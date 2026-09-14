Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97933393DF5
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378416; cv=pass; b=tPJxruPB6lhy64nAd5+wJdOIYRZ/gLsjv2kkj26u3nQSYiC6Z3kMacvPufxhCkP6Ov5KXA3xRj7yU5SHkIwzgRPKS9iaU8NzzF17hxD3Oyc8za1aipZsp1SfBjtXYKhN9YNyU8+q20ACfFgPMZ+u17qaxReOuRuGUswpwTrq01c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378416; c=relaxed/simple;
	bh=3xQrJg1JFXjI1zzD+hAXdtfOEjzOeKR2Os/v7hCNHQA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTkO1jJTWJJbkQ6R3BgngsvBJnlOCJKWVJXbJVxWyLHLFHMXOjemXSMQO6wvMG8RppPOrXgLMh9vEUi/RYTy+Kwikv4/TEU83uLDaOvqzq7Av14SdgxsW18QD0I0ifBM5vmb6xHsJ4uTLd/CVwBchc1BwXQYw6BD7uqYHyntVS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVAuLHTA; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVAuLHTA"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97e9c0da212so2294641241.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 02:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378413; cv=none;
        d=google.com; s=arc-20260327;
        b=eKRYXWng+8ffC8zqc90aQiPKgfkjGw8cI1IInqRlXVLFM5SOt5J/HsrKnznAS+8S7h
         5VE83npkQ7OJJm2RjGgKqXrQtACF5wi+VXP4/pgiwR4qSZ7TX7+6SevwFGzfkCY7tBtd
         Gb6o7Ah5Us4AAUAyZ/OqjwQNX/3738A21xa5Xtley1AiH7Gh18nRYqMw1GPskaYJ199t
         zODZRBb5t7VWapYr/EdYW4q2YDDReLbeMzjqo6PP52KEONwGKLf5saJ4g1YH9xAtRap6
         HCz99zK3g7ewrWBzTPaumUBriN+W5OOk7WgkOFkz4vU7UkU/Zy32DqBKcWZQt4SKJ5Fv
         f3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=M8eQZTHylVGQHyxADbV/rOg1eY6uctTKMzonL3asdP0=;
        fh=UV1BlsTLw2hHMmVQ2ZGEDOjtt6DUSydkhzg23YSixo8=;
        b=OVpo27NRCB6dr545244b9p11kqA1EgtCzzhkiDjGr8EIjgIBaGYmg5z4dLSwPp5AvS
         o14WyJD4VCwc4QfnOfPZhfQo56ZJlx3qp9/oIDtRFt6TbAST1BXuX/qQs5ILNKm0wFja
         Dwqmk4nTjHK9fdzQqi1h8SLRKbhN4OLzBGu3bhlKqadu9KTprTgnBWznTBB/e6HiUVPR
         jmZmJeU98k+fXUHSD9KvHdvvFkZoo0bstNGAFjNi8rL0OVwCc34E7hZ4Haaza+Kq1YdT
         dgRxPYbhrDeC9eciolxFru1zVHDEu2YVGeRcVykfyOeMeRqGULoNTxY2FKosYGrPcv/S
         305w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378413; x=1789983213; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8eQZTHylVGQHyxADbV/rOg1eY6uctTKMzonL3asdP0=;
        b=jVAuLHTAIb8EXCuWhfOfk6nqHMdOxfdxKIOFwhC1ripxkdxbOs6Kh91nkTSlxJoEYm
         CCK9fMkXTmBaCSycuuX0HKGVNRzFu1tH/9Cv4mX+8fDGY2pUwrfMyqUhqGMT7nIiKJIZ
         tzvpNV4vA7vH9NDwJIHxYNC1QtawTFHeoSVCuNTOQCbbEtWw9NxHbvilG/a4gJsNVIMY
         URhP5Wb+I0B0XnJpirQf1jwJq6lMhWV/tIo91GUeShxjxd3W+FGK/O46TD2D16xLjrYz
         gaCRmTy04Kd83O0YjXUbo23LVGNo9WUakfGjvSnr73EowQYwAw/knocYRIxPLgzNpzg+
         1QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378413; x=1789983213;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8eQZTHylVGQHyxADbV/rOg1eY6uctTKMzonL3asdP0=;
        b=RyD9ZQlLMpFYiVErM51NQ+9rDEf8/Ur0VSTa2kpIRtB/wceGQvfgQLZ8D40837aRhW
         ej1Dl1/5f/fi43ASszdy041VpAYuye+EjbUMsLM/6P9JojOA+5OKY/QZm3IgqMves39G
         2ZwcqYcd8L3547dWdRY/AzVvM70VQz3DdsIquGYWMvxK14rehfDzQsAzj8iBj0HKF1wH
         gqJGpm952vKC2q/Q9ueBKsZP52Jcp6SfU/q41XOCCZiHIXxAkCQCv5Y6UltQ1C26mfwI
         2Jc3YL6hSyQ5KvdtTcYiJIda+1UIae+MQdJ/FgcfiWIKasOVPg400IVTnUNVjbghtXyC
         I5BA==
X-Forwarded-Encrypted: i=1; AKwUvBySwqxrkfWVAqyVFndm8h0So+40Wi9SV9ppswu+UgPqvCbRN2K/O3lUs8+1ujnrNKTRgJA=@vger.kernel.org
X-Gm-Message-State: AFuF++lHLcTBcU3dh+A9uYouRRg1yb+gBYvGES8K1pBJLPRP0KWbF3xX
	FyJzycvVkEEcegRbf8oBl0AbRaiU6CksqM5RWx/Z6P6QYumoZR2lz+p1g7pudbY8Q0gRhV0DrK9
	Q2y4Dy53CPIbOJHjDmMwZMQ5anhUOll8=
X-Gm-Gg: AYBFou0emOoReY/H2JnUT+vpNmoK8s70HJKatR7HjGi8S0u8X4ry1k3rnnhgt8V94jn
	RC3pd8mXx+lSeLVA1VBQ3kkOJkC8/q7ZIDB1moyN1JJOHwkpvHHlu9yko8OrR2j9aFcCPDZwIsW
	T4ZVqHM4Sgvm/4FiIBvRf5e7fnNLvbFKkKv0YitZwA+fbw+jETERiALiQi+k/MrrSoGVGf8C1Rr
	WXOH+dQonwfBdq4tW8JO8MFv4CCRzDed1b6aBEUocQxmxV+w2BrsGhkSHjzDOWmPip3eyfeWDVV
	/anRK5YnQ6DdN9CliXF8YqrklliNHIxZsk1ZqPYewaKFPJcxodJsAVKwz/pdS+XMFUT3KkK8sqb
	EiDspZCWkKA9q+3xbOsqNZtdSMxpGdoi4RWk7TULq+sSVOw==
X-Received: by 2002:a05:6102:54aa:b0:785:c960:ff85 with SMTP id
 ada2fe7eead31-79b5915afb9mr876160137.7.1789378413328; Mon, 14 Sep 2026
 02:33:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 02:33:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 02:33:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-1-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
 <20260909-b4-pks-unify-ref-storage-format-v3-1-ca041fb40ad8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 02:33:32 -0700
X-Gm-Features: AcwNN1W88Q787KFqs-ru8M75x2p_4v_BU_t7foBNh4dhH2RIWHKJYDSCJL-xgDI
Message-ID: <CAOLa=ZSh_H9tjnjEsRrmGXm1Ht+3a=gRaGibO6BKZvvkEabesQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] parse-options: allow for hidden aliases
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b222da065b6e2061"

--000000000000b222da065b6e2061
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

TPatrick Steinhardt <ps@pks.im> writes:

> The `OPT_ALIAS()` option can be used to create an exact alias that maps
> one option name to the same semantics as another option name. This
> option type is especially useful when deprecating an old name in favor
> of a new one. But curiously enough, we don't have the infrastructure in
> place to properly support this use case because we don't expose the
> ability to hide the alias via `PARSE_OPT_HIDDEN`.
>

If we're going to hide the alias, do we need to even use an alias?

=E2=9D=AF ~/code/git/build/bin-wrappers/git.thisseries init --foo
error: unknown option `foo'
usage: git init [-q | --quiet] [--bare] [--template=3D<template-directory>]
                [--separate-git-dir <git-dir>] [--object-format=3D<format>]
                [--ref-storage-format=3D<format>]
                [-b <branch-name> | --initial-branch=3D<branch-name>]
                [--shared[=3D<permissions>]] [<directory>]

    --[no-]template <template-directory>
                          directory from which templates will be used
    --[no-]bare           create a bare repository
    --shared[=3D<permissions>]
                          specify that the git repository is to be
shared amongst several users
    -q, --[no-]quiet      be quiet
    --[no-]separate-git-dir <gitdir>
                          separate git dir from working tree
    -b, --[no-]initial-branch <name>
                          override the name of the initial branch
    --[no-]object-format <hash>
                          specify the hash algorithm to use
    --[no-]ref-storage-format <format>
                          specify the reference storage format to use


=E2=9D=AF ~/code/git/build/bin-wrappers/git.withouthide init --foo
error: unknown option `foo'
usage: git init [-q | --quiet] [--bare] [--template=3D<template-directory>]
                [--separate-git-dir <git-dir>] [--object-format=3D<format>]
                [--ref-storage-format=3D<format>]
                [-b <branch-name> | --initial-branch=3D<branch-name>]
                [--shared[=3D<permissions>]] [<directory>]

    --[no-]template <template-directory>
                          directory from which templates will be used
    --[no-]bare           create a bare repository
    --shared[=3D<permissions>]
                          specify that the git repository is to be
shared amongst several users
    -q, --[no-]quiet      be quiet
    --[no-]separate-git-dir <gitdir>
                          separate git dir from working tree
    -b, --[no-]initial-branch <name>
                          override the name of the initial branch
    --[no-]object-format <hash>
                          specify the hash algorithm to use
    --[no-]ref-storage-format <format>
                          specify the reference storage format to use
    --[no-]ref-format <format>
                          alias of --ref-storage-format

Perhaps it doesn't make sense to add flags to OPT_ALIAS() at all? But
this is indeed an alias and seems like the correct option to use, but
feels wasted. I'm okay to keep it as is.

> Introduce a new `OPT_ALIAS_F()` function that allows the user to pass
> flags and propagate these flags when rewriting aliases to match their
> respective source options.

[snip]

--000000000000b222da065b6e2061
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c775b4a1ee91a194_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xbnYyb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUZzQy80eU1YZkNnbTRNWVp3MTVxRDR2M052L0h3UApDeGpKOXRWbjZS
aFhuYVRJUWJGK3Bpa0VXR3Bhcm9FNE9aK0dWa1V6WVJmZWE2NXBjdjQ5MHNKZm1jblp2WWx5CmtB
KytZTnlsNXI0M3R6NVE2ZTFzTS9FVk5rS3JlMlZFaHF0MWVhS0p2aURsZXJyK3ZiMXhScWg5YXZY
bmxNU3YKRWRBN1ZHRTdQdjNZTmM5aCt2NmNQbTVUQ0NlSG4wSkZyaTAzNHp0bXZoempwR1BoOVlQ
K2k1c0pjdjZyQ1NCMwo4WEk4MCtKYzM5OVVhRXlyMXVPZ1hocFFZVnVLWWJpNi82eEZ6QUdEMyt0
cFlRQk5IZnNObjRwa0R1a1B0bTVRCjRKVU5QSjl1RmFLbW95aEFaZGc5RCtxYjM5Ukh3U1doSHBn
SGx2QURzVVFjMmh3Z1RBY2Y5SzVML1ZDbFBQa2kKdXFnRFdUVUZXMVNWQ3Zqd2VSb0JCSEJreDdT
MExxQldHMFQyVU9DUmxoSzkwdDFHSzBCWS93SUorKytxckpsRgo3VHFOTTE2cEJrL3hiVjNtWWJ4
blVVV3lJZndOM1h0bGpHTXd3UnEyV3NFbVZCQkhnS0JVaFFWbFl4UCszMlk2Ckt4SjljSVMwL0o5
K094QnJuRTFwUkV2V2FQUktXUkdDWmpTQ3JNbz0KPVVDWHUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b222da065b6e2061--
