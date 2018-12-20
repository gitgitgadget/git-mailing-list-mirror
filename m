Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FFB1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeLTMJa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36976 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbeLTMJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so808682pgb.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DLKeJkCN8+WNCwtGBbmWC9AWjdTo+7Ga3xhlzE87pkM=;
        b=jI8Hiyc1HbPwufHjU0AuWtqA20IMrnA3D39u+JTXmUkzByVOxHQHcQ/Gptsv7pRctz
         sKzx9R95NsXf8jJfmFv6yMPvVg0euPHnc54oIDfw8A2H0uCcqAyU6Cj1sNDP0zdiCKgv
         lajjaiCU807QzngYxPxcjazWH2GTy14bokaghrJNnYK6QpUZhrarclksJ1eNd3i1539g
         LCbuiRnvt/QsONwcFm3/PUQwiZ0fekQdg38of2Uc2yC0KbSnmzs3RIW9ldRcmOpWEUwq
         bpDZ5ZuTMVN8hAkv8vNrHE1aj34+hujsSOVs7i1z0rFCDQWcuI+8dER6TbaieVw3Epfu
         MW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DLKeJkCN8+WNCwtGBbmWC9AWjdTo+7Ga3xhlzE87pkM=;
        b=EQpOrwMiaklJ1SbwERC2yyGDVCiZ44zWuGWf8yaJtG3NoD0x7d15cyl4YqTFOTstMF
         0M2z9i/1WVqGcBg6fqhhGkMyFU98+wnej0gSWbnXufGOfP44q1KQKOwfpsv4sBhDYpI9
         j+dFEnGeV1zxalEwSOSGXCtBd/oz9RIOTmweJpodWa1Cqyqywqv8CsMGj+nnT5wxP1Ny
         AF351iYywhnvE7pYL8uu/N3BwQnIWT3hEnxQIrtbWDlirknODv+LOUIhTtqUbKAI/s80
         RrWPJDU2oOI0KkBzFjzkYrXhYxcnqf6R4YjUiKVK6Q7E+pEX0fQb0iCL2P2xZnzwAY4U
         gmhw==
X-Gm-Message-State: AA+aEWYKRK24QxeNMwQOPApHAc5vIMtSFbcBKUWo6hK21mVHC8Fjfz9+
        abHSrpZ8jZrrbC8p+7rA9BKfeIqx
X-Google-Smtp-Source: AFSGD/U/wHJX24NhmMj/TtQnAGARV/aWhabNTF7Dp9WOW+pNfMXokE/a14PCcP7NAqUqj+nJuwnb8g==
X-Received: by 2002:a63:6782:: with SMTP id b124mr23005005pgc.151.1545307766899;
        Thu, 20 Dec 2018 04:09:26 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id p6sm27316268pfn.53.2018.12.20.04.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:26 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:26 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:13 GMT
Message-Id: <86d85face8ba543fb4a03adbc42dc930ee318f74.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/7] Git.pm: introduce environment variable
 GIT_TEST_PRETEND_TTY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

To enable testing the colored output on Windows, enable TTY
by using environment variable GIT_TEST_PRETEND_TTY.

This is the original idea by Johannes Schindelin.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 color.c     | 4 ++++
 perl/Git.pm | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/color.c b/color.c
index ebb222ec33..4aa6cc3442 100644
--- a/color.c
+++ b/color.c
@@ -323,6 +323,10 @@ static int check_auto_color(int fd)
 {
 	static int color_stderr_is_tty = -1;
 	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
+	
+	if (git_env_bool("GIT_TEST_PRETEND_TTY", 0))
+		return 1;
+
 	if (*is_tty_p < 0)
 		*is_tty_p = isatty(fd);
 	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
diff --git a/perl/Git.pm b/perl/Git.pm
index d856930b2e..51a1ce0617 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -757,7 +757,7 @@ and returns boolean (true for "use color", false for "do not use color").
 
 sub get_colorbool {
 	my ($self, $var) = @_;
-	my $stdout_to_tty = (-t STDOUT) ? "true" : "false";
+	my $stdout_to_tty = $ENV{GIT_TEST_PRETEND_TTY} || (-t STDOUT) ? "true" : "false";
 	my $use_color = $self->command_oneline('config', '--get-colorbool',
 					       $var, $stdout_to_tty);
 	return ($use_color eq 'true');
-- 
gitgitgadget

