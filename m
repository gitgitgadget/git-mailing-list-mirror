Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF393E0230
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139812; cv=pass; b=V61urXRiALyeM4KcgGnR2/f5m6ZRkZZe60OACzvKtk57wZiJZ+JzXQTcvI7p+jFPN1hWtujTQ4l8qbgyoIT/3SNKANSaAX5+AGqJ1pVeHFHo5IYByyAeCBVf4uvlM+ufDocN+FNPyec68fTcmLyz2G6DqfmacKSZ9Mm85dJXXkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139812; c=relaxed/simple;
	bh=fxS4P5CKFQN3KkNE5+tPWdbjLAW46b2a5AtgG+ZZYPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSWOZyKFnIOvuPFifAfCiWUXl04Yut1wTghRks6dB/OUZrNltXLOVDMbUbw0J6b9CIxORKbt/p/A4b/umEgCsZkh29Hm+I0YbRHXwuwYmFuFkupDDzuJ4OhRVXH2vt131mQQYAfV0cp8FdQ/HDKNRyoP20sXzyCRpL7QWAv0MQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5JHvdGN; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5JHvdGN"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so7544008a12.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 01:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792139807; cv=none;
        d=google.com; s=arc-20260327;
        b=BKVs/uoXetb41J5TmaYZyNRQJImkaKvZ734d1to1HPZMYXkXdfGQdWTYcl1X0ZcHli
         eO4mdjU43zERqtIMGg1uyvKIljj6AdhGEEA5j4yBltyyQJPJypnuv01BiNelGg0EjwtG
         o9lzJsowWXaST+uypILWT8fmrDii3VSdhakJH0sXSUE5Fd5xYXcwMkVk19axzWKQWWUr
         o+adqvtlA9A/EYRIAGkn6CgAyUxNz4NyKbZlqt2ohz2iStyWK5RixWVEIbj1THM3YS14
         jiUi1z7QmL4CRQVtx0TbJR4i6DUihoWU9vxSgUkicIy7zhfOEuLLRvia2sgRf+6PzW8j
         MJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yYyAPScLnFF7qfSqG0/8djLqtibdudQ9i4j+MuloH+4=;
        fh=GV+q3+xoptdzTjdo/fAURyeoLF5hkow4oLuqL90b9Bg=;
        b=m+Ear2ZSC9KbZQS5gQYbBb414mtJaeTfsGF4QCM8GrAugzjLQPTbB+KXaVJZtB2NQA
         jzCwCkmlpwse78qkmZeOmZrdHTmHI7RDgdRQPVRonCnVdAAUkXyGwe+81n92nzSw1o4n
         6kHpAId8li4ExSfjvLf0Sv8SzKiJY3oRMSrT1EVO+5SrSFa5yxZrje8HEUNReuxkcWww
         yYe9r5putO0WFLHtO/KFr4pwIdhooi4eELvTxKRZSU0rxm+qzmQ7Uts4N26t2Wx7cCVE
         KscoD1jlj5QH672p1DDy7rhUxkARASetHecrLlcwe5z/5NY9OnjQTV8yhkvixT7ahVrZ
         IaYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792139807; x=1792744607; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yYyAPScLnFF7qfSqG0/8djLqtibdudQ9i4j+MuloH+4=;
        b=K5JHvdGNzfgUF1EaV7nI8xQMTEupLo1cUGKjxE7/bWu4E+bTtSMoqqx/aZs0rI/2wL
         pZkMwmFe9t2glkaTzykbubrVQtyP8E4PjTiUNZ8weIsdZeJ81brvebTXcWPpN5xRwQ5y
         PezejbcERVPt+btQ6bYHz8e/VqIHWfPx7QzEfB0O06BvyM5qt6ujYo3eDORu6jE3P1Wj
         fU5sSQKfoOajI/SbbL17JS3MUYw2DZnVMBu4xlJapjgyTVYHZapeihESZZ2K4KmEOmEb
         XWuBfBM7bzNPA2PH620PT1vC2ZBoo6vwu8kUsiUiopsk2HkhvkKYdwzycjrMSjL1+ypE
         907Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139807; x=1792744607;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yYyAPScLnFF7qfSqG0/8djLqtibdudQ9i4j+MuloH+4=;
        b=qHUaUTpZR90g7ZZVq8WCof0KvESS1aG/Dmm2G0r7S6LPrPaksk+eBUgcU2jmOuqRHu
         y9HJQ6fKlABSmOxpGQTpcHEvr6P3JvaiNqBLsp62Jw2IE4MQjY8PPsY447CUZkE5B0sO
         jOwnZYRyDeKEIz4fIg1SwlF9t6o71opdlLvZxVOEiZ378nnmwRFRMgm4khlxWa/qDmpu
         OpMbRhNMdjYUHASirDTV7yhe2Ra/DJP+37aK033JdZSCxau4A5JUIgH5SoldgyI+vX8O
         w27370kk/zrXXB0EeIbxYdA/tD+RnQSKbyY5xVfmMX0hqiW218oO2IXx9JKFl6k6j3+X
         v/5w==
X-Gm-Message-State: AFq9FYLdSkcXq8S0N9orAnTqhWqaXyIhvGGB7xwSSFf+87qgqW5FIFP7
	wFG30hJRrE0Y4EzuayeAx6GZg/0Yb41t0f14HZOai80K3yZe7K7xl88gpRYm8ED/BsiRcC2LUeY
	/0zsggwwaBk01oys5hZ0gFBawLodVeeg=
X-Gm-Gg: AYBFou12P16m7wIcG1UaJIaZESwlimt8i2HIv8DCWSah1V5IYg5WqY8izvr19k5K3hs
	5BticAO0OW1owf7LHj9AU9VqWMo+LWffgb4fTtFqUxtPISTbDvC7vYURVt40i+sI0+1QzPvsT/E
	cw2r4tq3U5+3xQLqMGRqa5uRpH2ywVbj4r6GQL0BMBUwBetbHENipLPnv4H+zu50xXvh9lpwEWw
	y/eRr7dfIM/iPvzhN/dSXDmp0SJf1jDiA7WLE+8snl5Am/KBnXbjTmjcL9J/84W0y3RYCmfS3Ap
	GdedUJ1hM0NjhjMiZtRZMeoD+LFHrQhUKp/7z0qtQHQtf2Z8y9xsCQ0=
X-Received: by 2002:a05:6402:44cf:b0:6b1:c7d9:b622 with SMTP id
 4fb4d7f45d1cf-6b1c7d9b9c0mr9655153a12.26.1792139806822; Fri, 16 Oct 2026
 01:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com> <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com>
In-Reply-To: <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 16 Oct 2026 10:36:10 +0200
X-Gm-Features: AclHuK8YWS1K-kW03DI3D-mA8ton0W2M2j7Sht0Oi12QPs--iENfLx_ETzYTS6I
Message-ID: <CAHwyqnWT9f0FvthhsPcRb+c7j7xb1LBxGxxBheb_ddfcUqij+A@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t2030: modernize test path checks
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Srujith A Poojary <poojarysrujith@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> +       test_path_is_file .git/rr-cache/$rerere_id/postimage &&
>         git checkout -m fi/le &&
>         echo resurrect the conflict &&
>         test_grep "^=======" fi/le &&
> @@ -182,7 +182,7 @@ test_expect_success 'rerere and rerere forget' '
>         check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
>         test -z "$(git ls-files -u)" &&
>         git rerere forget fi/le &&
> -       ! test -f .git/rr-cache/$rerere_id/postimage &&
> +       test_path_is_missing .git/rr-cache/$rerere_id/postimage &&

Seems like a good change, but there are lots of these calls in the
codebase. Maybe change the others ones too, while you're at it?


Harald
