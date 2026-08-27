Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D7305665
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835715; cv=none; b=CzpCiAwIhjCckHBIhv+9L7FWGc3lST2J2GfH1V+XVoAc7bjXFGtDeNdSyAO2Jht1GWJ7jDZKeZrsgOR/G6kK9Yv2aTzzWvHZd+C1Lq/u5YNvN/wTWbF7MndY1fWkuDDzXAOLALjF9RXhA21zJ/itPOVULoJCJUdBC+m8Qofgs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835715; c=relaxed/simple;
	bh=yiTkE8pNygV7zy7C/auF7L7T4pcKVkmmBMuRFzgRJrw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ktz9j0ZtrUS417p09expZByVngXcTBpW7R1/5Ngb2+hfsKQS7EJkOyHLxRyWjplUWFzxTp6/xJ/TEngzW2RhjFmHTxCt3DaJaUNPG4sYGbG9/ecXjYgHxRp23sCF6bp80B8wi9RBTlTRM1OcN7rDpdh1dnTo+F14ixbJEQCYGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7QcLQTv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7QcLQTv"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so3607917a12.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787835696; x=1788440496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XnsSnAWLFoPG1WPEQ7q8Lyh15caJJHU7TGK9pVDIvuI=;
        b=l7QcLQTvJPwmQc5cuZGedFwBTSR60k/L3pMYq5l3Q3hHPIpXs2NgR0W0+K8GmQWYz/
         /WrjqlwbmJyGQRoN169pCr/deyG8wosHIzMjLXLB0tXMCKtkvt1b9YnkA3S+cQSMWA2H
         vQiGnqkmKIwpmWp45xtWS+k7XAOrSoL0pDjm07kNRBKykdKYSfWbjJo7zo47RzPX3pHm
         sQAGRxtheyYo0Pwo2l6sKYwfWIwywL7v6nnOOC8Kb72fzSKKymmFoRH9jiSH9jfPQFhv
         xo0TmVuS4axCFfKWY220bLck00fGR7mnE0B1d7xq0ZaSg6Z1I6kuMWXIePKy3EzurjvG
         14vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787835696; x=1788440496;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XnsSnAWLFoPG1WPEQ7q8Lyh15caJJHU7TGK9pVDIvuI=;
        b=PMLGy36XgZ9VyZdJwznetoD9jHkqHSNkTf0O3Y1szoQc37f8CbeYPdbAYnZ3am54OP
         MGQtSTrxnhMvA1hFxLAQjrJ62yhI5d/3lR6jG114w18hV2+MLtfXnx8KPqapSKv7IuOG
         o5T28bhdNYA/EVStud1YJKM4yTaLqZRONKWQlWyyd0dc4pWndV8AkT//AYVmEdji4JTH
         rfLez945K6QhllHTzScV4Vv5VjS9FTKeMeT2povQFBRanwG5uodccvTZVvJCrzsp7IWC
         qeVRw4n52/DuRSdlGXHSldZIU4wURqsQXgMLebZC1L6oyS6B8XyXuv2y6oHli4pmaxbc
         76bg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3KfEyyR0rhQvsnBwuIrbkM9unuPnAe1KTNK8Jwt4u4UmNKX1iZfHMkWkUA5jqJMalFVM=@vger.kernel.org
X-Gm-Message-State: AFuF++kG/XDNFDyXbsvxowxqZWd+0H9oORfgbgcQcJb/G6U6g8tzDxaq
	mbXbdBakhZQUwm+wyqIwdjbXM0Z8H+FhNH5meHAhKzFYCxH0fdJ4GjTS
X-Gm-Gg: AR+sD12txBBTh7SukSil8iCZby8573hmAeCdfO68MUMvokupxhipsmCcb3DRPj65xAD
	1GnXmX5B//SqO7tPp8B/xD7v1UOshcCiztJ/Ns6HBDM3+k3gvKw/AGaybLar9JON9RgU2az4UX2
	kWVSnUJE/Ju5IT56x64qmpAUyJC6dZFvqndyUhje3Q0S8/jgYxHPUB4R/Q31ozPG4ZpPTm07tfW
	IYH3tbxIG2JVG7caoAKYYdZ+QH3F+eYs+4osYBKgbERjEtXYeQ/y5ZNLc8BYsfvo5v77x1L40nS
	+CPY7zy9jrtqsgF8/AailqPtJANkr2oMj2mWgRlTHAfth/mgCz9+F2eritAyQI/iNXPAtOKnOH4
	WXsJ1HxS65FjzOdh/GPkBn6gRiveyIwf+et/SGmqJpf2EuSttPSGKVb2vci3NaXDBlAR/V2yLei
	Hwkf0BdMVSCi/GWw99Wd4gY29as+X8RCOPwCpz3FSzRJjJyyxV5S3Ipp3f9/jLfuRE7hPXAZ2sq
	kct7dEbqIC1hqo48bXDdf+80AqMsiMSHQl7yOlXWw9RJtFyZAw=
X-Received: by 2002:a17:907:3e26:b0:c12:83c9:d41 with SMTP id a640c23a62f3a-c250c595aaamr1468649166b.12.1787835695273;
        Thu, 27 Aug 2026 06:01:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:8486:9ada:868f:4693? ([2a0a:ef40:17bb:9901:8486:9ada:868f:4693])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88ab65sm746162966b.37.2026.08.27.06.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:01:34 -0700 (PDT)
Message-ID: <ec6c3986-94ab-4692-a4c2-47569b77e9ca@gmail.com>
Date: Thu, 27 Aug 2026 14:01:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: teach autostash apply to report conflicts
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <b501b5fcd0b9dde65c1ce358e2f4014dfa340c37.1784993669.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <b501b5fcd0b9dde65c1ce358e2f4014dfa340c37.1784993669.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 25/07/2026 16:34, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a conflicted parameter to apply_save_autostash_oid() and
> apply_save_autostash_ref() so callers can learn whether applying the
> stash resulted in conflicts.  Thread the parameter through
> apply_autostash_ref() and update existing callers to pass NULL.

It would be nicer to use the return value to indicate 
success/error/conflicts rather than adding yet another parameter. Apart 
from that this looks good.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   builtin/checkout.c |  3 ++-
>   builtin/commit.c   |  2 +-
>   builtin/merge.c    |  6 +++---
>   sequencer.c        | 29 +++++++++++++++++++----------
>   sequencer.h        |  3 ++-
>   5 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index aee84ca897..72aafa4049 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1242,7 +1242,8 @@ static int switch_branches(const struct checkout_opts *opts,
>   					    new_branch_info->name,
>   					    "local",
>   					    stash_label_base,
> -					    autostash_msg.buf);
> +					    autostash_msg.buf,
> +					    NULL);
>   		}
>   		if (ret) {
>   			branch_info_release(&old_branch_info);
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 28f6174503..d678a81865 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1980,7 +1980,7 @@ int cmd_commit(int argc,
>   	}
>   
>   	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
> -			    NULL, NULL, NULL, NULL);
> +			    NULL, NULL, NULL, NULL, NULL);
>   
>   cleanup:
>   	free_commit_extra_headers(extra);
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 5b46a596f0..cecb8fb716 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -538,7 +538,7 @@ static void finish(struct commit *head_commit,
>   
>   	if (new_head)
>   		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
> -				    NULL, NULL, NULL, NULL);
> +				    NULL, NULL, NULL, NULL, NULL);
>   	strbuf_release(&reflog_message);
>   }
>   
> @@ -1680,7 +1680,7 @@ int cmd_merge(int argc,
>   					  &commit->object.oid,
>   					  overwrite_ignore)) {
>   			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
> -					    NULL, NULL, NULL, NULL);
> +					    NULL, NULL, NULL, NULL, NULL);
>   			ret = 1;
>   			goto done;
>   		}
> @@ -1844,7 +1844,7 @@ int cmd_merge(int argc,
>   			fprintf(stderr, _("Merge with strategy %s failed.\n"),
>   				use_strategies[0]->name);
>   		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH",
> -				    NULL, NULL, NULL, NULL);
> +				    NULL, NULL, NULL, NULL, NULL);
>   		ret = 2;
>   		goto done;
>   	} else if (best_strategy == wt_strategy)
> diff --git a/sequencer.c b/sequencer.c
> index 1355a99a09..91a70e39a1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4748,7 +4748,8 @@ void create_autostash_ref(struct repository *r, const char *refname,
>   static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>   				    const char *label_ours, const char *label_theirs,
>   				    const char *label_base,
> -				    const char *stash_msg)
> +				    const char *stash_msg,
> +				    bool *conflicted)
>   {
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	int ret = 0;
> @@ -4783,14 +4784,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>   		strvec_push(&store.args, stash_oid);
>   		if (run_command(&store))
>   			ret = error(_("cannot store %s"), stash_oid);
> -		else if (attempt_apply)
> +		else if (attempt_apply) {
> +			if (conflicted)
> +				*conflicted = true;
>   			fprintf(stderr,
>   				_("Your local changes are stashed, however applying them\n"
>   				  "resulted in conflicts.  You can either resolve the conflicts\n"
>   				  "and then discard the stash with \"git stash drop\", or, if you\n"
>   				  "do not want to resolve them now, run \"git reset --hard\" and\n"
>   				  "apply the local changes later by running \"git stash pop\".\n"));
> -		else
> +		} else
>   			fprintf(stderr,
>   				_("Autostash exists; creating a new stash entry.\n"
>   				  "Your changes are safe in the stash.\n"
> @@ -4814,7 +4817,7 @@ static int apply_save_autostash(const char *path, int attempt_apply)
>   	strbuf_trim(&stash_oid);
>   
>   	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
> -				      NULL, NULL, NULL, NULL);
> +				      NULL, NULL, NULL, NULL, NULL);
>   
>   	unlink(path);
>   	strbuf_release(&stash_oid);
> @@ -4833,19 +4836,24 @@ int apply_autostash(const char *path)
>   
>   int apply_autostash_oid(const char *stash_oid)
>   {
> -	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
> +	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL,
> +				       NULL);
>   }
>   
>   static int apply_save_autostash_ref(struct repository *r, const char *refname,
>   				    int attempt_apply,
>   				    const char *label_ours, const char *label_theirs,
>   				    const char *label_base,
> -				    const char *stash_msg)
> +				    const char *stash_msg,
> +				    bool *conflicted)
>   {
>   	struct object_id stash_oid;
>   	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
>   	int flag, ret;
>   
> +	if (conflicted)
> +		*conflicted = false;
> +
>   	if (!refs_ref_exists(get_main_ref_store(r), refname))
>   		return 0;
>   
> @@ -4858,7 +4866,7 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
>   	oid_to_hex_r(stash_oid_hex, &stash_oid);
>   	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
>   				       label_ours, label_theirs, label_base,
> -				       stash_msg);
> +				       stash_msg, conflicted);
>   
>   	refs_delete_ref(get_main_ref_store(r), "", refname,
>   			&stash_oid, REF_NO_DEREF);
> @@ -4869,16 +4877,17 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
>   int save_autostash_ref(struct repository *r, const char *refname)
>   {
>   	return apply_save_autostash_ref(r, refname, 0,
> -					NULL, NULL, NULL, NULL);
> +					NULL, NULL, NULL, NULL, NULL);
>   }
>   
>   int apply_autostash_ref(struct repository *r, const char *refname,
>   			const char *label_ours, const char *label_theirs,
> -			const char *label_base, const char *stash_msg)
> +			const char *label_base, const char *stash_msg,
> +			bool *conflicted)
>   {
>   	return apply_save_autostash_ref(r, refname, 1,
>   					label_ours, label_theirs, label_base,
> -					stash_msg);
> +					stash_msg, conflicted);
>   }
>   
>   static int checkout_onto(struct repository *r, struct replay_opts *opts,
> diff --git a/sequencer.h b/sequencer.h
> index 64a9c7fb1b..b39528b6d0 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -237,7 +237,8 @@ int apply_autostash(const char *path);
>   int apply_autostash_oid(const char *stash_oid);
>   int apply_autostash_ref(struct repository *r, const char *refname,
>   			const char *label_ours, const char *label_theirs,
> -			const char *label_base, const char *stash_msg);
> +			const char *label_base, const char *stash_msg,
> +			bool *conflicted);
>   
>   #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>   #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)

