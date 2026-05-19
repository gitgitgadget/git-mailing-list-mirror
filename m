Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201E270575
	for <git@vger.kernel.org>; Tue, 19 May 2026 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156456; cv=pass; b=r9YGjF6+Px+yy1PLgg0h+XYkEH2hMaUvzATzkngbvrr7J6ogYbSYn85TvH0EMtZqhscWWadYCAfwNukFMxIZuGbmKokWFLYEbBHeOXmET75sp0cgPyDG4/0cINRpHmosQUOvZT7ZBJwgNUkPUKhB2dR3uKAS2oR+hKA+aPq8pJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156456; c=relaxed/simple;
	bh=TEKI9Ds72+38Mf3UBWFbA8otSkiplaVk3+pCZpvc+q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biGFhI6RGtmjYeMUmi9Ct8KXEEmb+Q53Q2bf2fQunjVAD8m7vTFAWJZRKp337oyeUG29hsQuKb+UB6dcAElreCLx1lxhcO8n6iFZUHBb6a1FZxpAn6kx1QyDHvDfwcud9ta8feEnL1AMhaSi6cmqJM+DBk0Fmfn3K4xcISPC9c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRuSGcxG; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRuSGcxG"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-439a8366831so1165767fac.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 19:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779156454; cv=none;
        d=google.com; s=arc-20240605;
        b=HHVJ3HmjSgpKJcSAkt1eFvO/yTJ0JQQ8/RVtyqRS3zMvKDU/qhb0HwUu33g+OcoJ5u
         vPBgZFQAjIrmeoclJ2oYEn6wUzsaxVGbc1+rWBLT5yu+H4rqcyy5dMLxNL/VbQ4XRveL
         ult7YhLO/tlEhpyAjqA7l1nqHtm7N4QGjtndnqt0emoU1Iic74pYa++dmvx3rOwjPOVg
         EkgDaDHaJN8UZeJyuaoxfkBXAtxyaAle7nooaVspHYOw8Wp2LHIDJCqxcNjynU55aX8e
         urRs4ATIMUjmGfCV7RBpX0J7H4VMAxWDZA3fAflDPp7z0W6kWH6f5zc4UhmsR/FArWYc
         qMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plFQ+BYqpKG7QUtjH1XeEOSZpwkvqxayo+lYlLsyLnQ=;
        fh=/27pb2KtSMGgS4ycbJSnizG1c4CfgTV1XQXj5QNZCSc=;
        b=e/Y+kQ+0tFS/cqIq87CpOWGK3hQ8WaZstecmJOhJwCBp0ysRN18mlhLgFuGWzBQ2eh
         EDgSV+R28kvPoB2ECAa2m4Ak/Bsg06ge6M5c0t+sMnZUUdJCpkE6FLBqmtGV0/0/Je0p
         Dh44EKUHHwRprfT8FHFGoXa9L8GEr6L7N2t9IIEFT4o/99H67vLuq/SmRldBmK1CHaOr
         vsplbGrby0ozsuh/GmXqnQ57+TQmL4iJgYdVc6oT8bC3lv/QV9OUtWBi/yM71ZiMjEIj
         g8I3KPyT2l5AKHyVODqlRUEG1s7FfB7VSQnscEkhfh8OiP4jlAgyZ3bY06KEwG1puwLm
         aVMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779156454; x=1779761254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plFQ+BYqpKG7QUtjH1XeEOSZpwkvqxayo+lYlLsyLnQ=;
        b=rRuSGcxGpDW2Rf8xSDghv22g67lwtzVVzJt8jAB+XL6plng+mPSdDAIFisMnkVgw7k
         m2xIxv0tHhZ8J14/tMOjxPt5hnqHPULBQ35rrJJ0DOu2/K8vjshxBe5I8LNO57a3v1+w
         agPlv5GKxDM0ltgquCgf6jpaYpdRWk9OO4iWzSxPqY6EGfWkPqj83RqA5fdRik1GIjf3
         bTPtOriV1gPNfDXbLpMQKDApcqJ3V6KjgZtuQmi6pdDcVs4vX1VqxFW440TyCDEe01jG
         Bp9VorOqfeH9ulDJi2TV4NV8fBsP5Xpbkqt7IlvzUBKUQ+t1bdzZGCaw45fRJ6cLdU2g
         m/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779156454; x=1779761254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plFQ+BYqpKG7QUtjH1XeEOSZpwkvqxayo+lYlLsyLnQ=;
        b=fWeS/dG3S41c6TS4AHfmyYZvmjiOlT4ApW4COB/czCRtZcwVEXvePCMBLG52iMHk0n
         pmZaYwrNfvDq0HoSQJO730qI88okeLenqji/ypqhVmYGap/tEF+x8Pue+LTe7IfiX5Wl
         1jZGGJ/yzanhUUP/93KbuedypnnzJdLl8erWFCY6/zqBHEKeDtJ5ENbF50dovI5MZWWw
         IGhaxIFizmw9u/CoTEQUu8y7fRi73P+hxI2/zFfM8i4wzOBnQCZETkhZmvrHCXH9/4pC
         FJR/lE0ZfZibnMuPoJqMMjgR8LBZaoxARkigah/JwqH0P7vqXhS3HA6DfqfGul6q7sPa
         uL6A==
X-Forwarded-Encrypted: i=1; AFNElJ+wqZ2TefTWMSX9gzYVYfG+9BNWktkqU8CrmmeaECkK+A8bS5b7sr13bSJc20w3jgQ3t3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3jLe+oj7wLvjHtwj0pJ/Gn8bX0WkDCWsfCNTpm0YDPN/yVx8
	YFATuCLl7S5FJIJgZIG7AW45CR3QogCt4UCG3pLG2rw0Z1OGooitqrk7K9hRLKnYUsNlx5bz2GI
	JgQuI/VtDcM0KhbzbFWJ0vUurhI+iE9c=
X-Gm-Gg: Acq92OGobN7CuYPtnYRcHr8//ImrvNTrc5TbWdvMrRrM0nQO8CE9rIQR9R1a8+5CvDs
	JQwAdorORFYAqiTDqRMCSHAcby87F6LU82MRDRn6gIj6H4C1aVnw3y7qFDBzDsEtqsp8JACmt+p
	fnebiFctiDN5iQbsCZr98YOl9FGhUtEnkCvE9JX/hLop8hznAzbtM6/I19ASmu3khuFLb3vN0uT
	TK9DX3tXtK62iLix8uCufNq1n+WfExQYywndkCrbxfLcpYelhv94t5F3ErTmYF1EolDv+ijqWlo
	GqY6PZuLSMO3nUGi2IYISslftCxl80a/6YqzNPLd
X-Received: by 2002:a05:6871:b0d:b0:439:f314:ff14 with SMTP id
 586e51a60fabf-43a2dd6fcfbmr10827468fac.19.1779156454162; Mon, 18 May 2026
 19:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g> <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
 <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org>
In-Reply-To: <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 18 May 2026 19:07:21 -0700
X-Gm-Features: AVHnY4KpiJDj0QbMUjwGJ3kGsdE-ZMEDZ9raVozXhujTC98gsdfIM7TUnCSs0qw
Message-ID: <CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Johannes Sixt <j6t@kdbg.org>
Cc: vincent@vinc17.net, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 12:30=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote=
:
>
> Am 18.05.26 um 05:30 schrieb Michael Montalbo:
> > On Thu, May 14, 2026 at 12:37=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> >>
> >> Michael Montalbo <mmontalbo@gmail.com> writes:
> >>
> >>> @@ -457,6 +457,11 @@ endif::git-diff[]
> >>>  +
> >>>  Note that despite the name of the first mode, color is used to
> >>>  highlight the changed parts in all modes if enabled.
> >>> ++
> >>> +Word diff works by finding word-level changes within each hunk of
> >>> +the line-level diff.  The line-level alignment determines which
> >>> +changed lines are compared to each other, which can affect the
> >>> +word-level output.
> >>
> >> The added text may not say anything wrong, but I am not sure how it
> >> helps the end user to know the way machinery works internally.
> >>
> >
> > I see what you mean. Maybe the doc should focus more on calling out
> > the user-facing implication:
> >
> >   `--word-diff` finds word-level changes within each hunk of the
> >   line-level diff, so changes that only affect whitespace may still
> >   appear in the output.
> I don't know what this paragraph is trying to explain. I don't see how
> this would explain Vincent's observed word-diff.
>

Yeah, I was trying to explain the difference Vincent saw compared to wdiff,
but I agree with your criticism. In "beating around the bush" regarding
implementation details / making a direct comparison to wdiff, it has been
hard to craft a meaningful message.

> The thing is, "word-diff" is such a descriptive name for the operation
> that it is difficult to find a description that is even better. The
> manual page doesn't even give it a try. It defers to --word-diff-regex
> right away, which then only talks about low-level details and doesn't
> attempt to give a higher-level description what a word-diff is.
>
> I don't think you can summarize the algorithm in a single sentence. But
> then I have to ask: why write it down anyway? How does it help the
> reader? Only so that they are able to derive an explanation for a
> particular observed output? Would it have saved Vincent to write a bug
> report?
>
> If we document the algorithm in such detail, we cast it in stone. I
> wouldn't want to paint ourselves into that corner.
>

I also agree with this sentiment. I haven't been able to come up with a
message that threads the needle appropriately, so I'm open to dropping
the patch or reworking it if others have suggestions.

> -- Hannes
>
