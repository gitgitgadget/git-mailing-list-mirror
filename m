From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb: charset problem
Date: Mon, 24 Oct 2005 14:34:57 +0200
Message-ID: <20051024123457.GA30550@vrfy.org>
References: <20051024071839.GB4608@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Gierke <ch@gierke.de>,
	Peter Portmann <peter.portmann@sygroup.ch>
X-From: git-owner@vger.kernel.org Mon Oct 24 14:36:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU1Xi-0005YI-66
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 14:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJXMfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 24 Oct 2005 08:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJXMfD
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 08:35:03 -0400
Received: from soundwarez.org ([217.160.171.123]:15571 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750757AbVJXMfC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 08:35:02 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 50BED66D76; Mon, 24 Oct 2005 14:34:57 +0200 (CEST)
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20051024071839.GB4608@schottelius.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10539>

On Mon, Oct 24, 2005 at 09:18:39AM +0200, Nico -telmich- Schottelius wr=
ote:
> gitweb (my $version =3D           "247";) seems to send utf-8 as meta=
 tag encoding
> (<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dut=
f-8"/>).

Yes, that's is intentional, also the http header is overwritten, if the
webserver's default is not utf8.

> The problem is that the name of the user "HansjOErg" (OE is the germa=
n umlaut)
> is in iso8859-1 in /etc/passwd.

Huh, not sure if it's a good idea to put that into a username,
never tried or ever seen that.

> This is guessed, but it does not look like utf-8, as it's a one byte =
encoding:
>=20
> 00007b0: 3031 323a 3130 303a 4861 6e73 6af6 7267  012:100:Hansj.rg

Sure, 0xf6 is the single letter '=C3=B6' (oe) in iso-8859.

> What would be the correct way to fix that? Change the username to utf=
-8?
> (Is this possible without causing problems in other programs?)
> Or tell gitweb that it should convert non-UTF-8 to UTF-8?

Don't know. At best get rid of the non-ascii chars in /etc/passwd
if you don't want to get in trouble... :)

All other programs sure, should definitely use utf8.

> But we also have another problem: Sometimes we have umlauts in the co=
mmit messages.
> Those are also displayed incorrectly. When I switch to iso-8859-1 enc=
oding in mozilla,
> the characters in the username and in the commit message are ok.

utf8 is the one and only sane encoding if you need more than ascii char=
s.
Just convert everything to utf8 from your locale to your webserver and
all that pain will go away immediately. :)

Best,
Kay
