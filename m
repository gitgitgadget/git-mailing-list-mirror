From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 18:52:00 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070301175200.GA21433@informatik.uni-freiburg.de>
References: <20070228151516.GC57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <200703011040.35971.andyparkins@gmail.com> <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <20070301120042.GD63606@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:52:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMpS7-00017Q-GS
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 18:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbXCARw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Mar 2007 12:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965464AbXCARw0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 12:52:26 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:38447 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965461AbXCARwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 12:52:25 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HMpRy-0000Gx-Pc; Thu, 01 Mar 2007 18:52:18 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l21Hq5xn021999;
	Thu, 1 Mar 2007 18:52:05 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l21Hq0Qb021998;
	Thu, 1 Mar 2007 18:52:00 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20070301120042.GD63606@codelabs.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41108>

Hello Eygene,

> By the way, I am missing one thing: the Id keyword in the file. The
> problem is that when some user is telling me: there is a bug in the
> function a() that is inside the file b.c, then I can ask him to
> give me the $Id$ tag of the file and I will have the full information
> about the file version. Can I have it with git if user has just the
> sources without any signs of the file versions? I've glanced over
> the git manual, but was unable to find anything usable.
Git and the linux kernel (can) have the commit hash in their version.

=46or git you can see it with

	$ git version
	git version 1.5.0.2.260.g2eb065

for the linux kernel you have to enable CONFIG_LOCALVERSION_AUTO, then
you get:

	$ uname -r
	2.6.20-g509cb37e

Knowing the commit you can determine the corresponding "version" of b.c=
=2E

There are some other possiblities to communicate that hash.  E.g.
a tar archive created with
=09
	$ git-archive --format=3Dtar ...

allows you do to

	$ git-get-tar-commit-id < $tarfile
	2eb06531e3d53c2604f20c32e5cb791d5044ff02

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

exit vi, lesson IV:
Z Z

NB: may write current file
