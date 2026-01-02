Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCA25A33A
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385663; cv=none; b=i9NKi8I6/Z2/MP6JoNCmHz0MFneOA1aZsuy4uo9P9qlH68kTFL5PPtJgxBVxHVIjkU0orZbIjiRV0k/seotXftqtCIzWZd06nZloR/Mfi8pKNpOyOUQQxgdjlNoZTsPUrnwM3tZv1nBQVr2VkDzWWgm4/LFcegBkDBfgG14dr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385663; c=relaxed/simple;
	bh=cwwliS/AxL6tBsj7+bypVPOCcKMAImpoZnuL1GSq4JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvYUpQ45KgsvKZq2Bz1y4GmZcHcaNAcgc3hjl/YMWfy/QTdlaYQHMfVdkdn2bCBuyP4IFZJx2L1Rg5IoAFXoPyeKoWMWublRtNJkPzMbK5gt79hRiWcxLfdVP1Zw1mR4IZy/iAP1wBGOrZIwIWtRaWta2lU+bXJVi1VqBFMR0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OacwiPX4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OacwiPX4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59431f57bf6so12193878e87.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 12:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767385660; x=1767990460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPH4o8RRQ437FLc/3XRkYHExL/QKEIK1L0+Xgthaqt4=;
        b=OacwiPX4HuQMWN8R5KmLdNQ73vTSJ5z3DfvAGTrHaxKQHXujifyRZlh/pjGDMW5Twf
         +wAONNa5d9xQF8Nbbc/mLsgl+8DcE+Nf70zRj4eBEt42+m/+5Zz8cGa7L/i9xt4oFwNn
         MbZChXR626M1Y/Jypx25hr5a7athexQMXzSUbixkNrRryic8dIsf2yqAZ+BTx+tFIXMe
         SKclmFuWvzLXVwZwAvKURle5c1cxlrmfLobZF+Ie3qMYz+zwwIaQFqenGHGDNLiao2HI
         1P/V9pzBiC56hzC+4BZIAXUaRbejOOhIZjNNQD2dvByEA+5FfRKLrd5SCfxO4Z1M77z0
         zPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767385660; x=1767990460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPH4o8RRQ437FLc/3XRkYHExL/QKEIK1L0+Xgthaqt4=;
        b=LnWthglvYjSnN4UEdgFuOCvi+Cn2J23Hv8N/dSDHQqP1z4uP3h+zODDwRMSdyPhJVu
         G9Sy3WYr+7gZU2SIN7Zfn8WGURgUFHqlHgK7m0Umw4m23jWM9lYVtVk8GYYFLPVSBXBG
         j3hLl6q4AOImXlSALItdw4Y09L44R1t8B/10Vnzv4B5BZQ48e5ryPLsbKAZz+lu5IisP
         tublVvywJ6cvYuBoYi4ES1hWqtZ1aJdAReLzHh5m0/D8dRPRpvKZ/bh1BnBQuJMuw6XS
         d7kwZfYgFLXbGC3V9WLja0cFDqwFnah3FzYL6B3/sFe4exWsi6Pbbd7ijZ7PtVw6d3I7
         3vRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRg4DF7PyBsccipWiZpWDDKj+WIPDTfujgzeS8zubyvznvRHu467O+PfDhqmXTHOJLfUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8n/M68C3Eqz5bli6EXW8vnkbjYpovtwcd/ROzLJNCX1zOjE3
	7AcvqEnRydewIJXnctldLuIPWrynIo+KTO0OY8MjjtrrzRQpEEx0R42d
X-Gm-Gg: AY/fxX7vuqD98HY/NARQqty3SJCOoJZjALqIc2OTMmSjzDZT7lrpAF18w2U39o600+3
	0jm/NEnW6bQw6OWJ3vluUZJDfyxmPhoGyivUbYIY+lR6uUjIJlqnr88Gc6p/LWs9hZq+LwpnHFP
	qId3VjpGapIurKKRTP8f/V0xvrnXxukA0qVlGKUGvRJOLDGW4yfkbgINSdTHe1l7M/q4nJILySJ
	2V7F1974t8nsxyE6BOKcTTEQHeaHh/ZTlCT4DhmKeqX6AUqUgoC6wRBb0PCGvonGIWie8A/tyEk
	fkaS5w52tUh//JafmpTJO7bQ9nst0NWKLSWkOh9at/elDMEQkqWG92bjp53+czK5IaoMWjVWoH4
	x25xSenw+vXDziKX+FzfFVoCLyKZnO4nw7JdTguHg1lqBQDdJoLJxiAZm1wjDbOhf8/agQ5MWyX
	d/0d0H4aK+AD+7OmE2o+ZuXUH2KS3/Yj+stcnhwcKCG3AopkA8ae2uSxtg7eUdhEx5PUM7bsg=
X-Google-Smtp-Source: AGHT+IHGC7VGnr2zsLHLoeXTYlqBe8SGsmGNcfahJs/H/QpijvKo0rA3OlwFmHTcOqA77uuvFoAk9w==
X-Received: by 2002:a05:6512:3503:b0:594:34b9:a817 with SMTP id 2adb3069b0e04-59a17d462dbmr14408394e87.33.1767385659842;
        Fri, 02 Jan 2026 12:27:39 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a186287e3sm12602325e87.97.2026.01.02.12.27.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Jan 2026 12:27:39 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: Another look?
Date: Fri,  2 Jan 2026 21:27:38 +0100
Message-Id: <20260102202738.82432-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <6526c419-c60c-49d2-9c1a-52be7aca82f0@gmail.com>
References: <6526c419-c60c-49d2-9c1a-52be7aca82f0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Looking at the tests, it seems that the extra information is shown
> whenever the upstream branch differs from the default push destination
> even if they are on the same remote. I think that is sensible but this
> paragraph should be updated to reflect the fact that one does not need to
> set either of the "pushDefault" config settings to benefit from this.

Good catch, will be included in the next diff!

> I'm wondering why we don't reuse the existing messages - I don't see
> how using a different wording for the push destination compared to the
> upstream branch benefits the user. We should adjust the hints that
> are shown so that we only recommend pulling from the upstream branch
> and only recommend pushing to the default push destination but the
> comparisons should be the same. Also I don't find the message "Diverged
> from 'origin/feature' by N commits' very helpful, I'd find it more useful
> if it gave the ahead/behind count like we do for the upstream branch.

Thanks for saying this, I actually did the majority of this work already
but was hesitant to include it in the diff because it increases the surface
area. But I will include it now!

> Shouldn't we be taking account of the push and fetch refspecs here? There
> is no guarantee that $branch maps to refs/remotes/$remote/$branch. To take
> a silly example, if we have
>
>      remote.$remote.fetch =
> refs/heads/$branch:refs/remotes/$remote/abc-$branch remote.$remote.pull =
> refs/heads/$branch:refs/heads/xyz-$branch
>
> Then we should be using "refs/remotes/$remote/abc-xyz-$branch" in the
> message above as "$branch" will be pushed to "xyz-$branch" on the remote
> which is fetched to "$remote/abc-xyz-$branch"

I don't understand this one, can you maybe explain how to code will need to
change?

> As we don't use flag we can pass NULL - see the documentation for this
> function in refs.h

Thanks, will be included in the next diff!

> Why are we still suggesting pushing to the upstream branch when we know
the user is pushing to a different remote branch?

Thanks, will be included in the next diff!


Harald
