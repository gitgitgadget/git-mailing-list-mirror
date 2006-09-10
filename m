From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 17:00:53 -0400
Message-ID: <9e4733910609101400j2604ace1vdb2e363c1296418f@mail.gmail.com>
References: <20060910190332.17667.qmail@science.horizon.com>
	 <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org, paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Sep 10 23:01:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMWQF-000536-OK
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 23:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWIJVA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWIJVAz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 17:00:55 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:39916 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964938AbWIJVAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 17:00:54 -0400
Received: by py-out-1112.google.com with SMTP id n25so1867580pyg
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 14:00:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hz5yolmMNe6voRugmjbTH/iLSezO40TU7AA1UttAJnh6EJZ9Z4nv6meMh4Oa++Iwv/zkDxTX1rOCAkoSjfh2aH59nR/SHjF3x4EdFxo/9hSIb/SvG4IlIJVvte3AzrkgacVJxdXAm04skB5RpDIZ9ugQlkD+NPcFlG6TgB3Wzx0=
Received: by 10.35.61.17 with SMTP id o17mr7460747pyk;
        Sun, 10 Sep 2006 14:00:53 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 10 Sep 2006 14:00:53 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26816>

On 9/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Sun, 10 Sep 2006, linux@horizon.com wrote:
> >
> > A direct fork() (or even faster, vfork) and exec() is going to have a
> > lot less overhead, although it's more work to code.  See Stevens for
> > excellent examples.
>
> Well, that said, the Linux fork/exec/exit is certainly fairly efficient,
> but nothing can hide the fact that it _is_ a very expensive operation.

cvs2svn + fastimport can import the same Mozilla repo in about 2hrs
that was taking parsecvs about five days to do. The algorithms are not
that different, cvs2svn is probably slower than parsecvs for detecting
changesets. The difference is mostly due to the removal of forks.

Is the kernel mapped into user processes using huge pages? That would
reduce some of the pressure on TLBs. Another thing that should be
mapped with huge pages is the video RAM.

-- 
Jon Smirl
jonsmirl@gmail.com
