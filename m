Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDB38DC68
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369982; cv=pass; b=kCjgGaq2/21alAMDqATzhnSmuCpDKrQEYO18y4Lnm3mcB+trazZKYO2FGF/u92E6diLmTLjwWmmbMryF9962421MU2sIC99MWsuxGneAqPBe8bperUDTmDe4t0OfVGLORVY+y4rcXywBJV+V+6HJGg6d+m6KzrbNvpqCb6UFQtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369982; c=relaxed/simple;
	bh=j3LDWDs8P2zGY0/dn1dd3gW/+mnboJStPxSf1jzgo1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pmw0zw96VhxREnbQKVP25PV2kIxyTjiixjp8DnGlwXFyoVJR6g6N61lF9adof1IVz6ylKZ/zs+gzptL2zLEvdK5j0ioesa4hD4eXtO6EViFdPYKftiUAOOu6q1n0fMe2TQBH4BpLa41m9T/BMhCt+9sEUgDuoFqVsyspPVPVETs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=emynjPZV; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="emynjPZV"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-87ffa98d4a9so24893407b3.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 00:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789369979; cv=none;
        d=google.com; s=arc-20260327;
        b=S+7hsHTdbS49wP/eLf+YZn/XbHr4RIr0JW3zMNuI7p1WJLpNd7uNmzQZmd83QLPbsH
         kVIqdqOozpgkLEEt1dqn1/YNnefz/aVEqx//62xP8Qd0fgHDSx6RnL3GLjHulr30uU+u
         XW0XWzgom57VdJcSMABl36ORiV0GNoGYzwsamWDlwXY1Zv2a4n6b8HuZ/GX2sOEb159+
         hoQjJe1iAKgYKtU8MP9oYa8mByTrmFtVy9K+Xx7Zrf+VBYJsty0SzlS0HRyBEKsEofKQ
         Kk9WEK5SrksAdO2mv/wmIAH2exNAAJ7jtFHsIhA314ARfcMrTrr5v776ABi02gAXC4Bp
         /XhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bwnCx2O5A6Q/Ig8pNUlEjhvajUIpWgJ+cqxc/WqCtDc=;
        fh=0futRCsuuruNF0YpbT0htzurjoYfr03ulKCYVbMNkHc=;
        b=LmUj3lWs95plrjo5MTjYwef0CdrhprIReZrS+kITDWWjzkS0xXHqe9wliLnmY3tcHF
         KhV91FVdoYyQTxTRirroW9AqFfyZCk+8s76rzk56JfYZ80CD0Rk4WoiXHpQ8FudSzGCm
         THFQT2axUOxIwmX5zhQNniACeJbdEfGP6R0sVa8SZZc9IfgeNUqQsoxsM04gvdBCCYBG
         HQQsw/m3Wh1kOWRZNbowMilVvNz6++uoFQB4P+BEceV1uAIXBpIoXUIc7OKhe2XCBVSr
         rU+TUq9t63FOrqh5/crNPaFz7uzBp2FIz7HFBa7be/WSR+U10dD98ultjh37jpXI/1Ff
         CDQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1789369979; x=1789974779; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwnCx2O5A6Q/Ig8pNUlEjhvajUIpWgJ+cqxc/WqCtDc=;
        b=emynjPZV0ev0vCYWcyNRrRQAGU8eMA2sbC/1OVnYrJNsEigUKQJj8ixNPN4Hdmytu4
         koiSm3sLewU36qhyUYR1kqxu6+K+a/9mZu1ClA6+jl2lXUA2b1q0hCTEETBNPQH6i2HP
         vSA7XpVWuoaTpQul9ywjz0OYKqPP0OybJXxzlOVJ8sLSOieRLKKA9cVTZ2RmCmyhPMqZ
         Enr5NimYfzO/PeTJ/tpHDmBvCKfM/TDYXRHY4r28CCMYxHXqpPhJn5s4pselsUpIdmUS
         dpolgdv/FrQTDt4lqyX9GnZ7bGcsjtUF1i/Dc5RdanF24bECaXYznUZ6cYdoqOGR0czm
         Hv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789369979; x=1789974779;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bwnCx2O5A6Q/Ig8pNUlEjhvajUIpWgJ+cqxc/WqCtDc=;
        b=lSWF4G1LHuKmOeLCYkQqL5In5uBmf4xqwZOs2y3tt0+CP3kr5RtBWynQP3ncxwi0Ss
         rCaUoIBMPDbwzEeWawaQKYfWILVMljivD7pRdTxxfVF8ldggWu0GlJP1mUy+gFsDsOM/
         3J8vSyqhDNB8tK7AfL/kHGVTt+ueJWMjw44S+Hcm8ZHWjmACe2ocj0eWUVmP1xXdAugE
         NoN8X6sNlyjWmgANhAmYS4aiDZb0Z2ZAWDpjPx6ycU85dFaHuqKVjJAy3TPGYyskrJwn
         oWZkcrrN3Npo99VSj+p/BwNKF/GoDdAc7/zIx9jTgLOxOXGKk2jADvqYuoheiagmpMS0
         853Q==
X-Gm-Message-State: AFuF++n8IgADp39PurXfqG0dPfijG7exwwGXz2IyuJ4xSsHGOXfuiddT
	fvM91o9nB/367fg0SZzLr/yDcGZP5aRFnzP79RBdjlh6QjBktiq4QzinJnAtTkn7OxokvOwKZjn
	9DBldcXGTkuYjTiShA/rY/Goam4WXlrUYO4/w0k4PMA==
X-Gm-Gg: AYBFou2y1MwoRks3vmakeEbHI9mYs+a8D8ocFa9L/NSuAdEFyHO/LA8oG9qPR9+HJ7G
	FnzcTag+h9ckHO+tybtiMEQcjpDZO3q5m2o81cITcL4bL9nkVFS7ksyMhcxM1qWK9VvjuRYpqyh
	z/xC5On7wiDa/hVscmlr62nYY1z3wKDq/DQhiq4OuUdVg9YBHm8sPg/M7NbJSu2prfojBDCba11
	qGDpr+DHinyKM5BuGqhqC6gcpOOxcfEjn9NOSnwT3izG0nEiY+y/bKv6liRpDa8ShVbrU3ZqY4p
	xF4cbeEF3n8cOOOMq/iZGMsjVmJix36toAgSr+01NeqJzEW6GzOMlks5gpRHjFlco88TAPeMoWB
	DCUmKDXdeA020dF0vf71xorP6ZcbnWJSSt7Fdc5XBSGXZ
X-Received: by 2002:a05:690c:6104:b0:873:5bb2:6c12 with SMTP id
 00721157ae682-88d22eda592mr3029767b3.60.1789369974298; Mon, 14 Sep 2026
 00:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com> <0472fadbc564fb724e2cb14f306c1c29ed42ef40.1788942331.git.gitgitgadget@gmail.com>
 <aqOu-dvjAkkqx2Sr@pks.im>
In-Reply-To: <aqOu-dvjAkkqx2Sr@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 14 Sep 2026 09:12:43 +0200
X-Gm-Features: AcwNN1XH-3RIRLaUOUPr6Ji9PvsErwX_JJP0tS1fzJPMt85M1hl_3hZjSNViIno
Message-ID: <CAA0xjtoW3JfSbuBot0ANFiDEhEv1N-Di4mSd5tYfgkFEeh07Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] config: add git_config_append_parameter()
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de, phillip.wood123@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 11/09/2026 09:34, Patrick Steinhardt wrote:
> This paragraph still doesn't make a lot of sense. How about:

I'll take your text, with two corrections.

>   execute auto-maintenance at all. The only exception is when a conflict
>   happens, as the user would have to manually commit the result via
>   git-commit(1), and that command triggers auto-maintenance for us.

It's the sequencer that spawns "git commit" there, on "--continue",
and it spawns one for an edited message as well. That is why the next
patch has to turn maintenance off in the spawned commands.

>   In contrast to that, the "apply" backend of the sequencer _does_ run

The apply backend is "git am", driven from builtin/rebase.c, so I'll
say "the apply backend of git rebase".

> ... is still kind of dubious. As far as I can see, almost everything
> does end up in `pick_commits()` eventually:
[...]
> The only exception that I could spot is when we abort the sequencer. But
> I'd rather have us call auto-maintenance when `pick_commits()` is done
> and when we abort rather than having every user of the sequencer do it
> manually.
>
> Or am I missing something here?

The single picks. "git cherry-pick <commit>" and "git revert <commit>"
take the single_pick() branch at the top of sequencer_pick_revisions()
and return from there. Their "--continue" returns from
sequencer_continue() through continue_single_pick() when there is no
todo file, and their "--skip" returns from sequencer_skip() right
after skip_single_pick(). None of them gets to pick_commits(). For
rebase you're right, complete_action() and sequencer_continue() both
end up there.

So inside the sequencer the call would go to the end of pick_commits()
and to those three returns, plus the aborts if you want them there.
"git rebase --abort" already runs it from finish_rebase(), so that
would be cherry-pick and revert only. The two builtins are the
sequencer's only callers, which is why I moved it to them, and Phillip
preferred that too, for the single pick paths. Both work for me, say
which and I'll reroll. I'll name the functions above in the message
whichever you pick.

Thanks,
Thomas
