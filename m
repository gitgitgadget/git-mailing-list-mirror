From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix git-p4 on Windows to not use the Posix sysconf
Date: Fri, 13 Jul 2007 15:03:51 +0200
Message-ID: <81b0412b0707130603q69857564i1ba418b74397a33d@mail.gmail.com>
References: <46977660.7070207@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Simon Hausmann" <simon@lst.de>
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 15:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Koi-0005xa-Bk
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 15:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758209AbXGMNDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 09:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759507AbXGMNDy
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 09:03:54 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:49511 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209AbXGMNDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 09:03:53 -0400
Received: by wr-out-0506.google.com with SMTP id i30so326291wra
        for <git@vger.kernel.org>; Fri, 13 Jul 2007 06:03:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C9ef9ljFB+28mNaLnkeF5vvVZKginr3hMbD8+TbhXsiMATBAkOlqL5xCdTy1K2fziiBDNfttSEnrGFcifQfktVu5XYRQ+RIC1aNS3BN0ic9ORpJDeCoDl6Q4NTS863u8buS9eiUYxJcDR/XqgDXVTBjOqWXSqVbw/9W5T22Le+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TwwdULbPFcPDzqrvK5AFnmQCgin9dvpY+B0D1juQ+GI2ty6R0ji9SWN+nlSbfCVXRXCx24XTvSnLv/o+0ocV8MKcUP6Y4c0v1cnAv2xzbLepJMW1XNa9sgLvPKLu7CiVi4bLELViQyMI5YSnxoAgjvlaB05p1XV4QNo+uAYXfJg=
Received: by 10.78.142.14 with SMTP id p14mr475120hud.1184331831288;
        Fri, 13 Jul 2007 06:03:51 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Fri, 13 Jul 2007 06:03:51 -0700 (PDT)
In-Reply-To: <46977660.7070207@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52391>

On 7/13/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
>      argmax = min(4000, os.sysconf('SC_ARG_MAX'))

I wonder why the code in question does not use "-x"?
I use it git-p4-import and haven't seen the limit yet.
I.e.:

   $ ls |p4 -x - print -q
   $ p4 help usage
   ...
   The -x flag instructs p4 to read arguments, one per line, from the
   named file.  If the file is named '-', then standard input is read.
   ...
