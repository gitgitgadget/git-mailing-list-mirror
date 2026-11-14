Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681512;
	b=cxA3vy0KQSio9tMzOCFM+qcNWzWR72ULLkEumOGzYXSV8NMN3FFS7N1HGfmYkMOmCMFc
	 llzZ/sXeo46EOrIX6UlAEvNlAJa+ZDOdZovB4YCxeRPeFYcKiHEpi1z1W5TtABJ4BH8Ws
	 PQS8XNefMZ1YwhWvI6lohiOKmiy65jUzRbZ8j5SdAk4+CPGJw3hcTxji16i9ewUgpKLaa
	 xl2nua9j3+nV1ytIJZuj3baOt+Vmku3rrhOz8ofX2JeJtfcN3uHR9t6SKFLi+SiFefMIN
	 37Jv/KGFYh4/BiyXhimNynXWyJUWxWqLtQWuQckObWUppEzzUdbZ26K1AaSoBi0QHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
	b=NADJkB/vS7kp8Wavfb1n3GK0xp5g18LKK2nLGxLgf904OPb1sqZtZTddnjk51QUgeN6+
	 4u0UZZJhl+fcXlqLvcPFj+8UtEdV1u4cjzejtu7/svXHwVZ2ZwWcNQgIJox/0QeWb7Ygd
	 ZwTEtQCAVVGdZLvNHZYjn6u0QXoETQqqn8Bc+1PHiK3/s3UxiB1oVWtnXgd3p/l+4C8EY
	 yQOHuT4I+Kcn2fEgpc1Dxx3iUyQSyo2d2mlJWUC0g3Wh4wMcFA4tTBWKpRU4Ajd9538c1
	 xt36qC0EkU1crOFH4xtckoVJ4Lfk5GQEHcTi+FhTdLSrEPP5/GecJpEzGBGtikk8ftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRA187bu;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B861606A338
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B861606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRA187bu
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1078532b3a.2
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681512; x=1795286312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
        b=MRA187bu2VW0EQjG4mayV5Puy4R2/qttPqijLjW+B3o5jJGlXzHOIS8YldNpCdbj2J
         38pVj4bt87mlnl7dlbSRKXcr5dAhLMG+XpLo2P8h80EDT4EQPnQ68g3x7ghpXWMcEz77
         LSF7xFjzMEIJUwMLIGdX+FwLfHHtaZBA7QlRrM5QtDb0D0S06ZYd7n0Kwb56TO6W9+TZ
         izy3MsRYmDSEJjZsUC1IDqmTmZdCQ7Jiyhpdg2oUBWNg3K7pZhVeyb+goujXEW2+uTcp
         GIxbXCHrMigBmMxXCh9a1fArf08rjVfH4dvamZ6EsPqx1vDmNv9GasW+eR64oTIh7Dsq
         I29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681512; x=1795286312;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSxd7aYeQgNhiUaH9wbtPuHoRJGi8U1bn6Yo8HQcZNI=;
        b=xnRpitt4w1ayqeFvtCHXPNZ6poD3upwGlX0O6krSfqtrofRAZAz1WOUJK+jHsBUUIs
         RtVo2AvL7VGA+sWSMLcZc6unB1FBOo41Fx3HjSIh+4RFwE1C8Cv+UXXZNxLHPcqrqDAu
         R4lnPoNOdWRLhz+dCrEWVzMa561TTscYg2TzY7MQ0NF6MfjMZmCguOQJLNF9lv78uYme
         0mObcUpjIwpKFhXyzO5M69qwpe+SfrxuXChlKwGwpKKt7a+84eLvPzHH18kvvF4IuL/S
         +wQ+2l1wnooMycknO2PEXVQg1HPt3p7GyqRE1XkZUPUKM4FowPghFXsBBNAVMFRkLd5K
         kiYw==
X-Gm-Message-State: APuU4Z/3tVY9WwjdJiYjKSx25LyVMxPIRTsy1la6eUuOQ+TXFS/Twoxa
	GQEFzepWTKig5TuCkKy0QY6+w8gRCQJAqOXEq+H17uuebPpKj4mjUzqI93dAVNNc
X-Gm-Gg: AYBFou37UOR4Ee5lKHWjkSmfZAEL2jnj06FvVvvxW9tw/nDATcL1sKY3iuEx0vzOqgL
	aeXBMclBEJgOJJdZCPUAp7M2chGgy9leX6RTm2c6Ggv4wbvDR9d0kv1NvKaV6oYYFu7myAf+OTj
	k0bVYpU/I/PPmcbK9xlI3f4AUfOWHEhUfOGcftvbYHAcvRiajNTt9/4svnYcrnHCKql6Rcs1paI
	rDUdtMAHBrbvD/eNw7+//70iHedUrDtxGRDH+jwDIEemvA5EdiLhQHuyQmjcRUDToYXu4OVdnSB
	3ubg+lmJ3Ge54woOdaT0KKTzsp11lnrjZ5IIOhyZExV1XdLG6BNcEwVKbf0a6p+E0WFu/CYU5R6
	rqAWoUaLyOBmVjT/i3LCxjTjKELYVzrxLIj+IRgihxn3OnjI/Z7/UXI0mbXT/id3Ktgre0T76HJ
	x0zEKe4R5WS81eEcmJdGqIW87cJ+Qt2c/Ts7QYiOA10FEIzazJEBWLDHQZGwWz8GCGVGND8xeTs
	Z117NkurNsIOuhmSBgUQxXAsUHS8i6xkUYrYaG1ZML1vMOF4q1KalvxLUR5ERFJRzrfvUyefMKV
	kVaFyvk679PLxlloRq7hqWcJz7Uj3l5DdX8uyMbQBrHcZ6/eJZwZ9KaQERY6TBr5s0klJROQeVw
	f4jmDOO9E
X-Received: by 2002:a05:6a00:ab89:b0:8b5:7fc8:866f with SMTP id d2e1a72fcca58-8beb753deccmr5888505b3a.44.1794681511762;
        Sat, 14 Nov 2026 10:38:31 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-139.us-west-2.compute.amazonaws.com. [3.42.157.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190bfsm2197384b3a.50.2026.11.14.10.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:38:31 -0800 (PST)
Message-Id: <00f9d44a88e2bb187a508869ba1b7bf937afc111.1794681496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 18:38:16 +0000
Subject: [PATCH v14 5/5] remote: default to --limited-fetch in a shallow
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
