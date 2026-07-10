Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6C200110
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695824; cv=pass; b=oJN7QC64j/KHZOCj5OmoQWyCecbsMHl2Pb5S+6GS7qgRUP3+cSYeTIU7tgSwVtm4v4JmapyZupXSfKF7HA7JXY+uceO1RB7B6ZkS4AqV5MsLYWsx6G606RcSOrOm/tlKNFFl+O8PBu0HUSdi3fqvaBdFjB8m/7B6vbqTqt3fK8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695824; c=relaxed/simple;
	bh=FeqPehOqH2BiSwBp5CkwM6zwpS49AyWcJgvn3R1a5BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POEvrIXNsqYG2paKxge5oexFOgahMkB0Jp4p87+hQvNyEqzjHLd/Gi6RMSM/ivX6zcFlSIpna9sm+nvNne/IMe2/4yiURPMW28Y39kl1F0DN/MoE4d4ryVACg8l+HthH/pnIESIHBTIHstuGBFV4wBek5SEln2Lm1TLAaYgQVYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=IT/r2n6M; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="IT/r2n6M"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6611669cd16so1488002d50.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783695822; cv=none;
        d=google.com; s=arc-20260327;
        b=XZsBVluWMqsUXrDZ1+gteq3jYr9znw6QtJwbbQCph9UVdJ3SR3iB3ckpkXk1MaueZA
         JKj1gIAGy+r1J0gLD03kFnPUpXxgd4ZtmnWzCn76WLiGhO5wn9Ml/uFvD15DGtWu+ekl
         Dhv8u4pFcwQiutsGpR361j+jT2MC9vtdDcolmTbjPDkaLuXI9LSPNkt8onbIrSe2Jz6D
         TQS83DdJgh6dnMunhEgVhS0ll/nPEOHRRjM943/8WIExjoutVSSnO9mVnkQ6db2bYQ/C
         5WyVL4FMCMSoUe1yCjHmHHHkhJ+nuHIpsOyGOYpqgq+1UEYtoxJY4IJx0AkgJD8Rfo2U
         ZPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b0VfQ+W+X/QzQ/GTnNSNAMAVPJ8VNCEol7NM/YA9i/o=;
        fh=LQxUhKgAQB7PmSVkPtRVUXZQnA0nOfcU49Wj/8QHTtg=;
        b=DEFeJaX7Z0/VS9ztC1ylQV2Qlzc7UaRuSND7BBzBsyb5WlRneRekSLX8lN46sCrS80
         VFSrD0h9VrgHYM8Jlv0aXKucVUrZSAW1Ja0wak/bcChamln+LD7kyS8/v1jdLtIv0+pk
         sOBTPiWEaLAauETPdcj8cEKprR0APDaPnoxk/lqirj5kj5atxSkMS/TqfP/59ot8w/mn
         8SIu+GOVg6gX99aIvmG4/M/a1UXaz59yCPZy+Md4mJfPondAYj01qpfqd9DVmDbfSf6O
         aREM+VEeSmQ62+ez5LS+CqtUit7ezxYcZ7NcLvF9MVquOlYZHIJnZDo8q07mXvRJNrcf
         vsqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783695822; x=1784300622; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0VfQ+W+X/QzQ/GTnNSNAMAVPJ8VNCEol7NM/YA9i/o=;
        b=IT/r2n6MTgAgRgfAgT4mEx0/q/UAm5jCuMqNNQPsD9+tnwO2xTHYsIj681KcZx5Bsz
         8TTeQ+3VfGmY2bcwCRxp+ShhqDEaYIXK2ju37vAuS7/OSASBSkb2RhW5I4lBcFYFKcIm
         N4d5t0SX94pyyC23WhsVE5tzMwwnADTvTaweo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783695822; x=1784300622;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b0VfQ+W+X/QzQ/GTnNSNAMAVPJ8VNCEol7NM/YA9i/o=;
        b=ls3aRH1YNZgFSOnHl072OVMusKsxxHPzoRHnsXJy/Sf6lz47osSjBvORg4z+D/nMlf
         qiM3TC9HHzt1noYhso6HyDKv1YTCYHhPP8gAeRBowVTYKuExBffNayyxLxZQCDfC2KhL
         N+Rwz3q8zqdcNBuqbtXVDv+PgFxNK1Kl3MbFixQylEvGheBfw6ehJLT2OYiEMDdevyHm
         0wZI4jP64S0GvSRRU3XYKYoe+foC7VPwQW6M6KfF3YHcWahX6ipeRdi/GEO/naMmNPYo
         gZLPlwQCtys9px2FIqC2drIRyFuWgyOIiVpaUt+LZLPwD1bVc0sQ4zMZYhkWrRS469Ce
         x0Ug==
X-Forwarded-Encrypted: i=1; AHgh+RoJV7VbMT0Q9pk3txxmsJxvGVIdU3Awf2siUIkWX8aROl/I0vLVDlavznqjf2SPF6boN6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKzO23/V/LBHZ+zK7irrkaIqmUdMTgrpAJKah25QPslHM31Z/
	mxbuWbhdihXyW9ve/Gn9wmF+2HZ5DSqBfpfFrCuZs+0u2mRM2nUIHDYYwcmSabTSfscZH9e/26T
	d4TwNtkq0ib8+eM4oJpgnboCw+eTdoxXujx0oVoT2ng==
X-Gm-Gg: AfdE7cnJ+qesfhT/bLQYVis8NbjkwDjAGQT7nKfxbwi+sh0uqFGb6JZKJUxjWZtM+hK
	CmGEB8dosaHghMgLsSrphjrPZiXl7mm3Pfq7+5WeixaedvrQKikJYqItrNqklDWiguNGlAr3mUy
	wBUMgAwjM9u7lM+JrjfjmWslTAF0G5qvn6tC4wJJQBBC4ox3vajrngAKrdSIY56pgrw6jjPyzPb
	RLbERAWDixXwqMydynuwB7J/1vEGJNIRJo50SvGpJR0+RUEwScQbKFTWhfFFCEzy5YMv3E3kw==
X-Received: by 2002:a05:690e:138b:b0:667:b7f0:e70e with SMTP id
 956f58d0204a3-667b7f0fc57mr5087642d50.1.1783695820726; Fri, 10 Jul 2026
 08:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
 <pull.2166.v3.git.1783679767.gitgitgadget@gmail.com> <4fdcec84406431d56b7a7e593fd8e843c3b1ad52.1783679767.git.gitgitgadget@gmail.com>
 <alECc90WZ9RPqMaA@pks.im>
In-Reply-To: <alECc90WZ9RPqMaA@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 10 Jul 2026 17:03:28 +0200
X-Gm-Features: AVVi8Cd4G_xhhCpLEqxAf_Ah_k6iwVX6qI2x0ggrhYmw7Nm4Vrx0fUv8xmARlzU
Message-ID: <CAL71e4POhVpQ9FvLmjUc4ex_=T-DuCd7cas1D4uzqzg3RyDw+Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] reftable: fix quadratic behavior in the presence
 of tombstones
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jul 2026 at 16:32, Patrick Steinhardt <ps@pks.im> wrote:
>
> > This also requires adding deletion checks to the log iteration paths,
> > since suppress_deletions applied to both ref and log iterators.
>
> Nit: s/applied/applies/

Language and using correct tense is always the tricky part --
will fix if a reroll is needed for other reasons.

> > +     int suppress_deletions;
>
> A comment would've been nice, but I don't think this warrants a reroll.

Agreed, the field name felt self-documenting to me, but I will
add a short comment if there is a reroll.
Something like this?
"boolean: filters out tombstoned/deleted refs early if true"

> > -     new_merged->suppress_deletions = 1;
> > +     new_merged->suppress_deletions = st->opts.suppress_deletions;
>
> Yup, this looks good to me.

Thanks for the quick review.

Another thing I have been thinking about: should we consider
suppress_deletions a temporary stopgap, with the goal of
eventually removing it?

I took a look at libgit2's refdb_reftable.c to see what
it would look like. It doesn't seem _too_ complicated
(but I have been wrong about complexity before):

reftable_stack_read_ref() and reftable_stack_read_log()
already check is_deletion() after the seek+next,
so the call sites that use those would work correctly
without suppress_deletions too. (I think?)

The other call sites that iterate would need the same
type of filter as we have in this patch series.

So the total cost for libgit2 to stop relying on
suppress_deletions would be fairly small and it would maybe
also got a nice performance boost for the edge cases,
though I have not attempted to verify that.

That said, it does not affect this patch - regardless
of the future we will need this flag now.

Thanks,
Kristofer
