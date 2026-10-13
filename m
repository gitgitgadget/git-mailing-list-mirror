Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA157397E91
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914539; cv=none; b=nUjeGCnJNsCW2+n3HnXy8w2Si2cxkYnjU+yyJGA5T0ZRVHj90HBjGKE0aYPF/j33pBol5B7ICJvzs9UY/qwtNSGy4pM1/JngkRkKDfQMRwodwFaslVCv7ionXMu5oO92kl5NxrJ6/o1ByJJE4ndEhkyMKI7ScRmQjS12KBsyj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914539; c=relaxed/simple;
	bh=FjJOorWR14mhsQiFPsh1VE+01Xqj5xDLeb3fjqyBc4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEMFuZRgrA6Vv+PTzs+9y4WJMI1XzqiDzLapvf0vGPZJN/Npa0DQq0ONI38vJyrq62CqozK7MQQvl/Ycay/sOLH0OLDZFEwhOXxrgB8ECn8+sLNf10bP86aF3G9LRO+eVw4Zopzm0MF77D5L7VmSHODxZMkX71IgZvp0ja0EN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9GTEQC+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9GTEQC+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2df8e3c664cso3261285ad.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791914537; x=1792519337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvEXx3rI1mVwwWrjyOzLLNCW+LWjMxJQWfnFg3gPTlg=;
        b=h9GTEQC+e8dqchdJlFCtinEL7G16oNTZf6vMB52jUx6XV4GmOUlWo0uYNIPaWPo7Qr
         ye5NOvD2Nk2Wpm/CXe0vvHW5P/BE+D/QGCplwsKb2b80Fnzka/gMZuIXh1AaXUZ3jXhV
         XpFOGWCM2fSiHT2Etl/+vOhq7bMs0VZt1WGnyL0gZ16ARhKfakFOBXetnBrzduhnpzgt
         L0Uu9Bk+anUe1oH2Xg0lhxO6/Tlz6weCxKoDatO4v2oKKnPQBub1zwmjFsgOclDeDcY9
         XCwM77mRXXCP6GnWjyp21m8/1XLnoUlGVIe58XS3kMUb9S8LI3diR/fHctbHm62sCYHf
         XCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914537; x=1792519337;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvEXx3rI1mVwwWrjyOzLLNCW+LWjMxJQWfnFg3gPTlg=;
        b=vO65o1XyYYIzq0CQyTRymQpNYPOS8D59g048Tvqz1uNNp9mU5m2XVrKJZH1tKmP1gd
         1dT5r+THRr4bs0IsKddMV0xVIWDfdpLTGjeImzgzawyx2CUCXywDv6yj2usT52s6Enxg
         /mBnLYm97/y0ZBXvXkCGhDUltjuJnBgkgF5ZvRnGO1gZjszU0FlaQ+NhpnuWRp7V+yEQ
         xC0vix4Tu9M9kZHj4AePnkWh8ZDQRpPOBCsiJ9D8/Kuv7Z7N9GR+okBdbCwDoKMgzBNb
         KX+W2Yb6quyem/Zk/cc255t3kiVDpo/KK5w5dsZRtUYIWsVYbM9XVeRYsZkQcuO9t+ow
         UVcA==
X-Gm-Message-State: AFq9FYJwNClW1j3VJ7J2Y4yI2/8+gU2sMASdx5HoVvkXjkYlk5MLSrsW
	npx4C3lCQwRsYVFzcb0dmt//ouLke6g1UrNuKZs12V6nIMEQ+0nJAbsOetg2fXQt
X-Gm-Gg: AYBFou1O8U2WypAb+xSwc5JQTz/lZGZwgphu6qb/E++SnAHP7urDtelrbdPnoTQn6K7
	8rKHdeI6o+EutP0Zk+zc8VSJu7OP6Xp3teAtUGCTnxUstWv2dLpTIqZ3EnqV6/dWV/kh0u0cqvy
	TEsvhGzrEv2XoxolTdxdiZFbTpEn/Z00UVudsIfGfFVpN8Ao/XWRrWH+wldbtT/f7PrI9wkHIvF
	fHboaE+sppl9/j+0zrZ9ORsonBHv30E0/4wXl39dLtQXIsvWAZn0SKLZIQ1fnDuxmPb9G3bbFyB
	Cq1/LlsoIYsbWf15VdbOQbMALaHpg4dP7JynQEI0dNVzHeKFK6ZLpeUx5Y+i517o4ckDO+gLNMm
	CG/RmnEuL6Mjwc8rG8cJkLXThPlGVYNpHs/Gpoap/eiqfh7jlZguraWrIwIHeXeF+gwY8Ep2g6H
	TG8hA1lcL4UDdqa3bu7ozPG/DBWmxHChAuAQEZrNECUVTEDBr8EDKKCz08UGs9x2ScpYMcZrsiw
	MEtrOEp9awJnm9mcftHA/9bkh0pfhh13Bh3BgCRCVFRi/+YrNfhOB3ilaE=
X-Received: by 2002:a17:902:d4d0:b0:2e2:ce6f:4688 with SMTP id d9443c01a7336-2e842823504mr171547565ad.1.1791914537021;
        Tue, 13 Oct 2026 11:02:17 -0700 (PDT)
Received: from WF-A7VVAKE ([2605:a601:9a29:ec00:4082:bd1b:c62d:4f4b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35977229a6esm29763701eec.8.2026.10.13.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:02:16 -0700 (PDT)
From: Curtis Allen Smith <curtis.allen.smith@gmail.com>
To: git@vger.kernel.org
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5] read-cache: do not trust a size change when conversion is active
Date: Tue, 13 Oct 2026 12:02:04 -0600
Message-ID: <20261013180206.610-1-curtis.allen.smith@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261013065915.879-1-curtis.allen.smith@gmail.com>
References: <20261013065915.879-1-curtis.allen.smith@gmail.com>
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

ie_modified() runs when the index is refreshed, so this reaches
every command that refreshes it: "git update-index --refresh" now
succeeds instead of reporting "needs update", "git ls-files -m" and
"git status" stop reporting the path, and "git rebase" and
"git pull --rebase" no longer refuse to run.  "git diff" itself is
unchanged; it already reads and converts the file and prints
nothing.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
---
Changes since v4:
 - The two t0020 tests run in the test script's own repository rather
   than creating one; the attribute is scoped to the file under test
   so the existing allcrlf and mixed files are untouched.
 - The log message says which commands the index refresh reaches.

Cost, i9-14900K under WSL2, warm cache, fastest of 5 runs of
"git status -uno" (the first-run rows, of 3), stock 6de20f6 against
this patch:

	10000 files x 2.6 KB, "* text=auto eol=lf" stock      v5
	  clean tree                                5 ms     5 ms
	  10 files edited                           5 ms     5 ms
	  100 files edited                          5 ms     7 ms
	  1000 files edited                         6 ms    20 ms
	  10000 files edited                       23 ms   138 ms
	  10000 same-length edits                 138 ms   133 ms
	  10000 CRLF-rewritten, 1st run            22 ms   114 ms
	    the same, every run after              21 ms     5 ms

	200 files x 1 MB, same attributes
	  clean tree                                3 ms     2 ms
	  200 files edited                          3 ms   514 ms
	  200 same-length edits                   523 ms   513 ms
	  200 CRLF-rewritten, 1st run               3 ms   436 ms
	    the same, every run after               3 ms     2 ms

	10000 files x 2.6 KB, no conversion
	  clean tree                                5 ms     5 ms
	  10000 files with a size change           21 ms    22 ms

The attribute lookup is the last test in the condition, so it happens
only for a path whose size changed: a clean tree pays nothing, and a
tree without conversion pays one lookup per size-changed path (the
last block).  What the patch adds is proportional to the bytes in the
files actually changed, roughly 12 microseconds per modified 2.6 KB
file, so it takes on the order of a thousand modified converted paths
before it is measurable at all.  The same-length rows go down the
pre-existing mtime path and are unaffected by this patch.  Stock git
keeps reporting the CRLF-rewritten files as modified on every run.

A follow-up that skips the conversion and the hash when the length
already rules out a match is written and tested, but on these numbers
I do not think it earns its size.  It is there if anyone wants it.
 read-cache.c    |  4 +++-
 t/t0020-crlf.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

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
index fd1cae09e..9c8d07cfc 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -397,4 +397,43 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
 
+test_expect_success 'status does not report a CRLF-only rewrite as modified' '
+	test_when_finished "git reset --hard autocrlf-checkpoint" &&
+	echo "eol.txt text eol=lf" >.gitattributes &&
+	printf "one\ntwo\nthree\n" >eol.txt &&
+	git add .gitattributes eol.txt &&
+	git commit -m "eol.txt" &&
+
+	# a generator rewrites the file with CRLF, same content
+	printf "one\r\ntwo\r\nthree\r\n" >eol.txt &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual &&
+	git diff --exit-code &&
+
+	# a real change is still reported
+	printf "one\r\ntwo\r\nfour\r\n" >eol.txt &&
+	git status --porcelain -uno >actual &&
+	echo " M eol.txt" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'status sees through a CRLF rewrite of a file with a lone CR' '
+	test_when_finished "git reset --hard autocrlf-checkpoint" &&
+	echo "cr.txt text eol=lf" >.gitattributes &&
+	printf "one\rtwo\nthree\n" >cr.txt &&
+	git add .gitattributes cr.txt &&
+	git commit -m "cr.txt" &&
+
+	# "git add" keeps the lone CR and drops the others
+	printf "one\rtwo\r\nthree\r\n" >cr.txt &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual &&
+
+	# the converted length matches the blob, the content does not
+	printf "one\rtwo\nthrEE\r\n" >cr.txt &&
+	git status --porcelain -uno >actual &&
+	echo " M cr.txt" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.53.0

