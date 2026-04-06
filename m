Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472863242BE
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500249; cv=none; b=nYJRUUtVC43AmQzB94MIGR8qeMy+oKuXImAAjP37eudPJBmJyRIwSKyywEOf03CQq91FuH/Gg6Zf9btnJ1wGg+eHkJtdV4Angeiv9uqyQYJsFpMLZcr82qQzpXQ11L4YeKjCGT0qoOnDNv2HTOYmUzYgI8qwC/pYUl8s4yIJI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500249; c=relaxed/simple;
	bh=+pgyDuEN/QNLFqvN4GBo1W5uOTLKHKFL+TWmzdOPhmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNiGx0SOPhIcgfJ2l0C/u1BXaK8sqHDQhqSfHlDz1uBO75MFrKJtdNtUnHUmZtxKVmOiV7SWkQdMxXc4JdatTIvuMxNYQIxnrKxcpj5vQS/MaICReSW+M4OaXlmhyntIBGrzv5c5C/+41nMyhFJhimHbCv1DvKzXRgHi9XASBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sti44T0l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sti44T0l"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so3800440a91.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775500247; x=1776105047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbEVj9PUkB0W+4mRH6L6iiGdhe+5WG2Fsg7sYh2th8Q=;
        b=Sti44T0lfwmsNvf+dNvDAJj1sIR/DzvsKtBY0B1+kaDLSgRzYM/8CwRS13wKG2VK5G
         ziIP6fGLdUTzD1lDXOSTk8elj5VMF0miYtC3GR1hIrNzpauAuCOQI7y8Ommwx/vQ7dpZ
         8GbH/ghI2+IAU3eQPbgTvejEQi4uOjlWkpv8VOokLgaEyXOVxvsE/yjCjs+Qln6oVzzd
         HgnnJ+W81dbLWaBIoF007GQMjCR8vFYpeG/J3NebKhspCdXGkmPGBZHdRFvz0ZG4PB7p
         Xtrf2lrvD68HsDA6q4flFORaZ5yfYf2wUiOoxpo0TSv9sBTqnHSoxGkTEce88k1aJaht
         vWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500247; x=1776105047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbEVj9PUkB0W+4mRH6L6iiGdhe+5WG2Fsg7sYh2th8Q=;
        b=atznUrEU1A+iersgX4ZrdRVp6V5yMEKSnmbKWhfsFua+haXNW6MMVu64lc0xB2Gd9v
         uepf0SRbCXf/TkDBeZTqFLxLnSqgDHSBYIdse9n3BZvN6l25zIdCLg9SCQwMXppENLzn
         bkiyqffuujktA8QWKmFpLEGI9iZj83IBx9X99rmHvDw8j3A9hzFaecWjg6LKuVLYiSDV
         2mUIPLDQjHlNVagRwCMHLsyn0HRY6H2W6R+41RmZant81vjmLT+hkLlJ2U1DvatMKscY
         PJqT5xSuPsBzeM0dnf0EWLUiWKgHrt8uYack3s7RFs3T//S3pfueOuhopCJp0NjsefOm
         I3ag==
X-Gm-Message-State: AOJu0Ywu65tc9Abysy0kx2N9CuvXkaKVuggpnUl2WUABuKE8/rI8VMLW
	ahM/pBtKvf+ov7J6b8fFM58YiekkuGoPPUmxeRVifMxzLDPkBIwjCEsyS0i+H3hy
X-Gm-Gg: AeBDiethFLiz8V5acQ2B450Hs5Lm/Hg0CmXjRZ6Ei3RCBxAnLVOn2Go/nka+xqPUH+D
	C5HRkIApoIac65PBputr18dMqwAt5WvCoufTegs1GXt+wqCMYH6k1XRkAGDvq3mBLE7ryGata3F
	QHabVqs9XYIjGdnr06uw1rOt8DdeVz8+/j9GUwISVmSUipGVX3jEfX0c/81dEkeSEXoTU4TbxQg
	ROBU+yRMMW9Hjq8lceNnNNNmx0QZiNYvT7Jtn/JC5ectj6s1ki2rfEEfnDDDobBZGfLhWiCI/Lt
	n/iYE/f064HChXOTcevZ42fza+TEAniPTHBlGdSFSgMygls3Jb74mRMyDV4ChDeQhNkza5Z46G/
	z4pNyvyhxLRgKmTpaPlE+q9PztNNJJrdv0dJQPGZKdyLOzlMlfAecGdd1GMNk2NNC0ME8Z1JMb1
	deOhV57ITEbmJl68GogmHy9LGf30A/CQamG22YQXP4UwIp4KKVsmgRxYBEghqaxYIoW0B/O6NV5
	VeSTEbnmM4dWZVTmOeK
X-Received: by 2002:a17:90a:1216:b0:35e:1d33:2324 with SMTP id 98e67ed59e1d1-35e1d333c7fmr150614a91.14.1775500246852;
        Mon, 06 Apr 2026 11:30:46 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd368f538sm21353614a91.14.2026.04.06.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:30:46 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the correct repository
Date: Tue,  7 Apr 2026 03:30:41 +0900
Message-ID: <20260406183041.783800-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.53.0.750.g0a20ceeeef.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fetch_objects() reads the promisor.quiet configuration from
the_repository instead of the repo parameter it receives.

This means that when git lazy-fetches objects for a non-main
repository, eg. a submodule that is itself a partial clone opened
via repo_submodule_init(). The submodule's own promisor.quiet
setting is ignored and the superproject's setting is used instead.

Fix by replacing the_repository with repo in the repo_config_get_bool()
call. The practical trigger is git grep --recurse-submodules on a
superproject where the submodule is a partial clone.

Add a test where promisor.quiet is set only in a partial-clone
submodule; a lazy fetch triggered by "git grep --recurse-submodules"
must honor that setting.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
nit: This cleanup was explicitly noted as needed in 5d215a7b3e
("promisor-remote: make promisor_remote_reinit() not depend on
the_repository", 2024-10-17), where Patrick Steinhardt wrote:
"Those sites should eventually be cleaned up in a later patch series."

 promisor-remote.c        |  2 +-
 t/t0410-partial-clone.sh | 45 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 96fa215b06..225260b05f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -46,7 +46,7 @@ static int fetch_objects(struct repository *repo,
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     "--filter=blob:none", "--stdin", NULL);
-	if (!repo_config_get_bool(the_repository, "promisor.quiet", &quiet) && quiet)
+	if (!repo_config_get_bool(repo, "promisor.quiet", &quiet) && quiet)
 		strvec_push(&child.args, "--quiet");
 	if (start_command(&child))
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 52e19728a3..dff442da20 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -717,7 +717,29 @@ test_expect_success 'setup for promisor.quiet tests' '
 	git -C server rm foo.t &&
 	git -C server commit -m remove &&
 	git -C server config uploadpack.allowanysha1inwant 1 &&
-	git -C server config uploadpack.allowfilter 1
+	git -C server config uploadpack.allowfilter 1 &&
+
+	# Setup for submodule repo test: superproject whose submodule is a
+	# partial clone, so that promisor.quiet is read via a non-main repo.
+	rm -rf sub-pc-src sub-pc-srv.bare super-src super-work &&
+	git init sub-pc-src &&
+	test_commit -C sub-pc-src initial file.txt "hello" &&
+
+	git clone --bare sub-pc-src sub-pc-srv.bare &&
+	git -C sub-pc-srv.bare config uploadpack.allowfilter 1 &&
+	git -C sub-pc-srv.bare config uploadpack.allowanysha1inwant 1 &&
+
+	git init super-src &&
+	git -C super-src -c protocol.file.allow=always \
+		submodule add "file://$(pwd)/sub-pc-srv.bare" sub &&
+	git -C super-src commit -m "add submodule" &&
+
+	git -c protocol.file.allow=always clone super-src super-work &&
+	git -C super-work -c protocol.file.allow=always \
+		submodule update --init --filter=blob:none sub &&
+
+	# Allow file:// in the submodule so that lazy-fetch subprocesses work.
+	git -C super-work/sub config protocol.file.allow always
 '
 
 test_expect_success TTY 'promisor.quiet=false shows progress messages' '
@@ -752,6 +774,27 @@ test_expect_success TTY 'promisor.quiet=unconfigured shows progress messages' '
 	grep "Receiving objects" err
 '
 
+test_expect_success 'promisor.quiet from submodule repo is honored' '
+	rm -f pc-quiet-trace &&
+
+	# Set promisor.quiet only in the submodule, not the superproject.
+	git -C super-work/sub config promisor.quiet true &&
+
+	# Push a new commit+blob to the server; the blob stays missing in the
+	# partial-clone submodule until a lazy fetch is triggered.
+	test_commit -C sub-pc-src updated new-file.txt "world" &&
+	git -C sub-pc-src push "$(pwd)/sub-pc-srv.bare" HEAD:master &&
+	git -C super-work/sub -c protocol.file.allow=always fetch origin &&
+	git -C super-work/sub reset --mixed origin/master &&
+
+	# grep descends into the submodule and triggers a lazy fetch for the
+	# missing blob; verify the fetch subprocess carries --quiet.
+	GIT_TRACE2_EVENT="$(pwd)/pc-quiet-trace" \
+		git -C super-work grep --cached --recurse-submodules "world" \
+		2>/dev/null &&
+	grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.43.0

