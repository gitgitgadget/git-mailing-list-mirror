Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428F3CBE9C
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410179; cv=none; b=jYeT1+oRKEYXNL8/giQshVtjOfsIANW97uOihG7551AOmHxwPVAuBTR+HFNH+rqJ2MrSPwNz5+xHEUvPQJdnxAoFUr+qg98eJTUWQow0zRWSuCwqmCkeaTfu/ZWBimwEQJOPjKaO6xS6SJD6Fagxa6FIU37v4wfbKJIEhX1dF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410179; c=relaxed/simple;
	bh=JB2qh43jJmR2/5EX0tzAwNASpHp9OSxQ4sNUChn5fsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cODkTH0E/WPhY3LpOMiqIk/um3ZVQwBbOS3f8XIWKHh5/RZkEWigwN1by6733lQ4kyRY2uYTp7M526qSX7RqGHF5tS4ORJqqVic1gY7ojjA3qNsQak3Bhu5BDlqpKGUo0/JRuv7u4EqT3m1OA103oBfVuafu2uNcPWiLhK714K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn7+32sa; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn7+32sa"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ddfe39131eso1507585eaf.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410177; x=1792014977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=Gn7+32saSAjxmB00amiC2Wrtja2TyoLM+Z5XsWKK3XLkyAUAGNGzZR1eo315e2Z//s
         GAiRIaQbMHS4CWhDdd0FIRuXshMZtKkO4xNLCHugjluPngl49ic4zvPWfngE5SfJyC6k
         2nmO5g+CXxlcVt4cWSifum/533pG3KbNKpe2pd1AjaI8dcJ4vSkSpaKG1NW3BupCWANb
         gLr6jZfM6kHj6hjKX6cvDfLXLVlx7Mt53nKOnN57KYvlF/j3vGS1gAxIKWVrwfQ+9kzK
         sKc1hUe8kjLxUE2bwZjkf2Y52BZoJrd+hss31uKoElmHTVKz4v5ybAdw/LctjMm0MjXC
         1faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410177; x=1792014977;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=ejhZTXud5kDl80r8sig2UeCyyJFsXq88LKtSxdRacZaJY4wdVmBH4ulkWOuoK8cLn9
         LfK8PZ3Y+j9E6E/ii97gwSG57W8sXGxh8Dzkbx8Pjezk4yfcGeuA1WHBR1bhGpYu3tAp
         Mh92Po3RomIKe0JMB99fOAFa4IjB1fQo9Gc8D7zEFqN8E/59dfQ3YIvhr2jjCSRIF2wb
         fxkOj/Vi9h7O3y3S0HBl0JAUo2cn+eEVYjfwkuy12gGdAqWEdYkRp9gYPoWYGSowmzqq
         AJJkZP2U75u9aTB2l11TgQe+pBHZSMz6BahTlOzcDvDOoL94GXxGBa+L6MLa++/y+QjS
         HK4g==
X-Gm-Message-State: AFuF++mtYYqFDptx7/CJ/YM9BLrXyogaQC3fUDUmCz1TWl7MBI4lWrd1
	JQwDDqosv76g+dsWK8N6eSD/MhbEV8yL98SMguoxBvlivVTUHXJ2Klyr6cSgo5ql
X-Gm-Gg: AYBFou3VNAaPwtwNO4y2LHti9Os+DBWODNlpsem9BT14oWMtkKn/aXNqFpMQiZ3BsyQ
	cg9TA9J0szORwU5L9s2FDqq4E8fZG5KkwajuzfheIL1+TRgoecCUDaVH8dVzjzOKuEabIBza26R
	Lr2/IHO9qYvTvlvQlkxAiukOWCg7Of8UD6WPde0qCD6UwJTZFLqARMRiFAB9fFklmkFStZJzaxP
	0EDD4MTfoPC+YOqVVmuZN4ffN07h1SYvymuP0LT0xpFdFyjLM6RUdLPmd+rjgO7RHHwxdFSv3/1
	l+y1kGMBLTR1+tj/Uksg8G+Mt0ew1mIiOu4MnuSJlXEqfKCxsyo4L5e01TgBLjVsw+DvISdA3Lu
	BbIIw8K2HC8Qktd+wT8sQIaov1GwrvHxLrWHgyDXl8sQCYbKxGK+dw5XaFAeBuBG7i/T3HJlACt
	jRp+BSGTZVsb6wphg6talHHJ6ilFdBlk0cMjM5jmgN5wncVF/QJbtoTR1E98waaGe+9+9xBvGhm
	swUPQL6gR2SXD4=
X-Received: by 2002:a05:6820:200b:b0:6cd:3ffc:acfd with SMTP id 006d021491bc7-6e7a738e13bmr3551093eaf.77.1791410176657;
        Wed, 07 Oct 2026 14:56:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.134])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e7947969bfsm3149662eaf.13.2026.10.07.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:56:15 -0700 (PDT)
Message-Id: <c8fd073de34b6c63d0e9e9f41220fde36f5cd40e.1791410164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Oct 2026 21:56:04 +0000
Subject: [PATCH v7 4/4] remote: default to --limited-fetch in a shallow
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
