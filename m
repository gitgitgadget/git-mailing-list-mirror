Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5E4973BB
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996381; cv=pass; b=OJKp9+cZVSAXp0CwuQtjBoQgQ6Avjsqfjptjw23cnTx3mgSnIj1nY4sgoKxVlWl4LeBSNhPbrdKuBIVRa/aVRtn6Nwq+30WGpuvXzUfq2Qi/qNBnSrgktU1B3Ldrh9uTWiX+6V7CCmHCICi+BgjwgsN/YaT0nVzK0jkGMmDi+a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996381; c=relaxed/simple;
	bh=pU987LGalOhpjhNcUL/iq3wTl/LY9f0iDEAkDgDuX+0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzkp+Ug/SEqfFBsW10BYc9s5N7fGk0AJwxQhh/HleWPLw4Czww1ZJ/jQW6p/4kdOydipwOd2c8AOrhDbTlLTxXoCisb+mUEBotFIIktHqlgLJG3LUm6/H2OBlE2acPL0TLsSeaRMuZl/fY5+H+Rd9KJLYluId/094hveIS6eZpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pB9UyA1y; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB9UyA1y"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785692e5a3aso1675378137.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789996379; cv=none;
        d=google.com; s=arc-20260327;
        b=DMeHssFaPVpeNNkhoCQ11M4Nw5ib0LBLPW3seeU2fBSn23uG88cEfJH0L1SDxGfKkw
         4GOiqvul9chftgLwKx2i6XRDkfXiANWtJzj8rFm7vf+TkKbQ/QcMs73sLH3xrFa9uiAa
         /VQjZTB2tZSmmwQeTe2ajoc3X6NIQXN5nMw4PZy3uXPQSf03JYe5Rz7QAYHMdQ8HQUUj
         Zg5T8xoJYEuo1fiwenZUrIz2wOOeLkAfUqL0RPXWm/jkmCLF1bG7OPCcvOvSRmsbcDV4
         oBM5AZyd9kCJozNjHny8LtR7wzJi6lYSUw4sx4lbd1suLejZl8w2hX2ZO2+Wbv6OgNA2
         wxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ItMdo4p/fYe8uDrb/5ANJEd8aBfT/KPdZDEQla7cj8s=;
        fh=jWDfea9mIMiQ0BTcwDjb5waT11STyEvWumq4laIo5rI=;
        b=RwS9Z4wIpQSEkdqVCGQNF/FuvE15ZCSbHx+J9tLgh6yKBEp5GOQouP7jn99yv1dTJC
         Fe/fYfs4clRtjspL6xqoylLTW/nUQgu4ktrE6+ChBliOjlFp4raHZNmNZdkZ1cHSgxGT
         uVQ1xGs87UhYTCsmHAuJsPeUZM4kJfzMkWIMKPQWqsD43Ao0f5UL0PumxITdkEoubtl3
         e/05moUbzdguYv9LqN4eYuQmM0HaKX9FlKWgZOf3P1+KE0oh8Ct/9hj1JA+WynB15pXy
         VvKA7/7Rq7YQQ4WA2w57E9Y5pYZ4inylk7BPeX6zDLG0k4zEBYye7o7815E+bO/eKMWn
         Cuow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789996379; x=1790601179; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItMdo4p/fYe8uDrb/5ANJEd8aBfT/KPdZDEQla7cj8s=;
        b=pB9UyA1yhs9MRiuMm3fiMn4tHTyqOd6dQG4YE3wd2t3dTkjbIa4NT9+LWurahTIjUr
         hkRfIMXEn1EKTNOcVDINcr+Xr9/+jw2KjDx6xYpr4NTS7uINJ/pOM6yr/AfVGWQoU5bl
         WHbYtperLHOg4QyEtwuHfo3J/5F4kgmza1AMOzaUHHlMhUqLnoM50Wsylk9YdEJjgsj6
         9F/hdDjPlCFYePtdj4iXh3LVMrvKOGQHiUEBOU1w9QMPL6yj+ouVF9UkRl7Zr7nkpb+l
         enFxck5XwqWpTAp8sOBvN4FdYtecHt2+sE/bOh14f3ZEHNL3Oo+HixiWzP/DnkhTEUjm
         bHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996379; x=1790601179;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItMdo4p/fYe8uDrb/5ANJEd8aBfT/KPdZDEQla7cj8s=;
        b=pRD7GTN95/zRdDBvSidOIBoWv/TY944Gaf/BeExrhi6sIJGBTQnBX8kI6JqNz2yXmT
         5DR4/u37Cl8mBN5O+nEo7in8RjGty6hWlVDpP/fkQrjHoPWBIJgxAUpmeUaju6n48A1E
         1F2nLITVVB1FQ2UMavgXlqxiHFdBgxP4+CD0O4HR2v07Zf3GXpXXwGnwS7ef2Auj0iYV
         JOWSNjHAuKuqBAOwcOJ/E/kAOH7m+Q0vXliDcqdqdyLAYRn0+2PBI6OXb4y53W4ttWOT
         O0nP4EshXg+0xDsbgQ3B8lwf48yU8CqIZof4eQk36I4t+6Bp44xp3te8NiedbRi8gfJ+
         dagg==
X-Forwarded-Encrypted: i=1; AKwUvBw9u3Go/Efax6FrqL7iNqdk3F/Nf2WgqZ5zKG9QbssJDs94tYPhjCwbIoFgRUXCwFqogEk=@vger.kernel.org
X-Gm-Message-State: AFuF++m+fVMAT169pZu0UpzASPe4TQnXoMvIu/CHa2+IbTIT+XIDIlvF
	GtzhoewESKwiXc2stur/EUYaal+iGvMkGbsWEkSTRFDFcTYaPe07KxC67Q52r7uqq8eN31+S+i8
	isrsJyGx6LMOwit/OeC/as1Akarwtp+U=
X-Gm-Gg: AYBFou2L/5vLxQrrLp956MQsPqL724bH2QbOlorqkmPI0n++NHGUISPFRSm53NXJI0t
	MzgT2PTW+1lHNjQI3oJTTsYzxU09Nyv6l4wl+0UegmJYKNQKb8HlNJBs0XCrhIWpHDgaliK5anC
	ljw9xsPMuoXFK/dMNi37JWs2+jzPgYuMFU68dDwHs+CfUR72bZ5MIgEqwu3q4/3W834J55OUObT
	/lvi2iuzTwhujAesoAgDvs3I+OHCnlCAGIi55DtoWidUc0uwgBL2fVPmIsTzXTavYFIFKVWRJHJ
	I+puQkcShMX8OUTDCGg6bFGElS55HqCJrhtNI4+pGzliYR/zA80NcO5XJX0SpnAS1qxLueUg4VS
	1UmSAtmn5oqJcqj8ce6NRrp9X3y7L6AHpNqOMiwMbd1iH4g==
X-Received: by 2002:a05:6102:158c:b0:7a1:f951:664c with SMTP id
 ada2fe7eead31-7a55ce8b2c0mr4474632137.19.1789996378996; Mon, 21 Sep 2026
 06:12:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 08:12:58 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 08:12:58 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <5c96a5a1ebafd49a301c5c1dc77a2e19d6677ab0.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <cover.1789901584.git.maciej.ciemborowicz@gmail.com> <5c96a5a1ebafd49a301c5c1dc77a2e19d6677ab0.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 08:12:58 -0500
X-Gm-Features: AcwNN1WVG1Lt72ibm0vp2CWSIy3slfwIavtZhkUbbkuK-GemLNENhd7l2tV1p-E
Message-ID: <CAOLa=ZRd9x4yEcTs+TfnzGFK1iGNigm75F0ggpB=5M0jxGZb6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000051e4e1065bfe0217"

--00000000000051e4e1065bfe0217
Content-Type: text/plain; charset="UTF-8"

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> refs_delete_refs() currently performs unconditional deletions. Thus callers
> cannot preserve old values that they have already resolved, and
> reference-transaction hooks consequently see a null old OID.
>
> Add an optional oid_array whose entries correspond to the refnames. Pass each
> non-null OID to ref_transaction_delete(). Supplying an OID makes the deletion
> conditional: if the ref changed after the caller resolved it, the transaction
> fails instead of deleting the new value. Existing callers that pass NULL
> retain the unconditional behavior.
>
> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---
>  bisect.c                  |  2 +-
>  builtin/branch.c          |  3 ++-
>  builtin/fetch.c           |  2 +-
>  builtin/remote.c          |  5 +++--
>  builtin/tag.c             |  3 ++-
>  refs.c                    | 23 ++++++++++++++---------
>  refs.h                    | 12 ++++++++++--
>  t/helper/test-ref-store.c |  2 +-
>  8 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 94c7028d2..9aa3bace9 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1203,7 +1203,7 @@ int bisect_clean_state(void)
>  	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
>  	result = refs_delete_refs(get_main_ref_store(the_repository),
>  				  "bisect: remove", &refs_for_removal,
> -				  REF_NO_DEREF);
> +				  NULL, REF_NO_DEREF);
>  	string_list_clear(&refs_for_removal, 0);
>  	unlink_or_warn(git_path_bisect_ancestors_ok());
>  	unlink_or_warn(git_path_bisect_log());
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1572a4f9e..f1abeb681 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -322,7 +322,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		free(target);
>  	}
>
> -	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
> +	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
> +			     &refs_to_delete, NULL, REF_NO_DEREF))
>  		ret = 1;
>
>  	for_each_string_list_item(item, &refs_to_delete) {
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c1d7c672f..d202147b2 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1467,7 +1467,7 @@ static int prune_refs(struct display_state *display_state,
>  		} else {
>  			result = refs_delete_refs(get_main_ref_store(the_repository),
>  						  "fetch: prune", &refnames,
> -						  0);
> +						  NULL, 0);
>  		}
>  	}
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index de989ea3b..13d3cc52d 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1073,7 +1073,7 @@ static int rm(int argc, const char **argv, const char *prefix,
>  	if (!result)
>  		result = refs_delete_refs(get_main_ref_store(the_repository),
>  					  "remote: remove", &branches,
> -					  REF_NO_DEREF);
> +					  NULL, REF_NO_DEREF);
>  	string_list_clear(&branches, 0);
>
>  	if (skipped.nr) {
> @@ -1645,7 +1645,8 @@ static int prune_remote(const char *remote, int dry_run)
>
>  	if (!dry_run)
>  		result |= refs_delete_refs(get_main_ref_store(the_repository),
> -					   "remote: prune", &refs_to_prune, 0);
> +					   "remote: prune", &refs_to_prune,
> +					   NULL, 0);
>
>  	for_each_string_list_item(item, &states.stale) {
>  		const char *refname = item->util;
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 06c125b53..40874a292 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -122,7 +122,8 @@ static int delete_tags(const char **argv)
>  	struct string_list_item *item;
>
>  	result = for_each_tag_name(argv, collect_tags, (void *)&refs_to_delete);
> -	if (refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
> +	if (refs_delete_refs(get_main_ref_store(the_repository), NULL,
> +			     &refs_to_delete, NULL, REF_NO_DEREF))
>  		result = 1;
>
>  	for_each_string_list_item(item, &refs_to_delete) {
> diff --git a/refs.c b/refs.c
> index d3caa9a63..9c593baea 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -18,6 +18,7 @@
>  #include "refs/refs-internal.h"
>  #include "hook.h"
>  #include "object-name.h"
> +#include "oid-array.h"
>  #include "odb.h"
>  #include "object.h"
>  #include "path.h"
> @@ -3056,33 +3057,37 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
>  }
>
>  int refs_delete_refs(struct ref_store *refs, const char *logmsg,
> -		     struct string_list *refnames, unsigned int flags)
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     unsigned int flags)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> -	struct string_list_item *item;
> +	size_t i;
>  	int ret = 0, failures = 0;
>  	char *msg;
>
> +	if (old_oids && old_oids->nr != refnames->nr)
> +		BUG("refname and old OID counts do not match");
>  	if (!refnames->nr)
>  		return 0;
>
>  	msg = normalize_reflog_message(logmsg);
>
> -	/*
> -	 * Since we don't check the references' old_oids, the
> -	 * individual updates can't fail, so we can pack all of the
> -	 * updates into a single transaction.
> -	 */

Okay so we already have the error buf sent to the refs subsystem and the
appropriate error will now be displayed.

>  	transaction = ref_store_transaction_begin(refs, 0, &err);
>  	if (!transaction) {
>  		ret = error("%s", err.buf);
>  		goto out;
>  	}
>
> -	for_each_string_list_item(item, refnames) {
> +	for (i = 0; i < refnames->nr; i++) {
> +		struct string_list_item *item = &refnames->items[i];
> +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
> +
> +		if (old_oid && is_null_oid(old_oid))
> +			old_oid = NULL;

We need to do this since `ref_transaction_delete()` doesn't expect
old_oids set to zeroes. But why would a callee do this? Shouldn't this
also be a bug, if the callee doesn't care about the previous value
shouldn't they simply set `old_oids->oid[i] = NULL`?

>  		ret = ref_transaction_delete(transaction, item->string,
> -					     NULL, NULL, flags, msg, &err);
> +					     old_oid, NULL, flags, msg, &err);
>  		if (ret) {
>  			warning(_("could not delete reference %s: %s"),
>  				item->string, err.buf);
> diff --git a/refs.h b/refs.h
> index 71d5c186d..b76b556cf 100644
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
> @@ -613,13 +614,20 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  		    unsigned int flags);
>
>  /*
> - * Delete the specified references. If there are any problems, emit
> + * Delete the specified references. If old_oids is non-NULL, it must contain
> + * an entry for each refname, in the same order. Each non-null entry is used
> + * to verify the current value of the corresponding reference before deleting
> + * it. A null entry disables verification for that reference.
> + *

Here too, we don't talk about zero-oid's. So I think we should skip the
implicit conversion.

> + * If there are any problems, emit
>   * errors but attempt to keep going (i.e., the deletes are not done in
>   * an all-or-nothing transaction). msg and flags are passed through to
>   * ref_transaction_delete().
>   */
>  int refs_delete_refs(struct ref_store *refs, const char *msg,
> -		     struct string_list *refnames, unsigned int flags);
> +		     struct string_list *refnames,
> +		     const struct oid_array *old_oids,
> +		     unsigned int flags);
>
>  /** Delete a reflog */
>  int refs_delete_reflog(struct ref_store *refs, const char *refname);
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index 3866d0aca..c2c7dfb06 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -140,7 +140,7 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
>  	while (*argv)
>  		string_list_append(&refnames, *argv++);
>
> -	result = refs_delete_refs(refs, msg, &refnames, flags);
> +	result = refs_delete_refs(refs, msg, &refnames, NULL, flags);
>  	string_list_clear(&refnames, 0);
>  	return result;
>  }
> --
> 2.39.3 (Apple Git-146)

--00000000000051e4e1065bfe0217
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3382fee4e39dffe3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xeExWZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1YrQy80Ny9GUzJ2dWh0bG5TaFd5UkNSM2dWcURIbApFRXNxWUpIYmlQ
WXN1eWtCYTNnZTJpRVE2cXFwZHBtTGxTRjRLZVlKdmxmMWpEZEpET3R4UE1Ba1pjN3BJc2V6CmIx
dmFLNnBwcTVGZC9ndXpkd0xyTWFCb21ycWZMQlMvd0liTUxvM2lFbU5GR0xvTVBWZGtNVlkvblFX
VDlYTFUKUHQrNDQ0WWNFVC9SZzNMaVduVXQ3VXIxR3NmSUkrZlpFT1hJOHMrUHNWblVwNXMrZ0pa
SkExdktRYXF4TTJjcQpnc2ZCa3hIanBtUmNERHp2TnBjalFPYmxiaWpxU0xCNE9zN1ZJa1Izbjl0
UTYzbGtLazk0VXhSR2Nzb1RydmdYCnRDdzRqNm91NGd3d2Uxd1ovRXEzUVQwTUxjaUlIQ3lqVTVk
dTlEdE9UNHJIV3ladGRpRzB3Mkt6Q1BoVzN1eUcKUkx2VURSVlgwbVdMZHZvN2NjeWtRc2RJSW5K
WFlqV09ud25YYW03TXhsd2VERGYxcFdvVHNhMkxZcmFYdzlUVAp6QURUWDRoWnVtMlEzZVcrR2JS
ejNtd0hrdVk5emUrdjlIK3c3by9PbEFDNXBsUkJuTHVNaEw3ZzZHTVhjbFVxClBtREFkQ3o0clNW
bW1vZHVUQUFWdU9oMmthQjl3bzQ5WDU2N2d3ST0KPW5Rd2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000051e4e1065bfe0217--
