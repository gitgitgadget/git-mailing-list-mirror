Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBD3CB540
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486410; cv=pass; b=iOg+sroMkoa/rZHuysQxC6DfjWujng5MixAhRgMMko97W1ocVrlkN0pqTfi3szpWlV4Z/AE4ki4izK2t4AfMLOLvR82ZNshRNAj2b2Lv6GGUUhDsEnIUKSrWWB0KLZtxqpgeBjG/OHR5rK7/eRV6uoosMMM2Lsx1mkIWBS0QP4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486410; c=relaxed/simple;
	bh=e/WYtWhi2VzOkWg8GOeMNLRDMNcsJ+KMMmyD00cR+Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucI2VK6A/XxIZ60il7S1s81yAXAOr2sTY5RhfX7a7a/mBX5Lu+FAuFtksBfgM/vkFXXqbXRgk3IMqwsgJVcWm/StwNc9eFoZrcNB8wWC+xQYQJhXMnvzyj/Y3QLen/KEDkbT71Zwxh6UFhYVdM9vRqgOeWOf/OMsM3C7OKwdszU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn5R9D26; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn5R9D26"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a772ec8389so27686081fa.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 12:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791486405; cv=none;
        d=google.com; s=arc-20260327;
        b=RFn+IhzPzpyHhdwAaeAZtK2ZkMG0md7VU5Z3Hps22zSy3MUczTxkMYls7Wd+2mF87P
         2VOhWDNtPQH9knx9wDmrFC77CNiOm6pFuhzmHGiV+f99Iy2anBPIV7reJnnNhY0e8iAE
         LBsGbiX60CIGYXvo4PUIygeRm65CLt0M0fj+yT2qwnN/ik4UFpqO6mmd0gBu3oyUP1Wr
         aYEa2NAyjzhXIgbiBpADrvvHpOSwdPbV7ug5gDNN2NcB1IsmULDevWl+Xhp4jwv3bRo7
         NEDwmSsd/ZckjoHk5TrtfVmv+APYCKde+qEBKyPWV/XObQ5TQdyw73MQYbfy3PUGqyKy
         1CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tw6ZYd75IN/jRLjuwVizvQWP11TPHQplTLX1BHeIK4o=;
        fh=hQDIabKvi6qTfAtrYBXJqXyNz6uQZC8CwsxejGRhIkk=;
        b=qc0TUm4WfmVlJaC3M+9AMVBBpkZiGELKseZV9WH05iz6cGS58DP7LFRnobrb/2PQwk
         eEPXtFs+ZJkVSbszOWLASoiI5tdf6M5ApYtCYnYDxdJali0wa+BssgRJMrvtmAk4d085
         g4oF25B3GJdj+wbZLxXS29g0RdeRHa4MNpjDm1KhhNWI/pPcj9Eq/IywWQsiTvuimJ3/
         eclrjprX4yYAVtXXbef7kmJPU8HxYDYIW6kmyP76xU6WWaIheyqa0Me5V+710jfLHM/G
         EH14WYFTTc2q7h3l2zYmc6jF8JJpxUKNLKdYiBD/CqAaFCsyYyiMdzrVCfu4UQXplot1
         AlYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791486405; x=1792091205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tw6ZYd75IN/jRLjuwVizvQWP11TPHQplTLX1BHeIK4o=;
        b=Nn5R9D26FhA9AxjOdtKXAZI9fTPCMfKFku78pOsfdzuhodTYA5ufALWntIRbzTs9TN
         fArEFbnqjmRr9x57SaoGA39UhvHjfp+1fx6FftWREQKVE19dJDi3TsvvzUp2CmnqZFqn
         Nu/fkeYrR6lwIABIGVDtrUuxLT75xkuTVTMxBkO/c8CZLERwc/Qw/4GKdHN9SL4gaeOx
         vyMhrIDkcdtzrej1AwsgmvH5gmtcgn90zECFLBV8y21JaPZXd6VgWfh3Eru7tbAlVz32
         mRNOh/57WVl6GlN4ae4LRoQFxrGX7bBgOiOsUtda96IZ/1OeP8Mkz7MH1aBtzEr6hzdo
         jMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486405; x=1792091205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tw6ZYd75IN/jRLjuwVizvQWP11TPHQplTLX1BHeIK4o=;
        b=OqP8ZYsR9zNlZO4phQPE95+4obB1jOKS/+SoFG7mZqgru2YAUh4uK4RfIkXWt+xT5K
         HvwswglJIBoJBrMyQ8Bymy0r3V+LpFfWr8BgKIwJgIErU2V/ohu4ueliuyQZ1kOIyfe6
         p78RYG9SQ0m3i4n0fu5jKDjR2jBr6Bd9HWRoxvHw05L2m65EpeInBoX8kHJZDwsvvjQJ
         IFSDSirqIkQmF0+r1T2mofpU/dgRq4qL792YaDYH5R8tI0qi+/4THj7aj2h+FXsTMwTR
         bgRW33TmIvJBm1X2ta7VdUD4Af94VTznrQVdiMH+WCc3Hz3uZfvGebrlbMTs9hYB89tr
         lwGg==
X-Forwarded-Encrypted: i=1; AKwUvBx3sOAqo+OBXmPYGNfyRYucQcED3huC7T1ME0VlZCMepxYpgrcUvIO4r07auzRxls/z2sw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIJikvDjc9s9SbHs96j5UU3GWxU7xBhDQBNQqGQaP7tPvRZsgD
	ILS3bT5O7sFLTDf0GrT70QUQeiowv6E+HE/QHBC578EzASFekOP6kRdmmBvTuiQ5mXbE09TzNsQ
	XrK9DGYi7+yiKeCBWox8/QuCtc65hOtE=
X-Gm-Gg: AYBFou28y+eUA+8es98ypt1zAQE9DkkNap2yxS0HgLdQCB0BFQh7UUs0lOazT7hVmAP
	XXcM4psl+bILEQZSXaNCyG3ZI3J8K8RAR60lWvEexqcA5qo3Eqd81oUBu1B+fI0ra9LX4pTVqYv
	7y+DHcS+dI9VzLy6CucRQ6ZwOFxcpvjOGnaQXJbbvWENvtB5NhnRAvgJP+a9GyOiR5xyusylYKi
	mW5JPaAaW+EtC+KSI/BvlcZhHtws6ECw0hsU3Sur5idOzTXGAXR2qCWxYoQGXWYDn2aiTGscvgU
	HwEgFKyDV2rCH+1suJGqloiv6f95sbLCQ4AW2hFhYu0mhXtjtMxhU2A2hdyGrIRa2TQgzAdenrb
	YGu0By5PwJwCt1Av4zU4TUpHKYn1EAxjIYmtn4PIpIwXbrGn6ANpMrsUNzYIRb77kkMRW5C0s0t
	/9FtXiBMk=
X-Received: by 2002:a05:651c:a394:10b0:3a6:5ec0:796c with SMTP id
 38308e7fff4ca-3a9a2c9d3cemr11636721fa.19.1791486405342; Thu, 08 Oct 2026
 12:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com> <asdsIjNEUOpaAnX5@pks.im>
 <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
 <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com> <xmqqqzi02o22.fsf@gitster.g>
In-Reply-To: <xmqqqzi02o22.fsf@gitster.g>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 8 Oct 2026 21:06:32 +0200
X-Gm-Features: AclHuK9HBRHBHnrp2ROirDKrM4Wu5Jw3tR6FQjia4egn4Obym2qw3OoNLoDSx5o
Message-ID: <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 5:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> A response to reviews on the N-th round must come long before
> sending the v(N+1) round of patches.  Some contributors send them
> after v(N+1), or immediately before, but the proper time to respond
> is soon after receiving the reviews on vN and having had enough time
> to understand the comments, before starting work on v(N+1).  Only
> after that work is complete would you send the new patches.  Hence,
> we expect the time between vN and v(N+1) from real contributors to
> be measured in days, not hours.  Whenever I see vN responses arrive
> after or immediately before the v(N+1) patches, or worse, no
> response at all but just the new patches, it smells fishy.

I wouldn't rely on that. It's easy to fake. I'd rather ask for transparency=
.

> And thanks to your learning, the next patch series you will write would b=
e of much higher quality.

TL;DR: I'm facing a moral dilemma: should I refrain from submitting a
patch, or submit one written with the help of AI? If what I'm
submitting isn't useful, feel free to say so or simply ignore the
patch. If it has value and people are willing to accept it, I'm happy
to continue.

My current workflow looks like this:

1. I give an AI agent a task.
2. I check whether the solution works. If it doesn't, I refine the
instructions until it does.
3. I check for edge cases.
4. I do a code review, ask the AI agent to explain what it wrote, and
have it make corrections. My own code review is pretty weak, though,
because I haven't spent (and won't spend) thousands of hours working
with C and Git internals.
5. I ask another AI agent to review the code and think through its
findings. I usually conclude that its review is better than mine.
6. I go back to "writing" code, and the agent implements the changes
suggested during the review.
7. GOTO 4 if I'm still not satisfied.

At this point, I face a moral dilemma, because the next step is to
hand the patch over to other people to read, which means asking them
to spend their time on it. I have the following options:

1. Report the bug without submitting a patch.
2. Report the bug and spend a month writing the patch myself, learning
Git internals and C along the way. Unfortunately, I'm not planning a
career in C. I've been programming for well over a decade in a
completely different stack, and I simply can't afford to devote that
much time to it. It might be worthwhile if I intended to spend the
next several years working with Git and C, but unfortunately, that's
not an option for me. On top of that, I can't shake the feeling that
AI is already learning faster than I am.
3. Report the bug and solve the problem as well as I can with the help
of an AI agent.

So realistically, my choice comes down to options 1 and 3. And that's
my moral dilemma: I don't know whether it's better not to submit a
patch at all, or to do the best I can with the time I have, using AI.

Choosing option 3, however, creates another dilemma before submitting
the patch: Have I reviewed the code thoroughly enough myself? Do I
understand what I'm doing well enough?

I chose option 3, and out of respect for other people's time, I'm
doing my best to understand what I'm submitting.

And the only thing I can do to feel that I'm being honest about it is
to be transparent and explain exactly what my workflow for developing
this patch looks like.

Thanks,
Maciej
