Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463363;
	b=cWdhrhkfLUHS0iWHWAI9lbRqt8UjMcTW9pabbOa/cElE1hIbLeQvQTJhG4AV0m0DspZT
	 cwLBhiMER6a5ofUB0pqbfF944mhv0rPgsq299TawmEGHsy+wScfYnxy/G00kMC8pVCjna
	 zB7GREdU22N+vj899AcuuogiV4+4mnMzt8QRfmbjYVjlkawRheJDxA+gG0gp/BZIABrRM
	 Vw55TFr+yrl0Z/2bmx2/jIqcsKRv8uWVVNBGCzboD2jTdiz75pF747RSaasuyRneILQv/
	 JoMBrIV7n2kj9MXbIybWSPe5x6AIUP/MFx0kWvky6b3X5wBICc6KAqvb813xNXBGOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463363;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1xvZKFQ6AMm6lvt48XcaWBJIWHz7I25UWp0HOu2RN2k=;
	b=I8HB1DpEduiewR4AHZfGN3pvSWEX4nfymAIkdu6EtlyA3kf9t0gTaNEz+vp8ntx08jMQ
	 maSpm9pmraydAIAkIdTb2L5PcN0l6JeeP5yZ5zwnB/kTGgCo0RL5/yqB8f6h7z7606OG+
	 Y78/DzZEmd6Gf5AM/6RfnYEglLykQbwB7znq9k1Uka0Jf2lBU1n5zi9HFL8vZ10AYgWDS
	 Ibqy2oNWsf6sNlibg4jDRtP3wAGJrIAwibiVRg9VmJWltNvZzf/OMiXd+CIjQAk7ykTLh
	 Y8ox2FPfDt56mnPPoUvjL2+dXrytZGP2wzZihPjBdZJuI+VJ4nFA5ZTuKuvrKAUQSzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OJfpDl0c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jUGafuim;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF62606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OJfpDl0c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jUGafuim
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E52C140008C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 22:29:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 22:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792463361; x=1792549761; bh=1xvZKFQ6AM
	m6lvt48XcaWBJIWHz7I25UWp0HOu2RN2k=; b=OJfpDl0cgyVl0U76Br/xfNNXws
	S8ygWjWKgV/aTiV9AK7oFUYZvZbqTmPFm9xzeHcCgNrupVuAAnIPVkyaeWsSdXAK
	/4UQQ9pvertb66zGeGdSPtWTAoDgpL5eUQLOksIqllGJ6uv+uz3VGJdOgd3nHr7T
	ct9Q4o7drh8JV1Sh5Y9cv2F7oWlQnJ4hS5ZVQwaJm4F9XYfM03AJmo46T/iVYrt3
	4tEd/vgFEjluq/lgetsmzG06cMbdQpZbCn6GdEtnlWblkQtwCphCXU7/2IT0sLQ6
	g5sDM9qj2LLugCG3xNKFWnYzRCKVYx2vybHwGp3YIMP7PQHwDjV1PiNYxfOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792463361; x=1792549761; bh=1xvZKFQ6AMm6lvt48XcaWBJIWHz7I25UWp0
	HOu2RN2k=; b=jUGafuima8/A6u2eePtFd3MwMb4bL67FzdNKY/5AwaVG/W4FbE1
	Qd7vB2VfNAUljJCSyYvmPGTNDwz1NFLqf01WoWqph2FVZsSD156Yki/zW0aTwQbv
	4NyL18CxrTARVfKDXgQA0OJImquU9eJ+Pa3Q0S7GjfLDQcBZLkDuLiwj7jghY+47
	5mZg/cgvpQRotwCvP9LO1fixreKLkyHCxlmRO0xVstqfxZzxQa9TGF9JQ22qFizT
	Vys2SgfByPVK888cBXU81gmzEXAx8Rz84rk83oOfZX+I7ZKOb5vKJrftMh+sJ8oA
	fBZx2fdSmI3hPGvrYCFjkv0RMDDzN3Y9Fuw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792463361; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HKRqElGss3TQIEzKC3z6sOOcXCufh9/naTaIokHFzCBG3VV
	Sm4bVecovWi7YYcbMVyYkg6eNri9a3NKl77+8RuFsX27zJun3UyXVymq8PLsX6Si
	bKT64v39KHclrJG/LjekZbjxQr38695p5MQX9rOCHS3T6EDRQF4Y8FeclIx9LnIT
	L+QTCGbFYTiHFDJ2/9Ih1xvC0Pq7MUJA4MtgE3D850ZV5ypeG8/L8JTn8uDqO09c
	iiID4feCJBZI5WgrkviU2cdXPLwzjBRDW/g25qluiF12KdekC+QHOSngk52AMa0m
	xiNTCF8T2WzI/UEM12yqvKxn7vElQE4RiMxJjnQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LrepzPZUTTS7Z8Kl81V0VVs58ot9Q9/LEvU+ElEeIt0=:4cL+4C+/wPjUdnxk6Kiouc/P/TiZj8AV2uxwjnCTykA=;
X-ME-Sender: <xms:ANLWam9dkBLsA9Gz_sqmi7IC6xccMTqDeXdyHPWNeVY_iVao_6IUFw>
    <xme:ANLWanbwbI6MVB37mgU3o8upJV0PSf8y2g7TyNZybpi4_CKW-tuARIbuRrBK9j33Q
    C2dVaaL2TJDVcOPpSVOhFEdSczN1iGiH6v5-taeoRH87CN0drZzKw>
X-ME-Received: <xmr:ANLWaqM66cw856fBRUiRVFg1jplKrEJxyKH40TsHQ8TTJPzNqLnCZT2pDo8UVpKq0XYpsJ2ZXvSYhu5ZAixcc2eFl0cwg4nBIlta>
X-ME-Proxy-Cause: dmFkZTGK11jt9E1xzx5siNqBqN5bk0aQRHcMaFC2kX1pPHWmO6MyuleRbkq/4tQMBuJEV5
    WN2nvxjUq17+MqGYVOkFwVBB8aRTxZGkS8FSAFyM02SX3xxUzt5NkZcC5liKcjiNiba4un
    cdXi80ZlDq/E04GVURP+czC+1n1s1fH3SN21c9OqCdYYd/v4tvh5H4rpEI7RMW3vYDnpIO
    vTPKmqwM5gBeSvR9q7t08NFRvPHpee8kc9jsm9+yZxJ5htdyO2TXSNzt6MKVCICm3iOGQR
    Tua7AgST2y4Am2Z19ogb/lR+3mbBohyK3lrS5VCMbtyVhpZDJK3wYSD5CbEEWwcpUtnYCo
    bl1LIwO9aKbsxh4ZoAUoQo/XcGcwOkpJC0zBKP0zu2lw5WPT7phTccJkLBhl2q52gul5B+
    Nmfo4Wj6Naftl8XtGsHKBcSyW2TQ3/zn6DUgxcHL7z5xI3W4iA8oe8YVoEV/Fb198xZnnS
    t/R78gQreUhWRzeTRVUStWTzD2CYsF+4fmu4AC3VOIx9QVucdd5xSqM+E5Ecl/FF/GTsFQ
    Wh6QasdaA+CISoqnjIGVLrOQP6BlixIaHhBEfshRIJ9usLFkRgxR6RfTl6xWkYIkXzqge+
    bkjTNYvIKo0xFnBJpN407wfsC+SBTloJaoHEmNZTSVIw71o/PvaMgW6tUmNw
X-ME-Proxy: <xmx:ANLWajDJjYSHECjazZE3lz5_KEFERwmSxEeqrXzPHoSit4GYlDUItw>
    <xmx:ANLWahIlOl9CYSNK5mjwVGQgPxdUvh7yTQT5xaCL2XqHnDv4BWto1g>
    <xmx:ANLWasPvECAC6hK9IkVPm2e-2Bz9J-WzKoa0Vi2UpWpmlByZbbjF5w>
    <xmx:ANLWav4F8JM6uUK4XlHRTBbsLHBctNUsqzkZtL6Kuvq6X6kw0HwEjA>
    <xmx:AdLWahZ4q_gMVCfhxWCXLyLP22XDK-Lts1vDFiolwZsTrqibltb-q5-1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 22:29:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Jeff
 King <peff@peff.net>,  Julia Evans <julia@jvns.ca>,  Li Chen
 <me@linux.beauty>
Subject: Re: [PATCH v2] doc: git-rebase: Update incompatible options
In-Reply-To: <20261019143546.207295-1-omri.sarig13@gmail.com> (Omri Sarig's
	message of "Mon, 19 Oct 2026 16:35:45 +0200")
References: <20261019143546.207295-1-omri.sarig13@gmail.com>
Date: Mon, 19 Oct 2026 19:29:18 -0700
Message-ID: <xmqqcxt5yuip.fsf@gitster.g>
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

Omri Sarig <omri.sarig13@gmail.com> writes:

> Subject: Re: [PATCH v2] doc: git-rebase: Update incompatible options

Downcase "Update" here.

> Several options in the rebase man page link to the "INCOMPATIBLE
> OPTIONS" section when the option is no-longer incompatible with any
> other option.
>
> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>   incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>   the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>   section from the option description.
> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>   2021-09-07) removed the `--preserve-merges` option from rebase, which
>   removes all incompatbiilty references to `--ignore-date,
>   --reset-author-date` and `--signoff`.
>
> Additionally, `--onto` doesn't link to the INCOMPATIBLE OPTIONS section, even
> though it is incompatible with `--keep-base`.
>
> Update the description of these option, to have correct references to
> the INCOMPATIBLE OPTIONS section.
>
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---

> I was not sure if both adding INCOMPATIBLE OPTIONS (--onto) and removing them
> (the other flags) belong in the same commit, or in 2 separate commits. These
> changes felt small enough to me to not require a second commit, but please let
> me know if it's preferred. I'll happily send a new patch where these changes
> are split across different commits.

They both fall into "update the stale list of incompatible options
to code's reality", which the title of the patch claims to do, so I
see no issues there.

