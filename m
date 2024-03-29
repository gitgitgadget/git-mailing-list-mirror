Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378E381AD
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684724; cv=none; b=fUGLBYoLAoaOAV8Z9X9QDo4zwoRdgEkxAMp0IQ5gSPypILj69ld4YvrwY4ZJE7NIzACxU+aa4Ep9U1XwhPxPUXSIaQwY/x3gm9YSvDDmU2kGvKp8DFdtWj1SZHdFVzcDZhXt5ecsxbMNi2o8VaWhK6zhaqbhHgL840PZnMupkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684724; c=relaxed/simple;
	bh=afFFj9wzNvhnnQs0zmYWzrKM+HnRGj6CO6oGRHZt7t4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uwiO2lC+As0CFqKSDdUB2bOORoxDer2X9CCRopYfo/iTqHbKONfoo2QfXGNzk1m12apGZLfX3bqCEC+S8XTvHwwoLKkDmXQA7jyoGcZ+D8HuwV/6IGZemAIz5QjayUxqG/cjiyMKVNMyO/hMyLhKTQcwiu0lbDZqxOKLwqnPmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZJAY6Ud; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZJAY6Ud"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso843365f8f.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 20:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711684721; x=1712289521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ao4v96ZSb+um2rQvqluoqIhAYCQCqnZIpC3ykusINek=;
        b=CZJAY6UdIbmUx5UQOobEWsuezMY+n0zRO5nsZvwNsGXDYUShHrCsAHb6f8J85ep2gY
         AEBFhCwwTljRpIl7Njpu7EZ1WyJkeexur4PAhs/8IoJDVOh9ENosryx1L4mL3cU96AAf
         mICTzA+peV2wJX/ke6MYGznG7DA0UN7s1fkV3FJQFyLlG67AlY6pKABytYu7vaTxCype
         N0CfddAx9a1QQURVTSb0A5TiBHYOspdO0+1tsqVzabwPV4+sILuGwsB/k9jooExWcl+h
         gCR9ptFR/XL7rvvSwUY1gQTgthgc9bZb/Vsftcp1/tJ5qQQLJpzQMe1STLLTD01DO8uw
         bImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684721; x=1712289521;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao4v96ZSb+um2rQvqluoqIhAYCQCqnZIpC3ykusINek=;
        b=l+90W0WZjEj1aOxeNtqpkCgOerSalFh6Z1mLlGA3daWvSQJd/FsGB+tbhiqj7jCWHR
         HCcGy7FxAvUv5RkBWHCKRJkf1t30/pUVyicPbCR/L2ixR+3w+xFeQzjjFG1tiuTK17bz
         2ZeE+LSpuaFjUGP8PnVveF8xytHHBK+FxgjGCHbyfD/fg5D+UkD8tnQ6tnQ6sygyV0oW
         9Vom+OLbUHm4uZp/QwZbT4vfA7RncMZ55uEWraRzzc+wJrdEqMGF4Cjww8nrGh03e9Tf
         8PCcIsRuEE91J2Xq04ILT3w1vs9qSnh4HnTaZifM5DgPbcdaZTeoh7l657ES4aYiVhvL
         pbvg==
X-Gm-Message-State: AOJu0Ywuf88hMIwajxvzrYAmlAbVkdxy9edQPZaW/rcoaFMFj7A6eEiN
	/Vb0GDMj8G7CVQmIXtKLap0vdWNjeShpZPOdgis8d3jGgnZhspIeTzwbWNym
X-Google-Smtp-Source: AGHT+IGbqDSoJ0Igqsn8UnO8y4Xdl0jJaFoDfXM0owV0f7tM1tni8jH/8+zA68vYcE/4bMXKUOIhfw==
X-Received: by 2002:adf:e6cb:0:b0:343:343f:85da with SMTP id y11-20020adfe6cb000000b00343343f85damr2628878wrm.33.1711684720917;
        Thu, 28 Mar 2024 20:58:40 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id dw14-20020a0560000dce00b0034174875850sm3154990wrb.70.2024.03.28.20.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 20:58:40 -0700 (PDT)
Message-ID: <5d1c767c-4558-4d81-a6d4-6d3eef8d6ca6@gmail.com>
Date: Fri, 29 Mar 2024 04:58:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/2] add-patch: introduce 'p' in interactive-patch
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
 <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
Content-Language: en-US
In-Reply-To: <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>
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
index 14a371fff3..aceaa025e3 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -348,6 +348,7 @@ patch::
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       p - print the current hunk
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..b5d3a3f0cc 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
+   "p - print the current hunk\n"
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
2.44.0.370.ge17b8d70f1
