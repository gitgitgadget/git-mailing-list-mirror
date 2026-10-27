Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103897;
	b=ePhlGn5QlehrysT+R5oyMcSKTc1ZujYaCPJ0ST/YtmQ/J53ekpv6o2X4CMb9g8pVjxp8
	 /3RPJ43EQwq98rnYXxobmuSFEuEhoNa8kQnd/DabkM14+txFJl+qCXmXQAa2Bk23Qdlqu
	 FKCy+Du7hSW64fcDSaVy8yfjMNTOiTNrj9IRMHvz8VqYX5RdnsnIJSkfGH3AUGrRwGRZc
	 lUz2YRH5tMZx01A86eNN0kd1Lb3chjVWiL8HWVyqJdc/GZc6FIWVP3m5SD1U8aONqmaUz
	 kQLhJLghXFbBGd8Gg2/aShms/R+Yw4eVQGa7DBe0g08HHMnQwZ2+w1gRQUXYK02xAJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
	b=Hkgmfm+WOFhaH6lmEP25pNu4PwcRDxWbQsP3e/4Gc/ucTuOtN4sf3ts57DDYB6Fa8igh
	 Gl1a1m6Ftr702BnP/oLPHY7fCmfbZZXO/ZKIufW59/rzBNkHoXAbI30XctxuUHTM7R06A
	 hAUIVriMOUeb0H3yF5QEUNBFAEjfEfcPUU0YUEEQVFnKFI7VE1bBUHizqZPguVgUFRs5N
	 ihK3qCUvdUp9M4b/tLq28hcsFaykhXtPQ0AllxGrf/8EIpYGzuWJOctRTgcS3tz31v3su
	 R0Tfmuj2KEk8oz7wo58DnMx66A6ocFTF1li6MeraiWFbG+RAnJCPLucRppW6Gc3zZUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="IhG5iRv/";
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94260A3834
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B94260A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IhG5iRv/
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67a6b2a2259so965279d50.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103891; x=1793708691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
        b=IhG5iRv/b37ro/BFlSJre97XgfQEhPArJr3T424Lkcfv9kcSMy/9PWZok+CuZMZeHg
         /dhs11W68PwCcqt6BJb88WDce7rqdLcbkLLBIOewXbwh3GeNBJX1l2OLV0ratLs4TJ5A
         4sJt5vZTYFvr6glmfEKkOFHozxaZ90bxL702ZXpgYI/aZDHmRIj/dGEzbJR3nk4yVfVq
         llOn9y0Ms/w+yH2oX9pJiJCMHeYZgc2TKm69VwFmDx7/iLj5dDXuKZpPR5Xh70GBvSoH
         4EytgYRGNcLS0k1omPJyyRnDHOB7U6G2j46KZIhMjG5J+TZrH71JrGfko0qrsK+No1lt
         I0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103891; x=1793708691;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
        b=jNLqmNCmLnLTyA8q4RJKd+q8BXIjs8uZNF1q4uw6X1yoQeQUvZQsHsebdA19mL15mB
         /nsKDk0y52h5x82P2xJ0wLbGLXYhORRS1HoPegSNH9FMmwTyQsSoi2+yKrTKA7vonyMv
         0bEeIi5VYmxwhg9hrohDcXE1Haf00uJOHFhw69t44lj8HzMkKDySUxd5YMJt1KPUWg+u
         4BUOtjeczaweQTGmeWY52pV5RLUZFvqbls7/1Vchr7n05Td8s/bv833Sg2U93GXwXEuL
         3dXyg/RxJzBLq9oaLWbJqWyxh/G843hSBLlhdSlchPZ9zhhkgYUnvQNAJR0U6C51BOhL
         uBjg==
X-Gm-Message-State: AFq9FYIpoJNqAo1faUfHpgnioL13uQOgcFeS/F7DUedVLaCLRHV9u7Us
	kjqWxe31nVg2L+uHQGshQ3zCssbkEMKtlmvef5HxSU9/udvzpzK7flRX7nYdbWwT
X-Gm-Gg: AYBFou1icHkeKfcKESJ59z/ABqcp7MVm3VtK+/cb4b5K7DwKuvKXGpjV7k/XOeLwTZ2
	k57BEfYiZPy0CR72zX+jUYQUt5RAFZE6BYl7xmcviOAhphuTNIad58EKc5WTEOt1Yi7+JfvNBka
	UxqJD0hYlZky7A3WaknCjOv5qNJAMWgbXEvhMsrnrr6ii7515pRZ5WSpuOPg5Ui5kpepK6oNaEc
	H7MH/HhtIldJaEQZaIH19eYRPKo3Rt3UVU65sBdu3ZvCNjkaKIT7YgE+5OVlnhJI9b4HpGCZ52E
	c5M2s+XXA4jiyXmQCF4ILpG8ARKUhQgNzmQ7Q9KkkmqIhcLRbnIdWbjuUemuB5uSwywoM58hXq7
	X4XQTLjcss8jkMbcItTHYyqN2xuxvCO4RPCd2dIgwy6iM9igZofygwOZ/PMx4nYOxUy7DBz/sSf
	mjhJuJA7jXeA9qfL0Fzf2hl972e1lmgPmu3DOFWVTyHJB7320xdVzN4mElTKq7zOnBOF+XBXDiF
	zwoQu6PrBGmq2nYLJCgOuouWkb9o+I/NjpV87UK5Ma3opo951AHm4s8j9c4t6QvSHx5vd2U9kMm
	sZ4+r8U=
X-Received: by 2002:a05:690e:11c2:b0:679:abf5:1478 with SMTP id 956f58d0204a3-67a4536dd52mr5640396d50.50.1793103891114;
        Tue, 27 Oct 2026 05:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.118])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a461f0a66sm4580482d50.10.2026.10.27.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:24:50 -0700 (PDT)
Message-Id: <a802c9f82f26c8dadf2bf3dd90de33d589561740.1793103884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 12:24:44 +0000
Subject: [PATCH v12 5/5] remote: default to --limited-fetch in a shallow
 repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Adding a second remote to a shallow clone used to still fetch every
branch that remote has, since "git remote add" always set up a
wildcard remote.<name>.fetch refspec regardless of how shallow the
repository already was. That defeats the purpose of having cloned
shallow in the first place (for example with --single-branch), and
can make a plain "git fetch" on that remote hang or take a very long
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
index 1f490819ba..245c0c4558 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -57,6 +57,11 @@ Add a remote named _<name>_ for the repository at
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
@@ -79,7 +84,8 @@ With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
 that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
 refspec-less `git fetch <name>` only fetches branches our local branches
 are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
-details.
+details. `--no-limited-fetch` explicitly disables this, overriding the
+shallow-repository default described above.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
diff --git a/builtin/remote.c b/builtin/remote.c
index 5f8a8a2f71..5d2388a26c 100644
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
 		bool use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
-			limited_fetch == 1;
+			(limited_fetch == 1 ||
+			 (limited_fetch == -1 &&
+			  is_repository_shallow(the_repository)));
 
 		strbuf_reset(&buf);
 		if (use_limited_fetch) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 90cba75f93..68063a47b8 100755
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
+			remote.upstream.fetchRefmap &&
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
+		test_must_fail git config get remote.upstream.fetchRefmap
+	)
+'
+
 test_expect_success '--limited-fetch works in a full repository too' '
 	test_when_finished "rm -rf full-add" &&
 	git clone --no-local one full-add &&
-- 
gitgitgadget
