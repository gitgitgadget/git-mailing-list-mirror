Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959929;
	b=mhB1O1/KhzP4iCRYuBhA86fIKFu3kNP4iNuyJwCmaMtTFtrhA/r1Vd/90aHuOhAZQ6VM
	 4/SRYS7jtubhq/e1uwfQrNmJGbKLdTqlCC4Z0c4bl7uGCuF7cOJ/CfZsYNK6g23e4uDiM
	 T+tXvLV14CnkogL04L7LnXokq/WryBveyRBHX9/Y3BipUA611aJL2LpeeiIWD/lK44vYR
	 v/9eoBaUL1QHXVzWqDCUnhWwsCsqpqrK9IGMY/BFDKiK3JFfRu4+MFd+Pr1X8nBT/YLrd
	 Tft1jx016fQKcvOMN3AMqCkrfpQ4hX20a/RdVtikKwF9u4czBBBbDqRxRsANSDD24QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=eeEeIh6RGxgGnQ1M/hXIkUZ9QO/4BOzBPOxSHWSbkPk=;
	b=POkiJt1LZlotCE727qtqhvPvS62R/uQtm09tMIuWWsKKkop46ZzLH622dUKK2Ntomw+G
	 bWDbLC47n+EdnI0KnTRYubHUXhCwGgLk7sMJOWdP7oRICP8injX8stQ3vGtCShszhZCim
	 YLgGpWDIUIMIJ9ki4fbneyIqe46jOyh0pRiCodZtedXQ/nJjbKm23m0Vs0wUc8qsn66HN
	 TwCZV+SXOyq+fl2LUU428SuWzc2YQ1DFqvqj9CL30DqMONDpV1/M3zfZ9zDBBYHe/kMj7
	 0QRfBAB2te+u9yLCnOb/5dSSlhFzyJ6m6sXcFMlUHWAtmoyJIcAlPDwFkBEGn+1PxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EYbV/uZn";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176B606A31E
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5176B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EYbV/uZn
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35f036b17easo6284224eec.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959928; x=1793564728; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eeEeIh6RGxgGnQ1M/hXIkUZ9QO/4BOzBPOxSHWSbkPk=;
        b=EYbV/uZnoOIHS82Yp1QiOeTbbAzmMiDCk+clJ9RLK99Y75Tp8rtGVCzLrmVqV0ZYfO
         kLUkXd1O3wLWiiCz95CAZWtCXxCb75T/zue2dw69IeE3OJppX0a2Mkuj4IFz1HawGIM2
         lTtPoDTElbVgiPSjVwPgzPIIjmF8RTDOe3b3PUVoZZNy37bbD2vEd8Nx7CgI6sK/sUop
         3t5bZuPJPlJobitsrg2+qnq9ziGiFQltgaAqel8/+KdwhD6jnwG1qhnvATWBxybh9HtJ
         UBe5ZIyvbXOb7avfHpT8C1S6mkbUb3lJiEZ4YK6GmtUbTHC/fhN8+dTWGdCt2LGmswQM
         QXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959928; x=1793564728;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeEeIh6RGxgGnQ1M/hXIkUZ9QO/4BOzBPOxSHWSbkPk=;
        b=dyPO8BTwsMPYhzBICy/CWela4H37XiEJ4ArG3KBxaG5Bah0v0RkE0Paz2PwY9v4uwh
         CECaQFBLTv1WrD4X5VP/A5hPDPSC2eIO7A3C6nHQYahSd3VZ61OtZNuVoLZ/PPDiquWK
         qTJ1J6hXQPpbomP96eQArO8Vjt53dh1RCGVbKMBr4Gb9E8eDYWtf0BGmSV/Ba949Zmld
         GTVYakH4/XcQ05kZNsFv94JkluBrEX5JO8STXyFNWGGwuL2Ji9COIH5xvJZbzdbzq5EB
         VHgzbokT37t+nU6vWTJEr27tkb36dEI+6RfL3r5Mo7H+4AGSFTTV2P6Zb6aEj2DgDVLS
         UZmw==
X-Gm-Message-State: AFq9FYLbm5+ArFSnZ/eWdHQzqwuDTbRWALkM58NH3DagNi1tZ98iyVwJ
	9Fp9S9snfXtu8RciToLQTSSos+7HwtXEWVutvuZboeLl+sQpjoht2suQmo5mX5rdFMc=
X-Gm-Gg: AYBFou3IGxrJTPgan9YGrCiz8zzCWpr9sGo09+yqz37QRvABsSiKsF/SpedYmTSFOmL
	POUXtSLd8yidMTWZD4KIGBYAdRTIhWH+G7vps1v1eOoL8quJci+mIplULTa1f1bowLukpfFTONQ
	QfSYEm5cdI7+vCEQpiMyqxV9F+LVqN1I9ojfbMdj3hD98QVzx7/G72/ViHfAN3OE7dvGLBYQ4b4
	Fjp0r7bBPdhz8Aep7ix91GwvX7UrRlKrkO8FEDbLLEaiM0eTUuFwAmGKNcVhlPtfntH6svRGTVv
	W/kG9xzckI16IbG439CWJozzD58/6sKYQXgbdHxE7LCmZUt3vy3uBt1QGSutKMrTTI/5v9Wlkiq
	QyzJk13OxWHQftQrYYGPxjOWzyilYfrbNri40Rn3b6XgGH2ziNt3IgSi314PdrlCfenO0ariq3t
	/DrV9peZN5WZdTweeslh1we8IsrVn7sdlbkW1NraVgzxEyb2MJ6UQST5ETGKH+yL9v/IDUhYWuC
	21qkquW/B+gqYFKnlQMhRvDDG+5xgYt1TQp8RM1/BdUhnEnAzDZNX9e
X-Received: by 2002:a05:7300:2301:b0:347:8d01:164f with SMTP id 5a478bee46e88-369e84b15ccmr11938059eec.19.1792959928267;
        Sun, 25 Oct 2026 13:25:28 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.195.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee72c0sm28361533eec.29.2026.10.25.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:25:27 -0700 (PDT)
Message-Id: <de0daa8623b76c47b5c822d0aaa4287950f5c780.1792959921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 20:25:21 +0000
Subject: [PATCH v11 5/5] remote: default to --limited-fetch in a shallow
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
index f8764394e7..f43d707c91 100644
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
index 7e81a91aef..0104f23761 100644
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
