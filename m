Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348657;
	b=RmeNODp6gc+aFZ9A6/hlr/P5mpDE+WG0yMz0jRUAkVhD54lbAKXiK8vBPUv4X6/uhpmg
	 D5SZhv2jzMFlN+vliVpS5VV19HA7JOP8UxB526+wuvHBdYAqz6PjQ7WM828qMXOZBX3gv
	 oB0vRtJxzfV+5cnbZTKLw8eb+Jgs6f8rub0RQ4qgNFjOXtjtZZquX00dAAmYt2Cd5XJDU
	 AunVZklV90JkUTgJNSpTWsd3EfvlqYWZvC+KGn375sfja8TbJ0wd7k6xK6C4elBOHr0H6
	 hx8ujwUPDnHlNQyRmliFklfjDch1C1mBKN8DaG+ja+94cGpeuN53ZBLSMf7L3nUoCDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=FXvUa+v3783bEjtES8kLbQjJZyDPHExcsbD+gxjGdbU=;
	b=frxuqYGW1PgdhwpIEWt2bMiIZFurkjHXiZSDrxpOiI8XkbSeQvlcV0YH4qIbHqUM5lgg
	 9rb5H6xCq1M0kOqdEzH3XJEJ+YUzxCv8X2PbvKp9IOFvIocpdqrUOsdcyVIhiC2N24fv0
	 QgFQ6sFWvzkqfOjCotqJTlebbq3CJgnfyrkPjHHpXmC6boWf1HQ0SD6wMN7Y7KAM8mNwa
	 GBSdTrJkYMHJ65yjWM/nT6mVoOwVCoAc72OaQ+0tBaGQn9bLV1GpwwMZGsU+xLRUNKup5
	 n6PzR9+QBjXp4ynrfYFL6ZmIZAJxxCmNicqzEQAAfNfm0z3fWJhHTll795qEUqoovJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABGP9PkO;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE05606A32C
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE05606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABGP9PkO
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so4957139eec.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348656; x=1795953456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FXvUa+v3783bEjtES8kLbQjJZyDPHExcsbD+gxjGdbU=;
        b=ABGP9PkOkqaMSUkBNWWYhH67fvISZNUS4893IQ2Ltiqkdob4olYtwhiV4dVpNivphV
         V3m+chsciNGgCdmPpjoGYI6nuWIfB7zS6XlN5DwTxAuA8m0Ztz+83TG+QwoMEgWccD8L
         szt8Qb0SPIvHRE/NYeHE0dly9d4Gucb1ym5c99xuPUh1i5yF4MT3za63rKZh+DaiMpPF
         MlWEjjaplBZVhdRCRF1Lc8fjlt3cF4/+oywMMMbiAkoq4AIPBpqd4rNqbWfd4oiIMAt6
         6TsT0Nl+Vq+A9dKMiUUJa6hbz96Ei/7bjYI5GDkage4AJU/Lh/ycVRqsUpYheWP39eDy
         XBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348656; x=1795953456;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FXvUa+v3783bEjtES8kLbQjJZyDPHExcsbD+gxjGdbU=;
        b=C97vXlgH3aWIbjgxFjp5rV6PDKcqOeOqzgKfBCyRb2ht63OEzVCcJZq2UBM/OXwuKF
         qCjpu6X8ZGuw9ByWLn2gJFv7ATQyYBfcUqrZYiQ1UwI8gU9/l4LOwD+3Xj2s5NjPKn43
         bkMr1dHYx1+UqrBuH2uUDehOz1wlq7i+7R2OjcQ8fkV/KOCzJdu6I8tpa0aaEi3pADLf
         eJOFKVQpoefo+sxQuPMJxZ517utg3W+hAdjQh98xFA3G5lIFm7IVrgyoISe3u/nabbtJ
         h7EwQRlmpXcjW96icKfnPqcGBK2VnDvv348sOMXURqbq929OR5XS+3/Tsb2/Rwaz/KBO
         Orng==
X-Gm-Message-State: APuU4Z/FEZOKPgGIqlEqbDWrSl0z+snqgSEq173nUj+rFFUGJTKfkDAk
	dOIKaqaYtCV9lN/8WW3czIp7HISlG6VQ/8pgxcju1f/obQkeTbVcsFX97U2clQ==
X-Gm-Gg: AZFdTZe+k1nT5kMJ+xD4u8ZT4uN2gblEWZ/PQ4BV9G/xrI0irOP++aQc1noj+i9O8WZ
	JHdAeAZZgdEGuXtSEOlOq87kTpsAr+T9q7zzj1rg9NLzs3CixDgcIHscMOm1LcoJOfkuost9ekI
	+kokxdsslg7aYlEcH5JaeFNX4draE65oT1wwkiwubCVG91ALigAKLo86TElzNDHkJf/0OTRthgv
	GhfAUoSUn5qcvL+PuNs7EMfQORBwdXA9+iIPTxKb37X2d78fbpDMpqinKll7/JywHhKpUiVSktG
	7FFTCXrlycsnEPFF2k5O/oWBOi80wdSxYbdfZDrDw1HOK+Q0T71RWaoHl8F2fz1XwbcDRdE8OMG
	t7JN5ywUux+uQ8+Itm8u+bHwyrToF2UXASnU2sZQdkgqVpyLP8NucPRCC/3p3BdDT6LvGQkolHW
	kCQt4YQeLqUpYF5XTcLwc+URXJfu9HPg4tc/4Dlj9TU13fY+jcqpvq219EXV2eipNlHRZvS7GLF
	cL6z1XLEakc5Pc8UxH1b1JsogoC0Tdvq2FUeo5bKePpQpyd5OubAz77W2moL3/Zvsulb6QPLQo3
	I/zGfm69g/jA6VPhFUSmwOOhB8V7E7R5O5Q=
X-Received: by 2002:a05:693c:39cc:b0:386:48c1:6c5e with SMTP id 5a478bee46e88-38648c1719dmr6902611eec.37.1795348656450;
        Sun, 22 Nov 2026 03:57:36 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm28036567eec.21.2026.11.22.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:35 -0800 (PST)
Message-Id: <3f06f7f9e29a2282920d340993d02fe93f121783.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:24 +0000
Subject: [PATCH v15 7/7] remote: default to --limited-fetch in a shallow
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
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
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
 Documentation/git-remote.adoc |  9 +++++-
 builtin/remote.c              |  5 ++-
 t/t5505-remote.sh             | 60 +++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 39b9281293..2216a2a752 100644
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
@@ -79,7 +84,9 @@ With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
 that tracks all branches, `remote.<name>.fetchRefmap` and
 `remote.<name>.fetchUpstreams` are set up so that a refspec-less
 `git fetch <name>` only fetches branches our local branches are built
-on. See linkgit:git-config[1] for details.
+on. See linkgit:git-config[1] for details. `--no-limited-fetch`
+explicitly disables this, overriding the shallow-repository default
+described above.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
diff --git a/builtin/remote.c b/builtin/remote.c
index 18fe6f697c..8163fcc618 100644
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
index 73f0125907..4df51255f6 100755
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
+		test_cmp_config true remote.upstream.fetchUpstreams &&
+		test_must_fail git config get remote.upstream.fetch &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
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
+		test_must_fail git config get remote.upstream.fetchRefmap &&
+		test_must_fail git config get remote.upstream.fetchUpstreams
+	)
+'
+
 test_expect_success '--limited-fetch works in a full repository too' '
 	test_when_finished "rm -rf full-add" &&
 	git clone --no-local one full-add &&
-- 
gitgitgadget
