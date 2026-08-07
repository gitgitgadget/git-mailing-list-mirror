Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE194749DC
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106447; cv=pass; b=lPEaFVu6ANi+Bh5ax7krwAFTWVEc6t5i0nHtb4t2u1sREfVIIg4kk6tj7n6mUoux4Wheln+iBb7uXUoJHFDE+/y8m1bSZedFM/KecD2UYaF4/rrFZv/mnLgOmFnfA+HWkZa76wHJ/6r9q7gYsqo3zPslNcjqAGwvst7LIpqG8XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106447; c=relaxed/simple;
	bh=cskS3jpGCI9k0yHCtf1rMHVDff7+HHC7SehtnSy6zN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBv0UfXiNf0lvPahraSZ4hSk1CBJRhZ8opnXvX4I/0/C430l+d6/gKK3oxAkXPMg+Ng+lRC2zFeux0ZKqmUb4y5UNFhxo99NAV7n/ybMXVYxE4rNiRS6W627alb92UlrXwgHRoR1kcSyVpTiWV7JbSLmwA27P4Wptj+YNN5f6Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=AfufApKr; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="AfufApKr"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8111c0c7561so40676447b3.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786106435; cv=none;
        d=google.com; s=arc-20260327;
        b=jtll3jGDxtaA2n7T7zRznH1QhdyogPlOavg+mk46wqr52RT5vyUAAku/EnO44ZHZLV
         JA/sr8fMpTaXMV0Fswb3Q//4vDQTIx0tmcLnb2Y9aZoL7o0n4fKpP5vJWnmD6r1gL5H6
         2OmZ6F0xLg1wY1ab4X+Fr2sogJ9WWRvoqo2JdWrMdqu+bk8w2S7/ZTeH7iwTBGdp6kML
         AY4b5NwfT0Z+cnGLJAJ/jyzjgK4MAEneT2akZUck8oZYHtRt9R9S8vjSYNgF0do35cUU
         ykkVoy4SFJpXJqsZ/T9VSoI7ajz+8h9FxtwnZkFSzINTPM6pz0drdBqaq8O+xVMw1OW/
         83uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3j0a2pBHs3s4KyA+DSS2mUnwjk3+vrFXbtlQXh6K2lM=;
        fh=5FG3k1yQHjO6KCjJr6M9bwLid+ZjVFfysAeAU/ZOQtQ=;
        b=Z9qsG/sqItHKXwUvjlT0jtbtHLazvp2rvdGTnrG54Jj0ZCIVA0DNbmYlp1hBIg2hA1
         D9iyhUnvpTfzDpUmpPkqYaAQQz6p0ztx8bcBb/r9gkbiGd6zGENtShfJXLtK1WhmFF3c
         yC1a1VLBaxEYg3EIh6s4yq6+ZpFy/uNy0427BqXNN3QaMsoX5YYeC0g6cT3RzfqKLT/F
         y0IhoHIF6bpp2Md7UKlVouDF34wDCyDVG47HCg9QQRZQOobUwJO4MH2SRvOlDcdnQqyD
         efxuXxPsfb0Y7mTAK+yKPr00b9nyL5bcK7s9A4FvA8maFkC/ioNwJkSkdNlRE1Jj/9b8
         fb6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786106435; x=1786711235; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j0a2pBHs3s4KyA+DSS2mUnwjk3+vrFXbtlQXh6K2lM=;
        b=AfufApKro2PSgf1tiLRW+hBbUjEsjOEU5LU6gfAkT6GJ1ZM1hI01WPvSCx8P1dBNjz
         62W+cBgOW0YERvfSG6aVFh/6WOU4aqzId3iGr5LTFTYJu6ja0I0pdwACDqvAON9f/RPc
         2kYy0eM3n5+tkoeLBfBVHx2eN8iTBs/j4BpTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106435; x=1786711235;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3j0a2pBHs3s4KyA+DSS2mUnwjk3+vrFXbtlQXh6K2lM=;
        b=RTcMkosBrMViTpC3cJIIKysvmZK/pigK32u5mEv7GhY6zVZiCGMQc5xXEgVF1bZfe0
         p0agUjDtzYlzyNHqeiyrSTexzhDfVVNnnCujAErPRCFaWtnFcuvl55cqjdezXAUiWfNb
         g14Em2ksmyvJBU4mHTt9TSUuI1etVmGjCWXNGLZrAIF4lRvMWgj9N+cGQOSYABkme970
         9MDQ+rVTPSIdWJFl+qm79AqV4DLaRU9tJbqracXPzjyrg4lsTncw0rtv2Y3l9irEiE36
         TTBQSDuUfFytI4ol1qkQApgCcVVG00KUJYoUEEsLfwXocBBoruq/R6HGwbMdxstvYWkQ
         avjA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8aCYX/VjVsE4rQDXk9K8+zrIXj3dFkyY9BNnERw+DYLsSBj1M4C1xlebdSJvwoyTNQoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuJX4WaLZy+yYEiUYk0isIWWHMbK8aRpcK/lHIcnfSpswNbqw
	0uMnUbTWRSC6y7C/kPruqvBoUpLfI4r/nEzEMeQnRIJW6WIN81fBYwZCmPsvSFcRCg6FOA38Djw
	B2g8TBhx0WZnvKoDapMhQ4FW3OhuISMDtwJRJHa64YALDvXoXufzxvhGqew==
X-Gm-Gg: AR+sD13JzyJ9l+Ek/85yqpVYdaZPy3kY9k6gOt3ao45/DVc4LBelcJdWtO+BGF97COO
	bE+MOAyPpfUvXOAs/w9h4BhfhlFiC99GqtDjBdVKPxYZ36gW14XKpMy08Sg3y+HlQP9vzQo6JHV
	pqgwHCW8XHFCKV5rG/Np+9YBXuvCvoFNHRfFlPwUgf9ZFOPDWaHV0vI3gIcfds5gwlyNY/rISjF
	LRapsI8+IyOPhUxxAa6FmA+wixkbQqTehKlezPRgPBC0+yK4hrlIGEWArxM+PdbuukqfvOCd5H4
	oRWVHdRZWJiBqR4iJ6Nfm98jXjkxCS3I67kR9QFQEQ0=
X-Received: by 2002:a05:690c:6081:b0:7e8:a091:6c4b with SMTP id
 00721157ae682-8202250b677mr123378647b3.24.1786106435066; Fri, 07 Aug 2026
 05:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <391fa07783a7819a60c0b0c2a3ea86fb13c95079.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BE=MB-j2HOnZEFaf5wrdBz329+J1AKwyRWFwjP-5iao-w@mail.gmail.com>
In-Reply-To: <CABPp-BE=MB-j2HOnZEFaf5wrdBz329+J1AKwyRWFwjP-5iao-w@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 14:40:23 +0200
X-Gm-Features: AUfX_mxxXZZ0iwpTbPgNUVC8TdOhYuQgsm4RmphpQWfVfVhsmWKPek7umd8M3ag
Message-ID: <CAL71e4ONrNcOh82upp8YT0b_0nZhxtEv_zFDb_0Sknfc9_kJWA@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 05:02, Elijah Newren <newren@gmail.com> wrote:
>
> > The INFINITY gate ensures correctness: commits without a commit-graph
> > entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
> > which is not topologically reliable. The optimization only fires
> > once the walk enters the finite-generation region where ordering
> > guarantees hold.
>
> What about GENERATION_NUMBER_V1_MAX ?

I am planning to rewrite the documentation to refer to the regions
as (topologically) ordered vs unordered (I think you coined it in
one of the other emails, and I quite prefer that over
infinite/finite).

I guess I will need to rewrite the commit messages too, to reflect
that. Hopefully fixed with v8, unless I miss something in that
juggling.

> > +  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
> > +     remain in the queue, no pending merge-base candidates exist,
> > +     and the walk has entered the finite-generation region.
>
> "finite" or "small enough" ?

I think finite was correct before, given that the alternative was
the infinite region (GENERATION_NUMBER_INFINITE) but I will
rephrase this as unordered and ordered for v8.

> "In the INFINITY region" -> "outside the reliably-ordered region" ?

Agreed, I will pick something along those lines at the very least
(maybe exactly, but no promise yet).

> At this point in the series,
> Documentation/technical/paint-down-to-common.adoc does point out the
> GENERATION_NUMBER_V1_MAX issue in one of the paragraphs; it's kind of
> glossed over in other later paragraphs (as I highlighted above), but
> there's a clear incongruence at this point in the series.  I'm
> guessing you're going to fix that up in the next two patches, but the
> splitting feels a bit off.

V1_MAX is introduced before it's referenced in code, though I think
it's still valid as a concept for the existing docs, I just need
to be careful how I frame it in terms of the implementation.

I will do something here, though I am not yet sure exactly what.

Thanks,
Kristofer
