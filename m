Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E354A1D
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720320636; cv=none; b=YDTUH21oxf3ozMkBy4pyGj5SCwFz2pvsJNSNRZ5/IkvalnFomJOjKnL+b89qSF6fnSgYHKtWVJWVRJYeqbU0wsIwUi7g8Ib3Zi6kYWb69MATiBixUAQ8FZDWxrkBVgFNa0AbEEpzHfBnHLkb7Tg4fh9GfPIdi8EjtoXiYm9fiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720320636; c=relaxed/simple;
	bh=KWATkfOlUx3O3zg5SE4oOZ7QMcVU4kZltwa6dDGC5xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxclDgTEcOTrERUNL/OkC4JLuVZ1S3+Iqo+Es1K/i39YLTd/6AExVeO9yX1ZW0Bgy9ZqHM9WWjxaMSnbK4y7xUBWG84mWeYdmB4tu2U0o8zLkkIKOs9F+aEqjix6/FJ553TNobPq3muTij8Z4FlQPq42qxf+i1JwwQGmHspHLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClXpFeNx; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClXpFeNx"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cba5eea69so1336852fac.2
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720320633; x=1720925433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ritv6KK6mzUL8yJBouwQen0BvNpKUX7vLP5BRBOBNBI=;
        b=ClXpFeNx/zuIfI9Gbi4MbE0jk6lJGU8TE0v1Y/evTvQtoUFK7aIbG5+t7YA+65DbLm
         wYaL42eVrURqANAZCj/yZBYW+iThSHFHGpOFth6HAIbheI0yzeoEogiATyBxx+dculh7
         3k3uVFbD9mwtrOYmzt4eprfdbwUCZEZLOlCCD0hm3jKjRKefSJ+iSL6GtMMEdDpKf83r
         T8uJlEC9lkzHEzRZvhiAGJUAsHQ++Becll75s5J0hJSh6RssZo8RDQ/KNLxPkVo8f7eD
         fYliZJP+x5CE6ykxPBR0Zq/bM/E46DSoLG+FyFWXGmb/djQdeK1Ws+kwvMRa+9KIXn7p
         Ttqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720320633; x=1720925433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ritv6KK6mzUL8yJBouwQen0BvNpKUX7vLP5BRBOBNBI=;
        b=kO/ROC9jGpft02RyYIAbVGmaMTvNjYfOVJbXsHV980Yu9PeHyUe9Prf+B+bzMfflw6
         9kYPjKLfy/fvkEr/wpR79lAvJeCMMge5dH6g9TUdUmNAwIti3NOJ5H6yiWUQvwHORgV4
         ddp/88CCROVuFD+SxzqtcYxT7xqNdKIJnZPaczZbbX35XxT7fNuiQom243z4Zcs1qgD2
         TgaVFOSO0SYmD6ExYuVWujzdmfArPQPNJ4omcP3stf6TW/n6b60fqR2m+VQyenrHSydu
         lu9TxG8anWtW+RYSDmhcGMfGoJQaOHbqLvxmvJBijvrFV72QDW0hylK/ygFA9DH4Dx2M
         LEQg==
X-Forwarded-Encrypted: i=1; AJvYcCUsB7lXMew29z5EFuMRv9qv8NviHTbQJEbgMZvVEM23HDU5UlKCdMaGM0IRVikPbpfjO+pNW/suRuhWf5Tx6MuYLte3
X-Gm-Message-State: AOJu0YwEZDQ9lGDpaGNANic6GcxAGQsErqHtbJ40PXQyW0Q4u6Wmvt3m
	AD6yMai/ZxM2ZH7JxauYfatoSNA766Y00M9BcJteUciXYQBYjLEZOQaH6RpWOsW/DpElvfQ/Rku
	WLtLbA0gxxMjZwU9VVOgcoOy0nptAMA==
X-Google-Smtp-Source: AGHT+IGFxfX1iLxE+jo3o3h0xnJYNPu76uV7T+XBDBPfk5Zk1ZhoxYGQgREncg5JJr8A5PQ2n8aPZo3z06OMiWdMsD4=
X-Received: by 2002:a05:6871:24d7:b0:25e:24b:e662 with SMTP id
 586e51a60fabf-25e2bdac0eamr7576313fac.34.1720320633524; Sat, 06 Jul 2024
 19:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1758.git.1720123341342.gitgitgadget@gmail.com> <xmqqr0c6nzjl.fsf@gitster.g>
In-Reply-To: <xmqqr0c6nzjl.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Jul 2024 19:50:21 -0700
Message-ID: <CABPp-BEXgZ=igvNT2RFjYTAEappx-q=8oW3RD8+FFZDx1JxfJQ@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: fix missing early return
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 11:30=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > One of the conversions in 500433edf49 ("merge-ort: convert more error()
> > cases to path_msg()", 2024-06-10) accidentally lost the early return.
>
> f19b9165 (merge-ort: convert more error() cases to path_msg(),
> 2024-06-19) is what I have, date is different (and object name is,
> too, obviously).

Doh, sorry, I forgot to update the reference after rebasing.

> And funny thing is that your base-commit points at the latter.  I
> briefly wondered if we can somehow automate the generation of
> reference in the log message, but the base is likely to be the tip
> of the topic branch that has been accepted upstream, and the commit
> being fixed up can be something below, not at, that tip, so it
> wouldn't be like a simple and silly "compare base-commit and the
> commit we talk about in the proposed log message".
>
> A commit-msg hook that scans for names that look like commit object names=
 in the
> message, and
>
>  - makes sure that these commits are reachable from HEAD (the goal
>    is to make sure they are reachable from the resulting commit),
>    and possibly
>
>  - makes sure that these commits are reachable from @{u} (the goal
>    is to catch references of unpublished commits)
>
> might be a possibility, but such criteria are probably highly
> workflow specific, so needs to be highly customizable if we wanted
> to make such a feature as a part of what we ship.

Right, and a commit-hook might not catch it either.  Since my original
commit was based on the one I referenced in my commit message, the
original commit creation was fine, but I realized after creating it
that I should have created my commit on top of your applied copy, so I
needed to rebase it.  Since rebase sometimes tries to avoid invoking
`git commit` (as per sequencer.c's try_to_commit()), that'd likely
bypass the check anyway.

An alternative here is that I've thought about adding an ability for
rebase to update commit references in the commit messages it
rebases...but that may not have helped either in this particular case
since I was only rebasing the tip commit rather than the few commits
behind it as well.

> > Restore it.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
>
> Thanks.  I saw Peff's earlier message and the change exactly matches
> my expectation.  Will queue (with adjustments to the log message).

Thanks.
