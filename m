Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490681;
	b=zV7kpT8bU6lEENVuNeAp6tmOV25fnUK/jbh6py3Y8YVTJmcmnAbJIW3dUCboK00XRjXl
	 Y95JPqPyVsXxV/Rx8cWcMsCWLKqJ1W0s/7agkVnLKQa1rlb12wTgNpOJcanegYFvEhRCJ
	 Tq2gihT1QGlpwbCviA21dCkCQ9ItavbZGe537VIy3fm+GcVLm10NylEfrsK92Uwomlo0Q
	 1G8EoOx+RTdseMYCN81/UtPj3olni2jE4mlNq8CwK2HV6erXoEIXvioOEoC5QogFYpL+p
	 ax0L8gH0dzNq3671O9KaL9a0tJMu1ABm7vZikXuGbNRGpQGJv4aO27YJG86EmM6Eveg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Our5N1HT/HiMmGdI5MB5AHOEiKAQaar2sJP9BaQ5hS4=;
	b=Vy57pZ7pRKCoWZr7vAnNBHRvB/XGMLVMJaTf1AiTJIvW72OShxd0m8P1H1DWNbUl93fe
	 QGqmBUNM3fBgmMO7dpQ2IVu9oq3L2B7ArmIlmzEKUOFppxDTesHrrJTimesKXhFQCwNh6
	 C5mbzeYiGiUsH5VTaR31Nuo6id6hchoLfHiSiksiVSwL04ORMXCkCib//Uvm279aZGsBy
	 4GYVJDe3OTmHUUi6ECe9uruKl94vo0PcYdhRFFGzzIJB7U3kGUCj/8ZpkyzlFNLjm4scc
	 bKGb3zn4NkynKKcdXLOQCR90b+NiRsfxaCTitJpQHIGaihYwkogpISkoKEt6c5G6LEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=haposxhn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECF606A880
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECECF606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=haposxhn
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso1445615e0c.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 05:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794490680; cv=none;
        d=google.com; s=arc-20260327;
        b=qE2JAOpIO5DJwrNUk7LWRRUy+Z46WFn1qcuNux5Hz+aPGQszfVC2kxUN4QWRhszqN3
         W6c0yrzWx4gR2AOb7it08Y3Ut9ZmHdsF8MMRTgwClBSydtFiXnzVR0yTP6rkMkIMUsQq
         U1j2a70GxXrBX+ieUUW7MPMayQlOPCrhFqpzRIPzDDgQb3+kKPpJ8SOpsbIE4j2p7Gfo
         y1XbbklEDKQQQu7dFmYOT1OtkJ5N6wla7X3lZBcADTzJyRe0OnAPM1LyCl9Jfuh6ICgZ
         K1wLPoSdrf0oymcbNn4RmN8gm+HtIl7yUQC47/mP1l8rWvkJaloIt/bVBSz/Zi2X3iix
         bHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Our5N1HT/HiMmGdI5MB5AHOEiKAQaar2sJP9BaQ5hS4=;
        fh=ADj0R9n4hHacn3ZI0gFBYLEy4wny8jGDt7Z9V3p1y9I=;
        b=JdRAd54lTNAbbWhmG99mb3V3g4ek3zsMtJK+j2tQuGzX2et24+LHpe+L5zNLCP6Qzq
         l5UiEzroqvM46cKKL0JsN8EU77SfUHK5eF8rqX3GxrURWc9pk1uZY9MCVdVDH+AaTcsv
         LUdXUF1XyLwv74Ouart24mJ2cQ4EpvbOUT53USwKcv/Sco6Lww1XuwYjM+8N7/J/hwFb
         HSDfVwN+Hy8fH3wU9q9Fj9dHU8t9uqUOagYylq/BnvOy8xCGNsJuFogf+lMUcgvfkqD2
         GrHcfTbIQ+Ktp09j8ifM9y40ZMw07VMD9uJItxG7xGCSWNCi1EFLdXJGiVniW368HIvy
         m93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490680; x=1795095480; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Our5N1HT/HiMmGdI5MB5AHOEiKAQaar2sJP9BaQ5hS4=;
        b=haposxhnOQgs52ywVljtItj0WqsZ1yJ1+VXYnpQJiqygdU8gvz7olFy6ImJG2c+9om
         ecxFSkd2P0LudbusG/0oTADkUePoe/C8W+mwknQbpXNF/Rq5T3s6qYexY74SCE+aqu49
         UlPi7WGge4DeZ/MXahYGI3Vskq6akfCrRwwRmruw1bI0AkJ1KjLZLchHNFZh2rTo4zS/
         YiAa+iE9DxIRY3236Dm/WEzAiFE9cf1cXBWelB34kl8MWpBwAfrypnUBvJkaTPlV7I3J
         cWglN/P8njh4x1x3h1mL+kJa280epjduS9mMRQU2BMQuVrgRAfR5EoetoB57tCY3jIIy
         N+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490680; x=1795095480;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Our5N1HT/HiMmGdI5MB5AHOEiKAQaar2sJP9BaQ5hS4=;
        b=XcrCJqYrBTXQ+mAPc3y2VBnvgGFTwnBoxlhgS4jVfIBUNUmjbAP9cLcHqehnqZEmLd
         avgGKzfqPWCJcR5aNGOVB68Q1WgKcOYIwTaIon3JHEVVEcH3zFasnIroXl+vrfxB+5d5
         kuBFcXZXBv8M1De2oA5TlCVrZ0Hm7FkMsXIijyo2mSPlSaq6KH+CrF0dhO5Oea45XjrG
         WrmMaFodu6Z1xAFpicwUhruWmU/Y40RumknEC/ornA9sdb/S7tlxM16Ry9c1bsYkLcsg
         8z6Q12m4oxyid7ktIllUWVcNzKfSx2QETxpDjkJ9i91W8ZoCVch1GrxUSjmoWnWF+s1h
         +Q+g==
X-Forwarded-Encrypted: i=1; AL+hErGMc7YSiHxfqp4x1NOeHt4EO9/Nhe4ZuwYmyAcx2zqzKaErXarRb3E0hSq6mzK9vtJMd5w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GkJK1xamu3nQ88AppKUjuG47o89AoycyRu1bNiIWWDVF+QNWI
	owXbV3rV5IPdDwC4qj/LUGXi3DffJNae4Aezgt+ZfZe8tKWoV/E8h3eltmAqro8yHOJ4B9s4xH1
	YZJqGjBlFVevTjQ8Gi+Irxw+TuYcsFDWYfw==
X-Gm-Gg: AYBFou2pKbSqlxQXpUafwt3nIaHziXYTakg/xpI33sWYS33+R9nK9/D7lIZeTAL3273
	DRxOvh7IIf+cqg7U7tw58yZWLE5l8nTEuBeuNBDhgSmhfyKQ5rxP170i8nay7CGwQiRoaObN9c7
	Z+Ztm1hyhdxwt8gmUSxoYtdmmtmXASQKwX+Pia11ddp3U1GneXRDr130PjTEbXJib1fuCuRI/PT
	ZE8d4+AiON16fVX6NX45FPvjTHqO//rW4cPIGKqSmSBqpE3EXPP+ibpORMe2cPRiBlOTOlogktK
	DA9/pCDSqv5hfnUpll/sGIoSLIaqk4SoJhs5bStkjIJRhbHRKEZm4DAqb9megVQWvoDSavw0efS
	KeBQWDZr/HGk6IsIkFILS9KMMzbfNhKfgNx0FP2zNtaQe0/opDqz7hM6EaB1bZ8iVjVwz9P8Jdm
	5obg9/H8SS1kp32oqjMOHxEZwcxhU=
X-Received: by 2002:a05:6122:62e6:b0:5c9:a60b:e5bd with SMTP id
 71dfb90a1353d-5ee1c414946mr2043038e0c.13.1794490679808; Thu, 12 Nov 2026
 05:37:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 05:37:58 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261110133457.43700-1-inoue.tsukasa.4@gmail.com>
References: <CAOLa=ZTYevwM0YF0iQFnEwKG_buV7qg0QdjoaTkw0c8OQSd-mQ@mail.gmail.com>
 <20261110133457.43700-1-inoue.tsukasa.4@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 05:37:58 -0800
X-Gm-Features: AclHuK8EhG41U93CagtYGQ5ks4XXi5_x6S0Y3rof482wEkuM9Oyd10JQmSM43Rg
Message-ID: <CAOLa=ZQ559k_jrSrubdRcZofxLT+Fj=fi_e6BY=e2KJX_OJRag@mail.gmail.com>
Subject: Re: [PATCH] refs: fix reflog of a symref whose target is in the same transaction
To: tsukasa inoue <inoue.tsukasa.4@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000085fd4d0660146bbe"

--00000000000085fd4d0660146bbe
Content-Type: text/plain; charset="UTF-8"

tsukasa inoue <inoue.tsukasa.4@gmail.com> writes:

> When a transaction updates a ref and also points a symref at it, for
> example
>
>     update refs/heads/y <new>
>     symref-update HEAD refs/heads/y
>
> the reflog entry for HEAD should record <new>. Both backends get the
> value for that entry by resolving the target with
> refs_resolve_ref_unsafe(), which reads the refs as they are before the
> transaction is applied.
>
> The reftable backend writes all updates into one table at the end, so
> it always sees the old value of y. When y is created by the same
> transaction it sees no y at all, takes the symref as dangling, and
> writes no reflog entry. The files backend commits the updates one at a
> time in the order they were queued, so it gets it right only when the
> update of y comes before the one of HEAD.
>
> Add ref_transaction_resolve_new_oid(), which takes the new value from
> the transaction when it updates the target, following symref updates
> within it, and reads the ref store otherwise. Use it in both backends.
>
> Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
> ---
>
> Notes:
>     This follows up on the report at
>     https://lore.kernel.org/git/CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com/
>
>     As discussed with Karthik there, this only moves the lookup of the
>     target's new value to refs.c. Moving the rest of the reflog logic out
>     of the backends, and resolving conflicting updates within a single
>     transaction, are left for later.
>
>  refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++
>  refs/files-backend.c    | 10 +++++----
>  refs/refs-internal.h    | 12 +++++++++++
>  refs/reftable-backend.c |  9 ++++++--
>  t/t1400-update-ref.sh   | 36 +++++++++++++++++++++++++++++++
>  5 files changed, 108 insertions(+), 6 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 951db56113..3a5c225fc9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1388,6 +1388,53 @@ struct ref_update *ref_transaction_add_update(
>  	return update;
>  }
>
> +static struct ref_update *find_ref_update(struct ref_transaction *transaction,
> +					  const char *refname)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +
> +		if (!(update->flags & REF_LOG_ONLY) &&
> +		    !strcmp(update->refname, refname))
> +			return update;
> +	}
> +
> +	return NULL;
> +}

Can't we use `string_list_lookup(&transaction->refnames, refname)`,
which is a sorted list and uses a binary search.

> +
> +int ref_transaction_resolve_new_oid(struct ref_transaction *transaction,
> +				    const char *refname,
> +				    struct object_id *oid)
> +{
> +	int depth;
> +
> +	for (depth = 0; depth < SYMREF_MAXDEPTH; depth++) {
> +		struct ref_update *update;
> +
> +		update = find_ref_update(transaction, refname);
> +		if (!update)
> +			break;
> +
> +		if (!(update->flags & REF_HAVE_NEW) || update->rejection_err)
> +			break;
> +

So `update->rejection_err` would be set only if the reference update
failed. This would only happen if it was applied before the reflog
update. What about reference updates which fail after the reflog update?
Would it make sense to schedule all reflog updates to the end, this
would mean we know the status of all reference updates by then.

> +		if (update->new_target) {
> +			refname = update->new_target;
> +			continue;
> +		}
> +
> +		if (is_null_oid(&update->new_oid))
> +			return 0;
> +		oidcpy(oid, &update->new_oid);
> +		return 1;
> +	}
> +
> +	return !!refs_resolve_ref_unsafe(transaction->ref_store, refname,
> +					 RESOLVE_REF_READING, oid, NULL);
> +}
> +
>  static int transaction_refname_valid(const char *refname,
>  				     const struct object_id *new_oid,
>  				     unsigned int flags, struct strbuf *err)
>  					 * symref updates. It would be nice to capture this as

[snip]

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 1a164c96f9..19f0987d2f 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -853,6 +853,42 @@ test_expect_success 'stdin delete symref works option no-deref' '
>  	test_cmp expect actual
>  '
>
> +for action in update create
> +do
> +	for order in branch-first head-first
> +	do
> +		test_expect_success "stdin symref-update HEAD logs target's new value ($action, $order)" '
> +			test_when_finished "rm -rf repo branch-cmd head-cmd" &&

We could use a subshell, cd into it and then we don't have to
1. Do `-C repo` everywhere
2. Cleanup 'branch-cmd' and 'head-cmd'

> +			git init repo &&
> +			test_commit -C repo one &&
> +			test_commit -C repo two &&
> +			new=$(git -C repo rev-parse two) &&
> +			if test "$action" = update
> +			then
> +				git -C repo branch topic one
> +			fi &&
> +			echo "$action refs/heads/topic $new" >branch-cmd &&
> +			{
> +				echo "option no-deref" &&
> +				echo "symref-update HEAD refs/heads/topic"
> +			} >head-cmd &&
> +			if test "$order" = branch-first
> +			then
> +				cat branch-cmd head-cmd >stdin
> +			else
> +				cat head-cmd branch-cmd >stdin
> +			fi &&
> +			git -C repo update-ref -m "move HEAD" --stdin <stdin &&
> +			echo "move HEAD" >expect &&
> +			git -C repo reflog -1 --format=%gs HEAD >actual &&
> +			test_cmp expect actual &&
> +			echo $new >expect &&
> +			git -C repo reflog -1 --format=%H HEAD >actual &&
> +			test_cmp expect actual

Nit: A few newlines to separate out blocks like the first few lines are
setup and so on, could help readability :)

> +		'
> +	done
> +done
> +

We should also probably add tests which use
`REF_TRANSACTION_ALLOW_FAILURE` and check if a given reference
update fails and do we apply the new/old value for the reflog then.

>  test_expect_success 'stdin update symref works flag --no-deref' '
>  	git symbolic-ref TESTSYMREFONE $b &&
>  	git symbolic-ref TESTSYMREFTWO $b &&
> --
> 2.56.0

Thanks for the patch. Some small comments from me.

--00000000000085fd4d0660146bbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6a6cc21ce7c943c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMXdUUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHo1Qy85VFNuVTJLOE9naUhPZlFpdnFuZ3VGaW55OAovMVBueDlRaEdU
R2xXRUwzQURyZ0VoSC9NbjRneWZYUXBjWXBOME0xL3ZlVkk1b25nK0dla0dpY25HMVZseGRuCkJq
b2hTM0Y1K2RDSFZaUVlCUHZQbU5YVk1SMkNaaHRQYVFsMlVaTWJVRVFqLzZ3eWdwaUhrTHBWWWFR
Nk5nekYKRHU5dWdUMW13R0JkSW5PRWh6TUJaVWZXSC92MGh5QkpORVpSamdKZm1IL3lTazdFaC90
SFZtOWdqZXFWZVVxQQpvQTVuQVlwbGZKTDlGRUdzeEtBa0xZdFNTekZjN200VVQybktiTWtDbHhs
V2ZIakIrQytkbzhjZWRkSHRxVTl4CmVWZjJTK2VDU3dmKzljdXkxRHdnaDVYa3lkNHRyRmdleDhi
SnYvbDh1OEd1WWZTSmw3UEN0bHpSV3Q2anYyQ0kKMGZjY1E5M0hTWWZDV2gydEI1K0NvejNLRXJl
QlBZUFBsdjhQeEpGdm9ncUFDSnlYTzJ2ZjJyWkJxS1JPN2NLUwp6aUNyS3NEVVprUGZsaGdDMmcr
dzliTkNZeHZIUVVobmNJZnVVTzErMmRJeTBPRWdlZVdZaW45aEp4QitFS2NnCk9BSkFKWTY5RnZU
cVVhcUxlMjdCQSszM0o4STFRY2MxOUlodUU3UT0KPU1SSkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000085fd4d0660146bbe--
