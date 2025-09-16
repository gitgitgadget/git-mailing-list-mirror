Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1338221FD2
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058268; cv=none; b=fGMbMX5w3T3ySgoBP1KuXVEuqYGVcJKv4dATmfXMcFrXY8RLRrZgzB+pMRPbKX1pImahzWVRJy/cSi86uC0xqHpxnnNGvUhfLtRYnRmO4+Ycu/6+G/KsLbu7IOlSYzfG8lAIq01kx4XJh9AewJmUMxm3EouFeESS89Y6yP6oBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058268; c=relaxed/simple;
	bh=P9Kb+VHJyK7AvguPgxJeljSBoug90yMY9k2ET108pwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsmMjSBCEsP8FkwwpHUAapJkdlgxH//RbL9mp07rTW4PHEqF+eF9Dnu6nTqn1mOfFLdaJpNakirXJF750E+RXKrF12KVErOcNgt+i9kTGUFuv3HnhU2D5NhZmcujSgaaXWxT3W+aHcnbra1PjWbu/m7VyGwzUPB8q7IEK4NSkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fumon/r1; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fumon/r1"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-62340cf6870so598815eaf.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758058265; x=1758663065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYcLcIaNIHpf70CSx0bKTYvL1yOa+OTWd7cWaMUXNjg=;
        b=fumon/r1SQZJ0ZW5S0ZwEqEI+7OYb3qEdBzTQddFMaTa6gCp4tISS+PxJdunw0w6wz
         qiLexwtNYExcU3DjsHs6Nn0bzrmevRds2EIPp6bX5Y2oSUh5tE2G+ldLONXtefA3yAOH
         8bTFm32FpWDwSbuL0Mk3xJ+pyX7JzmxFg0AWA70LISqA9CmBTHTtzE0Q6VIWUb+Jd8pN
         FavO2TjCY+QV5agyFdMIDt/09DZDLF/WwAEORUQ5D0v/RZo/7SWpJKi/Va8wxT33OlwO
         q0N2LRIYhQiX8FqxGolSlhg28YwV7XqV4GTYkvBBaKd2ZMjld+vyK+HkRzwux+At4hv0
         Z0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758058265; x=1758663065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYcLcIaNIHpf70CSx0bKTYvL1yOa+OTWd7cWaMUXNjg=;
        b=iZkh+NvpMghqcB6SOCMEFR5LKxtoqohZxqHmBnRqoCcTMnUSukPIo5K800MV5DYD3o
         2RN92SyZvhtkxN2XPPXnpVvSAEoSMCHnGLm0AjG19fe6zun610/iw4+ezDUCm8o8gOHX
         JYsXOJOcW1tnhw/n/DKsRqNFsIgADceuPANj6Of6sJyuP77dKnjYkuZsET+3mDlb+7fn
         /AY0C8GwsxzCbaQS2meyprgWh9t6CHIxg8mCRa3sZlaG3ZIfQSdBC9aTZocBCV3+b4kU
         IZpfZHcHYck7DDBh9QhlwSKDlAeDCbL8UyA3/OcO6zk5x1iM4swG1X9EeKOsXCnqMe4E
         4OjA==
X-Gm-Message-State: AOJu0YxNpNnns5jdm5DERc/BkUTmPW/EIDLEcgf4g2Hvj5h/xEqbVcuv
	1shVzq4jocniSLB9Sf0xEpfoIeZkdo2ZzKJ8boseVt8ZgNQggxfsPXZIOlBi0Q==
X-Gm-Gg: ASbGncuwG86SwpKmgTBijchD5IddymRFSjSKj4jiPfDhklBPctbRLa1HzWn2qcOxyej
	8klm4uV4481XwtF5OnIUrn/23Qx7VqYmrjCyBOoIDqdrhWV5OSCh25QyU6QrETLSF/VAYsQaHjB
	yeA/VE1Px/FWaaeg1nwA5lMNors8ybCJIZfUcchi+dZ+VygrkY+4e27rZXy2ofzEaWs8oHmsHIg
	6JWJH78QTx8Rc7s3jCfuFGvdg2OSmSSf85nRgc1XKFf/EbFfTe8qED2AvAfuXI5JQNwZjKr5FMz
	lQyXrVRRN4KDwuUXARVLv24Yu3LxDtFh7kSCkyCSJZT/seRxcxdOua+GLPyRWe8eHb3HS+6H+5A
	ONgx29evm03WOymyE
X-Google-Smtp-Source: AGHT+IGtAekYYiOxtWVLjbYtCjy+oqJBSX8uWzf7mg21QCcQzFKGlpliG7DSpdPVC3Z3EzEeqtSkbg==
X-Received: by 2002:a05:6870:9a25:b0:31d:7326:c3a7 with SMTP id 586e51a60fabf-32e564d42f1mr9543575fac.41.1758058265282;
        Tue, 16 Sep 2025 14:31:05 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-75249e44c95sm4400193a34.18.2025.09.16.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:31:05 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:31:04 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 2/4] refs/files: use correct error type when lock
 exists
Message-ID: <672jdldtxegx4y3gdtcyrnsz5nsy4sh6pk76eftqrukwug3f3c@xwso5f4vukn5>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>

On 25/09/13 10:54PM, Karthik Nayak wrote:
> When fetching references into a repository, if a lock for a particular
> reference exists, then `lock_raw_ref()` throws:
> 
>     - REF_TRANSACTION_ERROR_CASE_CONFLICT: when there is a conflict
>     because transaction contains conflicting references while being on a

s/transaction/the transaction/

>     case-insensitive filesystem.
> 
>     - REF_TRANSACTION_ERROR_GENERIC: for all other errors.
> 
> The latter causes the entire set of batched updates to fail, even in
> case sensitive filessystems.

Ok so this issue isn't related to case-insensitive filesystems. The
issue is that now we use batch updated, a single pre-existing lockfile
causes the entire transaction to fail. Prior to batch updates, only the
individual update would fail, but wouldn't stop others.

> Instead, return a 'REF_TRANSACTION_ERROR_CREATE_EXISTS' error. This
> allows batched updates to reject the individual update which conflicts
> with the existing file, while updating the rest of the references.

Make sense.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c | 20 +++++++++++++++++---
>  t/t5510-fetch.sh     | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 01df32904b..69e50a16db 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -797,9 +797,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);
> -			if (myerr == EEXIST && ignore_case &&
> -			    transaction_has_case_conflicting_update(transaction, update))
> -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
> +			if (myerr == EEXIST) {
> +				if (ignore_case &&
> +				    transaction_has_case_conflicting_update(transaction, update))
> +					/*
> +					 * In case-insensitive filesystems, ensure that conflicts within a
> +					 * given transaction are handled. Pre-existing refs on a
> +					 * case-insensitive system will be overridden without any issue.
> +					 */
> +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
> +				else
> +					/*
> +					 * Pre-existing case-conflicting reference locks should also be
> +					 * specially categorized to avoid failing all batched updates.
> +					 */
> +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;

IIUC, by returning a non-generic error here the individual reference
will be rejected during batch updates instead of aborting the
transaction.

-Justin
