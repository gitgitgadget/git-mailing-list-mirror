From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 20 Jun 2015 16:27:45 +0200
Message-ID: <20150620142705.GA23163@leeloo.kyriasis.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
 <1434147436-21272-1-git-send-email-johannes@kyriasis.com>
 <20150612223223.GA22677@leeloo.kyriasis.com>
 <xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 16:27:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6JkQ-0003pR-7w
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 16:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbbFTO1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 10:27:51 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:41047 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbFTO1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 10:27:48 -0400
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 8e3e3d07;
	Sat, 20 Jun 2015 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=Pkh2toLGq/8LvZNwmt7JRAw7xVw=; b=hN7yZq
	UWVCpIiIVydFJ93OLV13D7qLwOF/1Glnlf1YsRvyIXEVIvlznpTHUPq7dr+o25jo
	hWccLK1lWQfHzMCKAKHMwCEfLh0nGhYTCVGl9s9WxTzOxWCYTYKdbgYq/rdSnBFr
	pYnxAy6IPaoMD7U4g9edhm/zGNVeC+SeOel1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=i5DYfeXEwLHxSG6CTZJs6cy28OieaEyP
	QIzBUJt/OjFcy3V9eGlHy4vTPZt71nTN7/0ljzQ8nmB4c8PL+coGV+1L2/kcDvO8
	TcdN3p0jxopkOCPvRCCBtVN6h18PSy/1tTC3hSU3EPIXmnZKstaIQRyia/uwqKut
	2EvcKfpwY0k=
Received: from leeloo.kyriasis.com (h45n5-tb-a13.ias.bredband.telia.com [81.234.145.45]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 77ccd850;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sat, 20 Jun 2015 14:27:47 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272229>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15/06, Junio C Hamano wrote:
>You would probably want new tests, but more importantly did you make
>sure this passes existing tests?  It seems to break 5509 (there
>could be others) at least for me.
>

It breaks 5509 currently yeah, though I've already fixed it locally.

Anyway,

You create a namespace by pushing to it, and without a HEAD the=20
namespace is not a proper repo, and the code won't deal with them=20
properly.  (Which is why without that patch this patch is useless.)

So, if you don't want HEAD to be created when pushing to a ref=20
namespace, (which seems to be what you're leaning toward, considering=20
your last reply to the other thread,) then ref namespaces won't really=20
work in most cases, and it seems pointless to support them at all.

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJVhXhhAAoJEJAcHDIOsNRduCQgALs2YlbCLHtKEAtdofFDBSr4
WlYYZDhu3c7YZsRoWRMClJA35GMbduRF8M4qAa1h8Y1+K8aX/JxLd+z8lIudRh/L
ICq1b3+9hXdxmvpRxV/pd4CUuspyHnwlF5jHMzm1fSZdvP9EPJ+R7nWnPUw2gcv9
fd9Y6g1Bw4JrgfvZ2pXQT007kg0LCialyGU++PYc1Ttcosx+SXZRYX4jQ9ws85sf
xyfWUxVUzw1jpLipJ0sLkEGaFT7GW5hTHkjYzl5YIkU6v1p315by4bDyX/5MlLX1
eRKaqVN8aIFVkpYBpm+/BcYO9WztjfsL5wTbHVS/PfoY4PgXtdEQh0bKMwkUqkTy
ayQHVRXrnmw/tU/0jAHS00Jlk+Go+yOwOJ25ZJlsgbCYngR34HWQxxRe/9ksXCbH
UHW6DKd3Xw3srvBkAiNRkdbsxk375fjex9tm2OjnjP3/NCu6VJroICg4AYjtmxgH
PbpXogynWnx5Ow0J9QKZHepZm66GiAOM7BvjI3snlVUPsQSOVJD0hy53XNyKSizI
aShKP1yuqqgtdrCWtNq+GEooDumg3DCD91lhav0Ugq6M3wm3Y/59aSZII4awXCRc
Ye0werdf4DFn4cVeh0zQUBBQgQRq3qHaMdQbuNok2DBsOzT/LCJpJ37vbZ6yrb6e
V0gk48MGPrX7KLeYC6KZpNhOmvkOJbwcFiTwCgfrniYcpvKgoBwaD8R21G5/O8yV
PgklmRoJK/kpX+R0/8k1hn4wv2KITl7QsCBJOoNz+N62U3KNNpNSvOlf4skYzUAa
FWKhOpaT2N5V84aQxve1tGnEqZ5XkO0zv74UN/PW5VzPLrLLOaeaSGz//5rbv0Cu
CgSQ53vQWFonEcgKUviidQeWjl4eI1Kqe50GI2Oqzun+lRnvHZoUvkYv+oVzlMba
gxtl7D24A9Bxboe9Dy6fTcpNQfqSlqQluDStwgBrVCIqnCchT4KGeIpLd6GrRBy2
DQ//l9qjBOpu9TdzJCTXi5ejcCNmuukEv8H1SODPE5CXK5GdAWfRZTzi+yOhlxwC
yjr5vASj/iALJKqrYxPZ8Cpu13rFuIjttupxD0acpE4lN/KRhhsNWbivwOhekX17
4z3b2Ygxkki666tp2fPQ9VBCZ0sVa85ASIO8VYuYiCKTHmNwfUhOKT2VDUy5yacC
K2uYs2ogLG7cKCwdsyyDs7R8GMXpjWuBJGoKiSXzDJcW7baEtzEYxAle86k8VaD9
VHN0BwWz9eTlMbojjKkwwV/KKU3R0k8gn3UIYCAtTS+un0uJEFQhwZIEUVjaAgvv
jS+twt+Y2NxA5S6Cu6fliGAHBZOnvIvpisgLfYzUJUoas5PEDAlTAu27uSgGbw4=
=5Lq0
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
