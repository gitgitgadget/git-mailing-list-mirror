Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F61C9850
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681594; cv=none; b=XKzEwmr0NxP9WSTx+lwu9KX95WwhUmIPkcZbyA6dD85WR7NopFnSpY5p1EgLp8fIxoR5nRzt/M68xiZd+mzn48sXeNOUkSEVV0V9dGmcHth/APMBOIofWkgaZ1TaEVx6BoMZM/wZJcl26b+1b9tBVMqub4kIYIVDmIdojXCOSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681594; c=relaxed/simple;
	bh=7N0cF57WnLiUOsNd/G9ajoPpTMuPGW0l59KrbbcizAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxDQ637+yJ78vD9jHbIyQoYHgq/CAJLWnnCNzgJYLKC3ygar6bX3fWID3j7Le40elTDwAyz7M99zDMJOX/kPaMaZxK1s+EdHn8vCh7giELI5e4wYQSg28Ct6Wp4i4MAx4TlH9slOoztxBIsOsKeg7GC8EHj4QtYNKT5/5h7fdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li3bus+N; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li3bus+N"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so4995478f8f.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726681589; x=1727286389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mcnaCdojY3brBW5RbLTGJLJ6mYRxXpzVO7DkXMUhh4=;
        b=li3bus+NR29iXCE/e+eiFZPSmkhOUlq8EYzHLxL7bLUckD75Zy06rTKdWc7Pvd/wGr
         S1Sx/r5qUfQm/4R6OFLIybqFwBLeqDeCrlU5X9DWbrD+nkeAEgVgzuYIrf5mpWtvnm9h
         M9FzFYRkYAGwmUyKDgjFxQenunGx8KBToCgZw9BXQnYQLCyHXRlClw03akV5xsAiP3iB
         /5Id+yHrKq0sIK1mhWJUSUFfX56Ijxf1A/aVoNjgdjagEC3foJ2ytaObQhJqT9aQFMn3
         QjR3oqFzLUkwwHuj94hI+LUq+uj9xQnBBFSszasyvOqTHh1h74fetgBFeZFCAd77wf3W
         OjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726681589; x=1727286389;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mcnaCdojY3brBW5RbLTGJLJ6mYRxXpzVO7DkXMUhh4=;
        b=JNo7hdk2DexTXF/MXBXraynPpr8hI0fup3UET4BLvSUsnN8otd7hMKNJCtMDjmPvk/
         dVNXT8JX5UbbnnOlSDPmbUuJOqCHhVBLSj9yttuFvxVzhe9iAZVgk4hzp816JOOCQaxW
         4At+Kdu9unh1pBez1kU8vxNha1+/Ddjq94foUTMKP+VwHrOsb0NcSglfTTf+kEtgwLLG
         Zr0drdIyE+Sqgn//Z1zsdTzASK2A9OKZzLHpiLxfxwDsWUZMPOzOWyouv2x1aSDeEvIk
         wM1RDiz5dcqBAnSMkJbd7cE2pJnarsOWxBoy0CpcLOxYsat45XKt0/hk49BBI0j5YxWi
         s7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVg+4JenBvLqpd7+IQfpYrCifeAV7SI8lz1OL46cJDK6sqJ/fa4oO0kx2FZOHazM2D85aY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SdBBuLLIzGgXLzwTfJPXF+Ecdu2eSyG7xj/3lOBI4Sm6+wZh
	FJwiSC09sb9Rk1D/fGpFj3wQjB5Ifj59o2no/kqwRLwEZBNixGB4
X-Google-Smtp-Source: AGHT+IEH6soC5D+4XLElnomdrfS9hQldI+PUinbZXGuy5GwVnRjLjcI/y+dCF4Hu5YIB3Zwpy3WnuQ==
X-Received: by 2002:a05:6000:1b08:b0:36b:b297:1419 with SMTP id ffacd0b85a97d-378c2cfc3bbmr10448800f8f.20.1726681588244;
        Wed, 18 Sep 2024 10:46:28 -0700 (PDT)
Received: from gmail.com (67.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e70459328sm22938375e9.0.2024.09.18.10.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 10:46:27 -0700 (PDT)
Message-ID: <08b29649-eeeb-49e4-82ac-2a3473dd2ad5@gmail.com>
Date: Wed, 18 Sep 2024 19:46:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: edit the hunk again
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com>
 <be0149e3-148b-4e25-9e44-f3f9a3303fcd@gmail.com>
 <d20d030b-7d3e-49c6-a988-ab7fe480dd47@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <d20d030b-7d3e-49c6-a988-ab7fe480dd47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 18, 2024 at 11:06:34AM +0100, phillip.wood123@gmail.com wrote:
> Hi Rubén
> 
> On 16/09/2024 23:09, Rubén Justo wrote:
> > On Mon, Sep 16, 2024 at 02:33:54PM +0100, Phillip Wood wrote:
> > 
> > I can imagine that we could give the flawed and annotated patch back to
> > the user, if they want to fix it and try again.
> 
> Exactly

So we agree on where we're going ...

> 
> > At any rate, I'm thinking about small fixes and/or avoiding to use a
> > backup (":w! /tmp/patch" + ":r /tmp/patch") if I have doubts about
> > making a mistake after spending some time thinking about a hunk, so as
> > not to lose some work.
> 
> The problem is there is no good solution at the moment.

although not in the length of the stride :)

Maybe in the future we can provide better error descriptions, or even
add annotations to the faulty patch explaining the faults.

But we're not there yet, and honestly, it's not my intention to work
on that.

> Either we keep the broken
> patch and say "this is broken, please figure out what's wrong with it and
> fix it"

Yes, we should keep the users's work if they say "yes" to:

    Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]?

> or throw away
> the user's work if the edited patch does not apply.

Only if the user says "no" (as we say in the message).

After that "no", the user has another opportunity to decide about the
hunk:

    Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]? no

    (n/m) Stage this hunk [y,n,q,a,d,e,p,?]

And then, "edit" will allow them to start over and edit the original
hunk, again.

> As I explained previously fixing a broken patch is not necessarily
> straight forward especially for new users.

Very true.  But I don't think that should be a reason to stop the user
from trying.

> A few times when editing patches
> that are going to be applied in reverse (from "git checkout HEAD -- <path>")
> I've found it impossible to figure out why a particular edit was being
> rejected. In that case starting again with the original patch is my only
> hope.

My experience is usually small last-minute adjustments that aren't
worth canceling the interactive session for, and I don't want to have
to remember to make them later.

A small error in a large hunk has been frustrating several times
because I have to go back and review the whole thing.

> If you want to be able to re-edit a broken hunk perhaps we should add
> an option for that when we ask the user if they want to try again.

As we commented in a previous message, this is what we are regaining
with this patch.  The option was introduced in ac083c47ea
(git-add--interactive: manual hunk editing mode, 2008-07-03) and lost
in 2b8ea7f3c7 (add -p: calculate offset delta for edited patches,
2018-03-05).

Thanks.
