Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84221F03DE
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336133; cv=none; b=m1hLw+X3a+2BZdY+bEUsCE82fTInm4NaXjf/vn2PSmni8J6DVofMK7evhVN4ko6v/phJg7GwzqCPAD5XhkHgoQNkhSWEYF+LGD0mJNgBplRnYQ36w717Hhxx/lA61UW6nf8NioYIRiohYDcFDasNcJMY+deLwALyZPvxpsv7lYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336133; c=relaxed/simple;
	bh=6xmURHX9iy4c0/zkOwJe2ZgYgJzVvDMlGJD9Oae2b0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASlKi82du5sh3zOeZi7G91zRXCZh2wmHgaqRA4FUZiFSi1zQOznh5bWGzg+dOlNO7fsSwLzFAMZRQB0DfkdQq8NORoI3pX09iuyAWlRHzeYLzE0e6T7qZpU73PmleNu72PMyMWgC+DG2iekf9vq0lhwoGv4lF+ZHs6hFlpPtb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtD3lD/C; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtD3lD/C"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-441b5b4af7aso862325fac.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782336131; x=1782940931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0CxvkDs/SLtqXlUyIpOIi2faPuCY/grDXrq/Rr/AtE=;
        b=mtD3lD/C/sYybRNCdeTWfXaAhewzEXDO/o+WcJ0kTa/3GKJ3AVzSxzANIKRTzChAZJ
         vOfH/hJHsuhlWxl32xRI5LuKrRjqLd6ndSlJlLAOP4iomL8vSwOcCGioUXARt3eVPL3z
         DJdHgzr5ktbdkeWb/u/jmnir8KPVUrAsUQEz9eravY/FwKivAb14SN6grdDL2G85adPr
         JzjEnKGPiih1g0Xgq6BYeD+lXIgsi7cnv9xSh8CJNj0/9ssQ7KeyZoSYUCFpDs3E9s0O
         AO6+iiwlVv4Lf5fEvb9L7AQPvwCtbfp/hXuDlk0dNqcfS6qO4k2F106oYaxCbmfS6gTN
         iO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336131; x=1782940931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0CxvkDs/SLtqXlUyIpOIi2faPuCY/grDXrq/Rr/AtE=;
        b=q2UX1eIkQpd95SdTquLaGv9BkHMGRlofb0ayy1JRTE76g+24Dc7qYBJEfNYfGPONP0
         /PxMDPO5lMmx9EQRzxRB4Dkircz5fr4amq80EAECgU6BKR2MqhZX3w3tj24LeT+qzHJu
         0U34XJFKTOqur5EW/AQDdrz2qY7ZKAspHDLZEu1yWLKFhGwLd3R4Tow/AUDv3f5najny
         vVLwlgRRCURd2ZQG3NrDEvhX22yMszQoPZcOZis07hNBAYKlm7+moJ+hY4CytDSVNOpr
         0AkMQWYGYdtYhgEJxw6UaWbB100oV1aCKUceK/AOdSZ0f+EI5EBvYuEsDqG8D6UBaOQ0
         MvOw==
X-Gm-Message-State: AOJu0Yz8Y3RL5usszxQtXB2aGS8MMexnUEYDDOWaMZ+UPmVfjs1uG2Qh
	n9xm7cbT3blyBVT/UxxJ1cUSGdnGYVZiq5osfvfc0ymh8zTx2JPaYIvc
X-Gm-Gg: AfdE7ckoMiJr8b0f234a5IF7prYo5LHg2MUzWS35V7pdEpaWxfFXV4E+/960pFIZ5QW
	t65OyILBuNVi2Meff//9w9KbVwrkHrp1sfAzXM7DnF4ZlhnoLuQNMeATGCA9Qadb3BXyeA8vnzi
	x6MF511XX5GEqIdvx41yYee9h3khcXtxWEQAV1ndmLLOLqZ+TwMl38zn3kSBqhLAHplr31lgCLm
	+R8U68/sARSiceJV4ZC7kWkyRCTGCQIkNsQjeUAG7AlfDm2xVWmkPLhRmPHSRKH2iZX5uw7voF5
	q+eOxxrKklfY50RwtegAUCJ5NbZGx5YmbI3F42a+RgGT2dvTWmpoaJniPivt1FLteKDcU0l+k/g
	smnEhPHXTW8RCaJONDBS/tJsCosR7IPltrHbk7Jl8zUwSNWo7WvolPkLkXIY/JwhqtFJlpugJf8
	0gOcMTZA==
X-Received: by 2002:a05:6870:b3c5:b0:42c:49c7:a499 with SMTP id 586e51a60fabf-447b5ab199emr7044462fac.3.1782336130587;
        Wed, 24 Jun 2026 14:22:10 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-447ec359d9csm1745655fac.12.2026.06.24.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:22:10 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:22:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 07/11] refs: move parsing of "core.logAllRefUpdates"
 back into ref stores
Message-ID: <ajxEXMTBmii01dVP@denethor>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-7-018475013dbc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-7-018475013dbc@pks.im>

On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> In cc42c88945 (refs: extract out reflog config to generic layer,
> 2026-05-04) we have refactored how we parse "core.logAllRefUpdates" so
> that it happens in the generic layer. Unfortunately, this has worsened a
> preexisting issue where we may recurse when creating the reference store
> because of a chicken-and-egg problem between parsing the configuration
> and evaluating "onbranch" conditions.

Ok so IIUC, parsing "core.logAllRefUpdates" in the generic layer forces
us to read the config earlier. This is problematic though since the
refstore has not been initialized yet which we need to evaluate
"onbranch" conditions.

> Prepare for a fix by essentially reverting that change so that we handle
> this setting in the respective backends again. The backends are already
> parsing other configuration anyway, so by moving the logic back in there
> we can ensure that all backend configuration is parsed the same way.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/checkout.c      |  7 +++++--
>  refs.c                  | 10 +++++++++-
>  refs.h                  |  9 +++++++++
>  refs/files-backend.c    | 20 +++++++++++++++++---
>  refs/refs-internal.h    |  6 ------
>  refs/reftable-backend.c | 20 +++++++++++---------
>  repo-settings.c         | 16 ----------------
>  repo-settings.h         |  9 ---------
>  setup.c                 |  7 ++++++-
>  9 files changed, 57 insertions(+), 47 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index b78b3a1d16..aee84ca897 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -952,10 +952,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	const char *old_desc, *reflog_msg;
>  	if (opts->new_branch) {
>  		if (opts->new_orphan_branch) {
> -			enum log_refs_config log_all_ref_updates =
> -				repo_settings_get_log_all_ref_updates(the_repository);
> +			enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
> +			const char *value;
>  			char *refname;
>  
> +			if (!repo_config_get_string_tmp(the_repository, "core.logallrefupdates", &value))
> +				log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
> +
>  			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
>  			if (opts->new_branch_log &&
>  			    !should_autocreate_reflog(log_all_ref_updates, refname)) {
> diff --git a/refs.c b/refs.c
> index d3caa9a633..5b773b1c15 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1053,6 +1053,15 @@ static char *normalize_reflog_message(const char *msg)
>  	return strbuf_detach(&sb, NULL);
>  }
>  
> +enum log_refs_config refs_parse_log_all_ref_updates_config(const char *value)
> +{
> +	if (value && !strcasecmp(value, "always"))
> +		return LOG_REFS_ALWAYS;
> +	else if (git_config_bool("core.logallrefupdates", value))
> +		return LOG_REFS_NORMAL;
> +	return LOG_REFS_NONE;
> +}

This function replaces `repo_settings_get_log_all_ref_updates()`. I
assume we just wanted a slightly more simple function where the only
concern was parsing the `core.logallrefupdates` value.

> +
>  int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
>  			     const char *refname)
>  {
> @@ -2327,7 +2336,6 @@ static struct ref_store *ref_store_init(struct repository *repo,
>  	struct ref_store *refs;
>  	struct ref_store_init_options opts = {
>  		.access_flags = flags,
> -		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),

This config is no longer handled in the generic layer.

[snip]
> diff --git a/setup.c b/setup.c
> index 79125db565..0c6efb0560 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2584,10 +2584,15 @@ static int create_default_files(struct repository *repo,
>  	if (is_bare_repository())
>  		repo_config_set(repo, "core.bare", "true");
>  	else {
> +		const char *value;
> +
>  		repo_config_set(repo, "core.bare", "false");
> +
>  		/* allow template config file to override the default */
> -		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
> +		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value) ||
> +		    refs_parse_log_all_ref_updates_config(value) == LOG_REFS_UNSET)

Huh, can `refs_parse_log_all_ref_updates_config()` even return
LOG_REFS_UNSET?

-Justin
