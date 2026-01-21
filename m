Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710343634F
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031585; cv=pass; b=ob/WB2dGQbzF7EjgsRhw9YM/LUjhOdw9a8LeQCnQ0yI85JTA64fAN2Ddjua4h+o8zNj409qp3iVxwBW85CNZJPqCGnlrLj8VNczpEOerD426Gs6Sp+LKx6n+JJgQQ6X18M2XPYbJtQtcANOgGNKmfDsSeibmPQlQe1z+xR08IuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031585; c=relaxed/simple;
	bh=dm3qczePg0mvMnYVlLl+FSPdZFxjF6hIDosXV5gjrbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq0swLQESJkJFejP2rZ2xMYlzLsP1geNBPQlomsJPDMV1kJF4GlB4N0TpMZ27ZS0zCA1zPPmNrUs4KdD1kC0Tix3NVHt+n5CgZhxZodLwyOr8H/j1DwOhrPlpuhriu9Hj/nPbNYdBDrdk4xhf4Uhzxl+nquwlf+x/NOdVCtsKqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yras3rUv; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yras3rUv"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-385baa8afaaso2695551fa.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:39:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769031577; cv=none;
        d=google.com; s=arc-20240605;
        b=VchT0dT87BdINZJoDgzxJcHl0o8Rv7Rc/VTOaBo2kf9vVRfggL3lNm1D91u7QaMJ86
         6iBsk/3ZnaGD20fq9Tt/JEFT5oYMSYAMXis7KmEztMKqFFcwMBChKpN3bnE+S1YQXbMv
         Ezz1dQGobHa4BLIHY6RQ8T8Uw3I+5lNMmLc+giLUmz4kzhKQyqVSB3B9ZLupVKmloCW0
         0rN1EEZlIm9RLg3uj8LULKoj7a8td3kWzugLLqjV5k+XSyWVoMaMXs2/MK59SfU5KYt/
         y1kR3eteOS4X+xfn37eVbDYJG0mlN7lGMFSdQrRa0N9e8RavLZKqcIg1jZnVRO7AQcS+
         m5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/mgrXOC+TOmdjnlO3TCQhywVMokslh++HPX16XC6us=;
        fh=A9+sbiAA7HKRyEpLdxfyjs8nEcZaRsr+jPPL0N0iqao=;
        b=VAIlkMIYPJI/FvBkD9towhuq3XpfoGh1SJmu6kvGVrXRLWW6qAqnP85hPyca0EhdNg
         /T0TMMiIVzYHnJYgwttSK0FscvJL1PnAnJhOyPV51UI74YwQJCVdwKu6+BI5+Nq6/TFe
         2aQaiJ6uL9YGAo7uld26sHK3BLmQ69zVqfZMYpAej7Gj6Z69ZOXzJ6Cq7oHV56aS1Nom
         CUwskUolpjBU+w+EDfG5sgOQ4FxmWWxiGGi8Sgm5yrw3Bo1KaYx+3Cs6lcQoMWqy49OD
         av1Y2a7+rwDw/sTJjtPJq1NwdVzPA4FrB4SGw94LN9viFi2XNDmW41paeM32zKEeowmM
         fRcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031577; x=1769636377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/mgrXOC+TOmdjnlO3TCQhywVMokslh++HPX16XC6us=;
        b=Yras3rUv8aVBmsalGwf8rHDeKAP8ktDT0tVJ9DXdvl9yn2TpCOjKnsgjgJfaUoYxdQ
         fQqIjLwvPmQdJad2Vc3E5FaFvIFHTKfrWWTXtRZSBJkDgOwYXj7e3meb2Bt/jDabgP6s
         LB2T8MHBjnAU/G+/WnYAF1753vEy6cmwfVmvCw8iFey0Bs82AsD5c4uaEPR5AouofpLY
         arRoIvObqF4a9TwWDau3wOH87gaJYDEptnzzL6/qj7ub5ipr7FgwxB6lTTvL3RL7ChRz
         oPg1ACuR4eqvW6IH5rCmKRqT9+vevEI1bsfXHVe5O6Wrnpbf+BB2yTFpdioFEQ4wR+sp
         c51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031577; x=1769636377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/mgrXOC+TOmdjnlO3TCQhywVMokslh++HPX16XC6us=;
        b=Ib5y7PP4bAShtg0sZpHPMrKkpPEsRJ/ulUdegTC+GBhYmkpN9TFfokRPJvh7uxLADK
         QBZ7V9puORl7vuQbAI2EyGxCrVmOHtGnqj5wGScM63bXrOxC7FaQNqSEBInnEOVsJsgX
         KLBGBbQu94A7FT53SEuk9DeZhCUBBnaPqzHMPWYd67uAtlqpuMJvp8eO+5W5/K55OpRs
         kO8F/54c3GNVpKzt2dIeIhUknQtyayW/aNKUNAro1eQoj93QUl5+sD1RNn4MMcjFXHH5
         OZ3kt4jV6vqldhZeZ9+yjtqVAYampQV3VdV2ulfqrxmN7MpmEukrk1jBHJlJX2mYc0Rq
         u7zg==
X-Forwarded-Encrypted: i=1; AJvYcCUBcOqH03AvJtwMtMs6r3xZu0NTKt45FrMi9sD1DnTnZKBvSsoJzk5utwLbzVu1zWzL/fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoyn7oyEPj4YfvMTBv9CmSXfGEgjlMbYZZjIj/Nsu/j2hGa07d
	5WRXaF63JKCBJ39yLN26aeyVKB+y/TfPTweepv5ayl8Vq4OemzR2BExX8VaS3pIAVnFCGMwgNlH
	JGLbRhoLt8N3fm07+lD7KyQTrvFU9Vkk=
X-Gm-Gg: AZuq6aImqmznj/LT4ymoOEv+yIEq7x4n3hXxwVEfSNOLMr0Hik93LzsV6lo3OyXi+nC
	xCMwQ8QLWOm1i3gnFlE5l7b0OrRqVF/CbXhA6j/5amB8P4gd4Ag8NWgnsgGLYhvu/OvmkDh8ESf
	3HFrXJXSrX4/ZvFCDwYmQZitPTJl6W3Z1UPwmaForRDm5dQzP40xSodBYqGG/xA5cwLHPYMgavs
	88+fF/6FRb+yCvq80aBe2SYguhCF2dWizqKWSSmNFS7p9SJNKrIM4jWLJAMwg4i1pzhouQ=
X-Received: by 2002:a2e:a58f:0:b0:37b:926d:5bf3 with SMTP id
 38308e7fff4ca-38384153c49mr64076341fa.6.1769031576592; Wed, 21 Jan 2026
 13:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <08318339-03c3-4068-92fa-7a711bd13da0@gmail.com>
In-Reply-To: <08318339-03c3-4068-92fa-7a711bd13da0@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 21 Jan 2026 14:39:24 -0700
X-Gm-Features: AZwV_QjMlv6Cawqxh_syFGlxAf2Ae5jw0Fq8HDzCQXDrCPq7ZFQBor0uTCLNXOQ
Message-ID: <CAH=ZcbAiGONrOyma7YjNKKLqNFoisU5LG=nGWjtOJ1wLfqX4cQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 7:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ezekiel
>
> On 15/01/2026 15:55, Ezekiel Newren wrote:
> > On Thu, Jan 8, 2026 at 7:34=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >>> +void ivec_reserve(void *self_, size_t additional)
> >>> +{
> >>> +     struct IVec_c_void *self =3D self_;
> >>> +
> >>> +     size_t growby =3D 128;
> >>> +     if (self->capacity > growby)
> >>> +             growby =3D self->capacity;
> >>> +     if (additional > growby)
> >>> +             growby =3D additional;
> >>
> >> This growth strategy differs from both ALLOC_GROW() and
> >> XDL_ALLOC_GROW(), if there isn't a good reason for that we should
> >> perhaps just use ALLOC_GROW() here.
> >
> > XDL_ALLOW_GROW() can't be used because the pointer is always a void*
> > in this function.
>
> Oh right. I'm not sure that's not a reason to use a different growth
> strategy though. The minimum size of 128 elements is probably good for
> the xdiff code that creates arrays with one element per line but if this
> is supposed to be for general use it is going to waste space when we're
> allocating a lot of small arrays. ALLOC_GROW() uses alloc_nr() to
> calculate the new side so perhaps we could use that here?

If ivec_reserve() isn't suitable then ivec_reserve_exact() should be
used instead.

> >>> +void ivec_push(void *self_, const void *value)
> >>> +{
> >>> +     struct IVec_c_void *self =3D self_;
> >>> +     void *dst =3D NULL;
> >>> +
> >>> +     if (self->length =3D=3D self->capacity)
> >>> +             ivec_reserve(self, 1);
> >>> +
> >>> +     dst =3D (uint8_t*)self->ptr + self->length * self->element_size=
;
> >>> +     memcpy(dst, value, self->element_size);
> >>
> >> If self->element_size was a compile time constant the compiler could
> >> easily optimize this call away. I'm not sure that is easy to achieve t=
hough.
> >
> > The problem is that I didn't want all of ivec to be macros that looked
> > like function calls. I wanted to minimize use of macros so that it was
> > easier to port and verify that the Rust implementation matches the
> > behavior of the C implementation.
>
> I think that's a reasonable concern. So is the plan to have a parallel
> rust implementation of these functions rather than call the C
> implementation from rust?

Yes, the Rust implementation will be independent of the C
implementation, but will behave the same way. That's why I'm calling
it an interoperable vec as opposed to a compatible vec. Rust can't
call the C ivec functions and C can't call the Rust ivec functions,
but they'll behave the same way.

> >>> +void ivec_free(void *self_)
> >>
> >> Normally we'd call a like this that free the allocations and
> >> re-initializes the members ivec_clear()
> >
> > In Rust Vec.clear() means to set length to zero, but leaves the
> > allocation alone. The reason why I'm zeroing the struct is to help
> > avoid FFI issues. If not zero then what should the members be set to,
> > to indicate that using the struct is not valid anymore? In Rust an
> > object is freed when it goes out of scope and _cannot_ be accessed
> > afterward.

Maybe I should call this ivec_drop(). Though the notion of explicitly
freeing an object in Rust is _almost_ nonsense. The way you free
something in Rust is to let it go out of scope.

> I'm aware that Vec::clear() has different semantics (it does what
> strbuf_reset() does). That's unfortunate but this function has different
> semantics to all the other *_free() functions in git. Our coding
> guidelines say
>
>   - There are several common idiomatic names for functions performing
>     specific tasks on a structure `S`:
>
>      - `S_init()` initializes a structure without allocating the
>        structure itself.
>
>      - `S_release()` releases a structure's contents without freeing the
>        structure.
>
>      - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
>        such that the structure is directly usable after clearing it. When
>        `S_clear()` is provided, `S_init()` shall not allocate resources
>        that need to be released again.
>
>      - `S_free()` releases a structure's contents and frees the
>        structure.
>
> As we write more rust code and so wrap more of our existing structs
> we're going to be wrapping C code that uses the definitions above so I
> think we should do the same with struct IVec_*.

I disagree. IVec isn't a wrapper around an existing struct. ivec is
meant to very closely mimic Rust's Vec while guaranteeing
interoperability. For things like strbuf I haven't conceived of a
solution for that yet. Making ivec diverge from Rust's Vec will result
in POLA violations due to different behavior when refactoring an
IVec<your_type_here> to Vec<your_type_here>.

> >>> diff --git a/compat/ivec.h b/compat/ivec.h
> >>> new file mode 100644
> >>> index 0000000000..654a05c506
> >>> --- /dev/null
> >>> +++ b/compat/ivec.h
> >>> @@ -0,0 +1,52 @@
> >>> +#ifndef IVEC_H
> >>> +#define IVEC_H
> >>> +
> >>> +#include <git-compat-util.h>
> >>
> >> It would be nice to have some documentation in this header, see the
> >> examples in strvec.h and hashmap.h
> >>
> >>> +#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable=
).ptr))
> >>
> >> This is a bit cumbersome to use compared to our usual *_INIT macros. I=
'm
> >> struggling to see how we can make it nicer though as DEFINE_IVEC_TYPE
> >> cannot define a per-type initializer macro and I we cannot initialize
> >> the element size without knowing the type.
> >
> > I don't see what's cumbersome about it. Maybe an example use case
> > would clarify things.
>
> It is cumbersome because it separates the initialization from the
> declaration. Normally our *_INIT macros are initializer lists so we can
> write
>
>         struct strbuf =3D STRBUF_INIT;
>
> which keeps the declaration and initialization together. Although
> they're on adjacent lines in your example in real code the
> initialization likely to be separated from the declaration by other
> variable declarations.

Ah I see what you mean now. I'll experiment with making IVEC_INIT()
work like that. One wrinkle is that STRBUF_INIT is a single concrete
type whereas IVEC_INIT() is meant for generic types.
