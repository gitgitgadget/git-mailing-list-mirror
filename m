From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test-chmtime: a utility to change mtime on files
Date: Sun, 25 Feb 2007 02:27:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702250220130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11723651923476-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 02:27:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL8Az-0003Ll-Rr
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 02:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbXBYB1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 20:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbXBYB1d
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 20:27:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932943AbXBYB1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 20:27:32 -0500
Received: (qmail invoked by alias); 25 Feb 2007 01:27:31 -0000
X-Provags-ID: V01U2FsdGVkX19ne50C/vtnB7JqVv/iSPwseRJvHGGr7LDw9pFqII
	qlPA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <11723651923476-git-send-email-normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40530>

Hi,

On Sat, 24 Feb 2007, Eric Wong wrote:

> This is intended to be a portable replacement for our usage
> of date(1), touch(1), and Perl one-liners in tests.

This is a cute idea!

> diff --git a/Makefile b/Makefile
> index e51b448..105f3ec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -829,7 +829,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
>  
>  export NO_SVN_TESTS
>  
> -test: all
> +test: all test-chmtime$X

That is nice! This says that the program should be only compiled before 
running the tests. However, you can run the tests also by "cd t; make", 
and even by "cd t; sh tDDDD-*.sh", so I think a check in the tests should 
be added, which tests for executability of test-chmtime.

Ciao,
Dscho
