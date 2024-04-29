Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C26F53D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397940; cv=none; b=HmzCny+gz2LZ+eEROp+u6Rte1+Yp1YqwOG2GddCWNQ7YiucxXidZFfaWQO5xzJyMf3C/W5C1wv2qOGyPpGLUrnBGX2ckr2jB4Nel8R/ZiTjcz/4y0svOc+V2DFFZlK/LzUECePzJ+Xlu7ZRIJvOYBN2XlOlx3i4makJ5D6W75oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397940; c=relaxed/simple;
	bh=cQpcnrVgylBj14NZi/Js/gQoWKKfByrlgYOAglKB66I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADeAsTWVXgVb0CXKI9mRy9qS3nQkEby4Nr3+6kN3wWYhbTxuKQidWxYNelM4+LYgT/89YSHOyAptjcAKJaAQAknCp790HEdLvFvEgKtcfEp+McOgzix9BMt6RFAv2GOszZFetc5EO4twosdua3ftcqZPqvx7lVQebrO2im0Kck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFP+sFsz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFP+sFsz"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2de2f5ca076so50523141fa.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397937; x=1715002737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2kMTI8Lc9qN/1cPKdgQ9B0M6Q+BU9a4mNsTkefrFifc=;
        b=ZFP+sFszCBanz7q3RFgfIgx3OZ/9Ifkg77QIPooFmA95wJLnA4K7oYZHFZm39oPASC
         bic/mk0pO2vmcU3l46ZEvcE2Q0c3OiOsXyUOlxdSw/HTp0JXTLvHRh+j6ONzGaPwz9eH
         iPdv7t5pcCMRhdy0+fRi51kIj73wYBcGA49NDpAQk8DCqzfxBQtjlM2jwscKu7z4RufO
         Hysxa4bOkmONglp3zOvhuUNRwg1xfnYnbGWkU/dFUj8hF+LStfwIkijUF251kUVJ5UKa
         fRfS3x7Z5u9QlS55CDcNRHxuwRQjQ4WKFXWg7umL2T7o4GIgJamuHev01aZDMQH6rwyp
         cg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397937; x=1715002737;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kMTI8Lc9qN/1cPKdgQ9B0M6Q+BU9a4mNsTkefrFifc=;
        b=qL3Tj/DOkVvhgU57/sfm9O/g9tPOIhvZ6DyzgRmngmzDF8RJQz4H6Vk9CUs1sKWXWF
         Fq9T6+jWjfxQvrWkAnpGPZlSFrUfS69PdLnFQa93WB/hf8yGhlTEAmOW0zzbl28ZNl4E
         ZOXXybca6Rm2uf8TKuUa9glW0k2igYs0E6mhXb8A846OosKKgw8YLhTpd4ONAIrA+Fsc
         KOdrvNJWx6iq5zLgG3wnzZS4A0OeA1SRKy+9ve+PACgBIHGy7vpU6TYfuuHalhktPcob
         TbK+QzgTv0kHZU2gZcDV7ShytEivyaGeFTNHKAAaV1FKfhtMs6j7vIRtes/W8jrOPiJt
         nGLA==
X-Forwarded-Encrypted: i=1; AJvYcCUe8gcS/rNBmL+3vSatl+MrScMhryBNGhGKj9gFJ9GGJG6OLdwZMlvM0n2PsxJq5++lsGt8/XR0XYordH2d0egeuR2T
X-Gm-Message-State: AOJu0YxI8UxvKCRczMsqfJtynWD7ZD1AXJ00ZREv3RRagsXQWJ3A4p6h
	FrH8mxhxfv2yB8/EvNAeLW3cV3KMNigTPrtc0wa9bg/pBNMBS5B0
X-Google-Smtp-Source: AGHT+IGmJiWXGgFROS9wvcjSX4W3UiWMxSNZPyH7d7Q8Oky8yoR4oF1H2STqvjr9yJ05DYGJe+1RUA==
X-Received: by 2002:a2e:b052:0:b0:2df:b6dd:dc24 with SMTP id d18-20020a2eb052000000b002dfb6dddc24mr4025377ljl.8.1714397937054;
        Mon, 29 Apr 2024 06:38:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b0041bf87e702asm7491929wms.10.2024.04.29.06.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 06:38:56 -0700 (PDT)
Message-ID: <73632d75-b82d-4853-93fe-3460fdda3325@gmail.com>
Date: Mon, 29 Apr 2024 14:38:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240426152449.228860-2-knayak@gitlab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 26/04/2024 16:24, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> The `ref_transaction[_add]_update` functions obtain ref information and
> flags to create a `ref_update` and add it to the transaction at hand.
> 
> To extend symref support in transactions, we need to also accept the
> old and new ref targets and process it.

s/it/them/

> In this commit, let's add the

This commit adds?

> required parameters to the function and modify all call sites.
> 
> The two parameters added are `new_target` and `old_target`. The
> `new_target` is used to denote what the reference should point to when
> the transaction is applied.
> 
> The `old_target` denotes the value the reference must have before the
> update. Some functions allow this parameter to be NULL, meaning that the
> old value of the reference is not checked.
> 
> The handling logic of these parameters will be added in consequent
> commits as we add symref commands to the '--stdin' mode of
> 'git-update-ref'.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

Thanks for updating the documentation, I've left a couple of comments below

> diff --git a/refs.h b/refs.h
> index d278775e08..c792e13a64 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -648,6 +648,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>    *         before the update. A copy of this value is made in the
>    *         transaction.
>    *
> + *     new_target -- the target reference that the reference will be
> + *         update to point to.

s/update/updated/

> This takes precedence over new_oid when set.

I thought it was a bug to set both new_oid and new_target.

> If the reference is a regular reference, it will be
> + *         converted to a symbolic reference.
 > + *
> + *     old_target -- the reference that the reference must be pointing to.
> + *         Will only be taken into account when the reference is a symbolic
> + *         reference.

Does this last sentence mean it is not possible to assert that it is 
currently a symbolic reference? I thought the point of being able to 
specify the old value of a ref when updating was to ensure it hadn't 
changed since it was read. This contradicts the documentation in the 
next hunk and the description in the commit message.

>    *     flags -- flags affecting the update, passed to
>    *         update_ref_lock(). Possible flags: REF_NO_DEREF,
>    *         REF_FORCE_CREATE_REFLOG. See those constants for more
> @@ -713,7 +722,11 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>    * beforehand. The old value is checked after the lock is taken to
>    * prevent races. If the old value doesn't agree with old_oid, the
>    * whole transaction fails. If old_oid is NULL, then the previous
> - * value is not checked.
> + * value is not checked. If `old_target` is not NULL, treat the reference
> + * as a symbolic ref and validate that its target before the update is
> + * `old_target`. If the `new_target` is not NULL, then the reference
> + * will be updated to a symbolic ref which targets `new_target`.

This looks good and describes the behavior I'd expected to see.

Best Wishes

Phillip
