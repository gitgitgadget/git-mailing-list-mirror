Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604111;
	b=nqB6BF7betNUTWX/95Qb9yCwkYtkS0Nw7vORVwaHq4NwBAxkfO80dOKZ+RARk0CKIJLw
	 ACKxrxv47b0pXCFbCRgcVvWKZawE0g1lVSM/KnZsorBsGdi70OlCcGHtf/1/YSCwemhIE
	 R3RnQAXPzdRDKma7H2ozooXfXTlRA0c0GyZz6KwugWXI7mo4ChTMlhsvIwzX8ThC8K8K7
	 V6D6XpC/ajxrCERBYTz5QPNDDK7QtN10/1ouZFPtmdEwGnRGMxADVuuY98lM5uHdQc8RO
	 CtiJCvbpd0D9ygypdj8fxgVfIoQc3l92+99Lrwiciz0SwR4dvexk906ZSAgzGlYeBNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wFSNWQm5wt+Lf0OC9pzqdoJKujXeeoYy2N8w4hspeuU=;
	b=GO5iB4LqgGXc7ivjT0lxSgE/rzwcvPEh3oyDLvb+3GYPXzCN4TTf0xGIEq0MLMZsZEDb
	 yPYHzf4jP4rVq/LXNVxLWOc1ozcwevHaibCa9oHIpqTKjk9dcIIJqM5BN17eUC6yVjgYw
	 cWYKRhs4idmvaaImj/4tX8rPKBOvKP+xsvfIKMIyIrUNAMRLHQYZHvTquJCqNQrhA9BFo
	 n76dmMJmUYEfz5roaBsM+PRRhM2P2+ZlKqpl6Yx/Y2LNH0DlPuhYqDdRnw5V4gUaQcOP+
	 +gfA47jNLyhxwfMxUUakhSiwOtLoVi4JwZ0Q7LD61Z9u068/SqWfncJ1wDFtQqPSbzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=mGklIyu9;
	arc=none smtp.remote-ip=74.125.231.132
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DD606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF5DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=mGklIyu9
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-702ba2fd61cso208065eaf.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1792604110; x=1793208910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFSNWQm5wt+Lf0OC9pzqdoJKujXeeoYy2N8w4hspeuU=;
        b=mGklIyu9IOmEe+JsdUjyrUqjmdN6XZPNv6/kX3prAsUbmWsk15fpa/OYdR357pqZ+m
         6ldm3Uph4kAPeLjRMDyFBI9rsnQ5JQMMvnvXS0vPdt+Nc3aHHreqvd0tBMEx8Y5gKZvG
         IFT0skgNs8B7ndUg80KsOJ01pJqproH0k5tQnEBf6oxxpcRluF9HVjf6UdQ9+km/F5D3
         dX/jTpH5q1AxftMcMsvtSOYujypFk2Phf6vm3j/+hJibL3AzoLX564Lz0YqmKr9F9vAD
         Tu1EkDg3K0DlD2LeK8qZCYWRjlPGPnvxx1xgGxEf8HpO5mgJotnZJQ1aW8Btnns+h6wu
         ti2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604110; x=1793208910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFSNWQm5wt+Lf0OC9pzqdoJKujXeeoYy2N8w4hspeuU=;
        b=TRvjWbv9qjsIQLNeOjk1gaz/jz6Q4bNl/4p3C+8ez1syFQazPljedWOskNR19X7og8
         xIa8brOKXc2nAn864cEGqOpSPlx3K6/EpZB4dlhHnVi6p/dEfbH8guhpdLPLNG1ai+Vv
         XOPYwFoJr23WX0e8mbw5wjj4QYjWTCl+0BzoOqGXaSeoOXYn+NvNCm6lb4TrNQYTwmy5
         VH0qNs7Bn1Uvg91A1r6APbHf5lsCIZRwQrE8pNj2ovIHqAJGm47LWt9pvPVJwETodlZH
         PcLpdQWKJztLZG3Hv09kJ+pwO0ce/gsozC5MKojep1a41CFx+K/2OhhNqC/4K973MvRU
         9yhA==
X-Forwarded-Encrypted: i=1; AKwUvBxW2IrwrAYoLZlkM2+rWQH2ZSkZoeyz/lwVVCu4hyirRG+8wTvYZY6vmmnXFGgLNkUBeGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRtMkfVvdYFM2neSZiW/tyUH4VYZUUIKyIn+GfRAC/3CPs5PvH
	/KnCL7QWfyU+BWAQBJbpzoWdr7w9E2/i2kFBDsChiXd1Xe4EwuT5Y5WwcgPIf6NU6xIeWXdOUW6
	cAQILYcknaPQNiH0DgGaqZh3d+f6xEUeoyl9qLv1xh1PGkNFllTE3SGfd0n74wTUULF/lBsut4u
	zr1L6ykDa9V1pBjnzTQA0wxnsEmdF06Xc=
X-Gm-Gg: AYBFou0dCFRuVlLyDCZIVBJXl7AgNokPRi9BxoVVVlXaX6nq4BVISS9MyBujcOQZAPV
	dviZC2XPtnhp7BtpkAjCV2mV1tUr6IW1nL98w/imnqnFPrujChrTr6JtrtSOqFyMVjZpKc9NGxw
	1xwesqlnMMepJ/vVc7yh7otOEvYS8Bp2hEZa9nMFcuxxOvJVRpWEPWQt6zGYlo1LYfvA3AVzXl/
	laJ7toIXkpnWJLjG9KlPFFrPe+0EpTTZICDMBmazn0GK5FcDjeKx88v3qvBfhJOC04hpIzyQlE8
	VFGE9s9G446/jxJXjNF7yovkLCGBqLe4eGy4lGU1vl7cmSHCv6XTOVwMu1aG2ZtpJgdlTKFoVYY
	iVcSuGIRMUpc2Fy7qxdOlWdONazRlyuVhxsMzGdYWZiVf3kHRaSyzbTGOWg1JjOUM+SwL7vGQ2X
	SLII88khHFCK4koaKlgVTA7IystxGwUdQg2AsVgSRz+29/rKw66MA9yXfDVhCf/7dTlnnpNDThA
	EYn0yBO7pkJOkfi+JlurJETMQjnNLj0y0/O3OPrf1eLN/KEuV9ZISv4jxtJIyk8Tb3lPVTgTEPM
	ZWrcgJKL7thRiIg4zBKspNefKYGpxveoZTFVUF1gLN0d0auDeDRo3zIXTwrYpyi1R5LcfVmgrzH
	08hTmbWi7zBm6sEGgvwG+rMwmF7rjpA28ts0Z9poWeYivTgaNKZgybpMyKG/r2pZ5mMhEAj8+Qt
	R7GjK8XSdYxC3rb5cZ9eTuo+eQx7cW8v2D8ijTCFstWIAOlt13xWEkU/AUGLkHbauJFWcvEA==
X-Received: by 2002:a05:6820:98c:b0:708:d449:47ae with SMTP id 006d021491bc7-70941725feemr1619889eaf.75.1792604109703;
        Wed, 21 Oct 2026 10:35:09 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbddc7100sm2890611a34.24.2026.10.21.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:35:09 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: haraldnordgren@gmail.com
Cc: gitster@pobox.com,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood123@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
Date: Wed, 21 Oct 2026 13:35:03 -0400
Message-ID: <20261021173503.70887-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
References: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * By default a branch counts as merged when an upstream commit has its
>    exact version of every file it changed. This never reads file contents,
>    so it stays cheap in a partial clone. It finds rebase merges, and squash
>    merges where upstream left those files alone.
>  * Replace --no-squashed with an opt-in --squashed, which also finds
>    branches merged after upstream changed the same files by merging those
>    files.

Thanks for the new round. I ran v3 (2befb182dc) on the same generated
repositories as v2, and added one case for a squash that landed after
upstream changed another line of the same file. t3200 passes, and the
build is clean with DEVELOPER=1.

The results match the cover letter. Without --squashed, v3 deletes the
squash merges, the GitHub-style squash, the rebase merge, the rename,
and the squash that was later reverted. It keeps the new case.
--squashed also deletes the new case, and "landed as" names the correct
commit each time. A branch whose work only partly landed is kept, with
or without --squashed.

But the false positive from my v2 report is still there. A branch that
was never merged is deleted because another author made the same change
in an unrelated commit. In v2 I could turn that off with --no-squashed.
In v3 the cheap check finds it, so it happens with no option at all.

That is the case Junio called "irrelevant", and he suggested that
"--delete-merged" stay the strict "my commits are in upstream" check.
The file contents of such a branch are in upstream, but its own commits
and messages are not, and the user did not ask for the looser meaning.

So I would still prefer the whole looser check behind one opt-in, with
a config variable for the default. The cheap check and --squashed could
then be two levels of that one option, for example:

    git branch --delete-merged origin/main --landed=files
    git branch --delete-merged origin/main --landed=merge

Users who land everything through "Squash and merge" set it once in the
config, and plain --delete-merged keeps its current meaning.

A branch checked out in a worktree is still skipped with no message,
while a branch with deleteMerged=false prints "Skipping". I sent an RFC
for "git worktree list --merged" about that case:

  https://lore.kernel.org/git/20261021173350.67854-1-me@jaspermayone.com/

Thanks,
Jasper
