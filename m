Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB123F20EF
	for <git@vger.kernel.org>; Thu,  7 May 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158280; cv=none; b=kNFz1+3Qtb18cFw2Wgrouxgg3Fe9T2I2Np1fPHEx3bQpkG0YwzvAIhVT35N1Gg9vf5nYaUshE4KZ9TG8lZppiEoNosI+32ZrqKu2eai+p9NSja7tMC/Bj0WvDS/1tyrfB7qobYxk0NPg5ud7mXjDT4F7PYlGHK/RmeNkrNxQo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158280; c=relaxed/simple;
	bh=VfCQMAmV6FoOsGJZLbGBAAcrs+3HFqLvCCiBA8BbE5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z11eYHsRZYMDGvUZbgGQknMVYGwA3vbCFh/XFsmpMo80om6lNzW337vwDbgAEZd/X7clWWhUhuiJ0JjtMzJDGNMvMAmhfBfbxoPgRhPMMyS8wdP3adrkyxC8zk6Ff01mSuIw4+otXgQ/XVCnOPgovJbQt+HjM7q3oC1m4+iKb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNpB+J7c; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNpB+J7c"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ec9f099fc6so90937385a.0
        for <git@vger.kernel.org>; Thu, 07 May 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158277; x=1778763077; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo3zsNr6OqCl4Zg3E/x5GcDvn0VbcU76B0K3epfV0sI=;
        b=dNpB+J7c2BMeVcddNFb3TkHbPgNbtaKJXAhLEi33OrHH/y4/Fv+RuEALRvKx0/OTn1
         s4tMoARu+CtfRHtcvquLMyY4A/nXwMs0IMWzPPqPXV+ThJ9dgeDDfddJSx/dNPpHwopG
         leyEZzxA30nmQx8btL1fuZSDPg0ggcOwX5Uc6xbk/W23orGJy5oYzx6OhCeVa7w4Jo97
         h8WxNKIj4+RSqirEgZ06WLZrbFzqI7/GLWrs/YKMnjN/iJ0wjNulA8xA3/eRcZQLwXJb
         5mhzFm+WknGaZmiStCCJ7UrShIwSfroAOKCyeCRU///kuy62fbl77+rKgt9vUVAlmqWk
         ouNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158277; x=1778763077;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fo3zsNr6OqCl4Zg3E/x5GcDvn0VbcU76B0K3epfV0sI=;
        b=NcSg+69pmBTKQ5HR6VNEbOA8hORPb9MBLntGIRz+0XrkfXuAsKi9eK2Iwsaoqya/m5
         Wwak8ww1JzJVcgF+WBnlhMBuff3TwFzq4f0RQ3tuvyV3LFKOEBW5WweVvbE7NAyWBnzU
         f8HZXRHBS/354C7YJzk15b1dMkyOkbiIWmMW/sjdl36ahjG6PeI1+n1oaBaNYJW1j97F
         YFBd0vpooKq/SdDZzMtdMRYI035l1RD6qFPrMXXOceB+CSMM8AHnpGhLDfZkuCq2pCaR
         HLFJes/HaC71q5OBtHmL6vlpc5eTfV4VcVfvP0nVPBv/DkjJ9WuewCkAGIEqrhfrIXif
         QHKA==
X-Gm-Message-State: AOJu0Yz5va1mQhoVMSOsm7Tg2csJbJH/01Zwlz1hdfpJ5h7Pak4V6p/R
	R+z2DjPQH9Y+sZ8XIZ6iiquPFEkoDKJu1rkTfgPjc9CrXcibgan/N3lnoqskpcQr
X-Gm-Gg: AeBDievoMbPFWKPBoBs6D8wlaA2CfbiVRUeFVj3MkYtNOJgi/uLjU7Dil5fXSLOv6j/
	sZ7hyvvIx6NkFM6I5hGahvUktLO3fnK4bxxqjh2JF5beEBkUTE5zw03e71VARFzr7Zk0lfxaAeH
	6vi+Iqr17IF1+h8tmYCJBJT2bhob8lxdh/7wIWHwS0Io7wazo1xuM8FtX4Q84DD4AFIfC1qOTk5
	Kwt7obTn0C47odUrjytRlBCWa8X9O7ph1LG0T62bqyH/kKU66UTPqoSApl9wk9AyCPfh1ucxHGM
	VN0USNA2X6hFUIVslknHfc/dq++5rdgIHp4IAnARv5rFLfHiyDGp/HGKUP+PpE3H1ASduxGIAd4
	fbuHSqvwN11ovg2vkWk5jWIUwSDx0a80l71L+c2OLBwlsIkNw3vkn6aoKen0drVOQDAHs6cdLJI
	sBCEepM1T+ICjv89lM8nQRY9JFbaHfudks+JA=
X-Received: by 2002:a05:620a:2592:b0:8ca:fe5c:ea6d with SMTP id af79cd13be357-904d72b9846mr1083928885a.59.1778158277276;
        Thu, 07 May 2026 05:51:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a7a627sm1968007985a.17.2026.05.07.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:51:16 -0700 (PDT)
Message-Id: <66219b79fa3808a85d2c0e1aee03a4979ca01116.1778158273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
	<pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 12:51:13 +0000
Subject: [PATCH v2 2/2] maintenance(geometric): do release the `.idx` files
 before repacking
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As is done for all the other maintenance tasks, let's release the ODB
also before starting the geometric repacking. That way, the `.idx` files
won't be `mmap()`ed when they are to be deleted (which does not work on
Windows because you cannot delete files on that platform as long as they
are kept open by a process).

This regression was introduced by 9bc151850c1c (builtin/maintenance:
introduce "geometric-repack" task, 2025-10-24), but was only noticed
once geometric repacking was made the default in 452b12c2e0fe (builtin/
maintenance: use "geometric" strategy by default, 2026-02-24).

The fix recapitulates my work from df76ee7b77f0 (run-command: offer to
close the object store before running, 2021-09-09) & friends.

To guard against future regressions of this kind, add a check to
`run_and_verify_geometric_pack()` in `t7900` that detects orphaned
`.idx` files left behind after repacking. Contrary to interactive
calls, the `git maintenance` call in that test case would _not_ block on
Windows, asking whether to retry deleting that file, which is the reason
why this bug was not caught earlier.

Furthermore, since the default behavior of `DeleteFileW()` was changed
at some point between Windows 10 Build 17134.1304 and Build 18363.657
to use POSIX semantics (see https://stackoverflow.com/a/60512798),
the added orphaned-`.idx` check would be insufficient to catch this
regression on modern Windows without emulating legacy delete semantics
via `GIT_TEST_LEGACY_DELETE=1`.

This fixes https://github.com/git-for-windows/git/issues/6210.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c           |  1 +
 t/t7900-maintenance.sh | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3a71e314c9..84a66d3240 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1590,6 +1590,7 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	pack_geometry_split(&geometry);
 
 	child.git_cmd = 1;
+	child.odb_to_close = the_repository->objects;
 
 	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
 	if (geometry.split < geometry.pack_nr)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc1..f497f51b23 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -532,7 +532,16 @@ run_and_verify_geometric_pack () {
 
 	# And verify that there are no loose objects anymore.
 	git count-objects -v >count &&
-	test_grep '^count: 0$' count
+	test_grep '^count: 0$' count &&
+
+	# Verify that no orphaned .idx files were left behind. On
+	# Windows, a missing odb_to_close causes the parent to hold
+	# mmap handles on .idx files, silently preventing their
+	# deletion by the child git-repack process.
+	ls .git/objects/pack/pack-*.idx .git/objects/pack/pack-*.pack |
+	sed "s/\.pack$/.idx/" |
+	sort | uniq -u >orphaned-idx &&
+	test_must_be_empty orphaned-idx
 }
 
 test_expect_success 'geometric repacking task' '
@@ -580,8 +589,19 @@ test_expect_success 'geometric repacking task' '
 
 		# And these two small packs should now be merged via the
 		# geometric repack. The large packfile should remain intact.
+		cp -R .git/objects .git/objects.save &&
 		run_and_verify_geometric_pack 2 &&
 
+		# On Windows, verify the same with legacy delete semantics
+		# that reject deletion of mmap-held .idx files.
+		if test_have_prereq MINGW
+		then
+			rm -rf .git/objects &&
+			mv .git/objects.save .git/objects &&
+			test_env GIT_TEST_LEGACY_DELETE=1 \
+				run_and_verify_geometric_pack 2
+		fi &&
+
 		# If we now add two more objects and repack twice we should
 		# then see another all-into-one repack. This time around
 		# though, as we have unreachable objects, we should also see a
-- 
gitgitgadget
