Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4941FBC8E
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511834; cv=none; b=OBwC25OUzo/d2BJLMzxVH4muIfbhcAQf3O6wB98Fw+tq7fOwAkideSwt+bOnITkUAgdg6+uHTvU2LiwZPANMWUeXXY3yLOTZyndknR8PAox4p8jrGvs8p6o3NuIUeuCa2IQ5LqDk8ySHoAqEYeaBdqB6F3BWlKOBtTMjwiT1v08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511834; c=relaxed/simple;
	bh=G6ifXoTbNu0BRVvFpZKBExlNRnfI9r+wluXE4zMM2is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBfgIjDQ2rVB9ABJBI8aiJ2SuvpQOrS2rMlXC9UNrJScovcijj3H+vAoe9wBq/qmQM/nYcKQYaDpkZ66gcasjQa+FqBeBN5KI9ejMGu2ucmv2k90jFYFJFyKIRIzgWR2kxFMLl2JmJ68hzaal7v+amKZgOM1Bt+DIAhKCE88r/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWJJccXM; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWJJccXM"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4041b3c1fa1so581264fac.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768511832; x=1769116632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LErY8mh0DWJAELoyV8IVQxyXQiUoQ2hApMeqp6hTYGw=;
        b=nWJJccXMpyE3BnSeyU/aW1AB/RMjtStdjtiV4cDZV62EL7RflDXAXcoy2QJE+ZQzNz
         NWx/nzi93uIWIElsDneOHe9mmbFuvhxTnsdfGMn45PfxUlQDWa18eAIgBAnEHrr14zvZ
         RY+OtFwe1gxaoo2gyexcF8Iy5cUNY1xa5lPQj4GY2YmFj61U7YWTYotXTwcvHy0otOjd
         tnEb4kly8l3RmlifLZ9IP9jw/b2RGlOUeIIojK/d4fgPVo4+Qf90lRR+UfO7dZyU2y3c
         aRTEfJZo6iduPuctSRmgBLd4XUKcZYj+gMJZ9TqQ29aiwO5f+o1Kcj2LkLV5mC+RsEXY
         +wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511832; x=1769116632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LErY8mh0DWJAELoyV8IVQxyXQiUoQ2hApMeqp6hTYGw=;
        b=Z0eEIcnRewqChPAkOU7I6rgPILCyLM/EZg6JzWnvqKnV6oqrdRP4J4nubmJWo+vFgj
         zB7I6a7oIlqqCFT4/C9KIuau7fgvi8SnTtO+y3BOL9UjHpbArr/HSa4f7QFZcn+PJaN1
         BEZY5j+wn/dkWFcyNujktraW/lDvRmu54ZgrxHrG5eiJ4bmGRcT1uITsWXFYbPcQl/2F
         4YaFwbXEXdZFz5yGxmHCYag+opEXBYyhaZm5XUhDRS1rxuadD43B5tISXWDZSARwF0dG
         5d1nWGIs896leTK1t2TfMd/H9JWMYgVBgyiQ67s9Ivk2D7YXQNWZbDDDkqOFunnhWbRS
         AZEA==
X-Gm-Message-State: AOJu0YwpZllxQx2a/1V1J7ui2YoRVbu4oOb9ddHB6eCFQGEPAOd3zWPU
	1/kdzq98YVCTpnPCYBIbqu+kC2o/yBG4jvwJcxAvc+Ez7zeB8j4zC1uymMmLmQ==
X-Gm-Gg: AY/fxX4Hi4dM7dNLeg1M3UX8UnUDw64EfMnWaqlPEkVbqhkDfgzx9D4L5AtWngA5206
	T+CEQc0IRhqcRMS4BXIZ3rP6lfHYNRUS8PE/4t1243HWXIYZahEoaQODoyVVQ1C3vrBqgsHWgmB
	+h2b+oDsw/4UXF2F4l4oPFaQYC+eHjaMWnC+zA2CJiMaKJYLLzKjromGUrhniFCEWUPFQgoda82
	7uKaugjPyvMs+p+DIwzhKs11keH3gdOgyFu8DRfXamPxQu1hDwlaN2vqdxxRUW2KI8ZznFflqZq
	jACy+ICFbR+/pcw6r0FOc5AkBiOW4LppW6NrlvNgU4QucOJa53jbPMiBiC/GoIRMJGWOYw2YyjM
	iiRqxihvymUQ0VVOWx95/7Ij4tpWGNaOkHA8uT7bgXMDv2bfAnyMolfVNBS3yjpzMeUBLWAd1QY
	aNqWh1lsMGLM9F3ew=
X-Received: by 2002:a05:6870:5b8d:b0:404:35f0:5a9e with SMTP id 586e51a60fabf-4044cff93eamr430622fac.46.1768511831898;
        Thu, 15 Jan 2026 13:17:11 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5d62csm484431fac.19.2026.01.15.13.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:17:10 -0800 (PST)
Date: Thu, 15 Jan 2026 15:17:07 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] odb: introduce `odb_for_each_object()`
Message-ID: <aWlXu9ogFnv0GGBo@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> Introduce a new function `odb_for_each_object()` that knows to iterate
> through all objects part of a given object database. This function is
> essentially a simple wrapper around the object database sources.
> 
> Subsequent commits will adapt callers to use this new function.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 27 +++++++++++++++++++++++++++
>  odb.h | 17 +++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/odb.c b/odb.c
> index ac70b6a099..65f0447aa5 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -995,6 +995,33 @@ int odb_freshen_object(struct object_database *odb,
>  	return 0;
>  }
>  
> +int odb_for_each_object(struct object_database *odb,
> +			struct object_info *oi,
> +			odb_for_each_object_cb cb,
> +			void *cb_data,
> +			unsigned flags)
> +{
> +	int ret;
> +
> +	odb_prepare_alternates(odb);
> +	for (struct odb_source *source = odb->sources; source; source = source->next) {
> +		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
> +			continue;
> +
> +		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
> +			ret = odb_source_loose_for_each_object(source, oi, cb, cb_data, flags);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = packfile_store_for_each_object(source->packfiles, oi, cb, cb_data, flags);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Ok, I think I understand a bit more clearly now. As implemented here,
odb_for_each_object() iterates across each the objects (loose and
packed) in each source. Object iteration is not handled transparently
for each source yet though and we still explicitly iterate both loose
and packed objects. If I understand correctly, this current
implementation will become specific to the "files" backend/source in the
future.

-Justin
