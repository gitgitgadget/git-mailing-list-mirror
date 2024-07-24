Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3214E1C8
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807506; cv=none; b=joLKUXR8qGxRp/uM7NaPLsTR2cOJWreij51UVB7U9O8I2VhowEMxNctmlKfMMS2HYlTFr/ncdOyduLgaVOAb7czuHjip7jeON30ajZmMLUHew9xnLs4ESGtBXGKL3eaWdE56B3ZZNHP5/q9GCtLx9rhseTsYkYQc1gPeFJuc2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807506; c=relaxed/simple;
	bh=O4S7BInl+ByBOmTPTZOZrBqZRGAdmAulgIPF6Uecvyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiSYRnanqdPiK3LxVLrCa+JSL5uFrtEuLBUEz2ypavHMerkvF8y+8MsOEZRMo/oMSJCgirAamfUA7fxMW7/8A8Vgj3geX75/c+XFPCAAQfKcizQf+5lvGHly8rfun5pQVcQsd3v4ydf8k0ZfwYy2hC6zIMnAi4Ef6zpcfpnsA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAYpGusM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAYpGusM"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77b60cafecso169262766b.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721807503; x=1722412303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCIgFG6ZmU+ZIAf4K3LeyaqdIBlyXIRe4lDQo25LSRI=;
        b=TAYpGusM+8JZvnPUuNazevuS0TzHcbbQTHHsB7U3cddeF+YJo5D9D8xOpDkQV492J/
         etviEsJcbelxpGSqLZ6L3opKUH8gDJJZPnQaIWuO06c8lktGrNsgw7K86kmgFrArya86
         KF9gercPhxSLb2MiMtSIF07PF9lJm8rbQKJ1u2H+/puqi5IjNNA6tBJ6xnJ1tm+/JgJ8
         HNEqVEgq9l2FDeNRcAjuZGVkT8JticDI3fsgje+vMO31tAd9KxFb1I3O2B2mGG1bSEUh
         XYmG4AtvfNbCb5I8xBKT3YLC6h5KwAN5HijYuYBlGtZdv11i9L4UKtIgkE3HOjN/STyF
         KKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807503; x=1722412303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCIgFG6ZmU+ZIAf4K3LeyaqdIBlyXIRe4lDQo25LSRI=;
        b=xPYoTJBY3Em6ceQEwzI+bKzzYxu4/NUy2rJUjfpg9gMPGNekae1U5huHC0Jif+hQY2
         4I68M4ue+K/B7ZkKYFB/KmIXjs+KcS8WQp+5GWHqhU40ktdfNVZizj0indVDSRyhIh1L
         oJ664/BhFrgguglXL/T2+x5vFz06sTGdTZdWxPfCggOPu2uKpn0wGfXxS8ftMKHExub3
         SVKgvPPQpZ8COUgEXAGUbbFcoSTLdmp0rdO8TDv0d2XmXfiKwXQSrF2bem5MFqc3Qck9
         0rj+1HR3wF0b/K5AJCZuihSkycVnUkmfgzFRguBeNwdGAZ4ilJ9IpJzhJ8qs08GLBAFT
         JNpA==
X-Forwarded-Encrypted: i=1; AJvYcCVb3bKjrVUJQOGW00RRtWA7suAj/TLUyIxAEG/QXjq0lFS+SBTs0Rr32XLX2cr8Z4/n4TW2jzO0VS4ZGIv8AfeeKSeN
X-Gm-Message-State: AOJu0YzUWLZxSdc0eaP1Ly6D88g19PmD0nZOIPqzH/ZsM7GX+yGgksnD
	Vsm+QZ6DV4XhKVwOHmtIIuDF4xvLwuVzEG9o8MnIWvdZvvQ7symLr/FJh+DtJ6ikYaT+A9gMGOP
	2FU2xbpRX9a1g0qsR7hPqgWJpRonTuw==
X-Google-Smtp-Source: AGHT+IEG+6GnwY+DfQheOB6M/2ExfGaAhUvA9u6hGw1ucncqOVdiFU/cDB/Df0v7lVAQ1MB4T/CYBWutcuNY6pdpzr0=
X-Received: by 2002:a17:907:d15:b0:a7a:ba59:3166 with SMTP id
 a640c23a62f3a-a7aba594a09mr25741066b.56.1721807502563; Wed, 24 Jul 2024
 00:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com> <xmqq5xsw2fyd.fsf@gitster.g>
 <CA+J6zkRKzQGvwhiQdgRqcctDP76y5_v582rRTzEXJyx7=+WRqw@mail.gmail.com> <CAP8UFD12Cqorr7oPS+JfOTYY6LaNUgPEJaEscf-jwLUOur+xqA@mail.gmail.com>
In-Reply-To: <CAP8UFD12Cqorr7oPS+JfOTYY6LaNUgPEJaEscf-jwLUOur+xqA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 24 Jul 2024 13:21:32 +0530
Message-ID: <CA+J6zkT7px4WPE7F=GnBv9X_piTBOPedbrTekYA1SFriZbbfLQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit
 testing framework
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jul 2024 at 12:48, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jul 24, 2024 at 7:12=E2=80=AFAM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
> >
> > On Tue, 23 Jul 2024 at 22:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> > > > - Rename tests according to unit-tests' conventions
> > > > - remove 'pq_test_main()' from reftable/reftable-test.h
> > > >
> > > > CI/PR for v5: https://github.com/gitgitgadget/git/pull/1745
> > >
> > > By the way, I still haven't got any answer to a question I asked
> > > long ago on this series, wrt possibly unifying this pq and another
> > > pq we already use elsewhere in our codebase.  If we are butchering
> > > what we borrowed from elsewhere and store in reftable/. directory
> > > and taking responsibility of maintaining it ourselves, we probably
> > > should consider larger refactoring and cleaning up, and part of it
> > > we may end up discarding this pq implementation, making the unit
> > > testing on it a wasted effort.
>
> I agree it might have been better to start by replacing the pq
> implementation in reftable/ with our own first, as there would be no
> need for this patch series, but Chandra's GSoC is about replacing the
> unit test framework in reftable/ with our own which is still valuable.
> And I think that at this point it is just simpler to not get
> distracted by replacing the pq implementation now. It's also not like
> changing the unit test framework would make replacing the pq
> implementation harder.
>
> > I did talk about this with Patrick and Christian on a private slack cha=
nnel
> > a few weeks ago and here is how that conversation went:
> >
> > Me: Hey, I wanted to talk about the message from Junio the other day.
> > It is true that through this project, we are modifying the reftable dir=
ectory
> > to a point that it is no longer easily usable by someone from outside. =
If
> > that is the direction we want to take, wouldn't it make more sense to g=
et
> > rid of reftable/pq.{c, h} altogether and use Git's prio-queue instead?
> >
> > Christian: Yeah, I think the direction the Git project wants to take is=
 to
> > integrate the reftable code more and more with the Git code. On the oth=
er
> > hand, there are libification projects which are trying to split parts o=
f the
> > Git code into libraries usable by other projects. But I don't think eac=
h of
> > these libraries should have their own test framework, their own prio-qu=
eue
> > implementation, their own string implementation, etc. So, even if I am =
not
> > sure about the end result, I think it would be ok to modify the reftabl=
e code
> > so that it uses the Git's prio queue and maybe other Git data structure=
s.
> > But I'd like Patrick to confirm, and the list to agree to this. So I'd
> > rather wait
> > until Patrick is back from his vacation before doing things like replac=
ing
> > reftable/pq.{c, h} with Git's prio-queue.
>
> Yeah, if it had been discussed and agreed on earlier, I think
> replacing the pq implementation would have made sense. Now I think
> it's a bit late at this stage in Chandra's GSoC to go in this
> direction though. I think it's better if he can focus on finishing to
> replace the unit test framework.

I'm actually more or less done with porting most of the reftable
tests to the unit test framework and it shouldn't be long before
patches for rest of the tests see the mailing list, so I can definitely
make time for other endeavors like these.

The only thing that I think is holding us back from making a change
like what Junio suggests is 'how far are we willing to butcher our copy
of reftable/?' From what Patrick said earlier, I think the answer to that i=
s
'it is fine to modify reftable/ tests because they don't need to be uniform
across all implementations of reftable, but modifying other parts to be
more dependent on Git's internals is a no-go.'
