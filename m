Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67968285CAA
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127505; cv=pass; b=qaRJEr2AC9Oa5lXC3tc7bRWYh282VEzhZyYmq2K3GOfO/K3oSlC4ZcRfssrFFlVFZyu4JSgMYRVFzoFONFADUXF5avwnyOGwWdDpym4MrFGZYByDkHHjJ7vA8qCPFVWXV/Dn7MT1CjZrJ42lztkHzr5Rc082mAfoORMMlmU8YP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127505; c=relaxed/simple;
	bh=XvQxk/tnbaCCGbBUSKrOoHmn9ADHYjam+slzw93OMEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5bOCUoPgEeTsJVVU+HEC9PjE4xF+CsPZRc1wLHxHjyw7mjJl5J9VORJepePK98iUr4R3rrOuMElPTAbRyW8abMU6mJHjZEKgaASnbRMOHnMW5zgLjVerl67zPPNCGSqa5eJMGAjTyhUE+ffxZQYqbFGCoSw0nFbZ0b/+rhj2Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdQKszNK; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdQKszNK"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a097f5ab95so5830486a12.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 11:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786127503; cv=none;
        d=google.com; s=arc-20260327;
        b=g8Jq5+NOn85q9yPewfG5S/ebozyVriLVWuTf2chUZcqZ4q65W/6H3I4HiUnBTZ8GSr
         bsU2k4K+wyebbpQbbHNWdjnMZI7lLs9XY4qCmyVRrj2ODKuEbZTI3CFnpFfsN/FK+N4/
         b8FV3gbi8Fi/bsZRtXaLNcwEtPX7ub5uXlrs4x0g2XHQyilIdI51ISJtGpVHjYzO9exM
         IJjdXM3JHdH+PZgzCvbtb4eLYNxPolTVsil95VEsTSXofNaPv+fZnFNxTmX3tzf6uB3a
         57r6MewHz0v+vc53Zpa82/zGQ/pg8/DL6rngOkEX/ijGLgx3SgJdNH5FIdjytSiciYL/
         D/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4faYn5HjOL744ICSKproCVA40TkWT6Vm5nkvXWpQqBQ=;
        fh=vKkbgLGH8wiv/5PEL8BsW/bT6GHGnhXnXbGRTmPFG98=;
        b=K6WI+IcIjougrxDuuGdCpnB1U0xbiIIw18cGPcPyNFpd2VBY3W+dFsYMNmnB89xvfV
         dCA175SsW0q/who606/aBFaZNf+fzhyb5+Yc30ALlIA9fJubZfhdEjBAGcGAKzgTyXlN
         du/jPwdwZKKhOcF/fWwius5t0tqAWa/Yueng3EIfbo2FrPsPoCgZsLW0r1Ew6HMSPN/y
         ERwXShHJ1ylvHYNUqPDKsFz3G2S+SW92utjKv4DEZmvibErjExl2q60geCkkzilpD6N3
         F1WMR7bDAFAGCUr6/ECnx5LdRof+pu5WINLmfaWmXF6hnpTrvRqrAi6QQfQXlDI45HPo
         8ggA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786127503; x=1786732303; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4faYn5HjOL744ICSKproCVA40TkWT6Vm5nkvXWpQqBQ=;
        b=YdQKszNKKndwMgqW+cfZgiVOIX/M6Eob8Ma2dwrj8Jt07AAXCs2HQZS4KX+as3gDQ1
         G2ekxdBD8//mZ3/QWPSep62SLMZHTjoL9he4m3RudP+ZZ7etimjFXXuc1fpA3Abdf+cD
         NGuFOtC4QdgQ8FXXwy+EBSQ83dPOlQ9Nl5vttdfQH8ThLSkEsUuiNv93ZOyLJPr6AWmi
         gQAF5wuJ3N2nBpIBySRZS9121B47mWnJVJJi02GyYR3sAOmIhLsGuM+D+4iJKQCB44Tb
         Ab9IPJos2jHUI9IpnTCs6CGmCFsk8thLS3QzBF661o85PNm5axAsc5qbtcOfd4OFq1eT
         WvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127503; x=1786732303;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4faYn5HjOL744ICSKproCVA40TkWT6Vm5nkvXWpQqBQ=;
        b=H7FWuLV0KFct/L3dAgnhUkbjyHkGZYQEaTj4pwS1Yd5zqq5duGa0fD+OmPSsTpiJk9
         C0TD1ih1dL77AhHyRcq7r6jOUtHQLUILpHJNU7pQzn4wsMLxFjd6m8STcDHxpIYWEKAd
         1HOYrMgTRb1UHAgyeV7pF6MUgZgTfHkVj3eYZysjSPgiTfqIM0X7IuswUoxGwytaiH3l
         Aux1FptCARe8MR4iq4gEJ2aulHcbKC3mn3IzshMr3HuuEoKIxKsg9eonkAh8zocdr0ux
         3S7xMBcsFPjYhclsPW+7XWq47/T8UcdNUkD1p2lADGtC1ZfvsfpvNnUEwISoISh75x3T
         qEnw==
X-Forwarded-Encrypted: i=1; AHgh+RoczNhXzAcdTASXcr+wskfxcx9gqgrCYCAc/vgXSclJY4b7yRfzU1Pfff0u8D+92OR38+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxflSWDbZdhk29Qwh0IzTlDllEwqLePiycXd6vaZO/D0e2Ia0za
	+B2XPTNfExipZZDRpL/Fq3nIIWUsdT5BbeBKbgbRwy+YeAdPvSxKRmZxxF4pBO23OmAvkTqYANL
	E4VdTt1sPdKZFBh+oii0NBHYydwEnDSU=
X-Gm-Gg: AR+sD13dnD25pSyqtqzkJ5rTu6/AQFTot/yAniy7KZxbcjhhYuOtYQjOzESs5jYcGpc
	fxudTqlpXaImxiwqepfrwYcdzv5h9wC8nvbCutVWFGbQbYtt2RkXwsStqRtLvAM/UF1Y72jUva2
	QnWPWpnAosdzCsD6w/ghZZ/3xw0qwZz1P2Ov+RX6vnRWfTJFybRrzgG+aCakj+lg1NgMMaJUqKL
	/+XxJOuICjEAIthClVlHHklHXKfl30mttvVuEPD1oICxO4w9Z1VXSmpkTw2GCdJi6Q2uMJ/wkyl
	zaZMOiOIrDEL+l2LHfEgTk0NCrefZRWqbXuXoDhaZy8W
X-Received: by 2002:a05:6402:504e:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a1e62d8b29mr3083465a12.21.1786127502489; Fri, 07 Aug 2026
 11:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
 <cover.1785750108.git.phillip.wood@dunelm.org.uk> <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
 <xmqqqzkevx62.fsf@gitster.g> <CAHwyqnXJLQ_naFb1RRQWS3eft0FXL7ripviSA15Zy5D6nvHGAQ@mail.gmail.com>
 <xmqq8q6ltwsb.fsf@gitster.g> <bf9384e9-3707-4d34-82bf-cfda84a17d94@gmail.com>
In-Reply-To: <bf9384e9-3707-4d34-82bf-cfda84a17d94@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 7 Aug 2026 20:31:04 +0200
X-Gm-Features: AUfX_mxJVB-Cpo5Lx7vfxykigwBGGM7rVAfUz6i0wLy-BG56pl9FBAVuinORF_Y
Message-ID: <CAHwyqnUDJ05hrS3BeFR1b9Ei=VWCT+gD2AGJveL+Vq+5bg0PSw@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunlem.org.uk>, git@vger.kernel.org, 
	Matt Hunter <m@lfurio.us>, Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> We don't have the luxury of being able to easily roll-back features that
> have been merged and are being used in the wider world so need to have a
> considered approach to designing new features.

This is fair and an important point since Git is distributed as a
binary. However, I still think there is a balance to be struck.

> Hardly anyone who is employed to work on git is given work time to
> review random patches that are not of direct interest to their employer,
>    the reviews are mostly from people volunteering their own time.
> Therefore comparing it to what happens inside a company where it is part
> of the job to review others code is not a realistic comparison.

This is very fair and of course makes a lot of sense!

> > When you reroll too fast without waiting for reviewers, it
> > invalidates almost-done-but-yet-unpublished reviews.  If you
> > repeatedly do so, it exacerbates the problem by discouraging
> > reviewers from even looking at your topic, as they wonder if a
> > rapid reroll will invalidate their reviews yet again.
>
> Yes, I've definitely waited a couple of days to see if another iteration
> is going to appear before starting a review.

This puts us on a "resonant frequency" since I often finish the work
and then wait a day before sending out. I think there are definitely
cases where rerolling quicker would also be beneficial.

> [2]
> https://lore.kernel.org/git/ddd0160c-7f4c-41c7-855f-58288db00050@gmail.com

My main opposition to this is two-fold:

1. I don't see the value that the new format would bring; I don't
understand that the proposed format is better than the current one (I
am not sure if I actually understand the new format at all), and Junio
expressed a similar sentiment earlier so I have been counting on this
discussion dying down organically.

2. It's consistent to keep them the same, which is in itself valuable.
And it requires work to implement a new format, so there should be a
good reason to do that, which goes back to my point 1.


Harald
