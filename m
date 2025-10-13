Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E342FB96C
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345362; cv=none; b=B9NUnxc7UXdVyklRh/RmsVoJfdlgETR9cuBkCz8dlARsBf41OgZ8UNIXTEihJOKgxFlTQuZBkIz6iTyQ4VW2LpTRrE1j8lsKJga9C6kqbHtRunOxwA5lfJEUM2HgKR8w1kZM5kkvxkjhNvzMpp35svs2ghTaALyTdVQetG050jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345362; c=relaxed/simple;
	bh=82FUfiWHVUY7/i1W9JSCjmwyxOR7HPm1c2b4Cl9EZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE0oBi04slYdV9VA5iULvjiR9JO/VAKMXy1NsQGDTeMBHUM4q6Nd3pVP1YCf9p3QKXoEC1yQd5eL59uMxCGJHwNgR4uFja5zs7VcNcAHaKVVEReg+Fc2tTktMua2E4S/1mu07zQHOyHe+UDr1L5XzrASzDtei+/W1JgLTooDy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJqQtecV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJqQtecV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso3007018f8f.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345358; x=1760950158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9ojGqNS4OAQZMbkfabEe7HcXcOXhO5bEnjjZaC/mTg=;
        b=FJqQtecVxt5oHr6LmwXRiqOHFSMFVTVUr9Djd+rUkSZCXZefZJFgqEhnQThIqV6gzS
         7aNR0Oz2NcMAJTdxTk3m3tHo1zzc3a8The6OAAM5bFAQYpvwjscBVzkOpzqAQzOrLQQZ
         Gz975/encFlZ7saWV688FZGLhK6d1PxyGIBpeSS6v4vqX2onaq+4ovHqosysqGnLTYtw
         OoACab95nAbv2HCclZkhIaKLD1ZcWdwOEQnDjGOMsS0uXN8+26OZ6uxfJ4zkDHNVzzvK
         rky/qnFhsiTdtbDFk7tYE57YZDhbhcMk/l7lE9AzWgqZqlODd7xStHRndrd11JIFUSPd
         /JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345358; x=1760950158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9ojGqNS4OAQZMbkfabEe7HcXcOXhO5bEnjjZaC/mTg=;
        b=Z4vHEvFHUi20fsPiEu/Eqog293xgGSEXi/EKKkFxZXbwIfb79+DiwJzpNGpwn6yX6m
         2oZ94iKNgZ/ETlS1nJDn3QSkwfO4lOCU2+62oVc3Zw1ro3zPKyPsstLGUq3YhXoNnxAh
         Hw/mpO3UEMqTZh7w9Xw/e8bkHCEK52UiT2/wv+0iJfZJ2lX5OOijOKWHtS8vq+LyA02n
         oPu3EJ6OwSD6LOqv3GCpcFPReICK2uYvJMMlQbyJ0VlFoaNdURGX+q8xueR1jvBLIfee
         p8Ef6sx5RJlasm5CaOfND1SYsH6n9hTkSq/9hK24OlCRgSgfL3DedZYzgFABZ9GyD+Gm
         Zsaw==
X-Gm-Message-State: AOJu0YyBtVZVNi5aY3LQeYnDjTdj3308k7ZsAyl022b7mYP4EvO9Ux3U
	TdNT0dP1crfxnXW8Z5GHENL1KTbh+G1UAOIAtrb6gjr7ej1W97b67fxZqhZ28Tbm
X-Gm-Gg: ASbGnctg6/FwWXBLDLiuTFBXJhe2PTfYdfvMyujkBK1Ys1mD2zpGPjYj5ne9vfT15Sv
	jEnegF/P/IBxG3aybPzWCHdnTrlXy798rVKTt8nV9QwkjZGbzV0rXp1sqPQ2ZAWhX15Qi6hMbLd
	LHfoax0MpagxDpKxXSAiK6/EvOmaMgRpPN2RtAFFbKB2cV4dEY8bP5/8lbpemKG2YhN9OzZhOxq
	jlBSaP7kImJTmmSyCtVo4JgcwoT5e//+SYJBQLhGMiVj/qqA6z7/5i1PO/WoymzoMgrn7z7N/l1
	GNhgHKLDg1gpp5Bxbh9tIkN7xyytPFDsB6mkdJXMZQHwJiJWlp3NyR5VhNXQHDfVYK62gtQ8y/e
	IHhvLfs0fOsm5guFKVGsLNyymQGIyWbNQ1d7B6nTQ/LPQ4rZbVQvVC4ijBcnjuugVTAr8
X-Google-Smtp-Source: AGHT+IGOeS5UZDWb33e2knptK1ed0BGaJSHIyY1NKbBPSOmmIY9I6XesBMxwYOmgoXfuh+Lb/MuEOQ==
X-Received: by 2002:a05:6000:2c0e:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-42667177c79mr13954330f8f.16.1760345358051;
        Mon, 13 Oct 2025 01:49:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm15630220f8f.13.2025.10.13.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:49:16 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/5] fast-import: add '--signed-tags=<mode>' option
Date: Mon, 13 Oct 2025 10:48:57 +0200
Message-ID: <20251013084857.1646783-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251013084857.1646783-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, eaaddf5791 (fast-import: add '--signed-commits=<mode>'
option, 2025-09-17) added support for controlling how signed commits
are handled by `git fast-import`, but there is no option yet to
decide about signed tags.

To remediate that, let's add a '--signed-tags=<mode>' option to
`git fast-import` too.

With this, both `git fast-export` and `git fast-import` have both
a '--signed-tags=<mode>' and a '--signed-commits=<mode>' supporting
the same <mode>s.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-fast-import.adoc |  5 ++
 builtin/fast-import.c              | 43 ++++++++++++++++
 t/meson.build                      |  1 +
 t/t9306-fast-import-signed-tags.sh | 80 ++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100755 t/t9306-fast-import-signed-tags.sh

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 85ed7a7270..b74179a6c8 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -66,6 +66,11 @@ fast-import stream! This option is enabled automatically for
 remote-helpers that use the `import` capability, as they are
 already trusted to run their own code.
 
+--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed tags.  Behaves in the same way
+	as the same option in linkgit:git-fast-export[1], except that
+	default is 'verbatim' (instead of 'abort').
+
 --signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed commits.  Behaves in the same way
 	as the same option in linkgit:git-fast-export[1], except that
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2010e78475..60d6faa465 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -188,6 +188,7 @@ static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
 
+static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
 
 /* Memory pools */
@@ -2961,6 +2962,43 @@ static void parse_new_commit(const char *arg)
 	b->last_commit = object_count_by_type[OBJ_COMMIT];
 }
 
+static void handle_tag_signature(struct strbuf *msg, const char *name)
+{
+	size_t sig_offset = parse_signed_buffer(msg->buf, msg->len);
+
+	/* If there is no signature, there is nothing to do. */
+	if (sig_offset >= msg->len)
+		return;
+
+	switch (signed_tag_mode) {
+
+	/* First, modes that don't change anything */
+	case SIGN_ABORT:
+		die(_("encountered signed tag; use "
+		      "--signed-tags=<mode> to handle it"));
+	case SIGN_WARN_VERBATIM:
+		warning(_("importing a tag signature verbatim for tag '%s'"), name);
+		/* fallthru */
+	case SIGN_VERBATIM:
+		/* Nothing to do, the signature will be put into the imported tag. */
+		break;
+
+	/* Second, modes that remove the signature */
+	case SIGN_WARN_STRIP:
+		warning(_("stripping a tag signature for tag '%s'"), name);
+		/* fallthru */
+	case SIGN_STRIP:
+		/* Truncate the buffer to remove the signature */
+		strbuf_setlen(msg, sig_offset);
+		break;
+
+	/* Third, BUG */
+	default:
+		BUG("invalid signed_tag_mode value %d from tag '%s'",
+		    signed_tag_mode, name);
+	}
+}
+
 static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
@@ -3024,6 +3062,8 @@ static void parse_new_tag(const char *arg)
 	/* tag payload/message */
 	parse_data(&msg, 0, NULL);
 
+	handle_tag_signature(&msg, t->name);
+
 	/* build the tag object */
 	strbuf_reset(&new_data);
 
@@ -3544,6 +3584,9 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
 		if (parse_sign_mode(option, &signed_commit_mode))
 			usagef(_("unknown --signed-commits mode '%s'"), option);
+	} else if (skip_prefix(option, "signed-tags=", &option)) {
+		if (parse_sign_mode(option, &signed_tag_mode))
+			usagef(_("unknown --signed-tags mode '%s'"), option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
 		quiet = 1;
diff --git a/t/meson.build b/t/meson.build
index 11376b9e25..cb8c2b4b30 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1036,6 +1036,7 @@ integration_tests = [
   't9303-fast-import-compression.sh',
   't9304-fast-import-marks.sh',
   't9305-fast-import-signatures.sh',
+  't9306-fast-import-signed-tags.sh',
   't9350-fast-export.sh',
   't9351-fast-export-anonymize.sh',
   't9400-git-cvsserver-server.sh',
diff --git a/t/t9306-fast-import-signed-tags.sh b/t/t9306-fast-import-signed-tags.sh
new file mode 100755
index 0000000000..363619e7d1
--- /dev/null
+++ b/t/t9306-fast-import-signed-tags.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='git fast-import --signed-tags=<mode>'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success 'set up unsigned initial commit and import repo' '
+	test_commit first &&
+	git init new
+'
+
+test_expect_success 'import no signed tag with --signed-tags=abort' '
+	git fast-export --signed-tags=verbatim >output &&
+	git -C new fast-import --quiet --signed-tags=abort <output
+'
+
+test_expect_success GPG 'set up OpenPGP signed tag' '
+	git tag -s -m "OpenPGP signed tag" openpgp-signed first &&
+	OPENPGP_SIGNED=$(git rev-parse --verify refs/tags/openpgp-signed) &&
+	git fast-export --signed-tags=verbatim openpgp-signed >output
+'
+
+test_expect_success GPG 'import OpenPGP signed tag with --signed-tags=abort' '
+	test_must_fail git -C new fast-import --quiet --signed-tags=abort <output
+'
+
+test_expect_success GPG 'import OpenPGP signed tag with --signed-tags=verbatim' '
+	git -C new fast-import --quiet --signed-tags=verbatim <output >log 2>&1 &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/openpgp-signed) &&
+	test $OPENPGP_SIGNED = $IMPORTED &&
+	test_must_be_empty log
+'
+
+test_expect_success GPGSM 'setup X.509 signed tag' '
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+
+	git tag -s -m "X.509 signed tag" x509-signed first &&
+	X509_SIGNED=$(git rev-parse --verify refs/tags/x509-signed) &&
+	git fast-export --signed-tags=verbatim x509-signed >output
+'
+
+test_expect_success GPGSM 'import X.509 signed tag with --signed-tags=warn-strip' '
+	git -C new fast-import --quiet --signed-tags=warn-strip <output >log 2>&1 &&
+	test_grep "stripping a tag signature for tag '\''x509-signed'\''" log &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/x509-signed) &&
+	test $X509_SIGNED != $IMPORTED &&
+	git -C new cat-file -p x509-signed >out &&
+	test_grep ! "SIGNED MESSAGE" out
+'
+
+test_expect_success GPGSSH 'setup SSH signed tag' '
+	test_config gpg.format ssh &&
+	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+
+	git tag -s -m "SSH signed tag" ssh-signed first &&
+	SSH_SIGNED=$(git rev-parse --verify refs/tags/ssh-signed) &&
+	git fast-export --signed-tags=verbatim ssh-signed >output
+'
+
+test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=warn-verbatim' '
+	git -C new fast-import --quiet --signed-tags=warn-verbatim <output >log 2>&1 &&
+	test_grep "importing a tag signature verbatim for tag '\''ssh-signed'\''" log &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/ssh-signed) &&
+	test $SSH_SIGNED = $IMPORTED
+'
+
+test_expect_success GPGSSH 'import SSH signed tag with --signed-tags=strip' '
+	git -C new fast-import --quiet --signed-tags=strip <output >log 2>&1 &&
+	test_must_be_empty log &&
+	IMPORTED=$(git -C new rev-parse --verify refs/tags/ssh-signed) &&
+	test $SSH_SIGNED != $IMPORTED &&
+	git -C new cat-file -p ssh-signed >out &&
+	test_grep ! "SSH SIGNATURE" out
+'
+
+test_done
-- 
2.51.0.438.g6987fc0bae

