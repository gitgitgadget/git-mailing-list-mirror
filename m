Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072E37E5D4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878093; cv=pass; b=M8oa+c9AxTUbCEKszpNH36Qs4p3wSFy9lllKUc28khl/yjQR73Y51Gg2OLZIWEaU9cRyoYzwWmhizgGbvvb2K6Yc4cfAe9wMBK3Dus2dAkYigV6jTM6DMgrDGNyFmvkoccAl82gwlH4WIH4wdEO1q2WazqAXmUd9z2DqeOFhh5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878093; c=relaxed/simple;
	bh=lVSqLz1EQ8JfoIWWwLAu8YH+SAkuP2YL2uYf9UfvBew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF5AYOtHcr/VUabSs4nqVKKOct8fVBuDPu0PgbL2B7q94JNzeXHAJF3m3W2LV8hkJQNGph3RYTCLLA/btJy5KLInmXBFsJbTjkUvmghT3PEskYSpn9ydlRKqB15RRqzfw7oxRkmBgrEq4RITIyvKhNqrP5UZ7lIpI9tPACsDLlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=cavyTPc6; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="cavyTPc6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-888cbacf70eso30466667b3.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 00:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791878091; cv=none;
        d=google.com; s=arc-20260327;
        b=HD22VX7JvKqdds0Qq4Ig9Q8betN3hFcH5lFWMiXYyfQvAHylOsNQqqjB+Ucm9yBezF
         8h1hYk2oK3rRZToUabaFwJqHiyxWA2P7zNLE0XYL94sFlKyc1/rLi6wbpquexgFJzWp+
         uepVjM5XbjjUTEIMCTkbgErrj48Y29yMds7aTCqq2PWsU8ZR7P/w+EzTCwom9URTyyDN
         ZmwuAip6L6ouhm26QsOzMJFfa1+nsQTlae3Z/mN/aRLK4YEzoDeHVBPLZSQLTuRjOow7
         mJKt2Q6MsLbIqsshE5eUye359koVJpOqkiCrUiuvu5r9GSy4cQbJ0s5UWAmEQPIhuFkm
         RENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0CPZtRKnn+5vicSF4WgXdljfZVwi7obTZW3UEnsNj5E=;
        fh=A08OC8PAtTR4Th8tiJvhe4XDtG+V8seuLG5axBZB8hU=;
        b=LthfO8XDaQt8mXdvzUwkp0dTcgk+94fYh+v+GhdLkdI33spaIXeE5iy1zmgs0+Y3aF
         z2BU8DZBarAu5w15XljKTX68f1xQDcPykFnBwkDgI0/cejCo5AhB+SMeUfkEENH75qkH
         4YSgoCaaPmAhPsvmphyr/Ebf6WsLFeuXV6qvEE7VL+o5O9frOhPKkTIctqCqk6/XDCvC
         I+6mB70Kmr+FRdwSjt//qGCIyQIYacbCcYt2fwPdFBIZlGwlXoBBn8DdfizupttLqPK7
         IORC0wqU8ffqG8fUnam14YuAlhyJdK5KzlTi459JjoAsuvO3sJfLPhXblhjkoCZvzNf6
         47XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791878091; x=1792482891; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CPZtRKnn+5vicSF4WgXdljfZVwi7obTZW3UEnsNj5E=;
        b=cavyTPc6pwptAZ30Cnd0W+Uj7r0AtGP1VB/LM18f+oX/U49U11lxWIAKZvddtE6zb+
         /jOWh9X5AwcPiHQgR3TOHiYCDBFQnKGp9pGpf9odq1V4TWh56h9ATnKjljcGpBRWphyN
         j5kGgE8Se9qV0/CKIPpDL8J7rBp412AliF6N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878091; x=1792482891;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0CPZtRKnn+5vicSF4WgXdljfZVwi7obTZW3UEnsNj5E=;
        b=0kRC9h85qxA2tEWLGWO9VBmzX6mfCzeP7b/LCy8nhfLXZP55J4XK+mMBt61GPnZJ/A
         24STjn8ZsMNsMAsSynmNGjUVgqR8avdVM5n6etKp2lLsWACGdcCDMD/EclrL/se2kZ3h
         3xpQCGIzzozbqCQNHb6CaJEGO0NBwBaAwRp/KZm4paTUOJkRjx6nwnrThKHlygXlTd16
         WFkN74kds2jMZfv8MwlnLYtMY/Aqg1ete5E8nUKL3QmUZiVIAY/zOvQqxiV+eU+XYKrz
         AueOpYizhYfC4YvyMBUvNbkH1cpYj3X2vf8pE4AFVgMY/qWW0QOF4VRVB//+0Hp/MpUE
         NylA==
X-Forwarded-Encrypted: i=1; AKwUvBxiV/Ojt+Hyz+r1f+mFGm5Eb4PugUemQN6xaa1EyV0eMhWF1Ge22pwUgLuni2mWDtBaDAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZ4OQKPhHfGqMrEiZZaKA1DxLEDyNhVucIIwF3HWGoCrEnt5l1
	DbpI3OWTW/FmXJ9tGK7HqUjf+KwquiJG8P51fyL9LcT1P9lnyCJLz7LgvRsnoMrXCDJyhjKYMQr
	LGEEelId3hyEcHA+ryitmuHf2/DYnZaJ32VzINd4Gfw==
X-Gm-Gg: AYBFou1nr4bzCJd584REBmdJDA13uLljKFVpvKuZG3WqsRSape+ISogk6/uLsH66mtF
	rrbhHZCaL/4YU6pvRWMnW9XB5vV7/agK7e0iCk9orh642vs9WBhh1e3Qu0RNBrj+2bkmRaaMQPX
	Em4qBRXIeybOpA+4errCYvSoIx4gZvw6P1dPHkEiLsNa0KNy2pthQ+HZGRUbjRgDHiVJGKBEq7N
	6RCUH6ozKxaHkgB7vhD4d9hUcBtooqvd/kvjd6WkRMwsm4SM7yTDn2//v5wDFouKCD6NfvbNYqj
	ry5dgvbfv30mWWbaSIhDbC33EQ5jNCkDkpObMu7vJlN8Z5qpFcMwFlc=
X-Received: by 2002:a53:d3c7:0:b0:677:c582:b1f6 with SMTP id
 956f58d0204a3-679362b7bd8mr2227355d50.72.1791878090585; Tue, 13 Oct 2026
 00:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <xmqqzewi695w.fsf@gitster.g>
In-Reply-To: <xmqqzewi695w.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 13 Oct 2026 09:54:38 +0200
X-Gm-Features: AclHuK93myMW5f_4U3Pq7g3_Q128wMsVivREUBLViEWmp_usjR5ZRWMXgqrfdBc
Message-ID: <CAL71e4OUW4rYqxaGgcrsy0aqjRSdWsz8ghtNRGQVYd9Gkz4NgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] connected: add incremental connectivity check
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 20:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > I'll just mention a short summary here, to avoid repeating what's already in
> > the commit message. The incremental mode is faster than the full mode when
> > there are few commits to verify and when the active object tree is large. In
> > the happy case, the work tracks the changed paths and their comparison trees
> > rather than the full reachable object closure, which substantially reduces
> > the dependence on total repository size.
>
> This is exciting.

I think so too, especially since I think it simplifies the
follow-up where the scaling with number of refs can also
be addressed and I hope to write up some more concrete ideas
for that in the not too distant future.

> > There are also regression cases in the synthetic fixtures. With long
> > incoming histories, the extra parent-tree scans accumulate; in the synthetic
> > fixture incremental is about 1.5x slower at 10000 commits. Per-commit
> > ...
> > A safety net for this regression could be to dynamically disable the
> > incremental mode if the number of incoming commits is too large, but this is
> > left out of the initial version to avoid overly speculative code.
>
> Hmm, ... OK.

This is where I would need feedback from you and the mailing list.
I have been reasoning about this internally and decided to simply
submit the smallest approach as a starting point.

Now with the config flag in place to gate usage as well as having
the worst-case regression bounded in how bad it can be
(2x more time, not worse in memory) I was thinking it may not need
further protection.  I was also not sure how common it would be to
get pushes with so many commits that it becomes an issue, and that
part is fundamentally hard to know for git as a general tool.

That said, I'd be happy to introduce some extra safety net here,
perhaps add a fallback if there are more than N commits to verify.
(Hardcoded based on synthetic benchmarks? Configurable?)

One partly annoying thing here may be that if we add fallback
for the bad case, it forces us to keep both code paths and thus
lose the potential for removing code.  My dream scenario would
be if there was a single implementation of the connectivity
check that performs well enough in all scenarios, but maybe
that will come anyway eventually and I should not speculate
too much.

What would be your preferred approach here?

Thanks,
Kristofer
