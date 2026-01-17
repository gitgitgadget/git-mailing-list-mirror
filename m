Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012F242D83
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768666510; cv=pass; b=njP1KbPcuplzXcpMz1FGSp3TU2lbe8dY1ioMYCflFXX5AMc7ofBdlG354E9iYc7GjCfnjv1Nt3/yFp6d4ezfPoq2cYXP7ocANaa3pKIlXM1Jsgmv11CMtRGG31AHFLzx0N/O4FQtuCsWB56hw3IAZ5tHzAD8u228Uy+bUjwhjCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768666510; c=relaxed/simple;
	bh=j8WONNryyVpowXxZgEjNVmfLM38M2z/yz2iF6QQeMq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4gpF3iEt/sByf/puE93taZvghuppvkUJmwrmuePSKXVw9Tjfyey5xE8lw1zy8jvXZFOQKg7oe2+rcR5niHnuFay5cMk6nF396uvEucL5540t9W9wj2VZqHGmZrREZShdWobm59AstUnwxMH/pptEoBsmTTbKId+lUNAW6oDvVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuqnmGC9; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuqnmGC9"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3831c18b23bso23678561fa.2
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 08:15:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768666506; cv=none;
        d=google.com; s=arc-20240605;
        b=aMkb4207s9gD4yLeK28AfF1MRBf9mcfe6N72ksN6dC8Mpu0G7t7y5D5VhaZb5miAeQ
         ug6WZ+ymCrk4mdGLSy5/mN1Irm+V1v5BfzegWjxrR0sRau44fs0rf2ukPkGtbK2QcJua
         mkt/gIizLz8mm6za08W/qKODtpk9LCGguEn6+yfJTRihKhVFflVgHtXPBCpYdB1zczuA
         cbSOLVCi6CapK7gXBzrc6KBp3CR5YMOKnhpWaAO9CZD6JLcjDhYU1XqQ+VWgIlMJvQvZ
         nbgbpb6xiLj9Tm/ch1E1MrRLdqQXDiKwKNP7548SqfI6IYf95KGtKLfQRXNcOEkezlhz
         4yBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qmnEGEw4GlWMULdkiVbNmK9diWUow/RnoVpmZTSPKc=;
        fh=XMnCKIaKobi6slfb2CtB2/bIi1b3Q0DvS8D0Th0lLWs=;
        b=ax61EP9vRSLhZsZBc5SZjcDh1BV+RGI4C+R02vqkkJPyfwkkGuBEsUar/r2B4zUlix
         d/2mriPmJuZGRpH6iD8yhhOIFm+2FHU0J8lhinWb8vhVqk+ut2EHVWmk/rW+x05NrL7l
         +VPhWd9Lz71CQ8HM708hvS6YESjT2WydFUGdmpDCYIAfdIXMCemD2wa3ISQ831igfj+t
         xZQnHPujXoFAYTR1do10A5aA+mlbH02iKFsfXYirvukPHmcWK90z1uuUoMIoCQYUOfDW
         ANspc3ht5BRUR8ZdSc8C5X55rt0aIqgaJYrmjn0DeAOA4Jmwq635DGrwRuUtedJpvk8W
         Qlww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768666506; x=1769271306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qmnEGEw4GlWMULdkiVbNmK9diWUow/RnoVpmZTSPKc=;
        b=UuqnmGC97u8m+9saC1Fd6Q4kzBJJl/2p68++dNMk0PEAkgYYeUwkkt/YCpVHYAsLuZ
         7BzwIqmZFGH+ch3MJYlGM+cWAOkQpNknh4jTY0LnA5Z7nq+67anGH8SfYJ1CXmiCZnIy
         /Q5MfcQ45Fc5IWszDf/wBbYb5KReGdjpu9qtsxfTHeU8Atx7WnpbTBlx+koSmkWefSgr
         vjMZpTa4rdNMBGlfPLj4/EpbNUhLf5+t+haX+4RnWsq9LI7OxPHeCXdoZZz2Jgeu4PhZ
         G3Clv236EsZWq96OeeWPQamchsQG7hkoCkceN13tbu1/1HFuf8/N3f79YHJmQnH7m34s
         uM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768666506; x=1769271306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5qmnEGEw4GlWMULdkiVbNmK9diWUow/RnoVpmZTSPKc=;
        b=FySIzc/4bfZuoJAnVFdS48E1F8Gimc5YRol60ed44TkPzHlxdnagtQlcFIznMygEzq
         3soZyHEuw+aYLc6VeA/isKvQ9ulPSfRL6IURjNtiMDeKfIfIgcoktt/f6x/IWwzhA+q4
         xL+0+DmLCqzKnr+bDRmOvBlqnwGeCLohWsdkzF6Xx2I8U5uZZYHJN6R0JlYCWosYjWYi
         Wmxf0HuNAt+0EgHhEC76J84FR7xw7ZZ8d1JqGo2Fmt7VyctxNwfhYbx3uBlJdF+KWGPW
         r7pHRtT6WI32C2NMXc4dq+jsMGPqf8atYoVYHtfYIxlWF4RyJsqij9vDQs57F3mc7qgw
         akKg==
X-Forwarded-Encrypted: i=1; AJvYcCVW1LZUD+bnWh+KBT52wE9unXKJzH2ybn9F/A772HS2E3a0keo33EygsK6YnknN6Z/sB4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfHS0W57lyRiZ/jkahY17rfKB+SZ7Tz3gFnS5IMNv0XVcZwmR
	FCs029s/0k4+MFYFGVKHTZ+s7qavEX3yF2H7jh/g57fbRhBeULvfUkeMQE4p3rLfrRlbDJ/SAq0
	6TIIBzwU3Agzg49lhuxvUMGm0eXqz95U=
X-Gm-Gg: AY/fxX6wdS5Aa8BXGGcwY7CDKIx7XPJ6WBTRcEa9KVMsIzr3kgarjbHjcXsLIzkZi8G
	Cr+EDqtF2BEWiBsSgzyOytNwPtSds4P0jmpwdCBstVrA0KzgDj3gbYBq0OeQgz2QOeoiDiBBFGg
	chwCzR47lgkxfEd+xjPya/FvqHc/l3r+qqlwN+PzB1RgTz78rPNjv7n8iUfW1Fb0elQ2dVjf0pH
	MezgYuSl4jqS09XqXUbAG7TnJbt+3Jjihmb1XUmXI6WvmPJGb6KOCToGJgbtZhWkUV5+IU=
X-Received: by 2002:a05:651c:2211:b0:383:1832:9590 with SMTP id
 38308e7fff4ca-383841489b7mr21522641fa.1.1768666506083; Sat, 17 Jan 2026
 08:15:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
In-Reply-To: <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 17 Jan 2026 09:14:54 -0700
X-Gm-Features: AZwV_QiViyJeagj01C0tfkN9ZnzmPuXDlr_wYI0wXPoloOh7gaBA-WG39sPSOjY
Message-ID: <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:39=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> I've Cc'd Peff and Ren=C3=A9 for a second opinion if you have time please=
.
>
> On 15/01/2026 15:55, Ezekiel Newren wrote:
> > On Thu, Jan 8, 2026 at 7:34=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
>  >
> >>> +static void _set_capacity(void *self_, size_t new_capacity)
> >>> +{
> >>> +     struct IVec_c_void *self =3D self_;
> >>
> >> Passing any of the ivec variants defined below to this function invoke=
s
> >> undefined behavior because we're not casting the pointer back to the
> >> orginal type. However I think on the platforms we care about
> >> sizeof(void*) =3D=3D sizeof(T*) for all T so maybe we can look the oth=
er way.
> >
> > If someone finds that this code does not work because of this
> > assumption I'd like to know. But I can't fathom a case where it
> > wouldn't work.
>
> So we have two different structs
>
> struct IVec_c_void {
>         void *ptr;
>         size_t length;
>         size_t capacity;
>         size_t element_size;
> }
>
> and
>
> struct Ivec_u8 {
>         uint8_t *ptr;
>         size_t length;
>         size_t capacity;
>         size_t element_size;
> }
>
> One the platforms we care about they will have the same memory layout as
> all pointers have the same representation. However I don't think they
> are "compatible types" in the language of the C standard because the
> type of the "ptr" member differs. That means casting IVec_u8* to
> IVec_c_void* either directly or via void* is undefined and so
>
>         struct IVec_u8 vec;
>         ivec_init(&vec, sizeof(*vec.ptr));
>
> is undefined. For the compiler to see the undefined cast it needs to
> look across translation units because the implementation of ivec_init()
> will be in a separate file to where it is called. Maybe that and the
> fact they have the same memory layout saves us from having to worry too
> much though I'm always nervous of undefined behavior.
>
> An alternative would be to pass the individual struct members as
> function parameters
>
>         void ivec_init(void **vec, size_t &length, size_t &capacity,
>                        size_t &element_size_, size_t element_size)
>         {
>                 *vec =3D NULL;
>                 *length =3D 0;
>                 *capacity =3D 0;
>                 *element_size_ =3D element_size;
>         }
>
> and have DEFINE_IVEC_TYPE create typesafe wrappers
>
>         static inline void ivec_u8_init(struct IVec_u8 *vec)
>         {
>                 void *ptr =3D vec->ptr;
>                 ivec_init(&ptr, &v->length, &v->capacity,
>                           &v->element_size, sizeof(*(v->ptr));
>                 vec->ptr =3D ptr;
>         }
>
> That's safe because we cast the "ptr" member to "void*" and then back to
> the original type. On the rust side the implementation of IVec<T> would
> also need to split out the individual struct members when it calls
> ivec_init() etc. It's all a bit more effort but the benefit is that we
> don't have any undefined behavior and we have a nice typesafe C
> interface to 'struct IVec_*'.
>
> Thanks
>
> Phillip
>

If the size of different kinds of pointers ever differed from the size
of void* then wouldn't that make all calls to malloc undefined? I
don't see this as a problem since I'm not casting between structs with
different members that are not pointers. I could use void* for
everything, but then we'd need an accessor like *(T*)ivec_at(&vec, i),
but this is much more painful and error prone than simply vec.ptr[i].

I agree that the example referenced by Rene is problematic, but
irrelevant to ivec in my opinion.
