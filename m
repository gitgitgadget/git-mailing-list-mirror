From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 12:32:05 -0400
Message-ID: <9e4733910606120932k5b6f7acfra3f3a26168454f47@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
	 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
	 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
	 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FppKm-0008Au-6o
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWFLQcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWFLQcI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:32:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:32608 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751284AbWFLQcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 12:32:06 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1672763nze
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 09:32:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rbocXR6OyEcwB1/ycxfs97V6enzoEPwJYu5W+XuuQk+En72E7H8KFRUlhDZTOEBIHTyStEIpK2OLkD5jaHh5MplTuXo+AbPGQ8wVtD3+Pf3DCSViQSQFAskhl/e+4WYza2FO6HKNtoEs8jYD5GfwRwMXLM+gdmddC+KBIyl24Vc=
Received: by 10.36.120.14 with SMTP id s14mr9048977nzc;
        Mon, 12 Jun 2006 09:32:06 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 09:32:05 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21714>

On 6/12/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >
> > On Mon, 12 Jun 2006, Jon Smirl wrote:
> > >
> > >  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> > > 14525 jonsmirl  16   0  604m 391m 1904 S   24 38.7 916:53.39 git-svnimport
> > > 20947 jonsmirl  17   0     0    0    0 R    1  0.0   0:00.03 git-svnimport
> >
> > Hard to tell, it's obviously got short-lived processes there too that it's
> > not showing, but equally obviously that svnimport script itself is
> > spending an alarming amount of CPU time. I don't think it should do that
> > much processing, but since it's written in perl, I can't read it.
> >
> > Are there any other directories that seem to be growing (eg some temp-file
> > directory where the old files aren't cleaned away?). I can't imagine what
> > else it could be doing in kernel space than simply some silly filesystem
> > operation, but dang it all, Linux filesystems are usually very efficient
> > indeed, unless we're talking huge directories (and if it's not the git
> > object directory any more, it must be something else).
>
> 64 files in tmp.
> But the SVN repository itself has 411,000 files in it. Split between
> two directories.

I'm doing all of this on ext3. I have plenty of free disk space so I
can make another partition and switch to a new file system after I
install the new RAM. What would be the best one to try? Doing that
would provide a data point to determine if this is a problem with file
system performance or the misuse of file systems.

-- 
Jon Smirl
jonsmirl@gmail.com
