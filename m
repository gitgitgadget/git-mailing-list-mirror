Received: from st43p00im-zteg10063501.me.com (st43p00im-zteg10063501.me.com [17.58.63.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F581CA9F
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780975; cv=none; b=itXxE4ZMLLiuSvuSc9FdD+s5VslAKBUaS8aAJUrQD/0iQxBcueM1e8SQwBrhfioJIWdBB+0skj5i1jar4kmYLzIxNQ13U01yhtfhjU0aS12lU8ywVcH/Q8cAbM4iG2KBAHEJrbO37c9spwqhkzPQ61bHSvMQ8zZgbxk6vuBpMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780975; c=relaxed/simple;
	bh=jBbKKiV9RpAOc3AGcTb4nP9MmNNrU1IImWBe/rnunnE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aV4XgqxSJE3apZdfBQ+WpCHqUR9hfvJ5inAmqgga/vPpFGCVoniFTKUz/STYKz5rg8aepWMci0zk18u+0+3jc0PPTHJO/OagV0EFwz+sALG5unV//+ljl5G2Z74ilVrZ3zHPtbqdMBadc1yFrVbA9LZROc7ZBmm93/bSklvH9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=ByuL2yTp; arc=none smtp.client-ip=17.58.63.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="ByuL2yTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
	t=1722780973; bh=HBCRJPxjyBrZr5yI2IMI86r7qOjeFoo9jTpXGnCz8NY=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	b=ByuL2yTp8nu/ifNC0oyZhgNSiyk1nd5yw4UztJMatyGcj7itjTgrz87d/ZoAkkYO7
	 ktCZuksIwJtlM47UYrlVUuelvUbWFwt09m9QkGmdRKmOYDZYN4TeNMK/7cGWB6qeUh
	 JFNFlDNKiexasbvmPcH0aCsLXztc6ShCzs2u5kpHuN64zV06xvLUQGH0vCwXnjIZNE
	 si597Bkn9kR73b9PNCJdTC30FPx6F1G6gkTbfiiBvEAv1HVMAJzKi1mrVbFeoJOW21
	 L7IdKqYd+22MzgNn5S85nWtI8qlI8pOnvcaAC+Ec7eCFvvfoPoVLwX5x0r35s+R32H
	 xiKmK71mMc0Vg==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 986F7980169;
	Sun,  4 Aug 2024 14:16:10 +0000 (UTC)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_FCF134BB-94E9-4318-A5BA-1B11BFE3BBFD";
	protocol="application/pgp-signature";
	micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Date and time processing issue
From: the.tester@mac.com
In-Reply-To: <xmqqplqqew38.fsf@gitster.g>
Date: Sun, 4 Aug 2024 16:15:57 +0200
Cc: git@vger.kernel.org
Message-Id: <E76CDCA3-A788-4B96-8C84-4175C4CE5F0E@mac.com>
References: <B896574C-A150-45AE-A636-ADA9ADF3255A@mac.com>
 <xmqqplqqew38.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-Proofpoint-GUID: rtRlZ3n9lznlQp_Me3syNTncXBxy43VY
X-Proofpoint-ORIG-GUID: rtRlZ3n9lznlQp_Me3syNTncXBxy43VY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2408040104


--Apple-Mail=_FCF134BB-94E9-4318-A5BA-1B11BFE3BBFD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 2. Aug 2024, at 18:19, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> the.tester@mac.com writes:
>=20
>> To me, the error message is at least misleading.
>=20
> Correct.  The error message is prepared for the most common case
> where people ask for an invalid format, but does not pay attention
> to the fact that some timestamps are not out of range in the Git
> timescale and such an out of range timestamp can be fed to the
> program.
>=20
> Something along the following line may be a good first step to fix
> it.
>=20
> builtin/commit.c | 2 +-
> ident.c          | 3 ++-
> 2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git c/builtin/commit.c w/builtin/commit.c
> index 66427ba82d..24de55ae86 100644
> --- c/builtin/commit.c
> +++ w/builtin/commit.c
> =E2=80=A6=E2=80=A6=E2=80=A6
> or date out of range: %s"),
> +    date_str);
> }
> else
> strbuf_addstr(ident, ident_default_date());
>=20


Yes, that would improve the error message.
Would it make sense to create a pull request for this? =E2=80=93 If so, =
should I do it? Or you?, Neither or us?

(That said, I wished I were familiar enough with C, to allow Git =
processing of a wider range of dates, but I=E2=80=99m not.)



--Apple-Mail=_FCF134BB-94E9-4318-A5BA-1B11BFE3BBFD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEImVTW2kalIKnTbGpN5OCOCEvsmQFAmavjR0ACgkQN5OCOCEv
smTeqA/9Ex2cH9NexepWsgi90j3w4qOEgbwj3U72QIFTt13F+K4R7SK1b+E1Nu2L
Vcqpg/jBLW687DKTheKBK0mqOQkCoph+/UsJ5dTqp6R/j03maZTzGjI8uGywbCsw
jBERcGk8R19LGlNwe6+PAeTls5n1TvQ8j03WLB4J12Sgb3IFRxkEJzB1X/VAF7N2
gMGmqph8hXvizzyziZb2XNuFezn5z5bF+CR9j/2a1tiMaY9Ojnqoy7exrM9q+M2z
ztK5vBH7VYx79sYQk+j2I5wNzWViD4c56/wju4LV2VFWRoqb+NiOcPuQJd0ALuvg
Hn+M47mxa+11aDzzVmLPTYAMUGuFv49lwH7aCUc8kwCL6LKpcS0323GH/hqnFLVq
OlnbI9qVJt9aOw7WmwxTT11qlKidBZT6PUHXGRsB/QjNbAcfRCW9VN+Op6fPFvX0
5BuyYYScdRrlGl1SWhQUXV86MJZSxp+wyNFsYghcgNC/e+N0jY7HMDjaLPTLsjCI
hjExLwKPiHhAqBKdR70orFhxdRHU/t0TbgoS67U3k6Je8c7hgjjMEk1o7LCWDvf0
1XudXythChnUX32hO6SbS7EhYeFTWArhIY3kKxC+jddYkVat/4Uc41/bD1k0whRf
NOwXdIWv4H6RqzPxv3qnUx6sM1aYTrfMzEpmPDpzT+C3TBlOA2E=
=3Hr/
-----END PGP SIGNATURE-----

--Apple-Mail=_FCF134BB-94E9-4318-A5BA-1B11BFE3BBFD--
