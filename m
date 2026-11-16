Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860170;
	b=mfyofl4m5dWO3WpOt9XtqG0BLWdGjyO47NwjxAnRKgbcr7cnurXl4jN5QNIzbRN36UBv
	 m1oQmA18BqicpCZUr3D6gauoIsWgkK+JvB+XpJ4RyY+OsKKKVaWrwg15TnShHRl8FzPGI
	 ncDj56eNH8TcqcoZwZwsSWqlTXwXp62WgQjmjozYg0WGi0y3ie29puexax5vxQXpb6R5T
	 nfmuAYYcPcsKGw4He9NLR+YBCyOSwVyTAKCuZdA5a9dgOTSajsHBq88ToYktHjerXH5Lx
	 es8bCAmvXqJZabyuRiZplhcpvdjn3LCB4xLoI8aXb0V1P+zLnNBRgdVUNymBGvOv9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860170;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WFWBWx0YLltwn0BqsuLrF9BTOsKjxlvb1hxtcIV8Ew0=;
	b=UyfBTLTP6x8Z4JmOWNPh7NbSJVhFT2Wf40hJPnU6ifVOljqsmWTOOFexw83zK4s8VwMH
	 hEpmTMVI0Z9r0yxmOwdij5qS8/Xed/u9X79h7tOGMuP2f9strMTlYEz8HmXFPb9coCVE5
	 RIuEJQ+bbndvR8XEy4iKjlv00+UBAdZ/PhSsbC/cHf98WNN9HNfmoBO0A23GrQJE5Pzga
	 X66406/HLFaDUEzUUKcKs/rS9wFpzSCUR5Tn7ZvsN1YqIGXULL50vOXB0QsbTU5cBB/Cg
	 HLk9tGho9soU8GInplBLovnNPPWrKGEBnM9AbMQp4tci91BOvceNiekbNShMsiz+hQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=LyztAD06;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2IaJGOgx;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F533606A336
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F533606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=LyztAD06;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2IaJGOgx
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 824AB7A00DE
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 15:16:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 15:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794860168;
	 x=1794946568; bh=WFWBWx0YLltwn0BqsuLrF9BTOsKjxlvb1hxtcIV8Ew0=; b=
	LyztAD065Uba2/eelEbuXmlX+US1lRVGbtunsN4Z8bgH+CwXh62uJPVcL86YyjVF
	vaGIEHuoIPZXp8jy6JadjKdjzCh4LVgs94uj9Rvp3I+RTtqEKHSo+YgSH1iHha5+
	G6cPPU9MpOWtD0T95r552Kfi0aQ4bOa/iKaw8dzeKNlzknHwHgNhKjZx9iL/4RMG
	thvBmfeQ6J+HIrh59Xcp3C8FS5nKHUhrUs2tZ/wKgzzrb8L9dcLFS6NGxrKkr2x9
	us6u6woqpobHbTsEZqoULYlQFQ69licKgNzaGPOp+H4FscIwat1SwpE0FyuuiugP
	VuesYtFxiL5ISs9yYCg8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794860168; x=
	1794946568; bh=WFWBWx0YLltwn0BqsuLrF9BTOsKjxlvb1hxtcIV8Ew0=; b=2
	IaJGOgxlAhxtpg5siMNxQG6W/1Gpz1mNtkQKik9jLr29E7XCA/BrI/VmzRsdGvvr
	ZZMnNQ3/TVAtxsHBCalW/mky9SvCqNgmWFhxcz/rw29Gi1o4IMYhsp6+jgycWjPW
	7+d5YkFEZfcI5HoI92gQI9F1J6CAE/oDpUPjCSjjCycvxK9GmhxvOQ81nDGa4s7g
	5hsSAmQHj5dboVHPFUCcHQ/wZk3SYTuQuBDW1noSVrAlyIKn2oj0V04Udj9l3GcF
	aqgfaXYIaT0dNovrwyTs1OxXFKTYFXgyaLVCAB8XyWAHcQxBrhJWfLX3G0b6up34
	+LCQe9D93AsMECnTm3gFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794860168; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZJJl32ex9mzCmCMSpQCZGm5p/aOo8whjTmpZjcERkghXGop
	4wTTBY/fvuSZlX3Nm7xskJDvXbQcbfq2BCRZR8YkOpT+/+gakreKAFTIcTC/Zr3x
	pKID3cXj5EJffz+sZgh4CeIDaVNyFHKpxcIeHB543c3LXRDQcchi8YuLaKe9HNZL
	05gBpKEla2LR2BKQGopyV5ZQranayK4P3ogjgyJX3choov+lchJu1OLbVU93oSMZ
	h/NDR9g7FNVb0Sa8zuVsGWVxPUHoDZrzlh6+CjCFNb7H+Q+VrbxzIYyBBieNbLaY
	jq204MJatSpRmFHy0D7jeFJVo43Fzzbfvo8WNXg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0X3nHlgZmOKaGEz70vEh6uAXr12qZPqom660KWswNmA=:e1P51hhJ5cdhdhRjpEATG60OdCiRw/sE9FgLvupysOE=;
X-ME-Sender: <xms:iGT7ajROzorQM_-4QmScxRESg2jAiAJXGAB47sxWjge8gyKrdUGzyQ>
    <xme:iGT7aqyjnXzU10bdsp3t2eu7FTSjWS1h_C0janvLi-B8VBLVLjTQ0Uytu7XPsQ8L6
    jhPOn5_mrGg-8b6kau1aB_BJzs-2YUcmmC-0IHaUWTVJFzo809z3Zc>
X-ME-Received: <xmr:iGT7amcuBO9ecZGu37t4PJGjTLmD9l57QJR3sG7MIAeg8i599vXFFAjHsW0k_PQsz5JKh1c>
X-ME-Proxy-Cause: dmFkZTF0GDMHBJ1x4Uu6OVYO0IiRUjjLt4bbcVkyGHoE8ksI4/RXqEna4apOjXNG/H/inM
    TqQNL+GX+kh3StddjfsyWSj2OBoW9suq56jDCm31hkKZCw/m6Xf3blpWk9AN/TXcZF9yq+
    KpVJ8hlzI9WSNUP0qvFvkFsca4yAph46hSPzMcZU4wycqLAFv8hmX5vPVrvOW6FoVxeyM8
    9OhH34zqoRJ0iY4Mh7joXxa0A8QZE58cDbVkiMzoa9y9N4UhuxLpGtMVUl8/X36ApZsjG4
    hCuyLD13edMBeTbKvO2V0j6/c0XwyczVRYIFYmORPyuTbW/mC5rR1/1vg0S5HLS3KVRBPy
    ZtY99S5vzNztEET1/ysXsP4oqZP+2143pMRX+rDpl4ukpEjj2DiMPAfpOX8l1ihkdo+m9D
    ir7NPtQGO5EZ2bbYSsxXOwUyciqBM2+TmwwYf5CGiyF4Jh7UKiceKGu33WwoHBBgE0Smt0
    8BcNlXUZEJ1PYTaRIwPGTPwR9tGrGQzUmkPxPybP8jxKoEtjYNNKN2OJqARV+KE4xRHRlg
    OHZV2I0xT6AILTcMth/L9D+3naBqbnLdtqDSqYDBSc/XLzkjOm+eKscS1CohXcJUcqtIfj
    w+xzsyg2hsVE1D1AARADLY7s5PcLQwaDykF8n5pQtbUD1I5h1VvJSmtM9Z8Q
X-ME-Proxy: <xmx:iGT7auKURsfkg38NvzF58FFSko-P6AdIDGlAMniSayX3uV9hZTZ4IA>
    <xmx:iGT7avHt7mi-Bo9idtqQrJGf7tcJLuXuGrDhtkUMUzqMzgtwHAaUkA>
    <xmx:iGT7agrBRU0MYLD0fZR0WuhhyoERr_gte2y3sSb7SXTuwNEH4_7vog>
    <xmx:iGT7agTg7g4u5UcAArbBKEsVRLAAchZw9IzC_mgfmx7rBU2wDtuNMQ>
    <xmx:iGT7anAMTLn0y_Nmj0BFn1SxHU4qG1KEXQIHVrUItWY5sxd7pMAalikF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 15:16:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7976cb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 20:16:06 +0000 (UTC)
Date: Mon, 16 Nov 2026 21:16:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Google =?utf-8?B?4oCU?= Mergify <remy.duthu@mergify.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] partial clone lazy-fetches a blob it just wrote (bisected
 to 5946a564cd)
Message-ID: <avtkhTVuKlnAugZQ@pks.im>
References: <69EF6B53-E153-46CC-B7EC-536BEBE8CF52@mergify.com>
 <avr7CP29sPOdS5DE@pks.im>
 <8F838F35-E5D5-4F6C-8835-99D1C040E0D4@mergify.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8F838F35-E5D5-4F6C-8835-99D1C040E0D4@mergify.com>

Hi,

[Re-adding the Git mailing list.]

On Mon, Nov 16, 2026 at 01:58:04PM +0100, Google — Mergify wrote:
> Hi Patrick,
> 
> > I think this is a known issue and there's a fix in-flight at [1]. Could
> > you please test that change and verify that it fixes the issue for you?
> 
> 
> Yes, it fixes it. I applied both patches on master (7fb6055e67) and ran the
> reproduction from my report against each build:
> 
>   - master: fails with "not our ref 201d4490..." as before.
>   - master + the two patches: the cherry-pick succeeds.
> 
> My test passes with the series applied, including the new "merge does not
> lazy-fetch locally written objects" test.

Thanks for confirming!

Patrick
