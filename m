Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B4C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiBVSyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBVSyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DAD114FC9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d28so7448978wra.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6c5ZkTaOY71A45Zr8zmD1XsOpyurqbzl+JMQ1ZJgy6s=;
        b=Qu5MH3Co4jZCcdYD0bTwLKqYCFLW8zCuxmm+GnGVC0Oo6MpXzv/v2AFcSmfkzhkTOj
         PS2s9zP+r+I4aBff7TqYRSVnNfSYr534VrYBZ6QVry5yGqIr//5Qvf3M+4g/CMksfStG
         RuSj4v2JcAtj5UL/7zjleUpYVPSo30CWg+oVK/bN4XFbVSj5cgPunZGWOCjYcuFXUTaK
         qS3FoK2O0ImVQQzKGay2lYwZRFnCSmkdNxwkiYBsntZ0v40JTd6Fn+++PrHj24LK2HoR
         i2q4XvXVIqbpEQX6+XEdY4AvqukinGJExR3wKvE3mzyPG6/yAg1lsimPEHE1Puw7M7m7
         IP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6c5ZkTaOY71A45Zr8zmD1XsOpyurqbzl+JMQ1ZJgy6s=;
        b=6F3nmiP5lA1eNMa3lBMfR76RVLsTeRXBcI1MT0vGzilnDqsyn2yXHBLk/cp0LLpqzi
         vlzm+ekFc46G21V47e1bt5+jDscFG9MnoN9CIZxn2j6QG2s9rBsxPngfVbCFEWb6HXOh
         duYSFnNTe00o/BYStb1adBmg8G9VH0ub+IdUjKlvVPgZISF1VmOAK0gCF0xY0L62PLSK
         MhQ3/YdAdQqpmitoSkLpHsD0UqX09ItpyjBhwOzOyENcduifwqUh5c9XyHSnvOQpZ+ld
         xmm+wHm87IXhcS4CjnIGMA+rUmH2QwvfFZJnyTcY0tizo2vv2O6oVLK+WywlPpwdXQBk
         hcCw==
X-Gm-Message-State: AOAM533bJbzp9A+VhtRrNelibhY1wRyVq2sGRRWk6UDgedg9AXiokGR2
        a1BbHACDQsL/7L6U//Yiw9x/MMMp63g=
X-Google-Smtp-Source: ABdhPJwzl9ObA1WRzakx7YoPtRbJUEKMUlCu/aIvDYzd8ACBSzb94qDgJhtxCBawYkuPQwIKCQNSBQ==
X-Received: by 2002:adf:ea4f:0:b0:1e7:447d:2111 with SMTP id j15-20020adfea4f000000b001e7447d2111mr20749323wrn.66.1645556017913;
        Tue, 22 Feb 2022 10:53:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm36580859wrl.62.2022.02.22.10.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:53:37 -0800 (PST)
Message-Id: <0020953f1cf901e66883853392915ba8ce07ca61.1645556015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:53:33 +0000
Subject: [PATCH v2 2/4] terminal: pop signal handler when terminal is restored
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When disable_bits() changes the terminal attributes it uses
sigchain_push_common() to restore the terminal if a signal is received
before restore_term() is called. However there is no corresponding
call to sigchain_pop_common() when the settings are restored so the
signal handler is left on the sigchain stack. This leaves the stack
unbalanced so code such as

sigchain_push_common(my_handler);
...
read_key_without_echo(...);
...
sigchain_pop_common();

pops the handler pushed by disable_bits() rather than the one it
intended to. Additionally "git add -p" changes the terminal settings
every time it reads a key press so the stack can grow significantly.

In order to fix this save_term() now sets up the signal handler so
restore_term() can unconditionally call sigchain_pop_common(). There
are no callers of save_term() outside of terminal.c as the only
external caller was removed by e3f7e01b50 ("Revert "editor: save and
reset terminal after calling EDITOR"", 2021-11-22). Any future callers
of save_term() should benefit from having the signal handler set up
for them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 17 +++++++++++++----
 compat/terminal.h |  8 ++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index fb8c70a6251..11288cfe5c9 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -11,7 +11,7 @@
 static void restore_term_on_signal(int sig)
 {
 	restore_term();
-	sigchain_pop(sig);
+	/* restore_term calls sigchain_pop_common */
 	raise(sig);
 }
 
@@ -31,14 +31,20 @@ void restore_term(void)
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
 	close(term_fd);
 	term_fd = -1;
+	sigchain_pop_common();
 }
 
 int save_term(int full_duplex)
 {
 	if (term_fd < 0)
 		term_fd = open("/dev/tty", O_RDWR);
+	if (term_fd < 0)
+		return -1;
+	if (tcgetattr(term_fd, &old_term) < 0)
+		return -1;
+	sigchain_push_common(restore_term_on_signal);
 
-	return (term_fd < 0) ? -1 : tcgetattr(term_fd, &old_term);
+	return 0;
 }
 
 static int disable_bits(tcflag_t bits)
@@ -49,12 +55,12 @@ static int disable_bits(tcflag_t bits)
 		goto error;
 
 	t = old_term;
-	sigchain_push_common(restore_term_on_signal);
 
 	t.c_lflag &= ~bits;
 	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
 		return 0;
 
+	sigchain_pop_common();
 error:
 	close(term_fd);
 	term_fd = -1;
@@ -100,6 +106,8 @@ void restore_term(void)
 		return;
 	}
 
+	sigchain_pop_common();
+
 	if (hconin == INVALID_HANDLE_VALUE)
 		return;
 
@@ -134,6 +142,7 @@ int save_term(int full_duplex)
 
 	GetConsoleMode(hconin, &cmode_in);
 	use_stty = 0;
+	sigchain_push_common(restore_term_on_signal);
 	return 0;
 error:
 	CloseHandle(hconin);
@@ -177,10 +186,10 @@ static int disable_bits(DWORD bits)
 	if (save_term(0) < 0)
 		return -1;
 
-	sigchain_push_common(restore_term_on_signal);
 	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
 		CloseHandle(hconin);
 		hconin = INVALID_HANDLE_VALUE;
+		sigchain_pop_common();
 		return -1;
 	}
 
diff --git a/compat/terminal.h b/compat/terminal.h
index e1770c575b2..0fb9fa147c4 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,7 +1,15 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+/*
+ * Save the terminal attributes so they can be restored later by a
+ * call to restore_term(). Note that every successful call to
+ * save_term() must be matched by a call to restore_term() even if the
+ * attributes have not been changed. Returns 0 on success, -1 on
+ * failure.
+ */
 int save_term(int full_duplex);
+/* Restore the terminal attributes that were saved with save_term() */
 void restore_term(void);
 
 char *git_terminal_prompt(const char *prompt, int echo);
-- 
gitgitgadget

