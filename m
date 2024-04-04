Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F781B7F4
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221260; cv=none; b=IJ/4OfoKJJ9ZUcpAw2tRtkm7VUafRjggTliC5b6/tohFMArHEEFMPz4JzDRzq7Bp1luPJeBvcJXB2GTw//8lyN4q3olAmaWgHucXv6SBq6j1IbublOsp7txlWLaJe5sNFl8QIDYbFbv6+oMERikDU4SqGBs5YvaIT75/+IF7gzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221260; c=relaxed/simple;
	bh=agkgnGN7j7co3h07pU74EPpfm8IJEstdRU5SPkjixXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDF7ITbO7K3YU/MacM8qtKjFZgzZq9BRfTXJ6u8l54kNYj3JL4DaeNtwEVZ3uX+rJpjRYXb0tCHr1igo8VuY/ufEY+WSA/IsUeCm3JZdKlUi3jrfyz+nlXSCQnbnDd0gwoN815AmL9RxCKdnbjSNsur+6U3Fj63du4XixMeL6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maLPkpEj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maLPkpEj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0fa980d55so5346345ad.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221258; x=1712826058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+47z7hRtjukiyknwqR8r+BTUn8o6r86C3702godyd9g=;
        b=maLPkpEjHNWyrVaJT8D4e9kkDJCcpFtIM6nz1JqRWLct9Js7zrg5ksyOyIvzZ6hbHx
         +mlIpylmSjNitPZSTjPYmKZuNOgHsQ1DmBPDjdyX1K0F9h31WZgKwNYJvq0I4mUnhEm2
         I0XdA7ODmv//LUj6l7YYYkaAf7riB40e802NdCH7ogedWAhPMb2BMCFjUP8PWWHfQwOs
         5EQEnQ5zIvaeIDZf/jSsjRdKMT2BlqE0KLl+GLiKtnnIOnuiaj/b8ytb75Te2usSfvFZ
         Kn9sun/NEWgW1uOmc5GXcmxzPZzBUFljLO9kWqEKyKfV+aGFCc6XAlt846G2wDbjjmiR
         T2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221258; x=1712826058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+47z7hRtjukiyknwqR8r+BTUn8o6r86C3702godyd9g=;
        b=wVFEAoDcNpuw86QjC2s1bA6MvyOF1zxS0fdnO4kQWe4EmqD82rh2/ujLotwNVacspf
         n/eHYqFPgOj2HpupVteiHS40RCZdm7HwwOPesbdknsarqXsBrOVL62x/As3DqNL05K98
         wUboB+lzXM25E88dgI+ATaojvW7+3ayVQkYAXmrnntB6KVvapiRKN2t3ytbmTEvY+awZ
         geELl2/ZT9fLo2Q0EcZIFcMFgVIOd/BL6LqD2Nl5ZocFmgzySoJdkcvXPJk7KX1vcpS6
         /f8OOtxr09kPOxkpQuNYaww5w24GBjgk9yVHGjy83erxg1NnH2Zp6N8WFKj1yu4e+YST
         1psA==
X-Gm-Message-State: AOJu0YzLjSDCOCGA1V9147JRrZRD8Gi5IpnkYEh6+cfhTCI3m85C83zJ
	hlY1qJelm4Cq7x3eNGfFdawRpLqf2Rc8Dam0LG29rNsiVZkfj3Gdm/LoRflMF7UrVHWnF3yF0cs
	w5XzJSurfwuZiQjhYhpAYx54nrFA=
X-Google-Smtp-Source: AGHT+IGKRMjyfg6pr8LPECkt0r6JdpqzHplNtyftDA5TFqbgrzIZqMEb3IpmSFY7jQT2CbasxAjq7tolltHU0l5Qgrk=
X-Received: by 2002:a17:902:8bca:b0:1e0:b873:ce48 with SMTP id
 r10-20020a1709028bca00b001e0b873ce48mr1380786plo.27.1712221257772; Thu, 04
 Apr 2024 02:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712078736.git.ps@pks.im> <cover.1712209149.git.ps@pks.im>
 <41db7414e17201f85b476af5e0183e72de450310.1712209149.git.ps@pks.im>
 <CAOw_e7aBPF1vPvF7iYXCM5VBQu-Nw00dO2pRC_6DU3PtdDUsbg@mail.gmail.com> <Zg5Xorz75NMRqONI@tanuki>
In-Reply-To: <Zg5Xorz75NMRqONI@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 11:00:46 +0200
Message-ID: <CAOw_e7a9BnEh2OatwaGoSyVK46Wv2-sVkArbtXHLPt79b6g2qQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] reftable/writer: unify releasing memory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Thu, Apr 04, 2024 at 09:08:46AM +0200, Han-Wen Nienhuys wrote:
> > On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > There are two code paths which release memory of the reftable writer:
> > >
> > >   - `reftable_writer_close()` releases internal state after it has
> > >     written data.
> > >
> > >   - `reftable_writer_free()` releases the block that was written to a=
nd
> > >     the writer itself.
> >
> > The bifurcation is there so you can read the stats after closing the
> > writer. The new method makes it harder to misuse, but now you have two
> > ways to end a writer. Suggestion: drop reftable_writer_{free,close}
> > from reftable-writer.h (rename to remove the reftable_ prefix because
> > they are no longer considered public) and find another way to read out
> > the stats. Either pass an optional reftable_writer_stats into the
> > construction of the writer, return the stats from the close function,
> > or drop stats altogether.  IIRC They are only used in the unit tests.
>
> But even with these refactorings the stats remain intact after calling
> `reftable_writer_close()` or `reftable_writer_release()`, right? So it
> basically continues to work as expected.

Right - I misinterpreted your change.

> It might not be the cleanest way to handle this, but I think this patch
> is an improvement over the previous state because we plug a memory leak
> and deduplicate the cleanup logic. So I would suggest to defer your
> proposed refactorings to a later point, if you're okay with that.

yes. Please add reftable_writer_release to reftable-writer.h for
consistency, though. Or remove the reftable_ prefix.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
