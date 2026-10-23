Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778033;
	b=dvSKvhLNy8jyqmXtRGYWgN2NqICadAE+I6TDDhQJ1wFGQ1dOgtGcJngD3/X103Bgrd4L
	 tbYBA19eK4OKELMZ8o0myInfxr/pHC6DGC1ofyIsaBbTsgxugu9SGVCQWquHqJZmImTg4
	 vbjL9n1xEdyux6uuf0nmGXTbAfxwTpIoSsgpKcbb8x/5c/aVlYRD2MfceDeq/5+2xAbkL
	 9hLl4s+CAsXydCGugqfE5XAWmqiz88inVHnvpkbZzqCn2ZL+zjx71ID0zS3gdd2t42SBT
	 zQDuxXjV3rKi6b0/AX1J/nRnAeBMis8oJV/4fWnWbs34vp1DpKVhJI4iggMxGXERd+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778033;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Pw+Cpuu67BNR8oEofBlJvQga8oGs6Dp9VEGp5qEK/Cs=;
	b=AqwV22mTDaYbPL5NtWYaa3iSsEG7AMjbW+GDs9a1aF3hlGD5uQS3GD05RGB9iNe4ZkBL
	 hy2QtHGm37uAkJ7Q+YWJfuQWW5zjJSCaiLUvwQwLtlp9RjNN2DuiCqqS0AH0N8TN47wf1
	 LmQS70JxykrsUlV7FbUSOql1tOp4CC634tH74c8Z9seVXGDk8qBsfTGsvsSYuPvBrEPrW
	 qFLHkbsrc6Ow3P+OtbtuODRlZjQ0d+7tUO+SSfOO0DoBUNC+pUOSWJIUh83WKSfR0GiDe
	 2ybuULR32JSRqwzHQKOJwqa/qzAm5ns4LP8J+OEInD854GQw8nOr4MLvWLGfp0qnxqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="a+D/ntbv";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AkvGotrD;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74309606A32C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74309606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=a+D/ntbv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AkvGotrD
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AABDAEC0183
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:53:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 13:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792778032; x=1792864432; bh=Pw+Cpuu67B
	NR8oEofBlJvQga8oGs6Dp9VEGp5qEK/Cs=; b=a+D/ntbvnWGoovESAcyY3vr3Ca
	Ue5k1SfryyXltwI+vwraNbkRw/Mf1l479VeVXD07zd2rnBdm7d+HAp0Wl424lVWA
	lCzshodBeFxRVHJuDMeFV61QypSEx1YdRP5h/iUZV627Gvre+OHZWAR9sm3H+h3b
	o3rTWQzJEPQ4K8eg9wN0/tAo72ildZd1BM0mLXsweV9hFhI/f3U7ds49+dMNTv0t
	QiGCKuThNs+hNWk32H4sAmVXVGd08/Q0MJY5sLup8Lp4/Dj2/Q55mG2suU8NPdU6
	Oq1/2BUJpfiECX7p8f3puSrMnBnVmNJCh73HQ9asvlEnj+AQHNUL8kL9+cCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792778032; x=1792864432; bh=Pw+Cpuu67BNR8oEofBlJvQga8oGs6Dp9VEG
	p5qEK/Cs=; b=AkvGotrDzpzmLEuPVnqV/HS0dt0c0TXm0KyMBQ6lfAVQwsKST3v
	ZQ+g6wXIquTzbSya17BAKvdLBOK1IRAK0ZEspINbcXycRm9VApArgfOheRsvgyyi
	S5zmeaVrLG0bU1iD9f+fFCldcRpxtAS2bzmfvhmYLXlh88fw3Nn59IPT/QEp2cz0
	CA/rIs9WEUv/K/eZEfHw9p5H7kDT07pzlOF9WRhAVVOv2fZ5soXhBQNEwzdneF9W
	maZvkZ1b1e90QSqtIT8wQ+VCb7VB+IUyQuoRT/C4HQxk8VvAYJAjhCCWiS+rYNM0
	REoiebWoL9Ry0kNm2jlrj/PNu+kzW4bs/lA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792778032; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:joU/8wrr8ynaL1HNt2Pj6X/xTap6w5w3A9UxrO/41v0J1+q
	Y6sbhJf92Jb+bKpSjGFqjZPjIcbRuCCYxZ01M+VoPgzilz5xgQenaPtDrfdp32u9
	/EpObjKp8ljcalMSpdeKr8TcbbbHOzZqq5M2nVDn27Z8XPhClrApAZX3ggzXBMX2
	cuKePIkFxbeGA+adpdBXOg/lk0Jn4R4tf4FTYl/SLeLwvUGT9HQ+BN19HGUlDcYD
	aVC3do1NIGzwF4S3pCBNNsJ4OHBbL2OeUN/b6Wt3408rwKvKBrUo2bM8CDPWbfwB
	pP0+XbUS0zCHzXdgjpqP/9sMGyP3IApOavzquCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2tWGm51HAAQOy/emK5HGI0wV7lG8ZATI77TTwtovfSs=:9xsFee+5ZPtx9WGLbDK1NuqEEtdBAvMDvLr/2+dzl0s=;
X-ME-Sender: <xms:MJ_balHMppAeVy672Pr4MvqU7WrXTj0MC8YIrMEWlZB_Twi58d-qTQ>
    <xme:MJ_basnIDwqvz5PPYt8rK2cvUsEGeK59kvUoJnVybar1CK4SKW8hU0UOVF2qiMh5V
    V1u7XtcEhTxagTQvf18UH0D22vq38P_KMelY5lsEceoHVHSNsLkVM4>
X-ME-Received: <xmr:MJ_bapbvrMk4rCv2vruLw8RUfL48jPo_H2rVEDwNfkRGA8VrOxo8UA4GPpQcC5zvTXv3H0wTsCoF5NfloHMWHmcD78nLUNiy9i30>
X-ME-Proxy-Cause: dmFkZTFhzS9jZ1H0Q1sU1GI2sQpxYXdk/7E5xXw429FfIPkdPD9FtB9X3fNfjWPwc0FQGc
    KkN0vxbhVPtdzLspxRhXAxH486Hnni9l70vxJEKlTeXaiQuG/KGDRmx+AYCxCQ1KaPIiDA
    WMvBipFCIXTCHLmJPKC01sE9sD8Z2H4UmWT46oEaPtbJCYppmXQZce3k+KEKbN7nYEYnqH
    ehPYk50sf5Zfb6YveWqB01Gb9cm/OX4XAMwxK0EUehGFFH+U42EJ3nQM0bJ91hYETh7L6g
    ZsqgrDLCoe8sMHyxDFL5FAqYSPTH7eAOS+MGS1/hDjom4J1ueRTXQkHJ6vvB+gjvFwFxhS
    N4AzGj9HwymTA13c1MrS6hM7J0hcGQmfnuN6Xii/cnU4fnxylKlq11btoksBnvIYuCqanI
    QltHh/5uD5Ne+/PuLfvxHkiIKEDAxYT9lrOvpM9UHiu7Ezzv6zVNLvtfJfdoYpH9BeQDHb
    3ecS1APB4vhmvz5lWI5S92supoDEmhsL1JaPK4B5f9PVGO1vExkffe2s6lZajh2ap2yScS
    4qmy4ZfIFc8tSIJy/Q4zwJ1htwaIgZE9p8Z+jhmM6suY+Fi8CTsj6gvbbPZxRn7FCCpOL2
    dHjCKVWJL1ws5Vlzy4IhEL7aR0s/nkE8yJ0qnCOiz4h3xqlWLQkrsE4k6v6g
X-ME-Proxy: <xmx:MJ_bahE12r4OwxqDYhU77chx2SIltf6aklA7Ek_2E3nGjotSHI_mnQ>
    <xmx:MJ_baqKy9j9hcoTnuHRomAfCt69gvtfafTjaUs4_IQMt367ItTTCYg>
    <xmx:MJ_basP6LFw1q-J_eOyLx3bRvDsYN2HFJ-JpveD9LTqoRzD4fdBTgg>
    <xmx:MJ_baqlSEGISNCoIKCrdfJhSpVCaRDHk14W50ap0Xgfum0_w5SdYYg>
    <xmx:MJ_baj07t1JYyk2WJD06UW8jT3PtbKuZ4Np3fTKbzzH_0Oa6dtOnPklg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:53:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Adrian Ratiu <adrian.ratiu@collabora.com>,
  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer <nasamuffin@google.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2 0/2] Two hook configuration changes
In-Reply-To: <pull.2272.v2.git.1792761542.gitgitgadget@gmail.com> (Thomas
	Bachem via GitGitGadget's message of "Fri, 23 Oct 2026 13:19:00
	+0000")
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
	<pull.2272.v2.git.1792761542.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 10:53:51 -0700
Message-ID: <xmqqh5ic7174.fsf@gitster.g>
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

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Two small changes to hook configuration. With the first,
> hook.pre-commit.enabled=false also stops the pre-commit hook in the hooks
> directory. With the second, hook.*.enabled and hook.*.parallel can be given
> without a value, which means true, as for any other boolean.
>
> Changes since v1:
>
>  * The documentation of hook.<event>.enabled now says that it covers
>    configured hooks and the hook in the hooks directory alike. The subject
>    and message of patch 1 present this as a change in behavior rather than a
>    fix (Adrian, Junio).
>
>  * The test that hook.<event>.enabled=false leaves the hooks of other events
>    alone now has a hookdir hook too.
>
> Thomas Bachem (2):
>   hook: make hook.<event>.enabled cover the hookdir hook
>   hook: accept .enabled and .parallel given without a value

Thanks, the range-diff looks good.  Will queue.

