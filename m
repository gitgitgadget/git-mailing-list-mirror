Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07442E408
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244315; cv=pass; b=WV8JOBDhh9tZr39uD/GZR3ZQ/KC7QtwPO61IkT776uRjBTN2iIlXrcEPwEB/msBz+yWKuqJYs8GP6TdQefi/mV160mdZX0hwZFLvng3aLAjIA8bkHbzv9L6gCietR5lCBl5AQEhxwioVQZBWjUUtEWi98MP4HgOXsEM+i6kXVWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244315; c=relaxed/simple;
	bh=JJUQneNqwo8yywxu6X3NpUoh1e5Hgw1UMj2NVeDLP5Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHlpIGmC8GH2lLuH0wjNWkB+BxCo328UJ70aFTUKhYpdFs9+uJ0uRy40kFZXzbYZ3u1PbVXVIv00ndURi4v3VfomGUCOiKxqOMp8KmYDDzegrliOKCZiy16Hu/1GTp1B5b1v6nahRgeFgbSdUrK+nkaZvubQdGQPnJl1gu+lPWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHSHIGV4; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHSHIGV4"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed1so970397241.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 03:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790244301; cv=none;
        d=google.com; s=arc-20260327;
        b=c2Rs5U5Pvaw/r4BQAnNuuzoXU6tMp2tjnB5VcKYdETJVRJnldADxs3fEsBBaioQrzM
         J73hZNZfHHNgbccUKjn5SOMiCai7Ji0pQjIQiYBOqcd1p4QxyeozBBzZ0stwvpn5GrQZ
         azTTf8yH47gxKb8kfIG9YRHWeNax+Q6SwUUcpLzZFYq6nbqcU62kKK8bePj+xh9hnOW2
         +AAaCqCVjbyM6wV5RtrZ1GpCzNmC1UJ9wA2WrjxWxKjAkeftesQFbOXSP/cNwYPz3xJs
         20VNFO/FU9k4E3PxHCLWnO6nZUcj3UXN83hEzOTNQ2TvD4Sl8pmSMrv2ZL/9k2wu3wf/
         iBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=REThypGTROqz8GTQQYLkkEC2P8uYQ6Au1DgKUGWxoJE=;
        fh=JkPU3HhON2XtLcbJ9UjatAmU+Ygb20dJYSCSVek9Dws=;
        b=R9PK28TSd+OtPYWt/HNq7wls1PLH2b8WPTj01f3rK1DFmCvCwh4ZysNuSfSDEk43RN
         SrfSAvcFK7yOthpemeJd8UMKy0wRGOlTEiWdUOmgFzPZ3YIGJs2ROe2G7iOmgwdVJ4sy
         FrbytH7DMSEivpgQ2jlgdGB2XWiBglwzCcflyW2N3skF77282pdAI+jmkuSF32GAzeQD
         d2xB+yowTf5teVgZF7TjL/rFj+Nz3N5MHFZK92ciRV2f5S52l6ZKBa9G2hgry6kkCyzt
         1sBwxVs0K/fZndzsPSoareWJCn20/M6DUD8Gb04GcmNbNgLwhNoVDAqKgtVDK17tDRTs
         XrGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244301; x=1790849101; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REThypGTROqz8GTQQYLkkEC2P8uYQ6Au1DgKUGWxoJE=;
        b=WHSHIGV4y2A/9+rOpovvcCx0yXHD6/PT8UWUdO9/8/XhpSAiXTVWaggNrL4PHbUdqV
         wfTACI2QDLwJDxLZDDE9EkTIL6HYa3fBht6+kVeQjqN/yi9lfXz99b5bEqF0vVs2f/t2
         hW0qk6rRA02WZ2OjRY0ja+iuaDLbfjzaQ20uLjLb2c0xdmE/GMmcOUPZa7JrlZVOwlz7
         1mlUen0DuKWQ1DjYKiI1gGHK9W0wb/KZCz8EHoc7KUsjxQezNUw4Ugy8ISryASIyAo4h
         PYGpersFDs55HEzUdrgylPICrCbCsmzECcYRcf755R/nyC+OCraihC5HQhNzk//+mqGD
         b3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244301; x=1790849101;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REThypGTROqz8GTQQYLkkEC2P8uYQ6Au1DgKUGWxoJE=;
        b=g34gb7OTsE3dI6rL9JvqEYiIYn2pKRbueyCQ3GwW0oe/tSRFcYg6YJWIBkijPdtFTb
         uJE81NY0sjT1cGivPdTVNZGRunEoijUUyfogjQpz/u/AqY9w1kjQVyCWxu7hvZTsd34i
         w6Iq1/Wc1V9PGHGz9teuQW2c2nvKt4d/RffAhWFHaH1SCH8w++ZQS8c5vg5Pyz1pbCaS
         mYSUMb5iY3I3z2+DBk/+dMrc7FaQ1m/ISssu++0gv2gtEoTLrhtYDSqs4p3/ZafTM89l
         /BQBtg3ouXoH5vsH5LsJ2u6pSRQnG+6/B0+CSIUf3VrQIIlDO7M+Y3gvzx5sYFUs8E04
         Mqfg==
X-Forwarded-Encrypted: i=1; AKwUvBxS5zg3UK1N2d10qPKVaz/eEeo25pZEfj92T1StAWK5yuNjl/yQZF9ygIhQJp0H20Qtly0=@vger.kernel.org
X-Gm-Message-State: AFuF++mn63lC1gBv7mLnu7QfCeKVMLkzygex9lRdKREpUfWqjUj8e/9U
	JXpup+u7NxrA+QIC5T4g42vJWwfo3RtP4KheM5txnXpZ6PriktG9IYuSgMNktB3atn9Op3IPa2p
	2ulPOdO+4lUKC6WBHniYXtM0kMOSgp5c=
X-Gm-Gg: AYBFou3s0FDrCQ7rwTiAZMCdZdJ9A+J8Ja4YbvmObz312QQx/GUf4QmMG0Z0tch5Eu9
	QTkD6so7kssgb6H8k9kt2hGwzPb+E4+gPaq47UyVP/xPFDrRfrzplcWV1raNgWQwqxVoRDibhUV
	GRYCh++Ud03ELlSXCl/VaoBlNUcVhKwN9rmG8OHBioaw3YuEYwG5LmShqTKgXL6LRYPjpWyCJkv
	MKm129AjSKIv1x+QFxM0ihrbb3PoF7mMcZLerCdE9VX2w0RLlcZEY/+8fmVFAfzGCSUsK4g9rkT
	1DvAWKCIVFo+CT3gQlK9WXMyf4k9U293dKuyt6v3YyB6DV+k2le1fL6kK7Yz3lIAmB5PJXXOWNu
	zPfnrvvCnQXj1xui0qBGvUHJcofQAl5VpAhB24RjFos+VQifOGvFZSqCA
X-Received: by 2002:a05:6102:868f:20b0:7af:81ed:6090 with SMTP id
 ada2fe7eead31-7af81ed6d59mr276803137.13.1790244300984; Thu, 24 Sep 2026
 03:05:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 03:04:59 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 03:04:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com> <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 03:04:59 -0700
X-Gm-Features: AclHuK9DURQqRVw8dpVr0cQOEKhKekMF8FgkWRDV2ZABfMCrdziOqoc1H6SDQrM
Message-ID: <CAOLa=ZTWq6eiqCwUyUhCffTn1=f9pdAip7nsYJMnaPPUuccB8g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009f42c1065c37bb48"

--0000000000009f42c1065c37bb48
Content-Type: text/plain; charset="UTF-8"

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> refs_delete_refs() performs unconditional deletions, so callers cannot
> preserve old values that they have already resolved. Consequently,
> reference-transaction hooks see a null old OID.
>
> Let callers provide an optional array of expected old OIDs in parallel with
> the refname list. Delete the ref at position N only if it still points at
> the OID at position N. Treat a null OID as an unconditional deletion in
> ref_transaction_delete(), allowing callers to include broken refs whose old
> value cannot be resolved.

Okay this makes sense.

> refs_delete_refs() has always promised best-effort deletion. Always use
> REF_TRANSACTION_ALLOW_FAILURE and report rejected updates so one failure
> does not prevent independent refs in the batch from being deleted.

Yup, this seems in line with what we discussed earlier.

> Let
> callers request the exact set of failed refs when they need to report
> partial results

So callers to `refs_delete_refs()` need to request the set of failed
refs? Okay reading on.

> This also completes the conversion that was missed when
> batched transaction failure support was introduced.
>

Not sure what you're trying to say here. What conversion was missed and
how is that fixed in this commit?

[snip]

> diff --git a/refs.c b/refs.c
> index 92d5df5b7..13ee2d459 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -16,6 +16,7 @@
>  #include "refs/refs-internal.h"
>  #include "hook.h"
>  #include "object-name.h"
> +#include "oid-array.h"
>  #include "odb.h"
>  #include "object.h"
>  #include "path.h"
> @@ -1523,7 +1524,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
>  	if (old_oid && is_null_oid(old_oid))
> -		BUG("delete called with old_oid set to zeros");
> +		old_oid = NULL;

This change is totally different from the rest of the commit, I think it
should be a precursor with adequate explanation regarding why this is
done and why that's okay.

I'm also still of the opinion that this shouldn't be done. A zeroed out
null_oid is usually a user bug, where they haven't initialized a `struct
object_id` correctly or ignored the return code while reading a ref.
This BUG() captures that. We break safety without it.

Another point is that `old_oid = NULL` is used to say, I don't care what
the value of the ref is, delete it. Whereas `old_oid = null_oid` is more
of, the ref shouldn't exist in the first place. Are we mixing up
concerns here?

>  	if (old_oid && old_target)
>  		BUG("delete called with both old_oid and old_target set");
>  	if (old_target && !(flags & REF_NO_DEREF))
> @@ -3069,39 +3070,73 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
>  	}
>  }
>
> +struct delete_refs_rejection_data {
> +	int failures;
> +	struct string_list *failed_refs;

I'm assuming failures is to count the number of refs which failed,
wouldn't `failed_refs->nr` give us the same result?

> +};
> +
> +static void delete_refs_rejection_handler(const char *refname,
> +					  const struct object_id *old_oid UNUSED,
> +					  const struct object_id *new_oid UNUSED,
> +					  const char *old_target UNUSED,
> +					  const char *new_target UNUSED,
> +					  enum ref_transaction_error err,
> +					  const char *details,
> +					  void *cb_data)
> +{
> +	struct delete_refs_rejection_data *data = cb_data;
> +
> +	warning(_("could not delete reference %s: %s"), refname,
> +		details ? details : ref_transaction_error_msg(err));
> +	data->failures++;
> +	if (data->failed_refs)
> +		string_list_insert(data->failed_refs, refname);
> +}

Oh so failed_refs is optional?

> +
>  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
> -		     struct string_list *refnames, unsigned int flags)
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     struct string_list *failed_refs,
> +		     unsigned int flags)
>  {
> +	struct delete_refs_rejection_data rejection_data = {
> +		.failed_refs = failed_refs,
> +	};
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> -	struct string_list_item *item;
> -	int ret = 0, failures = 0;
> +	size_t i;
> +	int ret = 0;
>  	char *msg;
>
>  	if (!refnames->nr)
>  		return 0;
> +	if (old_oids && old_oids->nr != refnames->nr)
> +		BUG("refname and old OID counts do not match");
> +	if (failed_refs && !failed_refs->strdup_strings)
> +		BUG("failed ref list does not duplicate strings");
>
>  	msg = normalize_reflog_message(logmsg);
>
> -	/*
> -	 * Since we don't check the references' old_oids, the
> -	 * individual updates can't fail, so we can pack all of the
> -	 * updates into a single transaction.
> -	 */
> -	transaction = ref_store_transaction_begin(refs, 0, &err);
> +	transaction = ref_store_transaction_begin(refs,
> +						  REF_TRANSACTION_ALLOW_FAILURE, &err);
>  	if (!transaction) {
>  		ret = error("%s", err.buf);
>  		goto out;
>  	}
>
> -	for_each_string_list_item(item, refnames) {
> +	for (i = 0; i < refnames->nr; i++) {

Nit: we could inline the `size_t` here.

> +		struct string_list_item *item = &refnames->items[i];
> +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
> +
>  		ret = ref_transaction_delete(transaction, item->string,
> -					     NULL, NULL, flags, msg, &err);
> +					     old_oid, NULL, flags, msg, &err);
>  		if (ret) {
>  			warning(_("could not delete reference %s: %s"),
>  				item->string, err.buf);
>  			strbuf_reset(&err);
> -			failures = 1;
> +			rejection_data.failures++;
> +			if (failed_refs)
> +				string_list_insert(failed_refs, item->string);
>  		}
>  	}
>
> @@ -3113,9 +3148,13 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
>  		else
>  			error(_("could not delete references: %s"), err.buf);
>  	}
> +	if (!ret)
> +		ref_transaction_for_each_rejected_update(transaction,
> +							 delete_refs_rejection_handler,
> +							 &rejection_data);
>
>  out:
> -	if (!ret && failures)
> +	if (!ret && rejection_data.failures)
>  		ret = -1;
>  	ref_transaction_free(transaction);
>  	strbuf_release(&err);
> diff --git a/refs.h b/refs.h
> index 9979446d1..43f7a32f2 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -9,6 +9,7 @@
>  struct fsck_options;
>  struct object_id;
>  struct ref_store;
> +struct oid_array;
>  struct strbuf;
>  struct string_list;
>  struct string_list_item;
> @@ -623,13 +624,26 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  		    unsigned int flags);
>
>  /*
> - * Delete the specified references. If there are any problems, emit
> - * errors but attempt to keep going (i.e., the deletes are not done in
> - * an all-or-nothing transaction). msg and flags are passed through to
> - * ref_transaction_delete().
> + * Delete the specified references. If old_oids is non-NULL, it must contain
> + * an entry for each refname, in the same order. Each non-null OID is used to
> + * verify the current value of the corresponding reference before deleting
> + * it. A null OID requests an unconditional deletion, which allows callers to
> + * include broken refs whose old value cannot be resolved.
> + *
> + * If failed_refs is non-NULL, it must be initialized with
> + * STRING_LIST_INIT_DUP. The names of individual updates that cannot be queued
> + * or are rejected while processing the best-effort batch are inserted into
> + * it. A transaction-wide failure is returned without populating the list.
> + *
> + * If there are any problems, emit errors but attempt to keep going (i.e.,
> + * the deletes are not done in an all-or-nothing transaction). msg and flags
> + * are passed through to ref_transaction_delete().
>
>   */
>  int refs_delete_refs(struct ref_store *refs, const char *msg,
> -		     struct string_list *refnames, unsigned int flags);
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     struct string_list *failed_refs,
> +		     unsigned int flags);
>
>  /** Delete a reflog */
>  int refs_delete_reflog(struct ref_store *refs, const char *refname);
> @@ -956,9 +970,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  			   struct strbuf *err);
>
>  /*
> - * Add a reference deletion to transaction. If old_oid is non-NULL,
> - * then it holds the value that the reference should have had before
> - * the update (which must not be null_oid).
> + * Add a reference deletion to transaction. If old_oid is non-NULL and not
> + * null_oid, then it holds the value that the reference should have had before
> + * the update. Passing null_oid is equivalent to passing NULL and disables the
> + * old value check.
>   *
>   * See the above comment "Reference transaction updates" for more
>   * information.
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index db58f0058..29945f2b8 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -132,7 +132,7 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
>  	while (*argv)
>  		string_list_append(&refnames, *argv++);
>
> -	result = refs_delete_refs(refs, msg, &refnames, flags);
> +	result = refs_delete_refs(refs, msg, &refnames, NULL, NULL, flags);
>  	string_list_clear(&refnames, 0);
>  	return result;
>  }
> --
> 2.39.3 (Apple Git-146)

--0000000000009f42c1065c37bb48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d740888fecc0786_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xMDljY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1VpQy85NEY1TlhPTXM2ekd1YmNvYlNzZHk2WW5qVQpnbnRwQkIxZzdr
b1dvK0k5bFh5OHN0Z1JIaEpVL0RDMDFXNU05Lzd5bXZQWW0yU0pXM0tRSDVRS3B0cWZzQU9mCklk
bTJSYkIvT1BxQXV4SzlHTDJOVnMxSVQ3ZjZYVXhTMjUvRmJJcElyVEpIYkdtbU10SUVJUHM3QWtN
Rjk2ZDIKbnpHUWVpSElzdlRMVGg2TUhSUGdSVk5FTDM3VlRKNjBSOStSWEtjTFZJVS9wOUpFb0pW
S3N0dy8zZ2FUTFA2aQp1SzFaVmJ6QVBYS0FaSlRJSWYwTEk1NnFuYTBHKzNOSWdsMDgyYjQvNHlX
UklRYStkZmpnMFdtMTNGb0tGdi9PCjBNQk44eWowMmRFdmp3RjVURXNXLy9YRXhQMnNxazlaUEhp
M3B1WkYyQTY5SkJhU3FVZUJYMWJQTHk0aUg4Y2UKbmlpckxqZHhBT2U0RkZrbnNYSDVZMVFMY0N5
NGxHTFJOU3V1dWdzUW43R1hrSi9KYVZDWFUxbUErQ3A2U3BOQwpqQlhhdmxJUVVmVlFHU1FPTjZl
amxlZlRJemVDWEFSbXQxUWQ3TVZ5NTZWZ21Ec2grWjVtYlc4Q2xtSEdvdGgxClF1UVZUcE5mWnJx
OHVSamVIYlNMMVZZc3BtNjUzS2VWSlA4Z2RMcz0KPXNaOGUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009f42c1065c37bb48--
