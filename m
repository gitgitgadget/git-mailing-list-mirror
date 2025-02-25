Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84C78F35
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495478; cv=none; b=huGO/zwfszYXKMt6ByJYVJBH2yNdFytEcorb16+JFv0A7beTfsIdgTuJwhNn16Blb1oIRUOUOJshcGwximtlnFoxCwN8/vO5gxUG8OqtjdQLC+4ybBVgM+Ejy28ecpUXGvO9ntEr1Ia2mCH1Zh9a/y0IuBSqAk5cRJmntQuJD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495478; c=relaxed/simple;
	bh=Yh6awPbcRm1IzuauFWz9djXxqHf8y7HGf67B6QIkiHA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MxD81B8QVzn33eRKkijxTeaRKI5YKk1To2F68BDRhqsxiYkJUmbfrYgoPwKjFwKe8citkX1WSlRSJqM5fybmzym76wvG3R0tc+nHosKfKSu9ThtNzrVrWBeI7v+cy2s9cGZwSR9uke6Rl4Ao2QcK6gavDHF1G/xdwVDiXaD21uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd+doJL1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd+doJL1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so2990651f8f.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740495475; x=1741100275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=35ku0qrs8tEYBMr16IQnHgGEyb8NJIQo2GYDs4f0Cgs=;
        b=Cd+doJL1JykG35C0euMkCPWSzUFLILyEs94UKbADLdGYwsMuuSwsnJZKXqjCMHo0lt
         gVIbkNtizZ/F6lltohp8YaQBxH6GCFHilZGJ+e3GhiTzR9xnX4f+cqvZGbQUJc24GiYn
         lEEdq4BC2G3vKNUWDBDAwsPZxtivMZlWVwVlP33s0Zyr7KWHyl1MSqbSj1AlI/cr97QC
         JmNs4u3BSVnp7SHE8QCOD6o/a9F+h1putwVrRMmL1VXFX/eSWzlWdRqOVbr4cTgjl6C0
         Efl7/WK9zLXs/NrsYub0Ju6qFsDYI6IFjbFi3xy/jaOBRqW7WOUEJO5zBZ8SNPQopFRB
         ZvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495475; x=1741100275;
        h=content-transfer-encoding:in-reply-to:reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35ku0qrs8tEYBMr16IQnHgGEyb8NJIQo2GYDs4f0Cgs=;
        b=Z4VoDFylUW1/Ak/iSR9hoWrSS1nhefChS0suiCXxOwmCoZCQUu8sdRUsZWyWOpiDhe
         Fww/ssghSuOS4YDB6k2CKANXYvuW7qaWw0HRIhGRdIHmuHC5PzXkbNDMm5Uvr5f+Q971
         SZPE5rM9JlZ0IrH3Q8kqw+cFKUP7a6VHmZk3pOr1AAsLX3aP3rtQZxgSSLqDByJIC5fn
         RxOthTANwfYwmEWgQd2FJrTyxBSVUIrRanvthnP9Gl6STsTKW/MO4ejaKHM0o/ATegI9
         d2mW2Qq5EcjG8fsQe89B61msn76nXuajKHm1iHNUlzp/2YtcSkjpBEz7zV6fAtadPeNv
         a3pg==
X-Forwarded-Encrypted: i=1; AJvYcCXXN7N3xvBkHaY2jrNrExBeCYM9nTq03vvsXvQ/tNzde9SP07fa3Ry4FTH1j5Bu+FC8+Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsQmNFUhiroCLC3VSkI3VF+2K8ZF1lfxdQT47pgAHVIgLDm7w
	zL+a4LQGOSTKI7gcldhr1nZxGC60GGc+fv+Lm7sTUdt2QMMeCRcK
X-Gm-Gg: ASbGncs8uibhswOtN6Qqa1nmmg5kyIaqiRPArCI+abBUKlQZh6Cj7aWpm1JmAKhALin
	eIF7OeQHfSNrfmF23XGHe0u7jI05krMdgvXV6a0gNgx4GbDhb98yjVAT3AAFMa0fflFXaVrSn44
	7tLV0+eC4GragGQRZUcrFD+UxfmQuLvacCLMGJZee2cSwR7YJhD0Xw18hq08Xz/7mb9T3FELp60
	3JPs6lOYhj5ruU6QHTzPY2Smft2YXLFbE3r1DVA8MAoGYyUW6s8rv6zExDGuSmkBS1LPXBBVrsy
	Tcfg41na5WCsbQBmgpCz9nREeKcY03mK3qoe/og2aLfDaj3YGLICj8DJSNU8Iw4iy439xvsAASn
	e56UK
X-Google-Smtp-Source: AGHT+IEVmsJIxAbxm6KauuNWkMwn2X8N7MPUTtlqkMSCdu72fjmUyN1QLz4gWFN/+h5lZs89bFf/xg==
X-Received: by 2002:a05:6000:1ac7:b0:38f:48ee:ddc2 with SMTP id ffacd0b85a97d-38f6f0b238amr11946222f8f.37.1740495475078;
        Tue, 25 Feb 2025 06:57:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fcfc6sm2571634f8f.94.2025.02.25.06.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:57:54 -0800 (PST)
Message-ID: <2755fb78-d587-4ad9-b22f-b60dfa752d7a@gmail.com>
Date: Tue, 25 Feb 2025 14:57:47 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 6/7] refs: implement partial reference transaction
 support
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, phillip.wood123@gmail.com
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 25/02/2025 09:29, Karthik Nayak wrote:
> Git's reference transactions are all-or-nothing: either all updates
> succeed, or none do. While this atomic behavior is generally desirable,
> it can be suboptimal especially when using the reftable backend, where
> batching multiple reference updates into a single transaction is more
> efficient than performing them sequentially.
> 
> Introduce partial transaction support with a new flag,
> 'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
> individual reference updates that would typically cause the entire
> transaction to fail due to non-system-related errors to be marked as
> rejected while permitting other updates to proceed. Non-system-related
> errors include issues caused by user-provided input values, whereas
> system-related errors, such as I/O failures or memory issues, continue
> to result in a full transaction failure. This approach enhances
> flexibility while preserving transactional integrity where necessary.
> 
> The implementation introduces several key components:
> 
>    - Add 'rejection_err' field to struct `ref_update` to track failed
>      updates with failure reason.
> 
>    - Modify reference backends (files, packed, reftable) to handle
>      partial transactions by using `ref_transaction_set_rejected()`
>      instead of failing the entire transaction when
>      `REF_TRANSACTION_ALLOW_PARTIAL` is set.
> 
>    - Add `ref_transaction_for_each_rejected_update()` to let callers
>      examine which updates were rejected and why.

I think this is a much better design. I wonder if we want to signal to 
the caller of ref_transaction_commit() that there were ignored errors 
rather than forcing them to call ref_transaction_for_each_rejected() to 
find that out. Another possibility would be to call the callback from 
ref_transaction_commit() but that would mean changing the signature of 
ref_transaction_begin() to take the callback and user data when 
REF_TRANSACTION_ALLOW_PARTIAL is passed.

Best Wishes

Phillip

> This foundational change enables partial transaction support throughout
> the reference subsystem. The next commit will expose this capability to
> users by adding a `--allow-partial` flag to 'git-update-ref(1)',
> providing both a user-facing feature and a testable implementation.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   refs.c                  | 31 +++++++++++++++++++++++++++++++
>   refs.h                  | 22 ++++++++++++++++++++++
>   refs/files-backend.c    | 12 +++++++++++-
>   refs/packed-backend.c   | 30 ++++++++++++++++++++++++++++--
>   refs/refs-internal.h    | 13 +++++++++++++
>   refs/reftable-backend.c | 12 +++++++++++-
>   6 files changed, 116 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index f989a46a5a..243c09c368 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1211,6 +1211,15 @@ void ref_transaction_free(struct ref_transaction *transaction)
>   	free(transaction);
>   }
>   
> +void ref_transaction_set_rejected(struct ref_transaction *transaction,
> +				  size_t update_idx,
> +				  enum transaction_error err)
> +{
> +	if (update_idx >= transaction->nr)
> +		BUG("trying to set rejection on invalid update index");
> +	transaction->updates[update_idx]->rejection_err = err;
> +}
> +
>   struct ref_update *ref_transaction_add_update(
>   		struct ref_transaction *transaction,
>   		const char *refname, unsigned int flags,
> @@ -1236,6 +1245,7 @@ struct ref_update *ref_transaction_add_update(
>   	transaction->updates[transaction->nr++] = update;
>   
>   	update->flags = flags;
> +	update->rejection_err = TRANSACTION_OK;
>   
>   	update->new_target = xstrdup_or_null(new_target);
>   	update->old_target = xstrdup_or_null(old_target);
> @@ -2726,6 +2736,27 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
>   	}
>   }
>   
> +void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
> +					      ref_transaction_for_each_rejected_update_fn cb,
> +					      void *cb_data)
> +{
> +	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
> +		return;
> +
> +	for (size_t i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +
> +		if (!update->rejection_err)
> +			continue;
> +
> +		cb(update->refname,
> +		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
> +		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
> +		   update->old_target, update->new_target,
> +		   update->rejection_err, cb_data);
> +	}
> +}
> +
>   int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>   		     struct string_list *refnames, unsigned int flags)
>   {
> diff --git a/refs.h b/refs.h
> index 8e9ead174c..e4a6a8218f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -675,6 +675,13 @@ enum ref_transaction_flag {
>   	 * either be absent or null_oid.
>   	 */
>   	REF_TRANSACTION_FLAG_INITIAL = (1 << 0),
> +
> +	/*
> +	 * The transaction mechanism by default fails all updates if any conflict
> +	 * is detected. This flag allows transactions to partially apply updates
> +	 * while rejecting updates which do not match the expected state.
> +	 */
> +	REF_TRANSACTION_ALLOW_PARTIAL = (1 << 1),
>   };
>   
>   /*
> @@ -905,6 +912,21 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
>   					    ref_transaction_for_each_queued_update_fn cb,
>   					    void *cb_data);
>   
> +/*
> + * Execute the given callback function for each of the reference updates which
> + * have been rejected in the given transaction.
> + */
> +typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
> +							 const struct object_id *old_oid,
> +							 const struct object_id *new_oid,
> +							 const char *old_target,
> +							 const char *new_target,
> +							 enum transaction_error err,
> +							 void *cb_data);
> +void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
> +					      ref_transaction_for_each_rejected_update_fn cb,
> +					      void *cb_data);
> +
>   /*
>    * Free `*transaction` and all associated data.
>    */
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3b0adf8bb2..d0a53c9ace 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2851,8 +2851,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>   		ret = lock_ref_for_update(refs, update, transaction,
>   					  head_ref, &refnames_to_check,
>   					  err);
> -		if (ret)
> +		if (ret) {
> +			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
> +			    ret != TRANSACTION_GENERIC_ERROR) {
> +				ref_transaction_set_rejected(transaction, i, ret);
> +
> +				strbuf_setlen(err, 0);
> +				ret = TRANSACTION_OK;
> +
> +				continue;
> +			}
>   			goto cleanup;
> +		}
>   
>   		if (update->flags & REF_DELETING &&
>   		    !(update->flags & REF_LOG_ONLY) &&
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 75e1ebf67d..0857204213 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1324,10 +1324,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
>    * remain locked when it is done.
>    */
>   static enum transaction_error write_with_updates(struct packed_ref_store *refs,
> -						 struct string_list *updates,
> +						 struct ref_transaction *transaction,
>   						 struct strbuf *err)
>   {
>   	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
> +	struct string_list *updates = &transaction->refnames;
>   	struct ref_iterator *iter = NULL;
>   	size_t i;
>   	int ok;
> @@ -1408,6 +1409,14 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
>   						    "reference already exists",
>   						    update->refname);
>   					ret = TRANSACTION_CREATE_EXISTS;
> +
> +					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
> +						ref_transaction_set_rejected(transaction, i, ret);
> +						strbuf_setlen(err, 0);
> +						ret = 0;
> +						continue;
> +					}
> +
>   					goto error;
>   				} else if (!oideq(&update->old_oid, iter->oid)) {
>   					strbuf_addf(err, "cannot update ref '%s': "
> @@ -1416,6 +1425,14 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
>   						    oid_to_hex(iter->oid),
>   						    oid_to_hex(&update->old_oid));
>   					ret = TRANSACTION_INCORRECT_OLD_VALUE;
> +
> +					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
> +						ref_transaction_set_rejected(transaction, i, ret);
> +						strbuf_setlen(err, 0);
> +						ret = 0;
> +						continue;
> +					}
> +
>   					goto error;
>   				}
>   			}
> @@ -1453,6 +1470,14 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
>   					    update->refname,
>   					    oid_to_hex(&update->old_oid));
>   				return TRANSACTION_NONEXISTENT_REF;
> +
> +				if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
> +					ref_transaction_set_rejected(transaction, i, ret);
> +					strbuf_setlen(err, 0);
> +					ret = 0;
> +					continue;
> +				}
> +
>   				goto error;
>   			}
>   		}
> @@ -1518,6 +1543,7 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
>   write_error:
>   	strbuf_addf(err, "error writing to %s: %s",
>   		    get_tempfile_path(refs->tempfile), strerror(errno));
> +	ret = TRANSACTION_GENERIC_ERROR;
>   
>   error:
>   	ref_iterator_free(iter);
> @@ -1676,7 +1702,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
>   		data->own_lock = 1;
>   	}
>   
> -	ret = write_with_updates(refs, &transaction->refnames, err);
> +	ret = write_with_updates(refs, transaction, err);
>   	if (ret)
>   		goto failure;
>   
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c97045fbed..7196f2d880 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -123,6 +123,11 @@ struct ref_update {
>   	 */
>   	uint64_t index;
>   
> +	/*
> +	 * Used in partial transactions to mark if a given update was rejected.
> +	 */
> +	enum transaction_error rejection_err;
> +
>   	/*
>   	 * If this ref_update was split off of a symref update via
>   	 * split_symref_update(), then this member points at that
> @@ -142,6 +147,14 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
>   		      struct object_id *oid, struct strbuf *referent,
>   		      unsigned int *type, int *failure_errno);
>   
> +/*
> + * Mark a given update as rejected with a given reason. To be used in conjuction
> + * with the `REF_TRANSACTION_ALLOW_PARTIAL` flag to allow partial transactions.
> + */
> +void ref_transaction_set_rejected(struct ref_transaction *transaction,
> +				  size_t update_idx,
> +				  enum transaction_error err);
> +
>   /*
>    * Add a ref_update with the specified properties to transaction, and
>    * return a pointer to the new object. This function does not verify
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index e1fd9c2de2..83cf8d582b 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1374,8 +1374,18 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>   					    transaction->updates[i],
>   					    &refnames_to_check, head_type,
>   					    &head_referent, &referent, err);
> -		if (ret)
> +		if (ret) {
> +			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
> +			    ret != TRANSACTION_GENERIC_ERROR) {
> +				ref_transaction_set_rejected(transaction, i, ret);
> +
> +				strbuf_setlen(err, 0);
> +				ret = TRANSACTION_OK;
> +
> +				continue;
> +			}
>   			goto done;
> +		}
>   	}
>   
>   	string_list_sort(&refnames_to_check);
> 

