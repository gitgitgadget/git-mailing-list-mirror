Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357573;
	b=ckH9zf9VUUWY0dpd4Dq1RCdKjkRwBIhVm5snjD+0THrJEadm8bLRscWa3k3DvKl80fZ0
	 4tyNBzAs6izk2BfdMyqDW8LgFm1+otijKlL3suYzPei+VmmEtk5ot7cF0GZkpOvTQxI3D
	 bVZzshOUi++H6JrXXteC3um2KwhIE7Y3zNqy47ZzD8Llhc95JwU2rCwJPgE0ap0Xmtmla
	 rIwAGOILY1uUwRSnJNFALCQMHmM7pyfE0zqSkCupB5xwLbIA/XhfL+hCjoIJ4E0foiv5w
	 kYS6FhS5tl91RRlIgTLdBulIaJRP/cR1HF7MW0mT+4YUVh4OwJ9s8zxYX05s+EKbP1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
	b=vC00LqyEW2hJg648NgYa9cloLAyMJHOSb+84qPJGwI3NREGZphhWwIOcaHXgbE3kT+eh
	 7ZO73QAuG2kllIXedY72k0VjZavMqn79nSkXzG7Y08b5LmOeuVgvWLdnooBHveZiIAGti
	 yu0KPdu5tNCGdhzmDWwZnTTGKrYOqDrzXYGu8XOYhbcmHD5uErWhSjqw/YhLIQHHL+sMQ
	 9EBfn2qPp+3wRMcT4SKvjddX4Gg2ezf4J93eD/ipr5y/5u6o+t1kX15+/rje36BMmIChd
	 /pdpP+3C58XOUPZKTv2/z4tRD6kVU+vyYpY9NGqxtohY7gPFU65f/KPBBDdFCs6gK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ty04xEW5;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E2606B97F
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 179E2606B97F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ty04xEW5
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6dd059478dcso396479eaf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357572; x=1793962372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
        b=ty04xEW5QiKWPGbpGBpEp3nKt2VTDT8CuykuaSGkXPfNiyjeJ+onU9vQFSrba1PQoW
         C+KZFcLB2DluNgSVe7R8P6MmR48nT2PIL9MyPPq0Afq0zOG8cMTJvXvB+VvBOhJ+Qqlk
         /lac818g7ryWQTthpUr8whRCpTxzT8ZH9IGNPuWaEQhnj1rST3aNRqU76oJ1bjeqkquD
         0foY2jj96utSzdW0GQ3UFwUpyrKcfu0E+Lkh2JerS/4l0Jhxss0DX8ToPSUU99jtoFjS
         evf+LQJtQYRQ+AdRnpva/C0sAKLiw/hEWJxedRj0CxYigo1x2Y1YfxgQYNwFu9mutLvF
         oy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357572; x=1793962372;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
        b=G5VooO5ZbGgTTNLLgMxakchBSAc9DugB3BJLsN16L0oypbCi/Qb/JbS9ANqFxaaUmL
         yp4yxvj4VIPvXgoypNLVrCgsFjOWuvPrpRATIIdC6uhpZoO1feWZpYq9K6QDJ+u/uetb
         CcugGoVtpvgBw7lXO9Eakf5dsqhlbdP/PsU+Jda1JAI33CdTCgUAaI2DNNwLz6o8zjCm
         frG/kA8fxR7XaX+1tihYb8OW1yutTAQ6o5D2X0FwX0ic9VUuaBCQ5br3N7bBcTBS36zR
         mM2MRayxSqTlCtrC/Xoj4/MmyqF23xJYNL5m/ez3CqzmFp2fy6Q2VMtQx336ZW4RguZW
         nh1w==
X-Gm-Message-State: AFq9FYLBs1KDLXsEoARTR+sedgzFeRlbH0lmu5Bg7BCA94tuofr2ADK0
	wrQItDGWu8bY8aziK0gXkcXDIZqKnZJDhxI9mgfYr8wIyVjd2sq5XCmlADa5qIn7OBw=
X-Gm-Gg: AYBFou1KZAmUjO5v0+VIaz6eR8HGiZLW4scocv+IO1ZiWiKuC4umo3LhYqh08mO2JYr
	CLV5wsWojdv/ZnEAG6aG5ZRT8pkcoPfo1dIyoO6apJmRDLTiTYUOC/jud3PDX6FYN0uwCiUCEo9
	oaH/GJfW7yh4n6+Ns17m1fphdgysVOBAFlGGfYfXPzWCLua6qe0OZRUGHKnLatt5/GmDZIhz8Fi
	ut9mvTPiBxoqrf9cvUxicXbI8scTrK5rNo84BYD1g31b90Et73huSfmxyNtdY+SJiDf96jUP44u
	haQ9PPZ/Bn/yGwiLTpxlLOX4FIQSxslm3xUNlyz8ZPsOxJHxOWybmj5eQZg5FMBe3CJ3K0CFxSL
	4BzvA9TzN2bg9OfWYZD4YQlaSLlmp8A+xUd+1MsmUNWeYj/MQeIRRQ3pz8t4f4x3ITHSBglnH+r
	d3F7gCb/vhvQuEkgRG33Q8adpuZeh5tmgR/RfR4I7Nb6ID1iTBPQG5Y7NF6v7kpycCT1V8U5VIa
	aZ3Dqw2s+IvAFWiGD8o9f4HumpAz6cYKP4TIP47A9tfTaqXSZ24VvuIlroeMvqdtZKaQ8d9Ziog
	dfEU6LUSTFiizk6CpdFQ0AqjJlJd2n9nZ26QtsYSnUrGEUoFQH0=
X-Received: by 2002:a05:6820:a65c:10b0:6fc:373a:1775 with SMTP id 006d021491bc7-714f2ac11bbmr871341eaf.79.1793357571852;
        Fri, 30 Oct 2026 03:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d351e77c8sm1703253a34.2.2026.10.30.03.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:50 -0700 (PDT)
Message-Id: <2cba4623ee743a44a44f48e9be61dc8b1b99a913.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:29 +0000
Subject: [PATCH v13 5/6] remote: default to --limited-fetch in a shallow
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

