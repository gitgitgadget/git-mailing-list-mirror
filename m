Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46022086
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533819; cv=none; b=UvEVvW70ZLKa0hAs2Xea8rGf3Q4R035pr1zT4Pl6Y7Vx5kT/z7oospJZo9xi+Mo8mKlHaLmOk63BZlkF2m44BvmMWg9552k2DjFfNBhY1TRu6NR4oxOlhKA5/SHmbb5jHM9i6FI963KVJsnahLCYx26Oo7+31paVpQ4m6Ckv3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533819; c=relaxed/simple;
	bh=LxeTtoIl2LtyfmQRhxf8skPH7X6n02WMDoqRWvF823Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lJGLnkMUSOlwCbMFrFpi7kwwx6d0C5Xxj7BOqTMYH4wd1Okix5/JDf4kYIPpPuTGvGLc+8UG8uusydz95FMPTjBWpzWCwTKz8LqjNHivoA0swR8fog5ofYItnhVxUcTHCLoxj/woW3I3cQlesxQVO+vLZKGDD3X6d4fNu584G8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kd0Wutp/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd0Wutp/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso18629685e9.0
        for <git@vger.kernel.org>; Sat, 28 Sep 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727533816; x=1728138616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHIBptl2YmW9msQG0GzTonRSj/2ue8oJo8IQg6e0aiU=;
        b=Kd0Wutp/FTZ7g/e9FLwLc1ZLdWUIzMzFq/fF+Srno4IRacx4N+lVAcfpRWs2gQ9Usv
         pr53b+xwxzLLDZgQC4nsuACDtoo0tLtqYc1uymAD82pp4bDBlpbVTqL84yNlPmXa7Tjp
         WKO+fSUduKj7cffNBHdGfbThEFVW27VXr5/CO1/3HaSMu9AHoA4kUXA2niTZrQeUng7i
         fTpunRTbkSwo7yzek3FLENr4cB+fe4DNxfqZ+ZLAB6Jx8gXBBptEs20cUb7gwCWq9jQ0
         ZDRG2Erk/PEqZECjmTRV5CKDeUNvp7XhiWgKfBm4XtqSjJuTMRDNCWiHZvIWPjSHRGhi
         tLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727533816; x=1728138616;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHIBptl2YmW9msQG0GzTonRSj/2ue8oJo8IQg6e0aiU=;
        b=H+uaK6hVeekqMR6Dzlmzh/PrMDMhwRT4VTu0hDuwvveHiap8pqN26aquoxhSxlhN9J
         sUd30o0opyX54WX0bF4VhSFBBO+wPWlV37iqxyKuZaVEmwYJbbHG8liHiNjbr6GaVIoX
         y0+bTqxvhX9c8KjOQk0RZ+IyNoNr0dBQlGHElXhlXym4rtmtKchipslmgnJ8MgbxJUSm
         triYZMvUUnLGnmz3aN5BT8H+9MLCO3OJ0ilxHrL5/kCHS8bit6DJC/Ki2RRIPUpPlZP/
         usN8pCbuZ+RdkNusQGux6ozA8PQgzqp+NxzDMWSngrOUuSPLv7S6PedE60c6qCrU3BNs
         esSA==
X-Gm-Message-State: AOJu0YwNeX7mZQjYtunoTuD/qujyqcJ/Thr1B7WwL6jYVXFs32xQFxaZ
	BYUrazag6uKqHmkFv2DN0Wv0zPfxv9a4QyWveeapktoylt69FZZS57t5qg==
X-Google-Smtp-Source: AGHT+IFuN4/Li1nZfbFrW4ZygqEY2i7Tb7ZA/sbYKK6IQJgvPBu1aVRxH0RBy2Bm9I+G1vUuW6MPiA==
X-Received: by 2002:a05:600c:5117:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-42f57fc9204mr38885865e9.11.1727533815784;
        Sat, 28 Sep 2024 07:30:15 -0700 (PDT)
Received: from gmail.com (108.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57310f6sm4991728f8f.78.2024.09.28.07.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 07:30:15 -0700 (PDT)
Message-ID: <74289d8b-7211-452a-ac76-f733e89112e6@gmail.com>
Date: Sat, 28 Sep 2024 16:30:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] add-patch: edit the hunk again
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
Content-Language: en-US
In-Reply-To: <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
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
say 'no', to cancel the "edit" and start anew [*].

    * In the old script-based version of "add -p", this "no" meant
      discarding the hunk and moving on to the next one.

      This changed, probably unintentionally, during its conversion to
      C in bcdd297b78 (built-in add -p: implement hunk editing,
      2019-12-13).

      It now makes more sense not to move to the next block when the
      user requests to discard their edits.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

In this iteration, I'm modifying the message 'saying no discards' to
make its meaning more explicit, perhaps also gaining some clarity
along the way for the user who wants to restart editing from the
original patch.

In the test, I'm adding "n q" to the script as suggested by Phillip.

And, just a bit of mental peace by restoring the hunk from the backup
before trimming the two strbuf.

Thanks.

 add-patch.c                | 33 ++++++++++++++++++++-------------
 t/t3701-add-interactive.sh | 13 +++++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 557903310d..c847b4a59d 100644
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
@@ -1286,11 +1287,17 @@ static int edit_hunk_loop(struct add_p_state *s,
 		 * of the word "no" does not start with n.
 		 */
 		res = prompt_yesno(s, _("Your edited hunk does not apply. "
-					"Edit again (saying \"no\" discards!) "
+					"Edit again (saying \"no\" discards your edits!) "
 					"[y/n]? "));
 		if (res < 1)
-			return -1;
+			break;
 	}
+
+	/* Drop a possible edit */
+	*hunk = backup;
+	strbuf_setlen(&s->plain, plain_len);
+	strbuf_setlen(&s->colored, colored_len);
+	return -1;
 }
 
 static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 718438ffc7..1ceefd96e6 100755
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
+		test_write_lines e y n q | GIT_TRACE=1 git add -p
+	) &&
+	test_grep been-here output
+'
+
 test_expect_success 'setup patch' '
 	cat >patch <<-\EOF
 	@@ -1,1 +1,4 @@

Range-diff against v2:
1:  2b55a759d5 ! 1:  7e76606751 add-patch: edit the hunk again
    @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
      		/*
      		 * TRANSLATORS: do not translate [y/n]
     @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
    - 					"Edit again (saying \"no\" discards!) "
    + 		 * of the word "no" does not start with n.
    + 		 */
    + 		res = prompt_yesno(s, _("Your edited hunk does not apply. "
    +-					"Edit again (saying \"no\" discards!) "
    ++					"Edit again (saying \"no\" discards your edits!) "
      					"[y/n]? "));
      		if (res < 1)
     -			return -1;
    @@ add-patch.c: static int edit_hunk_loop(struct add_p_state *s,
      	}
     +
     +	/* Drop a possible edit */
    ++	*hunk = backup;
     +	strbuf_setlen(&s->plain, plain_len);
     +	strbuf_setlen(&s->colored, colored_len);
    -+	*hunk = backup;
     +	return -1;
      }
      
    @@ t/t3701-add-interactive.sh: test_expect_success 'dummy edit works' '
     +	EOF
     +	(
     +		test_set_editor "$(pwd)/fake_editor.sh" &&
    -+		test_write_lines e y | GIT_TRACE=1 git add -p
    ++		test_write_lines e y n q | GIT_TRACE=1 git add -p
     +	) &&
     +	test_grep been-here output
     +'
-- 
2.47.0.rc0.1.g1645ecd054
