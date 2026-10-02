Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75354C33EF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950589; cv=pass; b=FWiHLhshulGcQ+yaOF0ctNTba1d6rB28dzbd8PnPfhpPV9zRYIoP0quLT4RyDMjrx50WbgyARxnvzHtcH5B7Dkl0ktqHrBOdE8AGxGjYctCNoj/Lf/b9Z24brE7+rzgIMZz2kmqZuSY/xuxwAONCLoaLC0u/bWfPVdDT8lKbOqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950589; c=relaxed/simple;
	bh=WbNUEytU6QJ4p9Skrh/51EWfoycjGHg9oa+OGuR8EnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6DGv/nML/WP6Gn4esRVJmmc8htsl2u/lUb5KP71XZC8yu3muziPWZLtbJCE7YulRk8LtDp2uCQUZQD80A9ln5cKxfe+6WrzvM2yq9TkIWU0BkF2EBthuV2QiKY1JnI3CxP5SoLqHjNZTD3n2iIRhG12YtamQBETFTbIavv/+oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHGUSeDV; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHGUSeDV"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a76ac0bdafso495891fa.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 07:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950580; cv=none;
        d=google.com; s=arc-20260327;
        b=FTu3p4ug2C25ap/+XJr0QeMLopmrPKD8SY5Ev+zthcDNwcJzgFU3pgwcMmDTp1kyA8
         0c50RK1QVNreAr1UUzkVWUk/gZ0YD/q8zrZQaTAOQgem4ycAaJC5D//BZaF9GaPyZ7CO
         Ly6IPIqkUfPG//pizZa+k1wWellkRLu3hdDCm/76R3+cdH//axPqVfxcIQnr9Apl+QRs
         K3yvWKvrOVIJVD1QPbJTfMIXichUvEoKfkT51T054ZOlb0a+KXNxc9PvZHYouQ5joDiT
         gJikWiTNcyTXek8jcj9Lhr8u4+Nci7NO7NAZxIEiRZ6obCv4QU4UXjdoLIofcR8qoXXG
         Dngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MwrC/vN4R9VNA6QQ0pSeSR2rq/L2Cw1oYE9Kp8+8E8I=;
        fh=Bz0wDeKh2rY3tqYPx76nLY7cCdw9PrgxzoqJJ/vlYmM=;
        b=Jb8327H5cbQQXlNL760wBvEIhBZHUrr9rgFm9HcmQ75miBq8/3vlBpPFXK9x+jwpsb
         lT+1gC42QibaT/2eGJCdigQIkikWaMMQQJuWj3CiMbAn5wncaNBlxWcTUfgwsXrzthJd
         1mte/4TyWkCxhA7hJor6A9BLLQ7K5fxLl7YeH6ZwocAQRaWwiYCBOzn2XQ1C+orOdmnh
         IJHTAIJoRKHzDtmVFGhtfRZp8vDV6BOVF0m1R0D0U9hn7eZdSx6d9rQyJnzFUvRqZFCZ
         n+rDnnt7GrokyA9IDTzbJa6bwwOBB0LJrnxhSdQ8onbOO2b2YF91b4t+oat2OsSRfZcg
         gpLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950580; x=1791555380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MwrC/vN4R9VNA6QQ0pSeSR2rq/L2Cw1oYE9Kp8+8E8I=;
        b=LHGUSeDV1jwU2k6SuKlWjPgGThl7HC2YU81kQ5Tc+HeEZXyyRA0/aqn2S0Sb8CXRl1
         gyxq7Tf3zXOMmPGonNbrTUWNuVJaqLKuUyajegSboPIOsU14YvBuaHF3ylzwaSIgx2y9
         u5AGWyvLcSFrUkafUopNzBs526clSWtMB6w3F67/rF4a+DenWRIYyMuAv3zJTQlpFA11
         nHwyyzZSC3++IqekqN1t3J4JBsB+HZMm4VrqwdM9OMlECbv3R7tKg6lZFQIp5I2auRIA
         ajBHKCihbeB4lmLo+xJRdRdSELmOsGdlb1rzZf2Ppr0vTQxs8NxiayrauZ/KeGFQF4oq
         oRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950580; x=1791555380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MwrC/vN4R9VNA6QQ0pSeSR2rq/L2Cw1oYE9Kp8+8E8I=;
        b=RsDt00NRDVCdX0Rgw8iCWClBLWfpluPxfNfQh7ILTF234Ed9gW9MeRNyj9dImLL5n4
         GWkgtTirkqGHNNmmJoXSsw95aoDLSKtUA1sZW6dYd875PJ1w5zbnXR0IhMad74SAarSe
         CqlJAOTKPbUtuEd4RPQa6KRlljIgjA+SY4jqPtLWAhqjXn9iQqCW4x+1ihyUxuQYGHrF
         77K6kuGnXkoGjOSCKzXkvc0F0PDeYeg7aEiCPZDbzFnVI58kGX15WdiIFrhRwF2Ic1J2
         aGYuSZ9xcBhmH+SyCHvmkhRUVF8Gms7ygJmAe1CwVm40GLPaSXGXFXmIhmOSX5QOUURI
         KC0g==
X-Gm-Message-State: AFq9FYLWNNnIZktplDbRMrC7XhpiMrpcTCoxIQashiRuyhCg0SsM5gTh
	uYQlYgM3c1gXgKgRrH+vdtHOfa2adsMej3BwYKMFZslsGE0zeGNbHU9uOdMAWY0MeHrM13QrIxH
	oXnWdbgI5tITej+u7u0n3HNUtGzRaAEY=
X-Gm-Gg: AYBFou2VlcD9AQWUHEFAUrB7yLL0qRsMY8VDZHknwObmu0fP2ZT1Rd8VUA2qZWt187U
	+/G+34IX6Lx0RjaGW9o40Ik7bU1XpV18jVuC52rLkbx0iKaINYHzkR0wnkyrc48h+mRg3pTf5LT
	WFpzNNZjw48MGvpKbe0Dy5rw3SutcqPirdLv+Y8RZtf/6g2eTy96045tdYvT3P0MMVdlt9cFdm2
	+9Uk8r3hhAQGbubBaMwaIXvslGZPxoa3wBZHTP0uDZyCLDlE8EbuIIQ5FFVWb9GawYdG2ZrDqwP
	i6OAVwQGo4vj4hFcMkRvXTf8BRmwF1aJB4Se5oQav41O2ZWrb6JdGSjKbAOXJgaPHQwKj4IC5cg
	5wgBBVaICVez2+MSCkA6We2w450hdSKjGCq2enkynTriTml5tpGRLVvIbkyDTmXW3Gr770OXKVe
	yfE4UqfTXp
X-Received: by 2002:a2e:bd82:0:b0:3a9:71c4:1137 with SMTP id
 38308e7fff4ca-3a971c414f2mr1296891fa.11.1790950580223; Fri, 02 Oct 2026
 07:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <20260923133651.74120-1-maciej.ciemborowicz@gmail.com> <ar-N7SA63fN_xx9P@pks.im>
In-Reply-To: <ar-N7SA63fN_xx9P@pks.im>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Fri, 2 Oct 2026 16:16:08 +0200
X-Gm-Features: AclHuK9I2kYXu_FBHpL3AjQNIN9IyoQcuPVo9gbo0f_NOgI1QJ9VhQIzFMFFIN0
Message-ID: <CACQ=SRGSEsbNz3v3obd3JUOs2MrROnvuHkx1Dm51seCcv+12Cw@mail.gmail.com>
Subject: Re: [PATCH v2] refs: run copy and rename through transactions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:56=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Sorry, but what does this last sentence mean? What is the consequence
> of it?

The intent was to address Junio's comment about making copy/rename a
property of the whole ref_transaction. In v2 the extra state is
attached to the destination ref_update instead.

> why can't we make this whole mechanism completely agnostic of the
> backend and implement this via pure transactions?

The part I was trying to preserve is the existing reflog semantics. A
normal ref transaction can express the logical ref updates. In example
deleting the old ref and creating/updating the destination. But branch
rename/copy also moves or copies the existing reflog history. For the
files backend that currently involves filesystem-level reflog
rename/copy and D/F handling, while reftable represents the same
operation differently. So my assumption was that the logical ref
updates could go through the generic transaction API, while the
reflog-history operation would remain backend-specific.

> Is this new behaviour? Is this retaining old behaviour?

The source/destination revalidation is new validation required by
introducing the preparing hook before the backend locks are taken. The
hook can itself change one of the refs. Without revalidation, the hook
payload could describe one state while the rename/copy later operates
on another state. The intention is therefore to reject an operation
when the state observed by the preparing hook is no longer the state
being committed.

> How does all of this impact performance?

Enabling reference-transaction for rename/copy naturally adds the cost
of invoking the hook when one is installed. I measured `git branch -m`
and `git branch -c`. Each result is the median of five blocks of 40
commands per version:

                         Hook    Before     After     Change
files     branch -m       no      5.089 ms   5.234 ms   +3.8%
files     branch -m       yes    12.608 ms  11.134 ms  -10.8%
files     branch -c       no      4.753 ms   4.916 ms   +3.4%
files     branch -c       yes     5.509 ms  12.732 ms +137.7%
reftable  branch -m       no      6.478 ms   6.998 ms   +7.8%
reftable  branch -m       yes     5.918 ms  13.229 ms +114.6%
reftable  branch -c       no      5.620 ms   6.368 ms  +10.9%
reftable  branch -c       yes     6.261 ms  12.354 ms  +97.0%

> Sorry, but I'm going to stop reading here. This is not in a state that
> is reviewable and has way too much stuff that is obviously generated by
> an AI without much thought being put into it by the author. I don't want
> to invest my time into a topic where the author has obviously not spent
> their time thinking about it, either.

I'm really sorry to hear that. Yes, the patches I prepared were
AI-assisted, but I do feel that I understand what I am doing. I would
appreciate some understanding, though, as I do not work with C on a
daily basis. The bug report and my attempt to fix it came from the
fact that I am working on a Ruby gem for per-branch and per-worktree
containerization. That is why I had to write git-hooks-ext, which is
how I ended up running into this bug in the first place.

I am not insisting that my patch should be merged. I simply thought
that submitting a patch might help get the bug fixed faster, and
getting the bug fixed is what I care about most. Karthik Nayak offered
to help fix it, so perhaps it would be better for someone who works
with C on a daily basis to take it over.

I can, of course, also prepare a v3, split it into more commits, and
explain my reasoning more clearly. But I cannot guarantee that it will
meet your standards, simply because I am not yet familiar with them.
