Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6B3CCFDB
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312448; cv=pass; b=lzs2S15vFoJu82YNKTqE8eeVuuMhTGR1jzk1iomdOEBCukPsGcQ7Esgd8ATZ3rGDVDcV0NoyacadSLynk9wfTljKmilSBk0MkQhUZpYkfxMA9actGnt6JZHBdEzByqoTr8uH8hHHwWNmXA/7e+a4vqRot6l9g5I2KL6KyPjk+I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312448; c=relaxed/simple;
	bh=ghrFOuYpdFIOBRBiiinRQWCz7SGm0ne3QJIwtZciE54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHdDHSqEM3HobjvNZHX9srvXcsX6wpO5jMd+3D3QLr+q1DygP8n9Squ3ut275I0zr4W3kdxPcDrpXFelKC1fHr73V+9qs2GX9jj3R7RDx+MahNVKviZPVfQelc3QmeiwbNvv93Tl3uwQ77pDNw51NaeMhN2wAFQDps5QqNNUNrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=bGZtpWb7; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="bGZtpWb7"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-662dd616cdbso1141288d50.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782312445; cv=none;
        d=google.com; s=arc-20240605;
        b=cghU6R7l/RPXlHRkerulqjl+PyPW4Y75YTQNGP5ZddslheQvLM7+zsRybvfwoK8+C9
         0It7Tw2S6nkcmDGI1s1bIXiApZAHDH7T66CaOZWgYy1Vzyizmg24bKzFb720ZeBRjl//
         AsOUye9OCh+KMJfxoZyukmui+deBHiYrTyF84bRZlOwuidYKH+csWynknDsjTLSHDJRF
         KtO2TPZ61JR/tUJcTRdhcuf93BpJAPK47S6P2VBbe272cJOKbv3Z29SiJnyYjYdvr/oW
         0Mk/IAOfmCBqbL1LNazzA6+cJu7gtkTLeW7lm79QhVBet9vnphv4Imbu1w8ffgzt4AXs
         kekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+jujwTaEO0JoQF1/lj1R+NArW6P/HNH7BZaNMUQtEhU=;
        fh=FL1Vp615hJHl2xgALHJTed7tA7wTrjiKFSJ78zFFsVc=;
        b=TpsxU/7ReTwmYgAbXYhVEUXybuw/DNGO9z0UNvzm17rUg6S4x5M4OvoraDQJz5P8tJ
         8Rhaj1t1Q7ALH3g6jm2w3RMjd+E24Vl3GRt27PzQ60SOxyoNfJ9XEnmdcMrx2VZW8L42
         LpFK2FB69YM8LxfApl7eeDOV6kYDasOuUM1WeZXdkGl1sqn2J/qFb/GuIChO4pz6t7Wq
         iho2XgiYa5ezSr4KmSuMrZfhJz8+mMxYJRgqK3ZSkF9CSTLEnUYFnuxJEj5Q5ZSck3Z6
         Tp4Y9QsqvnLq/qOA4cW2kgUIkgsH0gt/Pgt8ZVh0Hg31GN+V23DEjSTQUC23wT8I8hNb
         66AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782312445; x=1782917245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+jujwTaEO0JoQF1/lj1R+NArW6P/HNH7BZaNMUQtEhU=;
        b=bGZtpWb7ztBDIMAqNIRCxpzaU5vfO8Qv45zdcDDM4lx5cJunqpAIATBamPt+q1/Ak9
         ioaIHiLwekAS5G12X02SxAlSQmXOAhX0Xoxa8hHZYo5pOpoaXLE/gVTzOhe/JP/DLSlP
         TPhU/kUlYD7dW+inA4tu9lVn7dx6EagHZ+bMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782312445; x=1782917245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jujwTaEO0JoQF1/lj1R+NArW6P/HNH7BZaNMUQtEhU=;
        b=pHWXjYGfWgwqmowzpBpFQ3VV242oUkOBxf0laO5ufNRQ80meW6OUcSGSCYec1lSBxn
         g0073COWRavfVERzlRxXmma/kKX/fAp4DZW8dDb39xRnvjNmQGrBnRxTSbafy6uRiX7u
         qUQ0Baj0UgcvUBCoIkv/n9uC0uRa/a+Qe6mmbRQiOsnEOvLDfZjhS3xW+VWz13kqSQKj
         r3iw0FKwVr1zWbc2DJXIkMdF0n/LYSSCpa0XQnzmAGa42GDLS1uAp13I85Bb6sNGvEC6
         ttuYwT1pobVSr1TVdR5C4zsheO3C1jTXbS5fsdRlzqWRB/5/owaUWMBw2VwB1iTXpq0n
         9TqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEDYmktF54t11XOM21kVhmJ/oSaTHcg1qaYy22SW9dK4q2+1z5dhKhrcbRypgIyT4/3yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8+2v6JLoSoEAr1kbybfPMGKYrfY2QDgdsE+pAMSU+C7sMN1b
	0/MrLrOZp5pIANwSwaT/2yPEm+7hJwnkBu4gb+hR2X9nfAZSTQu9L9zkXY4QEZnWTSqLUC11Yff
	LmiaHLqMPUP+xt5/rGFI0b0fFDlFYvtvuLv98u/A4xEJqZLdbbpdPECkrsw==
X-Gm-Gg: AfdE7clt6MUxkQmtKyeSLlYKuyqIQZyQib+NnMUgbECE6hjEV4kuLp7wVnpPw2dRlhi
	YEVXzpYU6swEdZkMsGdbv07h5/wJL18b8ZsHxCjKl++hxtlvSgmOXIfxRUxR0nlm7KwVsMZnzfA
	47H34M8TpUjycKOvKReNWWX6flCKspN+oER/ZvLEr82vRolxBEuxY1dz4HfhaXjICceai59yagD
	KeBYQPE/W+O8gUTV11kYBVCX3wqUrphGXjmRO5/QUmWrj842JQpX0HMPbpfoM+9YFRfIXN13g==
X-Received: by 2002:a05:690e:1207:b0:662:c259:4902 with SMTP id
 956f58d0204a3-6636e5e156emr2864778d50.65.1782312444757; Wed, 24 Jun 2026
 07:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com> <d84b932e5b078edc8255b6944ecb67fc1aa086b0.1782303254.git.gitgitgadget@gmail.com>
 <6b0d81e7-7617-4fb4-9e39-cdf8bc778837@gmail.com>
In-Reply-To: <6b0d81e7-7617-4fb4-9e39-cdf8bc778837@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 24 Jun 2026 16:47:13 +0200
X-Gm-Features: AVVi8CdomkbxqQiWU-G9VJEB-2-hnfqK5qDx8sVsoAZLfuXAY7H0o55znTxII-8
Message-ID: <CAL71e4N1zMz=v9umGdGPTvLP1nF-tNLVQc+vAEBnekt2L0b6zQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 16:02, Derrick Stolee <stolee@gmail.com> wrote:
>
> I see how the previous implementation has a termination condition
> before calling prio_queue_get(), which is technically more
> efficient. It does make this initial diff a bit more complicated
> because we are moving the prio_queue_get() line.

I was thinking the efficiency here does not matter in practice -
prio_queue_get() only returns NULL once, and all other times
where we keep looping we do need the value.

I agree it does get a bit complex though.

> If the introduction of the method in patch 5/7 looked like this:
>
> +static struct commit *paint_queue_get(struct paint_state *state)
> +{
> +       struct commit *commit = prio_queue_get(&state->queue);
> +
> +       if (!commit)
> +               return NULL;
> +
> +       if (!state->p1_count && !state->p2_count &&
> +           !state->pending_merge_bases)
> +               return NULL;
> +
> +       commit->object.flags &= ~ENQUEUED;
> +       paint_count_update(state, commit->object.flags, -1);
> +       return commit;
> +}
>
> Then this diff would look cleaner.
>
> (This is the nittiest of nitpicks so feel free to ignore if this
> doesn't bother you at all.)

That's a good point. It doesn't technically bother me,
but it would be cleaner. The refactor commit would effectively
be looking into the future and prepare for it. I can change it for
the next version - my only thinking was that the current refactor
patch matched my original idea for how to best handle
the halt condition, but that did indeed change after this discussion.

> > -     test_trace2_data paint_down_to_common steps 81 <trace-half.txt
> > +     test_trace2_data paint_down_to_common steps 57 <trace-half.txt
> >  '
> I love to see these steps change. If you take my suggestion to
> update more tests with these checks, then this diff will get bigger
> (but in a deserved way).

I will try to add them to some (but not all) tests since it's more
closely related to performance than correctness and I want to
avoid making too many tests overly fragile.

> Also, when I suggested that 'test_all_modes' creates the trace
> files on our behalf, I forgot to mention that this specific test
> that you added in patch 4/7 simplifies by running the merge-base
> check under 'test_all_modes' and then checking the trace2 data
> on the three well-known files afterwards.

That's a nice bonus, I will try to see if I can manage to utilize it.

Thanks,
Kristofer
