Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850391F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbfJNUrF (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:47:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35557 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfJNUrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:47:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so8513742plo.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z76E7X52AQXx+/EuqnvQYe44BKFe0tLNUdXqX5tBhLk=;
        b=Dwd9igEtPfzOsWBEP3K3txzRYAH13kwMGTQAl+QOl1sI7O7gTf8vjNloq0dgSC90F2
         fzjqazaiP/lBLOf1jua9sXIK/UIxVfmmJwqrWvMLTjtUvkuDohhBVhorBwijpHu5JOEN
         vYIqdNF5uqwLI1SzNmt1Tw4beKS6nk1yeiStjrOvj51zbEZlBhi4+Y7jfP1lt7K0sHfK
         /IHMMltEeWUFS09CWeu+6dxdWOBTBENBbVcHBTHu6EdA/UTvdZOq3E9RmLx0yhYK83o9
         da95mvPeqGg1d5CFdjG+Y7JdeTOFDKL2cUmgZy2j6+cfpUHENmnaCqbN8kANFKc2ZjLy
         Z7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z76E7X52AQXx+/EuqnvQYe44BKFe0tLNUdXqX5tBhLk=;
        b=aWK/kqlYxh2IQKq7crYbx63QH2u3dQLhVaXdkflgdKs00sY6HQKDoTzCxRE/0H7Xfa
         qXnG3PGFX2fQDFsNEaSk08X+1npKg3M17I6HGeOhMQ64oTXOfr9rmyLWpjG1tM0gWc0J
         pOSM42hYu6pD6V4y7RfQDd1YNBSY/VPZMirFo4fLIzUkfn0EXc6P1ITWVsAWEoo7y5hs
         pG3ALUkCaiP880Zr06jxnsPfUcXEqufzFs6h26XXlZSdA18GKje+p2Si+72X9sqVNZUC
         ZtmGD5Yppfjad9fKx0BlIP7virJCpzNubUREQz1CPv+yu/1AkwmvranXnM2I6YyZko2O
         gtvw==
X-Gm-Message-State: APjAAAUKXwV2pTZqxwclsBXm5hs5jw/UT90i0QaZVDSdaDC074o2vJTQ
        wbHG4bYMu5ktgw1vOamOUwPPwyxQ
X-Google-Smtp-Source: APXvYqwK4N19lY15zbuZL2Ngdn7rxbU1dbzDAtfQzQEOBR6yPStrV116ESYpukW9MaZfhE/Ot+dFSA==
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr15653149pls.215.1571086024109;
        Mon, 14 Oct 2019 13:47:04 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id b3sm15360249pjp.13.2019.10.14.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:47:03 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:47:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 2/3] format-patch: use enum variables
Message-ID: <e2769092fad4a6fa8830a54ffa5afe782e5fb1bf.1571085952.git.liu.denton@gmail.com>
References: <cover.1570821015.git.liu.denton@gmail.com>
 <cover.1571085952.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571085952.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, `thread` and `config_cover_letter` were defined as ints even
though they behaved as enums. Define actual enums and change these
variables to use these new definitions.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Hi Junio, I double-checked and made sure that there is no arithmetic
done on the new enums.

 builtin/log.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 351f4ffcfd..d212a8305d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -764,24 +764,28 @@ static void add_header(const char *value)
 	item->string[len] = '\0';
 }
 
-#define THREAD_SHALLOW 1
-#define THREAD_DEEP 2
-static int thread;
+enum cover_setting {
+	COVER_UNSET,
+	COVER_OFF,
+	COVER_ON,
+	COVER_AUTO
+};
+
+enum thread_level {
+	THREAD_UNSET,
+	THREAD_SHALLOW,
+	THREAD_DEEP
+};
+
+static enum thread_level thread;
 static int do_signoff;
 static int base_auto;
 static char *from;
 static const char *signature = git_version_string;
 static const char *signature_file;
-static int config_cover_letter;
+static enum cover_setting config_cover_letter;
 static const char *config_output_directory;
 
-enum {
-	COVER_UNSET,
-	COVER_OFF,
-	COVER_ON,
-	COVER_AUTO
-};
-
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	struct rev_info *rev = cb;
@@ -1248,9 +1252,9 @@ static int output_directory_callback(const struct option *opt, const char *arg,
 
 static int thread_callback(const struct option *opt, const char *arg, int unset)
 {
-	int *thread = (int *)opt->value;
+	enum thread_level *thread = (enum thread_level *)opt->value;
 	if (unset)
-		*thread = 0;
+		*thread = THREAD_UNSET;
 	else if (!arg || !strcmp(arg, "shallow"))
 		*thread = THREAD_SHALLOW;
 	else if (!strcmp(arg, "deep"))
-- 
2.23.0.17.g315c308950

