Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B330216D
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055584; cv=pass; b=Ms2bzx8tfpQo7kQQojmA9urwGmDpNsCpKBf7emNfhGBDvR3fBmjaSjSDm6Uuxlu4/ySHXicTD6NjoylLOKUtxv1uPZtkV8UmliUuUzYqB/vZYTc8qaFAhk/70kW4G+psbvH0dC2cg4SQMulxW1CxVElm1N4foxUoEQtH0fI0Lc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055584; c=relaxed/simple;
	bh=Qi2TY/WX1qGf9MAjC9xrYrV12ZozbxfOfIg7KE+x1Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak6aY7/wkPq4VaH8LmXE17LtWDEg77VQGL8r+1XYZNpm7qysWYWIkqSirqSPHpr68VAXA4/saIgCmSi6R8dkKN3lr+xXJhBviPPbvoWpuOMxOUcdnNi8Y8pZDNDySPGu2p/LVj89fo9Jh+B1i5MF53zQ1iJp5OyQJJPMaaosCkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=KUM7jdKL; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="KUM7jdKL"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67990a45e02so1540326d50.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792055582; cv=none;
        d=google.com; s=arc-20260327;
        b=Nmrb58L4YbOPonqT92P+Vgtrb2+xokwLkdm4cSN6Ilc/BfK2j0HaWWiUA2mlLwm7D0
         kOkFZxEAw1iX3GBo9LARKOkt3/XMXes23lvr0Oay/kqsje536bEOE+IHpHWRED1pGUDm
         Atw5nAzXwYY2tyfu5O53CLUcS4sb/9nGaaXv+J90uZ6cfCszWA1Wg7R0ajJafm6Q8ert
         6yriksR0E6QqOjq6ijkZ59eekeR0rEcSU5utfBoNNubPAYTRQ2zp9tWo3XAnMQcgE2tm
         ElfSpM2ALON/FaSyY/MAQqW0fCcJV+O0IIWeqFInsLvlWxZEcsS3fYF+7GDZfdCy2W7D
         ILLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BeXKT91oE1yb1plYCTPxQNi2UhIZaZ6xCC1Z5AiN51Q=;
        fh=WGPRGJef2NnUFTBL0++UDCwzrB2Az9nbDODynPCukg0=;
        b=UqVSKQyZT8Nf08sqwXw3Px+gQnoKgnPqGV9o363jtXHUcJkUErzpXcBDXmAd4IKLn6
         cPBriDueVgKzIiwxiqEKXeiUe64DK7yqQPyacLK3EGF3RS+B3aPPYyP42FE3PLZCt2B3
         DNFdGmKiRfdHWLcGO8W/kkN6U2PL5fLMOrqNTeXljdXrRI8QPNgjOiqAWe5xj1fqh4iL
         FNh8YL4Ivka4p/BCmYXE41sQo8Hufs+Gfh/7WZHXFlXIyZv6wspQ2bMbBOgjUHc8v3cY
         4SBv3SYDTKft1qjPvELfXsN2KuAfmeDfJgj4+66dt1oLCYhrN8zP7aCVWoIgu80rZPHZ
         dBXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792055582; x=1792660382; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeXKT91oE1yb1plYCTPxQNi2UhIZaZ6xCC1Z5AiN51Q=;
        b=KUM7jdKL89fiaIYsPc/LesvTqvKXp45vEFoww8Y4CZBEavhP5bd7yc6+2Zobp+WtYm
         /+tGjkJQVvh0+FSdehussDpIWcComITzd3L/3XRcv8tLXL5uHG1gKw170WrswyvNCW1K
         r8TRnjYFdbEepc6LQUkiFNoff6MUQlsBTc2/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055582; x=1792660382;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BeXKT91oE1yb1plYCTPxQNi2UhIZaZ6xCC1Z5AiN51Q=;
        b=I+u46aFqRIxhk5NyuGDcr6p/rh0pxXyj0b1I81tMBL4o7wjmK37JdAun4i5p3J2vmH
         xhZaacc3ggNjBlJws3XlUJ6ebqZgjzQSfU88MASnFyR/R02NSGOpLk2CrCwMyhvrU/LM
         P1GE36W/GcioSNM/kJeKFLtKj08tcF8bB9HjQ883K9KUT9b30VuBt1LQyLkcyRceuYbO
         3TA7TTc1K3ktFAM5sSCaBgLM9XcOv3xcJOUxE+CU8Ha2JT4ztZCeUEFa6EdPiVm7FEBt
         UlrAkkaghJAxqeT46kZq40BRdjBuESXNbFH0UN8GFZ+RbyiJZS0EsRPzj/MD/u2YNe0V
         4+kg==
X-Forwarded-Encrypted: i=1; AKwUvBx33kz3U95tnUN+UbUdXa2NJMe7+CsAdLbKG2kvY7iJRCsBmqSwgmdVmnAPNkRupuEXnMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpjp1r4rFmst2GU966gs5WWOBS3kMfNxoQZ8B54uCXKTn2jSV2
	wKNQc6yEEksbtq/GW0Wc1I+OlwnWt6BIVjpZEEJvaQ/AveIUVutRFxHgNADvQ8DaSsUuV4zvJPx
	/mBezHxoRM356ocjAPW4z+3olxMmVLurjmKCz6Ac/3w==
X-Gm-Gg: AYBFou2wG4lszKQJXsqUGDlhRqHjfn6fXcUXx7zk/rF0tEE7ltsWlhCjOo2GgUQ3zw7
	ziNy/M69lf+V/NuMyQOtMEdOYJTNARrliaaUViGdwEMiJIFoWJo6pd+UZWRxxP4XCuTVwg/rjK4
	cceZM4DQ8G5dGqpAWcl950tAG3WaE2igPoAd/uAwBTo1kbjW58GuySiDvjEE7fOOsc7VQrVGtAb
	8+4Vi8AfdXMaTrh2luru5/ugj7afTv3S8wRGtJ4BacYvINMi8wdy/wU1AxIFGXaXcvnBvEZiWMJ
	0MCl3T/8VA+p0qedE0gea+GYE5Sgg23VHjpWSdqSFOY51tq9JVm/WLA=
X-Received: by 2002:a05:690e:4146:b0:677:a004:4c38 with SMTP id
 956f58d0204a3-679369ec4f1mr6476892d50.44.1792055581589; Thu, 15 Oct 2026
 02:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <19ea8cb534f0aaabdf21f358364ad32295b6bfc8.1791806877.git.gitgitgadget@gmail.com>
 <atB42M2GJ3NitXdj@pks.im>
In-Reply-To: <atB42M2GJ3NitXdj@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 15 Oct 2026 11:12:50 +0200
X-Gm-Features: AclHuK_xQM3fz0Jlx3M5jY0ZTg1_x35-htj6VWgtfXUsRbM68cknnMDLSiyeKEA
Message-ID: <CAL71e4O0vG9SPz9gNP_vjp-1ftSZ9g8RkXRvvpTRaA5+Q1pwsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Documentation: describe connectivity checking
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 08:55, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Oct 12, 2026 at 12:07:54PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > Add Documentation/technical/connectivity-check.adoc describing
> > the connectivity invariant and the full connectivity check.
> >
> > Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> > ---
> >  .../technical/connectivity-check.adoc         | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/technical/connectivity-check.adoc
>
> Shouldn't both the Makefile (`TECH_DOCS`) and Meson (`articles`) be
> adapted to build this?

Ah yes, will fix for next reroll.

>
> > diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> > new file mode 100644
> > index 0000000000..abef02debd
> > --- /dev/null
> > +++ b/Documentation/technical/connectivity-check.adoc
> [snip]
> > +Full connectivity check
> > +-----------------------
> > +
> > +The full connectivity check runs a `rev-list` subprocess, feeding
> > +the new reference tips via stdin.  A normal invocation is roughly:
> > +
> > +    git rev-list --objects --stdin --not --all --quiet
> > +        --alternate-refs [--exclude-promisor-objects]
> > +
> > +When promisor remotes are configured, a fast path based on
> > +promisor packfiles is attempted first.  If it falls back to
> > +the `rev-list` check, `--exclude-promisor-objects` is added so
> > +that the traversal does not trigger on-demand fetches.
>
> Would it make sense to document that fast path here, too?

Hm perhaps.  Or I can remove it instead, I think it depends on
how detailed we want this to be.  I will take a deeper look at
this.

> > +The traversal then walks the trees of the boundary commits and
> > +marks those objects uninteresting.  Trees of incoming commits
> > +are verified against these marks, stopping at objects already
>
> Nit: "verified against these marks" reads a tiny bit awkward. How about
> "Trees of incoming commits are then walked, stopping at objects already
> marked as uninteresting".

Agreed, I think that would be easier to read. Will fix.

Thanks,
Kristofer
