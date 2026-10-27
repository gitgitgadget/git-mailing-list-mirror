Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131264;
	b=TN7oXi+6jblV0Ic1hageII+IxhGT3DD46R6twLuAzGUo40Dn9Q8Sug+rWbihR53OUMKu
	 UImbK4oCGjKw/Ysxj/ap17fnx8xY5td26WO4ttKVocZmbagX1MWoWrvFc8ZcB+3F5Typb
	 yz+44WdcuCQ786sJUw2VTTyEHbGeykfQ1L/+3GdFjuICFLNfSCVVinuFkeVXdU/sf+L9b
	 JgAbHpVEi/t4XvjuWthHcFUT93rxojREmBrjAlsKYgNEkWsxubzm9s+8nWBatE9edjBr4
	 la40Kz8e6llaGxfqMdJu/CcEltEcZa81NyQeh0IUL3i9f/TKLLfFxmspYyPpH/12s6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131264;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zpmjkQyvhgaO4SDSba2XOx17yOfiiKOWzbYl+wlkA+8=;
	b=SWd1Ohupl5wfA9Vrsfo6hY6h7BXmP3M2C9BAX954L/4r1aP2wJ5hmxxyPvoW7BcANT83
	 /f41rg79nFOj2hxChHqZHDE1CHx6wFt5qasMlVhgOLdKaEKBgqn//gW/9+yeKxZkADazc
	 nUyKliaY+LWoS4AY7Sd0retWn7Yq5BIoyNR4reoFuSRvR1tvMmBlvWWtFMR/7qI+gyxSn
	 bFW2JI97Wipi25DQccJ6SxEotTd7yRodl2ljsI6D88Po2XvjlC7A3TINTyqIspqqJ70eg
	 Ox4aJCaLbpcW5zV/Q7l1/ZwptPQEYgeqAzs6kitKkD48JE3Ae2T8mx99KyHBMErnlAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=U3BD+MMd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cMJMZKcQ;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA7606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86AA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=U3BD+MMd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cMJMZKcQ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 800B97A01B2
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:01:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 16:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793131262; x=1793217662; bh=zpmjkQyvhg
	aO4SDSba2XOx17yOfiiKOWzbYl+wlkA+8=; b=U3BD+MMdukk8Fdrtl7EJ8GvbjI
	G/VoSBYrsQEu6gasyg1/vztP8N2OCd42FsTwquLa2EBUHJ7sPxGz38KMaAvZEcNO
	2g4IzvSRRfPrhpGrPu2G0PjRFR6Jt7HF/Z4q7LG2Hothxf/Rd1+8ZPGCv1gBgR5R
	lfV62es5qwOFfBtSeiK2XeXL48oume2vVp5eZU1SSop8hHjyjHpUTbrCTshVGZbp
	Xu6O7lqXvuOHAiGimuJLaPOVmaVQ9YPtWAuJPPk6woNxftXPRJiw8fXSeAEBlMul
	GaaqZLAFVvoSrH4y/jYpshM7/gVeFn2ZbFt+rJwk2QyTFLiJxw+6kmvbyQqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793131262; x=1793217662; bh=zpmjkQyvhgaO4SDSba2XOx17yOfiiKOWzbY
	l+wlkA+8=; b=cMJMZKcQYmrzn74upWiZrW1FblwDhA6n2XDrPKUKb5acJOzMsmo
	mrPHBQsbv/8Pd/ANK2xz/Kmskg5P/Nt80EP0E+dtaiAKySIuAozocR5tLbVcqNUy
	ZP8SVCDM++fxpwdxEBXPbT4RcNsN0PD/j3eBzPjcrLQti7gSdXa7TiFl0g5NwlTO
	TscPUGb4VkikIt0Soj3ee2m84STszV4YmmXTTL3P3EUgeYRZU8mgItI9+9GY2QMV
	U+D7nfCJzQfefxXzHDh48tWIWjQC5lZ4zRtAYa29gPWH/5S04xRT3wBg5v3UwDiG
	L7P1QekrUx9MJ8q+r4BPMgfwm/+OS9rAmpQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793131262; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bueDs5neFtGA1BsvWiwQVksdttswix3g8q+X0oefkCw2NA6
	YqFwdA664t06lozdilTgafseMgFuJ+cS0wnrErmDjmcKapiIpBn4+R4gatKu0soQ
	18Aif3dCKC4quS6G5/7PX8jVWEUWpKETWguugR9eSfrAwkM/1t5MkIvO4NeQwN+C
	71bksjr36GHPpe0L7m4iBRI1g5DawIIPeDB616XE8/aVYijTt+Qp4hskaK3Zc1FX
	7ZFn87TGZNdEJ/TdM9rdZP/YeBMgInFfTbz/P+utEgqgP52KPDfd1BU9VygFWziU
	ys5DdVnZQKT2ADalJWOTt1cTWCJOZ2/VR3ao06Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LhuhDLwHYskfJY0RZQCdlEJOOn7NRL4dBBQJ6Dj5d2c=:GNKPt8DdTUdIwz/W8UXxJzRBpEL2HWUtZQMmtL2WT7M=;
X-ME-Sender: <xms:_QLhapfA4_7IElaEkuaaOMC51YxtEsO0CwuwW_J2tR59TKxGeqsihw>
    <xme:_QLhauGQYb74nLuwrA5zGj1VKIboC_iAOkV5saCRiA2PYThaWrpRQ8DDHW2v5x6aj
    eVRsqrvGaOihhSYy_obi_LPNSPbQdXXHebQ_TtBqjD1_2KOVzEIcxs>
X-ME-Received: <xmr:_QLhaq1oMwjrgyzfZWnf15Y9AR9YwofvS2vo4XYdMmdKjg1cBHVYkZObikOh8W3NpENbmA7Hm_zV37Z6OO5V1XA0UAHcIpuJXkf1>
X-ME-Proxy-Cause: dmFkZTEfshG/YN5u4p3KBeT6UboihTQo3XVcqOxvlP/Fkx29XvRZ3DdqhxVIL6OjbCtNYU
    cTLvaFnK+ZUNcIEHKnuqycEdByqr4x5ZpvGhueQH4DOI7EMsjBnOjGMWIDeWlNlnBtGlPf
    w5PzB5wL+8ne7RJ4HmBj3HZAl4/rJw6Gs/gsb+C6+z19Z7bGtlWMgW/vB/22ZDbXXFUB2+
    YIA8s4USBVyKJUTmDwkzU16iQqaPRskDlRd7fcD/mPK3rFXrxpUs2vJtd/OIzRbcrEnFAa
    4bkyTsiiAYWtT+FdWYdQLQOMUgQv8o5CrvgJUrA9v+Y0vy41qdjqSpGl7x0YBDGwf5orTB
    R/FCb+myb3w0H1Hyur02pmWvzhO5lgr+A3OKAEX2/zpmgxM15Vgl5mwfGg/nwCy8h3lUQJ
    CcMil4kr+CDQf9Dk+2QS3BH/pACdD4sBj79JiVbPa7zJJZp7dJh/40blHr7bP4x8LSCWID
    mgFM3sKjLoKWS5BUw8+Sm7gyVy2y1tRC6cbo3920ZeFRCYiG99slwqe7xivx/GZkH4x9PZ
    MwhQSVxYXy1TkeX9x8lSumFQhiNf3F4es99tvzXUrryL4HTWG8YB4K2cAAn9MZUehwS0nz
    hxL2LcU9Qe0+LKP3c9tehlnWp1xKfRnDDse7Hd8u+kSAC4UIgaBcZg+IjbWw
X-ME-Proxy: <xmx:_QLhaukpDLm4B50m_EujQyjKSAci_qtsjGOjVQlolnPPmSnmw04xBA>
    <xmx:_QLhai_rtp1eirOXGFnpSPKOua5cD8VcOYiqW-ftcXTdt6CuZoqLWw>
    <xmx:_QLharq2fhNDm1P3hXsq09vhvjcq_drnZDlqmBX2E7Hlf7oWDSueNQ>
    <xmx:_QLhajkx0DoKqviIPLgdu1ZW_siroxFgJsTLZIb5e3nUCJ5ORxUD0g>
    <xmx:_gLhatDKLcRHe-NssSvaXRUs03JSNoxukdCpuYKvKtpdhlXFURaSezOc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 16:01:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Long 76 <long76.git@mail.ru>,  Matt Hunter
 <m@lfurio.us>
Subject: Re: [PATCH 1/3] test_ref_missing(): improve error message
In-Reply-To: <e246ee6f3b11c231580752b6c94a57f31f449955.1793098652.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 27 Oct 2026 10:57:55 +0000")
References: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
	<e246ee6f3b11c231580752b6c94a57f31f449955.1793098652.git.phillip.wood@dunelm.org.uk>
Date: Tue, 27 Oct 2026 13:00:59 -0700
Message-ID: <xmqqld7ij4lg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the ref being checked exists, then test_ref_missing() does not print
> the name of the ref in the error message. So, if there is more than
> one call to test_ref_missing() in a test, it is hard to understand
> which one failed by looking at the test output. Fix that by printing
> the name of the ref that erroneously exists.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/test-lib-functions.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Makes sense.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 09a41d51adc..b56b4f0a6c8 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -292,18 +292,20 @@ test_ref_exists () {
>  # a reference. This is preferable to `! test_ref_exists` as this function is
>  # able to distinguish actually-missing references from other, generic errors.
>  test_ref_missing () {
> +	local refname
> +	eval refname="\$$#"

OK, test_ref_exists is defined immediately before, so it probably is
safe to assume that the last parameter is the refname argument like
this patch does.  And it would make the failure output much easier
to understand.

> -		echo >&4 "test_ref_missing: reference exists"
> +		echo >&4 "test_ref_missing: '$refname' exists"

Thanks.
