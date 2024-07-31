Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C41BDC8
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446305; cv=none; b=oeHNfCHdUE7XaNRZI8/ke94u12JLpukF2WHPOFhPZsgIufOyE/AhygBNQ11M9j/8BInFVGQSW8/5Wf0j0cj91+bsLv92UTmZ06Da7kroI20tNBXehqXIGFw1otGd7Hwcf5FKMEPSUpVfiXdFLO9clKoMBuAqiu4Q0xJItMieFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446305; c=relaxed/simple;
	bh=G2/xU3oxtbxH4jOgOI7SXuRribloaKSE/Mzu8Yjz6/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLIqb4NatYzdwgSlgcybCw1x93Cf7R/apcy7GPTHY3jooLj65vZYJI8cLdT9x5kcmtuAT9duLIv4EML+L0lOL3Hhw07/7E4JmdAwTotHkAJgGPqzTdYuSoazDqXhIOjCO5SeHtcogkcwldP3JVEyT0uJ2bq2rr9QwxpSD0Qge28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAnT9wl2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAnT9wl2"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so795223566b.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722446302; x=1723051102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUD8JwqMCvvO9Kps0J9JZg8HIm1ZbAlxqvQQmU4Zk6s=;
        b=jAnT9wl2r9a13S5WCV9jSgMv1VNFCk0PZYlWQvXjEkoXDCvpWQUqgxk/OZPe6XWusf
         ZoAFmqBaRUY2tGR6fwW4lnMTO+SW9tSEURn32P09j0sMWICQVaRrS6ONMnHUwAnITWRp
         kOUxtROTOojah2UPrLkOpbRH2VMSvaJRc/DSBq5uBpgQgbqSDZmFpOehBROXx16ctQ6/
         218ePs6l+OEgyHgE9Pa/TU24sZ48OxNw4JrE5wfqp0IL8wu4hzgji8TJp+VfAMzEKzxk
         Tz2H2gdH/O/goat7h0rdvvqolWT4RQgHACLrf1p8faB5Fcd/+taqTQExlVrJh02SQwGr
         aJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446302; x=1723051102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUD8JwqMCvvO9Kps0J9JZg8HIm1ZbAlxqvQQmU4Zk6s=;
        b=GRUs1XWv3WI3UqYIDQ3OQ5x+DpQxk4yZUqnKRC1bF2oM/Py6Y5AlulZd0C83R5iktd
         u9XaT6LLh5FWWSIQm+rJ/J2hMauVAmjaWrWO+Lqi5DsCCIX7m/VQb3do8uob1xF59DUF
         KkCjkRLiwgrc0vYv7SWkTAAhWSDPPU2CVThcmrY8tJ7Zd+tadic7GhXLnzN9mEHZjqI7
         TLEH5KIHGE7A41OM92ypjIQwP36vAE6pMwax3aDTlYElgKbjDA5mZFvQzBo+vaKVLA2M
         pMC5+Pwl9oVRxQTYAOAnqgE5Vhc9vtHBBF52S9bMnmxPYech1h+RdXKRIsRSha2HRUlW
         oucw==
X-Gm-Message-State: AOJu0Yzznwix3Kiv9sDO1Cwvpede394ExrjppxKbpMvQ9ZvavQDGxVNn
	/f8qwNZksRRCWTW+Gv1qNhM38Fc7NUplCOthopyZIjTz2L+oqI99BukHZ40+H5g/pfPquMn1kPV
	AxomERIZSer4z57zsq/bDd+xhuXE=
X-Google-Smtp-Source: AGHT+IGR2k3qZQvQx5yeYbPZbWfHgwId24hvjo0cyq+Zo9Ni9uYAPTyH891FvJFLqwK87hcyJvsx7toFeCvI8j+h51E=
X-Received: by 2002:a17:907:2d1e:b0:a6f:f7c:5c7a with SMTP id
 a640c23a62f3a-a7d401e1597mr999400466b.67.1722446301763; Wed, 31 Jul 2024
 10:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711235159.5320-1-shyamthakkar001@gmail.com> <20240730115101.188100-1-author@example.com>
In-Reply-To: <20240730115101.188100-1-author@example.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 31 Jul 2024 19:18:08 +0200
Message-ID: <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>
Subject: Re: [PATCH v4] t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
To: A U Thor <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ghanshyam,

Not sure why the "From:" header of this email says:

"From: A U Thor <shyamthakkar001@gmail.com>"

Did you make changes to your config or something?

On Tue, Jul 30, 2024 at 1:52=E2=80=AFPM A U Thor <shyamthakkar001@gmail.com=
> wrote:
>
> From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>


> Changes in v4:
> - update commit message to add a reference and fix typo
> - change 'int ignore_case' to 'unsigned int ignore_case'
> - make 'ignore_case' the last parameter in all the functions
> - update t_get() to add a testcase query for better ignore-case
>   checking
>
> Range-diff against v3:


>     -+static void t_get(struct hashmap *map, int ignore_case)
>     ++static void t_get(struct hashmap *map, unsigned int ignore_case)
>      +{
>      +  struct test_entry *entry;
>      +  const char *key_val[][2] =3D { { "key1", "value1" },
>      +                               { "key2", "value2" },
>      +                               { "fooBarFrotz", "value3" },
>     -+                               { ignore_case ? "key4" : "foobarfrot=
z", "value4" } };
>     ++                               { ignore_case ? "TeNor" : "tenor",
>     ++                                 ignore_case ? "value4" : "value5" =
} };
>      +  const char *query[][2] =3D {
>      +          { ignore_case ? "Key1" : "key1", "value1" },
>      +          { ignore_case ? "keY2" : "key2", "value2" },
>     -+          { ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
>     ++          { ignore_case ? "FOObarFrotz" : "fooBarFrotz", "value3" }=
,
>     ++          { ignore_case ? "TENOR" : "tenor",
>     ++            ignore_case ? "value4" : "value5" }
>      +  };

I suggested adding the following test case:

               { ignore_case ? "FOOBarFrotZ" : "foobarfrotz",
                 ignore_case ? : "value3" : "value4" }

to better check that things work well especially when not ignoring the case=
.

This is because, when not ignoring the case, there used to be a choice
between { "fooBarFrotz", "value3" } and { "foobarfrotz", "value4" }
that can be decided only by the case of the key in 'query'. But
instead you removed that choice from 'key_val'.

And it seems to me that the new test case you added doesn't bring much valu=
e.

Maybe there was something wrong in what I suggested, but then please explai=
n it.

The other changes look good to me and seem to address the suggestions
made by others and me.

Thanks!
