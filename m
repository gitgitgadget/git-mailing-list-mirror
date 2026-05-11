Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DEE363C6F
	for <git@vger.kernel.org>; Mon, 11 May 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521552; cv=pass; b=B77c53oytDzjEbeW7oysjoDX2yMQdBx8tHxwMB4u7H/npBdqJ/nXHtXWoRzhbHKswYccRtT3X3okzDVJ9+vnBwtFoXe3iT79nMI2mYkYLMTZ/hs9w/DJzfYa4J6NfGYlx+RtuJgbZvE1bTYtoQ14WgkUv/7UgfkXUhz6Bmzkgq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521552; c=relaxed/simple;
	bh=q+OuyYiOfWc8IFkPTq+uob3bblA1ipHuX8qig1D1Mvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0XDYtDaFUxGp5evqnuaeje2A9Lx/6m+MRdA6jrwXMneS4KoqVbq2ihWGdxpPNojF8O9GL586P6/n0UhhazOFEQgoukBGv0pcQTcUfpyUxiLIPaOjAkCMr2SgPrGnavuNler1Xgjdi5y6ZYCMmO9WX1MP/X2E59gcnmA1pqhImg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYsIs4qZ; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYsIs4qZ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-42ff0576868so2077414fac.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 10:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778521550; cv=none;
        d=google.com; s=arc-20240605;
        b=aXcFpnNekr07uSEzGiwAi+AK+1duS8xtzi8zS48kklhG+0zWaUY5WWqSYM5uOoqnDh
         yXr/S/Da9kpTqPqkT+sS0IjKOVaOgpzopqongqiO6SooVP8BfWqa/dX2z8vwRw8h4qhL
         EDLFutJtwKh+ylUnNf97qNM4GKqfSoY82KwhvuVYoQIRZqQWDTs/b/P48PGYenQlER1U
         fRCE5CvbuqxIhjwNcOawZMaOIZOzvZkkxEea2tJ4/zGxkKPjoqSWpbzIdgVzUY0TCtNI
         jPxspmelaX/z3LhJWwLspYJRhhsv1hqq37tQjuGj3SyAZUb/4QM/DknscHg9GDETJRmt
         9o+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tYHO1N68YKs86MKtHWwY5XqIl894AzJUvvbnJovXxSc=;
        fh=W+QeAeLPFF+JUzpPXVhbZhreiYKdEhnTg17FhyfKTR4=;
        b=IG/2AMvAmaG9xCNN61YGMT80PzPIroCjGiu3ujQ7OG4qk/yb1IlXJDw5qje8wyy3nT
         j9mGs47Qb3Qa7vyaHXj9DZPNey64jMHyWHiIgo2ZHOt8UdVfzqqmcfGubDuekzK8aHWy
         hfG9VlwZ7qhuTxVd8WvCfcm0IHnyNB3bcmV8aD8LMciBE9F6C/pXlKLUAHJN349j1PwX
         NxZXZft32lsKCGjYghSqOqtJk5o9uQpwdpe2DMq3cjOgqUZPZG/UjnoHz8CyXUB2iT4h
         tCClU3LJ/r7goxsnf4p9J2TLSINHy7ahr+edP+WYhHV6PeRFgPlhHSTocKW+DzsI9vUO
         8EXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778521550; x=1779126350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYHO1N68YKs86MKtHWwY5XqIl894AzJUvvbnJovXxSc=;
        b=oYsIs4qZ8UfvdckcR4KsILN+25GKSZiNi7p87UGMAAXkIe+wG6nVuft1TsJxZffBL4
         hma/h1vsY6KnkhJkfkSfFZpBAU/fxs2KMFNVrIY4sgbcw/q14zuTD9WWB3PcnrFlokvm
         Y7pg2btv+d/5r4QxoNcPsdUPq9ihL3P1gWTXuSjejoiUNcbgFV69G+it6OWhwD4NZAxe
         yoXN4QDpdajUwe8P0AOvWMjJ/1R2fndPZMH7Fc+vDvKIZLYBF+lpZufOrM0GILC+9Div
         +rJYbs97ijI8SJh6mQbOsB83gJD+JK+G8v4pJcaCbCdrhjWZZsli9s9tGwNuTqI8m6ro
         qcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521550; x=1779126350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYHO1N68YKs86MKtHWwY5XqIl894AzJUvvbnJovXxSc=;
        b=Vt0+C/jt/zXcMFfafv8h8C3PcE9KnHR+D/flT/7L59myi3TnzTBYewU2j63hKR7V8f
         bL06sV04bOlOWmuzt+Ak5li+nVuhmpaH7vb/zitn9s2HvyyNItW95UgE2CzMuw9Z7xhc
         WsTGzDoteBoG2mQO+r7+8lVhEvgFVn1SpmmpGjtweMJUMNlxlcsGASnHiVGrqR0f9PXK
         vEuxeNz57CbmA/hwBZmeRLwtV31vXYc0SZYyWarRMLeqrc1b+mSz7ZBG7DNC0vsuX4Us
         RCrmlf0frgVe2QXX2xi8a8sNSXUroDZdvTph0tZ7aA9CVfD7c7NAuCJfh0F0T4mqA9UF
         zx7w==
X-Forwarded-Encrypted: i=1; AFNElJ/SI/uxftClO7AXOcEZl6HZ/9Gg+JCOd5QuNu/ZiFjpwg2sxWbui5KoR3aJkGD6fkzdqzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0K/k0d+m7EkmDqlrAF4QFefuSyC466Yw+fRJ0klJ6YfvH2hOv
	1MsiRD84HJ/NXzfT9txZASjmmPTwMho8dFC24jVm9Av1ObLz5xRmb4GNpgs1T+pNAsIvBdJ9NEM
	BTRIVKeevrRz38zKu2l+JEaa6NyrWeC8=
X-Gm-Gg: Acq92OGPrea7vqp2IRQTij7fhBV4UcxRpmTrSXbXKUrmTIHqU2x9dtcEXetG8w2TdBR
	3XHxA+zM2itL3CCzB5VInuH5bMH88dzlAU3n0J9/dae+qnS6Aq7LCitUAyo+qmIoxPTfXqqvZ9m
	6f0H5YY7Y8tbnv/TCWLTrnVkzFYiLG0IzPiQCSNISFCcyuLs/DGg5VR6+jz2YlHt+x4aDWmTB+3
	nH/i3r4cNLy/YZt32b5o5nKA8xj0gtOQO7Qgyi8CqtksFgyThHjctfa2ImEpFhrKvN6A5EzfL8+
	AhLqkWc7cfDMTAoR3HJopa+HGXwQ/9CZQZ/K3hTNl4u6yxlgtJbIsbPIpLPC084xrEhccZzjbOE
	Tp7AIOvJne9eQayS6lG1qCZv2qg==
X-Received: by 2002:a05:6820:1625:b0:696:1814:717a with SMTP id
 006d021491bc7-69b36d95a0emr4955050eaf.47.1778521549816; Mon, 11 May 2026
 10:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com> <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
 <a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com> <xmqqtsseu09t.fsf@gitster.g>
In-Reply-To: <xmqqtsseu09t.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 11 May 2026 10:45:38 -0700
X-Gm-Features: AVHnY4KBj8xzWqQvFv4ZhCwwmLHslBlIzRqi2BiB9TyO1PtE0rOkfO0qBLXp7FI
Message-ID: <CABPp-BFdYjnjhSrjEBf8kjYYY2jtrQ_=w0jYR+DDWh3szmtvqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git cherry`
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 7:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > Ultimately, _this_ patch cares about a diff. Could we compute a
> > "diff prep" computation using the core diff library instead of
> > inventing a second queue of results for diffing?
> >
> > Patch 3 cares about a "scan prep" which cares about loading all
> > blobs for a given tree with respect to a pathspec. This is very
> > similar to what a checkout would do, though it ultimately uses
> > a form of diff to find out what change should be applied to the
> > working directory. Perhaps 'git archive' is a better matching
> > example.
> >
> > I don't mean to make your series more complicated. I value what
> > you're doing and can see how your current attention can be used
> > to make further improvements later. By implementing things in a
> > common location, then we can have later integrations add to the
> > confidence in the feature through tests covering each user-facing
> > use.
> >
> > I'm not sure if it makes sense to attempt to create a universal
> > library method that would be used by builtin/log.c _and_ diff.c,
> > at least not right now. I'm most interested in having this logic
> > be more reusable in the future without needing to move code
> > across files.
>
> The points raised in the message I am responding here, together with
> the ones in <31763514-2602-4d8e-ac25-70590f090947@gmail.com>, remain
> unanswered.
>
> Should I still keep these patches in my tree, hoping that responses
> may come some day?  I will mark the topic as "Expeting review
> responses" in the draft "What's cooking" report I work from for now,
> but it has been quite a while since we looked at the patches, so...?

Sorry for not responding sooner.  There have been a number of
incidents at work (including a big problematic one the day Derrick
sent his email), and I was pulled into both firefighting and
remediation duties which have sucked up all my time.  I owe responses
to Derrick, Patrick, Johannes, Phillip, and Taylor on a variety of
topics.

For this particular series, maybe mark as expecting a re-roll, since
Stolee suggested adding a test on patch 3?
