Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F14BD0FD
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827493; cv=none; b=PcjvaZIL40tGz4TCnlxV6nLmsP5CqbUilffnWFOltoBcZDX5vUmV6qm5m4FpR/4DizUj4rZQfyqDUTSyJRGFYIrD8JPKoGab5gBV0oWr2TiTYrHnWpYHrSn5rRUTcwySO3jyzO3ga8JB7vTO8iPVmFj4vOENgh8ZnCcewo6RijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827493; c=relaxed/simple;
	bh=aV8faWuM27l8tBxkYpToViutMFFqQ8xqgAfIvuOcI8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFYxo0I7nk3yH2IllcQwGBfdrLbgMlFeuoeiBT/AS3kpvJvmvcXno4Sgx8Bi8qYwn3fdalH8hxQWGkOo+uWU5W4pKZS6gbKBZaWi8Ac01If8MLAPkR8BpQw3d+JD4TCPIMldoL2gUjjviWYalY1LAyTAB0xtuD6it5P37ZnauJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDmhBD1g; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDmhBD1g"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ae9bc9a2fcso32395117b3.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827491; x=1792432291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1Pda4zvUFL8Dukp/QANXACb3MGfE1jsVSJ6G4x4QxE=;
        b=BDmhBD1gb3ftwqUgFDLbAiKZF76iQf6ecCOfGRDS4Nx/22OGEoK0pJwILEtnXBQ1C8
         yvhob3Fgrz4gvvHC29s9w9FsST+N4VcCfPUSblWLmPgGOM3Zz7MtRLeBOWS103+umZrU
         kp1Las6X2FBf3bFQHxUnMIYYgMJBBOXAckmsB4krFw16qWmQKHKX7Ntb2pHwFFt5pqVd
         BX2EWVkqHDsAsUXYXoZ51XFZIrr9kikKk7xM0KL0rwo5lVNZYvJmoQ0R3jcXLKrb0VZq
         hjMfolkKFGSj3qjsJuEs9wcLduwepvZOP/LxRZ7fGqAgJ5r5BqVcZCu/5k4X0Qkriys3
         NiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827491; x=1792432291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1Pda4zvUFL8Dukp/QANXACb3MGfE1jsVSJ6G4x4QxE=;
        b=YJP0ftVIUaPo271w+3vHz7deTOAoQP4dN2kbCyHtckHFKv9ZVrsK4YZn0B5SdxhJ9S
         AXv/His63WWeX5jHihB4v1hYorU7KY3/XTZ0347JoxwGgXapfgjas9Sn5pY3L66fD/Sw
         4CE9Eb7wgdsuA+6WGJcQBVblQm8Q6lE0u6+lqcOq88KoGz1/vfx/2BJZMgUguXx2GDKA
         /pELkA6i6NiOHDxJ2iCp9E42uoT4nzs2OUuOpsd6hhTAxSnme8K7sv85OShbhVyK+0uO
         Nvk33AHa0O+If2vLCqgx8+Gii6wNKPXEAkoSouGI5IM2pgeqN72lnjhNuzSmQ+7tVEob
         ztAg==
X-Gm-Message-State: AFq9FYLr5bnfZLJtIce6GvojHIx0oD3tO6GImcORNbkE7wvJEASigfWo
	uUUvmURnIJMyceyjmFme22PClwS5h0Aho+xabDwGrbz/kLwsGVfhTZh8ZwqPyNf+
X-Gm-Gg: AYBFou1Az2lHzQ6AJPIrTt/JoAwWPpd9v6Aj9p1J3yOEC5NbN1r1FxCjBMjcUHfQj7U
	l74pi5bHYFki/3Rw+wcmJg1ETG17b9mGxLmn2ZodHR8kwTa34jO0sesshNQOOQ0RnFGCwE9dYkx
	sMfs5Q0CE4lwTplL63WTYPmehAdLdvwFYNiQ+jhogedSZjaPcXN/oDmdZLwo85FL8j4CP6r0AEh
	Mf667c1PATJj0sWSKEHZr88D6ycJ7K/RfHJG8y1ezrvO7ugVEetsDtBxO97gezf9HY58ErAiWqB
	JiTZWlFIh0H/aoy8RBGdJOY4hK9RLsA6BPBkdOYES2IWfQfNOncZNLGi7hqceBqpBWNXBusweK+
	hqBgkShVDabel/sXNPI8hR4WPiDhJejDT3paIZ3mXMRj9vZh9F/qnUrwl1+o7yf8LWgs/xOK9bL
	o89Dq2Qw1tZ/9nEziPhyn+YnoDgcFFFzPcbIcjboyuNs3N1i7AQAIwMVLIaKPRmScpU1tGVJd2z
	M/Z6peyO9v6rlJObtUtaercwns6Ovva3d/gxigg02AZVTg8qJ9/xZDdAWkxQOlFIGCZbPc79OAt
	Kdfj60n5QbvBKjKCUJHHgEY=
X-Received: by 2002:a05:690c:4990:b0:8b0:88c7:f184 with SMTP id 00721157ae682-8b088c7f2cemr28364637b3.4.1791827490882;
        Mon, 12 Oct 2026 10:51:30 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee8603fsm36797127b3.4.2026.10.12.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:51:30 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Quentin Bernet <quentin.bernet@bluewin.ch>
Subject: [PATCH 4/5] doc: drop usage mentions of "git stash save"
Date: Mon, 12 Oct 2026 13:48:30 -0400
Message-ID: <5a2ea087bf35a15760206e2c8ea1f8df5a43296a.1791827304.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.184.g5a00b4a6e9.dirty
In-Reply-To: <cover.1791827304.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though we previously deprecated it in fd2ebf14db (stash: mark "git
stash save" deprecated in the man page, 2017-10-22), the save subcommand
clings to life. For example, 951ec747d4 (doc txt & -h consistency: make
"stash" consistent, 2022-10-13) brought back "save" to the git-stash(1)
synopsis, and 41a28eb6c1 (stash: implement '--staged' option for 'push'
and 'save', 2021-10-18) gave it new options. But we really discourage
its use in modern Git, so let's drop mention of it from -h usage and the
synopsis.

It's still described in the manual, since some descriptions talk about
the "save" command. As we haven't gone ahead with a full deprecation and
removal, we can leave these pieces for folks whose fingers still type
"save" and need a reference for its behavior.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---

Notes (benknoble/commits):
    AFAICT there was no discussion of its deprecation when re-adding save to
    the documentation, so I wonder if that was just an oversight.

 Documentation/git-stash.adoc | 2 --
 builtin/stash.c              | 1 -
 2 files changed, 3 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index d6e8c4144c..6bf510702b 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -18,8 +18,6 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]
-git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
-           [-u | --include-untracked] [-a | --all] [<message>]
 git stash clear
 git stash create [<message>]
 git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..94869c2429 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -75,7 +75,6 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_APPLY_USAGE,
 	BUILTIN_STASH_BRANCH_USAGE,
 	BUILTIN_STASH_PUSH_USAGE,
-	BUILTIN_STASH_SAVE_USAGE,
 	BUILTIN_STASH_CLEAR_USAGE,
 	BUILTIN_STASH_CREATE_USAGE,
 	BUILTIN_STASH_STORE_USAGE,
-- 
2.56.0.184.g5a00b4a6e9.dirty

