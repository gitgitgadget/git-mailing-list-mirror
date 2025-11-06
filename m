Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB1265CB2
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426839; cv=none; b=b69uXeICL2MICaA+28bs2G9ySdwPeDon/w7Y0Jf6PH5kZ4WULs0Uk0MWEX9ewLHZOx/bq4dgiUBHylwNhbuGI+UewfSzNGboHPjBoVqboO3h/jyKXb6Ah+OQWG/4b7+TOwCSr01/XGazOvzYoKn/3vKq7wQrqf8yANxkTG1ghw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426839; c=relaxed/simple;
	bh=1pSpL7iH4MwAFYRJCRtfJOOUlMpuBr0hxTmmN98O870=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l474eUXh6DbjkPyoAJrYKcK5IbIFsHPBO/ucLvvaE11qZ0dqWfa9GaLWZGEqtp6EZ1Sbp/AsuH9lAU17LXLC5KFLMqVwT61buXsMaX8zY8RNuL6uVMnj/ePkrf2kfGH6yOfkfYCLTWE27vZKvANvQyYVhTENr1fGgUAgCcNIEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMKTEJd1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMKTEJd1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47721743fd0so3671405e9.2
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762426836; x=1763031636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eAIFXzygh2ylJ6NKfiJJCFhJpaFYvxUermHUhhqI4iY=;
        b=BMKTEJd19CuZXlIRMvfScMvhcoVyt2ked45eUit4CXq1jZy3EQVYUusA8gfktIx1Jt
         chdOmJB+t/5LYvBLATu/wwDqv0PVj7hrBSiDsisL2eZrmD97bDYPLFiMNxb4ygUqJY8u
         0Bkycoo5g+J516Oqp+mRx2Hhr3vi24aQ36sm/ii0Xaaqdn7sOEKdyEN6SFWNsO1q34ae
         iW8J42dD2hpS50OIgREziYxLB02oDXYpLkUBOMg3ASogBcLx6Us4ILj7E2GFtB4BLxGy
         MfBSge7se61z3Y6d5tNymHmt3gQ9vN8PtyqruBBEaML1vmmSHSpmf6+fD/gdjmppogQK
         hpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426836; x=1763031636;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAIFXzygh2ylJ6NKfiJJCFhJpaFYvxUermHUhhqI4iY=;
        b=u+WisiFsma96N/Ye+MEZWhexA11OsuXHb/0SOK4VFIyNSiDY9IyKQ/74mvIgQCsPXT
         srOW6SkyqddaZIr4yuQn+zjrkEtg4fhimmfRwuhD2Niek+OfjnUpXNFGbyGZOAiCj5TC
         4D++U74DmwrGCMj5cnQNPlT0p+WZRreOhoH+dpRdr/R8W8f/+nYKeZF3Ofq10AM6Gfbg
         cm3jyZHXcvZricoq/2uWuP1zU3NvNDC1G9fdu0RU5Gy0KIFqmyKXCLVtjc/lzcphfzjz
         oFCNC7fpQjLg3ekaTR0B3cSxzcfCPnWrL2WD71VL6b3mkk2m1Zf5jo7oFoEep06ocgYF
         h5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdViVaFFdk9xwSGk7CFuHUvb50oHXDAF+SjwXgPoMVYjDDF6OfKUkWv0axeBkMYs56nkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjQTuL7nwjMPHaOA9/xktvGNetCofh5xfbL/XwKy97FlENPNu
	Vu+2QzOAlKVqrPogF49l5RdlKPepDdl8R5XocCi4Md8t79dGRDMFCKvH
X-Gm-Gg: ASbGncvoZ5G0fsjZoflGq4vtwd7fDoDrHQPARDBC6c81up3d/zDr0cs4w5OvfN1APxL
	eYO25Nu9nFKtewPGOm19cfCA5+mv1IsR9dxATOdqEguzlfl0DL9zguspYo412exC0IuWb/3q0JA
	b4h++ZMR79OSlN+HlvFAE3RwwJNv04xMUbAGmqSL2gG6U2/OciyQ3p4dlB+u8wvHK3eliVe4Zkw
	Y/LNeUDDRNnUBVnvJXYOQUrb7ZardcV6YIEwn4b0uq9QmbYKJHag704IUUO+ZEPt7mbCymHJulr
	L8rdaB6QbgwM0+kW5a7O6oWxiTHFWvbkalj9+yNUQ4hl2DgNbVGDgUIL6fwYy69ujxiAMjjuWjF
	rsO7bKcsMp7RDfZ5SodzmQzkIw3P9T1Oe0Tj166PeZk1FS/5vpQbbNDKduVz6kChvCI5UGtLy3B
	DB8L3bSeHgk5lVkRyLeoqaDF0QMEh8G7Xaj19wB2d8EvFfl3rKp8PIxBcD2a+2WCbcAA==
X-Google-Smtp-Source: AGHT+IGLLmc2jWkDJEcb1wjrVTqttk/dKBPh+jwa3rtxWjOZbwGLW7rF+23HAH6Opt0XhBZJQP04ng==
X-Received: by 2002:a05:600c:3ba0:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47769829a5bmr7021035e9.26.1762426835672;
        Thu, 06 Nov 2025 03:00:35 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:7b5:6701:5a25:209b:be41:f23f? ([2a0a:ef40:7b5:6701:5a25:209b:be41:f23f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm101880065e9.7.2025.11.06.03.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:00:35 -0800 (PST)
Message-ID: <a66fb440-058e-4cd8-8971-9c320c0387e8@gmail.com>
Date: Thu, 6 Nov 2025 11:00:34 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/10] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <59054ea0cb65718dbac500d342bc960bdb5066c1.1761776388.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <59054ea0cb65718dbac500d342bc960bdb5066c1.1761776388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> The ha field is serving two different purposes, which makes the code
> harder to read. At first glance it looks like many places assume
> there could never be hash collisions between lines of the two input
> files. In reality, line_hash is used together with xdl_recmatch() to
> ensure correct comparisons of lines, even when collisions occur.
> 
> To make this clearer, the old ha field has been split:
>    * line_hash: The straightforward hash of a line, requiring no
>      additional context.
>    * minimal_perfect_hash: Not a new concept, but now a separate
>      field. It comes from the classifier's general-purpose hash table,
>      which assigns each line a unique and minimal hash across the two
>      files.

It would be nice to explain the differing types for the two fields in 
the commit message.
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 85e56021da..16236bd045 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -96,9 +96,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   	long hi;
>   	xdlclass_t *rcrec;
>   
> -	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
> +	hi = (long) XDL_HASHLONG(rec->line_hash, cf->hbits);

"hi" is only used as an array index so it might be nicer to change it to 
size_t and avoid this cast instead.

Thanks

Phillip

