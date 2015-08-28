From: =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>
Subject: git-send-email and IPv6-only host
Date: Fri, 28 Aug 2015 00:11:19 -0400
Message-ID: <20150828041119.GP301234@dakara>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KJvkvZqQCzHgjKcr"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 06:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVB6a-0006Rt-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 06:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbbH1ER1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 00:17:27 -0400
Received: from vorash.stgraber.org ([192.99.34.219]:48574 "EHLO
	smtpout1.stgraber.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbH1ER0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 00:17:26 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2015 00:17:26 EDT
Received: from dakara (unknown [IPv6:2607:f2c0:f00f:2700:5dd4:f1ff:8f39:dbf2])
	by smtpout01.srv.dcmtl.stgraber.net (Postfix) with ESMTPSA id A563128E34E
	for <git@vger.kernel.org>; Fri, 28 Aug 2015 04:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stgraber.org;
	s=smtpout1; t=1440735081;
	bh=AYe3RpqkNYLVC62VhRI3Btfyi1LFQmlD6hGxoC0PJtc=;
	h=Date:From:To:Subject:From;
	b=PYjROFZY8cyfyvVoaxaSigpns/ujhXdErQrX+EXwyZtSkkVBD8FwtribTH6z8HUuN
	 aPOrhS/DDLcSzVyoSYwOa6jIJbYu3IXYpbqXsqC57Pgmsqf8yR8WMDFku3B63yx5e6
	 1YYohLOD+aICmAlcFp6yVyBKy1eSe9fcp5hig6Kw=
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276704>


--KJvkvZqQCzHgjKcr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I've recently switched my home network to be IPv6-only, using NAT64 and
DNS64 to reach IPv4 hosts. Pretty much everything I use day to day just
kept on working fine, but I keep finding some small problems here and
there, mostly to do with perl software.

One of those is git-send-email which isn't capable of talking to an IPv6
SMTP server.

I've locally patched my git-send-email to add:

    require Net::INET6Glue::INET_is_INET6;

This seems to be the magic bullet for all IPv6 problems I've had with
perl software, though I'm not sure whether this is an acceptable fix
upstream as this does bring an additional dependency to git-send-email.
Maybe making this require conditional somehow would work, not that I'd
know how as I've not touched perl in over a decade.

Anyway, I figured that short of having a branch I'm happy with for
git-send-email, I'd at least send you a bug report along with my current
fix/workaround.

Thanks!

St=E9phane

--KJvkvZqQCzHgjKcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV399nAAoJEMY4l01keS1niSIQALoBiLbOvejNNM7qCo5AaCd1
uHF8nrckxp190p0GUun+JvweYP+NokC+UfknXtbKMHiKuFVutP9Pk2c2MWBVU0+K
oZHrPR50mtULq7Risn0dMq1RjTEbQ2jokvMJpLSgNtJ6629KicQlP0uqYDsuWFr4
Tj8b7ajH/JFsU3ToFZd/Yz/oIxOqC6sO/yUYeka6laTmSDTrFBi5tYrvIg0KOpOh
PHo1dsImummICIihDxYbrtYIajHM4+9pN/TkzMJU5x2wtENQCjagdKuJZog9Mu6Z
L03B0qNuWdwdVx9d7PhHx6Fh1PfH4i9sbQ/4C9A+u+x+DMnYrTjCzbsz5z7uGA9h
/HSwDI3iKo48wpqZ4PnfzE/R7ovl2qrJa4adsQVctwI8F/17kF8mdNDLA8iAq5IB
ABC54bt2drb1UUFjoNRFNbtseED2PLqU4LP/sBnMrNQhjQsR5GUsAgfR++Xv1uC8
MtDPwptdfIfYFtwmvtT8qSLDnn6JQFvCeetxiOmWDWGeDPTfo9pFRkWr3kgnbiHi
u64uAYBbfKxfUPkcfKkkgeOJ4q7Fc9QFcsYn6px3hthaT2J0XDaqXef915/Kf8w1
4vYFixmbFVKKTVPN67ZM/L1VKChNm3pzZrYquPiBsDJ2Jx7E8nSgenrMYN9tzaJi
/+FMwxqXZ4w/j0NDmyjI
=5eGW
-----END PGP SIGNATURE-----

--KJvkvZqQCzHgjKcr--
