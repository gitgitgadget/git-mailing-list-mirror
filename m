Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D618B04
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtthPMyK"
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9425D126
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 04:15:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so443072fac.0
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697800519; x=1698405319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddJnt+WE47+aWwJJEvAw1rZi1wkjfX1V1Y+F4/+pEso=;
        b=ZtthPMyK69HkZ/aPDD4cli9l2H7/3rKj9x4lUEc+HB4pf6TuqIV8b7LRlGPpi6mWop
         fAtOlgcYz/pjhMx/xe+tSWqMy9mszs4wF6yZMog2ba0MXJK6zpJwmTtbAdn8rhP436/1
         /lcOHAeLJ5AG+M42xtKB7+k9WJu79vR8JxYf9pEbeOErz3D97DAD8SU4XrMWfe9cHvyN
         v5Mu86bjYUaX84gqNMJmAixlphUczxP3F+TzB5v96/yMYlA6Ny6G5AieQRdHOccVkwAa
         73dRLYQD/m2cxk2w8ZIo9LSuWj6L4RVx4MFHfjvchXdtcnas4hUapnBVxYB33ON32nCs
         p9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800519; x=1698405319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddJnt+WE47+aWwJJEvAw1rZi1wkjfX1V1Y+F4/+pEso=;
        b=VBsFlZKX5zMT1qcBEuRJZ570qz/LZK8GV/pETrYSsnxdtUqYEDw4VjdO+/X4cZRm6Z
         r/B4wzmrtFmZUzWVBf+ZMTBe/lXS/A5mQGrkdr/y3GmSG5NJKqcld4KKJE8akEfAFy1r
         z+G5g/Sd/M+iQiEn5EfmgyFAkc1zCZPV42sdEJe2gJfKssGJfSvA80owxWSyvkthGDqS
         FGjMdDiHp8eRA53Doz6MQGosDwP3jgfvfnYklOhPyM/lX+ZszuK7yEF9Dm1qPKW7+oGj
         L65v7YhbRdsExYjPEFpqSA/dJcoOTwlGUocX6eVp0PM1A+I52DvAzZgCUo+E8gsGBi32
         sAtw==
X-Gm-Message-State: AOJu0YxrsGt02BOecG/0OyhHp2wg3vAzEt6aimzk65DPM/kguRzII/u3
	vocR21JeMTwmQ98jIB4THREXZFyLO/GG7HJzOGBdy8IYnHE=
X-Google-Smtp-Source: AGHT+IGVSSslSih1seHpLOx77t2U6kRJeTae9ymDlanawCWRSbScJDokz3YK8+PWUDC50Jpg9LEZWvJpYEczcl/y/Y0=
X-Received: by 2002:a05:6870:9d88:b0:1c8:b870:4e22 with SMTP id
 pv8-20020a0568709d8800b001c8b8704e22mr1899047oab.3.1697800518674; Fri, 20 Oct
 2023 04:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016103830.56486-1-karthik.188@gmail.com> <20231019121024.194317-1-karthik.188@gmail.com>
 <20231019121024.194317-4-karthik.188@gmail.com> <xmqq4jimuv26.fsf@gitster.g> <xmqqttqmtcc2.fsf@gitster.g>
In-Reply-To: <xmqqttqmtcc2.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 20 Oct 2023 13:14:52 +0200
Message-ID: <CAOLa=ZR4Qd9x-zVv9OtL7KTU00W2uT-kxdhKOLFZbi5cnHdiSQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rev-list: add commit object support in `--missing` option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Do we really need to allocate a new bit in the object flags, which
> > is already a scarce resource?
>
> Clarification.  I was *not* wondering if we can steal and (re|ab)use
> a bit that is used for other purposes, in order to avoid allocating
> a new bit.
>
> Rather, I was wondering if we need to use object flags to mark these
> objects, or can do what we want to do without using any object flags
> at all.  For the purpose of reporting "missing" objects, wouldn't it
> be sufficient to walk the object graph and report our findings as we
> go?  To avoid reporting the same object twice, as we reasonably can
> expect that the missing objects are minority (compared to the total
> number of objects), perhaps the codepath that makes such a report
> can use a hashmap of object_ids or something, for example.
>

This is kind of hard to do since the revision walking happens in revision.c
and list-objects.c but the missing commits are needed in builtin/rev-list.c=
.
So even if we build a list of missing commits in list-objects.c, there is n=
o
nice way to send this back to rev-list.c.

The only way we communicate between these layers is through callbacks,
i.e. the show_commit() function in rev-list.c is called for every commit th=
at
the revision walk traverses over.

I'm not entirely sure what the best path to take here to be honest. I will =
look
and see if there are any bits where overlapping doesn't cause any issues
in the meantime.
