Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C118CC13
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132791; cv=none; b=o7siQiH8DrPY0dyaXNsIPB4EbLTZ4nazEY4mEJT/T0oAVDuPEGDf5oPtyKvTmLKC1SrnxJhqqPMW8DK33DJfzkSY3SE5EhuNQxCABm2aQRhmKciY8lS0Tee4CijNibe+r5qycFipWHf3BMDJv+FS35klax/CI3xCzhb599qHF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132791; c=relaxed/simple;
	bh=qQsFku/hfNQY70JAI6FGXw4ycvC+e5dJ/Oukin6tByY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7DaMVoEaECF+1eWeYcAPPgXL4j4l8VycsGlcygDWkXFCIN+wl74UgEW2mRL4kmuI/1E9VfLP/WiFdOz+tuAV/Y73P7+K4wzUhrUTFSDneLqgUOyXTeNMepzMRjarq7PaxfL2oTRwvz5H9SYn0nokT1xjgvDobkKCMfZv3Er+Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR7ds2+7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR7ds2+7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487088510aso5736248b3a.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786132789; x=1786737589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/WpzGwhpVR7fM/esEwpNF38SEsJO2qGBar4O46Dbc8=;
        b=YR7ds2+7+cXOgv2k1vMky1WaH9l4tMZFwigYAT/BBSeoBTwikEwiBPAxr0rCn/Oala
         Kw7TdDTSZGr3XrB7f4C/NdpO9USGphuom2F+0cHdIVlNn3uAMKG2fDPQZvXpvaWw6o/+
         xBweOjaH9BMyUARNk0Dd+a9P7/dj25jxGbTPEKbep/81RkjKyA61YX19ohD+3Eib8Xw3
         y8XGhvtfBRxsO2Ltt8VuXfzFZTVFtLS+piZELB2fwPdQMOFr590crIPZSX6XEua3iQbD
         YSnj20eP0lQdTjbjm75ectGVAQtNCGaL2IMSPQnD8/SrbA2iOqRO6JkjEuOU1YpDtSKw
         pWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132789; x=1786737589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/WpzGwhpVR7fM/esEwpNF38SEsJO2qGBar4O46Dbc8=;
        b=BpnRFMjndQ88SMkmUEpEAMFKkFJkRDPoxbAAVp4ELIAJadby1VZ07Wiaz4VLQV9RZb
         wrZeAvJJEc36u8+tEslwbE7FKNsK60M3rQ7q5DbpSbj9FDMGEyVhQ8P+udFqBRDgV9oR
         MzDgtcXmhASt0ChpI5nbxe20s41EyD99VQCpm4l/D7p6DSH0dmToOfIqEWUTFtbNzHvG
         jiAimI4VOhaoGOCNOYwwTeq5MqGzz4JKGt1NRYSBIaAVaCsXArPknh/ZWGrnitiw4IvT
         a34rrHmmLkyyo21QUSEBQECG6L3DQzh45xv2qNtIYf94Ky+slP8vJZfNO2XrSWYOgxRF
         WoBQ==
X-Gm-Message-State: AOJu0YzQcj6BpHl1OR0D6URygQ0IQ1Mngq7XMi6NcxKkAc9JyDdV/rvz
	2TcONUpi1O2fLEbyuHDKEENDoZAhLQGnH/wv/8/fwB+Vre1RMwMR7JS2r7TlupST
X-Gm-Gg: AR+sD11mluJxL/w5L2JC6Iwp4gBYvSvSvMAmuOAwU6sEFehVM3lxezWRYHDCYcZrI5r
	8MLNG5ONSXkijzlU/a+ZX7Z7cDok8SKkI5LP9mDK49I+kYIFgfLDwDqNUSNJX1NuxzdSGIuOPvj
	f9juJrXEcgyTlvQU1kUYgvmnKhBoIWJStHXSMMRN44L05ibh2nSlOMYRv+6XiBfDqy3OlPudp1y
	0Yb9wLk9/KfR3UWQiG/gz73Mp29nTtMXZeK6JQRH44GuM2XOGANZleTYU31353bvHa32a6sv8BS
	HIja6Q/zT9cFegOt+mhlwALxoacQJ3llFynxGUWm4CqRPPul3au3jUThtqmIIg4XRCF6o7rbfe8
	TWD4ydAOfp1a8hT6F9bvH7kkh+C2zimvqRjgMq37ON8CZNVO8xfC8kkNQfJTO0NPPjDzL8G4Wp8
	uNcknXtILfMLsZuYOORdf2DKwaZnPkTk2p9W70RGDSXSgY83kaLd4LBNpC9Hfw6MleSjcnKxK9m
	xc4GpzH1N7EvHij+PJ/uJsgGOCcsg4HuqA=
X-Received: by 2002:a05:6a20:a107:b0:3c3:8d86:9856 with SMTP id adf61e73a8af0-3cb85ded96dmr28696689637.14.1786132789374;
        Fri, 07 Aug 2026 12:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c0a:12d1:e8b7:d1d3:7fd9:ca08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb883d9sm10401086eec.15.2026.08.07.12.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 12:59:47 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH] object-name: avoid use-after-free in get_oid_with_context_1()
Date: Sat,  8 Aug 2026 01:29:40 +0530
Message-ID: <20260807195941.99473-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a ":<path>" argument names a relative path, resolve_relative_path()
returns a newly allocated string and "cp" is pointed at it:

	new_path = resolve_relative_path(repo, cp);
	if (!new_path) {
		namelen = namelen - (cp - name);
	} else {
		cp = new_path;
		namelen = strlen(cp);
	}

From there on "cp" and "new_path" name the same allocation. Later the
memory location that "new_path" points to is freed.

	free(new_path);
	if (reject_tree_in_index(repo, only_to_die, ce, stage, prefix, cp))

But here the reject_tree_in_index() passes "cp" to
diagnose_invalid_index_path(), which calls strlen() on it, looks it up
in the index, and formats it into its messages, allocating as it goes.
All of this reads memory that has already been freed.

Collapse the two exits into one to ensure a single free() that happens
after the last use.

Three things have to coincide to reach this:

1. The path has to be relative, or nothing is allocated and "cp"
still points into the argument.

2. The entry found has to be a sparse
directory, which needs a sparse index.

3. The argument has to get past the check in die_verify_filename() that
skips a leading ':' followed by a non-alphanumeric, so ":0:./dir/"
arrives here where ":./dir/" does not.

Add a test to t1092 that covers the combination. It fails under
SANITIZE=address without the change to object-name.c.

This was reported in [1], and the shape used here was suggested in
review [2], but that series was not rerolled and the fix never landed.

[1] https://lore.kernel.org/git/cf6bcdb43e5b4abab464c30a914d64dc8e7a9925.1655336146.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqy1xxw7rc.fsf@gitster.g/

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
The three conditions make this awkward to reach by hand, so here is the
recipe:

	git init sparse && cd sparse &&
	mkdir folder1 folder2 &&
	echo a >folder1/a && echo b >folder2/b &&
	git add -A && git commit -m init &&
	git sparse-checkout init --cone --sparse-index &&
	git sparse-checkout set folder1 &&
	git show :0:./folder2/

Without the change below, no sanitizer is needed to see it. On 2.52.0
the buffer has already been reused by the time the message is formatted,
so the path printed is whatever now sits in that memory, and it differs
from run to run:

	fatal: path '' does not exist (neither on disk nor in the index)
	fatal: path 'M-6?:xM-@M-:M-L??X' does not exist (neither on disk nor in the index)
	fatal: path '?M-*JM-^M->M-YM-tn?H' does not exist (neither on disk nor in the index)

Still without the change, built with SANITIZE=address, the same command
reports

	ERROR: AddressSanitizer: heap-use-after-free
	READ of size 3 at 0x607000002a20
	    #1 diagnose_invalid_index_path object-name.c:1653
	    #2 get_oid_with_context_1      object-name.c:1807
	    #3 maybe_die_on_misspelt_object_name
	    #4 die_verify_filename         setup.c:216
	    #6 setup_revisions             revision.c:3103
	    #8 cmd_show                    log.c:694
	freed by thread T0 here:
	    #1 get_oid_with_context_1      object-name.c:1806
	previously allocated by thread T0 here:
	    #5 prefix_path                 setup.c:149
	    #6 get_oid_with_context_1      object-name.c:1784

With the change, the message reads "folder2/" every time and the
sanitizer stays quiet.

"git diff" and "git rev-parse" reach it the same way, and so does "../"
from a subdirectory.

The new t1092 test fails without the object-name.c hunk and passes with
it, under SANITIZE=address.
 object-name.c                            | 15 +++++++++------
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 83efba0ba6..bffe795830 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1803,13 +1803,16 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
+				int ret = -1;
+
+				if (!reject_tree_in_index(repo, only_to_die, ce,
+							  stage, prefix, cp)) {
+					oidcpy(oid, &ce->oid);
+					oc->mode = ce->ce_mode;
+					ret = 0;
+				}
 				free(new_path);
-				if (reject_tree_in_index(repo, only_to_die, ce,
-							 stage, prefix, cp))
-					return -1;
-				oidcpy(oid, &ce->oid);
-				oc->mode = ce->ce_mode;
-				return 0;
+				return ret;
 			}
 			pos++;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4140c4d8ef..e88946c254 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1357,6 +1357,17 @@ do
 	"
 done
 
+test_expect_success 'relative path to a sparse directory' '
+	init_repos &&
+
+	# A ":<stage>:<path>" argument whose path is relative is resolved
+	# into a heap-allocated buffer, and a sparse directory found at that
+	# path is reported through it.  Cover that combination, so that the
+	# reporting does not read the buffer after it has been released.
+	test_sparse_match test_must_fail git show :0:./folder1/ &&
+	test_sparse_match test_must_fail git rev-parse :0:./folder1/
+'
+
 test_expect_success 'submodule handling' '
 	init_repos &&
 
-- 
2.52.0

