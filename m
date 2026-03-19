Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922A3E9F73
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937683; cv=pass; b=rlfRlQlTa4Ydv/bAmcrqOpsrATl/e2hlPOActGSZpH7WsPR4bwIlHFAv2PI1hbdyF0+18PnzsaIAkAT0xWKucTCUIYcOWzs4aVinqUzSrl5h41vQw08nzA20d4ISTGar1yRkZWg9s5wtHN/Z2PaK0rufeNa/ONZby3/wqbkaEMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937683; c=relaxed/simple;
	bh=c2IebNqhh2+heTHCnOEAcAcr56qHXa0V6ItKGdZDNcQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LSuwVou2WOuGuGUsIaERswhtVOvQBKshEsOXv+UfbRAY75G/TnYkkjteNHxIYV0UsAdj/hjxpGXHZ+czSe9usdyMZm5FaPB7+uVLBGjMbBkY+5ky0iEHATzEqwL5sUIg5epZKlEDpHMocc5NLyV6jUXjRSk7d30Ns98B5686LU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwdiHch2; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwdiHch2"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94de664b541so329190241.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773937673; cv=none;
        d=google.com; s=arc-20240605;
        b=VgiIwxgDNc48QlQIHnNWyDZNuO531DWisbdea36Jog06mki+oB3jrYR4dIvxtkN+O0
         hXTqwYcFMiaEXafokUvtJpFbs1XQu4vTmGSF022p9sQMXX+SVF07KTwoT4cCCalFvHfE
         8eM2ps9g/NfxlTGBJLKNVH4F1AP4bqkuzExnSRRrGNaExyA45JAtLVhqQ4HkUiabsZ/v
         b8FLWB4AjBAdslMH07To4S1uhd7q2VDhiPutKM0/SygL304cfzku/Steh1HAYa+L3dmc
         w2raCw5ve7FALhMuDfKcnGizyt44ulqlp8ySyrqko1yS9LJe31ko0UzN2bxfDy8ECKEw
         N8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=C1gghrlxGD060tsI0Y/iBiWvSfZnRPkQzqJ0MjnwfhM=;
        fh=v+xrLZWTvKhOsfNG+i3c0GvqmokEZMUl6rd1Irm6Sr4=;
        b=V6u+N+FlwQshmJzqvSquB8e0VlPjMOvSV4upOxbLmMuIvL5eEeZV4uWGF7GL24z48u
         HSOsJAALXWrtx8YuTe6+cnekuLZsNdrZLBIFCEqDGjTpr9xQTdgWlNNyw6UBx3ensSbZ
         Td4lESpyeMYaXcH9PyVMy8fwxxtiCwloy8GMs1/m9HFO7U+eC8eIvWTBz7ewjN2feeNF
         5esjKvs5vIOmIzK3u8dpOwo4T13mlC7ae8LGfT8v4bX915fPV5pdHW0GJC+ehiZ3j2NR
         XbThZQ+VqBfvnYxe0tHpXcZUaC852urdp58L2wcsIw/3b5weTa8MBIzKQ3ekdppvNX5M
         kdIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773937673; x=1774542473; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1gghrlxGD060tsI0Y/iBiWvSfZnRPkQzqJ0MjnwfhM=;
        b=KwdiHch2hSGulPuLu4C2C8WbpjfWuDW61GUSGyx20bXJxWkNxa2f1rN9iuWw9j0RCk
         BJaWO0AR44vchpUgdOif9ocJZAxfwLiVtcwRxJtVZ24L5jLCvhKXbUfUlOm4wVUJCPJM
         0oj/qahAQ749qF1LFGKFEpY+LfKX3sO7vcRndAQGrbU9vbVOL2/Kwj/n/OKFJImb2rZg
         UCOltjvf8EEvPoM+3SpqEZP0aRF9ZUrrmXJemLzxX6EzvNUV1481paI3XqKTZ5oCIjCy
         F0c0eJmlqo1QXUOwQIK1VOeIPFyFJcaHM3vXl3SusGaqNPxJFnmp1Ztb4gUWW1KYpRnq
         IFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937673; x=1774542473;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1gghrlxGD060tsI0Y/iBiWvSfZnRPkQzqJ0MjnwfhM=;
        b=TSLMIoIVf5p1NGC/6KGTIKIo/F0p9Nv+gUk8uCdV70VuPdZ+TYY8PubHrMVP+LTLYu
         VxeUO+PW8/m4P9Xo4mA1HfCN3xrt2+uQa2LHd1B8LRk+BPttJaFQVoxSyQe58uWmEZP8
         JJ8Q+MZpY+Km1DPyEKwY0Bs+DbqhKIh1UrbWOU0x/QCpQebJavl+hNNW7P1X15TUWAho
         Fr8TyHbmOxl9R4LmvtzEQYeN68kVFUGGspxOJB/v6KXb2DsSua6mIEYlKnZLrrvr5t/n
         KNdm0a3hrWPGPosoDVyGNjfIsRJdUOWJiEehghV6BY+vn58hz6YBGGazciDkeSLIEFUH
         1QEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx3Xj+u+jBni47wcxDRhBtsgQYjMOFQ+FE3vaYgELW+JusDXe1TwYWP9eG+9bxqwd6Ep0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LjgM05NimVFd3VneZ6SbfANdyNme9bHHmrTswPZYb3wJkcGi
	7h32zxc3rPva4kaxvLrPmsjL5HT13mwhTUebKvrUE8eNQh5nGlijol6X/KARtgPvszFw9sT0Pp7
	I5+sA1I1qQzIyQIV2bpAyHaKcdzLzJkv+8Q==
X-Gm-Gg: ATEYQzwBDao2tudtaT7tVrWg8zXQFJtf3oIeKdz0gQsrVpPEY7VyJh8wlKmvgQGPAh/
	8BYe77fkfA2fqsCQe+gpQ3l31q4SGeQsmHg+lAVwBOgpUcB/sv7X9ZS+lfCCIXw6WcUpWJqwTYU
	Z/ODd7xn1RZ/AeZ1PB5MZ73WaAsn7S/c9aqCJTQaubkHb4yLxFH7AuY5SruP9oA3zHy0NI+OmNX
	zQ2Xoy7hM8h5XhOf9fZwZjngBzFUyx/kWiQFMDyRNLPTgKAi9YUo7jtVTLtwM/FYVKjwc5Z2Djm
	KML7E3Ma9H2w5eWNWcN3ooczAToioMGYuYQEWzZUXA==
X-Received: by 2002:a05:6102:cd1:b0:602:a651:11d7 with SMTP id
 ada2fe7eead31-602aeac9137mr89616137.7.1773937672811; Thu, 19 Mar 2026
 09:27:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Mar 2026 09:27:51 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Mar 2026 09:27:51 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-2-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im> <20260319-b4-pks-odb-source-abbrev-v1-2-5ddebad292b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Mar 2026 09:27:51 -0700
X-Gm-Features: AaiRm53e7E7_-iCG7hEgMsZ1hD-gLd64iX8VbHYEQDhp_HruFGmZ2iLElI52JJg
Message-ID: <CAOLa=ZQFUH4k5xDqv0rozSXcbsGFsUzVa-fnzfcb=+957zwHRg@mail.gmail.com>
Subject: Re: [PATCH 02/14] oidtree: extend iteration to allow for arbitrary
 return codes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d79023064d630c67"

--000000000000d79023064d630c67
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The interface `cb_each()` iterates through a crit-bit tree and calls a
> specific callback function for each of the contained items. The callback
> function is expected to return either:
>
>   - `CB_CONTINUE` in case iteration shall continue.
>
>   - `CB_BREAK` to abort iteration.
>
> This is needlessly restrictive though, as callers may want to return
> arbitrary values and have them be bubbled up to the `cb_each()` call
> site. In fact, this is a rather common pattern we have: whenever such a
> callback function returns a non-zero error code, we abort iteration and
> bubble up the code as-is.
>
> Refactor both the crit-bit tree and oidtree subsystems to behave
> accordingly.
>

Okay so this patch simply irradiates the need for a specific enum to
replace it the standard where non-zero error code stops the iteration.
Okay makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  cbtree.c                 | 21 ++++++++++++---------
>  cbtree.h                 | 11 +++--------
>  object-name.c            |  4 ++--
>  oidtree.c                | 12 ++++++------
>  oidtree.h                | 18 ++++++++++++------
>  t/unit-tests/u-oidtree.c |  4 ++--
>  6 files changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/cbtree.c b/cbtree.c
> index cf8cf75b89..4ab794bddc 100644
> --- a/cbtree.c
> +++ b/cbtree.c
> @@ -96,26 +96,28 @@ struct cb_node *cb_lookup(struct cb_tree *t, const uint8_t *k, size_t klen)
>  	return p && !memcmp(p->k, k, klen) ? p : NULL;
>  }
>
> -static enum cb_next cb_descend(struct cb_node *p, cb_iter fn, void *arg)
> +static int cb_descend(struct cb_node *p, cb_iter fn, void *arg)
>  {
>  	if (1 & (uintptr_t)p) {
>  		struct cb_node *q = cb_node_of(p);
> -		enum cb_next n = cb_descend(q->child[0], fn, arg);
> -
> -		return n == CB_BREAK ? n : cb_descend(q->child[1], fn, arg);
> +		int ret = cb_descend(q->child[0], fn, arg);
> +		if (ret)
> +			return ret;
> +		return cb_descend(q->child[1], fn, arg);
>  	} else {
>  		return fn(p, arg);
>  	}
>  }
>
> -void cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
> -			cb_iter fn, void *arg)
> +int cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
> +	    cb_iter fn, void *arg)
>  {
>  	struct cb_node *p = t->root;
>  	struct cb_node *top = p;
>  	size_t i = 0;
>
> -	if (!p) return; /* empty tree */
> +	if (!p)
> +		return 0; /* empty tree */
>
>  	/* Walk tree, maintaining top pointer */
>  	while (1 & (uintptr_t)p) {
> @@ -130,7 +132,8 @@ void cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
>
>  	for (i = 0; i < klen; i++) {
>  		if (p->k[i] != kpfx[i])
> -			return; /* "best" match failed */
> +			return 0; /* "best" match failed */
>  	}
> -	cb_descend(top, fn, arg);
> +
> +	return cb_descend(top, fn, arg);
>  }
> diff --git a/cbtree.h b/cbtree.h
> index 43193abdda..4f644d6e45 100644
> --- a/cbtree.h
> +++ b/cbtree.h
> @@ -30,11 +30,6 @@ struct cb_tree {
>  	struct cb_node *root;
>  };
>
> -enum cb_next {
> -	CB_CONTINUE = 0,
> -	CB_BREAK = 1
> -};
> -
>  #define CBTREE_INIT { 0 }
>
>  static inline void cb_init(struct cb_tree *t)
> @@ -46,9 +41,9 @@ static inline void cb_init(struct cb_tree *t)
>  struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
>  struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
>
> -typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
> +typedef int (*cb_iter)(struct cb_node *, void *arg);
>
> -void cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
> -		cb_iter, void *arg);
> +int cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
> +	    cb_iter, void *arg);
>
>  #endif /* CBTREE_H */
> diff --git a/object-name.c b/object-name.c
> index e5adec4c9d..a24a1b48e1 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -103,12 +103,12 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
>
>  static int match_hash(unsigned, const unsigned char *, const unsigned char *);
>
> -static enum cb_next match_prefix(const struct object_id *oid, void *arg)
> +static int match_prefix(const struct object_id *oid, void *arg)
>  {
>  	struct disambiguate_state *ds = arg;
>  	/* no need to call match_hash, oidtree_each did prefix match */
>  	update_candidates(ds, oid);
> -	return ds->ambiguous ? CB_BREAK : CB_CONTINUE;
> +	return ds->ambiguous;
>  }
>
>  static void find_short_object_filename(struct disambiguate_state *ds)
> diff --git a/oidtree.c b/oidtree.c
> index a4d10cd429..ab9fe7ec7a 100644
> --- a/oidtree.c
> +++ b/oidtree.c
> @@ -71,7 +71,7 @@ struct oidtree_each_data {
>  	uint8_t last_byte;
>  };
>
> -static enum cb_next iter(struct cb_node *n, void *cb_data)
> +static int iter(struct cb_node *n, void *cb_data)
>  {
>  	struct oidtree_each_data *data = cb_data;
>  	struct object_id k;
> @@ -80,18 +80,18 @@ static enum cb_next iter(struct cb_node *n, void *cb_data)
>  	memcpy(&k, n->k, sizeof(k));
>
>  	if (data->algo != GIT_HASH_UNKNOWN && data->algo != k.algo)
> -		return CB_CONTINUE;
> +		return 0;
>
>  	if (data->last_nibble_at) {
>  		if ((k.hash[*data->last_nibble_at] ^ data->last_byte) & 0xf0)
> -			return CB_CONTINUE;
> +			return 0;
>  	}
>
>  	return data->cb(&k, data->cb_data);
>  }
>
> -void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
> -		  size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
> +int oidtree_each(struct oidtree *ot, const struct object_id *prefix,
> +		 size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
>  {
>  	struct oidtree_each_data data = {
>  		.cb = cb,
> @@ -106,5 +106,5 @@ void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
>  		data.last_nibble_at = &klen;
>  	}
>
> -	cb_each(&ot->tree, prefix->hash, klen, iter, &data);
> +	return cb_each(&ot->tree, prefix->hash, klen, iter, &data);
>  }
> diff --git a/oidtree.h b/oidtree.h
> index 0651401017..2b7bad2e60 100644
> --- a/oidtree.h
> +++ b/oidtree.h
> @@ -35,16 +35,22 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid);
>  /* Check whether the tree contains the given object ID. */
>  bool oidtree_contains(struct oidtree *ot, const struct object_id *oid);
>
> -/* Callback function used for `oidtree_each()`. */
> -typedef enum cb_next (*oidtree_each_cb)(const struct object_id *oid,
> -					void *cb_data);
> +/*
> + * Callback function used for `oidtree_each()`. Returning a non-zero exit code
> + * will cause iteration to stop. The exit code will be propagated to the caller
> + * of `oidtree_each()`.
> + */
> +typedef int (*oidtree_each_cb)(const struct object_id *oid,
> +			       void *cb_data);
>
>  /*
>   * Iterate through all object IDs in the tree whose prefix matches the given
>   * object ID prefix and invoke the callback function on each of them.
> + *
> + * Returns any non-zero exit code from the provided callback function.
>   */
> -void oidtree_each(struct oidtree *ot,
> -		  const struct object_id *prefix, size_t prefix_hex_len,
> -		  oidtree_each_cb cb, void *cb_data);
> +int oidtree_each(struct oidtree *ot,
> +		 const struct object_id *prefix, size_t prefix_hex_len,
> +		 oidtree_each_cb cb, void *cb_data);
>
>  #endif /* OIDTREE_H */
> diff --git a/t/unit-tests/u-oidtree.c b/t/unit-tests/u-oidtree.c
> index def47c6795..d4d05c7dc3 100644
> --- a/t/unit-tests/u-oidtree.c
> +++ b/t/unit-tests/u-oidtree.c
> @@ -38,7 +38,7 @@ struct expected_hex_iter {
>  	const char *query;
>  };
>
> -static enum cb_next check_each_cb(const struct object_id *oid, void *data)
> +static int check_each_cb(const struct object_id *oid, void *data)
>  {
>  	struct expected_hex_iter *hex_iter = data;
>  	struct object_id expected;
> @@ -49,7 +49,7 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
>  			 &expected);
>  	cl_assert_equal_s(oid_to_hex(oid), oid_to_hex(&expected));
>  	hex_iter->i += 1;
> -	return CB_CONTINUE;
> +	return 0;
>  }
>
>  LAST_ARG_MUST_BE_NULL
>
> --
> 2.53.0.1055.ga2ffed1127.dirty

The patch looks good.

--000000000000d79023064d630c67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8c0026a9e86b48e6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOEpBVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekFCQy85dmpXVzN6UEw4ZTl6VWEvSjkvR0tnQ3lMQQppY0wrM09XRlNv
ZmFIU25QT2djc2VvdHJ3L0JEOTR1ZVU3NzU2emc0WHllaUxGWkZtRmFaWlRyRndHVnhFc2RICmFz
dE5uOTIwa0RQNzl5bkpCUmNrbnFWZzIyNEowMjRsRklRd2gzeGwyT3FDR3RnbDZyalFJL29Hc3BS
VGtQamEKM20vVnRsMk1SbkdiN0NLUU0xdGpidm1iOXpvVENYMjNWVCs0VzFrQm4yeDVJd3lmbW50
RDg0T2pkR3ErcjQ2ZQpMZlJxbnhFWTd0dFFwcUhGL2Z1WWRTS3A3eXpCYXpjbXk0bTNxNUgzNHI3
MUNkNWhMMjcvZkNuc2Z2MXJSSE5WCjEyRis0UnRxMDV3RmJ3WnVVaWxRNWlBYXdVWGJrU2Z2ZVI3
Syt4S1RJZk51TXZWTkdnUi9vbS9kaGNic0NrY0kKam5mY2U1RWNQdjliTnNYcWxmcUZEdWM3Y1ZI
OHpwR1FPMVpSRmNtVUduanExK3FpWnpzK0RBL3VtRG9lWHRiTwpaSzg2NlFRRkJJeU9xM2NvejMy
NXV2TUg3MWw1bGhoc0RRMGdpQ215QlVvYTVVR3VHNXFTdmh3Q3dpZVd1dGVyClo2bkhlZFMvb1dx
VGxkUW03Sk1Ua3BmZ0FBMzQ3YnFMOXVUMVQ3ND0KPUxlSkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d79023064d630c67--
