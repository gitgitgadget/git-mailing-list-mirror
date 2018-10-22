Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0691F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeJWEnb (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41019 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEnb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so39212408edd.8
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLV53ZJf7uA43yB6DIG8Qt6G8DsPOzNy3uqbadk3Efc=;
        b=O7KcWvECGperumr2JAo5GWbidJ1kJ6KdosUkwYi6Dhmwmv4e4L7dy4F3GJ8xYOwAGN
         AMm0uGdL1C6dD3yeOYu/T98IS7WIGHr6WvNhTh2wBMhgOtyEQro4Zpn1wpPWtXleqWB7
         oF5usooexHe6xSJyaUJ8CfAU/WzEJOaRdHtujkUzjhTkiLb3aVW5qmfuo7kwMzs0MNqF
         u1bAWzQYKwubqGwunlL+m9E7VpHjAjBVoPlF5iU5tbVIcT0/QlCw/NTfdg47PO3Flw/i
         UxMJQCeoKe4LrGksQ3JtFCwBJpJEHm5Wu4icPmZ+T+MHhRhX7+P/99If2E2++aTXpiM5
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLV53ZJf7uA43yB6DIG8Qt6G8DsPOzNy3uqbadk3Efc=;
        b=ay7dbFgGJ4HGzZy0IHQxzgsDhj/+KMMwQ4SfEtrUM3w6ZSOHIOFMKxiihkQBXWxjSQ
         sDGdWi9vTLULJQhq1gPM5hv70uUEmrCzHEcBE07smHckQsEdGNiYO07YQHpDDF/37ld9
         swFbhUn9JUGgJ8o/iQPhfY+p+OW3BVSC5n9VD0Ms2zEIRAeiWfchEPFloUG4cf1RiLWS
         4m8L1uptjir5+VMQUi1Ud/dQjOiRPStPFtrY4VLjz0G/MZe0pAC5FSNgpPUPHPL4TnXP
         4WvgrDrPbLd0bC/8/3RgfSFg/LAIYFE+jx2R7MLBes/OTeBrQ+6+70VTLmXr78JPKU9C
         Y4QA==
X-Gm-Message-State: ABuFfogNMY4h7I7abs0Iqw7GEQvZ/yAh4qnSaqbkvzI6rgTQtfYAv+4w
        OlF2zNq22WW9RLoOWguJzjChtEtH
X-Google-Smtp-Source: ACcGV62qX+3jXcnFm7K/y8m1KWQ7rPjHLdetKrUTmQIpJ6be9CRCEXaXXF2g69wfXhqGL0jL1XfFDw==
X-Received: by 2002:a17:906:344b:: with SMTP id d11-v6mr37237774ejb.130.1540239810076;
        Mon, 22 Oct 2018 13:23:30 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/8] gettext: don't poison if GIT_GETTEXT_POISON is set but empty
Date:   Mon, 22 Oct 2018 22:22:35 +0200
Message-Id: <20181022202241.18629-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to run test with non-GETTEXT POISON-ed behavior even in
a GETTEXT POISON build by running:

  GIT_GETTEXT_POISON= ./t1234-foo.sh

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile  | 2 +-
 gettext.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ad880d1fc5..7a165445cd 100644
--- a/Makefile
+++ b/Makefile
@@ -365,7 +365,7 @@ all::
 # Define GETTEXT_POISON if you are debugging the choice of strings marked
 # for translation.  In a GETTEXT_POISON build, you can turn all strings marked
 # for translation into gibberish by setting the GIT_GETTEXT_POISON variable
-# (to any value) in your environment.
+# to a non-empty value in your environment.
 #
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
diff --git a/gettext.c b/gettext.c
index 7272771c8e..a9509a5df3 100644
--- a/gettext.c
+++ b/gettext.c
@@ -50,8 +50,13 @@ const char *get_preferred_languages(void)
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
-	if (poison_requested == -1)
-		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+	if (poison_requested == -1) {
+		const char *v = getenv("GIT_GETTEXT_POISON");
+		if (v && *v)
+			poison_requested = 1;
+		else
+			poison_requested = 0;
+	}
 	return poison_requested;
 }
 #endif
-- 
2.19.1.681.g6bd79da3f5

