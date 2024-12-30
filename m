Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB91974FE
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543525; cv=none; b=GxlMcx3yKWMnDH3GI17FYzyRTkB/HLyhm9kYYCfZah2O1cKa7C5IGE/RyBqA275s5vbd9pVbe2EF1ZKRehMH0W1ZTPEGJCq39U/hHdgSoQipSX5GvsqChARjyz4sqEohasLN+eiCfgYTVQsQXXjS3q//i+5Jtwwu/xrx3ATZ6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543525; c=relaxed/simple;
	bh=Tk+y7PKqPW7STdxlJMM+VXcX78zYKqiZLBk/jxnD7bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQYlBBy8ZIE8NYTHKcXVW09NR2i8y4GjLXCfNqOmJntmTj0msXydhpNCQo7vBdRICT75zNbl8kdouCwDM0yLJHPFnvbtFQ09LxKKWHuPgHJ0SD0wuSb5vTJ7+U2N0pIUSXi/X33ZTyykAe9hQW6Au90ojiFC64LchY0VYGbUCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=skW607bZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZRpR5rg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="skW607bZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZRpR5rg"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0283B114016F;
	Mon, 30 Dec 2024 02:25:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Dec 2024 02:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735543522;
	 x=1735629922; bh=I4K0SWG2c63XU8MQfmQI1M6D34FLB01/DKy3vMpGPIw=; b=
	skW607bZcYjfdUECuq/rCxfSqkblw35FY4viXW+xGw8wWjmgcq7Ctcp1Qi+JNKQC
	mHG/C5A1ObnIszcNinch+C0Ems0zwKOxKYWqWUIsekCOar024XqotPPqGc2joBPM
	NIddaB+Pd2p+0CWkoBLYdd8oHA6Zj/Y0Vxt5pkhY1FrAVMhAJyy4Ke+FAxJBPLHP
	Lpjjs1fXwHtadrh9tZ6e4aF+8d9u+k6b9CvzgqOEh8VWSKjGdYy2Tq1Kq2B27Tl/
	ELTRuYkrRFRbAuFP2OmBaCyOmgWmPusA79YoKusjK2XPuYO3/d2/JTJ7p02khDmf
	7yQvEXOxUg9Whf6Ifo0Glw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735543522; x=
	1735629922; bh=I4K0SWG2c63XU8MQfmQI1M6D34FLB01/DKy3vMpGPIw=; b=T
	ZRpR5rgDtBlM2chNkVys4XEYdL60r85xaJHRRtrmQ4QZc7Kok7wR0u+Exac2pi4w
	R5xEyBLl9MkTFwDqgVp2Lsu2Zyxw8YP+bFPU+JB25hBbx1a361ERQdNeXkm6s3mq
	sRnJNby5nCDdGuLV7tzjKZt4fE9ymbaZbCansV/58j7ahX7yx6VR8xyPG+Hl+xR7
	jKpoTRWXiq3TNGMxNNhC/vZVrIT5ewhntY+TM4FY1esArb5CSPs9upG6qAbXNlJp
	8SqAuUmD+sF1Euv4N/A/wMNS0DqRZKDeueZR8S+k56ONhFFT+tpVSnakMlINq0wA
	JZyA5mktqEM8g5F9m5/0Q==
X-ME-Sender: <xms:4kpyZyZRuHA7UzpajuhCQq1QDf8gJf_dfssO3-qHrH39JFDWbvFkfA>
    <xme:4kpyZ1bNYKLFNvHPN-waKXUFX2zMrQ8oRAeoW2kER66bgCgG2Xvb5g8kssohcdVwq
    9Ku6qW14Pi0hFuyzw>
X-ME-Received: <xmr:4kpyZ88JW_JfKyzP48m7U6WQ8cD6OELVZDJKEPnNVF5kdx7O11rXRXIa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:4kpyZ0qTSs2-TGA7IjiJl2CxsazujdY9IIdBhYxfIZu8G-rX6m12LQ>
    <xmx:4kpyZ9r2kJk5mmnU11htc_9cdhGoMznm5hmiHEwM124UOt6JMEEdSw>
    <xmx:4kpyZySTX77b9b9W6siOONaxz58cqAfWAKMCNZRL8bkTFoNl26JU_A>
    <xmx:4kpyZ9qPsTxVDLcTGBeUvOijAGlKRu1Msd0nktpZQpMNFwdJjHv8Ng>
    <xmx:4kpyZ0W5kWy7wvPoSI2GwgwcFXlxg5RlR1tFhqE7WuUfDGLju1C3LsJ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 02:25:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 152d24bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 07:25:11 +0000 (UTC)
Date: Mon, 30 Dec 2024 08:25:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] reftable: handle realloc error in parse_names()
Message-ID: <Z3JK1rBxcuMoiUmK@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
 <c2cd277b-ba9d-41cb-b9bd-c519b445d179@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2cd277b-ba9d-41cb-b9bd-c519b445d179@web.de>

On Sat, Dec 28, 2024 at 10:48:50AM +0100, René Scharfe wrote:
> Check the final reallocation for adding the terminating NULL and handle
> it just like those in the loop.  Simply use REFTABLE_ALLOC_GROW instead
> of keeping the REFTABLE_REALLOC_ARRAY call and adding code to preserve
> the original pointer value around it.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  reftable/basics.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/reftable/basics.c b/reftable/basics.c
> index cd6b39dbe9..fe2b83ff83 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -241,7 +241,8 @@ char **parse_names(char *buf, int size)
>  		p = next + 1;
>  	}
> 
> -	REFTABLE_REALLOC_ARRAY(names, names_len + 1);
> +	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap))
> +		goto err;
>  	names[names_len] = NULL;

Okay. We may be overallocating in some cases now, but it's most likely
that we can completely skip this allocation here because `names_cap` is
big enough already.

Patrick
