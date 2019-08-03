Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E4C1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 19:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfHCTfE (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 15:35:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38339 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHCTfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 15:35:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so57432414qkk.5
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNrGyzN52d1S5UVMlzueTNOzLrvms13tWE2SXVy8zcc=;
        b=Xw0ZCACgsxQjA4tu7Sh5qruMwh9+T/4peE/dulE4s0o+14YdnCqSV9LyYFqHIscC1Z
         LRapP6EjlRX9TGZ/hyzpPSvpN7NbC9I28XQQD41LDfUsIl88QgdZ1HDjncj2qysldWFp
         uYT3Bk8yJ8z7BeSJTuzPw2rPNzlj8nEc80117XrmuvYK/bh7y3RMIduc15AS1D/icT9Q
         1gPbhA+cUwGHaadwZWE13UxVSQNo6RQEosDgser3ScUCj4/jluWRz1R+UVv1CHG+RM2I
         oONut9MFmcsqmsTfDW+7SBCaprlvP5UxIFv1wtQjNemKlqloo21xZQYtAVHdO33XYCPb
         NcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNrGyzN52d1S5UVMlzueTNOzLrvms13tWE2SXVy8zcc=;
        b=K8AQwETdZyjDQqBnHZPrKRrm69xvE+yRSAx8iL33JjQ90dRb2XQyO4dUSLcrnjjQ0b
         eEn0sEPF4Wiq50arYm8NbtVRk9fAMlKk+iHrKia8G5IJzysjjewdDtQOnXOJq2813VtQ
         sdU0XijrkrzW0M35KmqBXeYBpYyLRpOyhXeQvG71I3x8f/VtRXeF9H6RU5cDcEbv0z1E
         fpMEab38Bcy5xzJKsX0TQxyW1WntVsa1W5un4bv6stKB1VNgpaZxRigvD9tSVcUn7G5v
         1jAFJfGwTISui3z8XXTovIAraMj+NEx1HFlSzKbG49Z9CpMq8v90b79D/hdDuOpgPmSw
         Rutw==
X-Gm-Message-State: APjAAAUEdLwuagK56726Cql9CPTGAmh6yHS0scTHf9vNJZk6b/AaKwxp
        oIcccgKa1vGYOkC9JAuUj4npg7aw
X-Google-Smtp-Source: APXvYqzcLY4XaY+3+w5dCT+Y0JDvxDuQCjkcrBMwlXXDPzksWjBw8vPZcK9j/I+J7RU37esTDr2PKQ==
X-Received: by 2002:ae9:e20c:: with SMTP id c12mr94039891qkc.210.1564860902342;
        Sat, 03 Aug 2019 12:35:02 -0700 (PDT)
Received: from thor.xiphos.ca.xiphos.ca (modemcable114.129-37-24.static.videotron.ca. [24.37.129.114])
        by smtp.gmail.com with ESMTPSA id r36sm42601769qte.71.2019.08.03.12.35.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 12:35:01 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 1/1] commit: add signoff config variable
Date:   Sat,  3 Aug 2019 15:34:36 -0400
Message-Id: <20190803193436.13158-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.21.0.777.g83232e38648b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a configuration variable, based on format.signoff, to automatically
signoff commit messages.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config/commit.txt | 7 +++++++
 builtin/commit.c                | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index 2c95573930be..62aaacb0dc74 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -27,3 +27,10 @@ commit.template::
 commit.verbose::
 	A boolean or int to specify the level of verbose with `git commit`.
 	See linkgit:git-commit[1].
+
+commit.signOff::
+	A boolean value which lets you enable the `-s/--signoff` option of
+	`git commit` by default. *Note:* Adding the Signed-off-by: line to a
+	patch should be a conscious act and means that you certify you have
+	the rights to submit this work under the same open source license.
+	Please see the 'SubmittingPatches' document for further discussion.
diff --git a/builtin/commit.c b/builtin/commit.c
index ae7aaf6dc683..36d70396ace7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1456,6 +1456,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
 		return 0;
 	}
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
-- 
2.21.0.777.g83232e38648b

