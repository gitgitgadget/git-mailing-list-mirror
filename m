Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2380470431
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874782; cv=none; b=gJK/4ZjuH+T9j7YpY2gdpnMN9EH0hmaMnOk68hDjC01/K8NR+342XskOJGr2gsBUyeDCIBhE5baX1OhH0WVUJPSJj4JO3cqnydW16sCzxrGD8GHtAQ6d4arSTNCiy1PjHuOtczT5OKPQygGZ7U0ei2nTs1sLi2lTbl7scbfJ0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874782; c=relaxed/simple;
	bh=vXAm6O1O8nfcBKJQmknLI0V85Cjq0c1WbUTSS3D+pnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/BXuKLXmPMAe3B4/5eEy7uKi/9lahtrvys0HggsZ0+AuQS1L9xAVKkRbB8ok1EgvDftcOKcelorJTqeNevfaI/FN0qTPIpCZNrGnkBitheAgnNcY0yGVMFhbW1fG2gf34D4l42dK+DCmp33gBE77O5ItyPSJheJZwjB8kUeHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2oqubqC; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2oqubqC"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-313bab9cfe7so283334eec.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791874780; x=1792479580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JbnOYlrrgnJ6tW2P450kGkB5nlsqgxi3HwwnIdfLVSk=;
        b=n2oqubqCk4U2bbi4u8uNmaxqqOQdjhjNgXTEFvjW9//RIARtWmUIDKHC5U9FKr4QB+
         CLNsnuKSFlCWJPMjGmkSMZhVSGUJzM5AX9IYt6Kd7H0IeCWZ9fBjty9FIW8q6qsjF56+
         EFFayqTjED4SG1bd5Ip7LWSwWfKViR2burQkz5ARrdm42eDrGo2xgkbiJUvugiYa5NfS
         IaS6OgqCLmUidHdKV4rhKOxacnkEgIvvHO+8AhgMleRiNDMu296wiZNAHimznHTuWFBv
         YDBZIW7YIm33wUPtBy8yN8YDX3e5u0agHG3Y5lEsagN/aRV3I6h6AOOgxCS7OugyTPe8
         8tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791874780; x=1792479580;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbnOYlrrgnJ6tW2P450kGkB5nlsqgxi3HwwnIdfLVSk=;
        b=AkeUd/3ic9F0SIECgas5LfVkI7oFJRKmgwK3hhj4BFVZPfuklXY//fLOYTXylCEC8S
         liOlb9zSWyAR6Qj3c8QH+vYizaPchDhCGcMJhQ0QX3EWBfCjVfraodKnp+dblCH5YX/p
         G2b2VqfJaSnJw4thT66OX0UgAwHTq9sGNoOhGwTP0YHZq2ZYiaiES/9vuvYLzX1n+KkI
         XZEcv3UzwuaALG9ipJJxtgroc54snFqUjWve+ff8tuBNAn/6jti45IavY2UToNUCQVS0
         qjTzQZZF056+lpsRBVAXwLFK1+3xvvt0hd7nwsPvyrm2BBdmEGWgPFOzh0arOH0+TB92
         Z3sw==
X-Gm-Message-State: AFq9FYLEw45G626fKAiLEoa7q0SitBJrwEm0C1Eu9qNBI7UalV17f8Zx
	wChPrCnMDtzZLDz9YOuxFyhX0+H0K59rQ7ALju/UVNwcdd9Faer5mDXIx3//kQ==
X-Gm-Gg: AYBFou06m8maJinRH+zMoDPJtwHGEOnTxmVBsXGq8yqN+GggysHsM8WffA+d5Qhs3Fg
	rTgz0hbW7aYlW+pXRew6QXJREC2DxijVRK/NFsfCj44EMH43SSv2U2IhqjEhIhxiswWyAuem9ZI
	FwjPFCnd4AbouGxDyxKvHh5IXFlhG7iwq+z0WgC3z4bhWyBZxTuz7gyX/+KSJh7drnqtholoCky
	VIT+Hd87ijGh9jzHrLnRUvozxzm9NrUgLuD+Cho7pb8vMn48OiXXzkSXAAtxv8zVkd3MGJSHxpR
	Jy9xu5E7nO3F40BXG06nrtnUTzw0bRFWSn2RQ9mEcD2bdPU96SAL3AGHKWSRkckyqVuoZmKVQbw
	uOVcJxFLEIKhHDNhDPIREkd2R+hgJJSJ6OA7tG+z50NYbSBArdaukGUYSSHV4I33hJ4VzzmarZA
	7mWmpVc9/y64fdZFxWfqJKEMIF8s1z2BZy2WreqAnTrjqWPNfd6+A8BMFHzrraTmWNOVyOXFmWo
	49CJV/ixsWcZRqgZZxKe/A3rHBMwDSfSdiwNyUEpHtIKJ58
X-Received: by 2002:a05:7022:170a:b0:143:8212:a43 with SMTP id a92af1059eb24-16a5b97d796mr23632712c88.1.1791874779545;
        Mon, 12 Oct 2026 23:59:39 -0700 (PDT)
Received: from WF-A7VVAKE ([2605:a601:9a29:ec00:4082:bd1b:c62d:4f4b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm46917793c88.9.2026.10.12.23.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:59:38 -0700 (PDT)
From: Curtis Allen Smith <curtis.allen.smith@gmail.com>
To: git@vger.kernel.org
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] read-cache: do not trust a size change when conversion is active
Date: Tue, 13 Oct 2026 00:58:28 -0600
Message-ID: <20261013065915.879-1-curtis.allen.smith@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261012175638.3712-1-tboegi@web.de>
References: <20261012175638.3712-1-tboegi@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"git status" can report a file as modified while "git diff" and
"git add" agree that its contents are unchanged:

	git init t && cd t
	printf '* text eol=lf\n' >.gitattributes
	printf 'one\ntwo\nthree\n' >file.txt
	git add . && git commit -m init

	printf 'one\r\ntwo\r\nthree\r\n' >file.txt

	git status --short      # ->  M file.txt
	git diff                # -> empty
	git add file.txt        # -> nothing to commit

ie_modified() takes a change in the file's size since the index
entry was last refreshed as proof that the file is modified, without
looking at the contents.  A size change proves only that the bytes in
the working tree changed.  When the path is subject to conversion
(the "text" and "eol" attributes, core.autocrlf, a clean filter),
different bytes can convert to the same blob, as the CRLF rewrite
above does.

For such a path, fall through to ce_modified_check_fs(), as is
already done when only the mtime changed.  Paths without conversion
return early as before.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
---
Changes since v3:
 - The fix is inlined into the condition in ie_modified(), with no
   helper function.
 - Shorter log message, using Junio's wording; the "real life"
   examples are gone.

Cost, i9-14900K under WSL2, warm cache, fastest of 5 runs of
"git status -uno", stock 6de20f6 against this patch:

	10000 files x 2.6 KB, no conversion       stock      v4
	  clean tree                               5 ms     5 ms
	  10000 files with a size change          26 ms    24 ms

	10000 files x 2.6 KB, "* text=auto eol=lf"
	  clean tree                               5 ms     5 ms
	  10000 genuinely modified                25 ms   137 ms
	  10000 CRLF-rewritten, 1st run           21 ms   143 ms
	  the same, every run after               21 ms     5 ms

	200 files x 1 MB, "* text=auto eol=lf"
	  clean tree                               3 ms     3 ms
	  200 genuinely modified                   3 ms   498 ms
	  200 CRLF-rewritten, 1st run              3 ms   584 ms
	  the same, every run after                3 ms     3 ms

The attribute lookup happens only for a path whose size changed, so a
clean tree pays nothing, and a tree without conversion pays one
lookup per size-changed path (the first block).  A converted path
whose size changed is now read, converted and hashed, which is what
already happens when only its mtime changes.  Stock git keeps
reporting the CRLF-rewritten files as modified on every run.

A follow-up that skips the conversion and the hash when the length
already rules out a match is ready if wanted.  It takes the
"genuinely modified" rows to 57 ms and 25 ms.

 read-cache.c    |  4 +++-
 t/t0020-crlf.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a..70f4787de 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -9,6 +9,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -480,7 +481,8 @@ int ie_modified(struct index_state *istate,
 	     */
 	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
 #endif
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
+	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0) &&
+	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
 		return changed;
 
 	changed_fs = ce_modified_check_fs(istate, ce, st);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index fd1cae09e..b76c678ce 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -397,4 +397,49 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
 
+test_expect_success 'status does not report a CRLF-only rewrite as modified' '
+	git init eol-status &&
+	(
+		cd eol-status &&
+		echo "* text eol=lf" >.gitattributes &&
+		printf "one\ntwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+
+		# a generator rewrites the file with CRLF, same content
+		printf "one\r\ntwo\r\nthree\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual &&
+		git diff --exit-code &&
+
+		# a real change is still reported
+		printf "one\r\ntwo\r\nfour\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'status sees through a CRLF rewrite of a file with a lone CR' '
+	git init eol-status-lone-cr &&
+	(
+		cd eol-status-lone-cr &&
+		echo "* text eol=lf" >.gitattributes &&
+		printf "one\rtwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+
+		# "git add" keeps the lone CR and drops the others
+		printf "one\rtwo\r\nthree\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual &&
+
+		# the converted length matches the blob, the content does not
+		printf "one\rtwo\nthrEE\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.53.0

