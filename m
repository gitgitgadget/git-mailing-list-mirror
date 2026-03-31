Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301D175A87
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996526; cv=pass; b=jKTULZIpEEXeM0IIqIfL/dpU3zU2N9I0MvbrJ42X/OzK/jE1wXAPQn9AOVyO7VMflL/P5kevpii/uO3OmdaWLhFdTt1A+Of1WCWiIgIlBT2o5UECEPVb+0pTZMsiR/iZZaavzqTsNVbN0g8VKE9yvACg90VY2bCZXwrYTQfPWb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996526; c=relaxed/simple;
	bh=UwUR8A0RlWRZwrKyc6NMLdsNZVhEoTUvrPnPeR2kitw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv0NSbTmLa9KhKUHu3eVyPEr6u6NCkH1iLyCklz9VZ8rcbHcVNUOYla9NC6jIBLO9Y7OZ1hewmWz3nXnRYQfHMbTAqaCndZJXUjqZDGjT9h/y0s7DQ7P3u+PW4ywP5EgVeLw2qO7RMsTTTCv02QAmMzaHt0EVgLv4GMtzYO1VO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbpeTdB4; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbpeTdB4"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9519e97c01aso1770361241.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774996524; cv=none;
        d=google.com; s=arc-20240605;
        b=Warkzk/9BrgGMBztfhDv+fnbc8l6qO4FV4mK7mg7mNHZsoV4jiT1+bTczZLSoX+mTB
         dMC+utRU03Cs69jDUxQ+14ET2UQTzdxL5rzqV/jNgBm5caZ5L6c07A+w0MDY9pnOC4Vn
         lWF1CKyH2R1cPtLFF/7rdmZfQiUH0JmiigCAgdngIn27UduH7CzQHkoTfpYXMFSNkzKh
         NrX2GY6BwDIarKFc3ztlCdACbnglzvXxsCYtr8KEuUgRr0jQd8vbWGPzVdg0p6KJIJIx
         VIyOI9f8+LijiC9gqiLdHVbp60Z2subIJFSyNWusJZ5XMi0oLydCR8LihxY3i8fjAr6A
         uEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UwUR8A0RlWRZwrKyc6NMLdsNZVhEoTUvrPnPeR2kitw=;
        fh=I1783PUiMCkxE0K2KJoKqktqFGPmy35t8sZQ8FhVe20=;
        b=JYOBiDbqfs0bG6QoQE3ZZzu8u6oFBgrO0RA0fM8Q2usvvIvGOFiW2BNH02849RL82c
         S8ITSQNzFsBgspG1Y3WQrfioA/4D+7K/SOAU/32c+2Prn9bVHk8XyASEcG54/Q+Fxyri
         q1Yp//nXVoTTEeoLg1iMuvB684Gozuk6+K8ALiIwEOEHLmbVnehVPJH3CuSq+NSAKaqY
         nOmBl7HTVe5qD0FfryWhGcNbLeOtSRDvDZkqVPpQf2zCfxCt5dQYfXjJu5ikojuCKX8Y
         wxLFiTSa1DDTSbqFg6FTZC+DDoHOe2pyPpF0UBfhE9Uo/oeQ241PkflTr8DFmVzN1HRW
         NCvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774996524; x=1775601324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwUR8A0RlWRZwrKyc6NMLdsNZVhEoTUvrPnPeR2kitw=;
        b=gbpeTdB4dSnyLgYbZ/FMrhOdtgT6ByW8qbKIkfCwFa87L5JHVxhZR/Q87nwEZWQx9G
         D0On8KF3nKMw6/DvJalMpypQ9kRWxE5vT+77XuQDbL+Qs/1PHeAcYEtzaLiiLYOKpFNZ
         zxwe/bVUQFiE/ZpvLN+Zh2cSWB8zWvl6cxiNaAsj5TvIHKCntsZ6og7haw9rxsleiLV/
         hnmFHf5j2nTnPU/IHXVXXqV/qtgCJJokQoWxPiMX8SdTueh8GAlQr18Xuv3Mqbo4m1/c
         drY+Z3TS4qbUPzjtFAjT2MpDa0b7FXdyUcdQHpfFFc9rHpharj/Q5awQQ7c9rS+UZjHV
         KHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774996524; x=1775601324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwUR8A0RlWRZwrKyc6NMLdsNZVhEoTUvrPnPeR2kitw=;
        b=s95UyIqroFza29Fbq9J+EywduOez9uBPJJcyWyQVc1tVwJksoqRUTqOifhlNDF7qpq
         INPg2xy6CKh+TUvdclOc+b9ru/6LC0Z2VHC+RmaqD+UT1FyG7hGGMQy8dE+LijeBfV0F
         jfAJrFSaRAluQ5g4jxFhSsAAXkRicOsBlrsHHTtCe/XVNUAN5bcoGolWTK+U5FYIwrDV
         /G84quu12FEcRkheEzxJjGQEkhkHiSNnDKpp+e3ypa+5fuEJ9YgFj3yLDxpAFsQ8KQvL
         8uaaRTxcAg1Z6QzgABZ1/1IEonedlwKgznMk8ID5O6Ju8tUiR6nf56vD4xj55Siohq7C
         Npag==
X-Forwarded-Encrypted: i=1; AJvYcCXkYZ5TGgFDG6A9cnQ2XJ/9YP33SGomhJfjdj30jmtuzyECeLC5u2p09wLrvQ8C0/9bpTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIotkYfkaq0nKpl3jCU3ItDcEHKj2gpNaXz8KC8al6TYHAe2lM
	/dl4ZdBZEb0njEOive1CYx95eYFfrYRprMhoWfuR442GV0znrBupUPq117caCC0O02JrFSDDbIi
	QS3nFg0nWHCSpkKSSTje/EYehRCHJ7LI=
X-Gm-Gg: ATEYQzwCJpUTgoIgbG9e5Mi0IjSCi0O/I0GG0GNbEWBaFrx1U540ZO+vDPqRP9qs29a
	W8kUfhJtWY4WyLO5g9d+G0mB7/f+AKP3tu5TzzC5faceXVUDGKGpHX1iD7GjbCdGYRQ/txwAoNq
	HYAXyA/TiqABx0ETCV9kYxZKjmNEzkawl1Ji6yGPJv84kUrVUcDzCFd1P6Q39jrzzuWi0+K0YGg
	0jhzVgfhge/gXmrnDvMreLpJNOMA31cOhJyikCF3uRCCjlCByRxHyUlXFks9E8U4lqYD4WgrqNW
	+Uz4McuqyTTQ9o7b3kQrL4FuyeGyNDF2erdl+JKr
X-Received: by 2002:a05:6102:c90:b0:602:97a8:10c0 with SMTP id
 ada2fe7eead31-60567d38086mr488456137.1.1774996523867; Tue, 31 Mar 2026
 15:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
 <20260325190906.1153080-1-usmanakinyemi202@gmail.com> <20260325190906.1153080-3-usmanakinyemi202@gmail.com>
 <xmqq7bqzu1xh.fsf@gitster.g>
In-Reply-To: <xmqq7bqzu1xh.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 1 Apr 2026 04:05:12 +0530
X-Gm-Features: AQROBzDf18XEp5AoYExeIYbJHvrbnqMlhOa-7nE9H-2u_n5mIuFg4a-cPYWUOcM
Message-ID: <CAPSxiM_oSzQvH3w-vnrmGxWkXBhDy6B3JvZyJHBR1=+BMgjytg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] push: support pushing to a remote group
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, me@ttaylorr.com, 
	phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

>
> I am not convinced that having these two "failure modes" is a good
> thing; I am not convinced that a single failure mode is better,
> either, though X-<.
>
> I would personally have designed to mimic exactly like "git push r1;
> git push r2; ..." would do (not concatenated with "&&" but with
> ";"), which would mean that there is only one single failure mode
> that would not affect interactions with any other remotes, but I
> have no strong arguments to choose that design, other than that it
> would be easy to explain when we later start supporting pushes to
> multiple remotes in parallel, where a failure to talk to one remote
> cannot easily affect interaction with other remotes without getting
> affected by timing issues.
>
I did not think about deciding what approach to pick out of the two,
It was just the default i.e the behaviour after adding the changes.
I think it makes sense that we have one failure mode incase of multiple
remotes in parallel.
> > +This means the user is responsible for ensuring that the sequence of
> > +individual pushes makes sense. If `git push r1`` would fail for a given
> > +set of options and arguments, then `git push all-remotes` will fail in
> > +the same way when it reaches r1. The group push does not do anything
> > +special to make a failing individual push succeed.
>
> "when it reaches r1" makes it sound as if the group push then stops
> after that failure, but that is not what we just read in the two
> paragraphs about two failure modes.
hmm, though reading the statement from the beginning makes it clear to me,
if `git push r1` will fail, if you `r1` is part of `all-remotes`, if
you use `git push all-remotes`,
then when it reach `r1`, `r1` will also fail. I think I can make the
wording better which should
be clear for parallel cases also.
>
