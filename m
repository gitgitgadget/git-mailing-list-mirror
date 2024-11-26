Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BA1D90AD
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639984; cv=none; b=MCCvVa2kQ2cS6WNuG5pZPdOy7DciqXMV2genzNnQU2zU6y8UVsIMBSrMgiNAUq0Hw9dUzGi1U0hb4fym056wEHimFY3L7TtASGwDtqe5wjPywCoa0wJth22KBxqxDW71DQogb92pFmuLXhO2isUyTa8nPV3kNWEhedly9UF0nkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639984; c=relaxed/simple;
	bh=EP84hOaMvcDCJKmJdoqEMUuG1MCpfhx5bpMB46sph1w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECAJ3NS0yDH7XtlknXIkIRbWxgfVElpwy6rpit/fin4C8pWULIrB7d9HAZtVPa6EwS57MbGTD63ls/1wKucHBjGtE9S1Nrv2TfsqmFAyhVAOuAoyrhw/W3dyz/FPpgG680xVj6fSfzQ9vLINjEjhdV4poyk8GC7n4EOt13/s6YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbllMx2K; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbllMx2K"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51511a1bd53so951283e0c.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732639982; x=1733244782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj8zhp5a4EcAMzhGemK25sooeruO6aWwwbZ1GGpj8V4=;
        b=EbllMx2K2+WapeKFCWA2T6nd4f2gC9Pk/k7JjRwyNnq2aoOnJPiMCCVCoQ84wvNGL6
         w96BhJCBq7j049Ommq+/Cz6Fg/qskyS3J3MJBXV96A5488zNEcJoC8zWMbwk0U3WG8L6
         SbjaKROE/9nTTNr1Cu+nk4jaDY1oLS2tiWp/ZJB5WKI3R/pzVbVcoq/xpVlXiAeRM+oi
         1eEFKpEpAuEtIiG5q9231pSQBwcnvz8zQ+7RyCbwV7d7I/W/iqybS+E1FKy2lt8Mfvhb
         d6x3Zv/sISK6nZpmtaBWtFIbhFHuE/OuEGAh17Y0O4NmqE6TxI5HrNFVpFE8GLj7DA42
         qR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732639982; x=1733244782;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj8zhp5a4EcAMzhGemK25sooeruO6aWwwbZ1GGpj8V4=;
        b=W935MU1xxUf7Wa51GO4mvQdGBCS299eNx9BMpsOz3TFX5i8VtRvgbrY9iXBbILrmur
         rtUno5Mb5P4FtziQL6Dr5aO3iqFja7+X4GalAedSg4m3Kw7i4w990YTRkour2zizPIKx
         7eEKMwk7xRh0mh1fisUOo07VBOFJffrodwdtr9xmnMTJrYJCi5p6/xR55numDE6kn85f
         raNE0YvagOLBPbfnB6/ynlH8He/U2AIhzj8pYOh2vRYKUzHoNccxArHJk+p/lyMWeS/u
         gMF27XARYCFdSkDnglOLpjsc4b+905v56eP8qetnxMKeZlWMfNo56VikTaEKs60mBkuA
         niDA==
X-Gm-Message-State: AOJu0YwDBoPDEWqy7mtXbVvAwZUEVZe4HguTA7/3kBfawJoQMgha/z9N
	e1O7969Xu0AiFeH6OedwNYhHqTTYu8qvLYn54T/IZ7argWVJLZweOUl5tEeXl0FAtFomlz/zH0R
	TV1tQ7xosG5wmAtyov+mduR5gfrg=
X-Gm-Gg: ASbGncsKaz/qZBBMQSQAT5s8Q1pS3WKYEkRO9oBMXqj/p86BtWjeFM3l5DBA8Wvemnx
	FbyWZDminScLMF/deJWWIJ//S78QXfQ==
X-Google-Smtp-Source: AGHT+IEnlJebYwvGpyalpSPrv1Ns1yrjeQ0fcjPbX5BZ1KpW2M/jEO2JnKQkroBaOtOMj0uXu72+3RZ22GBy8tioDvA=
X-Received: by 2002:a05:6122:251b:b0:50d:4b8d:6745 with SMTP id
 71dfb90a1353d-5155681746emr182183e0c.0.1732639982183; Tue, 26 Nov 2024
 08:53:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Nov 2024 08:53:01 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com> <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com> <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com> <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
 <D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com> <xmqqwmgs6mxk.fsf@gitster.g> <D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 08:53:01 -0800
Message-ID: <CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of refs_read_symbolic_ref
To: Bence Ferdinandy <bence@ferdinandy.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000a984600627d3ae96"

--000000000000a984600627d3ae96
Content-Type: text/plain; charset="UTF-8"

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> sorry about the other thread, I saw "extend whitespace checks" and I thought
> based on what Kartik wrote that `log --check` should have caught it, which is
> why I thought it might be appropriate there.
>

With v14, running `git log --check --pretty=format:"---% h% s" master..`
gives me:

  --- f73b2c577b fetch set_head: handle mirrored bare repositories

  --- c0c84fb7f9 fetch: set remote/HEAD if it does not exist

  --- c366911074 refs: add create_only option to refs_update_symref_extended

  --- c47704d4df refs: add TRANSACTION_CREATE_EXISTS error

  --- 22e7a9bcae remote set-head: better output for --auto

  --- 25d9944eb2 remote set-head: refactor for readability

  --- 01fe46c842 refs: atomically record overwritten ref in update_symref

  --- fed56bc6cc refs: standardize output of refs_read_symbolic_ref
  refs/reftable-backend.c:833: indent with spaces.
  +        if (ret)
  refs/reftable-backend.c:834: indent with spaces.
  +                ret = -1;
  refs/reftable-backend.c:835: indent with spaces.
  +        else if (ref.value_type == REFTABLE_REF_SYMREF)
  refs/reftable-backend.c:837: indent with spaces.
  +        else
  refs/reftable-backend.c:838: indent with spaces.
  +                ret = NOT_A_SYMREF;

  --- d5534d6c67 t/t5505-remote: test failure of set-head

  --- a77b3b7774 t/t5505-remote: set default branch to main

> On Mon Nov 25, 2024 at 03:56, Junio C Hamano <gitster@pobox.com> wrote:
>> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>>
>>>> At the least you should see `git log`'s output, but if there are issues
>>>> they should be shown inline. So when you say 'no output' do you mean you
>>>> see absolutely no output?
>>>
>>> Absolutely no output:
>>> 	https://asciinema.org/a/lsqp4e1bNst6cFWw9M2jX1IqC
>>>
>>> But I figured out why: the whitespace and the tabs were not mixed on the line,
>>> just across lines. As I read it, that is not an error to have tabs on one line
>>> and spaces on the next.
>>
>> Our .gitattribute starts like so:
>>
>>     * whitespace=!indent,trail,space
>>     *.[ch] whitespace=indent,trail,space diff=cpp
>>
>> so, unless otherwise specified, we frown upon trailing whitespace
>> and space before tab and indenting with non tab is permitted, but C
>> source and header files have further care about "indent" (short for
>> "indent-with-non-tab".
>>
>> So mixed or not, if you indented with spaces and not tabs, that
>> would be noticed.
>
> So `git log --check --pretty=format:"---% h% s"` was _not_ supposed to catch
> this?
>
> I ran the CI with this patch again:
> https://github.com/ferdinandyb/git/actions/runs/12031250376
>
> and it's all green, so wherever this _should_ have been caught: it didn't work.

I'm not an expert in GitHub actions, but if you look at
`.github/workflows/check-whitespace.yml`, it says it is only triggered
for `pull_request`. Did you raise a pull request? From your link, I
don't see the whitespace job being triggered, so `it didn't work` would
be inaccurate, since it didn't even trigger the job ;)

[snip]

--000000000000a984600627d3ae96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 640f3ba1fc9603f5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRi9Pd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmtzQy80dVFNd1FvOXJ0NVM2WGI3OUM2UXk5T042aAphUm9jVHgvU1J5
QnFXcjdEcHpSWVhySWpqRW1oRWZDRXhDMGJRdUhEejlQNllJWGRMdEJGbWMvZHcwNXNtbE9UCnJ2
WWxuZ2xOcDdHQzlxSVlndDR6cXNMU04vUVo4QUxBc2ZiaTJMLzZ2b2U4K2FqdmZZSGs5eTdHMDI1
aFpubUYKUGt0UURwU201SVNHeHVlYmFNT2xjNXV6QVk1WlEycTRNcFZocFg3NWlLTmhVNTN6aVRo
Uk9vUXRIUk02S0IwTgo0SUpqRVp3V2wxbERtV3ZkQWVIQ1FwUXRIUlVEUFRUd3lRcVlqWitkczZC
SjZRY3pMODV6MytVajdMR294MnkzCkNNZ3Vxa3pYOU9yVGR0L3VSbU5NRDdPREplQlJVMzMzN3dQ
NWZZWkg0eWxXSXZCeUJ3eFFXa2RmTFpzenZjUmgKVHNaNk0zaTM4ejh3cm90Z3NIM1RtVzB2c2pr
VldUZFpYc3Fyd2RjS1o1UEY4QS80L1FUZDJnZlRWYklGaG14cwo2SHNzUUU1ZlJ3eHptQmlmYmdD
M1gyc1FYcFJMWWRWZk1nTFNqNFhSMnA4d2I2UXNkWUpzZnBRbWhPNG5OUmpwCnlIOS9sUTlBaGxp
VEcrL0VuSmZhNmlYcXNTTlkvcm9IVFcwemgxND0KPXJCZzcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a984600627d3ae96--
