Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021F1A01C9
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350336; cv=none; b=qEEL2p/hjXSNfcWrHywwxaKVvgiBvIudaMffkAs9c2H87Xrp8pni5NxA/IU8lFEemq5v+eQPW1FU4ZsY0/jMnsvw+qM10r/6lBTAa4PwyAMTz4bNlEgGMpnWRSnQFV35fAE8Za7A6+ZyWleNjZLLuZgZAfvwmt1QcFceeMm4Vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350336; c=relaxed/simple;
	bh=sXga+c3GdxreaTZQyjhERvjlAXbtI9IMV3+5nXjUpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckK4MwLwdc+9JyHtE7yjzLtc7DloSRS+rzoBP7KGUCvsnscFbWz20So8CuP6tlRZtS2A24kFTJqVYVH86HKFYVWRKEtCJD+LWFnANMA8l6G+3ZnfxK1Z+0ZWaphogM43sHX/PNum5j9Gn1EnCfK/++NqbxXL6l8+LxWKIQEQe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXIJGqu5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXIJGqu5"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4500321c357so3241321cf.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722350333; x=1722955133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFBhfEWBWwA5xDW26MP29yU78DLxR3BdztxMnB0RDng=;
        b=nXIJGqu5bRqtSlKKSWa4boIntn6HyTY7juekOU+N5J+8p2yosmKIKSaLvCeqeOX/b3
         f+x0A1ELPz1tAigpueew18ytNnf6zXIkFfddhZrh/KQdVf9h4vwyJ4uh2G6tn6rwJre8
         Ky16daedofHFglX4kUg3nLpOaK/aMZsOP4lJNREs/1KmJQ28g4kHvq/MGYx7dyUE9oCN
         pZDIKdpSYtoxRr89n56Dtxzab8W25J7PTcsC/CYRgEQOP+m7t9x6Mz60YfSDb04AXgB4
         gF98NYuOnVTjYo9G5kAATgpxHuhvQPEHxFnoaEJewZmjQGZ2R8nAnSA3JtWCeCMpBzYV
         xsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722350333; x=1722955133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFBhfEWBWwA5xDW26MP29yU78DLxR3BdztxMnB0RDng=;
        b=PH1yyY2I+yDwZaJoeCQDlFE9+2k0abLEzDcOZD+sY5ltBvpF2PsZrPT5s+hsex/4Hl
         mLaKvnzw6lUnqE0zZIlZeUz0Mm+PnZCkDZieVgM22F/VxmdBR4xMrDoRhcxP9GUCqHRs
         ebSRtpEYJcEmVIV+Yn8Pga7gPc+w+AmnYbGoQUeFA0eYdW7PFrr/3hdCsOuKw91vblZd
         GSfR4ISTK/dlt35S2Mnr5LhaMJXPNSrfZKK3zJUA+khjDBx/WYnXoJaJV9g0/I/MlQMl
         GGukbvVvC10JhLoosswhXMpOCXBQpn46gAGBKClgJbbkQl9aO1xWf6u2g6o8rDfqfRnE
         xFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRpLMtFLf1whEXIRInbIHTw6hLit+LPuwWG5AFkcmd/SY4BIYlwfcGGD6332S2EBokrYUDyQWUYYaQxXz97TmbMHr
X-Gm-Message-State: AOJu0YwNw8ZF4FDD10/BiQG1dmSCz5w4ctx9lc+ERfCGj6lcxkwv/lG/
	HJV/JBKICQiGYEqu35L06BkJwnStepYZCe5/6Z9PbafGhuTcfyLv
X-Google-Smtp-Source: AGHT+IGlNNMaTsh7tvg3whQey118cFBoCAMuWdJbnjRm18CprZW7AjZjZdtfRzZ4MPUkMvK/cDzyYA==
X-Received: by 2002:a05:622a:1885:b0:447:e43a:f8f0 with SMTP id d75a77b69052e-44fe5a6e21fmr134288011cf.2.1722350333435;
        Tue, 30 Jul 2024 07:38:53 -0700 (PDT)
Received: from [10.37.129.2] (syn-074-072-188-022.res.spectrum.com. [74.72.188.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8123b5bsm50664501cf.11.2024.07.30.07.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 07:38:52 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Jeff King <peff@peff.net>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
Date: Tue, 30 Jul 2024 10:38:52 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <45124B2F-BDE0-404A-BA85-54361F5877DF@gmail.com>
In-Reply-To: <20240611085058.GJ3248245@coredump.intra.peff.net>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
 <20240611085058.GJ3248245@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey Peff,

On 11 Jun 2024, at 4:50, Jeff King wrote:

> On Thu, Jun 06, 2024 at 05:26:37PM +0000, John Cai via GitGitGadget wro=
te:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> refs_resolve_ref_unsafe retrieves the referent, the unresolved value o=
f
>> a reference. Add a parameter to allow refs_resolve_ref_unsafe to pass =
up
>> the value of referent to the caller so it can save this value in ref
>> iterators for more efficient access.
>
> This commit message left me with a lot of questions.
>
> For one, it wasn't immediately obvious to me what a "referent" is. ;) I=

> think an example could help. If I understand, you mean that if you have=

> a situation like:
>
>   - refs/heads/one is a symref pointing to refs/heads/two
>   - refs/heads/two is a regular ref
>
> and we resolve "one", then "two" is the referent? And the caller might
> want to know that?
>
> But I think we already pass that out as the return value from
> refs_resolve_ref_unsafe(). That is how something like "rev-parse
> --symbolic-full-name" works now.

Yes, exactly. I think you're right that it'd be preferable to just use th=
e
output of refs_resolve_ref_unsafe() to get the value of the referent.
>
> But there are some subtleties. In a chain of symbolic refs (say, "two"
> is a symbolic ref to "three"), we return only the final name ("three").=

> And you might want to know about "two".
>
> You can pass RESOLVE_REF_NO_RECURSE to inhibit this, and get back just
> "two". You can see that now with "git symbolic-ref --no-recurse". The
> downside is that we never look at the referent at all, so you get only
> the symref value (and no information about the actual oid, or if the
> referent even exists). You would still get an oid for any non-symrefs
> you examine.
>
> So reading between the lines, you have a caller in mind which wants to
> know the immediate referent in addition to the final recursive oid?

The goal is to keep track of the value that %(symref) would need in the
iterator so that a separate call doesn't need to be made.

>
> Looking at the rest of your series, I guess that caller is the one in
> loose_fill_ref_dir_regular_file(), so that it can get passed to the
> for-each-ref callback. But why is it right thing for it to record and
> pass along the immediate referent there, and not the final one? For tha=
t
> matter, would a caller ever want to see the whole chain of
> one/two/three?

Right, the final referent is the right one to pass down.

>
>> @@ -1761,6 +1761,7 @@ int refs_read_symbolic_ref(struct ref_store *ref=
_store, const char *refname,
>>
>>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>>  				    const char *refname,
>> +				    const char *referent,
>>  				    int resolve_flags,
>>  				    struct object_id *oid,
>>  				    int *flags)
>
> Unless I am misunderstanding the purpose of your patch completely, this=

> "referent" is meant to be an out-parameter, right? In which case,
> shouldn't it be "const char **referent"?
>
> As the code is now:
>
>> @@ -1822,6 +1823,9 @@ const char *refs_resolve_ref_unsafe(struct ref_s=
tore *refs,
>>  		}
>>
>>  		*flags |=3D read_flags;
>> +		if (referent && (read_flags & REF_ISSYMREF) &&
>> +		    sb_refname.len > 0)
>> +			referent =3D sb_refname.buf;
>>
>>  		if (!(read_flags & REF_ISSYMREF)) {
>>  			if (*flags & REF_BAD_NAME) {
>
> ...we'd assign the local "referent" pointer to our refname buf, but
> the caller would never see that. Plus doing so would not help you
> anyway, since sb_refname will be used again as we recurse. So at best,
> you end up with the final name in the chain anyway. Or at worst,
> sb_refname gets reallocated and "referent" is left as a dangling
> pointer.

Going to include changes to remove the out-parameter which will simplify =
things
quite a bit.

>
> -Peff

thanks for the review!
John

