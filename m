Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B0274B21
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718746; cv=none; b=ezenmIz2ibrlv7n8JzD6vmDly6pzSvVyUtD4nuut6jy67fEC8f2Vtx2c8iscSahpLzkXAdQ2EDeXN48C42q3D0d4JF444VUofGFs1t7YzpD7boJnTMIcycXfbi48IRnDYogLtdiU2GYQxONMbRgjDZxeQS4M4euiF6FPvwpce4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718746; c=relaxed/simple;
	bh=SvDE2T6h9+Z4alJ2ekaaWeYPecl7eM4GktD5zEyTAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyvt6EOdrT1JljSwrYGqHmntnXUIAJji1Hf0KfUiEuBwPcOpkhdYnWzITaDlYAuLGUkFahxyBl67uD2onsxhxknfn7/aLyyfrwlmtL1HaKfYYfbCJTLknKBo85g5Ldh31OJCJLVvtYJDFRYkTeq7WQVjcrF1GyRSccHYs/uT6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE909You; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE909You"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73ff32d8b8aso867196a34.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753718743; x=1754323543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdG/dH70htPQMK/lVQL9ORNPnX2IoCavajcr/rYYvNg=;
        b=nE909You817ZNm5ynxovmFCU5g5WFyCeGVgZ69tv9d+ff0bVRRIRKIyqQmUz7xb9Ly
         ETzt8VqeqS4Mex3xLINSst25YEBQWcFYRSx3bdjQLljhFUWGoGRisS3HOw0qkb64NHx3
         B1qVI1S6C6xYwASZHr7kEloVIo1EhWBWRyvZfagrr9S1UyY0blCjQYyoqcdq27Zm2LtH
         jfb1RkYBUI9UolKtLRWevFQCGGNAeMCEIIANTELCB51hLrvxyBaMdzj514lIysVLIGDH
         3XehFr8PqEZkT7OhsAHSaLqcR3uq+wZSV2PitM//Win1ijQjqPTy76PKWlbAupPhULol
         FUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718743; x=1754323543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdG/dH70htPQMK/lVQL9ORNPnX2IoCavajcr/rYYvNg=;
        b=SrdKqu5nYmjIFnbh7GzdQY1xkzq4Z8yFi7Bg0GfzOqZ3q6NUWRklbqPlR2r8/Z1lDX
         M7E/e9MguS6M5J+7X6sV69ooGNlMHri1RYSBL/cLQ/IFd57oNtauyJ34Q5OQkRc1FTOa
         RvvjAu/BnKWiqFvldBePGQWYrelRxEUWNDg40pjv/dZvixwGfPYMgbVwk5K3JQlB++GG
         FKlx+XmkeS6unBPrp9awXTW/R00Lk0aSZeWZjKbo/K2v+UTWHbvGnrjr8c4+qLy9DIjg
         mOOykwVyW5dDiEL/fFvMSpeTrGgf74Go4KhY1UQJWARoHNheEWzioZORotiXAWd9YWbs
         +FhA==
X-Gm-Message-State: AOJu0YyxKLifIQyXsRJK2n84IvotazoC0x24OTxD8NY5DO4WR0ROS0GT
	Edgdx2VStiF8j2lFZnqUvr0mn+M+m66CTQKhl5JOqxOLFH64+7k3Wbbb
X-Gm-Gg: ASbGncsO9xIZPXC3ZX901QKSBzcOjUYtwTR/tr2Jiasmn3iu/f70m4vM+dVMOxKQ8gu
	r08B9DrKwak9VAwwKf0QidKUKrdou9aFLQz35N83MRpuZ+7jEKWsgaPlXQOKuH4br9mDcVNPNzS
	m93666Li9XvmeoTRGGF2MxtgJHn9l65ATDjOobY9rYRSVB5+XQ/GKP5LD5DtdwQMx70HFTvZgXf
	ooI7vXVr27qrmt80j0AiRnwIV8sh4I2FZSiVr8kuHOTR610Q3deS9eIhqetj5n+nXQH80ybsYeN
	pVp0hA2j38I2/cg9bZbcGeAXIG/q/ZByrUhGXl9Gr7Bva+pmCp6hM8jXArz0U1iNKVMu+1LS8XZ
	o4YVJecAUchd3h74=
X-Google-Smtp-Source: AGHT+IGgtenRIFsd8m5bNW0fHKdKZ6TJ6E1LRjPNQcZZJHHfCpZ006PaJBO2UNJwAmlmmf/f2ACVRQ==
X-Received: by 2002:a05:6830:60cc:10b0:73c:d14a:cb0 with SMTP id 46e09a7af769-7413dd382c1mr4751396a34.6.1753718742966;
        Mon, 28 Jul 2025 09:05:42 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-74148275574sm1077460a34.57.2025.07.28.09.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:05:42 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:59:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 1/4] refs: pass refname when invoking reflog entry
 callback
Message-ID: <vo4s7oj3ypcfnjgky6zlt3zjgqlwqzorvsmac55uajugafnrde@yzb3c4kwbk77>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>

On 25/07/28 03:08PM, Patrick Steinhardt wrote:
> With `refs_for_each_reflog_ent()` callers can iterate through all the
> reflog entries for a given reference. The callback that is being invoked
> for each such entry does not receive the name of the reference that we
> are currently iterating through. This isn't really a limiting factor, as
> callers can simply pass the name via the callback data.
> 
> But this layout sometimes does make for a bit of an awkward calling
> pattern. One example: when iterating through all reflogs, and for each
> reflog we iterate through all refnames, we have to do some extra book
> keeping to track which reference name we are currently yielding reflog
> entries for.

Making the reference name part of the callback signature seems
reasonable here. For the above mentioned example, it will certainly
simplify things quite a bit.

> Change the signature of the callback function so that the reference name
> of the reflog gets passed through to it. Adapt callers accordingly and
> start using the new parameter in trivial cases. The next commit will
> refactor the reference migration logic to make use of this parameter so
> that we can simplify its logic a bit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c            |  9 ++++-----
>  builtin/gc.c              |  3 ++-
>  builtin/stash.c           |  6 ++++--
>  commit.c                  |  3 ++-
>  object-name.c             |  3 ++-
>  reflog-walk.c             |  7 ++++---
>  reflog.c                  |  3 ++-
>  reflog.h                  |  3 ++-
>  refs.c                    | 19 +++++++++----------
>  refs.h                    |  1 +
>  refs/debug.c              |  5 +++--
>  refs/files-backend.c      | 15 +++++++++------
>  refs/reftable-backend.c   |  2 +-
>  remote.c                  |  6 ++++--
>  revision.c                |  3 ++-
>  t/helper/test-ref-store.c |  3 ++-
>  wt-status.c               |  6 ++++--
>  17 files changed, 57 insertions(+), 40 deletions(-)
> 
[snip]
> diff --git a/refs.h b/refs.h
> index 99b58d0b73c..a39f873b1fe 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -559,6 +559,7 @@ int refs_delete_reflog(struct ref_store *refs, const char *refname);
>   * functions.
>   */
>  typedef int each_reflog_ent_fn(
> +		const char *refname,

The callback function now propagates the reference name and each
reference backend is updated accordingly. This patch looks good.

>  		struct object_id *old_oid, struct object_id *new_oid,
>  		const char *committer, timestamp_t timestamp,
>  		int tz, const char *msg, void *cb_data);
> diff --git a/refs/debug.c b/refs/debug.c
> index 485e3079d7a..5e113db307a 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -276,7 +276,8 @@ struct debug_reflog {
>  	void *cb_data;
>  };
>  
> -static int debug_print_reflog_ent(struct object_id *old_oid,
> +static int debug_print_reflog_ent(const char *refname,
> +				  struct object_id *old_oid,
>  				  struct object_id *new_oid,
>  				  const char *committer, timestamp_t timestamp,
>  				  int tz, const char *msg, void *cb_data)
> @@ -291,7 +292,7 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
>  	if (new_oid)
>  		oid_to_hex_r(n, new_oid);
>  
> -	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
> +	ret = dbg->fn(refname, old_oid, new_oid, committer, timestamp, tz, msg,
>  		      dbg->cb_data);
>  	trace_printf_key(&trace_refs,
>  			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%.*s\"\n",
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3ebe0323d4e..24d0a8ebde0 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2109,7 +2109,9 @@ static int files_delete_reflog(struct ref_store *ref_store,
>  	return ret;
>  }
>  
> -static int show_one_reflog_ent(struct files_ref_store *refs, struct strbuf *sb,
> +static int show_one_reflog_ent(struct files_ref_store *refs,
> +			       const char *refname,
> +			       struct strbuf *sb,
>  			       each_reflog_ent_fn fn, void *cb_data)
>  {
>  	struct object_id ooid, noid;
> @@ -2136,7 +2138,7 @@ static int show_one_reflog_ent(struct files_ref_store *refs, struct strbuf *sb,
>  		message += 6;
>  	else
>  		message += 7;
> -	return fn(&ooid, &noid, p, timestamp, tz, message, cb_data);
> +	return fn(refname, &ooid, &noid, p, timestamp, tz, message, cb_data);
>  }
>  
>  static char *find_beginning_of_line(char *bob, char *scan)
> @@ -2220,7 +2222,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
>  				scanp = bp;
>  				endp = bp + 1;
> -				ret = show_one_reflog_ent(refs, &sb, fn, cb_data);
> +				ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
>  				strbuf_reset(&sb);
>  				if (ret)
>  					break;
> @@ -2232,7 +2234,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  				 * Process it, and we can end the loop.
>  				 */
>  				strbuf_splice(&sb, 0, 0, buf, endp - buf);
> -				ret = show_one_reflog_ent(refs, &sb, fn, cb_data);
> +				ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
>  				strbuf_reset(&sb);
>  				break;
>  			}
> @@ -2282,7 +2284,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
>  		return -1;
>  
>  	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
> -		ret = show_one_reflog_ent(refs, &sb, fn, cb_data);
> +		ret = show_one_reflog_ent(refs, refname, &sb, fn, cb_data);
>  	fclose(logfp);
>  	strbuf_release(&sb);
>  	return ret;
> @@ -3323,7 +3325,8 @@ struct expire_reflog_cb {
>  		     dry_run:1;
>  };
>  
> -static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
> +static int expire_reflog_ent(const char *refname UNUSED,
> +			     struct object_id *ooid, struct object_id *noid,
>  			     const char *email, timestamp_t timestamp, int tz,
>  			     const char *message, void *cb_data)
>  {
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 99fafd75ebe..25a1d516184 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2148,7 +2148,7 @@ static int yield_log_record(struct reftable_ref_store *refs,
>  
>  	full_committer = fmt_ident(log->value.update.name, log->value.update.email,
>  				   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
> -	return fn(&old_oid, &new_oid, full_committer,
> +	return fn(log->refname, &old_oid, &new_oid, full_committer,
>  		  log->value.update.time, log->value.update.tz_offset,
>  		  log->value.update.message, cb_data);
>  }
