Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51E01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 05:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeGaGmT (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 02:42:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43174 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGaGmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 02:42:19 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so11860499ioa.10
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 22:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClgrllaVYUw0KnFXNDWYlgrOqUmbHiZPI1Dn2GETJKI=;
        b=FRtvK0D8Ws1sAh5p3UBeV8vYhYE9mNJyEc9OyKZrqdXTgUb9iTLr+Qv4oJz8EWZoJj
         f8XKmBA7w0Ci3Sw8iZeW78LK7mmMl14zzNApM6JpYhxgUC+g7OoORA4m/O/VVePewffc
         AdGYJr014hZrmJwL+C3GfXk+ToV420HslIEq0n5KJHQo7V6Ern4UpRhR3TZq7TMfzMYC
         o8tLc1oWBMGnninjY7bjwLxOJfZzCbNkcy7Pr9r/oBptmzRaJQq4hpdfk5mJcR/ossWl
         T3TVKn/wlH0RfOBpGuahNtoNtaa8+JriUQe0QA8mwOVuD/gEVVT45SiYet6v0xqLCP6M
         +sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ClgrllaVYUw0KnFXNDWYlgrOqUmbHiZPI1Dn2GETJKI=;
        b=ZgN33kWJFy3UEzbgldvCzZnJjfL7ZzGllzK1MBSqQ66OoYsYTHqxt1bMvjW54q1K80
         Aw6cu7YV08MYf/MWox9vEbYXuANyVLiMGNcFLvQCiW41d7MwWV1Yd22zk8Y1BwBLF8Y9
         GdS19bPN13TpTuRkcMRzw4K3huUFuk7QHQAtre/uv401cBykCqw43ebvVYjkwv8pFdR9
         lbOXNqBfGdirF9aQGCcN5esYaSs3umOl1N4ef762QyLEAxnGLnJ79JNuKwJLsDG3iG80
         WhFeyg5K2S14L3sCZnHXY4j3nKJ1jymdtX+scUvM5tUK7Nhp4zgort7L01t1RW82vZY8
         Wc0Q==
X-Gm-Message-State: AOUpUlGHVoxDBwOzNI+AluNWiJelE08iBtU+7CJT3XHS7LtdEmedwPND
        73t7I2wTXRcc5A2+deY6Y9X3iIbI
X-Google-Smtp-Source: AAOMgpfel8agFmam/l2P4T7xa5dAjlbnGZ8NYJDS12lVlbIR9100PsflGhwHuw7diVgFDf4vDB6F+w==
X-Received: by 2002:a6b:cd8f:: with SMTP id d137-v6mr15606576iog.154.1533013434976;
        Mon, 30 Jul 2018 22:03:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id a79-v6sm844090itc.33.2018.07.30.22.03.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 22:03:54 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t/chainlint.sed: drop extra spaces from regex character class
Date:   Tue, 31 Jul 2018 01:03:20 -0400
Message-Id: <20180731050320.29530-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This character class, like many others in this script, matches
horizontal whitespace consisting of spaces and tabs, however, a few
extra, entirely harmless, spaces somehow slipped into the expression.
Removing them is purely a cosmetic fix.

While at it, re-indent three lines with a single TAB each which were
incorrectly indented with six spaces. Also, a purely cosmetic fix.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Just something I noticed while examining t/chainlint.sed after reading
Jonathan's report[1] of a false-positive.

This is atop 'es/chain-lint-in-subshell' in 'next'.

[1]: https://public-inbox.org/git/20180730181356.GA156463@aiede.svl.corp.google.com/

 t/chainlint.sed | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index a0de8a3882..5f0882cb38 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -71,9 +71,9 @@
 # incomplete line -- slurp up next line
 :squash
 /\\$/ {
-      N
-      s/\\\n//
-      bsquash
+	N
+	s/\\\n//
+	bsquash
 }
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
@@ -199,7 +199,7 @@ s/.*\n//
 # "$(...)" -- command substitution; not closing ")"
 /\$([^)][^)]*)[^)]*$/bcheckchain
 # multi-line "$(...\n...)" -- command substitution; treat as nested subshell
-/\$([ 	     ]*$/bnest
+/\$([ 	]*$/bnest
 # "=(...)" -- Bash array assignment; not closing ")"
 /=(/bcheckchain
 # closing "...) &&"
-- 
2.18.0.597.ga71716f1ad

