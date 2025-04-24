Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46B218858
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527174; cv=none; b=M3WdUKCMA/VVurSCfW4o5G3LPO/j5ErgGg/BG62pNcP8rZI8Y8LnH38LvCF+XgiN8jjeiGtmy18bb9dF5tbowUuyFBvvzKxNDTuK0EwxeZxXY4Uu9nHnwNmL/A2eyBJ4Q5VhZeLUr2CI90Bt/iHK0g3CDmCYKh0R9gULuz+EhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527174; c=relaxed/simple;
	bh=yscpfRW2oI0aDbE+zyGVgqV+Kj6WpKF1gpKFKQF+jyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oc56np/j2L4kdE2pKgdd/cLRZwV+JRqwFfE9doOwr+GOVZ2Fzbu1aT0eSGEk4Mo09rzMUVCiALxdZzF2nhkMev9hfoaYy9YfG6OIATLpQoFQdelHpc60km/ZAApTiG96wuFZCDFyLjkxW4c3uyl5PNJrnD4RaoW51bw0VllF8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrmFPL0x; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrmFPL0x"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c0dfba946so1101816f8f.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527170; x=1746131970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvvBuIg2Nroj2q67Kkc6E4ZgT2HxolAn8cCdm6D74sI=;
        b=LrmFPL0xjXIRR+qAQ9J0NSpkUPI3tMitmy8HjG4MVD0QiKok6j3uJ6C7JuTJrZC8rH
         oyeuqaYsFAehAh2tAYsb5bt3aHYnYlwCI73uVdTNFfwlYToxpCBKLznN/uM+l7zczW8z
         7/BKoRMQBo3snWD3G2IjjkntS01HjmUmC1EE9+mQMVGhAqMQlewQHjzoL0RO1//JuiGS
         5/Kjw3U5N8C86Nabme3mN1Qey3bm7X6ByzAq+MBYkmkVUnR9K+rVl6ea2XHGE6UYmifA
         L0GbFiKlazsGEx6nuEbM6X1h0fShPOnBwhOonsUiZEO20FVxkBjxC1KwbI7JEPgsAMbk
         goqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527170; x=1746131970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvvBuIg2Nroj2q67Kkc6E4ZgT2HxolAn8cCdm6D74sI=;
        b=V79KCVgcy4FHsomWj1qCyM8pd1+u7Sz+3MjAYNffWi+TyqFNG9asqBUMgJA8erIJam
         54M65Qok5M+Lh1zRpWZshqDfAk1ve5UpkS7Iw/Un2GQn6Yce6LJCA8eyzaDCIO9B0M1a
         3T0HOaXbdPW7iCj6xWtlu/tj0HaKdo1+4/XMWa+GyrcmyxDrXzuLZfMk+rD5a9bGl0eW
         XBLP70H3WH3WyY1p/ZbtPLlBqOqvLOzlccSbJJydep4g5JorNrqpFp50+vNN1f+aaLma
         aq3g4Nc5DX+YSGTrMwDLsV6hT+mX0fXiGguxlKFhmbD/3SsyC6YyD3cSIh131urJim6y
         gYmQ==
X-Gm-Message-State: AOJu0YyrvsHIkqQgV3UtLDdOX7EAIYRE+bJBZuCjL6z02/F6+LFBmeDW
	IesnWhg05SOStJHpqVJc40yWyJZK4UJoC0luh3p3NIzvdZvzXFUCIrU7xg==
X-Gm-Gg: ASbGncv0jyCsEZA34PvDdbU/7/zIFA6x4J7H0OiyC3nPbGD7B++GdSMRhP00Gp/ZrYH
	lH8izwObufrL4I+DMo/czRWE63KGAISpOD0nExZP+jX3fZAbTkJcv3B1yn0IJdY+V+rZguq+CLY
	rFSlwp58PdiEgp6/FaY05oW7u/tgKedMS5ZigTP1lxpj6Cb8PGcNkicRjvB7KgJ4GYbq8u5Fb6y
	74kwDEpgDvWWjAnQQQ525DCDOqu8W7LWNvQxRbhqYew6vy8R1KZceMd9JQ0aUP11Mcs7oszWFcu
	tewr/qqaD4TeNIavRGcLK98jLWrqfnDo+wI2bUhqxXmqgaM544rgGVdnfDEWjAVqsJdK8OH0syX
	Q5A==
X-Google-Smtp-Source: AGHT+IE2V8nNO/t0dDuMDatkmxV/449Czw2s3PJCv8YpIUBqX3+e5VokP4ZQYQgyOKrpajWXGiOcjg==
X-Received: by 2002:a05:6000:240b:b0:3a0:6f92:ef7c with SMTP id ffacd0b85a97d-3a072a7e904mr529111f8f.17.1745527169658;
        Thu, 24 Apr 2025 13:39:29 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:fb42:b8e0:37e4:2de3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca497esm319108f8f.24.2025.04.24.13.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:39:28 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] fast-(import|export): improve on the signature algorithm name
Date: Thu, 24 Apr 2025 22:39:04 +0200
Message-ID: <20250424203904.909777-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.392.g2fa1c74b07
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
signed-commits, 2025-03-10), added support for signed commits.

However, when processing signatures `git fast-export` outputs "gpgsig
sha1" not just when it encounters an OpenPGP SHA-1 signature, but also
when it encounters an SSH or X.509 signature. This is not very
informative to say the least, and this might prevent tools that process
the output from easily and properly handling signatures.

Let's improve on that by reusing the existing code from
"gpg-interface.{c,h}" to detect the signature algorithm, and then put
the signature algorithm name (like "openpgp", "x509" or "ssh") instead
of "sha1" in the output. If we can't detect the signature algorithm we
will use "unknown". It might be a signature added by an external tool
and we should likely keep it.

Similarly on the `git fast-import` side, let's use the existing code
from "gpg-interface.{c,h}" to check if a signature algorithm name is
valid. In case of an "unknown" signature algorithm name, we will warn
but still keep it. Future work might implement several options to let
users deal with it in different ways, and might implement checking
known signatures too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This is a follow up from cc/signed-fast-export-import that was merged
by 01d17c0530 (Merge branch 'cc/signed-fast-export-import', 2025-03-29)
and introduced the support for signed commits.

The format that this series implemented was lacking a bit, so the goal
with this patch is to improve it and handle signed commits a bit more
consistently in the code base. It also shows in the tests and in our
documentation that SSH and X.509 signatures are supported.

 Documentation/git-fast-export.adoc |  5 +++
 Documentation/git-fast-import.adoc | 15 +++++++-
 builtin/fast-export.c              |  8 ++--
 builtin/fast-import.c              | 14 ++++---
 gpg-interface.c                    | 11 ++++++
 gpg-interface.h                    | 10 +++++
 t/t9350-fast-export.sh             | 60 +++++++++++++++++++++++++++++-
 7 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 413a527496..d03aeca781 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -54,6 +54,11 @@ of tools that call 'git fast-export' but do not yet support
 '--signed-commits', you may set the environment variable
 'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
 from 'abort' to 'warn-strip'.
++
+When exported, signature starts with "gpgsig <alg>" where <alg> is the
+signature algorithm name as identified by Git (e.g. "openpgp", "x509",
+"ssh", or "sha256" for SHA-256 OpenPGP signatures), or "unknown" for
+signatures that can't be identified.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 7b107f5e8e..50b6d2cc1d 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -521,7 +521,20 @@ The optional `gpgsig` command is used to include a PGP/GPG signature
 that signs the commit data.
 
 Here <alg> specifies which hashing algorithm is used for this
-signature, either `sha1` or `sha256`.
+signature. Current valid values are:
+
+* "openpgp" for SHA-1 OpenPGP signatures,
+
+* "sha256" for SHA-256 OpenPGP signatures,
+
+* "x509" for X.509 (GPGSM) signatures,
+
+* "ssh", for SSH signatures,
+
+* "unknown" for signatures that can't be identified (a warning is
+  emitted).
+
+Signatures are not yet checked in the current implementation though.
 
 `encoding`
 ^^^^^^^^^^
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 170126d41a..d00f02dc74 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -29,6 +29,7 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
+#include "gpg-interface.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [<rev-list-opts>]"),
@@ -700,9 +701,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	}
 
 	if (*commit_buffer_cursor == '\n') {
-		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
-			signature_alg = "sha1";
-		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
+		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor))) {
+			const char *name = get_signature_name(signature);
+			signature_alg = name ? name : "unknown";
+		} else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
 			signature_alg = "sha256";
 	}
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 63880b595c..59e991a03c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -29,6 +29,7 @@
 #include "commit-reach.h"
 #include "khash.h"
 #include "date.h"
+#include "gpg-interface.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2830,12 +2831,15 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 	if (sig_alg) {
-		if (!strcmp(sig_alg, "sha1"))
-			strbuf_addstr(&new_data, "gpgsig ");
-		else if (!strcmp(sig_alg, "sha256"))
+		if (!strcmp(sig_alg, "sha256"))
 			strbuf_addstr(&new_data, "gpgsig-sha256 ");
-		else
-			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
+		else if (valid_signature_name(sig_alg))
+			strbuf_addstr(&new_data, "gpgsig ");
+		else if (!strcmp(sig_alg, "unknown")) {
+			warning("Unknown gpgsig algorithm name!");
+			strbuf_addstr(&new_data, "gpgsig ");
+		} else
+			die("Invalid gpgsig algorithm name, got '%s'", sig_alg);
 		string_list_split_in_place(&siglines, sig.buf, "\n", -1);
 		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
 		strbuf_addch(&new_data, '\n');
diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..dc6ea904d0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -144,6 +144,17 @@ static struct gpg_format *get_format_by_sig(const char *sig)
 	return NULL;
 }
 
+const char *get_signature_name(const char *buf)
+{
+	struct gpg_format *format = get_format_by_sig(buf);
+	return format ? format->name : NULL;
+}
+
+int valid_signature_name(const char *name)
+{
+	return (get_format_by_name(name) != NULL);
+}
+
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
diff --git a/gpg-interface.h b/gpg-interface.h
index e09f12e8d0..332707facc 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -47,6 +47,16 @@ struct signature_check {
 
 void signature_check_clear(struct signature_check *sigc);
 
+/*
+ * Return the name of the signature (like "openpgp", "x509" or "ssh").
+ */
+const char *get_signature_name(const char *buf);
+
+/*
+ * Is the signature name valid (like "openpgp", "x509" or "ssh").
+ */
+int valid_signature_name(const char *name);
+
 /*
  * Look at a GPG signed tag object.  If such a signature exists, store it in
  * signature and the signed content in payload.  Return 1 if a signature was
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index dda9e7c3e7..2e2c83d153 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -326,7 +326,7 @@ test_expect_success GPG 'signed-commits=abort' '
 test_expect_success GPG 'signed-commits=verbatim' '
 
 	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
-	grep "^gpgsig sha" output &&
+	grep "^gpgsig openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	(
 		cd new &&
@@ -340,7 +340,7 @@ test_expect_success GPG 'signed-commits=verbatim' '
 test_expect_success GPG 'signed-commits=warn-verbatim' '
 
 	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
-	grep "^gpgsig sha" output &&
+	grep "^gpgsig openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	test -s err &&
 	(
@@ -381,6 +381,62 @@ test_expect_success GPG 'signed-commits=warn-strip' '
 
 '
 
+test_expect_success GPGSM 'setup x509 signed commit' '
+
+	git checkout -b x509-signing main &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	echo "x509 content" >file_for_x509 &&
+	git add file_for_x509 &&
+	git commit -S -m "X.509 signed commit" &&
+	X509_COMMIT=$(git rev-parse --verify HEAD) &&
+	git checkout main
+
+'
+
+test_expect_success GPGSM 'x509 signature identified' '
+
+	git fast-export --signed-commits=verbatim --reencode=no x509-signing >output 2>err &&
+	grep "^gpgsig x509" output &&
+	test ! -s err &&
+	(
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/x509-signing) &&
+		test $X509_COMMIT = $STRIPPED
+	) <output &&
+	test_might_fail git update-ref -d refs/heads/x509-signing
+
+'
+
+test_expect_success GPGSSH 'setup ssh signed commit' '
+
+	git checkout -b ssh-signing main &&
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	echo "ssh content" >file_for_ssh &&
+	git add file_for_ssh &&
+	git commit -S -m "SSH signed commit" &&
+	SSH_COMMIT=$(git rev-parse --verify HEAD) &&
+	git checkout main
+
+'
+
+test_expect_success GPGSSH 'ssh signature identified' '
+
+	git fast-export --signed-commits=verbatim --reencode=no ssh-signing >output 2>err &&
+	grep "^gpgsig ssh" output &&
+	test ! -s err &&
+	(
+		cd new &&
+		git fast-import &&
+		STRIPPED=$(git rev-parse --verify refs/heads/ssh-signing) &&
+		test "$SSH_COMMIT" = "$STRIPPED"
+	) <output &&
+	test_might_fail git update-ref -d refs/heads/ssh-signing
+
+'
+
 test_expect_success 'setup submodule' '
 
 	test_config_global protocol.file.allow always &&
-- 
2.49.0.392.g2fa1c74b07

