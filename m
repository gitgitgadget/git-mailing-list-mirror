From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sat, 1 Aug 2015 16:49:59 +0000
Message-ID: <20150801164959.GC488564@vauxhall.crustytoothpaste.net>
References: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Cc: git@vger.kernel.org
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 18:50:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLZzA-0005xo-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 18:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbbHAQuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 12:50:05 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:35422 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751337AbbHAQuE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2015 12:50:04 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:55b3:7931:f059:434f])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8A7A128295;
	Sat,  1 Aug 2015 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1438447802;
	bh=/ATdUH2pkmJXXDnwmG8NbUi49IplyiB8xgJuPsHaZ4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klAsoOZUfInO7fStKGyl3LBdCoEFIvpprclVFAt7DXO4iQMlokY7Imp0USk5aznVw
	 VDiAbTh7xqTOuJ9OfOjcweyDz2Vh2u7hqZ7/bCVjjUml99b2nPtchUqCKf4biACqaU
	 vYxXVGNmSOlsyM2ZOsloAX7tNzd6c0Bnh8fU/P1Q68GDbrA/js1UwiL5oA/Fvlg6pz
	 /7mf2bMzO3d6NXqVXWwfHle68uE9B/Ge3vfJgI+js0nkknUpScMoDOy9j/lES7X3pH
	 xl6LBrpyxo2mKc674qwAIKbQYq19i1i3xlxLPrd2JYt8UNGXqcOx6EQEeu2iah1AcO
	 N6JGJd0jkJtsbwVuqjmvG5LWw3RJtC9pMLirwDhx+Ku3fkRLFePeN+UFrfmETollm1
	 htHzzcq5s6hteY8CLkd45otZLiyS/QLNBnNUqiwkEcxlrFtbnRa+77J1ILrwN18U36
	 OHCEUbZfhbmkEV1iCnsJ16qUqA/Ynui5fY1XW3qDsMq+BxEabyx
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jan Viktorin <viktorin@rehivetech.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-2-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275123>


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 01, 2015 at 01:33:37AM +0200, Jan Viktorin wrote:
> +	# Do not allow arbitrary strings.
> +	my ($filtered_auth) =3D "";
> +	foreach ("PLAIN", "LOGIN", "CRAM-MD5", "DIGEST-MD5") {

On my system, GSSAPI is also available, and it does indeed work, as I'm
not prompted for a password.  (I have only PLAIN and GSSAPI available
server-side, and AUTH is required.)

It may be better to simply force the text to upper case, as that would
allow us not to have to change Git if Authen::SASL::Perl implements new
mechanisms.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.6 (GNU/Linux)

iQIcBAEBCgAGBQJVvPi2AAoJEL9TXYEfUvaLuHMP/3ML+MIVUesePiFIx8nTeYaL
lPiu2GS/fEis7NNwD0lhw1jLnMkM9afUVgVu+Sk5c/+/sANaW5wJADvedOs0gitO
WETxOIJRy30TZgTXPlc5XZpi1QVMaR/bt83Ht4P8frfqgze3BRYLqERzPmh73vC8
iCS3CNVrEhgbr+T9DWfOEkKzQFREsbDJHFNa77K0N4mpVd3oIQk4rhyRoSayreXz
IgUyOGno8WaS7QY+f6Ov2gGmrKW2cNJOrPradCjVLBJzRv9Djy7xtSF7s0wR9H6o
j+uvpLLtjyN7fWEh/D96e9SGZ7gljfM8kLR31LJzQph6/utz21y4g81043JVV50v
UVOOQqIpCqGrXo4XgdEqejJM+k6xeS9az6sFQ1A4isLuSoePNAaEMmLzQgfgNVYO
Za40fUT594KdE/yQ9iTqH7tEDf0iZl1OPpoFAP3WJg4P6KvOlEobEKsWBlhGf1WO
X3ytZqOh5B4W7yigiAEXDXCPkM8+k0uaBSlSeKc5h3wdzxao6ihI0MkNb2SXNMM0
YIfvaxMl9rIJjwb2EtASHqQuI9bKQtVXo4M70ZRIrj9QLnLRgeeQfxIiTptcCPSn
cdD6a5MPTH8DpXrYccP7liDC6EESlAEh8oB/zXUvULrbqWx9hoWWeKAYgU9ODmcN
oDXw034qBl9lWDmcfx73
=Zntw
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
