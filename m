Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6A3FBEC1
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773240; cv=none; b=sLuubi5F6kgWlSJXC5aNej8/f9Gzi5teq5lN3nRIzWa36oWGsqH/zC4inEc/dwOgjilVM+53MDb6Ckrl3JPkywaUi0O616oCpzLsf4fnP1QVvVXPWZnwZ1k5CchJpCpKa8x36Fu0SUPFBxzolF8jD11gwXZJj2/nz7fDHOmm9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773240; c=relaxed/simple;
	bh=aXjUxyTqxpg8P3V2+AXKuEoccHEL5uWAlFkx9SbYdQo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYsfQ7ptB2NdyfIA2qy4dlFBVa+9Dt94vtp/nUpsLJMDWkQUwCkQNmCafNYvUFz91Fo6pSlXiZ1dDh7Iq5X8f5F0Q59UPp44LlPL8TG3wCtSGBxhVroOBpen+JB3letzdClUUaNcV8my7xnhmzgFvV3CLd2fHEj9rB3IV54vBKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtWaKu8a; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtWaKu8a"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8c94cefcdso3644269e87.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778773237; x=1779378037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsLJVmsFEyyg2EXvCiIJxyLxun+tWqJbmO39RQ4ZLv0=;
        b=FtWaKu8as5ymaRWWKKWxfT4iF+I6mB7QF+o7fGfpPl+BzaYBjQUFg2QMHNOxtyYRCf
         fdOlr31rmDwSgL+DqjP/M/pu0Lbj3seWkd/+pC2m/wiW5+ctGbIyMe15Cbh5k19TmTqK
         lN1khTSswtwcvWY1gLJ/ehJJm94btDuWObWrN5ZFVFom48EOGTw1xoW9rZgpTYcu6kPI
         AGfPGwafnjq5jhUIsaWDyOThXV6Njqau+a1xXnQ/uPQd/BO4P22JBicLv9uAaG+iA7gz
         8BwnMlvuCOPTXl8B+TckclNnqUZoDPW1cDsxSUxRw5WFVnFCkuXfuDBgv1ssVFV8zvX3
         mdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773237; x=1779378037;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsLJVmsFEyyg2EXvCiIJxyLxun+tWqJbmO39RQ4ZLv0=;
        b=p34y9ExxMH85Rke46BrdDr89eBzOhu0VxYJ+gUDMtqbTx6UU4ix/FCTtIUdnV41AyT
         HD+o/1KUtjHFVO/pymCNZWwZXSV5MWENEm7/YskhDQH1TdTPsN+5EIituzmcgllHcgs3
         Dj+JEunbn3g5NS8opCI8+jL5X7vYxulb3F8346CncA78zPEB9HKUHFtN3pANr+M8z/sI
         nCkfiFVMjsMsG3FSlbbZY7/xbRfEcGZ34rnYkbWW2r1RnokJWTpmkYmInJn2djSAV6sM
         zyQVAFtjLbmmC+9dbfYbv1gGO6sR3lQBO3IsAzac5xFX+j8XetwlNaNtZhTXpP7Dm6va
         otQw==
X-Gm-Message-State: AOJu0YxM0yDuzmbMiGuZBBHCblJPLFQ84ORTEWDYXOcQUiDZNSNu211a
	0N8cUTBMzzoqOP+aI//AWwp+KFv/0d8cr6X4Pj/S1GUbB73rCFOGx+ya7dQVbw==
X-Gm-Gg: Acq92OGHb59Mjvv8qX1l1PMxnHRU1FVo5W82v4nr2t1T0Wl5tkQA5G+xIKTNIj5XAE8
	T5uYt7Wueg/iJPkaTNsCEVM6seH0v1cVMxy2ARLtmGkz6Ec6JDkSKZEKKxzsRhxIIrS5vjgZUsj
	NMyCebR5kYoBXJuJwYEotqUFIgUyNJVgud62e2/Zk6ODyg9oTcym0aBO5P0gMaPPv0oPWr/s/f4
	Eeekac1eYCPKtsblve/ok7I6qCZcAFGuM+jl5axgQi1pz0guuTGmgnZXBoL+WZas51AFRdctiiu
	brtWuLXjjfkoM2AMSqrt189qqHsftPfFS797t+Dg/UTQoB2bIQg7T9KWJ/k/4B6s3JqPBjYKJca
	zz+WEpFsP5cw5tKmK11tCr5PkJt8nZN1G4ZcEZzgqI4XW+A/+vpEXjH7k91e6N05Tc/obZtSm/M
	oEUJ2n8f5b30XFiOEogCjnrzwGHs5X6VJ32RW3SZ34iRf06fdJE6YGFfUnl3K4TN8Ndbhn1LEDu
	oIRCzhoNthcdLVQ2dhCh3KWd1G2iBmhRlY3F8p+UJcViQGDqGutVsl4Qe8w8dc9opboP1bWtw==
X-Received: by 2002:a05:6512:1116:b0:5a8:94c2:d49a with SMTP id 2adb3069b0e04-5a8ef9afdffmr3263448e87.27.1778773236596;
        Thu, 14 May 2026 08:40:36 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:d0be:ab8:6808:601a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c806sm553718e87.9.2026.05.14.08.40.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:40:36 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Thu, 14 May 2026 17:40:34 +0200
From: Erik Cervin Edin <erik@cervined.in>
To: git@vger.kernel.org
Subject: Re: [PATCH] git-jump: pick a mode automatically when invoked without
 arguments
Message-ID: <agXb1SXKnA69L9ak@mbp>
Mail-Followup-To: git@vger.kernel.org
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
 <20260508141314.GB709299@coredump.intra.peff.net>
 <c5e0a1fa-f228-41dd-b547-07b0ad6c0964@app.fastmail.com>
 <20260508175240.GA737125@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508175240.GA737125@coredump.intra.peff.net>

On 26/05/08 04:30PM, Greg Hurrell wrote:
> Hopefully, they at least read the README before installing it from contrib/
> (although Homebrew recently starting installing it for folks automatically,
> so may not remain true for much longer on macOS...)

Oh! I didn't know that but looking closer on my homebrew installed Git,
looks like you're right.

I would've assumed that if users had jumped through the hoops of
installing git-jump from contrib/ it stands to reason they would have
some sense of what it does. But if this is landing as a part of regular
brew install git, I'd wager there's a few unsuspecting people running
git-jump that don't know what it does.

> Would having "git jump auto" work for you?

Imo, this sounds ideal -- there's something odd about `git jump` picking
the subcommand heuristically. At least when I invoke git-jump I always
do so with a specific intent of _where_ I want to jump. Then again, I
never do a jump merge or a jump ws.

> Homebrew installing `git-jump` by default a few months ago[^2] broke
> this, because aliases can't shadow builtin commands.

But it looks like this doesn't work in this case. Even if you have
git-jump installed stand-alone (mine is in ~/bin/git-jump, in PATH,
before /opt/homebrew/bin.)

FWIW I alias jump to j, jump diff to jd and jump grep to jg. E.g.

    git jd # git jump diff

On 26/05/08 09:07AM, Greg Hurrell via GitGitGadget wrote:
> -usage: git jump [--stdout] <mode> [<args>]
> +usage: git jump [--stdout] [<mode>] [<args>]

The usage message makes <mode> optional but doesn't explain what
happens when you omit it. Seems worth documenting the auto-detect behavior
there too.

> But there are two situations where we can usefully infer the most
> valuable and likely mode that a user would want to use, and select it
> automatically when they run `git jump` without arguments:
>
> 1. When there are unmerged paths in the index, the user likely
>    wants `git jump merge`.
>
> 2. When the working tree has unstaged changes, the user likely
>    wants `git jump diff`.

I can think of a third situation -- when there are staged changes flagged by
git diff --cached --check.

If we're going to teach git-jump how to be more clever about where to jump,
does it also make sense to bake `git jump ws` into this?

Also, if this is going to grow into a proper auto-detect heuristic, it
might be cleaner as a first-class mode rather than logic spliced into the
argument parser. Something like:

    mode_auto() {
        if test -n "$(git ls-files -u)"; then
            mode_merge "$@"
        elif ! git diff --quiet; then
            mode_diff "$@"
        elif ! git diff --cached --check >/dev/null 2>&1; then
            mode_ws --cached "$@"
        else
            return 0
        fi
    }

That way `git jump auto` works explicitly, bare `git jump` defaults
to it (just `set -- auto` when $# -lt 1), and the usage text can
document the heuristic. It also keeps the detection and dispatch in
one place in case someone wants to tweak the priority later.

All in all, I think an auto jumping mode could be genuinely useful.
