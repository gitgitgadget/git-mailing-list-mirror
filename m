Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7278238C1A
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627283; cv=pass; b=RfAmgKMxkVoS4a21wktqWIFjMGcO4GTMPj0CrCReSJhyqeJVAmCLqwHCwPmHbjAN74++MTnSuNycB+2a5h9ePhHp3Ie80tWLvGbqHmzW71j0LxYHFjh+oVdlDukOCKczSYfZKfXkUO8BuS89kZrnhFaI3xzT4FnIedSX0ZHC5WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627283; c=relaxed/simple;
	bh=fQw4tszLgtag1uYzUD7NnOaqXCZIdxg5UI1UCWsn76E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtD2+FZKbVzh/UbkIHaqqlY39z4CJLaIt6vO32FBHc8q4vEu9ulu6pFfLEjDvT/11yEaQ1fTt8C1/xhr9Vn76h9SpLZw3FZeyk2QXL2NZzyuYjCaYJ35dRox5LNsHiLSQ3F9KMIGMnPCYBkvfAWYzJw45Xi5JYWTOvI5mmHIPRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWxegFrW; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWxegFrW"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12713e56abdso704668c88.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 00:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770627283; cv=none;
        d=google.com; s=arc-20240605;
        b=TRzfda38E+E/a2WWJcEsm/MkBuikO8f+gxvxykSfgFZ6dMK/0da12R2iv/ciS7a9xu
         UJmT1NZ6EEuOQla8H4l/InKcMzAn08Ctf+x92e43TgEsMBPMnH/pqBpTZbgYZDeCsbi3
         UCGmUEc5yi+u7VtLeNesLvGh8QEy7x4qc1409UWUhYZVfKX+8SP39SJn0i28DTTH2Y9W
         ByBJ+5zM4f+rtxhYTYsCWvPK1s0FdfS3bZnBzJ2OYPIK/d/ZMUtC31rI7vXerUg3SAs3
         myi7M8fAfYLfqlkPyny1ATzHnBXEWVwR9ocX8zHRG8QO6NQ6YgaYQ2I22RK6KT5OWtfP
         W5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sAjy+xK+0nW25dsWuRmybU0NfLM6/Atf3kTT6piT/Nw=;
        fh=Gqer47B7wVpRcxG24DI2tH3SWYFh2covFErHXp173OY=;
        b=RvyRo+LeqOJd35cd8uJLKAlPDFHPMsRBBTJJai97vz4pySVX45gAr39H/pCiZMEuDm
         sG+y9DExMSPFuHD+d5rEE+N2ZG+gK8gGRPMxJojyZ1w9B608goGRMkJyf2qtnsHsvhpX
         T+rVQUht9zHjBC08W/Lir3UTO0zfVUCFdVyljtWzXx7urwsBqv67zO35I5WTzNi9Vilh
         WJiP0rlIIy49woYY7cCzn1qD/AmtdqautDLo0zu7qoUv0kHWCU/CDLep13dC8jUOx/B2
         86YLULL0H6dxsv0ESwjSqroOFvoLKj7BiloEtCGN+4MXKYXEZMzqhRxFMIM1V1kf0gYy
         AJcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770627283; x=1771232083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAjy+xK+0nW25dsWuRmybU0NfLM6/Atf3kTT6piT/Nw=;
        b=TWxegFrWxaTR1I9xNQQBmsrzOAXeqJmNA63i/v79Ggui22vm/dVKrZ7OuIn+rEllW9
         ps1jACC7AKr9bC39GyMESht6BcLk/Wshw2npCEi6xFk9SLd6BhLcfh8oyN5J5Rtauhwd
         9xuv5RqJiOKXW2lFH6aO0KVEb+OTlPOl514+OfJxRxCbhs6mmilwmEhh3MItJloUTSFS
         k4HxoOCZ2z/z1vw4Sv6CanO+F/uoT5uSgNWKBD0Eq0bHctk+A6TYIGMhl38ASAggXdGz
         xVRla6Y8g1DYASSbdq1bWq622hSH+V2hufwSMpCjI09nx20AoWfmq6JcfxmdQL2GdyVb
         30rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770627283; x=1771232083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAjy+xK+0nW25dsWuRmybU0NfLM6/Atf3kTT6piT/Nw=;
        b=vTWT4GeZW6oHDmx6nRJb/+b54Bm5nGrx/IHIhjQEsnry+165shtOHrOKTExG193kSp
         VMw0NDOkSexng7h3AyyeUyIXn1Q762c+uHRaxZQThldwNpdfqAkfgp2nu/Dem5f5MB1P
         RZ6/BkxRtAFiHgUN7F80pC5o5YUussqWcpknSNEZbylUR2OsxadEJIQHZqQoaG7pr+HV
         NiqcpPWSFtex1KnA0WU63aBvOb1ulw3GCYHMxqejHYG6U/JpZgfEb/SinxqZeorJcX/j
         2SHezkIpSRZMPj3tgE50KhyMaNsNZuGfUgdLcGebG+l8DWCeCC6ztk02tcI4aFBKCyvX
         dXpA==
X-Forwarded-Encrypted: i=1; AJvYcCVQLneCY/fbvllK1pemeomcpgpAaW9TdvCVOy/kYrSqi9ppjVHLkSsAYsCPSBaGjRoTZ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRclcE2RH4lRuj90c9NzqKiQ7W1uMlB1SziZSbneMBLBsS3p/0
	XpS98lwV43LxJAa6oxFUEE4sZXNca9R2Qo4/UwbTeDlYKxpBpr3liGv7Yye+G+MJecXW0ekX9Fj
	DVvh0fEv207wPdCl/jMaMzjnZO3LhIkY=
X-Gm-Gg: AZuq6aLWrSz7Bc4N2fDVwY4Kq3Z7qPgkKSsh5m/kVIx1TacRU5SGQyIf7t5YGp03JeZ
	18x4Yw7cx0sGualLkIUuto1uCtrTth9uPC1R8Y3r59fkWEoDwZTN/5VX2aksSxzMKclzXYppeEl
	aLHS835LwcKtHW2yaiS1LkSH39Md2kVIcuf2BTBNDProAFwyc3Jlkt0cT9Gjc/dkkDNZ5nLBQaU
	gXKG2c9DYOJ34U16mNcZLvZAIn/MrqNqnH8ESu+NiUHrLpcFs6P3udY9271B2F1tmGaGb9VHxE=
X-Received: by 2002:a05:7022:698c:b0:11e:3e9:3e92 with SMTP id
 a92af1059eb24-126fc1e223fmr5795208c88.23.1770627282659; Mon, 09 Feb 2026
 00:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770127568.git.belkid98@gmail.com> <7e3082125df08d3e5fb2195d73698c4c28c6645e.1770127568.git.belkid98@gmail.com>
 <xmqq7bspcq3c.fsf@gitster.g> <88570b6c-2ff3-416f-b63f-2fb7c80c5af8@gmail.com>
In-Reply-To: <88570b6c-2ff3-416f-b63f-2fb7c80c5af8@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 9 Feb 2026 09:54:43 +0100
X-Gm-Features: AZwV_QhAMY6-ZZq4XC8Xyad6Qf1ugjqr38qclcwOCv1gWN_opK7jTczDQeZzgcI
Message-ID: <CAD=f0L9ZeFGo=fD0oOS4rjprBjJTGZiGL8EodsjMj9DFk0hO2w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 12:14, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
>
>
> On 07/02/2026 01:14, Junio C Hamano wrote:
> > Olamide Caleb Bello <belkid98@gmail.com> writes:
> >
> >> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> >> Mentored-by: Christian Couder <christian.couder@gmail.com>
> >> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >> Helped-by: Junio C Hamano <gitster@pobox.com>
> >> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> >> ---
> >>   attr.c        |  7 ++++---
> >>   environment.c | 12 +++++++++---
> >>   environment.h | 11 ++++++++++-
> >>   repository.c  | 12 ++++++++++++
> >>   repository.h  |  7 +++++++
> >>   5 files changed, 42 insertions(+), 7 deletions(-)
> >
> > I bisected our recent CI failures that break fuzz smoke test down to
> > this change.
>
> The documentation for the LibFuzzer [1] notes
>
>      * The fuzzing engine will execute the fuzz target many times with
>        different inputs in the same process.
>
> and the first thing that the callback in oss-fuzz/fuzz-commit-graph.c
> does is
>
>         initialize_repository(the_repository);
>
> so I think the problem is that the assumption that a process will only
> initialize "the_repository" once is incompatible with the way LibFuzzer
> works. Maybe we should add
>
>         memset(the_repository, 0, sizeof(*the_repository));
>
> before the call in initialize_repository()?
>
> Thanks
>
> Phillip
>
> [1] https://llvm.org/docs/LibFuzzer.html
>
Thank you Phillip, I will try this.
I noticed something like this.
