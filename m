Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8351D20248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDAVxl (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:53:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAVxk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:53:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so13972991wrn.6
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZhX4cj40ZpO7KMj+Sz7CPRS9gYvvVy26/o2dgZg2wc=;
        b=jWxf9wYELC2JMFZYrPZEuCWKnzchXhavQTtNXnXnxO/E8tlpZt31K23MKbUJp8GG5Y
         zAKL/jZUwyM+CkcEXGUy9ib8OyefS8RvJENOCcdDzTjTnmM/B3bjW27kfIX55f2uQG4y
         uBBnJjvBmA/PmpwSvtZMDY0/OvHgI9OupX1n11PdDf3AeYJaeSlKI+VB6Nc3e6wKAL9L
         FLCTT3xGRgXOwbV8Wi/6gX/ISYdwjG+Q3x0oPE8H4o3T2bJqDG0EsJIrgwD0eJwADqOj
         YcXSkCThB0ITYvzMjgzyDaWzp3ZAk0i4iuLE0Fk4/hlUdtzdtoiAzEhJCeBx7N/6OH7T
         n18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZhX4cj40ZpO7KMj+Sz7CPRS9gYvvVy26/o2dgZg2wc=;
        b=UH75cKDX5h8vRceiorpgvtC+YFP23x1EAxSn0cd/IDSvky6xVP5MUHTQzlDj6R1eoA
         t7OcS4wT+JdL7LgWcoU2yKEVuvQZNIbfKJcyW/iSRN5+/pZaY/FpdO8j+h9Of6b8Ddg+
         sncFedwueRH19Hf6NguM8WYvV7aUOlG4iAPotTVc9P6LroYI+VPKTYpUcys2LPbRZCfJ
         jAZtLa6FSDtI/M77OBLIgLJBQlbd52pYkevFSDM0zwYRPg2WVEx0bNauks31eJrCk8vg
         EM34+U6xGuSTyTWWbfWglawtNd7UkU6/dFAShh5bXW1CSs2lCJsdi1GVwUeRu9rP/vEs
         qByA==
X-Gm-Message-State: APjAAAUjXf5swAvW/KZ07m0dHWk3YAEGb4PCZU9bYTiZ5bjrqdE8om/3
        YarP4SpPxNNxRLg40/jd/8Y37C+4dNk=
X-Google-Smtp-Source: APXvYqyDR5qS9zoz0uRXhQBklCK1r+c4HBL0VSWhWmyvy0888akMWpsiStETawVyMeeiXruW1Zuecw==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr42278260wro.111.1554155617789;
        Mon, 01 Apr 2019 14:53:37 -0700 (PDT)
Received: from localhost.localdomain ([185.220.70.166])
        by smtp.gmail.com with ESMTPSA id v192sm17082227wme.24.2019.04.01.14.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:53:37 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 2/2] mailinfo: support Unicode scissors
Date:   Mon,  1 Apr 2019 23:53:34 +0200
Message-Id: <20190401215334.18678-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401215334.18678-1-rybak.a.v@gmail.com>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
 <20190401215334.18678-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all for review.  Below is the second version of original patch,
addressing comments by Gábor and Peff.

While preparing v2 I found out that U+2702 was already suggested on the list
eight months before cutting at perforation lines was implemented:
https://public-inbox.org/git/200901181656.37813.markus.heidelberg@web.de/T/#m3856d2e5c5f3e1900210b74bf2be8851b92d2271

---- >8 ----
Subject: [PATCH v2 2/2] mailinfo: support Unicode scissors
Date: Mon, 1 Apr 2019 00:00:00 +0000

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
Note, that Unicode character '✂' is three bytes in UTF-8 encoding and is
spelled out using hexadecimal escape sequence.

1. https://www.unicode.org/versions/Unicode1.0.0/CodeCharts1.pdf
   https://www.unicode.org/Public/reconstructed/1.0.0/UnicodeData.txt
2. https://unicode.org/Public/emoji/1.0/emoji-data.txt

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 mailinfo.c    |  7 +++++++
 t/t4150-am.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index f4aaa89788..804b07cd8a 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -701,6 +701,13 @@ static int is_scissors_line(const char *line)
 			c++;
 			continue;
 		}
+		if (starts_with(c, "\xE2\x9C\x82" /* U-2702 ✂ in UTF-8 */)) {
+			in_perforation = 1;
+			perforation += 3;
+			scissors += 3;
+			c += 2;
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

