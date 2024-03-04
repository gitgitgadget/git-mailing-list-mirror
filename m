Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E10168AF
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539237; cv=none; b=fItEaxA0IZq5RqXJw2M19PzIZwFxqfK/9RqQM5SsytVW5HzU2gWfyh0frW2DAxdOkHBoah8M+slJcvpAL8prG/oLXDbhBb6feZbCY5OoG/7fhhVOjPaJPZggzP5C2MRlkqtW/YK9x4GN5T2SCT3glE7qFwnS6xNmUEXz5nz4REk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539237; c=relaxed/simple;
	bh=rJHuhHyUrjGxZfXyQbPnxqc+fk21CGRUSm0O7aCDmE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENzKH3AB3yKfqShItYoRcGOMqpYwp2iQQH2wgVixj9bvjP2rDoMWHhw3QIk7l1+d1DE0hDEqz/Ga1TrQtFnjr94H4DH0m7yv/VWRCP0CBD/9ixVxfcXnM6DFXvy0hvG6grM4l/r1Y16TQ/ig/q7gSGhSl+57hoWDZ95RMoSondE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNPoWKfk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNPoWKfk"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44d084bfe1so202758966b.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709539234; x=1710144034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJHuhHyUrjGxZfXyQbPnxqc+fk21CGRUSm0O7aCDmE0=;
        b=HNPoWKfkCEff1tPdqMuiMdyNaNiPfwVffjRPgLGYfMHoYlsmX3hQViEvU9t+3WWexV
         ffvw4EnHFY32DkdUFKq8/kKgijs+M2PivGCJZaCeX7ToU6CMrtqyaY7wiAeXSb2wV3Gu
         +7ztETidEnRtYZsdYBL3Y5NRBaxmTLOz/twNFLYHj6R3NpWH2cuiY+lBaKfmz29EY0Ca
         tycD6ehDH9SmXW6EWdBZFsJpp2RdtqD+yYdurgdG2gdLsGxkSXjyYavf7SqwD4/UkUdA
         3KC9LjGEquixv2PW3HHbfvdFD+HEEMXRyU2vufnzKtOBYYoy7xXV5AABxCwL9B7Rd/km
         QjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709539234; x=1710144034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJHuhHyUrjGxZfXyQbPnxqc+fk21CGRUSm0O7aCDmE0=;
        b=q0JyzHSvYThNXU6DNhQjh6iWJtKlKJ1jK0mqUw82SceJ5f85Sy5KatVS+GQpDwIwqa
         Ig0b6GgZeYWateB2m55ipV36tRYHOT3tAu6RI5sr6j0T1obtrQHISVOyDnj2i81RFX2S
         VTSk/04815YpYjmDw55WwVqqFac8UCZUlShkfbRWyqz5ookYIKrMpT/DXKmSgnC6Hh86
         l84zhAeUPEA4JwTFcwsQb1s+iJw+XuMO1pW1JFFI5CMpgB5HICAyUPqiTXANUwcUSSrt
         OPwEHbK7ijJrbe/i6BOikKvycILZK/tTaVfwJ0PKeQDMqlvzFm4xaje9czNOSMYkpgnY
         nH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx5iBoQcsquroRPMe1b8uv0qKUnmVZZVpP60nEwOa71mlyYPjDuW+JkQ+uriqHnJYDuchGVQ+eBbademFbLVfennxr
X-Gm-Message-State: AOJu0YzBK2pWg9t45/KQWpn7Q/AI9hyMRgA4yPB/tLSTobHZpuI3gYhu
	fY0tL7LwdUoWinIBx2YRgDvwOprQZAxWduJf9dZl8+caFu0NvooC8oA8cksQHI2ZTeKCNVnVzxH
	J2c7+B0UzRebU/b8t1AEbq+xO9lvHtCsGa98=
X-Google-Smtp-Source: AGHT+IE96QxgW8qb/NOPI8hfEvgijY9cC7rHpy7YERX0UGJuEfyzkPrifPvToHUJhJsOsaCDTtACmM1Nb9xWNIovBxo=
X-Received: by 2002:a17:906:4148:b0:a44:f89:a04e with SMTP id
 l8-20020a170906414800b00a440f89a04emr6289529ejk.35.1709539233914; Mon, 04 Mar
 2024 00:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
 <20240218204044.11365-1-mirth.hickford@gmail.com> <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
In-Reply-To: <CFC1A507-A9EF-4330-8C98-34C2B73BC036@boanderson.me>
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 4 Mar 2024 08:00:00 +0000
Message-ID: <CAGJzqs=wQA=t4CMVu-kap1ga4DX+KnaVMGy71ewmZ7QkFHF8sg@mail.gmail.com>
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
To: Bo Anderson <mail@boanderson.me>
Cc: M Hickford <mirth.hickford@gmail.com>, 
	Bo Anderson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Feb 2024 at 23:24, Bo Anderson <mail@boanderson.me> wrote:
>
> > On 18 Feb 2024, at 20:40, M Hickford <mirth.hickford@gmail.com> wrote:
> >
> >
> > Could these tests run as part of macOS CI?
>
> Do we do so for any of the other external credential helpers?
>

We don't.

> It definitely makes sense in principle. Though the concern perhaps will b=
e that any new features added to the credential helpers and thus its test s=
uite would need adding to each credential helper simultaneously to avoid fa=
iling CI. Ideally we would do exactly that, though that requires knowledge =
on each of the keystore APIs used in each of the credential helpers.

Good point.
