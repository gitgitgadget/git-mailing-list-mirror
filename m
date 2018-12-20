Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE8F1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeLTMJa (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36311 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbeLTMJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so808084pgm.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UrNsDcnIoWc9Sp/YoRS6WArLgLR0PZ+gIAfbG3+oA+8=;
        b=Dc33+ijPlPWip8d/4+73GYlGLbiVCJ0jUy5DgeVwFpg2FDPN1mh3w+xLQdnmgUZBhK
         oUJc8GR7iG3wM//Pv2yqcNh5k2PV93cK0KZTv/4ST9k5FTFiOsJonqX0tsBSLmcIZ/nC
         mA269LnBaKWnK+LyAQ2Jv+BZxkucDz+dpsmJ8L4ACscYH6RCoIRfNjdJkPdzqtWBnPGu
         Eko6l8XIt85O50LfAe+pDepFTkIcroqrd6NMCO8jek77kSeeiXn0GayoUXFDzprkru8f
         FT0O0pQOxmMP8LeqCKMejnWrXVmJFuHBx45J18CPPC7CpTzR1gwGlB6KFYFm/q0LdKSK
         +gqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UrNsDcnIoWc9Sp/YoRS6WArLgLR0PZ+gIAfbG3+oA+8=;
        b=nyknUXDbuZmWt0L+Tpa+LDeqFtK9UFFJnT5TcfuM7w9DmwPsb8nSaxgdlM1LcmphmY
         1PU7Y7qZBDeHrScSAs195Akl5NZlhESDpcwIVCzAUVBu9bRY93ihEEA0uY6/WKmdpZrl
         +C4ik0WCaD67CnfJiSQoMIfUQgHxqLrNj8yAL0I+ihGYqKgLZDtb78+4clPa4doxTRj7
         vVga41J6PpAs//26WockggWjo+cSo+KhZk9bemRhQVN+VHKGaYhuxYWr7BjoYdB2iINK
         uQADX1BbiQYKIyJImz0wzZNUKwIhgr0+29gvCDNtGABXjCmf0rHw0pvSe0tq1+ubIDwH
         nm2w==
X-Gm-Message-State: AA+aEWapZZ+Xc3YPhvQR8P+MmaMl9P5rC7vWj86m1Loun55OS6cbLCZY
        KoWHYSieFq0ueS3qjvcguvVb5LKO
X-Google-Smtp-Source: AFSGD/ULr5GcQ0gLpckBH9c2YerF37GUBBoN2MIPxO84z2eoqaQZlkgm7zKeJmIZyHn3Otdqeg3tkA==
X-Received: by 2002:a62:5f07:: with SMTP id t7mr16125368pfb.108.1545307768556;
        Thu, 20 Dec 2018 04:09:28 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id x19sm35961737pfk.14.2018.12.20.04.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:27 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:27 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:14 GMT
Message-Id: <060806010e77ee81c251d88629c16ae001247a70.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/7] add--interactive.perl: use add--helper --show-help for
 help_cmd
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

Change help_cmd sub in git-add--interactive.perl to use
show-help command from builtin add--helper.

Add test to t3701-add-interactive to verify that show-help
outputs expected content. Use GIT_PRETENT_TTY
introduced in earlier commit to be able to test output color
on Windows.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-add--interactive.perl  | 11 +----------
 t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a6536f9cf3..32ee729a58 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1717,16 +1717,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-# TRANSLATORS: please do not translate the command names
-# 'status', 'update', 'revert', etc.
-	print colored $help_color, __ <<'EOF' ;
-status        - show paths with changes
-update        - add working tree state to the staged set of changes
-revert        - revert staged set of changes back to the HEAD version
-patch         - pick hunks and update selectively
-diff          - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes
-EOF
+	system(qw(git add--helper --show-help));
 }
 
 sub process_args {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65dfbc033a..9c9d5bd935 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,29 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-\EOF &&
+
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> 
+	<BOLD;RED>status        - show paths with changes
+	update        - add working tree state to the staged set of changes
+	revert        - revert staged set of changes back to the HEAD version
+	patch         - pick hunks and update selectively
+	diff          - view diff between HEAD and index
+	add untracked - add contents of untracked files to the staged set of changes<RESET>
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> 
+	Bye.
+	EOF
+	test_write_lines h | GIT_TEST_PRETEND_TTY=1 git add -i >actual.colored &&
+	test_decode_color <actual.colored >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
gitgitgadget
