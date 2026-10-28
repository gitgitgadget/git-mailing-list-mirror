Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188511;
	b=WvWjKf1q2QC5/e+fB4/wkT5B79usNcpCEPn1K5NfoywSwhKhj0r42bqwrDmqPB0xDPvt
	 VIdSlmBgPCQTzjj3S35ozBlixxqVc5jOOOAskr5AA65oMC3YApP2is03JbURkBPP9bn9K
	 9X+BhpvHw6Szyh/1bDruMK2a30C5GEM13K/P5aCUkBNOloDGgA9D+3u2mIKf2io1moyJy
	 ys+ofvw6g9tQz0h+YLYZpMUrk6l9tcQdR106M7QN/jiJ+1bY2ajAl8KkWGYQw/+WI9Fsk
	 kvM/td4uFBDn9IrVsenQUuVFhzK/Qi2UC3fRI2RFu3RWYxjJhfSu2uzys41WuKNixog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XFEb7+TWYzFJ9a0KFg/bzvOK9C18bRpdepsBdsCeJB0=;
	b=eKDw0bBz814O8r3gnw8Wchz2SWd1v6TN4HsCSDeK9G/z6VCatOMHHUtX1MtuIHWPX6iW
	 cW/S7M4QnnpT2ip427Wf+VGVdoj3H7ajvdmjXWa4KbK50F4GM+BAPVaD5r0GGR4uR7yLY
	 7eGi/IWfYQqTPHjjkYvXFlv+F7wGvrA+pkiKWECAPk2eMm6j7PbfVoKZuksAbOYUE4Afk
	 FK6k0nsAdhf+Jn1DdwMZ0ieS/7AFiu19LMF4aiFYK0J/99trCo5X5KL/O3tNyNDOH0apX
	 4s2RfKX4dhvnnpXiHUaGhmJwl/WV9NFppSSdPrdhcoXmKbOvS0vDjJYO6+YEcBF9zHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ0g94rQ;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCE606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBCE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KJ0g94rQ
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so387978c88.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188510; x=1793793310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XFEb7+TWYzFJ9a0KFg/bzvOK9C18bRpdepsBdsCeJB0=;
        b=KJ0g94rQ8m0erqnHRLHjObum1c929F7kXMmhtRI1g8wqxKMgX1UtXsQ+SdkMko3wIB
         1AiNKyfITBlKYGcFGdRNier7TRjhCTbA0So7zE52CJPVUR4/yLtTx+hmjZ5k8F8Bcu0H
         ZD7Kj8+CX8t3zVTqVidTrlwQZ7R18nHakF4HA6x2EDXtNi/17AXgnHnotq3kgWJagaGq
         HwREdtWioeKrKH/PaO2zjkT5wQODztr/AEPZUWrgFF4kHph4OJKX1dH7ezqC1k/ZEOk3
         syM57YkpflOaUsZgq/3oNL/6akC0yzfEE1Ql5BleDlF8rm3+hMJZtgRly6tyffKuB8Vn
         jBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188510; x=1793793310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XFEb7+TWYzFJ9a0KFg/bzvOK9C18bRpdepsBdsCeJB0=;
        b=1MxZohs6/5xP3c01W72A4pYox7dpGxE7FH3t/Q6/ZzIIYPX3G8VPho9tuglhVuhntd
         dku00GDxfjTiuetRHNEFh60PGWd8vKWVYqpHSnL1bD70d5LNZ6HmNgXU3jWU4aEcuxbe
         49XXbIp2oENX23jqjwfTWLBIBhGWa0QUqOMXXH/IdUj5RPnb+lD2pQb39ZeQOipLmoVC
         lZMyYXROffmDh1SVhOrEgQR8weKBOe7P/ZajeGR4k7mz5Kdw8vtclsG3EW9kD6bCnUKl
         YcINvv10/QKOjq+LwctFnJzaIhA3E7peJsxLSetUfl8Ergfuduy5UI80XlgF9qE2tYDZ
         w74g==
X-Gm-Message-State: AFq9FYK9YtOYdF3JnPHbf4rPrsrtAsnGEwPg1G+1OMPwgnH+SLDEnAS/
	wvdIb9pUz+Ic6/jW/0XxeSvg8ioBQkWzWTvGFaQ2WfE2yz68FGmRNqSdfLX/5A==
X-Gm-Gg: AYBFou1r3cGaVZm+iKeD0GMj5rkJx8sXZYktBpYeP+kWHIzrTwNqO0k9hYgFqXxJUs3
	FthA4NBYSeoJH7JV/2lPwIZEmvEjaYvmIgpmbKPTI1YECkbP1g00RRE1NIoom5AjdvPwfnWOx7w
	xGENdQNnQaBOq1gp9L36x2Ko6m2nUYmer1MhUI8tK1SAHESePRZkR1L3EhMePqZeZnz7Xyi6qBF
	8bGXX8+R6WAPhDBgwjn6pBuEXYuMpYw1jg7d/3HdA/xijJqjR484eESZDcxCOTLHIt9MWuuD4m5
	zPd4UBkff7cn7iUopUQ90lIrNwsU4uLLZ+NXTD50tSiyisy2qumICGUDnzFY8H/BT5A6dDrfA2X
	5YInvIl4MdUYaiGTK4876F9FgHAZxcv8ScbL2tvJ4+pqN+muoY9WcX4bHzhj3sdqy2rI82Hx9g0
	/oymESuLFIx770Dp75zBZrev2+42to+scDmuzI8DpfT3Cb5++gfNy7DZWIXwFu9UMm2l3rkTOqD
	CxRiXzuYUgbbmB0cLFO8qXeUpR1eMqXnsizLHa3r0FM/gQ42p7c1J9MUfzscWJ2x5smuPd5IZoE
	VIQQCZ7Y3hgUGinwGVuh5VNjizgHEQy2xKyRaJtDX8+aQv9+5zG1D6QV
X-Received: by 2002:a05:7022:289:b0:149:50cb:2175 with SMTP id a92af1059eb24-1a6cd58e4b3mr2775720c88.33.1793188510125;
        Wed, 28 Oct 2026 04:55:10 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f7fb28csm6350819c88.18.2026.10.28.04.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:55:09 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/5] setup: report when GIT_OBJECT_DIRECTORY is what we could not use
Date: Wed, 28 Oct 2026 17:24:03 +0530
Message-ID: <20261028115412.169748-6-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.283.g7d13445134
In-Reply-To: <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
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

In the same spirit as the last two commits, we want to improve the UX
of the Git repository discovery case when the GIT_OBJECT_DIRECTORY
environment variable is set to an invalid directory. For instance,
consider the following scenario:

  $ echo 'export GIT_OBJECT_DIRECTORY=/tmp/git-objects' >> ~/.bashrc
                                     # shared object store across clones
  ...after a reboot clears /tmp...
  $ cd ~/src/myproject
  $ git status
  fatal: not a git repository (or any parent up to mount point /)
  Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

We get an error here because when GIT_OBJECT_DIRECTORY points at a
directory that cannot be used, Git refuses to work with any repository
at all, but says so in a way that blames the repository.

Improve this error reporting UX by explaining the real cause wherever
we are about to die. Because the check does not depend on the candidate
that is given to is_git_directory(), it is enough to ask once, at the
point of failure, whether the configured object directory is to blame.
With this, the user would see the following:

  ...
  $ git status
  fatal: not a git repository (or any parent up to mount point /)
  Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
  cannot access object directory '/tmp/git-objects' set via
    $GIT_OBJECT_DIRECTORY: No such file or directory

Note that pointing GIT_OBJECT_DIRECTORY at a directory that does not
exist yet is legitimate for "git init", which goes on to create it.
Diagnosing only where we would have died anyway leaves that case alone.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c                       | 80 +++++++++++++++++++++++++++++------
 t/t0009-git-dir-validation.sh | 36 +++++++++++++++-
 2 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/setup.c b/setup.c
index 87fcead87e..7b1e67e0dc 100644
--- a/setup.c
+++ b/setup.c
@@ -450,6 +450,52 @@ int is_git_directory(const char *suspect)
 	return ret;
 }
 
+/*
+ * If $GIT_OBJECT_DIRECTORY names a directory we cannot use, describe why in
+ * `out` and return 1, otherwise return 0.
+ *
+ * Note that the check is not specific to any one candidate directory: when the
+ * variable is set but unusable, is_git_directory() rejects every directory it
+ * is given, so repository discovery cannot succeed anywhere.
+ */
+static int describe_unusable_object_dir(struct strbuf *out)
+{
+	const char *objdir = getenv(DB_ENVIRONMENT);
+	int saved_errno;
+
+	if (!objdir || !access(objdir, X_OK))
+		return 0;
+	saved_errno = errno;
+
+	/*
+	 * TRANSLATORS: The first %s is a path, the second %s is the
+	 * name of the environment variable that set it, and the third
+	 * %s is the system error message.
+	 */
+	strbuf_addf(out, _("cannot access object directory '%s' set via $%s: %s"),
+		    objdir, DB_ENVIRONMENT, strerror(saved_errno));
+	return 1;
+}
+
+/*
+ * Die with `message`, which reports that no repository could be used. When an
+ * unusable $GIT_OBJECT_DIRECTORY is what stood in the way, say so as well: on
+ * its own the message blames the repository we were pointed at, which may be
+ * perfectly fine.
+ *
+ * `message` is not released, as we are about to exit anyway.
+ */
+static void NORETURN die_no_repository(struct strbuf *message)
+{
+	struct strbuf objdir = STRBUF_INIT;
+
+	if (describe_unusable_object_dir(&objdir))
+		strbuf_addf(message, "\n%s", objdir.buf);
+	strbuf_release(&objdir);
+
+	die("%s", message->buf);
+}
+
 int is_nonbare_repository_dir(struct strbuf *path)
 {
 	int ret = 0;
@@ -1148,17 +1194,22 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
 	}
 
 	if (!is_git_directory(gitdirenv)) {
+		struct strbuf message = STRBUF_INIT;
+
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			goto out;
 		}
-		/*
-		 * TRANSLATORS: The first %s is a path, the second %s is the
-		 * name of the environment variable it was taken from.
-		 */
-		die(_("not a git repository: '%s'\n"
-		      "this path was taken from $%s (which can also be set with --git-dir or --bare)"),
-		    gitdirenv, GIT_DIR_ENVIRONMENT);
+		strbuf_addf(&message,
+			    /*
+			     * TRANSLATORS: The first %s is a path, the second
+			     * %s is the name of the environment variable it
+			     * was taken from.
+			     */
+			    _("not a git repository: '%s'\n"
+			      "this path was taken from $%s (which can also be set with --git-dir or --bare)"),
+			    gitdirenv, GIT_DIR_ENVIRONMENT);
+		die_no_repository(&message);
 	}
 
 	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok))
@@ -2021,15 +2072,20 @@ static void repo_discover(struct repo_discovery *discovery, int *nongit_ok)
 				strbuf_addf(&message, _("$%s is set to '%s'"),
 					    CEILING_DIRECTORIES_ENVIRONMENT, ceiling);
 			}
-			die("%s", message.buf);
+			die_no_repository(&message);
 		}
 		*nongit_ok = 1;
 		break;
 	case GIT_DIR_HIT_MOUNT_POINT:
-		if (!nongit_ok)
-			die(_("not a git repository (or any parent up to mount point %s)\n"
-			      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
-			    dir.buf);
+		if (!nongit_ok) {
+			struct strbuf message = STRBUF_INIT;
+
+			strbuf_addf(&message,
+				    _("not a git repository (or any parent up to mount point %s)\n"
+				      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
+				    dir.buf);
+			die_no_repository(&message);
+		}
 		*nongit_ok = 1;
 		break;
 	case GIT_DIR_INVALID_OWNERSHIP:
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index ab3d2593aa..94ef10edcd 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -107,7 +107,7 @@ test_expect_success 'setup: discovery fails when a valid git directory not found
 	)
 '
 
-test_expect_success 'setup: discovery fails with unusable $GIT_OBJECT_DIRECTORY and explicit gitdir' '
+test_expect_success 'setup: unusable $GIT_OBJECT_DIRECTORY is reported with explicit gitdir' '
 	test_when_finished "rm -rf parent/invalid-git-object-directory-config" &&
 	mkdir -p parent/invalid-git-object-directory-config &&
 	(
@@ -115,8 +115,40 @@ test_expect_success 'setup: discovery fails with unusable $GIT_OBJECT_DIRECTORY
 		git init --bare real-repo &&
 		test_must_fail env GIT_OBJECT_DIRECTORY="/path/to/does-not-exist" \
 			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository" stderr
+		test_grep "not a git repository" stderr &&
+		test_grep "cannot access object directory .*does-not-exist" stderr &&
+		test_grep "GIT_OBJECT_DIRECTORY" stderr
 	)
 '
 
+test_expect_success 'setup: unusable $GIT_OBJECT_DIRECTORY is reported during discovery' '
+	test_when_finished "rm -rf objdir-discovery" &&
+	git init objdir-discovery &&
+	(
+		cd objdir-discovery &&
+		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
+			git rev-parse --git-dir 2>stderr &&
+		test_grep "not a git repository" stderr &&
+		test_grep "cannot access object directory .*does-not-exist" stderr &&
+		test_grep "GIT_OBJECT_DIRECTORY" stderr
+	)
+'
+
+test_expect_success 'setup: usable $GIT_OBJECT_DIRECTORY is not reported' '
+	test_when_finished "rm -rf objdir-usable.git objdir-usable-odb" &&
+	git init --bare objdir-usable.git &&
+	mkdir objdir-usable-odb &&
+	GIT_OBJECT_DIRECTORY="$(pwd)/objdir-usable-odb" \
+		git --git-dir objdir-usable.git rev-parse --is-bare-repository >actual 2>stderr &&
+	echo true >expect &&
+	test_cmp expect actual &&
+	test_grep ! "not a git repository" stderr &&
+	test_grep ! "cannot access object directory" stderr &&
+
+	test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/objdir-usable-odb" \
+		git --git-dir does-not-exist.git rev-parse --is-bare-repository 2>stderr &&
+	test_grep "not a git repository" stderr &&
+	test_grep ! "cannot access object directory" stderr
+'
+
 test_done
-- 
2.55.0.1003.g10538fe699

