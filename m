Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957229;
	b=sm/Z3lMaxpLI49Lv5XjUB4rb5JxNHMI0eeVKlbsr/ZCawht3YVd1dCI4NmIYFvoPOtBF
	 T3y8RzsuPytOWwt1Y1OjP4jZt69Bgngp1mzgJ/Ce1PRoKngBW4SAaTGjA8E9xjI5AT7l+
	 bzHmuztqhUiKkpgFeVLESIwxjlrc/OBJMGhTZJyBXBnU5ToYsCKlXzkJRK44WOGErpnB2
	 jtJRXL6gVWaVEYjZT+8VLVVCCnqlzsQ3AGtbpKs7eMjOLTWYb8AXjPVQ7XNjDivC2ShPe
	 KUVXhSWn9jFHMW6iTQ0cI4h1ovDFuH/fz3bBmYGrDnb2HKzUH77G0g0HdN5/1yqfpiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957229;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2evbet59QQq+n7XeBAmYOX/G28mKL5oOoSx4y1dDRmI=;
	b=mA+IGtg0k2Ql2yglc8n7ix73uRxyAzXRSVCkARW6WQCKe9B0BUACBk+U6lYho+Zbe+kM
	 jtkiPcpPeBmtALmy9GPnjtaU1RLBYNzJ8TX8De+gHMx6P1vDb4Dwj1HosD0xSeTbcRetu
	 gNlI6Eng2x9lWw4T4GJVK5TKk0QNg5DP/w3H9tkzjX6r/rsV8KOWBzcIf46OB6TwNO8fb
	 34tE21fzO8Y5Cl3Mf9Phs7iDMFSDFpPCE9/v6WiW/6ydjpKiYRYAoeiFv5OovNgzV1oGO
	 aWqlaaROjD3Fli7XsAis6vdhRrQvSKM3rnNHHsvgZzeclm/5JHdWa3AFR3c8DWPx5Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FbGYr9aq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fqoucDY+;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E8606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FbGYr9aq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fqoucDY+
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E4E97A0257
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:13:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 18:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794957227; x=1795043627; bh=2evbet59QQ
	q+n7XeBAmYOX/G28mKL5oOoSx4y1dDRmI=; b=FbGYr9aq6M7Xb98e8tV/qrpaP6
	gtihpmfvN3kdUNy9BdQuDr4yz6gQoQfNEVkqP322uq2eEZKJDOx2tdYy9xb0otpJ
	isNT6/Nt6DnXZeziJC7sFD1bW84MJeeldu8imsVDOiRFVPmBqz1JWRLRy/rqexYI
	mnHJIPI0VvV8KnS8I7a8yEF/3kqliBykBMA6ZoMtGXYZRByZ96l2le7cJ6f5Zqo9
	KCUNTADdZlXSuzLQ6CZKA4eJmlU6K2fkXGCfEUyIRsS1+Ooyd5LP8PLq3Ca9Oy+l
	o32uxFXdbqNy+7mdPSGmXgiBX91Bq6FcN8hZDXMjud2trr7ruCiF2dl0YR4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794957227; x=1795043627; bh=2evbet59QQq+n7XeBAmYOX/G28mKL5oOoSx
	4y1dDRmI=; b=fqoucDY+4nCVLj+pUFaVZ8VNbwuNSHjmQ3i2Pv06Rjan8WfGkCL
	i8VTiG+qv5hlmenHnQDJNCtWefxlsQTp7/+KSmGBEhyip6Dp65+Ep7eEM4HQUzPP
	tOINwcQqlk9RGCO6BKUiSq4bAXNTymE/gTIsNPaCRY0e5mr+VYq5Ir1zMp9bynW5
	z9OQdEzvguTu8DsDsypFlvjmQeybK9gWZ+W3ClshQh082aAzRkBScS0kSecJ7NDI
	T0/97xb/3Q0w5Rn2pt1m/PyVUgfRhEPQtYZWhpBhqnW3tBU0Nc1T9fNRnqO2VifM
	LomEASatQFuZKc2aBHZIAn5DJWSSFAko/3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794957227; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b0yH8IgbB7ErNVSRCBART2CPUqpSadmOWaIVzSJCfkCQILe
	7LVmhEeRhGzQw+uL2zx/AYYchKusVCTH1XMdMYgZlJp/N3BrRFJdvN11PZbFp2cc
	O1YkzkHnVWN1YKnlsTtU/syZgFoTb+H6VpkVag+5vW9IigjTj6qQ/dbQNk6gIot0
	tx+9mm/2xT5Yd1UXwRQR8OLp/PzlqlybVcfZXNJxufGnwoNz9afe1LkT71Io1DKn
	JUqeYejZ/wZsf/udDWZrjVrZQakCuG8g4bl2aen5swQtEMz5qmSIINdFQF+KXEj+
	cT+vY9azNnljTwb+xR4PaLOWXeujKCiVU65ZN2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mk4XNFWKhDr5rzdZ41FMUjZaPmawwpfD13tYD2yHZOw=:bSuGzNfrBGtRoSUiqCGHSaxroDUfDyRt7GVP492YPLk=;
X-ME-Sender: <xms:q9_8ah696FpdJWvWVnpSIn81B-I6bw-sHkfpqvqblHngtXrwi-ugGw>
    <xme:q9_8ahJ-dyl80Me7jMNms-QfCtahARwP2YLhiSY4Bqtc_VIXunDMrbFJxWPb-xr3-
    LqMVskFxCs8dscBxjUwOtB11SMRHIBsFT_tTCM7eyIMybo0OIAV>
X-ME-Received: <xmr:q9_8aqu1AMO8XAKl0SCKrSmRSEKtn2pdTzSsF_ZmtZA2WkJYLaEhXln8Bh492l2R0KsUQ5-Udufa5DmZenmOEBfpQBHj6WUC5dDu>
X-ME-Proxy-Cause: dmFkZTGIMZAu0c/BFNjI+Res8Sp5U/lorDUapQQYWj7rsIVaY+A0KSpDzr2mgY8bF0Babp
    w9mQN5yeP9NFh/PTxbzymhe36OS8TxvGt/fLR2Ad07NmHaRLomvNAE16hQAUwzF8pYT86B
    yoeV+OtuFYIl4U9S+wPYsU9BFM68mqGa0QNo3NFq2DA9zRAilRrtD3VPKnHVfGtjy8QFwM
    9LLWenH1KsMZyIM3jEsb7aQcFuKT+AOcKzDVP+f2IcbMzpbHrTqPD78TjQkJL4qRc1FmKt
    LHPltJuNPmi545sb1a120CxHE3c3tj7BXguyaM2+oKrSzD3887W37MVNN38MAj3k4amahf
    LTrw7j8yMiScDU0jPXq9F8Yi+kxRafgXJKe/v3KXVN/qC69O9f3DBKCiTWS3tskUK32kcA
    L+WcNl6ICYUsIMUp5/k12t7aAtcdISxVDSFS+GmgjY09YcuwMi7gRC+Cgrr30B75CKvjg4
    TzG9+aQNvLGgTByq70ToZ/+BS2QKk0jjy84DzEcK69bweUmzYRFITk4CljpJe8U3av779s
    pnCwGzglu8Tow9dlJPbfLIH0NZbMYgZVXKF2c+8WZTQYmve+ZnXz2/8swEpXF6c7g50BuQ
    vt54zkiQm2hnb5+2XwygSCaJSpLBD8N5cHFlBiWn0gw6o9HpjmUIMH242Wpg
X-ME-Proxy: <xmx:q9_8agJq2Pxd6TxjothpnWp60tNbhmdHhIfTLv92GbwVqfXlzdriQQ>
    <xmx:q9_8aj_D79RA_Kb50VzAQFHNFXT5VPDXcjCaVWNn6y9ObZUendzwUw>
    <xmx:q9_8apwb4gWWKnWnJXxqFND7QeV-85iXwkLr7rcob5zDVtCbaTaffA>
    <xmx:q9_8ag5FvtUtGOYFZu_UcNRiMT_xPNWZtyW8Nd30g_eSwgJWY3LXFQ>
    <xmx:q9_8avrZCQ2pi8w8y6t6ZGgDEz-MFFquwOnXuaF9mTe31FaCf2hLdYkk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 18:13:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Alexander Meshcheryakov <alexander.s.m@gmail.com>,  Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen?=
 <tboegi@web.de>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/4] diff: use uintmax_t for diffstat totals and
 graph scaling
In-Reply-To: <692c503e97d9841def6e0429ef52a963ab93eec0.1794909894.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 11:37:56 +0100")
References: <cover.1793546752.git.gitter.spiros@gmail.com>
	<cover.1794909894.git.gitter.spiros@gmail.com>
	<692c503e97d9841def6e0429ef52a963ab93eec0.1794909894.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 15:13:46 -0800
Message-ID: <xmqqcxs3aw5x.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> struct diffstat_file stores the number of added and deleted lines of
> each file in uintmax_t, but show_stats() and show_shortstats() add them
> up in "int" variables. When the total goes over INT_MAX, the summary
> line overflows. With the previous patch, a single file is enough: for
> a complete rewrite into a file of 2^31 lines, "git diff -B --stat"
> ends with
>
> 	1 file changed, -2147483648 insertions(+), 1000 deletions(-)
>
> Several files whose changes add up to more than INT_MAX lines lead to
> the same overflow even without -B.
>
> Use uintmax_t for these totals and for the parameters of
> print_stat_summary() and print_stat_summary_inserts_deletes(), which
> printed them with "%d". print_stat_summary() is also called by
> "git apply --stat", hence the change of its prototype in diff.h.
> apply.c still adds up its own totals in "int"; it is left alone here.

The above is super detailed write up but still leaves readers
confused because a crucial question is left unanswered.

  So we use a wider type to accumulate changes to avoid overflowing
  the accumulator of a narrower type.  But then what else is done to
  deal with the accumulator of the winder type that overflows after
  enough numbers are added to it?

The remainder of the proposed log message shares exactly the same
issue.  It points out different areas that use narrow accumulator
causing trouble by overflowing, talks about replacing them with
accumulator of wider type, but stops there without answering the
same crucial question.

> -	graph_width = max_change + 4 > bin_width ? max_change : bin_width - 4;
> +	if (max_change + 4 > bin_width)
> +		/* anything wider than "width" is cut down below anyway */
> +		graph_width = max_change < width ? max_change : width;
> +	else
> +		graph_width = bin_width - 4;

This change looks more interesting than a mere type widening, but I
do not think we saw it described in the proposed log message that
was a wall of text.
