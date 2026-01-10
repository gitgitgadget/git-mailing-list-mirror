Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E6E2737FC
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768050740; cv=none; b=LNs5pB7VXZVEWt/dvg9Z3JBiSynrUI27+lfRhOb05y2nWoX7CJK6HlYMl440e8c/bmJHLhDrXcYUUerwYJj67FzmMAQ6DwkJCnJOlSIVTsxzPOZ073NumD9IjcEcxNIEyg5NzAA/I18JiFO5fTSsU1bPXiY+fG27epuc1eIiREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768050740; c=relaxed/simple;
	bh=9hRvn+tT0oGzm9DP/TMn+nJ6caJmZmEiISEH01tKUhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgAevx9D3EgsrMCf26wpynF2aS85O8cMFunm3B22FAO9zjJay5hv8HfAQcAEOtiHQJT5ik+ykaXCSrRD++C/IXiSKz2s1mwAENaW8tuOPuhRMUFVH02UAnFTq6XMM2EF88nmY4pYBVLL/aYI5Mdg1WIZdsintW0LReh8uyuYnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evF+M4X+; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evF+M4X+"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11df4458a85so4443843c88.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768050739; x=1768655539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8hcq1yqtS8l7YuhjCiUweTUNsnKWjQoRAnd8JPea9g=;
        b=evF+M4X+4o2z2j9LonqoPmd0/Z2/Gr3cui1qz3FynbQBWhInFkNdcJW816mWQvlthU
         yj+0UJ9It7jJqqnuVz1WtG1ufu8Twi+owaxheffEJVTnygoY1NaQE4tdnvq/IK84A9AK
         g4ZT1PLqzxQOCdkunhuUvnTnLCYZ3OliVX6r+uaoBfhxJ4vyjS1Hn7IwgXmN5lgrR4EK
         IoQf3KzT55tzaGosbBJyntW180peCP1/VC74zSzp8dUHdr8IeIbXCcvasj6nRy0szQa+
         SdJ08bDVHerRZr+Y5Qn3Fjw80o3a2neVy8NJPyTyRJRt5UINrM9aOo2UQrvI2BVyuYli
         DjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768050739; x=1768655539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8hcq1yqtS8l7YuhjCiUweTUNsnKWjQoRAnd8JPea9g=;
        b=aLfTrDmhU7Wrx0yaW1bsrEeahIlGPz3eSPLLIrk3NDC5RgFyr1l3tdXz02orE1jzek
         3zjLnHze1coYrXTNfUULZm4+GM3KMuDIuLBVbwjDcTBH05mEUAAjFpzCWwt94xLsqCL9
         /AAuqGoVDRNG4qxbnPBdDUn2mwoRdaA0pnj8xuFhOoXwpwW01ecHAsOQ75LuxnRJSlkw
         h9ketvNI0kCtlbDGd7OIMyVd6ToJJOYZA6M/+N1l1xrlBS2su2L9AYg8Sq0kFMSlOD5U
         h2kzcvOsHN3iwVvf+YQB8ED7V7RfjpU+nUdR+G8KRnL35PcweHTSgSW01eaWHwxXi4vt
         YGtg==
X-Gm-Message-State: AOJu0YzxTEPYgca/i90KnB7P4/IiL5o7lsAUYkxkz4WLlWIPEGg+V7YB
	SCdBc7deiiwVAlv+fFmY6QHQcEM9OOwBOPIC/wIm5E1CMByc0fQbIznY
X-Gm-Gg: AY/fxX5g5uF/fDdxApGnXMjeLtpoN/pfjSgHrDBQMWdPJ3dcKlevATqf3TyXO8ny2cu
	P+fPrdiOVHGnJ0Nb5uPXW5GHtTSzzjHOl9HjgpCUctir4n0lwD7EAZ0U9aGq7UDPK2EqgbqaGnI
	uZmp/DUHPi2df0WWwnfBi1T+0jkm4ES03SpVngIiJZKZ9qn4h87MG60iiHAUQSUzKJYBlirAbsF
	29bxj8VXRBIM5ysm8qU1gekfiv1ZTj/ovzALDZzO7SZDbdzTRTEY3s9AG0CxE0Ciq3xxvoRCdDH
	+ognkYRqWW1L0tuwr812Rc+UtcnPSBq0IGZz4mJ6cbXL+qwbWhaO/WajUbM0Z37UYpBc3ifejvY
	hhvh9795nKboerRnsi8zuCDkqxnHY7NEsXzPrTTS9awEWl7ao+amjRUf/uY4vrrgV+mLn6xIm4h
	7zyudlWw==
X-Google-Smtp-Source: AGHT+IFBxyNNe2N6R5oZWmerYv49mJfFT+FJPYLXzx4Acex3ZK9lE/OSAMoAECnfhTtzLl0efHnW/A==
X-Received: by 2002:a05:7022:e07:b0:11b:9386:a3ce with SMTP id a92af1059eb24-121f8b6f5ccmr13223782c88.47.1768050738655;
        Sat, 10 Jan 2026 05:12:18 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm15528047c88.17.2026.01.10.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:12:17 -0800 (PST)
Date: Sat, 10 Jan 2026 21:12:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 10/17] refs/files: introduce function to perform normal
 ref checks
Message-ID: <aWJQL3WdZermrAUv@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-10-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-10-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:39PM +0100, Patrick Steinhardt wrote:
> In a subsequent commit we'll introduce new generic checks for direct
> refs. These checks will be independent of the actual backend.
> 
> Introduce a new function `refs_fsck_ref()` that will be used for this
> purpose. At the current point in time it's still empty, but it will get
> populated in a subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c               | 7 +++++++
>  refs.h               | 8 ++++++++
>  refs/files-backend.c | 2 ++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/refs.c b/refs.c
> index 739bf9fefc..4fc1317cb3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -320,6 +320,13 @@ int check_refname_format(const char *refname, int flags)
>  	return check_or_sanitize_refname(refname, flags, NULL);
>  }
>  
> +int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o UNUSED,
> +		  struct fsck_ref_report *report UNUSED,
> +		  const char *refname UNUSED, const struct object_id *oid UNUSED)
> +{
> +	return 0;
> +}
> +
>  int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
>  		     struct fsck_ref_report *report,
>  		     const char *refname UNUSED, const char *target)
> diff --git a/refs.h b/refs.h
> index d91fcb2d2f..61c56cca36 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -655,6 +655,14 @@ int check_refname_format(const char *refname, int flags);
>  
>  struct fsck_ref_report;
>  
> +/*
> + * Perform generic checks for a specific symref target. This function is
> + * expected to be called by the ref backends for every symbolic ref.
> + */

I think above comment is the same as `refs_fsck_symref`, I think we
should update to say that we perform generic checks for a ref instead of
a specific symref target.

Thanks,
Jialuo
