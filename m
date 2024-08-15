Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCF1AC890
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719852; cv=none; b=GBhBbvt1SOTbC+oUQ83gaA6tV8Zg+MIy89NFRObpDTcAwfh5rqtULTo/GvfWXywD7dD1dJue5hBqZPMkeAh4OSKYuoVDBCfcA5CIkj3RD9wFUKbopFf2qiXWNETcwTRO/kmJOY+erjAEQU+7bJXW7ug/GRlQE71Xj8jjYGDciQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719852; c=relaxed/simple;
	bh=nqepZnefSs4T/sc5dcQGp1TDzq0v4gni4FDM1ifkYyg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6ey85QW4TuqLvy96+Pj7LsjBGgqIOHE4xiYMVjC0BvN1ubl/YUPuULKQAgRvX9jvVxVCPJ2bhzH3xEweCcWM+lkf23CmiQW9cutXRHFG4gOKRgIj1HOxiXp3xaQJGQ3h6o6IZh5npQOGmC+AVhsv/NCuLkRs9H9GZiZGFizRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIYvYl4v; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIYvYl4v"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5da6865312eso486939eaf.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719850; x=1724324650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RlXbWY6x/IDy+cbIpYDFgr7LG+488ZIrghQqqi5a82A=;
        b=iIYvYl4v8UPeJymaky+TlhKH/tILpRmyQpUJAlnhLOaEeoBskIBmiiuuuAGCnHIhYZ
         EFa7m7VOxaQahRlUJCqVlIsNMUplNESIGoq7p1CCrri11Rb65Hxe+XLeMGCUy4R05t2/
         5fUdnVo1cMCZrhbDAFRw07AgbadVkp2mHv+1LEoPKbmF9ivCGQ8n6yUtWKMBJv9sRani
         It3HMQ1lAwhWQxuh2Lxnlph7sny8Qc/Yao42zs96RMDm201FhRTiT3zcwk9kI62xLBSS
         coj9gbU5t5OqPl/bNwzyRh6Of9rGkph3Vtdi0/CfWHrUPRMPyLsUENMByuklRG2PMzWe
         py4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719850; x=1724324650;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlXbWY6x/IDy+cbIpYDFgr7LG+488ZIrghQqqi5a82A=;
        b=MLHqXtO8TWxo/7xTV1vTZlRcs2op4IVnp++RieEVttYY8TIETML+jHls0z3W3uQmd5
         3aNDIy6CzUQxO065RIYsNvYomndk8+Vl5WODYXMbt7SjCcOs6uCfuVMgLxH6cEO2lj6I
         G4GHu9DB2NBiVHnE482GsQpGPbHNGpeEMvPfIV3Eu/+hipMB17z+p0Z3q9y5zBA5J2I8
         e2rVqAxO+OII6EOUVnQXjKRDVbXze1yeL0BA5zI6Ze7iW2hzxhBYZulb1a+gBNUVBrq5
         waht5X/UyItpvia0J+q+FNtxnOB5XezQ2uoYZM7pf0HN+p6+vmF6VqRdNEhLKCof2vU8
         W/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHHxdJ0iCa/h/UWJHAw4o345CTFV+GZuhztElXfjBClpcwVWJfVe1yNI3aB9KjY3xNl3axMi20NYmCK0FHApBCg0XH
X-Gm-Message-State: AOJu0YyPh5wHTc6l1ZbHI/nfE0i4YrV/XuBSrCmnr05aAGItmHoDQytq
	8GgfTa/h+jrgV/PCjplx28rWe4tC+/a2I3ic76GEIvTMGA0JF/Pd17rmlFUKnbXSnup2+9OpfoM
	T9E5N1LIWf24DunXgzS3l44Bj0m7/XA==
X-Google-Smtp-Source: AGHT+IGq/EQ67hMj55mm8amnMagRX1zv8hBGauDE/8lfgSfSJaDGa5IOa29OzHLHlLrQYFBNyz6qh3jZECPzuVO9aNs=
X-Received: by 2002:a05:6820:1b85:b0:5c6:4807:2d1f with SMTP id
 006d021491bc7-5da7c762f5amr6919596eaf.8.1723719850134; Thu, 15 Aug 2024
 04:04:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 07:04:09 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh6bn1391.fsf@gitster.g>
References: <cover.1723528765.git.ps@pks.im> <14924604cebe20ac30d291399b0200016fa8b4e3.1723528765.git.ps@pks.im>
 <CAOLa=ZQ15h8bFRGGhzJUPNwkCrRmc2Y26n-0x+L_V_06xWgd7g@mail.gmail.com> <xmqqh6bn1391.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 Aug 2024 07:04:09 -0400
Message-ID: <CAOLa=ZQ=6y2jRNUt_0YyoEHTSgOc6y+ECEnLccXnntbqyU_J6Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] reftable/generic: move generic iterator code into
 iterator interface
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005c2f9f061fb6cd0b"

--0000000000005c2f9f061fb6cd0b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> Seems like the CI caught it too [1].
>>
>>> +	it->ops->close(it->iter_arg);
>>> +	it->ops = NULL;
>>> +	FREE_AND_NULL(it->iter_arg);
>>> +}
>>> +
>>
>> [snip]
>>
>> [1]: https://gitlab.com/gitlab-org/git/-/jobs/7563308943
>
> Looking at it, the suggestions the CI job makes look hit-and-miss.
>

Yup, this is kinda what I was expecting and why I also wanted it to be
allowed to fail. So we have data points on what we should change to make
it better.

> For examle, this one
>
> -static int stack_compact_range_stats(struct reftable_stack *st,
> -				     size_t first, size_t last,
> +static int stack_compact_range_stats(struct reftable_stack *st, size_t first,
> +				     size_t last,
>  				     struct reftable_log_expiry_config *config,
>  				     unsigned int flags)
>
> is a degradation of readability.  "first" and "last" pretty
> much act as a pair and they read better sitting together next to
> each other.  The rewrite is reducing neither the total number of
> lines or the maximum column width.
>

Totally agreed, This is set by `ColumnLimit: 80` and I think most of the
misses I see are because of this. This works with the `Penalties` we set
at the bottom. We need to see what combination works best for us since
our focus would be more on the readability front.

> But this one
>
> -static void write_n_ref_tables(struct reftable_stack *st,
> -			       size_t n)
> +static void write_n_ref_tables(struct reftable_stack *st, size_t n)
>
> is certainly an improvement.
>
> This one
>
>  	struct reftable_record rec = {
>  		.type = BLOCK_TYPE_REF,
> -		.u = {
> -			.ref = *ref
> -		},
> +		.u = { .ref = *ref },
>  	};
>
> is hard to generalize but in this case it made a good suggestion.
>
> If we _expect_ that we will enumerate more members of .u, then the
> way originally written (plus trailing comma after the ".ref = *ref")
> would be easier to maintain.  But since .u is a union, we won't be
> choosing more than one member to initialize by definition, so what
> was suggested by the check-style linter is certainly much better.
>
> Thanks.

Yup these two do look much nicer indeed. There are weird bugs in
clang-format however and I was able to fool it to accept

	struct reftable_record rec = {
		.type = BLOCK_TYPE_REF,
		.u = {
			.ref = *ref },
	};

But this could also be an issue with our config too.

I'll try playing around for an hour today to see if I can find some
improvements we can make to the formatter config.

Thanks

--0000000000005c2f9f061fb6cd0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3a6b16dc5336de72_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hOTRLVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN29CQy85S0k0QytUMXB6YzZiZW96aUJMWndxV2JRcwp1RXo0UzMxeHZ4
YnVLRld2cWZCdmMyZ3M5ampTdGxtZlpSbWtjTVZ2aHNDMnlwdFJTY1lqeHVWb2hkdlFNU1BxCnFX
YmNuamJlTHlXRFdVOGpueGhiUlBFUlkzN0Y4KzFSdzB6UVNhNWJLVjBYZkJzVUo4ODIxVWt1cDlO
VHlJbkQKR3pwWXE4VjJxTWl5Yk5WZHpBYWI1Vk9VcWVTLzhRSGNpQ0MxUG1QbFoydFd2OGhJb09x
Q2tBb0kwWC9aSnBrMgpUb1BlNndjSS9TdmhNNENEZC92eWpJb1RKNVhGSjZTaFZJRXlzZCtCRkFM
MTY3dkhySjlZVVdnN2kzQmh4VjlkCkErUFNBVExmM1J4VWw5RHpZNUJqZ0FxMGJhVWd1NE5pSUFn
cWU2T0sycS9rTXM0VTcyMjl4WHZiMTMwQjZlaVgKZCtkTjkxWmsrU21BMko2U1c3R3hCWnNoZzVs
VGhOeXIvTlhSVUdLc1dhelRqLzNyTWE1N3VCZDIzM3dTeDk2dgpQbWZjSnZxditPSkxlSEhyajNV
c1JBcGMrN3o5bFl4K3FDVWJBZExiMDBSTm1uWTFCeWs1YWJ1WFVpT2hKdWd3CjdiRTh2UHk1cGln
MUlWUXFiajFSMUdkVE53UHRDR1FXUWlGZC9yQT0KPTR4SDYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005c2f9f061fb6cd0b--
