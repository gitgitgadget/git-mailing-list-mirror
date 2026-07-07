Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB31175A60
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432987; cv=pass; b=AFXlhzC4bGBlXt0zhE91zX+hrAo2vyXG4eGGRFOz/QPmSTbRBhHNdsvL3xanGhNuSSWqRTJcZPQEDBQxCQzyw73JSLHSYWrrCWviQP9CD6lmo5/vZYIQu1XeZWnoez31Vqas3aTDZtzD4f6REdnEfP3F85ATNvn3hOmNXW4DUKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432987; c=relaxed/simple;
	bh=znYi/bcBYWqRS8agstV4frRt2pciCDEbWuEHKtCWxOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiDtFMcFO1fxw/yqSwzVnVzwppv1gdfGrYfOhM+O7IkZair9is3FrI2lHuZIRuE1DJkwlmuimG21WA4xgR8a1mEndyMP7d2T0dKT/oh8kYB+hyNZUJJlUf681YIry4BxTLLPKCAC9UFqlt0J4NEgMpf6ZHgCwaNQ6JMTvzE+Cu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=jUrholu6; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="jUrholu6"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66771ded50aso2683676d50.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 07:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783432985; cv=none;
        d=google.com; s=arc-20260327;
        b=nMiBql5pLIQln29MofLmF71Kz917L0WBAmPCYwoXupPJXrYPpti+idhmqxETZ5nY5o
         t+iLPXWLOyvNRJ8Jf5NiScUUFi76FaVQ6HVK3RYOXt21dbSCs0ov2oYV+UIlff9GC29t
         ArDrknPwJBurCe5kjyJOptJ5xrtBjCOg/uE0XsPmUUTbOb2Be2GtlfnxqyRUV476cnm3
         FhKYSC+LpED3DVs76pckTVzxoSqfszMtULdZwNKup97k/pOBs+D8SQtlkH3HYtBMi59+
         CYUyp4iRhKZ93slQ/F9+GPi+8feseFgK9VZfpdZCdA6CHlRHc01pGlbzmxid/nLRIhkW
         hFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+Ld5S5wzW4keiTRtRJtFNWKFYY0djAuh98cRp9cWhnQ=;
        fh=SBkNhd38L9nuoysaXDQGHahQKqnYkLWtvE91EU+lfOA=;
        b=FCgrAcZW6c5i+Q5ccwo0r0lc+rqhPLoqj+sdyd1B7OI4Dr8iCqOzokEQBa4STyidrE
         OVu9QmfoBO9R++4FeUIzAa/lE9IVPKlRCozXVvrhCqoDAXxtZWB/f0U8HlbC+PgOts1G
         zEP4zFTwqzhRfDqD2s7Do5VWrKvpLQQGh8WNeD0dEIxJNu7DaHlF9nZHtCy8oXmzW9hz
         vjLeSBAPDFcxOOLObb5veGf16HwWx2hJ9m96PqfBmQB3Si9XSqrvlO/SiXJ2puIK2lH8
         QfspeS2mrqNZXR3+7OdFa5WusHlfZlwynkRkz9w93pnl7trzY/8CZAz1lgKdfOwhXAeI
         wNwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783432985; x=1784037785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ld5S5wzW4keiTRtRJtFNWKFYY0djAuh98cRp9cWhnQ=;
        b=jUrholu6sLDq0fBVtkWpuINvB0IQtY0Nv+G7NQ/nK/LGwO+9JAHT99Nlvw7wOJ6KEM
         Tq1GXwk/ywmZsDxzBdtJgI+GvMmh4mi7vER11Jb16S2lL/GZOKd8yuywloGgkkgPbUNy
         1SsUJkoJgtxrKIgMrIQXsUZkEbGT3x0QYZ95U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432985; x=1784037785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ld5S5wzW4keiTRtRJtFNWKFYY0djAuh98cRp9cWhnQ=;
        b=DbFsupgGTEumDpRhBVNvwAbJ3dHX53dTxZDclnq8KbWaDaDV2uocifEFgg1d7Jf2hT
         oo11Ci6EuGich8LchvtmSWeklfL+HLTJKNNPQXroBJzaVvaXdUIC2sq44wtCaBC+MEip
         OZuWMHaYXtP25S8xVQqnzd/ibIoIdjn713k8Xgnoq5Clss6TiGQm/4DxmYOsowocpHMw
         8w7CB57+4D1zgElSpcF4NhEWAY1ie/p1H3V3/C0Q1sket2WOXgnd69RD4QxLeAV6pLl9
         6UxkFZoH68xIqzKbBrCeSlt73p71LRjzK4aeI28wkvRdONG7B9Y+SgLOqeCutPo4+IU1
         G1BA==
X-Forwarded-Encrypted: i=1; AHgh+RoqhZcTkS5z88ailasSa+SbdD+wb+zmp/OkaU9D039JASuv2hWFL9Y4NVhb1wxcQ+2lzNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznoHP91pKy+0OJtYfEnDEz01/UMNq2o7VDaYHIJDmiJ72nFM11
	w5yt0Fge0yvt24CCBbESXWn3TXE80tNM27jO0lIeJOU+9ub+PlOaedqzhsjFg+yIybT9cUhzX2q
	QwFbf4HI2stEtTa1HTeQNY9z7+JLj/JrbpgGh7vcbAmz86mDwb5Qx4uBwSQ==
X-Gm-Gg: AfdE7cnbomTCJGCbsY9P2u+sLWMdzPRFaZmwRuwmDnOvc6IzZrQ04kwg1UJ0bRiNNTP
	tfBelot3YB1wn1jstmEOy96odlENgdJbUh/HbQ7dlOCSwxo/Ej6IAQj7rPPLGLnDe/ysDyoa57A
	Es7diHy2GoEPr220PozyPCACJW6Sc+osjHyqcoQCLWMeH2+/3v/d3he7aqcfHdB0wPR2XWW7U/W
	MbQeFW3dCvomg0iStRvSVeC9TLTUY/zNx2Lx4SEM4GFvy/5KSvR5xEmQ1qC57cW7RR8r/HK7g==
X-Received: by 2002:a53:a203:0:b0:667:8b90:3570 with SMTP id
 956f58d0204a3-6678b905446mr1172115d50.98.1783432984456; Tue, 07 Jul 2026
 07:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
 <ak0D44nhSH/98WYD@nand.local>
In-Reply-To: <ak0D44nhSH/98WYD@nand.local>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 16:02:52 +0200
X-Gm-Features: AVVi8CcC6LzBnbLbh25kZyZ14DSrCmvEUCkBS6mwQmK3NcDFQgZFsqofusHBt5w
Message-ID: <CAL71e4P4kM3a80DkyfWXXrCt2o+KKem8iFDM6qgmodRy1aiqLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all chain layers
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 15:49, Taylor Blau <me@ttaylorr.com> wrote:
>
> >       g = prepare_commit_graph(ctx.r);
> >       for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
> > -             g->topo_levels = &topo_levels;
> > +             chain->topo_levels = &topo_levels;
> >
>
> Looks obviously good.
>
> I think that there is a more permanent fix, though, which would have not
> allowed this bug to evade both its author, and reviewer (me). I *think*
> that we may clear up some scoping issues if we removed g->topo_levels
> entirely, and instead stored it in the write_commit_graph_ctx struct.

I think that sounds feasible, but it would be a larger change.
I wanted to keep this fix minimal and restore
the code to match the pre-regression state. I can maybe look
into a refactoring as followup (or help review someone elses
refactoring?), though I would also be happy just to get that
extra 4 seconds back on every fetch for now :)

Thanks,
Kristofer
