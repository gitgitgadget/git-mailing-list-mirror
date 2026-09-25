Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86221495AD9
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332533; cv=none; b=NSFT+su5bzOHxaaACjnMj1agk1LkEk8DvC4wbM/Abuq1PZ0UlD3jMtLzbbmZ+NfWtGbkUDyYkvuK4tksEJO0k1TpOJxMUc1ERR8SD6ZHMaxKbd7FYdi7XhnjGoSRPDDeWUhsUmH4KMNLno7IfGlOVpEfqDQMSr/CwEpb1Xj+BSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332533; c=relaxed/simple;
	bh=NN2M8HnUqIt3nBwGwOoBpIxlQxBAZlQhutXEbpWhcPg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tK+IEdv8ik+7X30tyYyuq47oSUtVKNDd3SLCGOtbfc9UgVSiVbwJDVVq2X2KD/DSOa6q109ZRHpzYIxXsC26K/cFeYR8iGxhXBVDgt7CcgHGL45qQpgu+/jFvvbUdlyAU4Ia+I3/xg5NahYoRbp0ux8D+QCCEnIddbfGQh9x8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0vsmMT1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0vsmMT1"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso3167715ad.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790332531; x=1790937331; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X6JTY4thVPyonNau9nR/hvwK4vs2cWf/oRnq+rzsV6U=;
        b=V0vsmMT1UNBqMGv99Lg1oHwdG2qJGkxZz85ZLDW7hGA5wFqQUgaAv7/gR6trMzsxHq
         fLzGFLXlalXtvUozZF1Uk6TCahmvxvB+KSttQ5ioc5eqbpIWsYp5pkNtu+oiOxMbN+ca
         iW4JGujjV64HJjqhW3U3AQ3d7YzZgt8ltkA3S+TECdKJgR/ZkrXGwUBboC4TbWhFuyZr
         RyvYkCJVYAUBUDRNzi+gAd1mLMpJaCOEb+L7L+GdudAB7Jv/HCLxEv8tQlpDrETM9ihP
         LxVicDqVAC3hhdkTYDIcfT5QFwCfQGRjRX7IIcJ2FU6L1FStBuO4yQFRhGCGyqtoXlZ3
         u9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790332531; x=1790937331;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6JTY4thVPyonNau9nR/hvwK4vs2cWf/oRnq+rzsV6U=;
        b=GfnkE8Xs1BMzyvHNQ0uJgcZRjVEwdM+c0nbCCcVos051gHowXSKr+19YgX4UdaY6nC
         7Mj3EsIV7tQqvJpQwVT4wDFsqv5c9hh4fjMULOxEwidvrRPTdjKQ7vkNbbs2HWsZF5eH
         UkYu/KQTlE+drmL2TYd9aOfwJDAG0SQsTVy/pMj9SbYUh05k4TLpdhoOdtW7s4Jn3DGv
         Pq6xFDlxMH060VQZCCygg0E+Z660xaA5ymlcahxFzEga2jHUl8qhjKyGUV/q3C5SCiZq
         FLyVCG3vEXrSojmXrv+gMztsZR5Gbd+tHI/iH/yEg2Tt6LHfef6qwlO6P+KdjQJ7XmpL
         FhoA==
X-Gm-Message-State: AFuF++nqThjKMPA1KHV54Ga8UwzLQJSQe49+lLjX1TW+O5BXu9eLFibD
	0hnRNQ31A3mMqMdn+mdJ+67OtByCmIlbc0OM8/dJr5mThjXxcl64s7XRW6SJsA==
X-Gm-Gg: AYBFou0PKmZ9D8Bc3f4K2BxJTSK0HsW4MCqXdqsBXThG2PdvAOAWJALgEDAjFZ1Zwl6
	0VXxqQkpviClzJ4LfDjOIOGOaAUOTZmTGKXtpCmnMReKNtYGedULY6/yIQpZ//BjI9i6GUROhZ7
	n0R4RjqMI+3vhVG/zqpEY38HyWjjGkF8D3js01w+XShm7wKnb4Q/CvfqOBdSka1cRUo65ExYypy
	l4EpwHHvYrYTr4YxSFEGEWX4KFy+C0f3B20JizJc5CW0U/eiSxiJzpU2Med6T1ayVteTPLJHA+c
	u/Lkq7bTiK/9mjKgendyZ5tkSNf0ngb9yxoOrd1WStkZ03+dHcZmPsWH3bNJEMMTgcu6MEyzFVR
	LzcXVr92QWuaUUANr4LIMeKRzgFlKvwkkv65BtvIwJlUHfj8x2rTKujr+QH3wHgVdWq7nEwlDxX
	OEqHIM2sxEZA8nnfiSPumk1XmcV5BM7VVykCIZpsmzy3QkhYmWH/wpZilVqB+AQ2iUj3wmEq/4g
	Q==
X-Received: by 2002:a17:903:324c:b0:2df:5f91:9e06 with SMTP id d9443c01a7336-2df7da7ef89mr47776065ad.14.1790332530350;
        Fri, 25 Sep 2026 03:35:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.64.173.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444797sm7731595ad.58.2026.09.25.03.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:35:29 -0700 (PDT)
Message-Id: <pull.2234.v2.git.1790332529050.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.git.1789991377413.gitgitgadget@gmail.com>
References: <pull.2234.git.1789991377413.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:35:29 +0000
Subject: [PATCH v2] line-range: skip trailing blank lines in funcname range
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

git log -L :funcname: includes trailing blank lines in the
function range. This boils down to parse_range_funcname()
extending the range forward until it either reaches end-of-file
or another function, without skipping blank lines at the
boundary. Including blank lines is inconsistent with how it
works for git grep -W.

Fix this by trimming trailing blank lines from the computed range,
with the same goal as this fix (though with a different approach):

    8e5dd94e68 (grep: -W: skip trailing empty lines at EOF, too,
    2024-07-30)

A blank line is one that contains only whitespace characters,
matching the definition used by grep -W.

Reported-by: Nikita Makarov <n.makarov@yadro.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    line-range: skip trailing empty lines in funcname range
    
    cc: René Scharfe l.s.r@web.de cc: Nikita Makarov n.makarov@yadro.com cc:
    Kristofer Karlsson krka@spotify.com
    
    Changes since v1:
    
     * Filter out all blank lines (only whitespace characters) instead of
       only filtering empty lines to match how grep -W works. (This also
       makes CRLF line endings work.)
     * Updated tests to include whitespace-only lines (spaces, tabs) in
       addition to empty lines.
     * Rephrased from "empty" to "blank" throughout.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2234%2Fspkrka%2Fkrka%2Fline-range-trailing-blank-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2234/spkrka/krka/line-range-trailing-blank-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2234

Range-diff vs v1:

 1:  f2e217d968 ! 1:  a55eadf639 line-range: skip trailing empty lines in funcname range
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    line-range: skip trailing empty lines in funcname range
     +    line-range: skip trailing blank lines in funcname range
      
     -    git log -L :funcname: includes trailing empty lines in the
     +    git log -L :funcname: includes trailing blank lines in the
          function range. This boils down to parse_range_funcname()
          extending the range forward until it either reaches end-of-file
     -    or another function, without skipping empty lines at the
     -    boundary. Including empty lines is inconsistent with how it
     +    or another function, without skipping blank lines at the
     +    boundary. Including blank lines is inconsistent with how it
          works for git grep -W.
      
     -    Fix this by trimming trailing empty lines from the computed range,
     +    Fix this by trimming trailing blank lines from the computed range,
          with the same goal as this fix (though with a different approach):
      
              8e5dd94e68 (grep: -W: skip trailing empty lines at EOF, too,
              2024-07-30)
      
     +    A blank line is one that contains only whitespace characters,
     +    matching the definition used by grep -W.
     +
          Reported-by: Nikita Makarov <n.makarov@yadro.com>
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     @@ line-range.c: static const char *parse_range_funcname(
       		(*end)++;
       	}
       
     -+	/* exclude trailing empty lines from the function range */
     -+	while (*end > *begin + 1 &&
     -+	       nth_line_cb(cb_data, *end - 1)[0] == '\n')
     ++	/* exclude trailing blank lines from the function range */
     ++	while (*end > *begin + 1) {
     ++		const char *bol = nth_line_cb(cb_data, *end - 1);
     ++		const char *eol = nth_line_cb(cb_data, *end);
     ++		while (bol < eol && isspace(*bol))
     ++			bol++;
     ++		if (bol < eol)
     ++			break;
      +		(*end)--;
     ++	}
      +
       	regfree(&regexp);
       	if (xecfg)
     @@ t/t4211-line-log.sh: test_expect_success '--summary shows new file on root commi
       	test_grep "create mode 100644 file.c" actual
       '
       
     -+test_expect_success '-L :funcname: excludes trailing empty lines at EOF' '
     -+	git init trailing-empty &&
     ++test_expect_success '-L :funcname: excludes trailing blank lines at EOF' '
     ++	git init trailing-blank &&
      +	(
     -+		cd trailing-empty &&
     ++		cd trailing-blank &&
      +		test_commit --printf --no-tag "add func.py" \
      +			func.py "def foo():\n    return 1\n" &&
     -+		test_commit --printf --no-tag "add trailing empty lines" \
     -+			func.py "def foo():\n    return 1\n\n\n\n" &&
     ++		test_commit --printf --no-tag "add trailing blank lines" \
     ++			func.py "def foo():\n    return 1\n\n  \n\t\n" &&
      +		git log -L :foo:func.py --format="%s" >actual &&
     -+		test_grep ! "add trailing empty lines" actual
     ++		test_grep ! "add trailing blank lines" actual
      +	)
      +'
      +
     -+test_expect_success '-L :funcname: excludes empty lines between functions' '
     -+	git init empty-between-funcs &&
     ++test_expect_success '-L :funcname: excludes blank lines between functions' '
     ++	git init blank-between-funcs &&
      +	(
     -+		cd empty-between-funcs &&
     ++		cd blank-between-funcs &&
      +		test_commit --printf --no-tag "add two funcs" \
      +			func.py "def foo():\n    return 1\n\ndef bar():\n    return 2\n" &&
     -+		test_commit --printf --no-tag "add empty lines between" \
     -+			func.py "def foo():\n    return 1\n\n\n\ndef bar():\n    return 2\n" &&
     ++		test_commit --printf --no-tag "add blank lines between" \
     ++			func.py "def foo():\n    return 1\n\n \n\t\ndef bar():\n    return 2\n" &&
      +		git log -L :foo:func.py --format="%s" >actual &&
     -+		test_grep ! "add empty lines between" actual
     ++		test_grep ! "add blank lines between" actual
      +	)
      +'
      +


 line-range.c                                  | 11 ++++++++
 t/t4211-line-log.sh                           | 26 +++++++++++++++++++
 t/t4211/sha1/expect.parallel-change-f-to-main | 18 +++++--------
 t/t4211/sha1/expect.simple-f-to-main          | 12 +++------
 .../sha256/expect.parallel-change-f-to-main   | 18 +++++--------
 t/t4211/sha256/expect.simple-f-to-main        | 12 +++------
 6 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/line-range.c b/line-range.c
index b99f0d9895..2dceb1cc0c 100644
--- a/line-range.c
+++ b/line-range.c
@@ -233,6 +233,17 @@ static const char *parse_range_funcname(
 		(*end)++;
 	}
 
+	/* exclude trailing blank lines from the function range */
+	while (*end > *begin + 1) {
+		const char *bol = nth_line_cb(cb_data, *end - 1);
+		const char *eol = nth_line_cb(cb_data, *end);
+		while (bol < eol && isspace(*bol))
+			bol++;
+		if (bol < eol)
+			break;
+		(*end)--;
+	}
+
 	regfree(&regexp);
 	if (xecfg)
 		xdiff_clear_find_func(xecfg);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index d0a834ed8f..0b5538b262 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -781,6 +781,32 @@ test_expect_success '--summary shows new file on root commit' '
 	test_grep "create mode 100644 file.c" actual
 '
 
+test_expect_success '-L :funcname: excludes trailing blank lines at EOF' '
+	git init trailing-blank &&
+	(
+		cd trailing-blank &&
+		test_commit --printf --no-tag "add func.py" \
+			func.py "def foo():\n    return 1\n" &&
+		test_commit --printf --no-tag "add trailing blank lines" \
+			func.py "def foo():\n    return 1\n\n  \n\t\n" &&
+		git log -L :foo:func.py --format="%s" >actual &&
+		test_grep ! "add trailing blank lines" actual
+	)
+'
+
+test_expect_success '-L :funcname: excludes blank lines between functions' '
+	git init blank-between-funcs &&
+	(
+		cd blank-between-funcs &&
+		test_commit --printf --no-tag "add two funcs" \
+			func.py "def foo():\n    return 1\n\ndef bar():\n    return 2\n" &&
+		test_commit --printf --no-tag "add blank lines between" \
+			func.py "def foo():\n    return 1\n\n \n\t\ndef bar():\n    return 2\n" &&
+		git log -L :foo:func.py --format="%s" >actual &&
+		test_grep ! "add blank lines between" actual
+	)
+'
+
 test_expect_success 'get_commit_action() does not mutate a not-yet-walked commit' '
 	git init peek &&
 	(
diff --git a/t/t4211/sha1/expect.parallel-change-f-to-main b/t/t4211/sha1/expect.parallel-change-f-to-main
index 6d7a201036..cb2f6bcbac 100644
--- a/t/t4211/sha1/expect.parallel-change-f-to-main
+++ b/t/t4211/sha1/expect.parallel-change-f-to-main
@@ -15,7 +15,7 @@ diff --git a/b.c b/b.c
 index 5de3ea4..bf79c2f 100644
 --- a/b.c
 +++ b/b.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -30,7 +30,6 @@ index 5de3ea4..bf79c2f 100644
  /*
   * This is only an example!
   */
- 
 
 commit ba227c6632349700fbb957dec2b50f5e2358be3f
 Author: Thomas Rast <trast@inf.ethz.ch>
@@ -42,7 +41,7 @@ diff --git a/a.c b/a.c
 index 5de3ea4..01b5b65 100644
 --- a/a.c
 +++ b/a.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -57,7 +56,6 @@ index 5de3ea4..01b5b65 100644
 - * This is only an example!
 + * This is only a short example!
   */
- 
 
 commit 39b6eb2d5b706d3322184a169f666f25ed3fbd00
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -69,7 +67,7 @@ diff --git a/a.c b/a.c
 index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -84,7 +82,6 @@ index e51de13..bdb2bb1 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -96,7 +93,7 @@ diff --git a/a.c b/a.c
 index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -111,7 +108,6 @@ index 3233403..e51de13 100644
  /*
   * A comment.
   */
- 
 
 commit f04fb20f2c77850996cba739709acc6faecc58f7
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -123,7 +119,7 @@ diff --git a/a.c b/a.c
 index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -137,7 +133,6 @@ index 444e415..3233403 100644
  /*
   * A comment.
   */
- 
 
 commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -150,7 +145,7 @@ new file mode 100644
 index 0000000..444e415
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -163,4 +158,3 @@ index 0000000..444e415
 +/*
 + * A comment.
 + */
-+
diff --git a/t/t4211/sha1/expect.simple-f-to-main b/t/t4211/sha1/expect.simple-f-to-main
index cd92100dfc..99404cdc40 100644
--- a/t/t4211/sha1/expect.simple-f-to-main
+++ b/t/t4211/sha1/expect.simple-f-to-main
@@ -8,7 +8,7 @@ diff --git a/a.c b/a.c
 index e51de13..bdb2bb1 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -23,7 +23,6 @@ index e51de13..bdb2bb1 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -35,7 +34,7 @@ diff --git a/a.c b/a.c
 index 3233403..e51de13 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -50,7 +49,6 @@ index 3233403..e51de13 100644
  /*
   * A comment.
   */
- 
 
 commit f04fb20f2c77850996cba739709acc6faecc58f7
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -62,7 +60,7 @@ diff --git a/a.c b/a.c
 index 444e415..3233403 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -76,7 +74,6 @@ index 444e415..3233403 100644
  /*
   * A comment.
   */
- 
 
 commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -89,7 +86,7 @@ new file mode 100644
 index 0000000..444e415
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -102,4 +99,3 @@ index 0000000..444e415
 +/*
 + * A comment.
 + */
-+
diff --git a/t/t4211/sha256/expect.parallel-change-f-to-main b/t/t4211/sha256/expect.parallel-change-f-to-main
index c93e03bef4..49f1402e46 100644
--- a/t/t4211/sha256/expect.parallel-change-f-to-main
+++ b/t/t4211/sha256/expect.parallel-change-f-to-main
@@ -15,7 +15,7 @@ diff --git a/b.c b/b.c
 index 62c1fc2..69cb69c 100644
 --- a/b.c
 +++ b/b.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -30,7 +30,6 @@ index 62c1fc2..69cb69c 100644
  /*
   * This is only an example!
   */
- 
 
 commit b511694f5337663fbd697622993a5f8e1099eca84be4df313f2b3ee94a098b42
 Author: Thomas Rast <trast@inf.ethz.ch>
@@ -42,7 +41,7 @@ diff --git a/a.c b/a.c
 index 62c1fc2..e1e8475 100644
 --- a/a.c
 +++ b/a.c
-@@ -4,14 +4,14 @@
+@@ -4,13 +4,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -57,7 +56,6 @@ index 62c1fc2..e1e8475 100644
 - * This is only an example!
 + * This is only a short example!
   */
- 
 
 commit 5a1b3989063d55e71e7685efa3392f133385b4034bddde530dcb5090d8b8b8ca
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -69,7 +67,7 @@ diff --git a/a.c b/a.c
 index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -84,7 +82,6 @@ index 75c0119..3a78aaf 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -96,7 +93,7 @@ diff --git a/a.c b/a.c
 index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -111,7 +108,6 @@ index 7a296b9..75c0119 100644
  /*
   * A comment.
   */
- 
 
 commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -123,7 +119,7 @@ diff --git a/a.c b/a.c
 index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -137,7 +133,6 @@ index 9f550c3..7a296b9 100644
  /*
   * A comment.
   */
- 
 
 commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -150,7 +145,7 @@ new file mode 100644
 index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -163,4 +158,3 @@ index 0000000..9f550c3
 +/*
 + * A comment.
 + */
-+
diff --git a/t/t4211/sha256/expect.simple-f-to-main b/t/t4211/sha256/expect.simple-f-to-main
index e67fa017a7..3dd225947e 100644
--- a/t/t4211/sha256/expect.simple-f-to-main
+++ b/t/t4211/sha256/expect.simple-f-to-main
@@ -8,7 +8,7 @@ diff --git a/a.c b/a.c
 index 75c0119..3a78aaf 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
  long f(long x)
  {
  	int s = 0;
@@ -23,7 +23,6 @@ index 75c0119..3a78aaf 100644
 - * A comment.
 + * This is only an example!
   */
- 
 
 commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -35,7 +34,7 @@ diff --git a/a.c b/a.c
 index 7a296b9..75c0119 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,14 +3,14 @@
+@@ -3,13 +3,13 @@
 -int f(int x)
 +long f(long x)
  {
@@ -50,7 +49,6 @@ index 7a296b9..75c0119 100644
  /*
   * A comment.
   */
- 
 
 commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -62,7 +60,7 @@ diff --git a/a.c b/a.c
 index 9f550c3..7a296b9 100644
 --- a/a.c
 +++ b/a.c
-@@ -3,13 +3,14 @@
+@@ -3,12 +3,13 @@
  int f(int x)
  {
  	int s = 0;
@@ -76,7 +74,6 @@ index 9f550c3..7a296b9 100644
  /*
   * A comment.
   */
- 
 
 commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
 Author: Thomas Rast <trast@student.ethz.ch>
@@ -89,7 +86,7 @@ new file mode 100644
 index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +3,13 @@
+@@ -0,0 +3,12 @@
 +int f(int x)
 +{
 +	int s = 0;
@@ -102,4 +99,3 @@ index 0000000..9f550c3
 +/*
 + * A comment.
 + */
-+

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
