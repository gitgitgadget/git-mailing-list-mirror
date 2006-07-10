From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Mon, 10 Jul 2006 12:45:25 +0300
Message-ID: <20060710124525.54ecaeab.tihirvon@gmail.com>
References: <11524258261798-git-send-email-ryan@michonline.com>
	<46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com>
	<20060709221326.GU29115@pasky.or.cz>
	<20060710013405.54fbe6bb.tihirvon@gmail.com>
	<44B19D42.6030701@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@suse.cz, martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 11:45:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzsKf-0007A5-CP
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 11:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWGJJpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 05:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWGJJpP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 05:45:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55472 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751382AbWGJJpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 05:45:12 -0400
Received: by nf-out-0910.google.com with SMTP id k26so372699nfc
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 02:45:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=BMzZIu4jNoMRLLpnMd0zHNz4y/IPvltxydXXy9mAg4jHhspwMl4lYP0CPGAFimWJGHNqcKIRo7VM1OSJ0tRCaViOkCQ4aEXyE/x8Sov4xFij9xcYsu+KDNiGX3+XuSEsze6ZJlcrb+/0rnxAdz5REBICds56XgeunhMr7/DMvcs=
Received: by 10.48.43.18 with SMTP id q18mr3555578nfq;
        Mon, 10 Jul 2006 02:45:11 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id p45sm2682422nfa.2006.07.10.02.45.10;
        Mon, 10 Jul 2006 02:45:11 -0700 (PDT)
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <44B19D42.6030701@michonline.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23605>

Ryan Anderson <ryan@michonline.com> wrote:

> By "don't split the Makefile", do mean, "Don't use recursive make"?
> 
> I'm fine with that (and if you look at my patch, I "include
> scm/Makefile" to do just that), but if you mean "keep only a top-level
> Makefile", well, I think that continues the problem of "there is too
> much stuff going on here", but I can be persuaded otherwise.

Recursive make is a horrible hack.  Splitting Makefile to smaller chunks
which would be included in the top level Makefile is almost as bad.  You
can't cd to subdirectory and run make there and you have to prefix all
files with "subdir/".

If you really want to make Makefile shorter just move all the platform
specific stuff to a configure script.

-- 
http://onion.dynserv.net/~timo/
