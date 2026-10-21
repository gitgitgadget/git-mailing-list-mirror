Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541224;
	b=os66DAo9dmLuxZL6BtjXRmsajwraUgGT13w9/IrIAz+azHooElnfb4gzFX5t2C1YtRL0
	 hBP/zYcxFnJ6+4pwRfmBHNC1aCc2WC8yQZOcA+EldFgBRP4kiUq16Alzvieu+DrMIzQGv
	 AzraPKLFClGAB5eA9AnI1OlrFv+OmZ9PfbJwXBZyA0E8+LNSHCbyV0QondfEf/1jvb9fl
	 0QhkUFcRlLZHxXo3jBHMWyyZ7YZFSVLPkcVU46btR4oZdE/SXFDjMGw/RP5vFbkHGi8iZ
	 PZ3XZk0NROUl4mKxvHX/8YxwniioRCNX0qVKLDWK/XpyXDbYeO5tD+Myj/GfD8DpmzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541224;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oqZFZ8YvdI09RZVyDpdjLM/sPQ5m8B8qaXQZsOUbeLY=;
	b=Gkn78di7blfjmcx4YMtHNnd52G2TV0KsAiorw73ZWtej/V+N9K9sljogXNJTeQdsmqbn
	 Loa+xY1tXZ/SIO+l0G0nuCzGqvBnilRUAfW7GdSNUzHXhc9jrO7Ov4UYkeLIVQD65ruRi
	 3+ycM17NioPqv29xQDhd1QvGTEdqsXm448f4U9oK1YyRXMOomutTIX9cnbbC2lfNBr0fY
	 yb/YrLwJeEg98/4VTFvkIaqyF1UMm0NmEWZPtqzXw2BxS+YwvmqlYUC0KhTzxxrUsLCOB
	 lGTNskmtQt/ivFwoy2RSf8oXLHDjk82ANCa8FhnignQ5DXPxo4Wok2u5dv5nXc6+LKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Zzc+ODqs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BbPYju8j;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9251E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Zzc+ODqs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BbPYju8j
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFCEA140012E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:07:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 20:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792541222; x=1792627622; bh=oqZFZ8YvdI
	09RZVyDpdjLM/sPQ5m8B8qaXQZsOUbeLY=; b=Zzc+ODqsGJh6qg3nIv2+aCvtkj
	agWcCeJ9Z9CGVd+S/qO01fPwQh25D4wAL6hgdIK3XfBWUti8RjKo9jggdjvHXqlP
	el7wCyAjX20bn26bUustPJI/npeOeACHMcVaV8gnGhiBB47ELnlVn0Sm67JUDv1U
	Vbz6Y/LkomKnxZNkZtKigv94dkHxKAi2Xca3sO15ig2d+NTI09FyZWpoTVwJYikw
	W/PGIVcYCQIuLJWaKVvAeCiSl87gj04WvQRDokI5cb6WUdrP3ixka/hfCjd63PvM
	pQuuIzLia8ARDIh/xg0nUWMhMtAH/i/ahJNkyIg/9sjE8rZOuucYCQ0WxNjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792541222; x=1792627622; bh=oqZFZ8YvdI09RZVyDpdjLM/sPQ5m8B8qaXQ
	ZsOUbeLY=; b=BbPYju8jwmZvsPQIk4WWqlqKUHCSOmqvdlZLlzBqvxKqUexEti4
	pbchWABWoZ9wqfe21S+ed4YQoj1k6scoP3kVrRM/bxD/r6EVY1M8Pq5IZQhtoqgH
	4JFedvNR0FBEjWbJjDcQ+OPSCiNG9osJixJGbNkhAsPDO2/gCvtuYc6mP5Pfq9NJ
	G3xiYupTp3f4ONeSGM79XGy/VIIwFmNwa+MwKSwpuZrvElwVXtrLJsE9vvEcZ52u
	RpkTAq40A99EH6Kmjt789PdRQG6MWuEDkO/8svGeGF2XNzId5ClE3Vppx+5zp4AC
	K54uwZu4ZRGmoq3x6sVbcnooqiZ/cr5q1tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792541222; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UZNf+6LWIPkkvV2WK02xdklSzh5jMVV3MfoVtrMjDPaJ6AN
	3CEvqTKGaNtHsdU9gjHKO8ShJxmbDeCEXw2s9tiYsooMNhlOhj/E85AMlnv+I/8W
	8xUZHABWaG20R1F4wGVkIuCisCu3LRA9okcfW7/Tobcc4J+SaYPZyraCmvX/oqyb
	r6G2fuD2t7CivXlK+e0saxBz8GkyP76SJK0d7kBCKtYcDlIqoYVKMDDdcCL8GLYa
	PdtNgR61R2PY1cSgIv+nnJk7+DADk+Z2HSz20HtWls6ZvC403CS+7UBHz16CbDbR
	DopbdQJmoZHkiPTGjFn1sgB+7n9uj9ve3i1VCtQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:loR07N8QMcylj4z76z4bOVwf1anVSGH5tVd1kO4ryLY=:6MT0oBENxzMakPahaop805gzNmx91bsj1ZldiujWv28=;
X-ME-Sender: <xms:JgLYahSFCaX_Y07We98mHOMztM52zdt4G8DxYszMQtKd2KIhXT8vdQ>
    <xme:JgLYahxiPDxrS29l-az0SePrw3kafQjERlCjLDYHHFT42B5RQ-qbchyt3gYo20-vj
    wJs7bq_Puv6jtAyGW5DiBFl04f1cfL3na5MvlSpxe0h7y3pI8WCPTs>
X-ME-Received: <xmr:JgLYar37lA2Lp0kkMUyfeewiQlbRll0qV2UoSvtmWPjFtDtBImeUt47id-NkEbBx9OtikktLDwH1gSmK_lMZry0sStpMUxgbCoBz>
X-ME-Proxy-Cause: dmFkZTEfYKDCxnkzO7zqsBiYTRlaCTqWk2+FR9mWr1LZigZintevC0LSF+sq0xiQo0R+eI
    cYWDfldzI1DTXKEaKrF3sECS3B9H0WFe6klk/dcF7b6jfPoHN6tAOdfXYyqLAVSsxJ/lTJ
    i8GdUvCPLV1RcmPGQNS7oPROOhiITy1+pJrZcwRNv+HXNHXDRjxrQ97FRcElrPuPXWipho
    e8qA6Denuz1Nesn5gBvlYqqiSdm4MbGac33Hi1mEW8SqgOkC5+r9IXPmfGHcaZMJSvrNaf
    orthfupZOHyfLai0Qwhu+69WxCsN9GJiKAe63jwwkEkpnP8AmJjM9mg0FXc7sZp36BJNtB
    7S5W968nWqpI5xhnI+98d1SUR6KIGeg9H5NYn0x9vCq+PIlM3PrsT+0Ot5JOERW4mmSqjM
    14CxnekfCrb/WYtIMQ7jcIWwd5z5IdSnedH8OoqxL7Z7TAQbd6O49I86ZqPnNF3bo2eqvh
    ii5MGBB+hHoGVoZNPIdO7edZjiPpEOS9ODL7vd4xOpH3bzIJiw3TN31gk4FuMgKz/2ESJG
    CIT/Ya7+GMhoclROsMTYNiCuzGPOziPmN+HfhZuyxTwmKoeiDaOEIPT5nR4TSQ6MUGjl8E
    gbLGFSryXTSo/yTx9vhTxpelOadYEI/wVEIir+1OAzz/E/6LN94nb6G7x7Jw
X-ME-Proxy: <xmx:JgLYan4L93PyBMNHf0lj9IDQru5VvDm9q1AlXGXV4WHeNgu6n93xYg>
    <xmx:JgLYamVO7N3YOpHPDN01R1YEQiV9djkUh9Cd0tn1lIvjaNw1ioe3jw>
    <xmx:JgLYauBsvvV9030sn2R-LGCzKoGX-YR1BYjl_P6lDqT6A-ltlTrwWQ>
    <xmx:JgLYat6uUN6VNzDtm7krdj19nV9Wy_wSuYOG7N0UpXJGRnUmPf6KyA>
    <xmx:JgLYamUIycwTDNNOpsNGuxt0Vu5WZYhuHPTZIACpOuR5L_QDjfBa2jJv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 20:07:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v3 0/7] stash creation: avoid unecessary index loads and
 refreshes
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 20 Oct 2026 16:20:35 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792509606.git.phillip.wood@dunelm.org.uk>
Date: Tue, 20 Oct 2026 17:07:00 -0700
Message-ID: <xmqqo6cnsyqj.fsf@gitster.g>
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

> "git stash push" and "git stash create" load and refresh the index
> multiple times when they only need to do it once. This series removes
> a number of calls to repo_read_preload_index() and refresh_index()
> which reduces the number of lstat() calls on each changed path by
> four for "git stash create" and eight for "git stash push". It also
> removes a duplicate call to check_changes() so that when stashing
> untracked files we only walk them once.
>
> Changes since V1:
>  - Added an enum for the various return values from do_create_stash()
>  - Fixed typos in the commit message of patch 2 (was patch 1)
>  - Removed an unnecessary index refresh and several unnecessary index
>    preloads

Nicely split and described.  Looked quite well done.

Will queue.

Thanks.
