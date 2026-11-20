Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174448;
	b=Aaa9MDNz+9nqwl46qNXvYWBRbNsbBuXpwz2Oik3azskdm9E+jmKfBiVvabDzs7RN8aGC
	 bAvGXtn3r4I3WjCHE8TAL0e661MF+mvX7H0z6r6jw3LMjN6K5b5iQ2GWkLBGvm84a2OxL
	 89TuNRBQcHex0uhElrxHCIDund8wp+5oaigmyEfjceaALDYKeU/EJjSAGZEXVlNVB1HSC
	 uDJV+oqUPa7wFqk4ixSOoYT2/CBP+4hd7XYtW7cjmJ6FSi6n6/ufA3E/i1hc5ik2Fqr97
	 NO1c1Qib+EUKNfMoVxpDLG2H91ioc5H14oB5AGWTha6+9ZFUyccn7WYhasZJPyW9yZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nd1cROn/xmhzVm3Xw6VWazSGiRd52OyCERH25GG+pZM=;
	b=buR8HVdqz1twOS7vLw1m08FZqwju4G/GoLw9XXSgAk05c9SGs4oMr8Yf4pnRVcSSFqDV
	 lz38WhD3icO/pwv0MWrVTSkSmdBYYc1BUdjlfceFx4BpgkX+8AUPfOcDAcBCT/YTsamEb
	 4okaMWuDDdYqEmtPL61FMvn475E/R0n7f27Vv1MPY6JX0eRB1qt8WBFfQQLiAJUDVE6/N
	 8EtTX6ojZr1523bHNuHcZ7VU63XvOSxZv7zoSEdhNWIPI+YwQDciM/+iCdmNEbmPcsq3J
	 xAeX3+cnFdvha+Hq2xQFRkhpb3K+BR7syV/+X2HJJr9mh0RbnNA4cpGZ29nKwVZTNfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2RYEnbR;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC73606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC73606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2RYEnbR
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-385c497bf94so1210584eec.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 03:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795174447; x=1795779247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nd1cROn/xmhzVm3Xw6VWazSGiRd52OyCERH25GG+pZM=;
        b=d2RYEnbRcNfAW/UPveawYUVK1aHVQRtuFMI39q1RS/F8khp6Y+X+0C3WRjNexQCnAi
         dnG0v9xIh3WzLfmsTlrS5nzEIts4+L/WWSE2+PXiHfQaXzxsU42PunYYrJrvEmAaXG+b
         YwCZ4DGyPKJ9Ris0sHATUVD/VPCHKI9vGGDdfVyANqeb8J9K225KXbh3/4MTyud/PUz9
         WXoGgYqZ76P3VVwNI/XkWQA8koyb8oZ+/oTEyW5UOdL5filgfpEC1BYGtP0X2ygZNPT+
         fV+4DXW3axtQ1Z1y6SFfIFLnzyzp7jtF8Bra1eetbxyA2Cqd6aoVKpMz7nihpGHfeTm7
         x+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174447; x=1795779247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nd1cROn/xmhzVm3Xw6VWazSGiRd52OyCERH25GG+pZM=;
        b=VmZTx0dgqE5wJZBfyPV5RwweUYy9uNlKy8RaZw6SsTzvXWoTj7zvfqRo814CBhKZ8j
         L2xCjuYLuQamCyYEbvoXzPGfvs2rPqXmX9mjL+43j7ejMDk8Xl2R/G/3wrh7aHGqfg8a
         grdFN+ReXJ6SqZ2tn6dYCmHyEhMiJOzHJ/1kNSNuCQQ6VPWGRUziHJRi80GiVsuEiaFE
         0V14SkPfYWAB3h3mXgrFQuJtO4/jaLMUxpFZJQo4XwD0epudmwF3smHUVlS/SBrZXmke
         LtafHU+JK3QdyWswAWsfcqc6vcFKNpAW6g1pZUjFnWl2X2+1sDxqynKQgYZFTyFJ2+Uf
         3DsQ==
X-Gm-Message-State: APuU4Z8wkMOHGEAQb2XWRCDAkwDrMXzAKyrLzFsLqoxFL10VA6G89hhL
	UbEKefdYEVttSo9HpW+o6NdY7zqfxbVwnQNCSP/sVvoMI26N2UZyD7rnmOrvMjcz
X-Gm-Gg: AZFdTZeHPhn+iNqIUYx+nuT9MFkMb3CuVlggtCqO0t2XUhpEqrrBK5AS1/AH0sCdjNe
	oyu+UKpSuFz1EL8GwL9XdiJUJM/DgKPMw6JJI/vOaFxLGYwcqiAHVAKqJpbbeCnApTDG6rhT9B0
	ihloRht7IT53pt/h2MSul3zBSdgjRq+MzVFIY1sIvwjc6aMmmI/0KC4WNRSgGXEXKQePTJkDvtz
	EZmd3mG1cdFFChg1xxMh4uDHUq8oAfsQcgJJr5vRGpWItN+RPlUg7pgPChFgt1ZsOF6Ze2cQQTY
	zl+1xafXAQ1Zb9Ud1Eykt0UKMLC58oG+Pk+JEFom1OkMkoZ6YUttKblikgkeUzAp2QyycghaQyr
	nlj+KXiiCm9gPnj1ftoOy86nRliOdE2b1Noe61Vu4jRWQ55DzTzdFivn7sNxpgjM6YS2BhEX8oZ
	a0UNu0FH92b/t8Q703oCVXHOlQInLUT9AQzSfSrVRvvTEnrYi/4p3MefRPUPs13h9azmz/7ivGF
	BXRFyM+WlXUOdELgFpWtrLXTUC7rrC2ijTVIuJLwNm9h3vPWJ0fUUv7ULB7hoK8IKrtcI39xEuG
	QB3ia2zjCOLxF0kem9f3b43banuF
X-Received: by 2002:a05:7301:dd94:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-3856f559cfemr2353569eec.30.1795174446950;
        Fri, 20 Nov 2026 03:34:06 -0800 (PST)
Received: from aeron-host ([103.177.178.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm7385010eec.15.2026.11.20.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:34:06 -0800 (PST)
From: Abhishek Agarwal <agab0323@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Subject: [PATCH] submodule--helper: check 'update --jobs' like submodule.fetchJobs
Date: Fri, 20 Nov 2026 17:02:33 +0530
Message-ID: <20261120113233.783523-1-agab0323@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git submodule update --jobs=0" aborts:

    $ git submodule update --jobs=0
    BUG: run-command.c:1574: you must provide a non-zero number of processes!

"git clone --recurse-submodules --jobs=0" passes the value on to it
and aborts the same way. A negative value fails with a confusing
message:

    $ git submodule update --jobs=-1
    fatal: data too large to fit into virtual memory space

Before 51243f9f0f (run-command API: don't fall back on online_cpus(),
2022-10-12), run_processes_parallel() turned any value below 1 into
online_cpus(). That commit made 0 a BUG() and moved the fallback into
the parsers of fetch.parallel and submodule.fetchJobs, which already
die on a negative value. The list of callers in the commit before it,
6a48b428b4 (run-command API: make "n" parameter a "size_t",
2022-10-12), describes "submodule update" only as a reader of
submodule.fetchJobs. But its "--jobs" option is read with
OPT_INTEGER() after the configuration and is used as is.

c39952b925 (fetch: choose a sensible default with --jobs=0 again,
2023-02-20) fixed the same problem for "git fetch --jobs=0". Do the
same here and use online_cpus() for 0. Also die on a negative value,
as parse_submodule_fetchjobs() does for the variable. Negative values
meant online_cpus() too before v2.39, but they have failed since
then, and rejecting them keeps the option and the variable in
agreement.

The documentation of --jobs in git-submodule(1) and git-clone(1)
only says that it defaults to submodule.fetchJobs. Say what 0 means,
with the wording used for "git fetch --jobs".

Signed-off-by: Abhishek Agarwal <agab0323@gmail.com>
---
 Documentation/git-clone.adoc     |  1 +
 Documentation/git-submodule.adoc |  1 +
 builtin/submodule--helper.c      |  6 ++++++
 t/t7406-submodule-update.sh      | 20 ++++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index dd3b44817a..a64084488c 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -375,6 +375,7 @@ repository uses a non-default object storage.
 `--jobs=<n>`::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
+	A value of 0 will use some reasonable default.
 
 _<repository>_::
 	The (possibly remote) _<repository>_ to clone from.  See the
diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 57a21bc8d9..8abeb69cb2 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -465,6 +465,7 @@ NOTE: See the NOTE above for the `--reference` option.
 	Clone new submodules in parallel with _<n>_ jobs.
 	This option is only valid for the `update` command.
 	Defaults to the `submodule.fetchJobs` option.
+	A value of 0 will use some reasonable default.
 
 `--single-branch`::
 `--no-single-branch`::
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 461b682d0d..e06a724ad9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -37,6 +37,7 @@
 #include "wildmatch.h"
 #include "strbuf.h"
 #include "url.h"
+#include "thread-utils.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3079,6 +3080,11 @@ static int module_update(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
+	if (opt.max_jobs < 0)
+		die(_("'%s' cannot be negative"), "--jobs");
+	if (!opt.max_jobs)
+		opt.max_jobs = online_cpus();
+
 	if (opt.require_init)
 		opt.init = 1;
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 10adeabf0f..2b5551044a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1096,6 +1096,26 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+test_expect_success 'submodule update --jobs 0 uses the number of CPUs' '
+	test_when_finished "rm -rf super5 trace-jobs.out" &&
+	git clone cloned super5 &&
+	GIT_TRACE="$(pwd)/trace-jobs.out" \
+		git -C super5 -c submodule.fetchJobs=1 submodule update --init --jobs 0 &&
+	test_grep "up to $(test-tool online-cpus) tasks" trace-jobs.out
+'
+
+test_expect_success 'submodule update rejects a negative --jobs' '
+	test_must_fail git -C super2 submodule update --jobs -1 2>err &&
+	test_grep "${SQ}--jobs${SQ} cannot be negative" err
+'
+
+test_expect_success 'git clone --recurse-submodules --jobs 0 uses the number of CPUs' '
+	test_when_finished "rm -rf super5 trace-jobs.out" &&
+	GIT_TRACE="$(pwd)/trace-jobs.out" \
+		git -c submodule.fetchJobs=1 clone --recurse-submodules --jobs 0 . super5 &&
+	test_grep "up to $(test-tool online-cpus) tasks" trace-jobs.out
+'
+
 test_expect_success 'submodule update --quiet passes quietness to merge/rebase' '
 	(cd super &&
 	 test_commit -C rebasing message &&
-- 
2.56.0

