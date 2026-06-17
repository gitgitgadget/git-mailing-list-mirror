Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A323F822B
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692426; cv=pass; b=JS1rbbZyh5T9jp3P1uSCq17o1AZ4HloQSXZiYLZdOBuOKIxrqmeFbXK3GZRhuw7b+du9xY//Ey6xV+IDN4PflIXtFWDQ+GutCv/o8wruoZua0qacOKvm0yVeQkf/a/7z7k3IqgNT5Ahvlfn2kTtjfy9zTe2m+fOkUxWbOD5t2js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692426; c=relaxed/simple;
	bh=KFepJTOtZxTdiO6uiSzabIicgkSrvjFDy0nxyKPEpMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVoOann2N58Q6tvHh/Z2SNy+coApHvYoslJsaaR4klH6pLRhIr7qRSE60qaUIHSKEyAL8QrJKnV7qDqiBvkyZqUDWtb+GoYrPOcj5Q2MekvN8kFrIzOnO35aX/jLtU6MrfKBVPS0XjR1cR47ttyJSOrynQgm6RyH5kzoojqfQug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMzU3Lqc; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMzU3Lqc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6956a8abe7aso602964a12.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 03:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781692424; cv=none;
        d=google.com; s=arc-20240605;
        b=JnZwDxQGNpkg+ZhMrX0AxCBORwxrSp6tFicvc8ScbCQ/dsYrJ49+57Qeo3jyoaEfs7
         br9cv0otcJGgLBBEksFS1HYgh60jZiyHMqD6uWkmv3jrqcXPcG4LSh4ZhhDuOQf7LhHE
         wraBMXPELlDREutLFTHx0Fa5e/EXUEPMSqLpJYDLc/hkPOzIHltQJLnGPjMh0c3adYPZ
         /XwPYNQda3SNd7eS0Wzt8PWZZrWftiYP6QASxsQMychwZPhwncURs6IYI0sndOL9RBSS
         Yy2ejKD9hgU/bXksvtxREo6t6m3vuFx5bS/X0zd4lwNnxlCu4XYQOlylu9JElbWsAeWK
         jJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7g3wdfKewj1ZV+Ze2lXFF7EsVzYSTwVBg1CnjfX0Qe0=;
        fh=FNLIMZhZiDFzfjD6hRJkkjs23dKhojv9FJ2aShxuIfI=;
        b=CDLPfzc4XZVhdH82G/4zMdzzZIWltN2T5G+QmCmXSIW86kDXqFVeg3sg4GX3qNORi3
         Q2Q5CCIftCiWEQhKf0Ym0QQZkGdpHi2i4acmYNbimesPDxijR2kjriLZytI3QqmaNMPp
         2sVpc3MeltjyWh2vm2P770iy5VB7Iy5BAnx528Jidx6b6lbf1PmALpz0RwEaI7HnM7ZN
         7hz5LURpn7Kh7KNPfG8wpQk45ieMImPIcDCZTSk2vEyQrouPoaDbj3kT1h1oW8SnmGlh
         +WrrsmgK10JIdVBSEwXeUDDFsLnhkuhePpVp5OviJmCMIPd55roy2/XeacK5XpQ1wZ/k
         iU3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781692424; x=1782297224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7g3wdfKewj1ZV+Ze2lXFF7EsVzYSTwVBg1CnjfX0Qe0=;
        b=HMzU3Lqc+xAvJrQDPjYiKDa6SnmrkJvozpD8/m+v+iYMooJ82wdfOH/Pvb1Lr+78cu
         /JodboQ1tEq0uTgMlDfqBZy5PcRPUpCViYDd4Cro5a5ZE1SWNY6ddA167hkiSf0U8/+w
         Kuhmw96TxSnkz+O+CKsSU887CucEdG3vXD97jaaxYjLwzmpibE9jC/jNXMLxMc5qAWrK
         yWUrKbVm97OCQWPqbEGPkE6Obp1+SYBxHx/8mVSkCAQhzQJjqSxKAkTn89zidNjnRs8i
         dlx3PvpKxMe4XYUCPo0wrScLGzQrARdskD7/kCKWWZyeDxuLmlLIo77BGd3d2r7RQwRE
         yhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692424; x=1782297224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g3wdfKewj1ZV+Ze2lXFF7EsVzYSTwVBg1CnjfX0Qe0=;
        b=M9ioDzd1lpI5q1SyTtwbjrp+FXYFoIR1WzaEbyiMEWK1IElGSML4rtqEEEEdevoRni
         qFdrbhNbykIvw4lBodp7pt9vOiGjOOuun9suiz1aTlQKnNqYodxhHmHsfrGWHBi8+dln
         gQMzJj1Cs+e0Iz/yIjAdHL/jeRzs8y9y7bk1fhug1TR/f9zXrW1vl2ChJQbbJslEtEuX
         /BVkutkrEdAa5NDr6nOauJQTv+PbWMb1+nUnap1crhHTH9pq023KmfvL9OzwclPWYq0l
         xIzLxLHW94ndbiwG2WHg06HYloptx45AxVPwQHuX3vDyuA2i95CMQXZrNYiikY/0hj29
         od5w==
X-Gm-Message-State: AOJu0YyZGLaTSQ1rMdToH/t7a/IbgNPigqKrBxDM8pKVpBpqKY/7dvAP
	zGTMO0nuY9Kxkn1LHeL5S0bWzBcNsj6EYV1kDWp3JwRsVEPywTYJCfHfkhXbD71cERlWxSGVFgo
	OE2z8hR4ebvSduewiYQWQb9H3PNUC4P0=
X-Gm-Gg: Acq92OGIAW1sHx6x8g8l8afoqj18ViFKybMq7dGhMGuhn0Kf/oREWVeiup44CVRRLfp
	DarSX/OsQ1j831BbH8eT/yos+YiW4fOQC72ITHd/VZFvAAGMu6SNqplPwNzBywW67+/VKoeIbfn
	p+pFvVhRmfl79WgvNcJaQUj754XKaL22B2BGgdFxMuEEDHJBEicHchm/wPbGiwr/By8zukAk7Qg
	uwufPD8trCgpcK+yDQdg7r1wYWnD/XQcf44ZeF9MATvCTkttfwnj3jXgVrsLC67ISA7JfMADRiD
	ZSqZbf2L68KCGW8RTrGhjnzeH9nwJtcX5h6Er5Ikkr0CSp/DQahR1awzkTkgieqfF0E7+ixfZOv
	Bnbozjl/UNf0=
X-Received: by 2002:a17:906:8a6f:b0:bdb:b76c:4dd0 with SMTP id
 a640c23a62f3a-c05d2ca302cmr117829666b.40.1781692423682; Wed, 17 Jun 2026
 03:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com> <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
In-Reply-To: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 17 Jun 2026 16:03:16 +0530
X-Gm-Features: AVVi8CerUCF2ouiCYPsVy0lekWSG6v3y6xPHZZVWXhSiWL0o84YQcS-Ml50reA4
Message-ID: <CA+J6zkRF8Pm5TGZncO_0=HcVcovJsw2J+3WBfqjCS1CiS1Y_Rg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] graph: indent visual roots in graph
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, christian.couder@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jun 2026 at 00:39, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> When rendering a graph, if the history contains multiple "visual roots",
> actual roots or commits that look like roots (i.e. have their parents
> filtered out) can end up being vertically adjacent to unrelated commits,
> falsely appearing to be related.
>
> A fix for this issue was already attempted [1] a while ago.
>
> This series adds indentation to the visual root commits, so they cannot be
> vertically adjacent anymore making it easier to identify them.
>
> before indentation:
>
>         * A
>         * B1
>         * B2
>         * C1
>         * C2
>
> after indentation:
>
>           * A
>         * B1
>          \
>           * B2
>         * C1
>         * C2
>
> Indents the visual root commits that have still commits to show after them, and
> if they have children it connects them with an edge at a new row.
>
> If there are multiple visual roots adjacent in history, the indentation starts
> with the second one, avoiding redundant indentation of the first one and cascades
> after the second.
>
>         * A
>           * B
>             * C
>         * D1
>         * D2
>
> This series first commit is a cleanup that brings a common function from t4215
> and t6016 to a graph functions file which they both use, so the new test file
> for indentation, t4218, can use it as well.
>
> The lookahead used to set the cascading and avoid extra indentation is not
> completely reliable, as the walker goes through the commits it simplifies the
> history of the current commit and its parents, but it doesn't simplify it
> for the next unrelated or the grandparents. When the walker simplifies the
> history, it removes filtered commits from the history and sets its flags.
> When the next commit is an unrelated commit and its parents will be filtered
> out, for the lookahead the commit is still a child of, it cannot know that the
> next commit once simplified (advancing the walker) it will become a visual root.
> This makes the lookahead fail, failing to set the cascading and starting it
> with the first visual root, carrying an extra indent for the cascade.
>
> given:
>
>         * A unrelated (visual root)
>         * B child of C
>         * C visual root WILL BE FILTERED OUT
>         * D unrelated (visual root)
>
> the actual output is:
>
>           * A
>             * B
>         * D
>
> A test has been added to t4218 and a NEEDSWORK to the lookahead function to
> document this edge case but I'm not that familiar with revision.c. Maybe there's
> a better way to make the lookahead more reliable.

It's slightly disappointing that we couldn't find a way to fix this
after all, but at least the bug is non-breaking and the added
NEEDSWORK properly documents the issue for someone else
to tackle in the future.

Other than that, this version looks fine to me.


> [1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
>
> V4 DIFF:
>
> - Fixed test to be shown as expected by unsetting COMMIT_GRAPH
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> Pablo Sabater (2):
>       lib-log-graph: move check_graph function
>       graph: indent visual root in graph
>
>  graph.c                                    | 262 ++++++++++++++++
>  t/lib-log-graph.sh                         |   5 +
>  t/meson.build                              |   1 +
>  t/t4215-log-skewed-merges.sh               |  33 +-
>  t/t4218-log-graph-indentation.sh           | 467 +++++++++++++++++++++++++++++
>  t/t6016-rev-list-graph-simplify-history.sh |  25 +-
>  6 files changed, 759 insertions(+), 34 deletions(-)
> ---
> base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
> change-id: 20260612-ps-pre-commit-indent-39ca72816382
>
> Best regards,
> --
> Pablo Sabater <pabloosabaterr@gmail.com>
