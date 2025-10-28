Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5062332EB5
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681516; cv=none; b=MVtxpx1gT/bVPm2lEFXJCcPsXOQxja4HK35PH+XCi9ViaMFvb6ALwgvv+ZNJYmGkFCg3MiSpozpxu0hRZFGCG4+dD6rcavio4BHLYH7iN+j9WvwLsMUC330R8A5Bjjoueha/lpqSJXJ3/hgSxdLnjtAhSE07p8rwhPQWgJRj+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681516; c=relaxed/simple;
	bh=Tmx+FoxxcdU3+mpmSDbloGu71pw0AXAW6vZBMUL6x/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nizi+n4ktkjM07/tXfO31GdszIjpts4IW2Zdg/EoVdXdz7BQtMQQKmLITtU5o3Egr8VDZu45sDE3CD5GXaoE2gpyBLXxgTdgDjcv8eovkZy8UqEaheFOL8W4ior2auWqbRMH/CYw84hHXa6JiZGPySaotwbtqS3TSn/LayI0yfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9sCZ5jD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9sCZ5jD"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378e622e9e3so3708471fa.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681513; x=1762286313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkChbaArSRV5M9uO4gM0j+A/PH1/oJBNH6ZxONF7mq0=;
        b=R9sCZ5jDoNCBC4SWWC49e0v/vrdwJ4Q5GeqWiUrWJl92TDHJVmLN0SdNB9BYf1tt4R
         1RTBM3jLZXImGr3N/zOAhFLZ31jR3DRYnby+wPXC8h/hT/ZRzAhPGt/WjdAmURn0pLz8
         yG4L/lYlu4vqwMgepDh5M4rYykoE9mm39l7CLHhfAVY3RGVumjWlogyPq14ODoREUGvJ
         zG0BS5myGg62vxVwvuZPu+OHFQqr25cZeAFs8iv8f1Lh5A2zyaKAd4985W6tcaEfMsSN
         2KjSKzRhnZ3lmWqSShmBY9T5nEFktnHyidjfTBZTvG1k3KLxApGWVIIHgvUKIUTT/9jx
         Ui7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681513; x=1762286313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkChbaArSRV5M9uO4gM0j+A/PH1/oJBNH6ZxONF7mq0=;
        b=rZUXTl8ylejJnig1A6ZP4rV5D5/y324fEeZvlquaBMxoBYTRpySjAirJqX4rNruVmt
         /vnypP1rFJ/9ONYBvNJ7u6zjxOckm4fk1kV2CaVluxYMzqG24G5eCWhIJTk+0f5k5L8t
         6LNgSUS+RBKtPY0pUvWiAypLHdfWvZ+d0GpP7F/mjYhm7FzpGOHPfbjznILg0ZUIyEaU
         aUCnr7QHYo9B/ifNMdeKhxJOSKtbNtKxUg4CGyVm/trr30cU4H8mn6QcMN21wW8ZI4Et
         /EwToQu0iU/z9ySVNH8d1mb5XtJ/T5G8G+xn+nsWBelPXrKB3NaEVf56ZeUT1fvD56wI
         fVsw==
X-Forwarded-Encrypted: i=1; AJvYcCXHivrXWeTU7uhta81eTeqD76jZINLusw9aJkJk3JHjy1MurIwb7yRLRg2yocZEJhDqz6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVCTDUQXx5yTsPFQkC4B0Y/BLhJbVQsMDdqg7M7KmZFAiO8ak
	z1o/kK4qH0kqz3RIUq9oIJZip/I/CZ/pgOQXne2znZn1clogGrEM94kUkRBpLaYQEa+zfLmX+OR
	bNk6EhUIAG2JSBHfSSFhs28+vO+v9vNk=
X-Gm-Gg: ASbGncsLRMwx1MmbZoLSAU1OoEhJ7zuRl1KwpOLqb59G0Z2V4mfQhF8MoAJPyc1Lv9o
	wTuXBF5kaR6jzQJzmTddZqC1nNlrful5GCrAJrGGAgl2oZwdIZWUehbQcl3+D+nf3Qm7ok0T0Rg
	tQ19uUtI8OxaY75fv+K0G8142EN8Tsg3PCShem6n7rCOkTx1+KFi6v5qt11HMKNqssXecAzKAxz
	mg2PjGk9HddwS3hPa6m6H07/si2d6Lff+bVcH7aOjcTRhHU3fBMxTwWdK4qsQ==
X-Google-Smtp-Source: AGHT+IG7G9a/Z03zWaLqEJ9godzXV6GStzxjI1WiKSMlJcOaSeLzKT++xs4h1ETa4dU4yfUSRYD7kahMPi5vZbhu0O4=
X-Received: by 2002:a05:651c:4c9:b0:378:dfa3:ffd1 with SMTP id
 38308e7fff4ca-37a05e4dfa6mr1222311fa.11.1761681512604; Tue, 28 Oct 2025
 12:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net> <aQCKCfuaEKBArD-g@pks.im>
 <xmqqh5viddo3.fsf@gitster.g>
In-Reply-To: <xmqqh5viddo3.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:58:21 -0600
X-Gm-Features: AWmQ_bkhfc0n7rIx6JZVRj72bzisC3PO9cTzcuniNIpMEAGUJP0brHCC7vi43co
Message-ID: <CAH=ZcbDEo2xcqpRrF400zHe=w-kK+rfnp85YhcE5kQ6jjS+8Hw@mail.gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Mon, Oct 27, 2025 at 12:43:53AM +0000, brian m. carlson wrote:
> >> We currently use an int for this value, but we'll define this structur=
e
> >> from Rust in a future commit and we want to ensure that our data types
> >> are exactly identical.  To make that possible, use a uint32_t for the
> >> hash algorithm.
> >
> > An alternative would be to introduce an enum and set up bindgen so that
> > we can pull this enum into Rust. I'd personally favor that over using a=
n
> > uint32_t as it conveys way more meaning. Have you considered this?
>
> Yeah, I do not very much appreciate change from "int" to "uint32_t"
> randomly done only for things that happen to be used by both C and
> Rust.  "When should I use 'int' or 'unsigned' and when should I use
> 'uint32_t'?" becomes extremely hard to answer.

I think the most appropriate time to change from C's ambiguous types
to unambiguous types is when it's going to be used for Rust FFI.
uint32_t should be used everywhere and casting to int or unsigned
should be done where that code hasn't been converted yet. This commit
isn't random, it's a deliberate effort to address code debt.

> I suspect that it would be much more palatable if these functions
> and struct members are to use a distinct type that is used only by
> hash algorithm number (your "enum" is fine), that is typedef'ed to
> be the 32-bit unsigned integer, e.g,
>
>     +typedef uint32_t hash_algo_type;
>     -int hash_algo_by_name(const char *name)
>     +hash_algo_type hash_algo_by_name(const char *name)
>
> Yeah, I know that C does not give us type safety against mixing two
> different things, both of which are typedef'ed to the same uint32_t,
> but doing something like the above would still add documentation
> value.

I'm against passing Rust enum types over the FFI boundary since Rust
is free to add extra bytes to distinguish between types (and it's
documented by Rust as not being ABI stable). Even if something like
#[repr(C)] is used the problem is that the enum on the Rust side will
have an implicit field where that implicit field will need to be made
explicit on the C side, and if C sets an invalid value for that
implicit field then that will result in Rust UB. Converting Rust enum
types to C is non-trival and has many gotchas.
