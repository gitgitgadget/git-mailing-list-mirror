Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837355;
	b=UXXwmQ+K+8wBliESPmFvizqW1eUK62IGDk+u3R0ZWBp29LHSuUf1cJw7o9zH7sG44HkD
	 oVYL7o7sk3Dzb8gOwBFURLJpDn4kfGGJHDI3fCTE0B+DMpJdSrkVCHp3fhch5bU/bqawW
	 L1YcvBjkcaGxRvaAc8ecOR3mLzlTyMZxZg883sACzSSrP7hBxcuK6R5aV/YL/kf2XFvMI
	 eL4snBJgVyx/FAM8LZwvqCQGzg3RmAzF4eyU7clyn/Y0ChuxPdnJ9MrEMUkFvBKlfv0ts
	 tTOiXfGcpiLUErRXU7KL8jwYtQJt7vt2lHQq8FOaOreh2R8AELakyZI9WW2fXCzSKvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837355;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=qnGcSbEzPdGm/wqbBM6/QZyWI1GgqnaXJzk71Nt/45k=;
	b=DKRnA30WMjUoaBaZNTsr+AvOJS1+6xEwETKCKpDV26HYZZ7lZqonEatv+bRsp28jDS7k
	 WswN8bSJK5apH65nSOsYX2jQ5tazLNc5Emyip91oSkY55I3cU2qUg9JC2SjSGhfOr7aiv
	 9AS5jFFbEWreCGZPiP3TJlWzUVc2NYIhcI62t9GUmIexIVMjGFZ/lqThCdkIR7x6ARJwd
	 zAafZv3B63ykl8VUECm9g7naH8HIIR/rgTvAIFGdxDS0LZRVKjjol4CO55x9Fh2x0X+fc
	 RJji0oXVRZg3Rv7+qwajjps3HnKFs8ZX4nI0y/Th7hmYCop0NQhJR8u9wonohuWm9gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AUl0u58a;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="cDL/qbt2";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F4606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168F4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AUl0u58a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cDL/qbt2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 346841D00120
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:09:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 19:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793837352; x=1793923752; bh=qnGcSbEzPd
	Gm/wqbBM6/QZyWI1GgqnaXJzk71Nt/45k=; b=AUl0u58aP35eqmTnXd58slFo57
	KDePM0+lrGETO/3Hx9ERZ/hC17lXMFoZZaeo2qArk9XDZ+bmE4tzE5h6sEpp9edT
	WP0pJIPkeAPgrcbL7bsmfRp9+wtE15djH4A5U969ChhHLR+NRDYboOjQHvS4Lpbx
	AYJM9y8cXvW5QVGVUy6cdxKnt8L7cR4hHXNDySiaBMIkCR4h2ujcgXYlIVPJAxhg
	jT+m0s3W0mHtekj7gKTrm4NWd+L4v5yvr9l1Mt/H4RM3KGECHabVNTIUTUoA/pwE
	L/FnteKHSyxqg4s5eCrlMdzQtaHQnUUDmxvb9o3s8hC9LE6vI3CXJFqzUU3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793837352; x=1793923752; bh=qnGcSbEzPdGm/wqbBM6/QZyWI1GgqnaXJzk
	71Nt/45k=; b=cDL/qbt2vkbpRRK0x0LAYRoV5PvA4D7Yn/tq51HVFgJtMAi/P5v
	uYqJIVuVdtuIJzl/Q1QMXGwlUeBYLfpslRZEAdaWdoOWl6063cUnWSlXi2jDRp87
	aM6D4rDDifcMpxEcdj9WkLgHKhFsbwi3UJIHEeHartJ4+Honl2N1uGhJOLc1Z62+
	Rj3mvFaM8q4wj+6ucYmynqvTLlDTm8p21JkIu9VEo8JYOQZct7OBdZhfVrjMXowY
	uZVPj43STR5qDyMT5cFw3Y/ORhfjhgmEGP4TPrFSnqHgLw8CZzgFSfKr83wWq4b0
	Q9CeVTQ6rPXUh5OxiM9Z9poplJ6rL9I9WqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793837352; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OdL49j5xxqH0jC9rIQcmNUKFgCk4Tvyu71mTykaZ74/DlUu
	ZD+9DS6641KGh14wMKohuDUwu65zelX6Ky5cpQT2agpNywcxgANXaZAL9a3Fp73G
	ohOho2CihbrxpXbDbz4FLfhYzs9MuqDQlX17JXj+jA6UL+4crXolQ9a2XRLJUuL6
	1pp/0AMSGputIeiHo2m5nyZ8IvN/wuTL2SH7dKAoBTS9C0rMEvoM2l1LHUXReokQ
	QgadJtpTsEX88MWWhkvVIwsb/+6Ia1oVusBpPOyNKgzqYY6HML1PyK6Jz0kLpEx6
	umNAAQ8oOdzJAodBGbC9XF70WvFRi8FBx07SmZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Dp53/XeHQDoNR4U9vVe8cbbAyP1SxKDRzhSRrTpGkhM=:qnGcSbEzPdGm/wqbBM6/QZyWI1GgqnaXJzk71Nt/45k=;
X-ME-Sender: <xms:KMnraseHlnRdceuBoHorXKTZmoO4d2cPXnznEoE6efeOfzNkXTykWw>
    <xme:KMnralGAtbqrLhnkekeWHa0moRaEAXO8O66Rty99J0Xp3PpU5Ic5AvmxIMClgVrpg
    _kBk5z3s3wWmwWBbOSyAKZhgwyWOFtcgdu4TEAWevndhxFYGWGyFrg>
X-ME-Received: <xmr:KMnral37TrzGt8N-xD4enlZOxYyLdm1IF1oeID2O1VawDzm7kfIkXkFWsrpiU6YVB-Y1wEl7a9RwrKMep5qMOobOveKihSDILeN_>
X-ME-Proxy-Cause: dmFkZTGT76GloFIVHJunIcvo0X2kx/7z0+efqpoy64fdDX58pyasgCtIqYlEVYDDSjmYf9
    a2DU/hbw2s2bgLUp7Tye7gR1uHt+tdVvPkBIHYcsO/fACLWWx0lJINoTuEG9X3PLY9VUJ9
    A/vqJm/q3EZ00Z1f+8EsoMXrNPTVsDptF/mUNiUewHfAsLdLXOGnscbnZjcg9vPyKiRzP+
    OhfhjQ+J6E2IxtYO86vVD7bSuLJ17VcgleAugD4Y7MbUkJJcrQgTSB1R/aWpwpwdY+0TAN
    IVQ7U303jakSNHfyfQqyYodIQ4DU9WmIqL0KnQBtE0/R0Tf6kSblmw6u+jmhREUh9v+xKK
    F8SB31c+67vFeVsWxRUu+It2HgpZcI/irxmJNI9cn72gDVJCa/Iw1sWiZ9Qltc/PRrRMBf
    6Tv0Ij1COD2eZzkOqkzQYbO9TMfjsU9ozBVUDA7CzgBNI9IthpKMqyA20Vr1rQxACElT38
    Shhj0ZsnZN4dGbK0J6Qc9MP0d60g57r98NAMvrZUZQaFJW9+S2RCPH4xtPsFL0OWOOn8XS
    IF/gwqYoJtrRSIk0mBi5DPvSWNZ4nihqEs8Bb8s8RgICdTW5rfUGmAXkrv3L2BwcJODVBH
    58ruNRvWPWZfYObl6Th0POw5cYozBfAFgz1gnS4E70gV7/6sGu74mqRAzuBA
X-ME-Proxy: <xmx:KMnratm-0wgEZDiIdqHHe0BEOGz2Cdo_wtNRyZuyM7KD6Ts2fMNM-w>
    <xmx:KMnral_1wFLDtGp7Vmf4bn0ieeAEx8iaHJiYm82fxJCH2NqSzZFxiw>
    <xmx:KMnraiotLDJ_TVmn24PSY6wDNqYRfsiK3NOqWHf8AhLT6QJpiT4CQA>
    <xmx:KMnrauk-VHKFFbbUEXJul5Ocr1_wrRdI_DyufeSXgLnD7t9YL8PZFg>
    <xmx:KMnrasAYcMPNNTW7rBt3JOx6aS2I_RIoV4vyFNcrx7zgoX6HsN77aYcP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 19:09:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Patrick Ohly
 <patrick.ohly@intel.com>
Subject: Re: [PATCH 0/2] odb/source-loose: fix failing existence checks
 caused by stale cache
In-Reply-To: <CAL71e4ONN4OQUZ2S==0TRWqZgA8ogT0smRL3Rk46voTm+0Tihw@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 4 Nov 2026 13:57:52 +0100")
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
	<CAL71e4ONN4OQUZ2S==0TRWqZgA8ogT0smRL3Rk46voTm+0Tihw@mail.gmail.com>
Date: Wed, 04 Nov 2026 16:09:11 -0800
Message-ID: <xmqqqzh0xhp4.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> On Wed, 4 Nov 2026 at 13:17, Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> this small patch series fixes the bug reported in [1].
>>
>> In summary, when git-merge(1) writes merged blobs it may be unable to
>> read them back because the loose object cache does not get updated.
>> Consequently, we may think that the blobs do not exist locally, and thus
>> in a promisor remote we may perform a backfill fetch. But as the remote
>> doesn't know those objects we'll fail.
>>
>> Thanks!
>>
>> Patrick
>
> The fix looks good to me, and I verified that the test fails
> without it. My own local fix is logically equivalent,
> which is a good sign, though perhaps that biased my review.

Thanks, both.


