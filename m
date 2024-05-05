Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97BB662
	for <git@vger.kernel.org>; Sun,  5 May 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918184; cv=none; b=Qosk5yPILHuF9Kstd1ClH2GQor+CnzcCnVzNt2WpqQdkXmv7y6p+VIyIa/9xQstF8HRK2Fb4++o+C9urY7w58t3d/zPdFIH2f/0CpvRZKj35TLlAmv0d3RbD83GvwStS2joe+T17MDBCNxHrKatIeW4JKqK+8XxaTRfzr7IbcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918184; c=relaxed/simple;
	bh=9yAyyyhNDpqANOHiD/R3XCa/7JjsmVPGPqFrB8oozAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hU8wFYcEKCoDJVyzxP68/vexqGgIHPzZYRo8ZqMB5DQthygDhZjpZr6xWX+UVI7I0Dz8OmbeHcx4ESlrLPm1DspxMQOfWJPQNyH+2ppJLmcEgJTaN4tdK0Wqux7JooEAa2m4bHcQAI1P8TCSBAJiFzGUHBcgNwJixoHwnCu8PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k++QqaaI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k++QqaaI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so11811595e9.1
        for <git@vger.kernel.org>; Sun, 05 May 2024 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714918180; x=1715522980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2RU0P7Q5nbujdUn+9kF4gh6+s93N4xM8gRYPxjHZMM8=;
        b=k++QqaaIB6JQ68ddNDc3rMQl4OdG4VOnPUK5xHdr1vYkpj2BgU/tqcfJpoJBw3bN/x
         O74M3xOkRP5rQZ9roY+baYeHICx5LS2pwqEOuZPCBGC26qT3keBCv1DsHm5EU7EVWRQt
         1el6+1zj06xoqg6LQyX4NDT357cJamF6OgOEE0WHY7bi0/19psPRwOi+V4JETBO9tlUw
         Ew+NMMLuF+yLscYiffx6g1nsUwij3l72Bf7FAJlRGydjTYHIvigoHm6yyMnRehQMl6kb
         Ha+tfuwZt8hwgZDgWnZUyWHRiFu111LeMn07syzLF00dthFfULvTWjU5QRnBIPkSTMIs
         MGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714918180; x=1715522980;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RU0P7Q5nbujdUn+9kF4gh6+s93N4xM8gRYPxjHZMM8=;
        b=Kd6TjuqbUcSGlPogyiY0uSGZ7D+UYJL5VDhuwJUPnfGskTRwzO0hLttTZ34X6zswyx
         z2RwZEJih53DhT301DwG4xL6p0zgv3QdyBaY4nCEUvfMamCswjo49Xl0Y/mbS+bOs5Pj
         UzzXamBvxYK9AP127ENCurAKzljhl+Vqd1k2mI+VvAiFHVtklXs/AYioLA/TLdL4sTWT
         im5l0ji7rliYkz9YgD4n8sQo9WKpoXMLBzdEJ3n26u+HOEe9ABRINhCaMr6iKUSeACYk
         EGSdDnxcEuaZfvXxqf8yfJIJHvoD4/epGWkTTU7kpVZ0uNKUfRmzIZMKkd96W2sPpwVW
         qj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxbceXzCqusU1sWdOr363jHfJxdoM+Ju8zmG6rldR7MS+KF+HVDPEig8/YqdHe+m2aWIDCuIQfLSGhcg82UPFXVI4R
X-Gm-Message-State: AOJu0YzzD38P7W9GqulrogNfEN3FztohZlQ81/4tzKOGLQx4cF/vZoW5
	z5RcGA4OEIJyjxTNzakLXR9h+d5YewOrawBkLE9HuVnxRp76YtjE
X-Google-Smtp-Source: AGHT+IGu9loGUThft9n4BLie+KVktkcxkSuXaBVMcHSibCCK0+0FcgZ6NbYwPH8hCxT5WPF0JWR5hA==
X-Received: by 2002:adf:f2c5:0:b0:34c:4d98:d6f7 with SMTP id d5-20020adff2c5000000b0034c4d98d6f7mr8102271wrp.26.1714918180510;
        Sun, 05 May 2024 07:09:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0034e19861891sm8327397wrp.33.2024.05.05.07.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 07:09:40 -0700 (PDT)
Message-ID: <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
Date: Sun, 5 May 2024 15:09:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240503124115.252413-5-knayak@gitlab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

I've left a few comments below - the most important one is about the 
error messages in the reftable backend, non of the others are worth 
re-rolling for on their own.

On 03/05/2024 13:41, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> The reference backends currently support transactional reference
> updates. While this is exposed to users via 'git-update-ref' and its
> '--stdin' mode, it is also used internally within various commands.
> 
> However, we never supported transactional updates of symrefs. Let's adds

s/we never supported/we do not support/

s/Let's/This commit/

> support for symrefs in both the 'files' and the 'reftable' backend.

s/backend/backends/

> Here, we add and use `ref_update_has_null_new_value()`, a helper
> function which is used to check if there is a new_value in a reference
> update. The new value could either be a symref target `new_target` or a
> OID `new_oid`.
> 
> With this, now transactional updates (verify, create, delete, update)

s/With this, //

> can be used for:
> - regular refs
> - symbolic refs
> - conversion of regular to symbolic refs and vice versa

Excellent

> This also allows us to expose this to users via new commands in
> 'git-update-ref' in the future.

I'm slightly concerned that splitting out the update-ref changes means 
we don't have any test coverage of the new code beyond the part that is 
used by refs_create_symref()

> Note that a dangling symref update does not record a new reflog entry,
> which is unchanged before and after this commit.
> 
> +/*
> + * Check whether the old_target values stored in update are consistent
> + * with current_target, which is the symbolic reference's current value.
> + * If everything is OK, return 0; otherwise, write an error message to
> + * err and return -1.
> + */
> +static int check_old_target(struct ref_update *update,
> +			    const char *current_target,
> +			    struct strbuf *err)
> +{
> +	if (!update->old_target)
> +		BUG("called without old_target set");
> +
> +	if (!strcmp(update->old_target, current_target))
> +		return 0;
> +
> +	if (!strcmp(current_target, ""))
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "reference is missing but expected %s",
> +			    original_update_refname(update),
> +			    update->old_target);
> +	else
> +		strbuf_addf(err, "cannot lock ref '%s': "
> +			    "is at %s but expected %s",
> +			    original_update_refname(update),
> +			    current_target, update->old_target);
> +
> +	return -1;
> +}
> @@ -2576,9 +2623,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>   		}
>   	}
>   
> -	if ((update->flags & REF_HAVE_NEW) &&
> -	    !(update->flags & REF_DELETING) &&
> -	    !(update->flags & REF_LOG_ONLY)) {
> +	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
> +		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {

This line looks quite long

> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -938,7 +940,22 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>   		 * individual refs. But the error messages match what the files
>   		 * backend returns, which keeps our tests happy.
>   		 */
> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
> +		if (u->old_target) {
> +			if (strcmp(referent.buf, u->old_target)) {
> +				if (!strcmp(referent.buf, ""))
> +					strbuf_addf(err, "verifying symref target: '%s': "
> +						    "reference is missing but expected %s",
> +						    original_update_refname(u),
> +						    u->old_target);
> +				else
> +					strbuf_addf(err, "verifying symref target: '%s': "
> +						    "is at %s but expected %s",
> +						    original_update_refname(u),
> +						    referent.buf, u->old_target);

The messages in this function differ from the equivalent messages in 
check_old_target() from the files backend above. This is potentially 
confusing to users, creates more work for translators and makes it hard 
to write tests that are independent of the backend. Can we export 
check_old_target() so it can be reused here. If not we should reword 
these messages to match the other messages all of which talk about not 
being able to lock the ref.

> +				ret = -1;
> +				goto done;
> +			}
> +		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
>   			if (is_null_oid(&u->old_oid))
>   				strbuf_addf(err, _("cannot lock ref '%s': "
>   					    "reference already exists"),
> @@ -1043,7 +1060,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>   		 * - `core.logAllRefUpdates` tells us to create the reflog for
>   		 *   the given ref.
>   		 */
> -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
> +		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {

The old line was already quite long and the new one is even longer - 
perhaps we could break it after the second "&&"

> +			if (create_reflog) {
> +				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> +				log = &logs[logs_nr++];
> +				memset(log, 0, sizeof(*log));
> +
> +				fill_reftable_log_record(log);
> +				log->update_index = ts;
> +				log->refname = xstrdup(u->refname);
> +				memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
> +				memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);

Both these lines would benefit from being folded

Best Wishes

Phillip
