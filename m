Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E101798F
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295501; cv=none; b=L1LCROAtPwiQXfknWnjwGUCmvy92Ioy3j0u6PcKWQXXtCqFjVWQbsGvpOSvEnGT8u75LjWhFMBLn42wMyeykzR7WBk8QTvCPEgL2ZLfJL4zlGMo2nfCmHx1e/UyfLOfVN+3J0X/lrj01/9Ez72RRiEHQvp2IuRYcpqCIzJKNp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295501; c=relaxed/simple;
	bh=GOIvU+jUFLxbT4QLrLmgNNoH9TD4UltTilkOKoIsNis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1ZvUees2NwqAgr+jDL7r9e1+SaXzSUOTqJxQQBr1d6b654RDyuKw2QiCJnyFh43GBxnStU/RO7l31bIYTT7oRqGe1lVuhKTkizK4RueMaYQYNwUX6dWWVVVZKfvKOdmufTRKco/S2T+Y6EXCbO8Q6w6nDakO8kINDowt6tZ/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggU6etCh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggU6etCh"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-41b1ca1f28cso168275b6e.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753295499; x=1753900299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52kOonYlKFb6htCpgxwqGJ7bH7EVCg8bpQLGtej+ZvU=;
        b=ggU6etChzcefwOpYlmWZ8sHaCt3/vpjtPzh9ujsK09XvXdMjXdiYtMDA9vCDHz6xZq
         fqMFhLCvYtPy61RCjScEGKUdQBYspylBTRWMyx/ZCh2hednzCw4eg7UxCcr7KBwOz8Lk
         seSxtq96o/ZoWIHvlVPqZqO/CUVJuj+VYsTXUnFkTDq4fXnLTK9TxP+bGSTYTzEF5L2j
         9TMHW6StCNWRtBzxpsXVZo6hl7d/GloZ0zuh0o+NPzgVuDgjkjdgJ5aSyQqXtc97Eb+a
         vcZtSp6YpJtmY3dO/o6WzHhF06sibmmmSYeQNrDmJpYsr5Tkdf+8LbbtBgWohhWaL0n5
         jYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753295499; x=1753900299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52kOonYlKFb6htCpgxwqGJ7bH7EVCg8bpQLGtej+ZvU=;
        b=k/7661O7ET00HcJEdaiJkr4ULGAQEjib7QawZiW16jEwfcKkYbvGa2c6yYO1O7HfaP
         goNRiddUcriwsloP5M/bTl8ZEqQkPlny9vDDKAa6bp6GDkP9sqNn5v36ZX09tJeUmQax
         EXxq8DgIEngk+ZLlj9QVCtZEpMm6I2OcKFs5mwKh2/+Rfb5cFvlut1b1fQ5i1KxKpYPs
         zeD9+DB/HpDt1oTY3VuQauG1GVsiBs6h4Di2Svmb9pBqaSVi2nXMmbA8KNBKlEhuEj7H
         BOma1EWvuFVd8JrKcfEu/5UL4gae886DB/5wZczDi+17Buou3wPgvzakV0Hj1ArIGZ27
         rQUw==
X-Gm-Message-State: AOJu0YyMqIdIS1AklOXXcf4+ZiaylWwRi4XQ8N8r7qS10bq8fRrjFd56
	B6ngIjyyYAWZEbFadqAw0jk8m7HsLyyA2kv3anXOagYtoZQSfERc6j9H
X-Gm-Gg: ASbGnctrmEVsu21z/nqosaW+i1VPYeeHuQCq1LCO4Q+zdaaiJBELv8qr93P9ynMqeS1
	hbKh3F6NL8S/iU5WOMoF70UcGFxQmDBxENxfzkAJ+aV40pOcj2S5ZNS6ejfjSjRjSRSLeU2Ksdj
	9Y+y9A2zQgP9JwIvnfqSLnmygRl+b6GFSQQkaQHV2UP/ykJUBSkN5iO3y+1jrKwbt4qLCgZqNoH
	fzKwT+dhYhA3UvWfcx89g5hmQWeNnCXUpD4wXOTV/sDT9E/PVujXIUvEr+zZynBaI1wNikG+MEp
	Ko+zPIxmZL3WSkVg3LrHKGouibcGOrIjoOv0o9J6qsP07tPVoLRN62JxokKfVKhKDNaX9BwmV8s
	fenashm8+VPLcaTw=
X-Google-Smtp-Source: AGHT+IEK3Vo23EnLztKRITRXvA+UWnEcdhEUOo0zRaErqm24T+Gf5f0gqUyuJh9E5hTcy36yGeQ72A==
X-Received: by 2002:a05:6808:6f86:b0:40b:4208:8444 with SMTP id 5614622812f47-426c42f5546mr3561132b6e.7.1753295499063;
        Wed, 23 Jul 2025 11:31:39 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd10c1f4asm3243663b6e.7.2025.07.23.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:31:38 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:25:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/8] refs: export `ref_transaction_update_reflog()`
Message-ID: <2xwgx55dxhltq3ohktarsfe5wsw4f4er2h5hylz5qov3esntt6@fexfi4mioaqi>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-pks-reflog-append-v1-3-183e5949de16@pks.im>

On 25/07/22 01:20PM, Patrick Steinhardt wrote:
> In a subsequent commit we'll add another user that wants to write reflog
> entries. This requires them to call `ref_transaction_update_reflog()`,
> but that functino is local to "refs.c".

s/functino/function/

> Export the function to prepare for the change. While at it, drop the
> `flags` field, as all callers are for now expected to use the same flags
> anyway.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 29 +++++++++++------------------
>  refs.h | 15 +++++++++++++++
>  2 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 73913b6627b..188989e4113 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1362,27 +1362,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -/*
> - * Similar to`ref_transaction_update`, but this function is only for adding
> - * a reflog update. Supports providing custom committer information. The index
> - * field can be utiltized to order updates as desired. When not used, the
> - * updates default to being ordered by refname.
> - */
> -static int ref_transaction_update_reflog(struct ref_transaction *transaction,
> -					 const char *refname,
> -					 const struct object_id *new_oid,
> -					 const struct object_id *old_oid,
> -					 const char *committer_info,
> -					 unsigned int flags,
> -					 const char *msg,
> -					 uint64_t index,
> -					 struct strbuf *err)
> +int ref_transaction_update_reflog(struct ref_transaction *transaction,
> +				  const char *refname,
> +				  const struct object_id *new_oid,
> +				  const struct object_id *old_oid,
> +				  const char *committer_info,
> +				  const char *msg,
> +				  uint64_t index,
> +				  struct strbuf *err)
>  {
>  	struct ref_update *update;
> +	unsigned int flags;
>  
>  	assert(err);
>  
> -	flags |= REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
> +	flags = REF_HAVE_OLD | REF_HAVE_NEW | REF_LOG_ONLY | REF_FORCE_CREATE_REFLOG | REF_NO_DEREF;
>  
>  	if (!transaction_refname_valid(refname, new_oid, flags, err))
>  		return -1;
> @@ -3010,8 +3004,7 @@ static int migrate_one_reflog_entry(struct object_id *old_oid,
>  
>  	ret = ref_transaction_update_reflog(data->transaction, data->refname,
>  					    new_oid, old_oid, data->sb->buf,
> -					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
> -					    data->index++, data->errbuf);
> +					    msg, data->index++, data->errbuf);

Right now this is only the single caller for
`ref_transaction_update_reflog()`. Since it is intented for all callers
to use the same set of flags, removing the field makes sense.

>  	return ret;
>  }
>  
> diff --git a/refs.h b/refs.h
> index efa182c6a14..0faf3bc0422 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -794,6 +794,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);
>  
> +/*
> + * Similar to`ref_transaction_update`, but this function is only for adding
> + * a reflog update. Supports providing custom committer information. The index
> + * field can be utiltized to order updates as desired. When not used, the
> + * updates default to being ordered by refname.
> + */
> +int ref_transaction_update_reflog(struct ref_transaction *transaction,
> +				  const char *refname,
> +				  const struct object_id *new_oid,
> +				  const struct object_id *old_oid,
> +				  const char *committer_info,
> +				  const char *msg,
> +				  uint64_t index,
> +				  struct strbuf *err);
> +
>  /*
>   * Add a reference creation to transaction. new_oid is the value that
>   * the reference should have after the update; it must not be
> 
> -- 
> 2.50.1.465.gcb3da1c9e6.dirty
> 
> 
