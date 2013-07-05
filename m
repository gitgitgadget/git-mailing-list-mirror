From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 20:29:48 +0000
Message-ID: <20130705202948.GW862789@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
 <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
 <7vobag7wl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72btQdUC6twB1rwh"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 22:30:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvCdp-0007Lm-E8
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 22:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab3GEUaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 16:30:00 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:60213
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757566Ab3GEU37 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 16:29:59 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id wgWQ1l00516LCl05AkVyF0; Fri, 05 Jul 2013 20:29:58 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id wkVv1l00l25wmie3SkVxoX; Fri, 05 Jul 2013 20:29:58 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A672128057;
	Fri,  5 Jul 2013 20:29:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vobag7wl0.fsf@alter.siamese.dyndns.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373056198;
	bh=47HOHTf4i7Ohf0FMonXv80lYhPwbWf2UfQco2upEc18=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=g72EBe79xL0AvF5u6deQNvY01gf0fisChq8H5nq2gi6wD9XTuXpUtU2S0EJ3Y66LV
	 wmHA0fgZQTNe+rwe5XOvF1fNklqV5NqdId4spZXqWoEywrWUwCQKTvDkByxkvArhCs
	 MAVzSLzUTdMx3vjnXa/PfmWcuwVM2DFiaCXKQ8DmKMvNQwYjwjhjuEGX57ATVi09MG
	 Wpp6b5B9RstJbdRLbe06jIByg3tNyRaGNPoZUZrJtmmIvpZG6g4IoEzzDEyXQ2/12S
	 2qQIO0y8b9iJjT+r0WqJAXnhblhA64CBj9n80O5qNOve/pSGApxliMfXP2+418qsL0
	 jWJoW9P4rrZYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229680>


--72btQdUC6twB1rwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2013 at 10:20:11AM -0700, Junio C Hamano wrote:
> +# Helper to come up with SSL/TLS certification validation params
> +# and warn when doing no verification
> +sub ssl_verify_params {
> +	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);

You might as well put this at the top of the file, because all use
statements happen at compile time anyway, regardless of their location.
If you want to lazy-load this, you need to do:

require IO::Socket::SSL;
IO::Socket::SSL->import(qw(SSL_VERIFY_PEER SSL_VERIFY_NONE));

which is equivalent to "use" except that it happens at runtime.

Otherwise, it looks fine.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--72btQdUC6twB1rwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR1yy8AAoJEL9TXYEfUvaLkZgQAKMJed0+4CuB04KfW18SkEpW
6GZl4sOdPKrLvi6vXAYH9PHBkJCLkyzdm9armMpArjbwTfzVFbg10ogDbwH/MRSt
EnW1VRMwgLft5ocCOg4nAYbd7XCt2Sm+kKyGSv/BHqRCZuKdPTfPDcthUW3t9+5u
xd/9C2pEoglc1dxBF1NkJRU4ZRyo5V5N7tqjHSbIdoSHcxeLDkqzC/03XLt2Jtb2
yqiUDdV91KAq6XylfLhmz/w+XKtaQZPto0f4HxaEAbsNJpFaGlhzYXhCTT1Pp/Xb
cMBvjvJAlBGrQy+8s7l1bwUFZ/cGRXZQirW4AJ1FEBg185EqBkK2vfd3nnfT/w1F
cpzuCUal8Y7oT44rRtcs/F2cGos0D5Ci2vJqZjBfHlH34fvhDxOBpyG0e9wB4CWL
i8WPVW3jStaMuPvVluGmpl9QICt4+kYnhPfLzYQ7tBUsVTC7pcqzbGXElMTDqutr
+dw0Hzh2jpBqod/1X3eacbY5k/TeLZj/kOSBRQNJpVj6J/449VXRtsmfqja1TUEX
AJgB6pX/fWCUOh3eRpCaHyEn9DmkCwLuEX7lyEXrwETGzdUjQx32XFJExznSSRBK
Toz1Wn36O7TtyRfpIkvXZ/syApYPw7uZCU4eUPUvnRLqTPev47etxx4uv8JEiN00
Ml0nEaLpud4bjgPIga0I
=0Qcw
-----END PGP SIGNATURE-----

--72btQdUC6twB1rwh--
