Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7947A89F
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106091; cv=pass; b=fxZJD0NPnbi/a8ezAXgvJLV5HWfhA1/vCnB45/iT+Xj7iX6aW+pL+cLspmk5T7knGwAFHoD1h4fi1HZJbgz4VbI86YuoJiHrCUo0BVxXniPxVxVunfZNmJnksXqMQEqqTCvQT5FyHlOiyy0TQWq0w3i5IRLtyuW9z8RMjK1MxKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106091; c=relaxed/simple;
	bh=FDT/ji3tALN/xrAYm+HnV2R3sJ0oi2IQJHgicmH894U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTpCKK/9sVMR/GDh9uWF0oMtKVRoB38oSano0StvbP6cx0nyCpFm9gUgFoaJcr1LaGa/5H4tO0X/PqJEWUH0lhpOEPaGACysGvHbf751P0pT6rhrSy4rv4PIjnW9YmKdGngEwOFpxAm6j9TrgFa6vl8EcKaGMTYa+s70kkh+EWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=byrJ6StO; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="byrJ6StO"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81f36179dd5so46509197b3.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786106072; cv=none;
        d=google.com; s=arc-20260327;
        b=F+DE6jqlmjB2A1TLelV2ldUUoPSkzs9bgrcQkal9bSRlE3/WewdrFS/0um54ZJdTfR
         1u2vfA1X1tO9Gl+6xYQ/87MJfb06O7p7H6P19lnEPekjfLPJqKZKx7iRT6/po/HXLR7J
         VKVBG6Rtdaslt0WjEcbsBWgbHgMdQqGNG9Xv6SktGDkqNaUcydcc8RSjSIUg5DcamF8Y
         XVh7oFYcLt8L+waCjY6vYTqypRJMGxjS8mGQ1Fq1IRo4KL5kCd20ct+uYO6eiYbshVrN
         9VSjDpk0EXQtOJLBXd+wcAE2aOhgFZVu/ZCxnnetd2DqEWUXaAzYvZlTIT8cDF3q/1Bh
         qK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W+UP7JZnwhm8V0KUhP/2GUkzHyD9Nhl1n1wlfFHiGI0=;
        fh=hevuZHoCqaxGg69pg/ZCsYitngbo7U1KgIATJ4GH34s=;
        b=Qt7W6ojadO/PpkO4Xev1tEAsSVzy/WsveJqdc/8GGBsecPVdi7VxS0L21hZc++ElGw
         pvSPi1TfXWI4fdfV7Brk5RI/rxnXGqP0GyOU/Css0uR++6igt3+n7J2FIOWjQBpFu/7S
         a/NdJ/hO7ITEAb/VnRvhWheWAZbmREg+7MyQn5G/1ukglIfiPsLayLGGtaLEtx0WN6EV
         lc+ulUEJRKbZ5AlrZG2xNFDv3fRIw7iLkzHPQIU8HEJg/YxKFlJHFHJAfkt0mMAlSEXD
         ckSo9hDF7JeMQiie4LFZ09A4GR2XVratlxoYnZyjlU0Z3txwuWYcPkfTYcRwVU2wwH93
         cIJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786106072; x=1786710872; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+UP7JZnwhm8V0KUhP/2GUkzHyD9Nhl1n1wlfFHiGI0=;
        b=byrJ6StOi+U5RUaNGATWG5g19lPAuY9x9r8XEJIGsMiKKpw9Vdtmp4/xwG4QOopFnF
         sk1zWyvzKPWy9JZy+/kIGyK7s9UAsZHZVMXS5JJ13FMeOH8EnX5CwEWzXGS/eRmYvw0C
         5LxG5uf9p9Ttk59bhxOtvy8dGUQV029wxUYDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106072; x=1786710872;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W+UP7JZnwhm8V0KUhP/2GUkzHyD9Nhl1n1wlfFHiGI0=;
        b=VbKxCHXc3lweIwi1wXStvziFdiX8QArdZWC9l99iE4fYgaaHEuTzZdvD/uK9GoeLcy
         joOn3GfW4K43NEgE7GgyyAlPsmEMA/xl3+3kVPITVbVtp8iqBSXby0bkBlwm7XrN/w+f
         JjdUad+nqXuZSjtOCMctEO0VOCcO1YEiVIp/E7LTTF8KqulzUrM2Fm6LZhFl4wFXXSFl
         j6HseBsg+5o2JE5DgYki4DMP1vTPgTIRmqpmqMReDhGQKi9+g4XYjUr97th/+1RbXjAC
         xhcjVI3B/R4HOCkB5UKswHeE8X9ibKmO54tZPjapsi3dT3cGP0maItrW416rHkqGrFYX
         e0tw==
X-Forwarded-Encrypted: i=1; AHgh+RqBK0aSqnBnrU5xYwGB6q3+Nj9i0Te2zZXXYQTRymSvSqDDl6kpRX6O0MvMFJm6WS5xvL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ryl8qiONCK+flI0HMQP7ctgwONjtm0yjUZuNdYKAgNsQ7k/v
	dKR/4PrVj06VagCWfaHetFWv7xgEKDMhDxr60C3r08tvhOxgvo4R2zKHu2g+iz4QLLf1+oWFrwj
	Qq5xaarGVyChDKdrWH8sQoGlVCcWp0vHv05nSCdmiwQ==
X-Gm-Gg: AR+sD12epWJQ9Z1IZLdtNFdIUocKm47VudH4cuKjzfn1mzMeBMkbz7ufcQgBsuGloKY
	HGX6ssN1WMyRKy+bM680vtJ0MaVIucm5tgaiQWz+7i4SkVu5JzXDtcSaV2PYvpKOz/MLrWSLTnI
	gbUx0XDT/C2Frl2bZyhEF7j/KMG59lUfuP0QTIjamc83Vv7FXIARoyN8vJmGiBqSVms8BalYtLg
	1S6zRMdv49Yo7u9Nq1VFNIHBfAzfeyz8kjZmAymW6zUQQm99UCExgobeGmIAEg8KluSPU+9qGgU
	xdc7jjC6v4oDCXdqQFvKUswjmxwEYwohLUCCknuj934=
X-Received: by 2002:a05:690c:7247:b0:81e:4aa9:d025 with SMTP id
 00721157ae682-8201bc8540bmr140247857b3.6.1786106072144; Fri, 07 Aug 2026
 05:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <490be76befc4689d463d472829c0271351b69a43.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BHLHGQxuG3gO+nCa-FPFyOFEU2rk_oxLtFjekLqENvQUw@mail.gmail.com>
In-Reply-To: <CABPp-BHLHGQxuG3gO+nCa-FPFyOFEU2rk_oxLtFjekLqENvQUw@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 14:34:18 +0200
X-Gm-Features: AUfX_mw390pE6E47VmmaiDxFnWnwfvHgM62Azn1u2siHkcYAjTK8bv0NEaUuou8
Message-ID: <CAL71e4Opn3u6qYG9xhhkB1qqYj9ZLk6_=fxznyFzSFbrh2BMTw@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] commit-reach: add trace2 instrumentation to paint_down_to_common()
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 05:03, Elijah Newren <newren@gmail.com> wrote:
>
> > Add a step counter and trace2_data_intmax() call so that the number
> > of commits visited during the paint walk is observable via
> > GIT_TRACE2_EVENT. This provides a way to measure the impact of
> > future optimizations without relying on wall-clock benchmarks alone.
>
> Ooh, I like it.

I will need to credit Stolee for this idea to count steps instead
of measuring wall clock -- but I agree, it comes in very handy
here.

> > -       test_all_modes in_merge_bases_many
> > +       test_all_modes in_merge_bases_many &&
> > +       test_paint_down_steps 45 2 25 3
> >  '
>
> Whoa, what?  <Digs around for a while.>  So, this is really confusing
> at first to a reviewer; it makes me think you are testing that you've
> already written the optimization and that some forms of commit-graphs
> provide a speedup from your work that doesn't land until later in the
> series.  It might help if you point out either in the commit message
> or a comment here that this code is just relying on pre-existing
> optimization where a min_generation is passed and --all is not passed.
> (In contrast to below where --all is passed, so it has to dig deeper
> with or without the commit graph).

Yeah, the numbers are a bit hard to understand here -- I could
add a comment saying that the min_generation floor optimization
kicks in here and this is how it behaves for:
no graph, full v2 graph, partial v2 graph, v1 graph
(in that order)

So it's not about the new optimization, it's adding these
counters to existing graph tests.

I am not sure what the best approach is here:
skip these step-asserts for graphs that already use some other
optimization (min_generation floor), add a test comment,
or leave it as it is (confusing for reviewing now, but perhaps
not as confusing long term?)

Thanks,
Kristofer
