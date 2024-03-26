Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13588163
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412258; cv=none; b=qU0t10d27luIVbSyZ62S5uZt220Qd9hZhNrTpXtu3aotLxTy3NJCKoAYDYtUkVOVxCD09545Z0R7PJlVLDwtdg/7d67wKxwpM6OsLCxH8I6sFq9SMBZ1yBrYEli3utd//JmuGHwTRP4/nNgTrZkx30NsARx5YKJSOVI+Us5X6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412258; c=relaxed/simple;
	bh=P/R0/IEdirTlDGfAlhhhX9ohln4OeQhG5/yEmWv0NAM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jSk2wX7xOFTylVcyc3nuyEVF5DRuNEXzifDOlLMW7e0WBbQxlZ9DCtG+dI4wbNNsLibv/RXIwlaVX1cB3HDSqE9N4ng9Cw1M0GxZRVzdp6oOYTh8oHjSpUEis964ER3lBTrdRVoTV9AAj1bupWhvcRTKBo5H2cUQq8OmOEndNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MENEOggu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MENEOggu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4148c65ea45so4411065e9.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711412255; x=1712017055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXRT/qVSx4UDLPRHFs/xj53qu3CwxE+F8mxHvhAgrqI=;
        b=MENEOgguYkgHXxsHjXiynS/FBqWSo90ni4RSsbv5jOfcZc9GPJSp4yv73nW+/K/tai
         HDHX4DIlsmX7CpIXAdGMBcB3buC5UceXs3WwCdzfQvgw4Zw/RbPQIexF/q9hcBrAwho8
         HUwNxJiTddis6eogLKO8C2HPuRQR93L0gYJAbu+iGmpJgJxXvvbpymwIvhJW2TQDUqR1
         /V4tcH6wO/tTwkZSc5cTEblqu8D+4dC664NWQ3MNesHrnRCQ+t/GzY5G1UL2eTAxo48d
         zk0hP5G3YkWxFa1lyNd2tKOv9P1N2r8K2wQdQULrr0fhuQaJikEZQKQv9icujStRHHq/
         n7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711412255; x=1712017055;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXRT/qVSx4UDLPRHFs/xj53qu3CwxE+F8mxHvhAgrqI=;
        b=dhRsGB0oHUY17W/SBg1qjAUBNoKLxQwCpmC+sH33bCT5Uq6P5dw4KumqmqBZfVVgW2
         zMQlijzrOrE4upxZ/FEcV8Av5SJ0ibI38/5A/p8UDAgdcb9/JN/qVnUc8p8vGbsPNsDj
         w2PCwj9gQ2bDhN67W0xfxGI+MwUgwCFe3qi7L97ux1nNI1xSTy2zM0ZKZB36Z7m+LMl7
         B4N3ZgNEHMoOY0TKQpVDPNJXpKsYfREbAvxQvhMC49i7Cg5uCJL/CXcwJlCXO/h81Ue4
         uVnnmiPbqlBn0riVsZD04t5RHA4wqpoEjY8RgKGphG3VsWkM0A1IikOFi0iaGJ3JDO3m
         d2uw==
X-Gm-Message-State: AOJu0YyYIVncyUjH94zCxFzjgXi1FsCjzU28Qnp1gTfR4MDowes9aRFD
	SkURdeFCt17o4A6oox4RBWznZTvoktiSVP0nBlOAeR7B0uNQJ0Yb9NygRhdk
X-Google-Smtp-Source: AGHT+IHNb0+AaMnwpiNCxY59oLw6hjNvmfaZj1ZrUJQNA3y34NoaIyudo2qeRRhCl9vmFfMe34sxRQ==
X-Received: by 2002:adf:f884:0:b0:33d:9c3d:f930 with SMTP id u4-20020adff884000000b0033d9c3df930mr6412386wrp.66.1711412255227;
        Mon, 25 Mar 2024 17:17:35 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id k13-20020adff5cd000000b0033ec9936909sm10717287wrp.39.2024.03.25.17.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 17:17:34 -0700 (PDT)
Message-ID: <34e027d3-c351-431b-97de-e15a2d5a9756@gmail.com>
Date: Tue, 26 Mar 2024 01:17:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] add-patch: introduce 'p' in interactive-patch
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
In-Reply-To: <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shortly we're going make interactive-patch stop printing automatically
the hunk under certain circumstances.

Let's introduce a new option to allow the user to explicitly request
the printing.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 Documentation/git-add.txt  |  1 +
 add-patch.c                |  4 ++++
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 14a371fff3..90b47927b2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -348,6 +348,7 @@ patch::
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       p - print again the current hunk
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..444fd75b2a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
+   "p - print again the current hunk\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1480,6 +1481,7 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
+			strbuf_addstr(&s->buf, ",p");
 		}
 		if (file_diff->deleted)
 			prompt_mode_type = PROMPT_DELETION;
@@ -1658,6 +1660,8 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
+		} else if (s->answer.buf[0] == 'p') {
+			/* nothing special is needed */
 		} else {
 			const char *p = _(help_patch_remainder), *eol = p;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 0b5339ac6c..bc55255b0a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -325,9 +325,9 @@ test_expect_success 'different prompts for mode change/deleted' '
 	git -c core.filemode=true add -p >actual &&
 	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
 	cat >expect <<-\EOF &&
-	(1/1) Stage deletion [y,n,q,a,d,?]?
-	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,?]?
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]?
+	(1/1) Stage deletion [y,n,q,a,d,p,?]?
+	(1/2) Stage mode change [y,n,q,a,d,j,J,g,/,p,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]?
 	EOF
 	test_cmp expect actual.filtered
 '
@@ -514,13 +514,13 @@ test_expect_success 'split hunk setup' '
 test_expect_success 'goto hunk' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? + 1:  -1,2 +1,3          +15
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? + 1:  -1,2 +1,3          +15
 	_ 2:  -2,4 +3,8          +21
 	go to which hunk? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -530,11 +530,11 @@ test_expect_success 'goto hunk' '
 test_expect_success 'navigate to hunk via regex' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? @@ -1,2 +1,3 @@
+	(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? @@ -1,2 +1,3 @@
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?_
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -715,21 +715,21 @@ test_expect_success 'colors can be overridden' '
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+<RESET><BLUE>new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
 	<CYAN> more-context<RESET>
 	<BLUE>+<RESET><BLUE>another-one<RESET>
-	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,p,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
-- 
2.44.0.494.gfaa70abb0d
