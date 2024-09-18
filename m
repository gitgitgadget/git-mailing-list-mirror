Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F991C8FD0
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681906; cv=none; b=ktG1o2WxZuCqzojP+DhE2b/zSj0zuefpOm8zc/CgIvwe2/n3odkSw/Iy3RI/LaCEgTkfTrIje9rF1P6/MCSVwDHcuE0qPPAF07z16HYWv/RfXUwvU6dGzgnz7Ek4y94UzEg6Rj5hYvtZ1OZFQZN78X2HjvTFb8q8l4bNGI+GuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681906; c=relaxed/simple;
	bh=cm8cFsF5iuxY9iY0TVVAFtBZLh/1OZYwbMQMnbQFIrg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rJ3RvLCllgL5BeDSrUm73dMLoUtmtZDCycYRFRbbmo4EGkvH74f715bA15bgheDGrjpcfjOXxyeM5WikdQOMSdhHjHgd6jj2rol9/VCMVMwjnC76aFx2m9WlmjVSkqOEVJuxkMvldWdPmvA2Cs66djWYZEwN2gLPZOAvu5x7esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JItgGmHA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JItgGmHA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so69086745e9.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726681903; x=1727286703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMpyx+mYi3/LBWRQyuRd6RhVzZc9ljiAFt8uyU9/9Yk=;
        b=JItgGmHAFfM34B2WQUyBg0AycA71fhRFOuJIxRsFr4WNDZK41qLA1d7pqH2EvqeSEG
         UjDuEliGU+HhiNyA1hyj+lqsXc3jPQTgvYtUM9jintJgYligyXcrru8ZfUl6T+/43x24
         OWjxi9V2H/vGTp3QXmqCEtC/LOsvndWsUVucuso2gJOimzd8hRyZbhYW+8RVLZAlS2rb
         AyNyAF8FPDQzf9Gv1b9tVPGQxL4i83EChVmL5cicntcfYrzXOoMganFj0Oxc7srS9sMQ
         yDGAna0S3VO0N6nJTe5HXlwt8i/WmSc3DEqN6lCbLqnAD8ftXJ4GLDH49emRM4vjfrn3
         dzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726681903; x=1727286703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMpyx+mYi3/LBWRQyuRd6RhVzZc9ljiAFt8uyU9/9Yk=;
        b=G2ehIEDlirWzB+pHoqCaaV3KG+QHAC2TIZpkwXQDUsF6iLZArTCn7E460Z3r35VCfz
         PEIPN+VHg4VnFYbRnVTMWH5Bu74950dy2QKTrUaY0YiWWcieAmw/ZjURwLJcSYyC1VqS
         JhGWMNxC4agT5toUEs3WjPr6YYoOS1IcM/w42d0SQsNG2Abqexu1CEvJSh4Z+cCfR60Q
         Lt5nRvhL5zaGDLIoWBYjfvuUb5pLviKDtXiRd9XHmN+y0DxTLxXR/98ZOh52zDtDuUD7
         9wM7xKYIC6PDZ9xNjzOI0BFaQzmMfzl1Vhs7DaFIImM0aLE0QpBR1VTUAwpFtiGLj15T
         eeLg==
X-Gm-Message-State: AOJu0Yx0DKGBccYXfJJe/FqUUyXdTuNu4uwEgYCSldAR3MmYSgcd6nQ+
	THfMnsX7V5KuUpabH7UiAwLdSYtEUWb5kS32/HLd2Cgfgcj8LOIhXvBfvw==
X-Google-Smtp-Source: AGHT+IFybvy8DjnUVqiS5vpXUhIABrYkjgufBuZsBkFXjA08TZGnoTiNefLgEY0Pm+upW9OPttXXNg==
X-Received: by 2002:a05:600c:19ce:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42cdb56ae9bmr189133835e9.23.1726681902537;
        Wed, 18 Sep 2024 10:51:42 -0700 (PDT)
Received: from gmail.com (67.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704f261esm22592235e9.26.2024.09.18.10.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 10:51:41 -0700 (PDT)
Message-ID: <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
Date: Wed, 18 Sep 2024 19:51:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] add-patch: edit the hunk again
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
Content-Language: en-US
In-Reply-To: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "edit" option allows the user to directly modify the hunk to be
applied.

If the modified hunk returned by the user is not an applicable patch,
they will be given the opportunity to try again.

For this new attempt we give them the original hunk;  they have to
repeat the modification from scratch.

Instead, let's give them the modified patch back, so they can identify
and fix the problem.

If they really want to start over with a fresh patch they still can
say "no" to cancel the "edit" and start anew [*].

    * In the old script-based version of "add -p", this "no" meant
      discarding the hunk and moving on to the next one.

      This changed, probably unintentionally, during its conversion to
      C in bcdd297b78 (built-in add -p: implement hunk editing,
      2019-12-13).

      It now makes more sense not to move to the next hunk when the
      user requests to discard their edits.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This iteration addresses Phillip's comments:

 - Ensure that `edit_hunk_manually()` exits with sane values in
   `hunk`.

 - Merge the tests into a single one and use a subshell to prevent
   leaking `EDITOR`.

Thanks.

 add-patch.c                | 31 +++++++++++++++++++------------
 t/t3701-add-interactive.sh | 13 +++++++++++++
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 557903310d..75b5129281 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1111,7 +1111,8 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 	hunk->colored_end = s->colored.len;
 }
 
-static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
+static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk,
+			      size_t plain_len, size_t colored_len)
 {
 	size_t i;
 
@@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				      "addp-hunk-edit.diff", NULL) < 0)
 		return -1;
 
+	/* Drop possible previous edits */
+	strbuf_setlen(&s->plain, plain_len);
+	strbuf_setlen(&s->colored, colored_len);
+
 	/* strip out commented lines */
 	hunk->start = s->plain.len;
 	for (i = 0; i < s->buf.len; ) {
@@ -1157,12 +1162,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	}
 
 	hunk->end = s->plain.len;
+
+	recolor_hunk(s, hunk);
+
 	if (hunk->end == hunk->start)
 		/* The user aborted editing by deleting everything */
 		return 0;
 
-	recolor_hunk(s, hunk);
-
 	/*
 	 * If the hunk header is intact, parse it, otherwise simply use the
 	 * hunk header prior to editing (which will adjust `hunk->start` to
@@ -1257,15 +1263,14 @@ static int edit_hunk_loop(struct add_p_state *s,
 	backup = *hunk;
 
 	for (;;) {
-		int res = edit_hunk_manually(s, hunk);
+		int res = edit_hunk_manually(s, hunk, plain_len, colored_len);
 		if (res == 0) {
 			/* abandoned */
-			*hunk = backup;
-			return -1;
+			break;
 		}
 
 		if (res > 0) {
-			hunk->delta +=
+			hunk->delta = backup.delta +
 				recount_edited_hunk(s, hunk,
 						    backup.header.old_count,
 						    backup.header.new_count);
@@ -1273,10 +1278,6 @@ static int edit_hunk_loop(struct add_p_state *s,
 				return 0;
 		}
 
-		/* Drop edits (they were appended to s->plain) */
-		strbuf_setlen(&s->plain, plain_len);
-		strbuf_setlen(&s->colored, colored_len);
-		*hunk = backup;
 
 		/*
 		 * TRANSLATORS: do not translate [y/n]
@@ -1289,8 +1290,14 @@ static int edit_hunk_loop(struct add_p_state *s,
 					"Edit again (saying \"no\" discards!) "
 					"[y/n]? "));
 		if (res < 1)
-			return -1;
+			break;
 	}
+
+	/* Drop a possible edit */
+	strbuf_setlen(&s->plain, plain_len);
+	strbuf_setlen(&s->colored, colored_len);
+	*hunk = backup;
+	return -1;
 }
 
 static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 718438ffc7..f3206a317b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -165,6 +165,19 @@ test_expect_success 'dummy edit works' '
 	diff_cmp expected diff
 '
 
+test_expect_success 'editing again works' '
+	git reset &&
+	write_script "fake_editor.sh" <<-\EOF &&
+	grep been-here "$1" >output
+	echo been-here >"$1"
+	EOF
+	(
+		test_set_editor "$(pwd)/fake_editor.sh" &&
+		test_write_lines e y | GIT_TRACE=1 git add -p
+	) &&
+	test_grep been-here output
+'
+
 test_expect_success 'setup patch' '
 	cat >patch <<-\EOF
 	@@ -1,1 +1,4 @@

Range-diff:
1:  bcf32d0979 ! 1:  2b55a759d5 add-patch: edit the hunk again
    @@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *h
      	/* strip out commented lines */
      	hunk->start = s->plain.len;
      	for (i = 0; i < s->buf.len; ) {
    +@@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
    + 	}
    + 
    + 	hunk->end = s->plain.len;
    ++
    ++	recolor_hunk(s, hunk);
    ++
    + 	if (hunk->end == hunk->start)
    + 		/* The user aborted editing by deleting everything */
    + 		return 0;
    + 
    +-	recolor_hunk(s, hunk);
    +-
    + 	/*
    + 	 * If the hunk header is intact, parse it, otherwise simply use the
    + 	 * hunk header prior to editing (which will adjust `hunk->start` to
     @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
      	backup = *hunk;
      
    @@ t/t3701-add-interactive.sh: test_expect_success 'dummy edit works' '
      	diff_cmp expected diff
      '
      
    -+test_expect_success 'setup re-edit editor' '
    -+	write_script "fake_editor.sh" <<-\EOF &&
    -+	grep been-here "$1" && echo found >output
    -+	echo been-here > "$1"
    -+	EOF
    -+	test_set_editor "$(pwd)/fake_editor.sh"
    -+'
    -+
     +test_expect_success 'editing again works' '
     +	git reset &&
    -+	test_write_lines e y | GIT_TRACE=1 git add -p &&
    -+	grep found output
    ++	write_script "fake_editor.sh" <<-\EOF &&
    ++	grep been-here "$1" >output
    ++	echo been-here >"$1"
    ++	EOF
    ++	(
    ++		test_set_editor "$(pwd)/fake_editor.sh" &&
    ++		test_write_lines e y | GIT_TRACE=1 git add -p
    ++	) &&
    ++	test_grep been-here output
     +'
     +
      test_expect_success 'setup patch' '
-- 
2.46.1.507.gdd29a28bc2
