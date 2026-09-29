Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5643CF21A
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673612; cv=none; b=D4DDw9PoTKyepFAJqSWSaMvaBun7/2FKpwKjerPSIS0S8FqGG3adwj1q48v9RQyvb1wwswezL50fxdOy0f2ZL3X6Q20eqqzK+Xi7vJ/6wSxc6psZFquBdsGBbI3Ce0b2yfiar9NRW31G+vy0EXpE7uL4paFSKkCk3JJtQz4PB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673612; c=relaxed/simple;
	bh=JB2qh43jJmR2/5EX0tzAwNASpHp9OSxQ4sNUChn5fsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jt8KZ2wlZgmbWSh2FXiuXW32zowd4za1j23dQ/r3QYrGgzCLtddXUTcLfMOTVGA973GOvC3yJHmknFJWC0sMYPjlyqBy9WBM6pya1wpVYmZAOYSEXB05atOT9qKcHHEXOnjGvjeOY3Uu+B3apQ4Fu00tLYbjCNLgThPflvFLnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCMP4U1p; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCMP4U1p"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166acdso297791785a.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673605; x=1791278405; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=DCMP4U1pZjpEb/2S3r2EnzhMIU4R6V5mh4f6KeLtLSDDH0Q9XAqxe1oKAcTFPfqaQF
         Nk/eIMi6sF98/tIC7/RrcXaW7pGljz3W6Rzr6zBmnpC7Z4+N8TDwx5dfeul/c7ysy6lZ
         zGA7S11lxMKAED2gmxW29ep/NQsXxavgo7t83Fa6+1zu8GBJ2uixi0cRSCsd1dWjUBhX
         vzSD/PlckjcEbZY4DE8KnOwBKvCNuR62f4RYrIpfV/yy6jmv+/KkViJVWElc7CnjmPxB
         rLYhGavTlI6SUzMnRwWeVEc/8cfgQQLCOjv9zrhSn1RwYAfLxpTSCcEIygu8NhGz6D0F
         ddlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673605; x=1791278405;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=ZE7iZygwrfQF63K/4LH+oNoxrYQs/wHkKpPRPS3uzpvnQ28Q5Z/Ds0WLnibNB6IO41
         aH+335jdV0VQbmCFi0k2QcV4hE59bCBAyUjjABOiXEkivvkcAuKkHWIPtd96af59Zksk
         z05cK8VlLyYgHEAHMFfHfo3HnXH4dISYdINM6XacdKEtau8NGuQomqK1s9KpRApv+LNF
         UFuVMbB1hEd8ePq5zDKXD/UkImVagzSF1CINCHn+oQ0XjBVi1CVc2GcoaYI8ayOTQ5L7
         E7DyD2sOdGg1lxCu8kLa21gqv07J53QdvA7B2a+61GGM4T2v9FBlPKNna2UCHSmHd1iH
         fFKg==
X-Gm-Message-State: AFuF++mK1JuGcIPm8y56/oqR/gWe7NUbujnEf52DcqUFrrbXxKgZ51lc
	OatZ+hoZy+mI6YYHowwh0bhu0vFJ2oaCG054BriwnS6tuXQiHVOAGw/YLKiAr/bC
X-Gm-Gg: AYBFou34yJZkJvMjQ1x0/1qZTRimsUCiVWO2JpVwAvez5GEDgn2PBI7IfeJBHpdOMqh
	GJ8OQ1MQ12ySzmVd2gX9r70f9Zt2Me8jtJAqnqRwYtoZ5Z9eGbydd1Yq/VMEQdHpRcZelFk5yOn
	JLWewc1t5I3sxkl2ZlRLd/9QPnWu9Ez8NSgFZuBs3HLDsEUv/BJHGYxzUz7IitUqQkioPCgMAhF
	lqGEzAfbetxHL3Ehq9dG+SBByYSH0I1+sC+2ER0R33cpxqFv1nuDPhdvIylmfyWB5ZJkOa/jZBw
	MCcRR+agRiCQ2rC423O9AuUmP6d4nNdqQt4PfrUIpTArDEDJiSEaRsinDfUZYXuerXBnxVCYqf8
	O465qc3sV8zlIEv/T3u+LVFukwRxYyS4I71gH8gHwYG+Wqr5vWNBFwLkLtgMumOo1W55+E+RAeF
	/6E2Sxe6+M80YskYTdE3XmVR2ZUWlszOJMFiVhXxiSCD/5Gl2VpGxDJ6uhfLBu04j6LmR/VKVKt
	vo=
X-Received: by 2002:a05:620a:6888:b0:93c:6e1d:96af with SMTP id af79cd13be357-93c6e1d9a45mr1465908485a.49.1790673604527;
        Tue, 29 Sep 2026 02:20:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c8125f6f6sm349192785a.6.2026.09.29.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:20:03 -0700 (PDT)
Message-Id: <43b9711a2cd100e4987393acd588de2823b0acb3.1790673598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 09:19:58 +0000
Subject: [PATCH v4 4/4] remote: default to --limited-fetch in a shallow
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
