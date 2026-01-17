Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F13236A8B
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768665877; cv=none; b=rfY1SxXNqevhqsfLfJnRwjMLVaIUu9tbulGONmBPSrEzXTVvQ2Vuc8tgjGjQtjnJQqIZaVBcB9tGpRTEy0/AQ+2c69mXcoJIHtoc1QTkVwiIfBOWiXhY3two9EWQpQ5NsKjHvdut3DJEST/o0Gc33nAQwPYIiKCXEh87rPyGQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768665877; c=relaxed/simple;
	bh=dB+BzgVCqG2CY7QidM3/1wO3x1W6Cphc7hFzb4fFQyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOkZkAItetVY1Nxzd5ODXCLDnSjpmMetmvkrpUpiB7q16A5eBcTgnCjOgh4REBdqxXHemRGMM7tjX8Z/r5xHxiaU3SNRqnAEzBd3JOWZT9a5pk8RNHAQImsw7Zl2JEj+L7DOLxog7QvzYY/ajHHEenuyuCDck/7xBMG2fygV3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKX3b4FV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKX3b4FV"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-383247376a4so26255951fa.3
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768665874; x=1769270674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXtKbFL/DpZmgHL6PXAIaheGfJbM+uv1ScR2e67i5s0=;
        b=FKX3b4FVdkw9TfE6wsycwfY56wKhWqSvGp9eMLMgetVoNnt0+FYu0qLMFjCWUpvQdD
         PTwP4hCqk70YrS5XMce7SCFFWORyyr3zlx3LPr3ozP9LMFsh4uZV8G8N4kn4lvOGkWo+
         SdIfoAvnUUewOxvTonp8VK2/FP+QmKBkK/rB26bQkV/Y2cCzyiyhpdUujQ+lf5vKP9F3
         3yTRMSncMwHlVhftdXTHQmtq1n6LvFtC8MC/Ke0pTcKPysMuvH8YrAja0YcF6CFdHxL+
         +VuTWS8qFXPufwRjMyZhDRpX6setZlO1AcM27xSxR8f/8W3FciIWCx8J+lAVi7FX6tPL
         DjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768665874; x=1769270674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXtKbFL/DpZmgHL6PXAIaheGfJbM+uv1ScR2e67i5s0=;
        b=no02NRu1o+ux/1WghSjfTL3No6G3vV58mCm2NVVJ9q0afEjkIaNJccULt3zroh9Pe3
         p/x9jspaXntuwj1KWt9E2A4utkYYwPqJ+cwC18NAgu5MUhY42/6eU1I62fZ2oO5jgVUy
         QlzOCX/HUepiqR2YRRPpJLp6G4La5ENgjQqBTABFK0KaPZ9XEgYNcJcTDZiS6QmansUx
         6o2mFgIBBrqjE1vke2s2pOdfkLfXt20sxuputXPaVAsxrikkxFWusMIrtTDQaMQeRXL2
         JLQT4/6V79CiEKwn9tjVdSrL7mngtkg4XyIGGBBG0QfXO2SHVyziGz6ySUeu2r/drJZj
         eSfw==
X-Forwarded-Encrypted: i=1; AJvYcCVxqn3nqpIdjA/gwPBbVxs8cLh9WFnqAJwkRwiWdV8ylxH8k6wPDoCHxcy+juBTYcrJ6RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NtGWOeTfvC7yktqxCawa4iv6RPkVSgt8YphvFs0OHL/oioOL
	cIdgok78TiXbfv91phTBgHYrLsEYfQ3ovDd7Bo05vymAkflqPhBAAu8DOFAnsSDdMLWkDFxyUvp
	43vzCuXyL5smEFIGNZuFfBvR/DHabOHNZSuc62X0=
X-Gm-Gg: AY/fxX7pmZKpaVSBAgjhy0P5IAqzw2H5hriovshrTOLQxOrP39/unxZi8eNuPTVF3if
	EuKcVybGDvg4YzkkUgMyDscjDjHNJfOIK+C4vjps+aoe8gVRXJSz/Ih+VEH9zzPi0lbZFM1Uvci
	4AxyUnvogPq91bUS9HjIOgX5po3u32zgyCPXYVaGc6U6A6hnl5KDXWML3PwQAA60y5KfXOZM8ny
	eAf3xPBU6AycHV/PDve6dttI821L4RzZOH9GNhou4UvpZXVm3c730QzH6JbB+4ft9MgLHI=
X-Received: by 2002:a05:651c:2205:b0:37f:c5ca:b737 with SMTP id
 38308e7fff4ca-383866b0f0bmr19614571fa.1.1768665873673; Sat, 17 Jan 2026
 08:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com> <fc291b3a-5ee5-4488-9b01-d3de32f7c257@web.de>
 <ed06232c-4c48-4d5a-a269-8663b32787ea@gmail.com>
In-Reply-To: <ed06232c-4c48-4d5a-a269-8663b32787ea@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 17 Jan 2026 09:04:22 -0700
X-Gm-Features: AZwV_QgBGN17YG6NwNLJZf-_ylx1G6BAv9OkFNauAQvGIIHQTx-YfE51P-LbIOo
Message-ID: <CAH=ZcbCuY22WCqzyK-=Adw924a6ZJqnMYjWK9fxwoFn5xK9q-w@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 6:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 16/01/2026 20:19, Ren=C3=A9 Scharfe wrote:
> > On 1/16/26 11:39 AM, Phillip Wood wrote:
> >> I've Cc'd Peff and Ren=C3=A9 for a second opinion if you have time ple=
ase.
> >>
> >> On 15/01/2026 15:55, Ezekiel Newren wrote:
> >>> On Thu, Jan 8, 2026 at 7:34=E2=80=AFAM Phillip Wood <phillip.wood123@=
gmail.com> wrote:
> >>>
> >>>>> +static void _set_capacity(void *self_, size_t new_capacity)
> >>>>> +{
> >>>>> +     struct IVec_c_void *self =3D self_;
> >>>>
> >>>> Passing any of the ivec variants defined below to this function invo=
kes
> >>>> undefined behavior because we're not casting the pointer back to the
> >>>> orginal type. However I think on the platforms we care about
> >>>> sizeof(void*) =3D=3D sizeof(T*) for all T so maybe we can look the o=
ther way.
> >>>
> >>> If someone finds that this code does not work because of this
> >>> assumption I'd like to know. But I can't fathom a case where it
> >>> wouldn't work.
> >>
> >> So we have two different structs
> >>
> >> struct IVec_c_void {
> >>      void *ptr;
> >>      size_t length;
> >>      size_t capacity;
> >>      size_t element_size;
> >> }
> >>
> >> and
> >>
> >> struct Ivec_u8 {
> >>      uint8_t *ptr;
> >>      size_t length;
> >>      size_t capacity;
> >>      size_t element_size;
> >> }
> >>
> >> One the platforms we care about they will have the same memory
> >> layout as all pointers have the same representation. However I don't
> >> think they are "compatible types" in the language of the C standard
> >> because the type of the "ptr" member differs. That means casting
> >> IVec_u8* to IVec_c_void* either directly or via void* is undefined
> >> and so
> >>
> >>      struct IVec_u8 vec;
> >>      ivec_init(&vec, sizeof(*vec.ptr));
> >>
> >> is undefined. For the compiler to see the undefined cast it needs to
> >> look across translation units because the implementation of
> >> ivec_init() will be in a separate file to where it is called. Maybe
> >> that and the fact they have the same memory layout saves us from
> >> having to worry too much though I'm always nervous of undefined
> >> behavior.
> >
> > True.  The GCC docs give a fun example of what a compiler might do
> > when using different struct types to access the same memory:
> >
> > https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Aliasing-=
Type-Rules.html
>
> Thanks for the link
>
> > Not sure it applies to this case, but the point is that compilers
> > can and will do terrifying things when they smell UB, with little
> > concern for safety or original intent.
> >
> >> An alternative would be to pass the individual struct members as funct=
ion parameters
> >>
> >>      void ivec_init(void **vec, size_t &length, size_t &capacity,
> >>                 size_t &element_size_, size_t element_size)
> >>      {
> >>          *vec =3D NULL;
> >>          *length =3D 0;
> >>          *capacity =3D 0;
> >>          *element_size_ =3D element_size;
> >>      }
> >
> > The ampersands (&) should be asterisks (*), right?
>
> Indeed, that's embarrassing - I must have been thinking of the caller.
>
> >> and have DEFINE_IVEC_TYPE create typesafe wrappers
> >>
> >>      static inline void ivec_u8_init(struct IVec_u8 *vec)
> >>      {
> >>          void *ptr =3D vec->ptr;
> >>          ivec_init(&ptr, &v->length, &v->capacity,
> >>                &v->element_size, sizeof(*(v->ptr));
> >>          vec->ptr =3D ptr;
> >>      }
> >
> > Mixes "v" and "vec", misses a closing parenthesis.  Looks viable,
> > though, and this method should be applicable to the rest of the
> > functions as well (on the C side).
> >
> > I guess this doesn't require an element_size member anymore as
> > each wrapper can pass in the sizeof value.
>
> Good point
>
> >> That's safe because we cast the "ptr" member to "void*" and then
> >> back to the original type. On the rust side the implementation of
> >> IVec<T> would also need to split out the individual struct members
> >> when it calls ivec_init() etc. It's all a bit more effort but the
> >> benefit is that we don't have any undefined behavior and we have a
> >> nice typesafe C interface to 'struct IVec_*'.
> > Right.  No idea how ugly this would be on the Rust side, though.
>
> I'm hoping it's not too bad and `impl IVec<T>` just contains the
> equivalent of the wrappers generated by DEFINE_IVEC_TYPE()
>
> Thanks
>
> Phillip
> >
> > Ren=C3=A9
> >
>

I don't like this solution. ivec_push() is the only function that
deals with actual values. The rest are just generic memory management
functions. What if we used:

#define ivec_init(vec) { \
    (vec)->ptr =3D NULL; \
    (vec)->length =3D 0; \
    (vec)->capacity =3D 0; \
    (vec)->element_size =3D sizeof(*(vec)->ptr); \
}

#define ivec_push_unsafe(vec, value) (vec)->ptr[(vec)->length++] =3D (value=
)

/*
 * grow by at least 1
 */
#define ivec_push(vec, value) { \
    if ((vec)->length =3D=3D (vec)->capacity) \
       ivec_reserve(vec, 1); \
    ivec_push_unsafe(vec, value); \
}

Instead of concrete functions?
