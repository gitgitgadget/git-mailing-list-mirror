Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A9802
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402515; cv=none; b=ht01potnH1IiexrgAn3RnhqZX0+9UPuJa1wpzKHxh6motUjpi4leY4A6Z/CFalO8I8yw4wpqjy6YW8GGte2VNX62R1BlA43s6TsGaeABZWyyrxZnq7ae70lKKfmDyXvISllABRAIgDTDyzzdTr8cGSPn8+0rtu3vWNPYOxi6xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402515; c=relaxed/simple;
	bh=cxKkNFS/Opb+x28D6Q2JGgTPUWkYB0yuB7LU/o1JdjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru/dQjVi4lcsaRd0FnuiZ9L19o2QzGzQKlUni5RQ2wMN+WL+a11VOkWwb2/tQv2U/YazoQimBtNCxbeFwPA53hnkdwr8xYhU8bWhayTYT6CrWRfsaYY40tW8OXy7Q8OUvMCZNDZizu9+7UnvukYdNRNUrksMVuL3XCd1hHv3huE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaTI1y63; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaTI1y63"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212a930001so3435535ad.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 05:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740402514; x=1741007314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrWw5G9dT5tJhs4+LobY/LtQwR3opsFMZvW6R5TBtJs=;
        b=FaTI1y63BQPrWzfDrtA/xZy6vvMs54GL4bKGHG9lW2uiliakit8rcXSn4CARFP+mhy
         idvFy0m3KbuLYf5CMqY2bkRFA7udlml4nWGNWtcBZZSaLxn8+1CT/w3vvJC1jmJ2vyYH
         JHvKPHTnvS4cabFsdcK9ebrSSnVtQzSH+7qCQ1kWaCzcYMxAEA4EOAdwWgDNLJ4HnxWE
         u/L1chrUFVrZ5VNbkTNgY0/RrUBqFjlMCz8sH59oDccGSsgMwqowQPlL/6NfHwQKx/rm
         h4l1dSsDe1HM+bXCUl/85c7GtUen45DLlGiwJXqzZyPAJ0okMaCEEFKA7WraO3J8zIfe
         Fpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402514; x=1741007314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrWw5G9dT5tJhs4+LobY/LtQwR3opsFMZvW6R5TBtJs=;
        b=d3z5mPJdZm4jg+3JlueSqf3riMQBZ2RCaba1+i9Hw+WcxUlfJK9z2ZITZ3ZKb4Tc6r
         6CKKwNujiRd56bOJyktoI3kUfIIeoGn6N8C0SxwZ6Y4sDZ8IqlntqGc4hX58tpmmjlHI
         11cNsVQIMywsFO1j6Hg/3oU8HYqUJ7Soa4EQrYukQYDaYog06JeP7cTK43fpitOtknWG
         aJsvSk5OcL/meWWDr8gCW6Czwe7hSU+N6b9rxZA4NVsKQ+y9OP1/MCANWrko21cYCHiE
         EYFHvIcPbtfTQMcnSm4h25rEPf5m+JFEs3PBGAG6+ByqYJ2ZWYX6g60Eqf5qA0tZP66F
         /RYQ==
X-Gm-Message-State: AOJu0Yyla/RfcGvQlD84s8QXUh81LHf2unxmPpuSkFbkg7XxapwyiSyp
	ZmW2RWdgvSq2Uv5M57m5WsiXISMeb0CNV9mLFZhlb4ZY/Ofc0etC
X-Gm-Gg: ASbGncuPZp8hTDlwbX4WDyVMhlXpJWVc1jZA3zp7u3rMnqITenBwkQwJfkNHSk2g4nH
	KkPjxuq+jwyM5gMOXsMnhqQuMPtwRvMEUxgHDrGTDuXZu9EHOkLLG5qrObAXUmmyXoheDcSfcVL
	CiD1u8fcsRUSxwgYSbbGoQl45Ntl+tZUFKU03yU3PPBLvKsyMKAcHsfckfrn44ApbPKiQQ5B26d
	neT6e42zBjTi2oTRZAlreFw/IM/uuQGW754Gf1mGVyqrp5Dv7ssrtT45s4qvOnrH3HktEjOQgrN
	OM+kIcYW5K8MOxpGrr7TOw==
X-Google-Smtp-Source: AGHT+IFQzp5xYS7a9RT3S98nwupTjz5eZYnc/K23Wai6ajtD7Q/GUnCqqVCtwqopnXMqoSS5xVVYJQ==
X-Received: by 2002:a17:902:eccb:b0:220:ea90:1925 with SMTP id d9443c01a7336-221a1148e99mr234709845ad.35.1740402513569;
        Mon, 24 Feb 2025 05:08:33 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2211eafd20dsm130873185ad.182.2025.02.24.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:08:32 -0800 (PST)
Date: Mon, 24 Feb 2025 21:08:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 10/16] refs/iterator: provide infrastructure to
 re-seek iterators
Message-ID: <Z7xvWPjHjppNp167@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-10-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-10-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:37PM +0100, Patrick Steinhardt wrote:
> Reftable iterators need to be scrapped after they have either been
> exhausted or aren't useful to the caller anymore, and it is explicitly
> not possible to reuse them for iterations. But enabling for reuse of
> iterators may allow us to tune them by reusing internal state of an
> iterator. The reftable iterators for example can already be reused
> internally, but we're not able to expose this to any users outside of
> the reftable backend.
> 

Out of curiosity, is there any benefits for reusing iterators for files
backend?

> Introduce a new `.seek` function in the ref iterator vtable that allows
> callers to re-seek an iterator. It is expected to be functionally the

It's a bit strange that we use "re-seek". I think we just want to see an
iterator. Isn't it? Don't worth a reroll.

> same as calling `refs_ref_iterator_begin()` with a different (or the
> same) prefix.
> 
> Implement the callback for trivial cases. The other iterators will be
> implemented in subsequent commits.
> 

[snip]

> @@ -368,6 +381,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  	return ok;
>  }
>  
> +static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
> +				    const char *prefix)
> +{
> +	struct prefix_ref_iterator *iter =
> +		(struct prefix_ref_iterator *)ref_iterator;
> +	free(iter->prefix);

Here, we need to free the "iter->prefix". We don't know whether the
caller would call `prefix_ref_iterator_seek` many times for the same ref
iterator. So, we need to restore the state/context.

I want to ask a question here, why don't we care about "trim" parameter
which is declared in the "prefix_ref_iterator_begin"? From my
understanding, we may want to reuse "trim" state in the original state.
So, when we want to reuse iterator, we only consider about the "prefix"
but leave the other stats the same. Is my understanding correct?

> +	iter->prefix = xstrdup_or_null(prefix);
> +	return ref_iterator_seek(iter->iter0, prefix);
> +}
> +

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 74e2c03cef1..3f6d43110b7 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -327,6 +327,21 @@ struct ref_iterator {
>   */
>  int ref_iterator_advance(struct ref_iterator *ref_iterator);
>  
> +/*
> + * Seek the iterator to the first reference with the given prefix.
> + * The prefix is matched as a literal string, without regard for path
> + * separators. If prefix is NULL or the empty string, seek the iterator to the
> + * first reference again.
> + *
> + * This function is expected to behave as if a new ref iterator with the same
> + * prefix had been created, but allows reuse of iterators and thus may allow
> + * the backend to optimize.

I somehow think we may emphasis that we want to reuse some internal
states of the ref iterator except the prefix. However, I am not sure.
Just think about this.

> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int ref_iterator_seek(struct ref_iterator *ref_iterator,
> +		      const char *prefix);
> +
>  /*
>   * If possible, peel the reference currently being viewed by the
>   * iterator. Return 0 on success.
> @@ -445,6 +460,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
>   */
>  typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
>  
> +/*
> + * Seek the iterator to the first reference matching the given prefix. Should

Maybe which should?

> + * behave the same as if a new iterator was created with the same prefix.
> + */

This statement makes me a little confused. I think there are something
difference between `seek` and `begin`? For prefix ref iterator, we will
pass "trim" when calling `begin`, but for seeking, we don't care about
"trim". Although the prefix maybe the same, but the internal state may
be different.

Thanks,
Jialuo
