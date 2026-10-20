Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503805;
	b=PhCEexQbeubbcQPiqTErROH4/DPD6iMO75jnKXGfV2XKi+WoQWxw4acZnX+L3rnFHN7o
	 l+p/gQvUCFe7BDGc9w7fv3pakg50e3bJaOWVMR/0YFPLbcff0gplYtRHvnjgSkzFcy9Ex
	 pRXXuqhw2Qvpqs0uY866vN60AezbVIh3ePoysaanwr3kGShrNuOlcZwbhW9yRO30vWv4f
	 XlG33mvBRscFr/5YSbLxlQ1xYxsfHma7+jZNeEeukHwE+gn30UVCeplAehpYMwBThW2jf
	 NW5d72QwOwB0Z1+6QuGWyDymyRnB6b3CfKbssgjJpEOVRpxEY9v6P/5m9xmI+E/vT4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=yfjclvMCidjgI1/hccxT+IR4akQ2bjn8JTa94E/11Xk=;
	b=FZV/k3Kxxdt/MaRVlcbtzrcwzhivg5yZbd8s+FPRYsvWyYYr2oMWmzv+Of9ePhT0k31U
	 jYOfoQ6HtS2YzA3Q9wc894yuuMUFXyN9t29rM05iO3hlgYAQWbC5dFntGlp58ktgcm0Al
	 VCR557zPz7d+QwsmC9svKV/vV0cAeHLwoy7B9q0jDnp75mNqvluOTjTRZ/jXuvSmwcZmX
	 9VEWlVj+vIDIkwa6oh7nkath3WJZNsM1WvFC+hIpOpyQtjUrgF7DBBiAJ44T9TsOKDx5o
	 QlPjbBefY+yrFmMC48npdRGWJ0WuMkOTGWj5ulzgay2RZrkAA7G2SGMHlIJZJSyVVCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rEFlnVMF;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084A60A380C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A084A60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rEFlnVMF
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso7707364eec.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503804; x=1793108604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yfjclvMCidjgI1/hccxT+IR4akQ2bjn8JTa94E/11Xk=;
        b=rEFlnVMFzx1bsKTCH1sNl0Kv7ctjiffFZbKkTCjoetXa3TWx5dTD4m1o54KxzjzOjA
         mhpnJwK41jiW9BE5Aj3nY3ipKFUiBw0SK2rA47EAUQzGp0WjVz3Gdkhyb2eaqzdD9eYo
         bSF+nOfeB6xcMZ+G1wrJz+mXBKjZPNvdtJB2jiDbWdWtoEeSnzRS+du1dp15PBlCko0R
         LdDTpYu5QR5lCQtyj1UVLDVMvCIagFWsAsTARUNuHFj+UYiqne0i27W96/Wlym0WdzRn
         6EBNQaEnsNYdSXhI8U/RXppBxffgmJprPed12i/wdsoas8A9kZ35O0BYLWHzxaDz+SrT
         1xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503804; x=1793108604;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfjclvMCidjgI1/hccxT+IR4akQ2bjn8JTa94E/11Xk=;
        b=Wh4caf2j/Q+ny3i0w1KfpLo9sJmVOfa/k3QVNKy+OI+GZk64H8b+4WzcAd2eFqv9JQ
         a7huyrAorjBlV+OpV9MvhX0OKpm3TaUCcSaO8NwfMTboCSkKoN06HJsMr+mnl0UR8sSg
         bIh0Q5B00Jl8EiGYbx+NEKM+RSlQzARCenCdrXjIjh0bQdlsq1VsJRrVU1HQvj22CSXX
         lMkZ6gyg9Svyx/MnOjopq7lPJs9EYGJwnkZea/yFCQ/fOM6L4udrP7OLOb1cpT5LUrK8
         fu6TpYt11QOK2P8vQfnWqSmLeiCMSpX98eqs0aPp7mXFx69uJQelQEKcvwgEf17gXBJm
         MXqQ==
X-Gm-Message-State: AFq9FYKiOBx1M7LKfm5iP2Msu2pHCZqyy8KeQQzmn094JMXGRdYawmlb
	r0zk4Ii8dvTirCnoKuuRtnYdsiC4O3NKOIkBz69JTlguMKC/YAWqFASQPz3MSDum
X-Gm-Gg: AYBFou3U6vg1+NIX9aWH+b2xwwhyCdSCYuuVznhepIuM0eu2g4mCvrB5pnyHjhYHyIh
	u6P+8FOSGgo2/R2Er3j3vw1oYfI8jwgfO3YG3WYY3Qpk/BHQjmcwxhFUHzXL/LlchiFP+TXfI/6
	A4vVJ+mSkCCCZh4WdELy61TrDmPrMaDmFhHG6qUdnrEJlB2oFel1yej+Ol0aB9a69KW8zG9LuUN
	KSw1Yxqq7LuvSQYIJE0O92Fc0cuKLlk5Z2DxchMKIXFCd3dH0tiQ8ShsaRieo0bQwfccKAz3PFe
	A0KyFOHobc5BgJdjDxGTv2zuB7TbAF6vf9gCAYASbPO/7nyoahd/GIQsW6c8VMWRv4qFRzl0pzo
	t/5Cyd6YNYwvfDqmk3UG0wZzV4KS7Akpdv8+FJ4zkDHTlbkBfmeXDhrX+ykzgSjDCH24L2dD1/F
	Nn2IGww5gf/D9IyoA9VXwhwD4HByZxgeae6pyocKowjXDG4zdqyTWAxMOZuhNEqbK64R1dX9uYy
	oGMATuZZg==
X-Received: by 2002:a05:7301:424b:b0:359:ef9:9be3 with SMTP id 5a478bee46e88-361a1667375mr15770948eec.11.1792503803418;
        Tue, 20 Oct 2026 06:43:23 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.77.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b684dsm41112754eec.10.2026.10.20.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:43:22 -0700 (PDT)
Message-Id: <552bf08971be5204311c96bf232b5da49e852db1.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:42:58 +0000
Subject: [PATCH v10 5/5] remote: default to --limited-fetch in a shallow
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
index a7c13946d1..8c4497cccd 100644
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
