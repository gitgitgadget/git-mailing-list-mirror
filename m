Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF322E173B
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161353; cv=none; b=duHp04NawYGWVCauwsGf207bpgBrNgjiWUIrH1ydi3NLm0Hyt9V4XzE54F+ybm86r1JlHjmCu+P0F0tfKclzjmwWnP59tZ/1l69HeBmPHz9U3VrPxbMdsjDZRKlWTao0JujPeEgoCSq09RlbGguCQh1NWrlkwIU86wSFXnZrXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161353; c=relaxed/simple;
	bh=yEG3IAObMQH8VWGZCoZQTyUdN7XBZ6j8M+QuC7S89iw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hJi7NfXyQRV3hew6qWEc5QDpPdQa8pbeuLpfzKOfEr7NpGhtGQ7XEuuHfMmLHeb7MUFQaYNdBJ7eQlj02/59YY000AAor+OQU3zDMDIqOj8SYivrjjm8TiO8+lRqpkFPxRjNyjywT40gDgbTX/lvUqdkfttQlBwKTyNJ8ypYCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N294U+sS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N294U+sS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488c21c636dso32296815e9.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776161351; x=1776766151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaG8WFK1CKR5gZsSfjToOc8e/swMxkCXruHmVaE7sk8=;
        b=N294U+sSrsRqU11IHNyCcpPbIGmroz7yomrf7W6I2l0/wIUg2D2JEYlU/Wh0+t/qW6
         4NdxLw4JMeHxz83xglyJntelEBEgNf+XHN4hZc2+eWIOpAIN5674TR2/ES8h70NnoBx2
         gnq69mADeujOUMvzMahmJl06vR80EoeXpx4h5QnZTvxSXm5PopkqKqzeZO3rExbpKszR
         zaIir78DeCtch6IAfTHrh61eEGTViG8abDvr3nAHiyODed1sgTHF3dH9ePVKHBHtQsMU
         b/YRoaiphs2bzTi0piaVJhaTtDhmkJK5LCTO1zCIjrd2Av3Vj9tICxGfHPgsGfvwjAbn
         vnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161351; x=1776766151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaG8WFK1CKR5gZsSfjToOc8e/swMxkCXruHmVaE7sk8=;
        b=rrDKbT6fdL+cqKQ6mb9o3O91gLXpxBMukbBG3rofysrm8D7R2sr5uqiN3tSjDH7ei+
         O2HUwrY/TYVQeEChKcaINjIWoQnFcZd7rt+6sePGdmOsab4ux5veHROD06a1jBmMu036
         lXKc4jLn1OFtwrOSIdKIPXdP6m34dmLudVa1Ol7/pGvsyn4/jLq9pkDW3nAo3nptC3Wk
         bjF9gs4ihHEZr1gzo3cT/NhMC7kKQCBtY0Yt9oz7My9AVyQ3fVVXMPAVWv4rrawPz4J2
         +Jf0QEaOqq2MZUYy3rcyxT5iWctNI1IXYNtDqFZlJRJyzcebXrITBmobswUcGxPxvI9G
         ccnA==
X-Forwarded-Encrypted: i=1; AFNElJ+SDFxVWY/Af/bzXnHzKKar/Gp/WbwY0yW8vKVcoZUJqy59ps30j8Fo+lax2EHnN625Fus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OSzipM7QwrgSHeJjhuo32Ec/WOayHCGc2TVcyuUHBuVKzN50
	n3pkrjBDMA67uuw5yRI1OVs2ZoZdLY1UtvqMi0xa9G0Tzd3cQlFI30qU
X-Gm-Gg: AeBDietOEPKkBAXA0vnYDrVqneFlpnEMRHl3oFoxSda1Kj3xWdYquCHLJdqg1uPOCJk
	gDalYtJpQH2qp5ygynqG4hF0fJX7wX+3disfrLtbgCczNEwEsqvk8QqO2D13JD28+yyfGSO1UKR
	Q9hvfSk9+KHsl9yBfXeuw6R6Z3/svUN560uoYGc3NujQI2RnBRX/0AVM13yQ+jXVtAN/DASD7Tm
	odQFPmMuPsfyGEwb5Y+8XXparkBLZjC68FD5KgSK5A1HHv7zQn4P2tkQiNVlWuNOu+BENId2acG
	Afn2UnjBY/a0B3CF6HPo6Ur59H/TkV7oU1DY79lUnsykiwBii4YRElZnE9b7wZK9Hv6+JX4Eedx
	GHhN5niqqrJjAV5rRdI22+Rrcf0p2Z9fJ7nFpxjgw5Z8YXmVM8WjE+Gz7sq8DHP89mhsV5hDpiG
	mTfBcaVde/ya7Z6QbfbhLnl6AdFikaRisfE14qPfrF9ywxaa017rRt3Anqzpw8pMMo4mNaEsg9V
	OHr+Y3P
X-Received: by 2002:a05:6000:2301:b0:43d:e31:68d1 with SMTP id ffacd0b85a97d-43d6428e2damr25207745f8f.21.1776161350565;
        Tue, 14 Apr 2026 03:09:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:b886:6d6:9111:f662? ([2a0a:ef40:7d8:fa01:b886:6d6:9111:f662])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ea5f26274sm5283598f8f.1.2026.04.14.03.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:09:10 -0700 (PDT)
Message-ID: <d88af7e1-e8dd-4423-9c6c-977e1f1dc074@gmail.com>
Date: Tue, 14 Apr 2026 11:09:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/6] xdiff/xdl_cleanup_records: make limits more clear
Reply-To: phillip.wood@dunelm.org.uk
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
 <fec2b0f38ae30deceda104ec140fa4d404324103.1775679988.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <fec2b0f38ae30deceda104ec140fa4d404324103.1775679988.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2026 21:26, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Make the handling of per-file limits and the minimal-case clearer.
>    * Use explicit per-file limit variables (mlim1, mlim2) and initialize
>      them.
>    * The additional condition `!need_min` is redudant now, remove it.
> Best viewed with --color-words.

This still suffers from double evaluation in XDL_MIN(), perhaps we
could do something like the diff below instead?

Thanks

Phillip

---- 8< ----
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 386668a92d7..bde3cc7f3e5 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -290,22 +290,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
  	/*
  	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
  	 */
-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
+	if (need_min) {
+		mlim = PTRDIFF_MAX;
+	} else {
+		mlim = xdl_bogosqrt((uint64_t)xdf1->nrec);
+		if (mlim > XDL_MAX_EQLIMIT)
+			mlim = XDL_MAX_EQLIMIT;
+	}
  	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
  		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
  		rcrec = cf->rcrecs[mph1];
  		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action1[i] = (nm == 0) ? DISCARD: nm >= mlim ? INVESTIGATE: KEEP;
  	}

-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
-		mlim = XDL_MAX_EQLIMIT;
+	if (!need_min) {
+		mlim = xdl_bogosqrt((uint64_t)xdf2->nrec);
+		if (mlim > XDL_MAX_EQLIMIT)
+			mlim = XDL_MAX_EQLIMIT;
+	}
  	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
  		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
  		rcrec = cf->rcrecs[mph2];
  		nm = rcrec ? rcrec->len1 : 0;
-		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
+		action2[i] = (nm == 0) ? DISCARD: nm >= mlim ? INVESTIGATE: KEEP;
  	}

  	/*
---- >8 ----

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xprepare.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 386668a92d..bd8baf214d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
>    * might be potentially discarded if they appear in a run of discardable.
>    */
>   static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> -	ptrdiff_t i, nm, mlim;
> +	ptrdiff_t i, nm, mlim1, mlim2;
>   	xdlclass_t *rcrec;
>   	uint8_t *action1 = NULL, *action2 = NULL;
>   	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> @@ -287,25 +287,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   		goto cleanup;
>   	}
>   
> +	if (need_min) {
> +		/* i.e. infinity */
> +		mlim1 = PTRDIFF_MAX;
> +		mlim2 = PTRDIFF_MAX;
> +	} else {
> +		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
> +		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
> +	}
> +
>   	/*
>   	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>   	 */
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>   		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>   		rcrec = cf->rcrecs[mph1];
>   		nm = rcrec ? rcrec->len2 : 0;
> -		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> +		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
>   	}
>   
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>   		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>   		rcrec = cf->rcrecs[mph2];
>   		nm = rcrec ? rcrec->len1 : 0;
> -		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> +		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
>   	}
>   
>   	/*

