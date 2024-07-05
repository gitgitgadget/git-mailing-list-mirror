Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57151F61C
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720217268; cv=none; b=XzfGSelnhb7w0JArYiYUZvi5MjAtQyGi77L8ybXcKSutwul0KlpcXP38WeBH6d3pLnsU+l4kAhk0W6HbOVFvn1T+mmRUe5h1LWgRuE7gU3GSdiqm0IJ16X+HKbSgNjdqMWSur6h1BsOAx4bYwf4xmI1YxGzVhCVqC84MGwHvM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720217268; c=relaxed/simple;
	bh=V7XAKmb9XCIeU+Yy6fUXzhjFhGaXBPId6Keq93oVZ40=;
	h=MIME-Version:From:To:Cc:Subject:Message-ID:Date:Content-Type; b=M/F3ITTn8DsBkgJzDewLgU9Hp+AwdLyEn+nShbeJKoVajG+zZccvVADsO4dS/3FlMuuOXUourDhf9zcemhWgrcGEczVYhV5Q0ispl2BB//y+G0k0xeEwTgK3v/sGzb40S2pcAFrRSrW1ehTEB/aG9Er7C/SnP7gDM164BM2DCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYNmMxVI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYNmMxVI"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02748b2402so2219784276.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720217266; x=1720822066; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynMs8ZD0BWomqDUc//KXeiIImTzbRvmaTLWqVA6NJY4=;
        b=dYNmMxVITZf8pgWfPWnbjEqj6jLm1CjUp6IoKIwk3vGz3Zo1r/9xhD/5tQjMEWjnob
         18HuSsRKzL+NTaHiEC5AfW55s6TRwmujEeS7D44j9r8J318tszzpp69ElPuEpq1nmicn
         UezLHnpRgkP228nGs7SoqMIvI6u3xmvoPg86BwlfWJltNRCmByTl1Iw3+2MqdicsrY4x
         /qNjzBO7B3/F1qhpoH3kiZRNrg2un+DSegD0jYfEmAIfWaLRpQp3B/UFiiaJgn41Yga2
         EUzZRpAzGHbvV7MneuCiWQFrIuCtpXHlnexHyzMJXcborGhYPFAv8YgyNdKzovfb59GC
         FmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720217266; x=1720822066;
        h=content-transfer-encoding:date:message-id:subject:cc:to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynMs8ZD0BWomqDUc//KXeiIImTzbRvmaTLWqVA6NJY4=;
        b=JaKpKZDSvGtxuY9HsY/cUmVpFE2szMA5kjW+KBromyPaZXN2BlskN5haj9Ns6Qq0Ld
         8PgNvN/jS8BZT7aFXGun2qy3qSVGBO8I9NU8SrbnTGiY33G2x2PJ5l5adb3T81zUxF5f
         zVaTKKyGfulLVZKqosM3+Hi0DMQXBsCk7YXcYud8KMRBpwzPCXUR79YN2Y+VOKZ9c7k5
         /cuf5RubA7ovvxMmMZdO3LDzS2FPzBCfcTvN2dJZ2XT+GIt8IJR3FAPywdMg3IAucumf
         GlWBiXGOSE+Ja97NATKCK4PBaqM+7/jBYBcsedYqaa/Zsk+zXM8nNeJZ2Xkpi2YZdqBH
         PEyA==
X-Gm-Message-State: AOJu0YxcZnwUDQCMABg2B8GKVVwxBHC2p1txpWjVkK1v8SAMhiz4x2es
	+fmSHt4YPVIQvXqfmJyTLJb+orGn+eGaMPPwHBJizbzmPXuZfmfr6FwLLQ==
X-Google-Smtp-Source: AGHT+IF6LEzyWXRIoZmeHMkzG+BswfHeP4W/vEvFn7tyVPdXqfMzp27GHzzFMtq3DB9vHpErF6POtg==
X-Received: by 2002:a05:6902:4ea:b0:e03:5bca:aedd with SMTP id 3f1490d57ef6-e03c190d9c1mr6544232276.18.1720217265739;
        Fri, 05 Jul 2024 15:07:45 -0700 (PDT)
Received: from EPIC94403 ([2620:72:0:1f14:b026:2206:d6e2:81e9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353ea398fsm2902174276.28.2024.07.05.15.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "brianmlyles" <brianmlyles@gmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Git mailing list" <git@vger.kernel.org>, 
	"Jeff King" <peff@peff.net>, "Phillip Wood" <phillip.wood@dunelm.org.uk>, 
	"Sean Allred" <allred.sean@gmail.com>
Subject: Re: Should commit-msg hook receive the washed message?
Message-ID: <17df707d08b81dc4.df629cdadcf4ea15.524a056283063601@EPIC94403>
Date: Fri, 5 Jul 2024 22:07:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> Eric Sunshine <sunshine@sunshineco.com> wrote:
>=20
> The idea you proposed in a different thread[2] of exposing
> cleanup_message() functionality as a user-facing utility which a hook
> can call on an as-needed basis may make more sense(?).
>=20
> [2]: https://lore.kernel.org/git/m034onpng4.fsf@epic96565.epic.com/

I don't think that would suffice for our use case. Specifically, the
commit-msg hook has no way to know if it's looking at a message that
will be washed, or will not. For example, let's say a commit-msg hook
aims to enforce a 72-character hard-wrap policy. If a line starts with
`#`, what is the hook supposed to do?

- If the commit was created using `git commit` and the user's normal
  editor is invoked, the hook should *not* evaluate any line starting
  with `#` because that line will be removed prior to creating the
  commit as part of the message washing process.
- If the commit was created using `git commit -m`, the hook *should*
  evaluate any line starting with `#` because that line will not be
  removed by washing.

This challenge also exists for the patch scissors and any content
following it. That could have been added by git because the user called
`git commit -v` (most likely), but it also could in theory have been
added by the user, in which case the patch (or patch-like content) ends
up in the final commit message as well. The hook has no way to know
whether the commit was initiated via `git commit -v` or not. The
real-world use case here could be a commit-msg hook that adds a trailer:
if the patch will be removed during washing, then using `git
interpret-trailers` to add the trailer (which places it *before* the
patch) is fine. If the patch will not be removed during washing, then=20
`git interpret-trailers` ends up putting the trailer in the middle of
the final message between the subject/body and the patch, then the patch
isn't removed and thus it's not a valid trailer.

Ultimately, the hook doesn't know what will happen to the message after
it runs, and thus doesn't know if a given line is guaranteed to be part
of the final commit message. This presents these edge case challenges
when attempting to implement the hook.

If the hook either were always called with the final proposed commit
message, or if it knew that the message would be washed after being
executed, then we'd have options for handling these edge cases.

--=20
Thanks,
Brian Lyles
