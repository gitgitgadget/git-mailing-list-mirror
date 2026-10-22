Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792685476;
	b=PJeCkQYptciBZIeywR1lC3/+VgGuDueKCkfGMxlYrm652AhvzljgZ1hQ4a1anpc4kPZH
	 K7KVphZQDx0vDeShKFQWl8mJg6asbjuO2f0erhgzCheHuNzuu8a9/K7NUVgCBo72VCXIr
	 55QPr6T8MX+E0VcHSbe2kEfX5d/G4ksc/beYLolWRjAQ1B8XNY07103/gO2ZnVdf+CN1Q
	 JaGm2rFOMMeOcsvEeWlOUi4ON7GnbTqH20z/hHOJpcu3vDeMjpqEHc2xIUZbZ1ouukT60
	 2i2PiUoNAyXcMX5cVPZDDmL5EUI36+Nm1XWPVJr8bdF/y9CAcJHPT+XKMLRDk7e8i+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3FqVM+gtNMiqLU4WqwVKq2DPngPe/OZNN4G7Mkfn0L8=;
	b=3l+irXl1JtUC9Ye20CW2EeUZpK5pKbdoEeOFbgOnFOLe8DhhP3SX3n/89x2fZ5SVH7wl
	 w09Ou+jW+UQsgztESVB9QLg6f6a/NLdo+0K97h/vG3ToTNME95GR6vB+98Yj/oF78dE1B
	 lgzNycA+ZM6MbpK+MdZkNe2CAVfsp5hQ4XdQYt+uJZ19Y0TrP6lB/xF7W9xd94OnsDmVA
	 n/npwk83TML6TdgoUoMf0TKm+1YbIVjJ739b7j+J3AFLxvJEuuygwoIzrwe5CQfkZe04d
	 DMs5yBBYDx+fNBLtN7Lge8RURSrqQwrqmm7jk4Od5KJXSYCRLi/qJGNSkZlK3FK2chQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=kKbT0eBV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547F606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6547F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=kKbT0eBV
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679aeeddc6bso61978d50.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685474; cv=none;
        d=google.com; s=arc-20260327;
        b=PfWtR+P4Y3FoR5MsA3/lxfg/erBKr/L7dD7UlM24aGMPxkEyK3VRh8YD0kWB5FXJFf
         1HaSz3bWUoM5IX4gtfTMH+DZ/1pbN9fCxW1SPocePYHQo/4RoaFZyQrsesWlpORW/p/B
         WAy/+ZEyqu+K68f74T+bzeheXdxgpkAgV6RFQ4HjhjZyOrNP5bA6Piu/j4X4KecnjvJY
         ZBpuKYmLGTYAYSwE86E+OolJ3+GRVuaq97ID3bplVMGhHhaSFgpasrWPp1tx07oiQZ6a
         TbbR50O1GqfWXWAZO8wPzs6iAuxzd2dKmr7bhVPALcpvz+/A/DOJd3rliumY9g5ZnoTl
         P8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3FqVM+gtNMiqLU4WqwVKq2DPngPe/OZNN4G7Mkfn0L8=;
        fh=7dI4c2pNGDaBKyXWxC/LC5DIrrYPij/oz6noN/4if5A=;
        b=Z2ZVdp75eJ53NXX9Mdy3GyEJOLW/E8iPXElCPXIW4oWG+voNGFBMtho0VHeisLwSZb
         R10s7SnjmYgin1wQx5+tT6FI4ttl8e4Q7Wdzl6teumDcdvFv/YDklOU2VK4fldnZot89
         0pZxN1xansHg99cPsB/6l4prN9uXLQliRfdCKjgkSbDl1PxwrJfy3rwxKT2UGR8TO6c1
         5cCahBVZU/PXwN1Q5VGif9oXDpXiuIrEoozFWYHzln8SgfawTacMIhu/0Cd+l6TpjJ3T
         iaWA6Ij+LZCGblqziMFmC6Th6lf35rddiqGJGwE0oCwLKQ4bFPPVMYKAnML/uyFljm0e
         QXgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792685474; x=1793290274; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FqVM+gtNMiqLU4WqwVKq2DPngPe/OZNN4G7Mkfn0L8=;
        b=kKbT0eBV7YLCoZRiJU/eb0Xwi0xieFL+bYkNHgjrMPFT+rE3yhRq1Ky2XPrOoQ0u7T
         UevWIxEkxDfyA4jy5drtouPniBdw64bx7k3Uf7olyqWnOz+4FdtAQKS28Tn6Sx85syIa
         q370UoqLdbF3WEUY1mPvfdCbeuSKOZ4hu9q4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685474; x=1793290274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3FqVM+gtNMiqLU4WqwVKq2DPngPe/OZNN4G7Mkfn0L8=;
        b=k73WwIhx/HTNLArcvp9YTdaYgd6owT0Tdnnk5Fgf0yENZsZI9olFvc2/ye1nbD9Xh1
         PXHm8/YJLu7pITq3MT58T+yMqyCkH9Sb8Nv5Xmj2oN1UF4kKaoVO4emflptCrylP5sJ8
         Sl1dpy5UwHR3mFZCjnKwahWkseVi/2Y0ir3AC/AtD17Pn0G3AxBUz/vmg4yLP4dFP4Gh
         hm8HmLC0rPN5mwb9UwabSl2SsMT6a7GCdOkXniO/X9u1x6Rv9vUTvD+kWQi8pLRQiOK0
         5AwHWl/rOK1kgEovQth8vut3b+gLETPduDnH3W/oxLo3rhzC/CcXbP90gak7QyrcSgCS
         ncqw==
X-Forwarded-Encrypted: i=1; AKwUvBwX/H/q+xhHSo8Yr5PFcMDVRwPCkeFcMiRK9/c4BnhtSBX927ZAtmvRDGjBhxkn0sK5FKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUhWNVR1wViIeBluWzzeXlBMP6xC5w53T92VDxN8DnyxkALa8l
	Lo0PiE565qCaYwBzXoW//NvubsRTm74M5Cv67ELutqkhig89R+KNwubDJ/1MpDCe91uuhLE3F8d
	/CPESLSNOr3SWUdbqS7aBCwgAsTMQ9u+9rLc2+WJayA==
X-Gm-Gg: AYBFou2gGqy91ptUdSHc7qLyMLy/+gnZWMqexGNOOGx/Bie14l8g8ssc3lJBa+Zhgd+
	5oyyX/2BW5GVB6YR+kiJja5/HFE3WEyiNj5S2a8TF2WjZcXOL+R1V9BReP3uHB4QPI1W/nUYBXZ
	kJC5dHhCn5oYzlJK6P0H1DrAyQJA4kEyEQO3ZXXh0ecatr6rLbvCWjQD2zw2graSY8dvJ/P2FnJ
	F1UGIsIUpTMNun/dR0k0/owPB6+2tQJILzOgOW1pFeT7iDqVrlvpvVzbKTllUCGqiaDGsN99HBm
	LapiQ3+jQmNaXY+VbSNMghDsQXeIUZ+qBkp/VRuS/Np4zqo7siS4BhAmmf80EZUScpBTEr8Bhxj
	8sFsSZRy8+RVoAULF8A7Orx0UjWxJ6H5V+MnsNA==
X-Received: by 2002:a05:690e:1917:b0:679:c29f:5989 with SMTP id
 956f58d0204a3-67a0e45bc42mr2412141d50.35.1792685474282; Thu, 22 Oct 2026
 09:11:14 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com> <d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
 <xmqqecdin6xr.fsf@gitster.g> <CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
 <xmqq4iedkd2u.fsf@gitster.g>
In-Reply-To: <xmqq4iedkd2u.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 22 Oct 2026 18:11:01 +0200
X-Gm-Features: AclHuK_Ln3cnUkfPl1u7nteI6IbS5T6h9B5QdOysQp5jjyNqgxh9G5n_aL39wH8
Message-ID: <CAL71e4Ngsxv=JU_qzVGVyHPZiB2Qzvjn22NeVQAtZOdCr2vyXQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] connected: add incremental connectivity check via rev-list
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 16:46, Junio C Hamano <gitster@pobox.com> wrote:
>
> Kristofer Karlsson <krka@spotify.com> writes:
>
> > Yes, and an earlier internal prototype (that I never sent) did
> > this. ...
> > But even then, the revision walk around the verifier and the full
> > check would still depend on fetch_if_missing, so the verifier alone
> > would not let us drop it.
>
> As use of _extended there in new code will certainly be a way to
> avoid making things worse, the above in distilled form should be in
> the proposed commit log message to help future readers who may
> wonder why these new code paths are written to rely on the
> fetch_if_missing flag.

Ah, I was not aware fetch_if_missing is something we want to
move away from, but now I see it's mentioned in the docs.

I looked into the code more after your pointers and I think it's
indeed doable (and not too messy, just a bit more code) to
use odb_read_object_info_extended() instead and completely stop
touching repo->fetch_if_missing. It's still being touched by
the rest of the rev-list code, but at least this series no longer
makes it worse. The full check is unaffected, since
check_connected() already passes --exclude-promisor-objects in a
partial clone, which clears the flag as before.

To check it, I ran rev-list --connectivity-check=incremental by hand
in a partial clone, deliberately omitting --exclude-promisor-objects,
on commits that reference a promised blob and a promised tree. Both
were reported as missing and neither was fetched. I did not turn
that into a test, since check_connected() never invokes rev-list
that way, and the existing tests all pass.

This ends up nicer than what I had -- I can also get rid of the
BUG() guard for checking that flag state.

So, I think my plan is to squash this change into v5.

Do you still want me to include this reasoning in the commit,
or is that now unnecessary given that it would no longer touch
fetch_if_missing?

Thanks, this really helped improve the patch,
Kristofer
