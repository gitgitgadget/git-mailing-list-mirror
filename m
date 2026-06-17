Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28858363C40
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718188; cv=none; b=MLsLG0fJjqvtcGf9KkDkE7ezV9SEG3t+3htknaso1CrLm94t0ajQqF+hTknB9dYo/D/rFUUYqmN0wxOaAIbvNCjQZCinwkzxKq1GELOo6UFD2u7C87/eGzoTBxZNLRl+ejELkLvnnUz6NLFmlQpjtFOibruyTRHaU7EjjgV0jy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718188; c=relaxed/simple;
	bh=RDWe9bfyNMjaVGrM+e2rOXv4jk/Upn4g4oq6rRbz1sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGQ6dgM1DVcCerYf8B8I79Ix/2+TSuIVZr7wvhmo+uwcQoFsm22TpZmRcJ1sIpL/I9MsBVBqZoDw2z/N1DW1V2geAjtW4hL4XleJWqYRU7bm8gFtYmR92EkhGr2ZNwYSPswTsV7MYK9jFb2QaC27fs5Nt/zFq4LD1HKNORw/i+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6IuC7Wx; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6IuC7Wx"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6cfdc8382so12236a34.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781718186; x=1782322986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ax7rdxY4AfG/Tdm2hF5K50U+pMv3XhPv/ZdKGQzUSUM=;
        b=o6IuC7WxBj/GCEHrd49DJmT/2niaMAwm7UwshfXJnlDjdZl1u2AVjPbJAOyDt9qmHM
         7p2PKN50CebVxi0+qZy0FIqKBwAgvaKjMPmpjmGsUcY1vy4iFF2S0a2HqTe3VQ5XtUZu
         sP0HECmJ1aJdm738t2jDebEAs2YoWyADj9zM0IFUZWtRzDjtqw34fypuTy6GMrFDNMtY
         yt56FINdGuDDjqhLAQLZkgjyKm8pToQWNzdIcgDu3piYccp/Cji3JwyPsQcdGOcwoiwz
         zShJVEUaE29u6s2CX4bcVAPQB0i2fsCg83z8NjWda0EKub5ko6fbwRsHiWCTA64tn/yW
         iPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781718186; x=1782322986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax7rdxY4AfG/Tdm2hF5K50U+pMv3XhPv/ZdKGQzUSUM=;
        b=cmKcBk/V887xDei6rwfzMIg4LeMb21cJ4HZ7W7/dzozkPK9yD1R/APgIifZw3/6jlI
         39ZEmX/3ajlam9M9LAhPd5DQCe+4kARA/n6tF1hHJITj3VJhNMdRoisD5S9c3MiOYFz/
         tct3PclMQwWdWunWE1ZNJJhb8z/mCrqaL43NKg43XE3GpnRv0xv4et1n+F2seiSu/fIu
         Bf0lFBwiRSarGoL9mq1TMIUY13tqx1UiMJYH99iGkASjlfls0PV+EenLDOwsirSqDosO
         zSmxaHRspI4rHoVEov1WlxoWvIszs27t6WjquT3PIcHMTcH+C0tLRHkoJJDlR+QvpFm7
         I4Vw==
X-Gm-Message-State: AOJu0Yy6aMaYIBPw8eLPtjYwBg0cYTiD4qqack93HoBDGSzbdfg+tLx9
	3fFDyHmDVAiqJYL9iSJBNVzzCVbepjHVxmNzj0KvEimqpRI8AzJl9WDGL9od+Q==
X-Gm-Gg: Acq92OEyIkz7Z5J+XH3LMVHQIa5ro7SnUTUbOt5CFjUTq0PTFpSbUbYasO2zZcj/+6t
	5Qpfx+zPgWevESXE7Bpthkx58is7ufDHET/ubbAQJDdCbJcV3q9K+g/aRoPVLBBGcNvX8sOGT/G
	j68JtTudvYPtAmOFe9ZSc/5m64d6gT3CVPnpcVxsucWexJVxtzN6wHa/Z8iVFUF8sSytfoU7kVO
	z6s2/kLw6tOE/625d10rAmJV4pbuZDoprlgDSH++GXEZpR2jnX84KfIIdcJM6Ti7bQyTnfN/dvn
	FmnUZbEZ37RmWYVL5KlE1HrN/tU15UdDOn53XCdNUgTDsMtJkE2yY59RCuZVxmfWnP/Il1NsmSh
	g72KEz5xQVtllZG9WPfWp7hW/LGGg1Ta5VM6W8Sv1+7ahbH9HLlAmYT2Q5f5yDCIHtG+4B4hFwp
	enE5GLig==
X-Received: by 2002:a05:6830:8296:b0:7dc:c338:d23d with SMTP id 46e09a7af769-7e90b38b774mr4626772a34.14.1781718185826;
        Wed, 17 Jun 2026 10:43:05 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb5fcsm10325077a34.9.2026.06.17.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:43:05 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:43:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/8] setup: don't apply "GIT_REFERENCE_BACKEND"
 without a repository
Message-ID: <ajLapsLze_zF-dsS@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-3-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-3-f4854aa99859@pks.im>

On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> When discovering a repository we eventually also apply the
> "GIT_REFERENCE_BACKEND" environment variable to the repository. There's
> two problems with that:
> 
>   - We do this unconditionally, which is rather pointless: we really
>     only have to configure the repository when we have found one.

I agree that configuring the repository reference format when there
isn't a repository to begin doesn't sound very useful.

>   - We have already applied the repository format at that point in time,
>     so we need to manually reapply it.
> 
> Move the logic around so that we only apply the environment variable
> when a repository was discovered. This also allows us to drop the
> explcit call to `repo_set_ref_storage_format()` because we now adjust
> the format before we apply it via `apply_repository_format()`.

Make sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -2023,6 +2022,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  	    startup_info->have_repository ||
>  	    /* GIT_DIR_EXPLICIT */
>  	    getenv(GIT_DIR_ENVIRONMENT)) {
> +		const char *ref_backend_uri;
> +
>  		if (!repo->gitdir) {
>  			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>  			if (!gitdir)
> @@ -2030,6 +2031,24 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  			setup_git_env_internal(repo, gitdir);
>  		}
>  
> +		/*
> +		 * The env variable should override the repository config
> +		 * for 'extensions.refStorage'.
> +		 */
> +		ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
> +		if (ref_backend_uri) {
> +			char *format;
> +
> +			free(repo_fmt.ref_storage_payload);
> +
> +			parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
> +			repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
> +			if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> +				die(_("unknown ref storage format: '%s'"), format);
> +
> +			free(format);
> +		}
> +
>  		if (startup_info->have_repository) {
>  			struct strbuf err = STRBUF_INIT;

Hmmm, we only invoke `apply_repository_format()` if we indeed have a
repository (having just GIT_DIR_ENVIRONMENT set isn't enough). Should we
instead nest this logic right above `apply_repository_format()` in the
same block?

-Justin
