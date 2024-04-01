Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8D54BF7
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.157.195.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007620; cv=none; b=HePRZgh1rpbdZTgn2wO5mhzwHmZxnRawS3IlyQzB4rfcRfxqxW7I7GAvLrQPCwjLfu621s0AGpC3RKQMpNIPEIjKYjmfVjUrvE1s+M/defU3Br+xs0WFP6stRPxLn3wHv3rOWAN+ys4fNybuQi4TTjwyQs+z91TgsbY/3dhvYX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007620; c=relaxed/simple;
	bh=uUyC0yKGGjROQzAb/Ay1DfndLHtXqwLC9bSLhu8/SlY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To; b=Ofd+7pi+/JC5aiBKh4g2CVpAiwk+uJIFTbqHm643VPJ8+LCLEoZjixCHYicEf/nJA2MHj0ShtWcgW2l3ty5WVHBlPH5BmJRczJ2KLmWoPH9Ogx2RwbiliT8NdnpqTO5U96ZrTFb71R2MCO4Ay+dDupDp33yI0bcCamp/hENpAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=leFnvTkr; arc=none smtp.client-ip=37.157.195.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="leFnvTkr"
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id B7F8B484A
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 23:31:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org B7F8B484A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; s=default;
	t=1712007063; bh=MEAcEcrPuOGZdL42nIic2csXVfsEJaia+M+O9hpqQDQ=;
	h=Date:Subject:From:To:From;
	b=leFnvTkr0e4DcBWLoH8bX9T3T5M+SSmHSlvaG6CYpbsC2ughPomg/aC9UlLNCCg6t
	 0ltSML3V3a2sh9zFg9iO1epuLtmGU1w6HgY393Kn2cEM3bwGWrU/QBXZH1HpIE75OZ
	 pDWGfyAe1/5w25SuTsIPLy/Bzu9NHpHkcu90FONU=
Content-Type: multipart/signed;
 boundary=09c7e158f1b7900a932f26f51a4858cb9aa626a7403b19350f2ca85afea0;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 01 Apr 2024 23:31:03 +0200
Message-Id: <D093URBT023E.1YE9AM8FF493U@cepl.eu>
Subject: [gitweb] Category per directory?
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.17.0

--09c7e158f1b7900a932f26f51a4858cb9aa626a7403b19350f2ca85afea0
Content-Type: multipart/mixed;
 boundary=4e8974fcafba66f10bab7fedca58908bcf557df29458233d562b1de7b4b0
Mime-Version: 1.0

--4e8974fcafba66f10bab7fedca58908bcf557df29458233d562b1de7b4b0
Content-Type: multipart/alternative;
 boundary=1829fa9cff045842ffada34af9e8ed1f23bc13e03c06e5051c407abc085b

--1829fa9cff045842ffada34af9e8ed1f23bc13e03c06e5051c407abc085b
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

With cgit I can set configuration variable section-from-path
and it makes all repos be grouped under their directories like
at https://git.cepl.eu/cgit/. Unfortunately, I cannot find the
equivalent for the plain gitweb, so https://git.cepl.eu/git/
looks convoluted.

Any idea, how to achieve the same effect with gitweb?

Thank you,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
For a successful technology, reality must take precedence over
public relations, for nature cannot be fooled.
    -- R. P. Feynman=E2=80=99s concluding sentence
       in his appendix to the Challenger Report


--1829fa9cff045842ffada34af9e8ed1f23bc13e03c06e5051c407abc085b--

--4e8974fcafba66f10bab7fedca58908bcf557df29458233d562b1de7b4b0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=E09FEF25D96484AC.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkQyZzVUMFJCQUNaZG5H
LzlUNEpTMm1seHNIZUZiZXgxS1d3ZUtQdVlUcG5idThGZTdyTllNV1ovQUtjCjlWbStSdW9WRXJt
NEhHc2IwcEw1WlBubmNBK204MFc4RXpRbTJyczhQRDJtSE5zVWhET0duayswZm0rMjVXU1UKNllM
emQ4bHR0eFBpYTc1QTVPcUJFQW1KbHlKVVNtb1dLakFLL3ExVGo1SFczKy83WHFXWVlDSnpBd0Nn
alIyRAppcnc4UVA4R0NvVVVYeGVOcElPVHF6TUQvajY2VlRsbityeFlUMTJVNGp4TGxzT3M1WTBM
VlFmVWJwREZFWXk5Cm1rV1g4aU5UVVpzeCttNnVoeWxhbW0zRWtOL2RXMGIyc1E0RDNvY1pla3Jp
TFBEUi9YMFAxWFBVZGN5MjhhNm8KV1pvVkFLTjI2WCtQd3hTcTNKQ2lRRUpnUEplS3hpTGlFeGgz
bERpdE55QVMwV1VEL3hRT3FyeUVGYjlrc0d4TApSOVVDQS85V1VRTXdnUXZFVWh1VkI3cVNuUkVv
MytrczM0S2x0cDcxdVVqdU1qTGszeWtTcHR5bjhvVitYWmd4CnJ4UEFEK1dPSm41MXlGeGJvK09Q
TmRINndHMlphWEZqNDdyWDZHUTlXNndJN0swUWhkeVFUcHM4S05sc0p1RFEKcHo3WE1FOThvYjhT
c3pzdmtQUG0vZ1gwb1dkT0lxSGlwSG5NbEw2ODRqUkhDV0hWanJRZFRXRjBaV29nUTJWdwpiQ0E4
YldGMFpXcEFZMlZ3Ykc5MmFTNWplajZJWUFRVEVRSUFJQUllQVFJWGdBSVpBUVVDUlNvV0FnWUxD
UWdICkF3SUVGUUlJQXdRV0FnTUJBQW9KRU9DZjd5WFpaSVNzcjVzQW9JQXFzTmNzMVNsOWpybXF2
N3ZKekw0UUc2OFYKQUo5KzMwTm1CQ2xRd3BtcW5BMjZuQ2E0K1dTNWFiUWJUV0YwWldvZ1EyVndi
Q0E4WTJWd2JDNXRRRzVsZFM1bApaSFUraUdBRUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dD
d2tJQndNQ0JCVUNDQU1FRmdJREFRQUtDUkRnCm4rOGwyV1NFckFVTEFKb0M4eXJwdE9nb29KT3pM
em1MeERjMW16ZUdEQUNkRkJ3Wmx2RmNqMVQyZG1DUk5kbjUKY0VyUnlCZTBHMDFoZE1TYmFpQkRa
WEJzSUR4dFkyVndiRUJqWlhCc0xtVjFQb2hpQkJNUkFnQWlCUUpRaXhwdwpBaHNEQmdzSkNBY0RB
Z1lWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFLQ1JEZ24rOGwyV1NFckJNWUFKOWVRRXBpCmJMNlZt
N3NVT2h1cHhEL1VzSGlXbFFDZEhZaStVTnB6QzFtS1l0RFNXYTFvY2ZPMVE3NjBIRTFoZEdWcUlF
TmwKY0d3Z1BHTmxjR3h0UUhObGVtNWhiUzVqZWo2SVlBUVRFUUlBSUFJYkF3SWVBUUlYZ0FVQ1JT
b1dDUVlMQ1FnSApBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklTc1AxNEFuaTZVODdoU1VY
RFUrM1pUYURSWEl3YXNUdHRsCkFKMFFXaGpTbWFKVGRra3BmcW1SQjliUmk5cEFRYlFmVFdGMHhK
dHFJRU5sY0d3Z1BHTmxjR3hBYzNWeVptSmwKYzNRdWJtVjBQb2hnQkJNUkFnQWdBaHNEQWg0QkFo
ZUFCUUpGS2hZSkJnc0pDQWNEQWdRVkFnZ0RCQllDQXdFQQpDZ2tRNEovdkpkbGtoS3dCQndDYkJP
b1RZNTJoWWVLbkt1VS91UmpPVHNVTWczSUFualRUclhZSEQ0OXh5THM4ClQvVnBzdWs2WlAvaHRD
Rk5ZWFJsYWlCRFpYQnNJRHh0WVhSbGFpNWpaWEJzUUdkdFlXbHNMbU52YlQ2SVlBUVQKRVFJQUlB
SWJBd0llQVFJWGdBVUNSU29XQ1FZTENRZ0hBd0lFRlFJSUF3UVdBZ01CQUFvSkVPQ2Y3eVhaWklT
cwpraTBBbjBHdzFNalpKQVR0VnExMVN1MG1qZDNyRFFDaEFKMGVlUEUwYW1Td1lWR1NwU05iMjY0
K1hqVW90clFzClRXRjBaV29nUTJWd2JDQW9VbVZrU0dGMElFTjZaV05vS1NBOGJXTmxjR3hBY21W
a2FHRjBMbU52YlQ2SVlBUVQKRVFJQUlBVUNSU3ljaXdJYkF3WUxDUWdIQXdJRUZRSUlBd1FXQWdN
QkFoNEJBaGVBQUFvSkVPQ2Y3eVhaWklTcwpieVFBbmlxdzFQWDI0QmxiQkQyMnpOcVl3emZJUERo
d0FKNG0vM3l0dUp6c2Z4ckVhYzF0U29FYjIrSDl2clE1ClRXRjBaV29nUTJWd2JDQThZMlZ3YkMx
YVR6UkdNRXR1YlVORVNHc3hkVTFLVTBKclVXMVJRSEIxWW14cFl5NW4KYldGdVpTNXZjbWMraUdB
RUV4RUNBQ0FDR3dNQ0hnRUNGNEFGQWtVcUZna0dDd2tJQndNQ0JCVUNDQU1FRmdJRApBUUFLQ1JE
Z24rOGwyV1NFckFuOUFKOWJPME5VcUxuTURUQ2NjaHRWeks2eUVPTGtDZ0NmWHdrdHkxdUVBelFJ
CjVrdDlHZWM4eVFweERsaTBHazFoZEdWcUlFTmxjR3dnUEcxalpYQnNRSE4xYzJVdVpHVStpR01F
RXhFQ0FDTUYKQWxyNjVDc0NHd01IQ3drSUJ3TUNBUVlWQ0FJSkNnc0VGZ0lEQVFJZUFRSVhnQUFL
Q1JEZ24rOGwyV1NFckhqTwpBSjQ3eUY5U1RYL0VzNHFzSlBqVzk2MUhlOUgzYmdDZEVzak9ndDdj
ekU4N0d5MEQxS1hXV05UZFR0VzBHMDFoCmRHVnFJRU5sY0d3Z1BHMWpaWEJzUUhOMWMyVXVZMjl0
UG9oakJCTVJBZ0FqQlFKYSt1US9BaHNEQndzSkNBY0QKQWdFR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VD
RjRBQUNna1E0Si92SmRsa2hLd3NRUUNkR21HWFc3M082UTNUQjBWMAp4UDl5THdNakR0RUFuaktX
RFc4UEtPOTBueDhJa1BvZHhyMW5DdkpidEJwTllYUmxhaUJEWlhCc0lEeHRZMlZ3CmJFQnpkWE5s
TG1ONlBvaGpCQk1SQWdBakJRSmErdVJQQWhzREJ3c0pDQWNEQWdFR0ZRZ0NDUW9MQkJZQ0F3RUMK
SGdFQ0Y0QUFDZ2tRNEovdkpkbGtoS3lLdFFDZEhEcG9sSGcvMXFEYXcvNENReVV6QWZOdkhrMEFu
aUVZTDZCRgpyZHlvbmhnUWYvWlh6WGpuS3pTZXVRRU5CRDJnNVVFUUJBQ2Z4b3oybm16R0p6NnVl
S0hrVGVYY1Fadks0V3pLClROL3VKSmhFbVN1UW1PS3ltYklrR0w2dkJRYitXNEt4dkxsMmxBYk5s
ZklnTEdETENzMVlBd2ZTcEo0dlM0bXQKbGlQZ0EyT3RaNWoxV1NPcXB4ZWRRUEdWYmE1Z1ZvN0hO
U09NVXRaS1R6N1ZzQ3ZSOTR2MDVjb21oTzFHb2s3NQpaeEh0WXlWSHVrNVY4d0FEQlFQL2Z0K1c0
RjB0Y2N3c2x6ejhPL2M5L01qOEtaRFltZk15TmI3aWVsVDJXZVEzCmlGRjlBeE1UNk92T3hBUWJE
SnZ1cmZLZVlseWRjWExzNmN5NGxLY2UxaEZhSjRpK01PRkxWVjFablpERENoUlAKcFE2S3JSQ0hM
YittTFkrU1lEMzdPN3Awc3BRQSs5Z3NFRS90bW4rNXNXN0xFOGhxU09vUFZkZjdZNXlVRGo2SQpS
Z1FZRVFJQUJnVUNQYURsUVFBS0NSRGduKzhsMldTRXJFVVNBSjQyVDFsLzJURnlrYlVMQnFxQXRu
YkM2a1IwCnd3Q2RFblJsQ0dsdm5PNzhSMEZnS1hsdDNSeXpHdUU9Cj1zeG9XCi0tLS0tRU5EIFBH
UCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
--4e8974fcafba66f10bab7fedca58908bcf557df29458233d562b1de7b4b0--

--09c7e158f1b7900a932f26f51a4858cb9aa626a7403b19350f2ca85afea0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGsEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZgsnlw4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErPAmAJYiIvXyUqZTqZJqKGLDshxQHggUAJ4gm+vmCDzU
Zyy53xLZK+tR9Bn3Lw==
=rQmX
-----END PGP SIGNATURE-----

--09c7e158f1b7900a932f26f51a4858cb9aa626a7403b19350f2ca85afea0--
