From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Fixed non portable use of expr and removed incorrect use of test -eq for string comparison
Date: Thu, 23 Aug 2007 11:06:00 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070823090600.GB6573@informatik.uni-freiburg.de>
References: <20070822132359.GA13750@informatik.uni-freiburg.de> <11878139102715-git-send-email-david@olrik.dk> <7vejhvi67x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8dr-0006QV-Et
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbXHWJGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 05:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbXHWJGM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:06:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49153 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340AbXHWJGL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 05:06:11 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IO8dm-0006V1-Iv; Thu, 23 Aug 2007 11:06:10 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7N965KY007320;
	Thu, 23 Aug 2007 11:06:05 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7N9603q007319;
	Thu, 23 Aug 2007 11:06:00 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejhvi67x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56478>

Hello Junio,

Junio C Hamano wrote:
> By the way, I do not know if the use of "which" there is
> portable.  Have Solaris folks tried this program ever?
I don't count myself to "Solaris folks", even though I still use it to
read and write my email.  But anyhow I know some of the pitfalls...

	login@~ > /bin/bash --version
	GNU bash, version 3.00.16(1)-release (sparc-sun-solaris2.10)
	Copyright (C) 2004 Free Software Foundation, Inc.

	login@~ > /bin/bash

	zeisberg@login ~$ which httpd && echo successful
	no httpd in /home/zeisberg/bin /home/zeisberg/usr/bin /opt/bin
	/usr/local/graphics/bin /usr/local/gnu/bin /usr/local/bin
	/usr/local/X11R6/bin /usr/xpg4/bin /usr/bin /usr/ccs/bin /usr/sbin
	/usr/ucb /usr/openwin/bin
	successful

That is, with httpd_only=3Dhttpd I get:

	$ if expr "z$httpd_only" : "z/" >/dev/null || \
		which $httpd_only >/dev/null
	then
		$httpd_only arg1 arg2
	fi
	bash: httpd: command not found

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

If a lawyer and an IRS agent were both drowning, and you could only sav=
e
one of them, would you go to lunch or read the paper?
