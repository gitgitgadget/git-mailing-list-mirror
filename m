Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549446;
	b=fQ24zsozAqL5ofk+IpUme80AC71CHEt2a6tswXZeb2i8asXQIthwQ09BLC1jI4QvD5GY
	 ErriDc5RwvBzrQCS+qAezp2HqE8shboVHzvq+auh5adGM7ST15/q9O6WmXhgFB9dDiKPW
	 aOLa1UPMrUT5CeNM5HQ+f88Du/4LFZg2kqrY37c/uw1e4pxny4nrD+U0G/J0NdfRmMOPz
	 plymNPM7xjEQWgeFxQpuMJ2oMOKchtZTaBh1s/pMp3etkyNITZLDTgevMPXNZRHC+hcKt
	 9NiHbLamKl/c35/BMQNcIC0kdfIhvGgd4PqNyyGs0+Tjra66eUOAd4IufsK262/nOAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=sFKFaBjDPXHpFyKEVtYbUMEWrVer2P9Bzv49tpLxOKc=;
	b=DTzvZrrjoTfwwR4nMv7mgNTEWuuz2khGfVMEhCcqfQvD9eZXp7NE/DLMcBQhEdla3oVQ
	 pjK0ZA72Z0JyP8wn8hqzpvWIOKk5xH7YCCfyAY4Z7DjAuwcTo1MSK5uThlb8Jsl6GQb6y
	 3YlvgVgtEyjKVjNo8FxU33LHyYTyzvbbOlEsdsSXQHE2oE9bpltYpSKqT4W+b84YDcC9N
	 rG4CwPDLwQ0uU+roj4uHoXZ/Ji52zhlGfE6kw87N6Aa7H+lhVdthb+7lZAmHkFDu3pr0G
	 5C4LyNtLghUPhYkv2/MkCGn0H6TNgsB7m24BdurxkdZknbUlCPVFwXSqnp+ExUUQfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IczcAGvO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nXrIicQL;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC8606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DC8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IczcAGvO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nXrIicQL
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91D1F140003C
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:44:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 24 Nov 2026 14:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795549444; x=1795635844; bh=sFKFaBjDPX
	HpFyKEVtYbUMEWrVer2P9Bzv49tpLxOKc=; b=IczcAGvO7zknmJXdIeUJy6lorj
	6wRGjCIDD26mM+PZj4yWOpLDTBx/97fbiSY0w/ythDBuzmOK+/2Zn4Sjb44/rd2j
	LRXm+4G0iWImxkTMz3Wb+maPmL2Tl92+/vDQfQH+Hny5ysWprv5rEAbHUNLzcHO1
	ViXl4NXiqy1wDZEArxpHzBz5/22twpy+LBPCemNjDuZCb4cUdvNe+fCvIqZKpfOY
	Y+BPhjY+q92EBszdkEZxUHUgwRGbe5TYiTyXaginP7NhgipGKrGPqycuMKFciwmF
	9NNJ9I3irpBmdVDJBQwymM5L/vz72i69OXRC9Xk7++3qeKQA/nhT681Fqagg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795549444; x=1795635844; bh=sFKFaBjDPXHpFyKEVtYbUMEWrVer2P9Bzv4
	9tpLxOKc=; b=nXrIicQLkPlbZap2a4kDzvATdZ6GqscO1kMqlMdP+X+5g5/OrMO
	QU0SDwZFfFZJi1rPzqYtPjldWMLy2TrPbdK/7oQT6ye0+jMIZw8YFG6cOeiuwatk
	pA8ynHKi07LYlli2Wtv/YaYl9LJIe10zsdWsaKGYpgwid0eN2EXvqVlmLWyq9gxA
	uqfhLfx7KpypZZaSM0NU1kElWmTNiPMbTuPG3Qr2++jm8fqEDfgZ2oXhIH/GdhPJ
	k946/AY5BQnrNmE8jFRcLmrsfqGO7NaAtdsHqNd1VsfIJcz72EFeziu21tIBM6MA
	/sGPyn6LxJLcftDQvbGVxR1E4DY30o5E2Nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795549444; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OD4shjahSRgWvJm3CfUTw4ehMJvZBF9nBbrrILYwSqz6Vd0
	TVxYMa8b/NS8MB4uHRtG8KYJP6q4D/eLPe6GChH9qY71i6TkW8TOl08jP9YiYEvj
	j/KIeoVmlW9DQEUU2+WWRznil62m3kJ9MO1saJpOua4mEYRexLR7qXVevh+vmtw3
	/TGjGZgiEm6MYG1pYxvVjTW+M0WkNVpauQM8e6wm5i1vglOsH9cxvYO/3IkOfbjY
	UCfRWaGjUSwcffioChujefTNRoT9vTsCKYd4PiaKkLvwLo7dTJcXP/hL2BwsP43p
	CR/U5xHf0LC94NJmMEgH3NyFTm+ZiHzPrK5zMIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jjjpuXj1KpSLIWl1ja5yGFJo0YNqlFFXAkRZXfH2fvw=:CriSfeFtq5unbUBuBtgHQdbWW+0x/9Bc1mLtjz7hua4=;
X-ME-Sender: <xms:BOkFa13wK9UzA81_GDV3qi43LifQ5gdW1RQsuVelOLCJ7_VhuhMi8A>
    <xme:BOkFazGmk9zn3IhCXRukciffgXEaA5RZZD0F3Sg6OWOanWdl4vgQ6fmZANY98ml3r
    LrmMmCJsWzGCT0VZ6gelhjpF1icvINduQUJPPJrFOa7RVMtWpC99dU>
X-ME-Received: <xmr:BOkFa67WQ7NXTxnaTND55r--viPiwAnO0I7DRHTXBqiICmdGIJs6eh7q3JTee-TIelNCSLuiQMbTDquc41wRxg0h6JHRo62pnhSfgxs>
X-ME-Proxy-Cause: dmFkZTFqsVvU4r+wL2UbMMEplqXxANpyn0higtcX6xBKnN7kkdyK90KaUUUZ7nUM0qmKMK
    FBEZfBylRGXsjGu1NtXos9+MR74WFm5nLuc0hMlTFXpSt1e9hGwMFBOKIxTXX7o6MA3FvA
    l1zRBcVHI1L6R5b78Lg/WWDp/K3eHF/GGsulAlBPpQyACBvEyo79jDuIglZIpvSaGRFTP8
    /54U2DCzcGJZEcQJF5RNa95eLxdfxY5j6tWQp6CI1zDTlSyiwclyGi7uFHA3VbQmIKO6vE
    e+J6yqw44o7C1TPNfFtxke3tmfiOKCx8yHeH3gEGCe+u4zifD7rt5MT/67ZCsTHWMKyiiv
    zZ+p4LDDPlcg4kzcA42K2ZAeRyywoCK8PPxcBQjtojKaZX0/fi3Oq8RmDQf3ia13EcgMRJ
    vzdJhsCogrumnUSNePQzJv8fAuq5QKy3KOHFr+pk+A2cSIKhOuOgM+DWId66+u2rI5Aeye
    FrReiPR1ufKMS1eLQkvA8UoTd0YKGZ9T2S84bchASz7wxP2T82dLlbAkvXTYBWoXPBBQjw
    b/f0XKEL9mLpQTvB3iJDYJmi97gm9D49cPnDZCitnlevDjP36bO1QmZRB2HNoaJyogpzWG
    L4qk/DyHqd9B7B90SLLI94vdCsZxP/sF0aYW3pHoDF60J3P2KXKsIqkHQ3QQ
X-ME-Proxy: <xmx:BOkFaxvKSuwgKI7aNOke9aKJfr-__IYpz-6-Uyo0d3JBm6PzRFZmsQ>
    <xmx:BOkFaz6FkTWjkCmR5FzSJs3qYRefLLqnSDJUjd3iuzLduUuCdycmTQ>
    <xmx:BOkFa0W9aXRQxrktq1qUcdOzzbuC9-hljEjZk8vXeMHahjgSH54DKA>
    <xmx:BOkFa9-nmGrujjGLSkvu-hpM-PP0qtP91vuUXjmQfcOqju8EfmvzwQ>
    <xmx:BOkFa6WHNisREHUezK_GoUJw_N9Sjow4XIsYAdh0HZoTpoReIRf-XcK8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 14:44:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v2 1/3] submodule: make submodule.<name>.gitdir relative
 for worktrees
In-Reply-To: <435ca42ec99d0eed613621186306cb68def30e6c.1795273853.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Sat, 21 Nov 2026
	15:10:51 +0000")
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
	<435ca42ec99d0eed613621186306cb68def30e6c.1795273853.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 11:44:02 -0800
Message-ID: <xmqq4id6qakd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> For a linked worktree, always keep `submodule.<name>.gitdir` relative
> to ensure it continues to work when the worktree is moved along with
> the main worktree. (This benefit also requires
> worktree.useRelativePaths to be set to true.)

Perhaps state the status quo first for future readers, that
repo_git_path_append() produces an absolute path for linked worktrees
unless relative paths are enabled.  This change applies to the main
worktree as well whenever worktree_git_path() returns an absolute path
(such as when GIT_DIR is absolute), right?  That may be worth noting
here, too.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 461b682d0d..c3b3a2865f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -507,50 +508,63 @@
> ... 
> +	modules_dir = worktree_git_path(wt, "modules/");
> +	if (is_absolute_path(modules_dir)) {
> +		modules_dir = relative_path(modules_dir, wt->path, &tmp);
> +	} else {
> +		strbuf_addstr(&tmp, modules_dir);
> +		modules_dir = tmp.buf;
>  	}

Copying 'modules_dir' in the 'else' branch avoids overwriting the static
buffer from worktree_git_path(), and converting the early returns in the
later cases 2.X to 'goto cleanup' nicely plugs pre-existing strbuf
leaks.

However, doesn't the 'if (is_absolute_path(modules_dir))' branch still
have the same static-buffer hazard?  As documented above relative_path()
in path.c:

    The strbuf may or may not be used, so do not assume it contains the
    returned path.

When 'wt->path' is a directory prefix of 'modules_dir' (for instance, in
the main worktree with GIT_DIR=/abs/repo/.git GIT_WORK_TREE=/abs/repo),
relative_path() advances 'in' (initialized from modules_dir we gave) and
returns a pointer directly into worktree_git_path()'s 4-slot ring buffer
without touching 'tmp'.  Once patch 3 calls worktree_git_path(wt,
"config.worktree") inside validate_and_set_submodule_gitdir(), four
consecutive failures across Case 1, 2.1, 2.2, and 2.3 (e.g., if
config.worktree is locked or unwritable) will wrap that 4-slot buffer
and overwrite 'modules_dir' while create_default_gitdir_config() is
still using it, no?

Unconditionally owning the copy in 'modules_dir' (or 'tmp') closes that
hole cleanly:

	const char *raw = worktree_git_path(wt, "modules/");
	char *modules_dir = xstrdup(is_absolute_path(raw) ?
				    relative_path(raw, wt->path, &tmp) : raw);

Of course, if we go that route, freeing 'modules_dir' under 'cleanup:'
would become necessary.

Thanks.
