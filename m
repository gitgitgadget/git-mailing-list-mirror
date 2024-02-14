Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFC1A58B
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920827; cv=none; b=PaoPOPcqCqpHNeGJD5U1C/EQydo8xJKnWoGwT15lAR6ADDOvhOfefK4Us0UpIYUnvUjewlrWwoe3MzanOTV+SkDR7KVasXmEBKTRdmKzy0M1iR/x4lS/1xiYwc7UjQwwHf4IrTmjGAjYujeazh2tsmDb4RmD0/2ef3AW+e9QGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920827; c=relaxed/simple;
	bh=HSYk+M7uRUJ7V7Vl61RnQIajl4AgPEOkzEGoyep2A0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZERcKoEpRumwkv+PFXHcIKP/jQ0vOj0JDvM4YeJmvYTpcl/vWYgoHsd7OvMJv8R+xprupI9jwfhoCa7U738cSzsd6IJL8sD6vxNxM4U8hAhegpwI8K5gr9sTaSfaBbvWiTRSeTQ9F0BWrgaa2nWnUqXIsTrmJ5AaYz/FTJBodxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFM+b5A2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFM+b5A2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d6cd979b6so22855266b.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920824; x=1708525624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQBIeZZDh236u3h4FmDgo/L28GDT+6iN3Wg2zRu3tgU=;
        b=DFM+b5A27vIjlsyityfdvp41rKK3WO+B6sQ9zjVzNR/4/CTpiBySadUXN3ku+uF4qU
         RQ39z0bA2PFKYoFJT4gmouHQe4mD3UafByRO/jBGQR3ByyqbQck3rTUI6I9qHqqXu90h
         SG4uYh+YC3Oe8Xj6b2gEbCk8ck6qEK4VwHFXH4Qym12N5u9VHANYnIYBSj57uf+NB3To
         BdjFHjkkq6QDlrpM0rxvxQBBT8njbKPcItqVDgyUta3w7hVIG7Gpxwq9iYBRo4arpOJW
         DzbkqWd35P5g5SK/5k0Qq9ZJ1Aw4QoyO+Itw9Pb3fTs7iH21jbyaeHXxGRSmzSCGd8M7
         nLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920824; x=1708525624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQBIeZZDh236u3h4FmDgo/L28GDT+6iN3Wg2zRu3tgU=;
        b=P8LwRS/L5mBTWXAvnegx4/cwOdV8NK4YchBRrVyEGhtPtOtd39Wk4fQS8u25TXAw+L
         43IAOhAKeteydE5l1HE6SMpGa2QYWDu+5/b8XM/m2KChadw15Ww3IFPfujr/fEmtnhG1
         gSOaQIb6Q5vIW5xNKzXMAQZBIOUVus085DUr1lAcpBFAc4/T9ApmhlSB3ciM6f8UZV0L
         6CtE8xPYTKkoDkGpb3ybPc6vvQ5tdNyH2gbyO6JFnJIgdDC1UYZZTHCogog3zi3me4fU
         udmDip1QdB+KXtkoeuLSPzpbqJBkYkei70ysQjDKcnoHW2naR5IOpl+wH+N8klyhzazZ
         gdrA==
X-Gm-Message-State: AOJu0Yyuc+/CXUah542uHkhq2ivdVpk9XQhRrpEpwyKMMtgJ7wEvP3gx
	bPinxrmtURJQvQDAevxup9NNxDuUQ97y5Cdj5nFXzejDMwOP8DTvFrweMR842t0UmtJV1k+eRbO
	wvwV6/DLCkkFLFMT7snnxwc+RbpU=
X-Google-Smtp-Source: AGHT+IFWDAC58MREvIg8DCi0971kRPw5lfedAju/lZBuZSvpWB4JyZQoCURuCxySggnHWEG9azVTWnD8O9aI04CuQDE=
X-Received: by 2002:a17:906:b291:b0:a3d:4819:b9a9 with SMTP id
 q17-20020a170906b29100b00a3d4819b9a9mr1425287ejz.52.1707920823898; Wed, 14
 Feb 2024 06:27:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com> <xmqq7cjemttr.fsf@gitster.g>
In-Reply-To: <xmqq7cjemttr.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 14 Feb 2024 15:26:51 +0100
Message-ID: <CAP8UFD1xHq7nWXe4pQ8qFR4mjCZnSou06irDgZ-cR0FtscbsFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] rev-list: allow missing tips with --missing
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > # Patch overview
> >
> > Patches 1/4 (revision: clarify a 'return NULL' in get_reference()),
> > 2/4 (oidset: refactor oidset_insert_from_set()) and
> > 3/4 (t6022: fix 'test' style and 'even though' typo) are very small
> > preparatory cleanups.
> >
> > Patch 4/4 (rev-list: allow missing tips with --missing=3D[print|allow*]=
)
> > allows git-rev-list(1) with `--missing=3D<arg>` when <arg> is not
> > 'error' to not fail if some tips it is passed are missing.
>
> Thanks.  There is an existing test that makes a bad assumption and
> fails with these patches.  We may need something like this patch as
> a preliminary fix before these four patches.

Thanks, I have added your patch to the V3 I just sent.
