Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA1416853
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961469; cv=none; b=CTNI7nW/exCvHK3nIfeoAadPOuqwFyQkrLpg8gCUg8hqnEZE6oujw+ZF/5tDN4NQC+6JggBs17Fu7bdpu3ck1Bhrx4Gcdl2vuQDOF1wFMGKszPnV/7Qx4QGVzEBNeYLcosJIiZ+fprnhq9eyPsEOE+3MoQsP+8BPwwKBoQb0SpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961469; c=relaxed/simple;
	bh=JB2qh43jJmR2/5EX0tzAwNASpHp9OSxQ4sNUChn5fsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QOgKWjTgcABcNvnFhepkgnhJpNLTcDYk8Al7lwNdIpqJT0RO3NiEkwdZLjGl9es7++AycMfkfDbYPeP1IkecbT8+4RjWSeOz+1xtMGG5j1JVIN9d0c1NSRk6AdVR9Bw/XRoIOK+1ZVWishRPAZZsOPgR9jNM0Ni5Dz7gxR9c8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swM7IQ0h; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swM7IQ0h"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so3104170a91.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961467; x=1792566267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=swM7IQ0hZrvFjdcFGhZ0FG4ET9rh+RBmVnhDXb/jBNZ3qmCWt+KMBI3JeaZNwQeEEq
         FLCJMCw+H+xQBRf4v0CSY44vHU4/yPvfIUAO4Xt8SOyQwW+f73v3Y9hGUSZc8dxvcT6r
         jXRTrewq3qLR5duyQ+69/GfQMKI5vl2oFtzrSmtxR0YdAr2DIdtJ1XGdRv3nMbPgZaM+
         7hIuaJfNoEcMQ4PZZEmyE8PwjNiTX2sCwh15B+55Spp/Gab4NvM+Qp4fkge69sQScbTu
         J/fxum3jlUN/+p/kAj1QtBQJ1O+UkgpdXPiA5kssxE3atN/3XCDP/3TEsoPL/kt4APU/
         Waxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961467; x=1792566267;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=qxeMU7XZTjfyOt1psFrJXBZMweoQHGyuy72AzAIe8OGljt0WG9WH98aUeYUYAiSu7Y
         cnqkTFnwF6CRmVVnsDi2YkPhkMQLI40I9Kwq/i9WmiZkjdN1w0PkKPGfYq8zurjfiUr7
         y7JtQfHoHUVXES30MUEUieotBFxYONGR2LQZ4hNgF1KJb5PcO7H4tlWGiZzn8hjHFYNB
         8svMH0eg+vTCBXn78BjDbeQlw4VrJ8joeVz14uTIIibRktJLZkfsKo4MOxUvwDPzWqUQ
         eim2ZdyIRjW4d+F9xdxbxITZ7IG/iDHzVShW7dkfLzjOjRDekzGiHKNQjFqxunJCzcQf
         mXug==
X-Gm-Message-State: AFq9FYLkkdeI+Anj729JJrKnx/nhiKfNcXgF/a8DgaUR3QSW8cn6ypw4
	9+0liq3T3bNgfw/5UNJKsKs6CIM9V0jqfn7GbVlcTJ4IZqIdJqvPjeS9udJkOw==
X-Gm-Gg: AYBFou20nvxolnRYMHFfEgUm+R6pbJibv4jv0fFF5TGJ1Jgg/fiq9wm7OlU0YNiA8bB
	AbJDALN/wY7VIrTIqCfo65UPENTFJlxuEYCug1grdDLMdSo7/e8oMGgO2V7JX3jCPBFHyTuhPHQ
	v3p0nKt0R+/acI09qacDEUagQ/2DRr/ie2TIF+YSr/XaEVIUb1X1g5ANK1LZtAVDXbRIfWWjJYb
	5IRStTMLIcoBG9IFF1sYnWwi4YBJDW1c5gjJwAmeFb4kF84iov0intrM/kuGUYfYEFT6npNZXXc
	1WDgZG2aZtnKc5TprVsMBpbHn46Ocd7SgumO63MroT2uLrVSkXBu3SANG4oO9gCP/KrOYnkctn7
	WPT+76saGNYzy01yI9p9KzTHNAumm4/cd/iPZYR+zUpRhw5Gq0xgZebOu01iNAA+r0mkl3ZyLPN
	GtMUL0s5Oh1t83MLexD8BfX51sFgRs0mD61g07O5DGmwBILWgPj4Mh0lfYFTIyo0jc0uvWT88O6
	Q==
X-Received: by 2002:a17:90b:2b44:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3ac4e182de7mr3031924a91.46.1791961467202;
        Wed, 14 Oct 2026 00:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd5dadd0986sm5440519a12.18.2026.10.14.00.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:04:26 -0700 (PDT)
Message-Id: <9ee090d3d0e2b64730864ae49896d1f72eca310e.1791961452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:04:12 +0000
Subject: [PATCH v9 5/5] remote: default to --limited-fetch in a shallow
 repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Adding a second remote to a shallow, single-branch clone used to
still fetch every branch that remote has, since "git remote add"
always set up a wildcard remote.<name>.fetch refspec regardless of
how shallow the repository already was. That defeats the purpose of
having cloned shallow and single-branch in the first place, and can
make a plain "git fetch" on that remote hang or take a very long
time on a repository with many branches.

Turn --limited-fetch on by default when the repository is already
shallow and neither -t/--track nor --mirror was given, so that
adding a remote there does not by itself commit to following every
branch it has. --no-limited-fetch keeps the previous behavior for
whoever wants it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 ++++-
 builtin/remote.c              |  5 ++-
 t/t5505-remote.sh             | 60 +++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 4255f8b3e6..80f8a4a183 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -52,6 +52,11 @@ Add a remote named _<name>_ for the repository at
 _<URL>_.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches `<name>/<branch>`.
 +
+If the repository is already a shallow repository (see linkgit:git-clone[1]
+`--depth`) and neither `-t`, `--mirror` nor `--no-limited-fetch` is given,
+`--limited-fetch` is turned on by default, so that `git fetch <name>` does
+not need to negotiate history for every branch the remote has.
++
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
@@ -74,7 +79,8 @@ With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
 that tracks all branches, `remote.<name>.refmap` is set up so that a
 refspec-less `git fetch <name>` only fetches branches our local branches
 are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
-details.
+details. `--no-limited-fetch` explicitly disables this, overriding the
+shallow-repository default described above.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
diff --git a/builtin/remote.c b/builtin/remote.c
index f036dd5d6f..0cf1126976 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
+#include "shallow.h"
 #include "odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
@@ -238,7 +239,9 @@ static int add(int argc, const char **argv, const char *prefix,
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
-			limited_fetch == 1;
+			(limited_fetch == 1 ||
+			 (limited_fetch == -1 &&
+			  is_repository_shallow(the_repository)));
 
 		strbuf_reset(&buf);
 		if (use_limited_fetch) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0168d5abfe..f3b5905e9e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,66 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add -t main upstream ../two &&
+		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'a remote added in a shallow repository defaults to --limited-fetch' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.refmap &&
+		test_must_fail git config get remote.upstream.fetch &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-limited-fetch overrides the shallow-repository default' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add --no-limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch &&
+		test_must_fail git config get remote.upstream.refmap
+	)
+'
+
 test_expect_success '--limited-fetch works in a full repository too' '
 	test_when_finished "rm -rf full-add" &&
 	git clone --no-local one full-add &&
-- 
gitgitgadget
