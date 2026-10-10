Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E735A39F
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619348; cv=none; b=GEvdI2xkJ3/eifQRQWoMdxV276I4rdSUcFq7M36+obKQFPwWgexX0F6ehXLt/aaK4L8GX/RIM1OcBeaQIQLu6mLHb848mNdMNclztrQeywoWW2WKj0xSbBKdeW4e1VNeJ+1pXGI1ZFX2A7zNP3iX/9b43l/wMxQoNLH+vNERazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619348; c=relaxed/simple;
	bh=JB2qh43jJmR2/5EX0tzAwNASpHp9OSxQ4sNUChn5fsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AjgBSTO8IHli+MbwxRudyfGbSRNYfQyJBL8Qe+j2ckd3yNGzSfoEuh/HdPVAxsYlX0yJClcuWhmpIO4eEaHGgaEWXThLvZCpCdU7oinau020vXtVSvB7ggYjW+0osVqC/0svx1ob3NlMncXnv0Hw2LBTGIccDM5U/yggXaiFnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ7ScaQw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ7ScaQw"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93cbee4b010so25875785a.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619345; x=1792224145; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=lZ7ScaQwjK0XFfcTIe0BOL8QL+VVpYKjXPbetPqA11p6ppi1IxyvSRv04dOlk2SJ4H
         0dtBFL+VJSX1amUBp2NHi/4CecPtw3liJpzBTsGZMhSbqfiXnyh0Rp0d9uXwLR0ZsVP7
         U6GqaenVFuh3U1IUblWP0ALDM//4ZPksQh8a5Ql8vYFvxITOM/G4dY7Dx4KCk5ymWuqP
         hBHh+dKOpVHVnYIhMI7wAVOfQCCxIpQvo8eiUGGWzRCBIGS5AmtY+o64fR/hFJ3Ged2M
         EWQgglqrxqHbRt18dqEW+il8ycdhcdodUlyR5HJjuwScTr3FjNllRuCUfPluceUKl8Lp
         jojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619345; x=1792224145;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=Xh8snUe6JMfEheISboy8HgEWGsVlxUaXcsaKNbzLPaYG2USx6av7P4Z7WkNDFbG2IK
         PexQlmqUkQHadFK6+SXXhcZRctUtQO74yptUDp3ENqjqnV1rCCvAKNDJHskUDowADj/0
         4McHAeb/aAu7dycUyqZ8zG1Gu4OSmxtsdCJBEOWhfoGVLfHlwGwxNwfB1E8Z0Euol7mI
         xtuParlwooFrOueHh2o/P+HquTdHJvu48irEeoJWP4gbVrh6+CcBgB2R4PHMTfS8lV3i
         TcHF0CravKKSi9hMf1oCKEGHb4Xv/Uq1GN2FEpaISoU6Hz9JVwQbSOZ30TjEh1Fj1d8I
         iIIg==
X-Gm-Message-State: AFq9FYJL7OkRMhc+6361AYt8s0grI69MEgbpmE1say0dBfRyuUXPoK7i
	9dGArNSkk14YvPfhRnij9uafhKGU9yfRx53bKE6sHUUOXc3etLFC/kZX7A1qqg==
X-Gm-Gg: AYBFou0aVzvISrnEh5Je3UCZROtrSFNLNaXqwbWkTn5T/ES2THn9BSAiivxbl9ulK+4
	9IrjL5SnIUKzuZ7QfFlRddyg4iz97sLRAf2IbsHXJmEQq/kGe/axo0trPGOmrjK7ARyHMJ1WeRD
	TtPGbyZ/rqIrwdU0n1NvpXinpZD/59uoUhqHm8pHrvY2bq3tz98TwWe8whkKIjUJMlFXDXXuYLD
	O/MFQJXfWadC+9qTVwQ2gLf3oGFkV2u9l6+xQzu0VVkORIqAyeDQ58wA2xt5e7UGKSV1j6WAU+X
	J59qwJTcRJilheha5WACGmX+V5lOLr8Ps8RxCfwTH8vyxYDnyslLotLhL1sA4P9x/26RuB56jYb
	SjWMUYZ/iKXyOfAO88STDl6mHTirV9MYzVa1n+js314Pe9YjdxO8CYdB1rNZRQISDvjdZuyoehF
	PJU08m+hW+7StA1M6aZjcaOg/7MqFBzgW4y5oYUQQUMzR1lc0W5fAUPHrQzbQgMiHZ0vAUP+jsV
	L0=
X-Received: by 2002:a05:620a:1a1e:b0:93b:d7a2:dd32 with SMTP id af79cd13be357-93ebd29ff75mr662098285a.66.1791619345300;
        Sat, 10 Oct 2026 01:02:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984b499sm371308285a.11.2026.10.10.01.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:02:22 -0700 (PDT)
Message-Id: <db27c290866c893591a3c69b460cf245c0dacf5d.1791619334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 08:02:14 +0000
Subject: [PATCH v8 5/5] remote: default to --limited-fetch in a shallow
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
