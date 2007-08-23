From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Fixed non portable use of expr and removed incorrect use of test -eq for string comparison
Date: Thu, 23 Aug 2007 12:02:02 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070823100202.GE6573@informatik.uni-freiburg.de>
References: <20070822132359.GA13750@informatik.uni-freiburg.de> <11878139102715-git-send-email-david@olrik.dk> <7vejhvi67x.fsf@gitster.siamese.dyndns.org> <20070823090600.GB6573@informatik.uni-freiburg.de> <7vveb6txfc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9Vz-000839-Rm
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbXHWKCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 06:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbXHWKCI
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:02:08 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49629 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758611AbXHWKCG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 06:02:06 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IO9Vs-0007Tp-B1; Thu, 23 Aug 2007 12:02:04 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7NA222Z008503;
	Thu, 23 Aug 2007 12:02:02 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7NA22H7008502;
	Thu, 23 Aug 2007 12:02:02 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vveb6txfc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56487>

Hello Junio,

Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> writes:
>=20
> > Junio C Hamano wrote:
> >> By the way, I do not know if the use of "which" there is
> >> portable.  Have Solaris folks tried this program ever?
> > I don't count myself to "Solaris folks", even though I still use it=
 to
> > read and write my email.  But anyhow I know some of the pitfalls...
> >
> > 	login@~ > /bin/bash --version
> > 	GNU bash, version 3.00.16(1)-release (sparc-sun-solaris2.10)
> > 	Copyright (C) 2004 Free Software Foundation, Inc.
> >
> > 	login@~ > /bin/bash
> >
> > 	zeisberg@login ~$ which httpd && echo successful
> > 	no httpd in /home/zeisberg/bin /home/zeisberg/usr/bin /opt/bin
> > 	/usr/local/graphics/bin /usr/local/gnu/bin /usr/local/bin
> > 	/usr/local/X11R6/bin /usr/xpg4/bin /usr/bin /usr/ccs/bin /usr/sbin
> > 	/usr/ucb /usr/openwin/bin
> > 	successful
>=20
> Thanks.  Somebody else tried:
>=20
> 	found=3D`which "$command"`
>         if test -n "$found"
>         then
>         	... use $found as the full path to the command
> 	fi
>=20
> and got burned because "no httpd in ..." comes to the stdout!
That was someting I planed to mention in my email but obviously I
forgot.

> I did not exactly recall if there was an issue with the exit
> status, but your demonstration shows that the status is also
> useless.
>=20
> We _could_ do something ugly and pointless like:
>=20
> 	test -f `which "$command"`
>=20
> but I'd say I prefer the alternative I sent out at that point.
Ack.

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dgravity+on+earth%3D
