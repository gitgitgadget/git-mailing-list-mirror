Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6698220248
	for <e@80x24.org>; Sun, 31 Mar 2019 22:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfCaWBJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 18:01:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36809 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 18:01:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so9055582wml.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Hv0C7ttE+bvKcei0hD61xLwrqLEytzNFatcCrywb6g=;
        b=cHm9eE2yIHVYKde2AEZVoB2N6d0ttg8GiEHRtO+WbbxnZgGyzzVbNtfdqGA0Yf5pra
         6x1JEVrELEBPhSWwt1wBBnnyTn6dYLfr5rMmk5+Qt1TLK003O9FQIrWRYxGNC71Ek4qs
         PlqqTyC+2WNRql8LJ50RgXLrFqD9ZxdJi2x67e/y6dJJJL1e228IaW2JWMh+00Hor6aH
         fcvGE7E8ih9VGAuOlWGxAC7AiBFD/vInR93dEocHrDJq0IYZi1o4pJpAFC+kDgl0MQyi
         CRK4hMsrsE9xwB3hh2EHCCy1yFT1ngR0FvRvYmdUfxwnMxk7aPUYh/agFWiQsEt75121
         w5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Hv0C7ttE+bvKcei0hD61xLwrqLEytzNFatcCrywb6g=;
        b=dEY90GkKfqc7pkFxv+ZFK4RhGz2ZWOABlVaJxjLVdCOFn0Ywn7pTz/4hhdtWQpG8QY
         leh0U3UJxmPxpI2vq2dUil+NlAp73PEc7uDoF6bAsOxXWIbakJa9kH2qHUslEnWL44ur
         RUeqnpDZDsZY9cbTT+8dDlz5uzik5fYiIr3CHMWfatl1AN5aXzKz0hnNUY+hn+/iHIYC
         pfF2hbcYr8fZy435ffZMVqAa5JNmgW2EbH/lOUYQOuyscdjqiJv6eZXaDdP1PJ2PHlj3
         savVdcJYF7+8ffKhxMM7aDLsiLicwzX+LmTzQP7l3doaGW+4IOlOfyWtd5Oc8ag3UsRr
         xIsA==
X-Gm-Message-State: APjAAAXPYrK4uchLi8+zguIrehwh2dbqxXQWIDmEVwkV2nIQWlBZ6Cbz
        Gm6wnhgcx28x+Fa2q96Vg383PQxe
X-Google-Smtp-Source: APXvYqz/kudn0Ysx7WwpyURjaY1vk3MZ2efHzk/MN69ygdKFRXWD+dQ94bavDME91pCzuyaGCsXD0w==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr10702489wmh.128.1554069666799;
        Sun, 31 Mar 2019 15:01:06 -0700 (PDT)
Received: from localhost.localdomain ([185.220.70.170])
        by smtp.gmail.com with ESMTPSA id f128sm8321532wme.28.2019.03.31.15.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 15:01:05 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH] mailinfo: support Unicode scissors
Date:   Mon,  1 Apr 2019 00:01:04 +0200
Message-Id: <20190331220104.31628-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git am --scissors' allows cutting a patch from an email at a scissors
line.  Such a line should contain perforation, i.e. hyphens, and a
scissors symbol.  Only ASCII graphics scissors '8<' '>8' '%<' '>%' are
recognized by 'git am --scissors' command at the moment.

Unicode character 'BLACK SCISSORS' (U+2702) has been a part of Unicode
since version 1.0.0 [1].  Since then 'BLACK SCISSORS' also became part
of character set Emoji 1.0, published in 2015 [2].  With its adoption as
an emoji, availability of this character on keyboards has increased.

Support UTF-8 encoding of '✂' in function is_scissors_line, for 'git am
--scissors' to be able to cut at Unicode perforation lines in emails.
Note, that Unicode character '✂' is three bytes in UTF-8 encoding.

1. https://www.unicode.org/versions/Unicode1.0.0/CodeCharts1.pdf
   https://www.unicode.org/Public/reconstructed/1.0.0/UnicodeData.txt
2. https://unicode.org/Public/emoji/1.0/emoji-data.txt

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

This applies on top of ar/t4150-remove-cruft merged into next in 
commit a0106a8d5c, which also edited the test setup in t4150.

 mailinfo.c    |  7 +++++++
 t/t4150-am.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..4ef6cdee85 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -701,6 +701,13 @@ static int is_scissors_line(const char *line)
 			c++;
 			continue;
 		}
+		if (!memcmp(c, "✂", 3)) {
+			in_perforation = 1;
+			perforation += 3;
+			scissors += 3;
+			c++;
+			continue;
+		}
 		in_perforation = 0;
 	}
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3f7f750cc8..3ea8e8a2cf 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -77,12 +77,20 @@ test_expect_success 'setup: messages' '
 
 	printf "Subject: " >subject-prefix &&
 
-	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF
+	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
 	This line should not be included in the commit message with --scissors enabled.
 
 	 - - >8 - - remove everything above this line - - >8 - -
 
 	EOF
+
+	cat - subject-prefix msg-without-scissors-line >msg-with-unicode-scissors <<-\EOF
+	Lines above unicode scissors line should not be included in the commit
+	message with --scissors enabled.
+
+	- - - ✂ - - - ✂ - - -
+
+	EOF
 '
 
 test_expect_success setup '
@@ -161,6 +169,12 @@ test_expect_success setup '
 	git format-patch --stdout expected-for-no-scissors^ >patch-with-scissors-line.eml &&
 	git reset --hard HEAD^ &&
 
+	echo file >file &&
+	git add file &&
+	git commit -F msg-with-unicode-scissors &&
+	git format-patch --stdout HEAD^ >patch-with-unicode-scissors.eml &&
+	git reset --hard HEAD^ &&
+
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -421,6 +435,16 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
 	test_cmp_rev expected-for-scissors HEAD
 '
 
+test_expect_success 'am --scissors cuts the message at the unicode scissors line' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	git am --scissors patch-with-unicode-scissors.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code expected-for-scissors &&
+	test_cmp_rev expected-for-scissors HEAD
+'
+
 test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.21.0

