Received: from mail-ua2-f32.google.com (mail-ua2-f32.google.com [74.125.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FA379EDA
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850507; cv=pass; b=P/ZyClEkBZq5e8Eh7T7rkXrIU6ElTUIFgGU/SG/tvkxiBehS8+s/SUWc3KVoTLaFJiuGroMUszXn1oK1E5dNMaQ935STRDC8e0azDdK/oG4rYq2R6MwwUyoAgHN0JCGKkzLPLBIPn8/IRoMNVXy8/EqqfRNY/jLoeJzOGRnALmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850507; c=relaxed/simple;
	bh=0DtdbGnv52E3dpvMQ4u6Cg8MPbWyICv3J/C0nvwgp9o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO1VqZXKw3HGj+apAzcYqUgdOWQXtYDXWWuIDF+zdjx+cqiV2sWNsbQBTnIcZkQSCk8v/ytB/JvUty5+BL7Ca5JTGeOr0Dum5dUFFNr4WCMHTJ3J9e/dszRtGlqZtNlosDNMJzzLTnhH6u+ZI6v05koj9FmAjhL4HSg4PiJZQ2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtIYhCXi; arc=pass smtp.client-ip=74.125.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtIYhCXi"
Received: by mail-ua2-f32.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so981141241.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789850505; cv=none;
        d=google.com; s=arc-20260327;
        b=r+zNNEU+PwwU7op6KACvownNPW3P37+LOMf49PrJUSFI0lIMu/QL7rgBt7H8Poh+MR
         d/xI/0YeJhhdANJOjsvWOhPSoJgKBMYbdMF5iVZpxg2yp5Ova8yHAECQG7XVeZgNurCe
         hLFjpameI9+rIDeyWIfPHNMzhOCLsy+yEMWM2hytRfKwOAyPqpDTDU98bcBcQo5iDqCD
         VddIVrdMPs+RslnLMb69dIxBHjR3Mmin+Pv/x6iKy6XxbeLthZaZ+RGdJ3RmPNKyz7Vl
         YrVzhl21GgmVOmTjvl/QJD9FL4OSw4meAdS27fkXRlriOrnmS4rD8KjwgptsJJnnM+vr
         y9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3+WWbqqXLWWKjq0n3okc7NnC/tLDguhaeWWts1VBTYI=;
        fh=YTN5K0KO8LF4par8ok7UF6jzQJrC2SqWzkCYNic8saE=;
        b=SK/DrA/puoVNImZp07KoOpl60Ua0Li0YNnn0ShTywA5fsLzHbXQnGJE81hOIQWcl0j
         Zbrc4m1HQ3tCqT9zMR6RqXBdMm4PjRmBECicWcSKYn6vlFlEz/hqBfXLaYe01bBZate9
         x0SlXzTldFp5ZGqhzRWVruEze70MlFAYrX4AwI9Tk3zrsFcexKZbJS1TvyHBbKoNSUlH
         YST2EdzlR0UoJKNZUXcFcNdMoX3wkO9RUvuz7d1TvVz5Lqyj22s6TOEb+Cuo1HMA9sP3
         Fiw4gH8gF93WycHTaleUdCGEbbo4DgPXriIovJv3JXqEAXOu18Bi+nM+TKtKddCzBnKw
         mYXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850505; x=1790455305; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+WWbqqXLWWKjq0n3okc7NnC/tLDguhaeWWts1VBTYI=;
        b=UtIYhCXiXnrsvm5Alx6gvFrXw9S7BK/is4w/nlSfSUFRcx0ggfeuoVWq0lpuy8kOts
         Y60xb2mA4mfQG3vIKhziCsVygzLmFMHn9CROSBwoETjx8hXNjHFhLTUAWuV2DNjcZrPR
         PcCxquCx2Xnd99piz54XBPKcctGM6FSR0ljCV9d2gWehZfJakAZ7Ww5qjDKG/Bt1uVio
         Odzk91SSQDSubUZzMqAk31khUItMGHKXZVsEPpedH4LsRG8s2R09VCKFWQWaSraFwRbc
         xl3VShecI6OFCBh34AuzHdFU+zeVZ+vp5HWNmzFER5B6uuzQyWGeRWXXslLnwdIcz/I4
         6Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850505; x=1790455305;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+WWbqqXLWWKjq0n3okc7NnC/tLDguhaeWWts1VBTYI=;
        b=HV9VjoVvWCh+ygTPKQ5zqZ8OuXeuwm4ssW2TJQBjzHH9TVMesKFUlsOi6Qrjqc/b7k
         fQm/bOGQtLDuKUexO6D4jiwNsjzmywJJmyEGwLugRlSyw9cgzzn7ZKtLoN3PE/GTKiSr
         hf2xLlXCd+XFqtoI8ShWCEt8An4/A8XfnnWYnTEbswMq3EjyCY8PiTuOGq4Ssf2xN5tp
         Q+N4RJHL2L+Gl+bV26H7gMBhGkTwbyBJfVCKVxjKjHcOdMu+sxb/GyL9wPOs5aOt+QrU
         RL+hxJ/xuYwsRnGXubqpfyveJe68nthMshqg+YpzXaN8kLK2Q6smDOGzFGvqJ8SFUPDQ
         1nEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwh5wRWMnXcL5IE+SCOeoJElxTmjYq+6h/bH4rmog3dPC3Lp1kKVfA/QVerskG4pyJQnOs=@vger.kernel.org
X-Gm-Message-State: AFuF++mIkUN/JtLwN/oCqSORvKaYdlGQjmK3imbKQEGXGP3lMfh/RoVv
	cfXFJNtoJN8H/GNcZhlzdHL8N3yVRBl9ApIGOawBnrb45U9YK8Be+jF3nN0pL1oT5SGbXmC2lNP
	prxbkWwtdUXuzXNZNcDv43dNUKjSahBQ=
X-Gm-Gg: AYBFou3gNGyu5i25RYTCMj081TAKrFlg7p5jMe+U+1qBB6jeq3B2NNtv+OM2aoTCgi8
	5p0XF2ktbhr6fygYX88+yipzx+nJxE+nZ3N5+FoPdGr8VjVVSUwzDb7rZyF1ICrBw7OvJqkuhSe
	Fw201/Tv2U5B4wW7b0ETKbLUGjTm9f5g9KNVDEcdieLMv1msnjQSJg1WxjnV3WiHNIpOsMjq6gC
	q1aV0DyfhsCIHF2TzB4O4roXAZQbLU3YUY5U/YjsGMg//MFyyCfjFaz1cNTFKVxccmTuj1YY2Zr
	A3lCFIev4XM6rzutzvd5mtWyFuyMjB3YocLhP3uvxZT0krNrhBd9eB6CC/O1UOzY4rx9KZaU/8A
	Ed2kJ2kFq9CQxJtOBz1Ac8lL6ExOlGhMcg9/GAR1zwRVZZQ==
X-Received: by 2002:a05:6102:3314:b0:7a1:f7d2:e81f with SMTP id
 ada2fe7eead31-7a55d28b816mr2429013137.24.1789850504889; Sat, 19 Sep 2026
 13:41:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 13:41:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 13:41:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260919201158.43415-2-maciej.ciemborowicz@gmail.com>
References: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com>
 <20260919201158.43415-1-maciej.ciemborowicz@gmail.com> <20260919201158.43415-2-maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Sep 2026 13:41:43 -0700
X-Gm-Features: AcwNN1VhIfZsPjZR75hcZLrkChaZr_kk1T-6uHw00emr5Q4Qbo_TPeW_yXkypXA
Message-ID: <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs: allow callers to supply old OIDs for batch deletion
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008ba4e9065bdc0b71"

--0000000000008ba4e9065bdc0b71
Content-Type: text/plain; charset="UTF-8"

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> refs_delete_refs() currently performs unconditional deletions. Thus callers
> cannot preserve old values that they have already resolved, and
> reference-transaction hooks consequently see a null old OID.
>
> Add an optional oid_array whose entries correspond to the refnames. Pass each
> non-null OID to ref_transaction_delete(). Existing callers retain the
> unconditional behavior for now.
>
> Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
> ---
>  bisect.c                  |  2 +-
>  builtin/branch.c          |  3 ++-
>  builtin/fetch.c           |  2 +-
>  builtin/remote.c          |  5 +++--
>  builtin/tag.c             |  3 ++-
>  refs.c                    | 26 +++++++++++++++-----------
>  refs.h                    | 12 ++++++++++--
>  t/helper/test-ref-store.c |  2 +-
>  8 files changed, 35 insertions(+), 20 deletions(-)
>

[snip]


> diff --git a/refs.c b/refs.c
> index d3caa9a633..a9c5397fd7 100644
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
> @@ -3056,36 +3057,39 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
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

I understand that this is intended to fix a bug. With this change,
`refs_delete_refs()`'s behavior has changed from unconditionally
deleting all refs to now only deleting the refs if all old OIDs match.

Doesn't this introduce possibility of a race since callees of the
function who checked the ref's OID before can now expect a failure when
the transaction re-checks the old_oid?


>  	transaction = ref_store_transaction_begin(refs, 0, &err);
>  	if (!transaction) {
>  		ret = error("%s", err.buf);
>  		goto out;
>  	}
>
> -	for_each_string_list_item(item, refnames) {
> -		ret = ref_transaction_delete(transaction, item->string,
> -					     NULL, NULL, flags, msg, &err);
> +	for (i = 0; i < refnames->nr; i++) {
> +		const struct object_id *old_oid = old_oids ? &old_oids->oid[i] : NULL;
> +

Nit: we could add a `struct string_list_item *item =
refnames->items[i];` for a nicer diff.

> +		if (old_oid && is_null_oid(old_oid))
> +			old_oid = NULL;
> +		ret = ref_transaction_delete(transaction, refnames->items[i].string,
> +					     old_oid, NULL, flags, msg, &err);
>  		if (ret) {
>  			warning(_("could not delete reference %s: %s"),
> -				item->string, err.buf);
> +				refnames->items[i].string, err.buf);
>  			strbuf_reset(&err);
>  			failures = 1;
>  		}
> diff --git a/refs.h b/refs.h
> index 71d5c186d0..b76b556cf7 100644
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
> index 3866d0aca4..c2c7dfb065 100644
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

--0000000000008ba4e9065bdc0b71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c583da045a77d9c8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xdTg0WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melZqQy80aVM5dXpaZHo4ZzhxVmZMdDZzcEFhbUhpRgpMN1UvakFKL0Ur
RTZtM2xBcklxYi9DbXJXaDlib0JGQ3dHekdoUmRFb1U4c2RnZ1djYVk5QmNUdnVTOVRDdTZxCmZH
cW8zbkRDVHN3OE14S1pPd1ZNMnR6WEJVTVAwQmQxRFlzYU9FOTV4SVR1VjgvdlVuUU9Bb2NiZ202
ZWVSNWoKcmNCVFZaang0bHovR1pScXlTQkpBb3VtTTBueEgwVWZPSTlaOGM0cGtsblROdVVwQytO
TVFXem4rU3VyaCtIVgowQ211ZEZpNzFDMElIWEgvb3Y3K1JDWHVNS1NBVktJVWlKNDdkM2VDbXIz
RUlvT0Z1UU1TaUVWZW1FY3JmUVAvCjFiSmwwNm9WSERKWStsSm10ODdCZVhjcWMxOVR0cTA1NzQ5
bzd6RHZkeFZIRDJramZIWVhxaEFtUWl2cXl6WkQKZWZHT1lxSE5MZkEvekJTb1ZlS0FlU2R1SnB1
ZFdsMTM1L3FQU3Q5Nk1pbGp1b3FDQW5SYk02RDBsUFQrdWUxRgovaTJLbm1QK2Z3TTNoM0JCZFF3
eStiYXd4YXFUNnA2WUozSE9zOUJodFdHNTFURi92d0N3bGJ5dThPclkwQ1VECncrNTdPM0tVSnlx
QWJuUGxzbUlzbHFFMXRQbTQwZXgxK1RKQnk5WT0KPTRucGsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008ba4e9065bdc0b71--
