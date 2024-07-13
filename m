Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAE13B58A
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888209; cv=none; b=JWKxGY0cDkwso0TjntLTbtTt+CyzzDoDxTCLsw9+xMlkYynBjiroWLK09ZYl3eCX9moI3NukgzaZxm/3IScxabVblUiL3msYNzJwDr/wRy0pzKrNySWScPWq8fzTWJ3DpJmizrKBa8poZ4/cdyo15eLnXyN5ij4iuHEGKxj4yCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888209; c=relaxed/simple;
	bh=UUTzpEW57fHTaj7kIu4iWsYO0CW3qIf+luKlgLU2JeE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lGPrHMAvlWiMLJySsyODNu2QLm1nNFc0T74CLaSxLgVvSYhZJTBZ8WCaEQs33mspLa/Z7MrHXViH2SBpZbqDH8yXfzibRw+O2Fgn90E7il2F+DRwIcT5Ukir6DjpAIvDfipPTFoRtqIx1JuXVkfzLk06YRhL9MmxG3pCuWQX2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6p0FOeD; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6p0FOeD"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-380eb36f5ceso12143855ab.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720888207; x=1721493007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dTOJOlXw8WcA8RcsYNBiryqYbVnDNdRw+4jeTorZl4o=;
        b=S6p0FOeDiBGt3NebpKhS+Fx8rUQIh9bgEaZ4YqtGrPdNcjJDRtZRI3lbnZECEZ07oY
         8imAsvyrzYfNufYX+ZMGXlJh4w4zpQd5xczXx0jAtf1gHsTaZbsI18zVI7iJ2LTqeEZj
         +yU8+0nc9IgH0MOwMoj3qWVmvTyYKxQkaz6Opu8xiAe/65v59KzH8v2sozB5gFO23i+c
         Z7PWg5kw5i/KqSegeL/icH06Rah9lei//1sXKRkj1HaGNvo8or678vrp1mohg9/FEzgm
         gBOHpmJ/DPa/GLNNjnhWQ5NW99rgxWsukhBLWyDT5nVhLzfF0fsDf2vtrPexJXHZSZOY
         j7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720888207; x=1721493007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTOJOlXw8WcA8RcsYNBiryqYbVnDNdRw+4jeTorZl4o=;
        b=Kj4n45b4ylzR7BUIu8dlytU/E9OQb0xihQs1sUyiRzkgmb0pTMuHShoKIdjfFlycU4
         0O/ucPBkv1jGK7GiiwsmFD98xD/6fb6BGMwFFe3eRrmSxkhFM4VKlg2nGf7KDDtCwibb
         KoHazpPYgsZ04b8kcKs1mte8jWMUQpnR2kxNKy5G1zO8s4jlvfcfHkO7c6If5nLF4zvS
         FWDpJA58OEVmP8mL8oLTW81RTC3cYDI+5UZLIH/DmK6Ef8ivMgTs3Jc5jyw9GDfgNFu5
         0CdzlYEFgR6Esui0QvlI3oT0SsLar9Ayuzh5fFeA8aWd8CbHp7jq7x1upwZFtgUNDKIY
         jVKw==
X-Gm-Message-State: AOJu0YxdVimh1JA/st9vNN9RJ0Fkk4pKcoAzUGNxpg40H7Yy3X6IP+SA
	HsUC59bwNfSOq5YkTHh6DBAa1Pbqf47Cd9J567Wgg5tKR8u7+Rb9PwgEfw==
X-Google-Smtp-Source: AGHT+IFZ6MbCMTGTJ6p0hE1BGT8lvSYevZm1s8tvdu0C+ctRNLyoqfPKR4DQXNfvEKNapbp37oJ5FA==
X-Received: by 2002:a05:6e02:1c8d:b0:383:6af0:eb08 with SMTP id e9e14a558f8ab-38a56f09dfdmr168995885ab.1.1720888206987;
        Sat, 13 Jul 2024 09:30:06 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e232sm1409029b3a.34.2024.07.13.09.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 09:30:06 -0700 (PDT)
Message-ID: <4556095f-47d7-4849-b6d7-a08cd00ad865@gmail.com>
Date: Sun, 14 Jul 2024 01:30:03 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/4] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Language: en-US
In-Reply-To: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the print command trigger the pager when invoked using a capital
'P', to make it easier for the user to review long hunks.

Note that if the PAGER ends unexpectedly before we've been able to send
the payload, perhaps because the user is not interested in the whole
thing, we might receive a SIGPIPE, which would abruptly and unexpectedly
terminate the interactive session for the user.

Therefore, we need to ignore a possible SIGPIPE signal.  Add a test for
this, in addition to the test for normal operation.

For the SIGPIPE test, we need to make sure that we completely fill the
operating system's buffer, otherwise we might not trigger the SIGPIPE
signal.  The normal size of this buffer in different OSs varies from a
few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
this limit.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                | 18 +++++++++++++++---
 t/t3701-add-interactive.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 6e176cd21a..f2c76b7d83 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,9 +7,11 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "sigchain.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "pathspec.h"
@@ -1391,7 +1393,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
    "/ - search for a hunk matching the given regex\n"
    "s - split the current hunk into smaller hunks\n"
    "e - manually edit the current hunk\n"
-   "p - print the current hunk\n"
+   "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
 
 static int patch_update_file(struct add_p_state *s,
@@ -1402,7 +1404,7 @@ static int patch_update_file(struct add_p_state *s,
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0;
+	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	enum {
 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
@@ -1452,9 +1454,18 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
+				if (use_pager) {
+					setup_pager();
+					sigchain_push(SIGPIPE, SIG_IGN);
+				}
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
+				if (use_pager) {
+					sigchain_pop(SIGPIPE);
+					wait_for_pager();
+					use_pager = 0;
+				}
 			}
 
 			strbuf_reset(&s->buf);
@@ -1675,8 +1686,9 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = USE_HUNK;
 				goto soft_increment;
 			}
-		} else if (s->answer.buf[0] == 'p') {
+		} else if (ch == 'p') {
 			rendered_hunk_index = -1;
+			use_pager = (s->answer.buf[0] == 'P') ? 1 : 0;
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6daf3a6be0..c89b984751 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -591,6 +591,34 @@ test_expect_success 'print again the hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success TTY 'print again the hunk (PAGER)' '
+	test_when_finished "git reset" &&
+	cat >expect <<-EOF &&
+	<GREEN>+<RESET><GREEN>15<RESET>
+	 20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	PAGER  10<RESET>
+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
+	PAGER  20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	EOF
+	test_write_lines s y g 1 P |
+	(
+		GIT_PAGER="sed s/^/PAGER\ /" &&
+		export GIT_PAGER &&
+		test_terminal git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
+test_expect_success TTY 'P does not break if pager ends unexpectedly' '
+	test_when_finished "rm -f huge_file; git reset" &&
+	printf "%2500000s" Y >huge_file &&
+	git add -N huge_file &&
+	test_write_lines P q | GIT_PAGER="head -c 1" test_terminal git add -p >actual
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.45.2.831.g9e4974e3d4
