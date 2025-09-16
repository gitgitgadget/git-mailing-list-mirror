Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039831BCB6
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057237; cv=none; b=E1aoCJopDeZhDnrhnsPFDzi7KdM1LLBl7N9b1+eLmsTVBPmoX0LOmdg9V2sQ12U0n2KjqfXwqWuyZTkkhXTPkmu0xxkx33MNzbxQw6mOVCENU9GweXQG+oaq3FC5crbUPmom3kW0nji3Xpciq0+gJJ8ewWvppJuxgWbfffzBmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057237; c=relaxed/simple;
	bh=Uye2SN528/LJY+HmzrYanGs7oKb4R5zdIIrC8msyFfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6QyNhxFZ+Ihbf2rB4GLsnmzxPdR7dQ8PNCZFHrt5jQ4ZoiD6yTXNg/95n8O/g9CS6A/fn9ShvlpwQLuU4A5TDx6Yq/BZiurlYbo+XIx2/VunPiG+8JAk4ee9u65Dh5K3p/XP5hd0YUVfhYWF9MXEDuSfk3YUcS9X0zBSYOkLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9YxKqKD; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9YxKqKD"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-31d6aa3e73fso193012fac.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758057234; x=1758662034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GxpdcLwNar+VRf+hz306LbHOSj5mHSP5c7iejx22xI=;
        b=l9YxKqKD9xEmawG1x0agKsEGkcvfkDCi7QRkclnYmpxxiboNlJWJX7lW4+upSQYXc/
         TPrQgeUeaNwZg/Er4KuTaIDrbEbij0k92PKbzHcsLbS53ktdQ4JOvZXoAZfTn/kXRLzu
         ZyxMHEfDlWjQnLpfWOenSZ4d/367bcpcxMZQQiLRDaqBU5cJSbNDLDz/Uh5Lwi9gVPJb
         Aa9K+Y7W7CXDPCVxh4fdpZlNmiH/WGSHHjRWibkzpcXxYAWstJQtQ5IM1cOb8T2LI3wB
         GqznIqoBiL2WHFVdA24W499S5VIwjcbzGrtK/BkAyr6gi/4H1Ktt/ff1fLT+N/xPwG53
         7eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057234; x=1758662034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GxpdcLwNar+VRf+hz306LbHOSj5mHSP5c7iejx22xI=;
        b=HG4UymzsEtJ/yneyAOx9LqwRZmi8CIAS7L9MmvbNFsMNbQQ+BXN8BIMiy6imVy5c+Y
         6kq2wFkVqBi9PjCPE1DZskIrxDrcVX/bEdTJwqRDUj0Nt1EWCdyoSUh8Vl33EHaCOutr
         nL5NzaOE5L9d5C6wxKBFlJ9mvfLkE9t29jxZhIo1i+kAM4YAu1v3c1pEHwFhB0rXVFAS
         p2HuEfOATVE6WjHQBpS8Z7NyrRHsDcC8lyCToYGCVfg2XmdTA0cu3GoaFbEHZLmUPXyI
         7d/nybifSKfuvWerjGQdUJOJAc6nhOP1djiNTiimadu0UaheDE+oN0JF7O84T09sLr4w
         4cmg==
X-Gm-Message-State: AOJu0YxBuKnu1vpsIM7wNfh/rQ/VSmRZCC7yvkBQRjHVQGrN0lOs6ltK
	KwH1ZuScxpuL0eDJd1ip5LSg1MGfDMizpF1ABGxCjLx1hn8GAUc8tiKb
X-Gm-Gg: ASbGncvEI/Uwk9PgyFTuhld1Wtg41Zlj/Gjaz6VbVMExd7I4DeTdQKBhlQWIeeZlJLv
	slUeP4vsHs4rNH458whp9H0WW4BlLlwYD9llHIQqBqA6hN3AavVFVdEiZcjhmEXOC77nP6k3BIa
	fFVvbR2fswCx94M0UY4yCtf2Yhk+UfPqbCAPWWIXQpHXqO3WbfwW1/vAxrEZXF13Xu7ZVXDkqil
	YO18WqEIZT7Av5EmJxENRxNGborQjmdj3N2m90itlOllubfPrPXsuhwKgX95jVl3weOrNKOYlHA
	OYDJSUOSiPilTKhwvHNKSbTklzqOAMSSY7wsM2bDqBzoBF+HS6QLlJAMQm6job8lBxjtoql3/Pf
	TMKneNcKNW/2MGi8T3AQUcZUQQ3c=
X-Google-Smtp-Source: AGHT+IHgzpmZoVAYZwoxdZZtwVutnSTi3nxcdwvpV5pvCOaY2ip2a8BS5Pb6xh5dbCfE0MHOBdjc4g==
X-Received: by 2002:a05:6870:289a:b0:315:8985:d81c with SMTP id 586e51a60fabf-334527da0d5mr1706948fac.11.1758057233931;
        Tue, 16 Sep 2025 14:13:53 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7524b8a399fsm4321439a34.24.2025.09.16.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:13:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:13:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] refs/files: catch conflicts on case-insensitive
 file-systems
Message-ID: <uv4ifkvxcujjjj3lsc4tf5b5dnc7pkaaw62t6ahagnskxn4kg6@oyxjgupdilrc>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-1-195569740b57@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-1-195569740b57@gmail.com>

On 25/09/13 10:54PM, Karthik Nayak wrote:
> During the 'prepare' phase of reference transaction in the files

s/reference/a reference/

> backend, we create the lock files for references to be created. When
> using batched updates on case-insensitive filesystems, the entire
> batched updates would be aborted if there are conflicting names such as:
> 
>   refs/heads/Foo
>   refs/heads/foo

Ok so this is only a problem now because the reference updates are
performed in a single transaction and the resulting error causes the
entire transaction to be aborted.

> This affects all commands which were migrated to use batched updates in
> Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
> that, reference updates would be applied serially with one transaction
> used per update. When users fetched multiple references on
> case-insensitive systems, subsequent references would simply overwrite
> any earlier references. So when fetching:
> 
>   refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
>   refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
> 
> The user would simply end up with:
> 
>   refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

Makes sense.

> This is buggy behavior since the user is never informed about the
> overrides performed and missing references. Nevertheless, the user is
> left with a working repository with a subset of the references. Since
> Git 2.51, in such situations fetches would simply fail without updating
> any references. Which is also buggy behavior and worse off since the
> user is left without any references.
> 
> The error is triggered in `lock_raw_ref()` where the files backend
> attempts to create a lock file. When a lock file already exists the
> function returns a 'REF_TRANSACTION_ERROR_GENERIC'. When this happens,
> the entire batched updates, not individual operation, is aborted as if
> it were in a transaction.
> 
> Change this to return 'REF_TRANSACTION_ERROR_CASE_CONFLICT' instead to
> aid the batched update mechanism to simply reject such errors. 

So does this mean that we return `REF_TRANSACTION_ERROR_CASE_CONFLICT`
in all cases where a a lockfile already exists for a reference? Or do we
only actually care about scenarios where the lockfile already exists
specific to case-insensitive filesystems?

> The
> change only affects batched updates since batched updates will reject
> individual updates with non-generic errors. So specifically this would
> only affect:
> 
>     1. git fetch
>     2. git receive-pack
>     3. git update-ref --batch-updates

Just to clarify, is this saying that this new error is not ignored in a
standard reference transaction? Only the above operations?

> This bubbles the error type up to `files_transaction_prepare()` which
> tries to lock each reference update. So if the locking fails, we check
> if the rejection type can be ignored, which is done by calling
> `ref_transaction_maybe_set_rejected()`.
> 
> As the error type is now 'REF_TRANSACTION_ERROR_CASE_CONFLICT',
> the specific reference update would simply be rejected, while other
> updates in the transaction would continue to be applied. This allows
> partial application of references in case-insensitive filesystems when
> fetching colliding references.
> 
> While the earlier implementation allowed the last reference to be
> applied overriding the initial references, this change would allow the
> first reference to be applied while rejecting consequent collisions.
> This should be an okay compromise since with the files backend, there is
> no scenario possible where we would retain all colliding references.
> 
> Let's also be more pro-active and notify users on case-insensitive

s/pro-active/proactive/

> filesystems about such problems by providing a brief about the issue
> while also recommending using the reftable backend, which doesn't have
> the same issue.
> 
> Reported-by: Joe Drew <joe.drew@indexexchange.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/fetch.c       | 21 +++++++++++++++++---
>  refs.c                |  2 ++
>  refs.h                |  2 ++
>  refs/files-backend.c  | 33 +++++++++++++++++++++++++++-----
>  t/t1400-update-ref.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  t/t5510-fetch.sh      | 22 ++++++++++++++++++++-
>  6 files changed, 124 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 24645c4653..c7ff3480fb 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>  
>  struct ref_rejection_data {
>  	int *retcode;
> -	int conflict_msg_shown;
> +	bool conflict_msg_shown;
> +	bool case_sensitive_msg_shown;
>  	const char *remote_name;
>  };
>  
> @@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
>  {
>  	struct ref_rejection_data *data = cb_data;
>  
> -	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
> +	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
> +	    !data->case_sensitive_msg_shown) {
> +		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
> +			"trying to fetch from has references that only differ in casing. It\n"
> +			"is impossible to store such references with the 'files' backend. You\n"
> +			"can either accept this as-is, in which case you won't be able to\n"
> +			"store all remote references on disk. Or you can alternatively\n"
> +			"migrate your repository to use the 'reftable' backend with the\n"
> +			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
> +			"Please keep in mind that not all implementations of Git support this\n"
> +			"new format yet. So if you use tools other than Git to access this\n"
> +			"repository it may not be an option to migrate to reftables.\n"));

Nice error message.

[snip]
> +/*
> + * Check if the transaction has another update with a case-insensitive refname
> + * match.
> + *
> + * If the update is part of the transaction, we only check up to that index.
> + * Further updates are expected to call this function to match previous indices.
> + */
> +static bool transaction_has_case_conflicting_update(struct ref_transaction *transaction,
> +						    struct ref_update *update)
> +{
> +	for (size_t i = 0; i < transaction->nr; i++) {
> +		if (transaction->updates[i] == update)
> +			break;
> +
> +		if (!strcasecmp(transaction->updates[i]->refname, update->refname))
> +			return true;
> +	}
> +	return false;
> +}

Ah ok, so we do validate that the pre-existing lockfile comes from this
transaction. That is how we know it is related to case-insensitive
filesystems.

> +
>  /*
>   * Lock refname, without following symrefs, and set *lock_p to point
>   * at a newly-allocated lock object. Fill in lock->old_oid, referent,
> @@ -677,16 +697,17 @@ static void unlock_ref(struct ref_lock *lock)
>   * - Generate informative error messages in the case of failure
>   */
>  static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
> -					       struct ref_update *update,
> +					       struct ref_transaction *transaction,
>  					       size_t update_idx,
>  					       int mustexist,
>  					       struct string_list *refnames_to_check,
> -					       const struct string_list *extras,
>  					       struct ref_lock **lock_p,
>  					       struct strbuf *referent,
>  					       struct strbuf *err)
>  {
>  	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
> +	struct ref_update *update = transaction->updates[update_idx];
> +	const struct string_list *extras = &transaction->refnames;
>  	const char *refname = update->refname;
>  	unsigned int *type = &update->type;
>  	struct ref_lock *lock;
> @@ -776,6 +797,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);

huh, so if if we have a lockfile error due to a case-insensitve
filesystem, does this mean we print the error message from
`unable_to_lock_message()` and the new message?

If so, I wonder if we would be better off skipping the former since it
could be a bit misleading.

> +			if (myerr == EEXIST && ignore_case &&
> +			    transaction_has_case_conflicting_update(transaction, update))
> +				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>  			goto error_return;
>  		}
>  	}

-Justin
