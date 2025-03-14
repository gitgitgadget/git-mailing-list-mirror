Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F01FF1AF
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956938; cv=none; b=VU4nESgF1QaZVkITwOp/O2Za1GS4PS6bUCcCVwm8HgDmh+lSeOrdE9kZ1/Tm8wrCAC8WmozQ9WF+61DKK1SPOLQpPNqly2aiUuI+4afzFjzxdSFIsbXKhndiJvO//jT+aCMh6/boJG4QkWBzJXCpOWkh+c+xIW2Y/HKnlC6oCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956938; c=relaxed/simple;
	bh=uPWGkrSEPMDyW/sVZ5g/czXo2KYgH416SObCNcAgn3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUvqx1Vr5Gb/5O22lJlVXA2GbaylZwEMS/DbDr8+W9bFsilm0n60v54/pGdL6EnFOkyaIHLIfx7Twz1tpHMdcdyA2j1bV35fyx3KQV3zhkrFmezkEk/Ucs9AZ9SpWDcvSL4gXlHPiJ4Bqw2HGY9uYqkb0qTLP/Iy07iNhYSVxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvQOcfkq; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvQOcfkq"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d377306ddso905348241.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741956936; x=1742561736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n7245VEGyaYK7dTKzOL0fWFASmN5Y45iOZygceEcl6Q=;
        b=EvQOcfkqtqnuf86c7VNwPMcFOO5/P0Wg5PmsbXLu02mzwt7+1TYu453Pr89JejJjax
         ukESxSga/F2u23mSK1aSgqbpKeU3D74ev01wPnTtwmNb+MEmQ6BQNaISNJ0UnXLfBTiQ
         VFDbcFDcxNaXk9n3MGF7wOW+WG6oJXOaYV41A5IfriPG++C3nfFUX0D9jQSECSlACqZV
         CaFGcI0trrHzeXYxXUq++xE5z+MOGXkijb/WvYQM2ZiR/HskfN/ncaiC2U7/gFWIeroa
         IAfLrs8wcTJfHgeRGUvUBhGrJyQU+qA1vme8/LIOOLDZPLXjaIETQk4GZ2f0L7aosvRX
         5jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956936; x=1742561736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7245VEGyaYK7dTKzOL0fWFASmN5Y45iOZygceEcl6Q=;
        b=ioDstbf8GBltPUbAP4xDkIkzVcm/ACYiarCg9ivfRHc5xGABEI1MoRte0VgLxl8t0U
         bCKWZT6J5KQuTOxV7XQZSRor4IOQfX5tgJstrxSmvQdVhVnd0VuZsumNXY7lQQPm89h0
         HFvfR6luQCyFDZskUsWo6Y8PZ/4K2ny39HnfpG8CZ9Suzz/LFvcktkYCSB4eGdgIEgxF
         CypZv6cijFMOTpjfJwS6hagHzRuvs4wajKHD4VhUwci/QLhvkeuHaswu6qKiDOQACOkE
         9vVJssx6DpeQrQEDrif8tB0VpYNpYm+KJ/QTEaGL5FCjNLtHQ88FSfdNZojzXuWKJeUp
         zPSg==
X-Gm-Message-State: AOJu0YyAQjLpVS/4UaFy+uw3PfaUXbU+sdvAW/YtbYW/LUbdBJLdRbxm
	xEedm3kXttG/6a/Ii2UESfRMOGRpVbdyyasZMse0SfTAap0YNzuOvcpEkq2LDc3A7yo8kGmKxQM
	ij9Sg84eKo13LNV8fR4wBg3AOQIQ=
X-Gm-Gg: ASbGncv+2I/9swiMskPgmnhNZLGkqhkbxkGxuGt46ZeUv5vIvpy8Xy0xgpsxkVnyuNh
	aGhoaaZKvNBNy+GAxlwWKaPgxO5ENuKtsvghM+y10cYzUADWaC7UBBS3BapkUvulvckTjO4cjsS
	DHnIQiooHOdYNG+W1R0iR+x1GbNUlRBWWg3KG6y+gQaciwAOu7LXoS2ipTKEHQ
X-Google-Smtp-Source: AGHT+IGXsBlSdmC77dedzJELdnXa8udTzN8nRXjHS3OCnExHaglio/I2F+p2wjmwJxn9yDt/guH23on+GdVDu9xNsTw=
X-Received: by 2002:a05:6102:3ec3:b0:4ba:9923:fa57 with SMTP id
 ada2fe7eead31-4c3831626bcmr1188561137.15.1741956935784; Fri, 14 Mar 2025
 05:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312064639.668875-1-05ZYT30@gmail.com> <20250312064639.668875-2-05ZYT30@gmail.com>
 <xmqqsengn1ms.fsf@gitster.g>
In-Reply-To: <xmqqsengn1ms.fsf@gitster.g>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Fri, 14 Mar 2025 20:55:22 +0800
X-Gm-Features: AQ5f1JrDSM4qAC4viE-pH0iD429F41YNJasy76wyb_01Tv969gGNTjVBAg4GsKQ
Message-ID: <CAMvj1+pn_+8PRXCUds0NHrRPBWh1uUzOOeNGhXTmHRTg_DGqHg@mail.gmail.com>
Subject: Re: [GSoC PATCH v3 1/1] Unify SMTP auth error handling
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri Mar 14, 2025 at 3:58 AM CST, Junio C Hamano wrote:

Thank you for the thorough review. As a newcomer, I really appreciate you
taking time to help me improve.

> "improves clarity ." is (not well formatted and) a bit subjective
> and does not apply to all three changes the patch is making here,
> does it?

I'll reformat the commit message and split the patch into more detailed
parts.

> Hmph, the interpreter may tolerate the new block-eval "eval {}"
> simple statement that lacks terminating ';' but is this an
> improvement?  The original look more kosher from syntactic point of
> view.  It seems to be totally unrelated change from the rest of the
> patch.

I'll revert it to the original state.

> We seem to already have the comment added by this hunk, since
> 4d31a44a (git-send-email: use git credential to obtain password,
> 2013-02-12).  Am I looking at a wrong version of the source (or a
> wrong version of the patch)?
>
> And curiously we do not seem to have this else clause with the
> comment that is getting removed.

You're correct - this was caused by my failure to rebase before
submission.I'll clean up all duplicate comments.

> As I do not see two evals in our copy of git-send-email.perl source,
> it may be moot at this point to comment on this patch, but if we did
> have a eval block each of the if/else arms, moving the control
> structure around and turning "if eval {} else eval {}" into "eval {
> if ... else ...}" may make it cleaner to see what is going on,
> especially if we plan to extend the choices and add elsif to the
> chain later.

I'll use if/else structure which is more extensible.

> Have a SP between "#" and the comment body.

Understood. I'll rigorously adhere to code style guidelines by adding
space after comment markers.

> I'll stop here, as the patch does not seem to be designed to apply
> to our source tree.

This was caused by my local branch being several commits behind upstream.
I've now synchronized and will resubmit properly.
