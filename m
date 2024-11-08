Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B07462
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028318; cv=none; b=JFzSssLmkSgwhcFZDZqoNvcaw9s0R0hLMZ0fr9MrLX49RyZYprmDQSaJj06eS1ndeCopF8r9ApuLE70Q9ho0N/g67utMABSMfpfjNXFZsE6e4Gq4c65JtZgmEgGQ/fwLE/OSkfapkP7Prhee11rjYsmxdf/XmCliRrOagMMYXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028318; c=relaxed/simple;
	bh=q9VwAODYum9flN98jI2SlIqP8fEcQfPYqNpy3Du+m7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz1P7arPlJF8ihjE/GKb045KTcFmL/jpzV0s3znpZgSyY5Ud5ktKJT/QFxFfX5tG9PUWquIGJpDduQvaJIWTALAMFUJlnPtyD4T5dZgiJ2GyhPvcYRw9ZUxyX95temvW7nguFP+lF83Q+Ob00l1Ame0f/dFMwpDw2a6mMLTRMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSEmHkpr; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSEmHkpr"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ebc0dbc65dso906136eaf.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 17:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731028316; x=1731633116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6a1UIekrixOCZ7mYyBNfGmZxP2MQ+kYOKue1d8exOhs=;
        b=VSEmHkpre1K1dHyW6se1Sgv6dqLfxT4nIRUh9OjpRCCchE3qL0EYCUBOVlBUs4t4Hg
         fEiZNv1ewNus7Gpq0cMIsVtfeAKDTKr5E9TPb//ycSV5nIhhLBzFsbZCxP8GZw4OBXVG
         vOC4WdDdPCj6BXQN3ciL6CebZdsx9schPhpihKYsYtmijwIXtHrrpsB0y7BS4xr6JLdc
         N2FF3x7zZvRSswld+Lt94bhh19HnCAxUTD/5uC8bSYS6Jn7sZs3SKdclZTmc6r1MA8ar
         r0n99bmumTkq50CaKVM95W4F9068o5YAe6bcgpi47p/VLnlrPqa5n5k2HIOIOGa9lw2i
         ei5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731028316; x=1731633116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a1UIekrixOCZ7mYyBNfGmZxP2MQ+kYOKue1d8exOhs=;
        b=SOGPVgbL6XsC89G7JCardq64VqEuJitOnKLvtZBZdEKhBhJC1wBEDjdB63hxgXnuDL
         29A1WZthNKyrsWwDRjOJh7TaHm63z8+tfwNa/rju5XTQqrwwSK/2iJlf1GUT8mpf8QJX
         kYr91hBi7UcHxT9I6FGRrbK7GLQCCMq4i2MrAcZXHFNlQk20v4P3Q8eXUg+7ZyHHc1UC
         OVGALzadHx+Stl4Cibghrb7HgweazKD2oVVeflQkbtH7+9y2HYAIv649BQ7GivT2Azg5
         7j9SUMN7MPI6RpYsjspP7aAXdnBXNEM/OA/Ft2xjPKgHkKpV+G3wSQiIdvBYipDXvdeO
         vmLg==
X-Gm-Message-State: AOJu0Yw1U/bxoth8/VgSTs3xRvlTW/nkwRkt+KkBVf1yTLXT0ml/zljY
	sZWZGQLUdQjj35AKAVnoNAMuz6BUtnP82rV+zAFR/qK8BzVqDLQy
X-Google-Smtp-Source: AGHT+IH2HF844LDT0P3mSsAWx9dUb+b4zA0tku9PP5CLdnm8SO9dWrgmz62mbPQ/yF7UBX9J6pSnhA==
X-Received: by 2002:a05:6820:8c8:b0:5eb:75a9:3aac with SMTP id 006d021491bc7-5ee57c61091mr1124355eaf.6.1731028315886;
        Thu, 07 Nov 2024 17:11:55 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb90csm501526eaf.2.2024.11.07.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:11:55 -0800 (PST)
Date: Thu, 7 Nov 2024 19:10:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 3/7] reftable/system: stop depending on "hash.h"
Message-ID: <hhlsmyyqt2y6ue3abnlwjmrmsslewwjcoiu44aadp6nqkscict@m55ip4ibqgoq>
References: <cover.1729677003.git.ps@pks.im>
 <b595668a5cdae0dff4a7271a3547c5821aa6e912.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b595668a5cdae0dff4a7271a3547c5821aa6e912.1729677003.git.ps@pks.im>

On 24/10/23 11:56AM, Patrick Steinhardt wrote:
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 3c6107c7ce5..7d86d920970 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -15,6 +15,7 @@
>  #include "../object.h"
>  #include "../path.h"
>  #include "../refs.h"
> +#include "../reftable/reftable-basics.h"
>  #include "../reftable/reftable-stack.h"
>  #include "../reftable/reftable-record.h"
>  #include "../reftable/reftable-error.h"
> @@ -289,7 +290,16 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  	refs->store_flags = store_flags;
>  	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
>  
> -	refs->write_options.hash_id = repo->hash_algo->format_id;
> +	switch (repo->hash_algo->format_id) {
> +	case GIT_SHA1_FORMAT_ID:
> +		refs->write_options.hash_id = REFTABLE_HASH_SHA1;
> +		break;
> +	case GIT_SHA256_FORMAT_ID:
> +		refs->write_options.hash_id = REFTABLE_HASH_SHA256;
> +		break;
> +	default:
> +		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
> +	}

Here we define the mapping between the Git's format ID and the reftable
hash external to the reftable library. This facilitates swapping uses of
`GIT_*_FORMAT_ID` to `REFTABLE_HASH_*` as done in the rest of the patch
which looks good.

>  	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
>  	refs->write_options.disable_auto_compact =
>  		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
[snip]
> diff --git a/reftable/merged.h b/reftable/merged.h
> index 89bd0c4b35b..13a5fe4154e 100644
> --- a/reftable/merged.h
> +++ b/reftable/merged.h
> @@ -10,11 +10,12 @@ license that can be found in the LICENSE file or at
>  #define MERGED_H
>  
>  #include "system.h"
> +#include "basics.h"

Naive question, being that "merged.h" only depends on
`reftable-basics.h:reftable_hash` and not any of the internal reftable
basics components, would it be best to instead reference it directly? Or
because "merged.h" is also internal do we also prefer to use the
internal "basics.h"? 

Probably doesn't really matter, but I was just curious if there was any
reasoning. :)

-Justin
