From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 14:15:40 +0100
Message-ID: <43EDE37C.9050005@gorzow.mm.pl>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net> <5C03F8F8-656F-48B0-825C-DE55C837F996@codefountain.com> <43EDA3D0.7090204@gorzow.mm.pl> <20060211130530.GR31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA811B6D3E50C2AEFCB87FF53"
Cc: Craig Schlenter <craig@codefountain.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 14:16:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7ubU-0006ga-57
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 14:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWBKNPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 08:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWBKNPs
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 08:15:48 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:53147 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1751412AbWBKNPr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 08:15:47 -0500
Received: (qmail 11039 invoked from network); 11 Feb 2006 13:15:44 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <craig@codefountain.com>; 11 Feb 2006 13:15:44 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 476CC178FD5;
	Sat, 11 Feb 2006 14:15:44 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060211130530.GR31278@pasky.or.cz>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15943>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA811B6D3E50C2AEFCB87FF53
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Petr Baudis wrote:
> But the native git protocol works completely differently - you tell the=

> server "give me all objects you have between object X and head", the
> object will generate a completely custom pack just for you and send it
> over the network. The next time you fetch, you just ask for a pack
> between object X and head again, but the head can be already totally
> different. What we would have to do is to check for interrupted
> packfiles before fetching, attempt to fix them (cutting out the
> incomplete objects and broken delta chains, if applicable), and then
> tell the remote side to skip those objects; but that may not be easy
> because there can be a lot of "loose fibres". Another way would be to
> just tell the server "if head is still Y, start sending the pack only
> after N bytes". *shudder*
>=20

The other way would be:
 - generate pack file between X and Y
 - start sending from N bytes

It could break if the repo has been rebased in the meantime.
But we could safeguard against it by sending the hash of the packfile
up to N bytes.

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enigA811B6D3E50C2AEFCB87FF53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD7eOAlUMEU9HxC6IRAk6BAJ9DuN7EyZVmeb2PZrveGIaKZRy/vwCfVyeT
j5A55LEWMN0x95UflQDDp6g=
=9nDJ
-----END PGP SIGNATURE-----

--------------enigA811B6D3E50C2AEFCB87FF53--
