Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276A3D8902
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105981; cv=pass; b=OMJAeo+eC3k0Q/yHDNZPpmul9IkxGmVbQLlwmQvFJfmmKwCnd6RNebM799QRdPCvZAFfVskuI4fmcxwhLDsiGBMHoWMKLnvCvMcj6raI3WiJz9PuxyYJVnBAu6IbQ6V8BR6ueyZpESdFj8rnFqLArIxoNPbplztdxrqnD6BuGSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105981; c=relaxed/simple;
	bh=XFZJbtDJb9sXUfeQhutghuQlEnSjKITvEmjHj6mhyiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxpJ40t2rzwZxieAuP+VWdMiB5gkQ1Cu1kVqDOzkBiJ8WuHT7TMEWpnxC5Nwd677bPmtLd1obQXHZziU8uUIjzo3GAT967xzv08IIMg7G3V6Q02xztNbD9kVV+IveiacSi8SyNz/RMhD1ZD/yKQkqKtEf/QsK1bBrXH2vyOfJU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqMxjAFT; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqMxjAFT"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so136971a12.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 01:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784105976; cv=none;
        d=google.com; s=arc-20260327;
        b=dQy7Q+lSwchrmVjrLgjLd6bBH+f4bGilO9fwDurcSEhUpIv3jyvkyvVVaO2W5Vg1sN
         8DQNZLLVbu7jDZrIIaEz4U/ldfG3m523G5OhRwiiRnPXCabS+U7Fh4eQh748fJoAl8vr
         LAfp/g6czYHJbMTlxg0ESFTWHwyeNcfbt+HAittd47yX3iCcvpTMZ6F3IN0O7ke/p61D
         GEvi/tptwJW85BxquT90J1E9l6BznV8exvFpEf/mSCh1J7gZYcDVlJsSEaXPNR5PoKGF
         N/QDntG+quOylpytQUYLcaQl13Asu++YIKCAxBJuN9cMZNGgrgxE2illh+7c1RcQxJKm
         S0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QcLmzproZRghvLntKsphhtb0jCQ2wnExq4+R8euZnvM=;
        fh=G4/kgNlKWOvjnwaGGdc2iCBFv0vnRRJ2DhemIbbjt1c=;
        b=iK0pzTVpCaZ09YsrvWpQGvhtR/j9TFbNQX4P8XdoOmyGtLUf9gSvnMnEcOwVqQIuaY
         l3LiQqVmIu73gMjsmdLKOSXV4OPoDJPmeEfkjXTjhfaT1XJrO27QUqUyGgk82PjwCDCZ
         BPHiLFkr4KdQTOjx1NZeecw0wjcIHI5YTIGoVIyzzPB7nSthH6UkEP5AUd4waEm6iWY2
         P6f9lEtKJt9i9Ai00dqUXbAV3o/QvRRXnZKl6YQnWF2OvaiqU7qTvxHE/JMkm8SQYG/e
         y6NWjbAbjTWsvxJnSVxBXDeO0jKqlWUeq82Z2PBC0hpHjSnDPs3Qanyhq7oanEV70bJc
         5mTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105976; x=1784710776; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcLmzproZRghvLntKsphhtb0jCQ2wnExq4+R8euZnvM=;
        b=LqMxjAFTe9ferEooTfW3u34jBZfbHHFCoCXuRpbVxFAMIaQAUFQdrWToF3A++w+LHv
         fsFqm/JPxDZFUo84BIr78I0tJKhRlFB9sCGrgY9iZzibnOu9iRDNdIeSsHaTMZ7VHsTB
         nbGwoM7M4PuAK0Ec7wPuXsSnnmhiiDjJoxTBYmaDs4H3Ti1nF9+7yqz6S9ckGJznzfju
         KEhFtVAmr3S4RTHXaPa9uhkVcVg5S7LCKMjksDigqK2ki/HPlwa/CJPudq2Ijqeyeaem
         CrMuULdEikJ63Uad+Aqb9ax35Z5dpDIgaj/oXAq/3WQR7gOyLCKOt3NUHFFxjuzDMK6i
         5mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105976; x=1784710776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QcLmzproZRghvLntKsphhtb0jCQ2wnExq4+R8euZnvM=;
        b=W3kSQgqtDU4K8qVotVjFrbolfduEIdLGBlOyEkxWOMc8RQW63aCByGcMaugHxEJDoE
         Ru0HViRA2VzcPB0Dsh515MkM+P7OXWQcGoOYQFdUKb4dIBgmKt0L/qR+0+kS+UYk6sb/
         bGvGx1JuZwtSdafeDEAFK2+g0cEMTedKKF2q0unrNLoqNowVEmuizENbw2EQjCXkU9Zu
         P9e06X11cI9axUrQQ+d802rePL0xTF8gwDgth0w2i5B8bzCKvFkvOUeJWIilY/b5Qt4+
         sKnEtuLJt3Ot5ff1GwoGDkh6tBSJ3N7WbdDNRuGUrQLVAVNpUhJZlmxCG0RxLleczx4v
         NQAg==
X-Forwarded-Encrypted: i=1; AHgh+RpmmyIjRB9UCNda6EmxjYdcOwa//jkMl97Rz57LWIk+sSZPDj6rtEeBgassRcgqMlkvGpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcCZzB9nfis7QBO6qwOYEKhy4AvzeRAXWA2MvVPJpHQ4hh35t
	S50Uis99WkPAWgfNt2mNzrrnA6qmwLlwMvImEHXIFsV69eABebkh3VqYJVBbd7T0UIUQLpBJQR7
	y5kAKNMv4zlW+KZmJWkvcHQG4IksXs0Q=
X-Gm-Gg: AfdE7cnJwiRhsObj/tvpt9sNTeFxaFQdfA0zWi17XFscUWb8P9nL7yxlVVhIXwXciZ6
	VF20FX1c+rQitDZepnhQDqA7iDKl2DLcTpbTlhUeyWMVQzEtav5kFOG0LP25s0CdhvGkwn5K3JN
	CZ5+ZttkPr94HLMRMLlsp/DnuN0VsPgPN2JYfRQWZqBMnO3QmYh3kku8eo4gPuXKh0YL5BnllcM
	ysK/bH4GnZYbJ8sTp+QcKDA4d96HUMpe8QSvN/AsKb0VeWX4SyVR6UUHUGp24RLgGRiFj5t5I9L
	Xu+PACkhTkA7fKalL4rmZFLatLiryfwD2YlT4W3L3CMJ8vI/8ox7Gwy3TMeS/R5yJSREOPZK4Fr
	09QGdp4L+BGE=
X-Received: by 2002:a05:6402:40d0:b0:698:aa82:3d77 with SMTP id
 4fb4d7f45d1cf-69e19ee9729mr1006820a12.21.1784105976017; Wed, 15 Jul 2026
 01:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com> <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
In-Reply-To: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Wed, 15 Jul 2026 14:29:08 +0530
X-Gm-Features: AUfX_myCrADDNPU8_6PGkGKlu1q56scfxSJKlo8398NFGu0YxX8Ps1BZWAL-3Zg
Message-ID: <CA+J6zkQNzEAhhY74qDrOwfFVrshEF7YFxWRRkwE3ttJo15ZbAg@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] graph: indent visual roots in graph
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: ayu.chandekar@gmail.com, christian.couder@gmail.com, git@vger.kernel.org, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, 
	krka@spotify.com, mroik@delayed.space, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 at 17:39, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
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
> Before indentation:
>
>         * A
>         * B1
>         * B2
>         * C1
>         * C2
>
> After indentation:
>
>           * A
>         * B1
>          \
>           * B2
>         * C1
>         * C2
>
> Indents the visual root commits that have still commits to show after
> them, and if they have children it connects them with an edge at a new
> row.
>
> If there are multiple visual roots adjacent in history, the indentation
> starts with the second one, avoiding redundant indentation of the first
> one and cascades after the second.
>
>         * A
>           * B
>             * C
>               * D
>         * E
>           * F
>             * G
>               * H
>           * I
>         * J1
>         * J2
>
> The indentation wraps after cascading columns and when wrapping back to
> the initial column if the next commit is a non-visual-root commit, force
> the indentation one extra level.
>
> Series explanation:
>
> 1. Cleanup to bring a common function from t4215 and t6016 that will be
>    used in t4218.
>
> 2. Logic extraction of the chose of from where the commit source comes
>    from.
>
> 3. Add a buffer for lookahead purposes.
>
> 4. Principal commit. Implement the logic to get the visual roots
>    indented.
>
> 5. Make visual root cascading wrap after 4 columns
>
> 6. Add --[no-]graph-indent and log.graphIndent options.
>
> GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29331144667
>
> [1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
>
> V11 DIFF:
>
> - Changed the check that required graph, to not confuse because it is a
>   boolean value.
>
> - Typos
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> Pablo Sabater (7):
>       lib-log-graph: move check_graph function
>       revision: add next_commit_to_show()
>       graph: add a 2 commit buffer for lookahead
>       graph: indent visual root in graph
>       graph: wrap cascading commits after 4 columns
>       graph: move config reading into graph_read_config()
>       graph: add --[no-]graph-indent and log.graphIndent
>
>  Documentation/config/log.adoc              |   4 +
>  Documentation/rev-list-options.adoc        |   8 +
>  graph.c                                    | 332 +++++++++++++++-
>  graph.h                                    |  17 +
>  revision.c                                 |  57 ++-
>  revision.h                                 |   2 +
>  t/lib-log-graph.sh                         |   5 +
>  t/meson.build                              |   1 +
>  t/t4215-log-skewed-merges.sh               |  33 +-
>  t/t4218-log-graph-indentation.sh           | 596 +++++++++++++++++++++++++++++
>  t/t6016-rev-list-graph-simplify-history.sh |  25 +-
>  11 files changed, 1032 insertions(+), 48 deletions(-)
>
> Range-diff versus v11:
>
> 1:  dd0bb0d215 = 1:  d754392142 lib-log-graph: move check_graph function
> 2:  07e239533d = 2:  c93c2c0771 revision: add next_commit_to_show()
> 3:  4d71f674a1 = 3:  70fe612ae1 graph: add a 2 commit buffer for lookahead
> 4:  48ad2562f0 = 4:  e1ac06c4ea graph: indent visual root in graph
> 5:  45be69d11b = 5:  ce52b41527 graph: wrap cascading commits after 4 columns
> 6:  8ce53ae21b = 6:  9b7bb2cebc graph: move config reading into graph_read_config()
> 7:  c1fa81022e ! 7:  13e830725f graph: add --[no-]graph-indent and log.graphIndent
>     @@ Documentation/rev-list-options.adoc: This implies the `--topo-order` option by d
>      +  When used with `--graph`, indent visual roots (commits with no parents
>      +  or whose parents are not shown) to differentiate them from commits that
>      +  are vertically adjacent but unrelated. Enabled by default. Use
>     -+  `--no-graph-indent` to disable or set `graph.indent` to set a deafault
>     -+  preference.
>     ++  `--no-graph-indent` to disable or set `log.graphIndent` to set a
>     ++  default preference.
>      +
>       ifdef::git-rev-list[]
>       `--count`::
>     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
>         if (revs->graph_max_lanes > 0 && !revs->graph)
>                 die(_("the option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
>
>     -+  if (revs->graph_indent_set > 0 && !revs->graph)
>     ++  if (revs->graph_indent_set && !revs->graph)
>      +          die(_("the option '%s' requires '%s'"), "--[no-]graph-indent", "--graph");
>      +
>         if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>     @@ t/t4218-log-graph-indentation.sh: test_expect_success 'visual root cascading get
>      +  EOF
>      +'
>      +
>     -+# graph.indent true and no --option is the default state.
>     ++# log.graphIndent unset and no --option (which activates graph indentation) is
>     ++# the default state.
>      +
>       test_done
>
> ---
> base-commit: f60db8d575adb79761d363e026fb49bddf330c73

This version looks fine to me.

Thanks,
Chandra.
