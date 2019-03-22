Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C3E202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 16:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfCVQGe (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 12:06:34 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36765 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfCVQGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 12:06:34 -0400
Received: by mail-pg1-f176.google.com with SMTP id r124so1834467pgr.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Aumq8B6++g+9k4Bs0MKU/T3GIVWv9qkt11rBjOpJ6k=;
        b=p3eTzyAcitbFfC8z8NzsOPouNRdayTiWdECNvBAyj0I0YuOGjRAQBs4VhTKOLYMTfl
         31U6QLbQ6ncdgdu6GvHMRjLZjXNCo7Gf0KXY2uy3c/dcPMrq89Z7/4yf/zRPwKUFBA50
         j+BMGg3RnJX6KXGr2YnNe5hx8jQSNaUfjIOz/u0OU+ChZ1jToTKTpIABcXEk4MAs1j4O
         6WVSWWSUqYS7XCFvrGJMHLXmcKxSNgRflnCpiTxNRZhVdjUzvb1TjxWR2oEKimwCzwDk
         13Eqt6pHWEDY64kMPyPnBxKz+y9f+wkNCx/r3PtJnsrpRfFe6fK+O1ZS5Lq/Aek6jl//
         1fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Aumq8B6++g+9k4Bs0MKU/T3GIVWv9qkt11rBjOpJ6k=;
        b=L1Ek9ZXLz62lVbC6LMqQgSkgmG4AghYZWIYPsLVmNq0cficnySzMK7bQayf/vkSP7F
         0E2+lE0jTVtjvPlq2UrJXmg/iExOIoXIjX2Mlv+JdHS38UhzDg8cNEM2rnaujg1V5jPl
         xpUf3728jjuhfXJBQjOKeOz23pnDbjjbN3yljEDqnaCF1zmVN0GC6N1ce0ft+93fTidA
         vRuMFPyVFj+xcGVYDgygtDMJ/gZ3zymM797HUAr1MGMW3KOAvhqqMcBC9wBlmuu+rnxk
         vZxA2F8SlfM1uQZdHx2N9s6KJC+SVyXJPYZ/sEU3uTYfDNImJjrL7+RVJXWKOD0jLh+n
         a9Vw==
X-Gm-Message-State: APjAAAXVg5Chzj9pB6xNPab7uPEjE419aab3LRzOZBWOVe9NceuOOu6R
        oNmmfg0F5ZqEoKo5l0MuiQ+aLK77
X-Google-Smtp-Source: APXvYqzyR48BPqoONTD78er6QTL7l7WkYxJ6ix0cUuZa2ehXSU2MsR+zD8AtzlsRoNneTpWRp0Lk2g==
X-Received: by 2002:a62:1f58:: with SMTP id f85mr9872040pff.39.1553270793328;
        Fri, 22 Mar 2019 09:06:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:2199:7a1:e10e:b74d:d736:35f7])
        by smtp.gmail.com with ESMTPSA id m7sm16451019pgg.62.2019.03.22.09.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 09:06:32 -0700 (PDT)
From:   Kapil Jain <jkapil.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Kapil Jain <jkapil.cs@gmail.com>
Subject: [GSoC][RFC/PATCH] userdiff: added support for diffing shell scripts
Date:   Fri, 22 Mar 2019 21:36:15 +0530
Message-Id: <20190322160615.27124-1-jkapil.cs@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kapil Jain <jkapil.cs@gmail.com>
---

The test written does not pass, imo there's some problem with the regex part.
please let me know about the fault.

 t/t4034-diff-words.sh | 2 ++
 t/t4034/shell/expect  | 6 ++++++
 t/t4034/shell/post    | 1 +
 t/t4034/shell/pre     | 1 +
 userdiff.c            | 7 +++++++
 5 files changed, 17 insertions(+)
 create mode 100644 t/t4034/shell/expect
 create mode 100644 t/t4034/shell/post
 create mode 100644 t/t4034/shell/pre

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 912df91226..74366e6826 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -314,6 +314,8 @@ test_language_driver php
 test_language_driver python
 test_language_driver ruby
 test_language_driver tex
+test_language_driver shell
+
 
 test_expect_success 'word-diff with diff.sbe' '
 	cat >expect <<-\EOF &&
diff --git a/t/t4034/shell/expect b/t/t4034/shell/expect
new file mode 100644
index 0000000000..f2f65e7a9b
--- /dev/null
+++ b/t/t4034/shell/expect
@@ -0,0 +1,6 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 2fc00ad..cd34305 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1 +1 @@<RESET>
+<RED>[-$TEST_DIRECTORY-]<RESET><GREEN>{+$TEST_DIR+}<RESET>
diff --git a/t/t4034/shell/post b/t/t4034/shell/post
new file mode 100644
index 0000000000..43a84e0188
--- /dev/null
+++ b/t/t4034/shell/post
@@ -0,0 +1 @@
+$TEST_DIR
diff --git a/t/t4034/shell/pre b/t/t4034/shell/pre
new file mode 100644
index 0000000000..32440f90b7
--- /dev/null
+++ b/t/t4034/shell/pre
@@ -0,0 +1 @@
+$TEST_DIRECTORY
diff --git a/userdiff.c b/userdiff.c
index 3a78fbf504..936447a0bc 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -158,6 +158,13 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+
+PATTERNS("shell",
+  /* Function Names */
+  "([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\([[:space:]]*\\)[[:space:]]*\\{",
+  /* Words */
+  "([$#@A-Za-z_\"\'][$#@A-Za-z0-9_\"\']*)"),
+
 IPATTERN("css",
 	 "![:;][[:space:]]*$\n"
 	 "^[_a-z0-9].*$",
-- 
2.14.2

