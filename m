From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Fixed non portable use of expr and removed incorrect use of test -eq for string comparison
Date: Thu, 23 Aug 2007 10:58:08 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070823085808.GA6573@informatik.uni-freiburg.de>
References: <20070822132359.GA13750@informatik.uni-freiburg.de> <11878139102715-git-send-email-david@olrik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Jack Olrik <david@olrik.dk>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8W7-0003bA-Pt
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbXHWI6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 04:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756115AbXHWI6M
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:58:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49098 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbXHWI6K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 04:58:10 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IO8W1-0006Qk-JO; Thu, 23 Aug 2007 10:58:09 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7N8w8sn007014;
	Thu, 23 Aug 2007 10:58:08 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7N8w8kO007013;
	Thu, 23 Aug 2007 10:58:08 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	David Jack Olrik <david@olrik.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11878139102715-git-send-email-david@olrik.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56477>

Hello,

David Jack Olrik wrote:
> On 22/08/2007, at 15.23, Uwe Kleine-K=F6nig wrote:
>=20
> > > You'd then need to check against 2 instead of 1, which I find les=
s
> > > obvious as we are testing for a '/' at the begining of the string=
=2E
> > If I understood the problem right you only need to test for the exi=
t
> > code, that is the program test is not required at all.
>=20
> Ah, yes that's true. The following should make it more clear that we =
are
> looking at the first character.
>=20
>     if expr "$httpd_only" : "\/" >/dev/null
yet another note:  I used expr "z$http_only" on purpose.  Look what
happens here:

	$ httpd_only=3Dsubstr
	$ expr "$httpd_only" : "\/"
	expr: syntax error

Once more, Solaris is more exacting:

	$ /usr/bin/expr "/" : "\/"
	expr: syntax error

(This works fine with GNU expr.)

So better use "z$variable" because (up to now) there is no operator tha=
t
starts with a 'z'.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

fib where fib =3D 0 : 1 : zipWith (+) fib (tail fib)
