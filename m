Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA032DF15C
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137844; cv=none; b=gph/rcM6akd7msbOpuf3T8pIiSDqlN/Hu6tWzYF8aUmjfXR74lZWbXPcq4JwbofJ9mrFo99HX1X+L4U9wLB/4FHoX62kgn5tJBQbjHJD+MDuQS5FEhsZ7EfrESr9YNXZbC1O9sU0f+QVfBnWUSnpArEF+YPgNMnxTTspUhhtMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137844; c=relaxed/simple;
	bh=71mIUVY88ncb9MT8GYDRi6R+k9oqBUGQAKX9wBSHiy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY7l41WXksiR41C8G9kbYvzwbWSOjbRvW0/yT6yE0Wywi7d2PsZq/3LdxwzB5rAi4UVNX/4u5vDCP4P5FPXSrqHpUFBrpgJbfuB7UckvqKM1EdBKPA6qGBVYEAT1YQ4a8DYAZhIs4vW0/f9Ef4mCq354Rpfo9Ou6Yeb7ZXlrPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-44ffed84cccso2126000b6e.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137842; x=1767742642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TZuILXbDjz6Dotr+dNxS8Xse6u597jivdeLaLI4088=;
        b=F1ouun5aOxgJqv9DTcGtCAnkVV1rLW4tkD94xb51jx3czt8rt+XFhlKWwQEZJV2D1H
         ppQU5MTs8Lz5th8zXc032CfVyX6mHSJTt/cUYX/wiD5ZkYGWTZR17ye0r2m4npzMnBhY
         4UKUxCBuotHWWwdEH71Uy0vHGMGJaOwYLZXAyPI4EBd6VPd4OhiZU6jwol9F7jv9Z0XU
         uXhBxDVfVbCdjB3rz5+aRoIoqtxHM99/GYeC5jIOcdMGn8rQd2NHmuFSayXoakTrdqZn
         J7kq9nl9RLxuSmpM4FcRvmTh1c+Sg+R65nII1fKodPCCnrqwEMkeY5O1FjOr2FNkvW+l
         DXWg==
X-Forwarded-Encrypted: i=1; AJvYcCVkpGq4npIOd/bNeN8NB9WnqyQExvT6Z18XGfQcHOE2KpR3jzZfpXgOySkno61BjY/GDcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKjWDpXYG0AvPbpTaf3MoXwYM+niieVme0gMmH/BFW2QvTVHR
	U055CMAXKWgWUX0jD7nMIqxO93muP1g0nrvf0jzDwBLWGGKNBH6ONaScBR/3TtGKNVKHQoIk0Mj
	VivT2LKyclMWnPIvF+/JyQgltCrX+J20=
X-Gm-Gg: AY/fxX4TF7WaA+0JTudN2994hHlUDzhSi99vkwA9Bz7Q5UcGlGmfWR01RP7z90sSN+m
	zMS1nGBH8q2c27pLB4+mJMb/2gE4FUu8qQFKSQka8FtLACwVyfPOyRkP7VADO3SeHMtF0jpe/EX
	YvOsq7VfLM3c7icEHO2cXT6lEDs3zzmf1YcfR/PKHeJ+PPQdAM8YRJpwcTddpUDxSQjEoHTLjjy
	cCuvpEvR2E3kCu38l0qh1soxfH9gBNpo6infdkgj7VcaCoFQVI3/3wrGSDWhlT4PlD54mYV
X-Google-Smtp-Source: AGHT+IG+mwKT7LV9U+hfpKMz/0dHTCGeg0URqfImcEQ7SrUe99WeXKo06FJnqrUucoE7E0C45k9tPvw96GTYmkol8bw=
X-Received: by 2002:a05:6808:3986:b0:44d:bdeb:f577 with SMTP id
 5614622812f47-457b221d35amr15055083b6e.31.1767137841817; Tue, 30 Dec 2025
 15:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
 <V2_dead_replay_code.17c@msgid.xyz> <CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com>
In-Reply-To: <CABPp-BEJV1XG62_hn_OiZ9q9S3jsyTP0VdOEzS4pME2rrkKFrg@mail.gmail.com>
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 31 Dec 2025 08:37:05 +0900
X-Gm-Features: AQt7F2pAEB-zxdQ4FDWZar-ga9YxMNL8KUEpgvXsWms4W0SKnuv-ztb3YcZ80QY
Message-ID: <CAPc5daUsZkwC-H0Am3JHozE-V3x0vF_Yw7EjZxkVcvtmtWzkOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] replay: remove dead code and rearrange
To: Elijah Newren <newren@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

> > -static void determine_replay_mode(struct repository *repo,
> > ...
> > +static void populate_for_onto_or_advance_mode(struct repository *repo,
> > ...
> Renaming makes sense, but the new name is quite the mouthful, and it
> feels slightly odd because "onto" is both a command line flag and a
> variable -- and the variable value is used regardless of which command
> line flag is used.  Since the variable is used either way, there's a
> risk someone might be confused by this function name.  Maybe just
> setup_replay_mode() ?  Or maybe others have other suggestions?

After reading the above, the name that came to my mind is (curiously)
determine_replay_mode() ;-).

> Looks fine otherwise.

Thanks.
