Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509104;
	b=4k77SO8Ulv4ZVKekQ5nGBw+ixD6wtBDE91vDALOmj3w346t99sWyupnkY2OVAliWWmRd
	 RJ1O3M4KS0LB01VpbD0JGkx4IsDuwXhdNGyHkzuk+j9dQunlSB0OtkLrXl4WfTllPNWmb
	 Y18BfzJfRAD5l+ruq3Y9i7JkQKCOdpLbm2dAKIy2XweC9HHnJxoQ8mEp2Vg2CfDBKx5yJ
	 HIdp37Qi/gdwyGldzesQD+JLCVapGMaug5WGodN6/AyLJ5eLzL/fEs4HDm/tTUpBXmxCT
	 VrZBO07pR2WVUSjdhRa3qU+Uoc6QyJJpyfhXCQBpiJlOhxXepn/xd7w9XtADtJwIBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509104;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wVdpQzYnUenAlAb2m/KOqQE1oWiRgOoG7/qPUWAzPXE=;
	b=F23SRHpo7UhaWGbbPslejWq5hkT61z7lL+aBWFjQI3SJmA274wu96w98t3Ns6P8qot0W
	 EKkw2cHNRZmicr/KKr/8bio1ZWnzLwZ59GsKYrpiBvKaxyb0kafk/HDX2zGneRaOzjejZ
	 0KkkoCgFf6ARPDawtoWCMuuAI5qOU4YZFoeEs9QLMxTcGOcasUAW0yZuhJ98S6wbTI3NH
	 rHUP1ivQYds1osP0ONQHF0mb8tDdF/i+m+kaA+U1n2i4zdaJE8YSF2lnzSVstyFov2p65
	 CF1lrjnLxsQdoeqWP2ml18/u9ZXYicn3CAbv4rKBmEty45fZxwuchceoJldJSTM2KbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NsC4G3yi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xVdZ2CSE;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B4606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 18:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15B4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NsC4G3yi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xVdZ2CSE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 05B207A02B0
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:45:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 13:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794509102; x=1794595502; bh=wVdpQzYnUe
	nAlAb2m/KOqQE1oWiRgOoG7/qPUWAzPXE=; b=NsC4G3yivglcHfxKVkbhrGSvF6
	UCjHdNJOrWM7RFi9xv/TrLUIFMQ09g4rqy2XT2f9wGwzvTiNyVLxM83n/0YVaYdw
	6iG4OcSk4Ev9Kueo3AjeJZwn631ce9SHcgq/g2ppGn7zLwbmGCuzISAS2TgSkaCM
	d4Wb8W1SLXfC4sQtSmWO1+hMItCB8PfUFejOgYNuXQ6RRDuZxMP7YQk0vVKMTXko
	0uQHzvOx7/++faGBkEAN7JAlBQaw73ELuO3kXUabIzYI2rB3xHAN34bjsy+dtrlF
	QA9tka+Q9ihdEj1i1VU+jqk5PMg7RIdWaWtDGjcsywdr11D8GCb4YWQW51EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794509102; x=1794595502; bh=wVdpQzYnUenAlAb2m/KOqQE1oWiRgOoG7/q
	PUWAzPXE=; b=xVdZ2CSEGqkIzuHlwyPyKwNJK2PiCAEvrDFShiNRO5jKYDwuzZg
	xx1yNX8JRPARHZge59iuo9KViChcX0qJ7T6KtZkob1c+n/qYmhD3mJYWTP60BuYB
	4c8e8lxmXJM8vQVSGbhNT3FZNDEKnKT9egZEkbLlyzRSYRuBFXM4TNs6Qote2LW4
	aYDux8iuqWRzHND7QAruQqhp2spqa1EIKDnEGBAK/g+JTscSgQbSv2u4rmPJN+jA
	zueCGxFd9iyp2r+hi9GvIOQt7kdD+riemQsHsQn0D3tAA0+pOyN9a+GNmtiqJhRb
	7zciGJFKYcYF5Mn1+spPNitWUs14BhAPQYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794509102; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ASpNevSFMuDjtQ1GWy3k67Awv1h9hY2Lja3p02fFvT4OmfS
	wl6GbRwgadM33fBQ4Sr2+WGjr39RWLOcIU6ripg3OK6lHWu5b76ratYQxovKEfgr
	B4jmbhroevg3MmA3/6QORu3RbBzzLRDatU8/kBq1yY4WiFS0Am/Bu9LlhkC4uoKW
	5HT6HcG+4cr6nJW/IbnnBm762RAbDmPHyoqLCl2u3n1X1/WP1iFFAPIsK+LOtp8Z
	41mipK43Itt7Sfg3z/hFlmYr9+1wxIO6u4t7C+wlR7uBQeKjDBCf2cFZTzINWcLv
	4PTogS9EUOi2wyNmjleWVedlxIrRgB1lEYF1bbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sUwnxc6T4k2bOqA8ayx+tOvuHaiqYe4KM5edV9Kk+yw=:eAKdgxzkE3gAoCvRCwMvWhTOhuqYhPiJEZwZ/++gFrw=;
X-ME-Sender: <xms:Lgn2areWcizpgn9QAxgMvWjp9fH4jfpNgh0f8P5nd80lGyEOidPLow>
    <xme:Lgn2ak7XV3qpMA_Jxthre4TLV8v7nKjvXcKSmnA7WROjErovwLy_ovWiWws1AlzT1
    4IRjFrDAFXCBfaFKsUavc5SdwTRCji9585NUoLLStUiQ0VcOJVVUg>
X-ME-Received: <xmr:Lgn2auUagmuu3vmkzTv9_AALjYl2Ger5l_E1pqEjrFVouUSFczp--CU-GNdMgnw3HkMZplUsfdvSSuSI_dx84aeDUfoB7wPH7gbm>
X-ME-Proxy-Cause: dmFkZTFR3T5BSxpX7OdpKMDCtCac3maBwgUZXkBRtnX547SzZdTCK4ozSEx0nDnymgaIlD
    qUAY45Kzyu95d+9peG3CpvnwFgf50H6E12HceZpH53eeubCvmA/fCsuJozNDFmKLCdc/Gq
    DVARSU9wNJ8PpGwMcpKEhplixfPDPSAzUefwPopUZ6lD2PRlRf58XEjVECju0n3vSYHvVU
    i/H65qF8QG9KLfVYhkYToR+BUe/xvv+Emyytt+BIDwevKLEqbPLcz224kg+WVPCqDkiOD2
    07d/2S6+GM8xBtDZWe/NVsIawT4MtWj45/EOshqFK7U7l++QT23h6P3MtXzAM71/kO+quB
    6ZdlZD1boouehEI7QuhGL4hbe0pxt7djdUcflurzuWLk2Gq2zUmqallSJXbi1i2GhBgMEW
    VVhWH8E8J13pPjCA+Kb/uH6t6k4k2vU0Mmzwc8UUM+fBRytlsbeIrCwLnc/qZZnT7UAtg+
    +J/kBs9KceOzVDs1r+BRvKmMEZsufnx+i+twi0oDV0MbukSfw76c318ALb/ZwEgxyhdVoY
    3TOwlwDPLO5X0K5AJoSNNbhqkXSX980JSR/yKcBYRLQgUVesTBaZ1QYP+ugsu6Yvf98PGn
    4nulpJY23xeDuYa3ub9k6nJvmtTp0Tg5l9e/qj9Pc1hM5XZNL5Rj0bQkQ4Hw
X-ME-Proxy: <xmx:Lgn2aj6hmO-wJqAuO5WI8KnTxhhW9C-waHJmCXGthVAhF22oZrwNKQ>
    <xmx:Lgn2apoqePReaRPOG_Arm8cnFY6lBrbQKftlr_yUxe3HEtau8KyN5Q>
    <xmx:Lgn2ammemG7EwU2vEt1pgr-oMCCFkAmvfyrbJXLmuFIIN_dS1FZjyA>
    <xmx:Lgn2alM_IlrD0V1zBEuSbLOjy1vaLdXOYBaX1AcAQGXfsh4llOrxzw>
    <xmx:Lgn2av2fTutfR_RaLqi4pzM8iMBM6WYGiPm5jaV5ZpbzE2PhtdzAvUjl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:45:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Yusuke Hayashi <yusuke8h@gmail.com>
Subject: Re: [PATCH] refs: drop unused `peel_iterated_oid()` declaration
In-Reply-To: <20261112-refs-drop-peel-iterated-oid-v1-1-7df1c313e293@gmail.com>
	(Yusuke Hayashi via's message of "Thu, 12 Nov 2026 05:57:35 +0000")
References: <20261112-refs-drop-peel-iterated-oid-v1-1-7df1c313e293@gmail.com>
Date: Thu, 12 Nov 2026 10:45:00 -0800
Message-ID: <xmqqv761j3df.fsf@gitster.g>
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

Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>
writes:

> From: Yusuke Hayashi <yusuke8h@gmail.com>
>
> Commit 5a5c7359f7 (refs: drop `current_ref_iter` hack, 2025-10-23)
> removed `peel_iterated_oid()` from "refs.c" after converting all of its
> callers to `reference_get_peeled_oid()`, leaving behind the declaration
> in "refs.h".
>
> Remove the unused declaration and its comment.
>
> Signed-off-by: Yusuke Hayashi <yusuke8h@gmail.com>
> ---
>  refs.h | 13 -------------
>  1 file changed, 13 deletions(-)

obviously correct ;-)  Thanks, will queue.

>
> diff --git a/refs.h b/refs.h
> index ee3b8a62ef..73076cba2f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -178,19 +178,6 @@ void ref_store_release(struct ref_store *ref_store);
>   */
>  int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err);
>  
> -/*
> - * Return the peeled value of the oid currently being iterated via
> - * for_each_ref(), etc. This is equivalent to calling:
> - *
> - *   peel_object(r, oid, &peeled);
> - *
> - * with the "oid" value given to the refs_for_each_cb callback, except
> - * that some ref storage may be able to answer the query without
> - * actually loading the object in memory.
> - */
> -int peel_iterated_oid(struct repository *r,
> -		      const struct object_id *base, struct object_id *peeled);
> -
>  /**
>   * Resolve refname in the nested "gitlink" repository in the specified
>   * submodule (which must be non-NULL). If the resolution is
>
> ---
> base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
> change-id: 20261112-refs-drop-peel-iterated-oid-ede2901e1c5a
