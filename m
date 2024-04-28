Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E64D2F5
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343326; cv=none; b=uZ3De92vIHdJAB3Tf7U5jQr6RvBzA8kaTSvxrD/t1NAXQxm3GHH4w+qtV2Q+BJClYNSJAVv8UB/N4MnlfIM1vpL1ER4UOhwPLQjrc1T+bv1u5JLbjdkR8B7wIJ2M+5CgFLmReYizddkNd+Rnp4l5I3QWFkwhixbxS0R3Ic9JFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343326; c=relaxed/simple;
	bh=9df9wvHdWf9Se0u4a7jLS/zXCqW2PzxIKV6SWUCBfXY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc9zuuNAKb1MC5ld7KF/vI4LfL2wjO5v6LCwib7a1njfGY8dkdL8T/4Y/sIefkBr7aHPgS5ft2jfjKkXJpoyrX7rqXEpnzfoJ1DPO/qQOSewqDFNmbMB4FWHYKOGBecf8/FRBEeDfqr6G3Z73jlCVJcLpKuRW42ElQAquH/PxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac4AQ2dm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac4AQ2dm"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea128e4079so1924955a34.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343323; x=1714948123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcQnespMFNYZvJCVKdFo4msnzSL12b7rpQldfjtrQBo=;
        b=ac4AQ2dmhKzzFO0UcDyOSD878hZb1V7AYbvrOQcUgc1Krof4a7q/3fkdkPhlz/3koZ
         dkK34B8SqaDXiXj1uFfYGyv54p0q6oZRbzGMwCN4maTbwYcKlXFM3K/SnggRLLx/cai3
         8y9B91u6sDC1PJFvL05Lq8jRfICebKwDuTIbcgkptya4pnFM7EGS/Fw4JpUfk4fz9qM4
         SUQ9DNaGdKjPZhF16y7QUoZi0aFjqc6oP49FjditMfyntWLRgJKOEgu/FGUG+WmplY1K
         0HH3xmH5XL4JCSoYdOswsYf+vChmu//G2X23Zo9lNJ/eDn1IEZjqBhJdczMAtc8JG2LO
         XgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343323; x=1714948123;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcQnespMFNYZvJCVKdFo4msnzSL12b7rpQldfjtrQBo=;
        b=b1Lh1jL3ODLV2cPlg2R/v4910PxT6vvAQ/JwhzGmog428vBXx7D2lhBWvM+KpMSe0p
         chH35JIPCB6oK0NcYGBpoDHXXQgtrVgKq7MXp5pGrlcjREoaZ2/AwKsA63lNN0wWFTgh
         ScGfv7Lpradipg7XkU2xXCepDgQ59AaiQIArng70aVhcYZo4lEwfuQ+114zeV6Ht7y4t
         sEEMxQmBP8+1byE/+bywsnrIoo1Ty8a+44Nd+qm7R07XX2zl9HQNDoxHsSWJwfP4jvaI
         nheFIn2hCo9b8be87ew9LedtnUtm48urh7ZG3rQR6mUmbTToFMxBLN5pZ9rNTJuvQa4f
         yfkg==
X-Forwarded-Encrypted: i=1; AJvYcCXvjFRyWDyMS6WUFNlyJQE+Y9UuqHkR65OH4sUh6XFSYKjAJQU6PfMhx3Odd+wl0/yhdcGjCkWh63Q/U2NjCtkeT5dQ
X-Gm-Message-State: AOJu0YwNI/dja9nqKwKqx8oPgsYMYCgecTVINQfmg4MHIlCZuyF4XJWA
	vbBZ09TipY24zASK+r5IFxsmiRNCRCf1WOy2CqZiHDdGK8TQG/e5IQe+8A/VXZBgkCacHKaZJRx
	smGg6le94YXOuj1gweklOq2GP9TLITQ==
X-Google-Smtp-Source: AGHT+IG4Ghy2iCvS+c1/3+EZuv08rqUr5EGPDGH+aWuA81YTMrssO3yeSPSiQ0SL5GJBAh5KE+HR4kbWC31CAhvuzYs=
X-Received: by 2002:a05:6870:308:b0:233:f233:c3ee with SMTP id
 m8-20020a056870030800b00233f233c3eemr9927876oaf.50.1714343322829; Sun, 28 Apr
 2024 15:28:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Apr 2024 15:28:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xw37n6t.fsf@gitster.g>
References: <20240423212818.574123-1-knayak@gitlab.com> <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-4-knayak@gitlab.com> <xmqq5xw37n6t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 28 Apr 2024 15:28:41 -0700
Message-ID: <CAOLa=ZT4yVEuZXmiTVB2tf0qaTPCPn=0TcJRc89knZQWZBbFTg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] update-ref: add support for 'symref-verify' command
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c7eb3906172fa8ca"

--000000000000c7eb3906172fa8ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> In the previous commits, we added the required base for adding symref
>> commands to the '--stdin' mode provided by 'git-update-ref(1)'. Using
>> them, add a new 'symref-verify' command to verify symrefs.
>>
>> The 'symref-verify' command allows users to verify if a provided <ref>
>> contains the provided <old-target> without changing the <ref>. If
>> <old-target> is not provided, the command will verify that the <ref>
>> doesn't exist. Since we're checking for symbolic refs, this command will
>> only work with the 'no-deref' mode. This is because any dereferenced
>> symbolic ref will point to an object and not a ref and the regular
>> 'verify' command can be used in such situations.
>
> All makes sense, but a na=C3=AFve reader may find it helpful if you
> explained why having "verify" command is a good idea in the first
> place ("I can just do 'git symoblic-ref' to read the current value,
> and see if it is what I expect").  Presumably the value of "verify"
> is that you can have it in a transaction and fail other operations
> in the same transaction if the symref moved from what you expected
> it to point at?
>

I would say none of the commits drive this point, and I would go ahead
and add something on these lines to each of them. I think it would add
good value to readers.

>> Add and use `ref_update_is_null_new_value`, a helper function which is
>> used to check if there is a new_value in a reference update. The new
>> value could either be a symref target `new_target` or a OID `new_oid`.
>> We also add tests to test the command in both the regular stdin mode and
>> also with the '-z' flag.
>
> This looks out of place, primarily because the helper function is
> *NOT* used in this step.  Without any actual user, and with the name
> that says only what it checks without hinting why a caller may want
> to check the condition it checks, it is hard to guess if it is a
> good idea to have such a helper.
>

I think over the revision, its usage from this commit was removed. It
makes sense to move it to a commit where its used, I'll do that.

> "If a ref_update object specifies no new-oid and no new-target, it
> is not about updating but just validating" is how the callers are
> expected to use it, then instead of is_null_new_value that says
> what it checks, something like is_verify_only that says what the
> caller may want to use it for would be a more friendly name for
> readers and future developers.

This is true for the old-oid and old-target. That is, when they are set
to null, we're validating.

With the new-oid and new-target, if they're null, it usually signifies
deletion. We could rename it to 'is_delete_only', but that would also
need checking the 'REF_HAVE_NEW' flag. So we could ideally change it to

```
int ref_update_is_delete_only(struct ref_update *update) {
	return (update->flags & REF_HAVE_NEW) && !update->new_target &&
is_null_oid(&update->new_oid);
}
```

I'm okay with making this change.

>> @@ -297,11 +320,47 @@ static void parse_cmd_verify(struct ref_transactio=
n *transaction,
>>  		die("verify %s: extra input: %s", refname, next);
>>
>>  	if (ref_transaction_verify(transaction, refname, &old_oid,
>> -				   update_flags, &err))
>> +				   NULL, update_flags, &err))
>>
>>  	update_flags =3D default_flags;
>>  	free(refname);
>>  	strbuf_release(&err);
>>  }
>
> The only damage by this patch to parse_cmd_verify() is that
> ref_transaction_verify() gained another parameter NULL, but with the
> default "--diff-algorithm=3Dmyers" algorithm, it is very hard to see.
>
> The "--patience" algorithm does a much beter job on this hunk.
>
> And the following function is entirely new.
>
>> +static void parse_cmd_symref_verify(struct ref_transaction *transaction=
,
>> +				    const char *next, const char *end)
>> +{
>> +	struct strbuf err =3D STRBUF_INIT;
>> +	struct object_id old_oid;
>> +	char *refname, *old_target;
>> +
>> +	if (!(update_flags & REF_NO_DEREF))
>> +		die("symref-verify: cannot operate with deref mode");
>> +
>> +	refname =3D parse_refname(&next);
>> +	if (!refname)
>> +		die("symref-verify: missing <ref>");
>> +
>> +	/*
>> +	 * old_ref is optional, but we want to differentiate between
>> +	 * a NULL and zero value.
>> +	 */
>> +	old_target =3D parse_next_refname(&next);
>> +	if (!old_target)
>> +		old_oid =3D *null_oid();
>
> In many existing code paths, we do not do structure assignment like
> this. Instead we do
>
> 		oidcpy(&old_oid, null_oid());
>
> We can see an existing example in a common context in a hunk for
> refs.c in this patch.
>

Yeah, makes sense to switch this. Will do.

>> +	if (*next !=3D line_termination)
>> +		die("symref-verify %s: extra input: %s", refname, next);
>> +
>> +	if (ref_transaction_verify(transaction, refname,
>> +				   old_target ? NULL : &old_oid,
>> +				   old_target, update_flags, &err))
>> +		die("%s", err.buf);
>
> Are static analyzers smart enough to notice that we will not be
> using old_oid uninitialized here?  Just wondering.

Yup, at least the clang LSP server seems to detect and not bug me about
it.

> Anyway.  This ensures ref_transaction_verify() gets either
> old_target or old_oid, but never both at the same time.  The caller
> to ref_transaction_verify() in the previous function passed NULL for
> old_target but it always had a non-NULL old_oid so that is perfectly
> fine.
>
>> +	update_flags =3D default_flags;
>> +	free(refname);
>> +	free(old_target);
>> +	strbuf_release(&err);
>> +}
>
>> diff --git a/refs.c b/refs.c
>> index 060a31616d..0e1013b5ab 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1217,6 +1217,8 @@ void ref_transaction_free(struct ref_transaction *=
transaction)
>>
>>  	for (i =3D 0; i < transaction->nr; i++) {
>>  		free(transaction->updates[i]->msg);
>> +		free((void *)transaction->updates[i]->old_target);
>> +		free((void *)transaction->updates[i]->new_target);
>>  		free(transaction->updates[i]);
>>  	}
>>  	free(transaction->updates);
>> @@ -1247,9 +1249,13 @@ struct ref_update *ref_transaction_add_update(
>>
>>  	update->flags =3D flags;
>>
>> -	if (flags & REF_HAVE_NEW)
>> +	if (new_target)
>> +		update->new_target =3D xstrdup(new_target);
>> +	if (old_target)
>> +		update->old_target =3D xstrdup(old_target);
>
> Presumably "update" structure, when freshly initialized, has NULL in
> both of these _target members?  Otherwise ref_transaction_free()
> would get in trouble, so double checking.
>

This is a good point. My understanding was that FLEX_ALLOC_MEM should
set everything to 0.

>> +	if (new_oid && flags & REF_HAVE_NEW)
>>  		oidcpy(&update->new_oid, new_oid);
>> -	if (flags & REF_HAVE_OLD)
>> +	if (old_oid && flags & REF_HAVE_OLD)
>>  		oidcpy(&update->old_oid, old_oid);
>
> Since we can ask to work on a symbolic ref, new_oid / old_oid can be
> NULL when REF_HAVE_NEW / REF_HAVE_OLD bit is on for _target members.
>
> Makes me wonder if the code becomes easier to follow if the flag
> bits are split into four (_NEW -> _NEW_OID + _NEW_TARGET), but let's
> not worry about that for now.
>

The intersection of this is quite low currently, so I'm not really sure
if there's added benefit. I did start that way before, but perhaps with
the iterations in the last few version, maybe it makes the code simpler.

>> @@ -1286,6 +1292,7 @@ int ref_transaction_update(struct ref_transaction =
*transaction,
>>  	flags &=3D REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
>>
>>  	flags |=3D (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0)=
;
>> +	flags |=3D (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OL=
D : 0);
>
>> @@ -1325,14 +1332,17 @@ int ref_transaction_delete(struct ref_transactio=
n *transaction,
>>  int ref_transaction_verify(struct ref_transaction *transaction,
>>  			   const char *refname,
>>  			   const struct object_id *old_oid,
>> +			   const char *old_target,
>>  			   unsigned int flags,
>>  			   struct strbuf *err)
>>  {
>> -	if (!old_oid)
>> -		BUG("verify called with old_oid set to NULL");
>> +	if (!old_target && !old_oid)
>> +		BUG("verify called with old_oid and old_target set to NULL");
>
> Is it normal if you get _both_ set, or is it equally a BUG()?
> The parse_*_verify() codepaths we saw earlier both made sure
> only one of the two is non-NULL, and it is unclear what should
> happen if both are non-NULL.
>

It is a bug and this is caught in `ref_transaction_add_update`.
Introduced in the first patch of the series.

>> +	if (old_target && !(flags & REF_NO_DEREF))
>> +		BUG("verify cannot operate on symrefs with deref mode");
>>  	return ref_transaction_update(transaction, refname,
>>  				      NULL, old_oid,
>> -				      NULL, NULL,
>> +				      NULL, old_target,
>>  				      flags, NULL, err);
>>  }
>
> So this queues an ref_update object whose .new_oid and .new_target
> are NULL, and .old_oid and .old_target are what the caller gave us
> to check.  The NULLs in .new* members hopefully do not mean "delete
> this thing" ;-)
>

So the 'new_oid' being set to zero should be the delete this thing
queue.

>> @@ -2349,6 +2359,12 @@ static int run_transaction_hook(struct ref_transa=
ction *transaction,
>>  	for (i =3D 0; i < transaction->nr; i++) {
>>  		struct ref_update *update =3D transaction->updates[i];
>>
>> +		/*
>> +		 * Skip reference transaction for symbolic refs.
>> +		 */
>> +		if (update->new_target || update->old_target)
>> +			continue;
>
> Is that a final design, or will the hooks have a chance to interfere?
>

The last patch adds hook support.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 2420dac2aa..53197fa3af 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2425,6 +2425,37 @@ static const char *original_update_refname(struct=
 ref_update *update)
>>  	return update->refname;
>>  }
>>
>> +/*
>> + * Check whether the REF_HAVE_OLD and old_target values stored in
>> + * update are consistent with ref, which is the symbolic reference's
>> + * current value. If everything is OK, return 0; otherwise, write an
>> + * error message to err and return -1.
>> + */
>> +static int check_old_target(struct ref_update *update, char *ref,
>> +			    struct strbuf *err)
>> +{
>> +	if (!(update->flags & REF_HAVE_OLD) ||
>> +	    !strcmp(update->old_target, ref))
>> +		return 0;
>
> Earlier on the assignment side for "update" structure we saw above,
> the guard was (old_target && flags & REF_HAVE_OLD), but here we
> assume old_target is valid, which feels a bit asymmetric.
>
> Yes, I can see that the caller does not call us when !old_target,
> but still...  Perhaps
>
> 	if ((update->flags & REF_HAVE_OLD) && !update->old_target)
> 		BUG(...);
>

I will add something like this.

> or something?  Or alternatively, perhaps !!update->old_target should
> be the only thing we should check and ignore REF_HAVE_OLD bit?  I am
> not sure, but it smells like that the non-NULL-ness of old_target is
> the only thing that matters (if it is not NULL, very early in the
> control flow somebody would have set REF_HAVE_OLD bit to flags, no?).
>
> It brings me back to my earlier question.  Does REF_HAVE_OLD bit
> serve a useful purpose in this code?
>

I checked and it doesn't, it can be removed from usage in this code.
Will cleanup this part.

>> +	if (!strcmp(update->old_target, ""))
>> +		strbuf_addf(err, "cannot lock ref '%s': "
>> +			    "reference already exists",
>> +			    original_update_refname(update));
>> +	else if (!strcmp(ref, ""))
>> +		strbuf_addf(err, "cannot lock ref '%s': "
>> +			    "reference is missing but expected %s",
>> +			    original_update_refname(update),
>> +			    update->old_target);
>
> So... for old_target and ref, an empty string is a special value?
> How?  Shouldn't that be documented in the comment before the
> function?
>
>> +	else
>> +		strbuf_addf(err, "cannot lock ref '%s': "
>> +			    "is at %s but expected %s",
>> +			    original_update_refname(update),
>> +			    ref, update->old_target);
>> +
>> +	return -1;
>> +}
>> +
>>  /*
>>   * Check whether the REF_HAVE_OLD and old_oid values stored in update
>>   * are consistent with oid, which is the reference's current value. If
>> @@ -2528,6 +2559,18 @@ static int lock_ref_for_update(struct files_ref_s=
tore *refs,
>>  					ret =3D TRANSACTION_GENERIC_ERROR;
>>  					goto out;
>>  				}
>> +			}
>> +
>> +			/*
>> +			 * For symref verification, we need to check the reference value
>> +			 * rather than the oid. If we're dealing with regular refs or we're
>> +			 * verifying a dereferenced symref, we then check the oid.
>> +			 */
>> +			if (update->old_target) {
>> +				if (check_old_target(update, referent.buf, err)) {
>> +					ret =3D TRANSACTION_GENERIC_ERROR;
>> +					goto out;
>> +				}
>
> We come here only when update->type has REF_ISSYMREF bit on (we
> learned that value by calling lock_raw_ref()), and know referent.buf
> has the current "target" value.  That is consumed as "ref" parameter
> to check_old_target() we just saw.  OK.
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 6104471199..a2474245aa 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -938,7 +938,26 @@ static int reftable_be_transaction_prepare(struct r=
ef_store *ref_store,
>>  		 * individual refs. But the error messages match what the files
>>  		 * backend returns, which keeps our tests happy.
>>  		 */
>> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>> +		if ((u->flags & REF_HAVE_OLD) && u->old_target) {
>> +			if (strcmp(referent.buf, u->old_target)) {
>> +				if (!strcmp(u->old_target, ""))
>> +					strbuf_addf(err, "verifying symref target: '%s': "
>> +						    "provided target is empty",
>> +						    original_update_refname(u));
>> +				else if (!strcmp(referent.buf, ""))
>> +					strbuf_addf(err, "verifying symref target: '%s': "
>> +						    "reference is missing but expected %s",
>> +						    original_update_refname(u),
>> +						    u->old_target);
>> +				else
>> +					strbuf_addf(err, "verifying symref target: '%s': "
>> +						    "is at %s but expected %s",
>> +						    original_update_refname(u),
>> +						    referent.buf, u->old_target);
>> +				ret =3D -1;
>> +				goto done;
>> +			}
>
> Again, the puzzling "empty string"s are handled here.

For here and above, this too is dead code and no longer needed,
old_target being empty string is left over code from before we decided
to use zero_oid for deleting. I'll remove it. Thanks.

--000000000000c7eb3906172fa8ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a06ac29ea209a73d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdXpaY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meE1sQy85ZTExT3dtOTBQLzZBbjFKcGNJYVZJdFFWTwpIenJYVExWanU1
emlLVWllRUlYSE02dkg2T3ZnRzFCM0wwQTRqdlY3VVFtdGhvOVpBd1NxVGRGVHpQU3hnaWZTClAx
dmhKazA0bHR5akpYdllsTEkvenJkVlRHcTl0M0psUmhSRXZLRzUyQWhzay9KcTBYWjlIaUdxY2VY
NHlJMXoKYlYxK2xxSGpUYmVMMFFoVnRSeURsbHkrbm92Z2FwRUVkYU9GcmZPbVRtREgrUUZnR241
VWpaaHdxcTRNaG8ybQpVYjhSc0xpTGR5VWZLbVU0cmpwWGl1SHIxRHNGUEhMcFpUUUJKdEx1Z2Z3
TUZILzY2Rkt1MlBTZWt4UlVmc1FqCjhzbS9VYmVzeTVNb1Bnd2o3SmFxRnA3SEh5bFJJNW5WTXR4
dkpSVVBQQ3dqRGYvaFViRFNzbmhEV0tOOGkxRW0KcDRFN3VYSmJJbExhS29qWlc3cEFFaXFiSWNH
RXNmTDJ0OFJ1SVpSUGFYbFhJcGkzUml6NnY1bDduUWQvV3h0WgpiRjRUbDhjQXhMUEFaTFcrSlZ1
N3paYnU2T3RYMlREVDF6alVROUlxSmNrYVlZc3hLSEJEQ1lmdVVTREM3ZXg4ClB5TEcvRmZENjh3
aUdWZms5d3RHYWtwdDQrRGg5aHNLYU1pQVJObz0KPVZBYUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c7eb3906172fa8ca--
