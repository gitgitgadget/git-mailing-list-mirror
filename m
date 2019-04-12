Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5A620248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDLMAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46432 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfDLMAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so8070056edd.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qN63TrtHggTAGtg/Fx+ZyXty2CY5YBwtv3fKIy6wnQw=;
        b=bcI1kMu51BfjLb9XxVcuDXq8Ix73tefBzYssw6Hd4jXhfpXpuUCiWQMmr1Gq/YptZs
         C2fIgiCs+a/Lj7yLtz1uyeIwbFjYYZUn8tUIQSN7BVVerJrq1VUswqtGs43s3WOwEePG
         105iGxpE5oR6OlsqUzKNlNYLrjrIaXOSD8jEF/pG7Gk0CirRawDk3ZKPAGR55Tn6NWO/
         htESb2rfUFcKOZAcsulAvjXdJT6cYXM5JadRh+juZhAI+c9ggvgQVL77I1HoYq48XO//
         GoTYXjFozCwhJnnXRHGlPCjmjE2yXZfjhTbSvGcGrrAyruel2rDFOPhNxGbGvtAdVMnv
         NKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qN63TrtHggTAGtg/Fx+ZyXty2CY5YBwtv3fKIy6wnQw=;
        b=elvD6gReplDIfuk67mj+XJYQjADtZmdpTvDguFvpRbnG02LuPKV/lynH/Xa5maLARp
         4vLOWKkVmYY8VvygLIfeTqNhdISGArgbGTAvRlD5R6+IR0QVqta91Ssc8OM4l+3C/yIl
         dQ9dQMSGLW83z9EWNn6V3OBEG2ocEb+WHHGcH4Fl+PXfqRmNFC06vpGuzoFwJ7xo/pDO
         FhhXQF8q+97gxIw2DQoqs6hW6YbFv2rSztkhWzgXZP2cXNhRdwIAxgih7qA7dZgwJSFK
         UJME/GnYHWMqogG38YL4tK9YKj7FENNIDWiJouo31jKr2rCOXY/SfEvJ1sIY84UJalzQ
         m+6A==
X-Gm-Message-State: APjAAAV8kKZipooZ9eu2tQDjwjiLMZefHmkJeSKMYGQ8aD1TU53ygECc
        B/ZC3XIcnRK64jviKazg/gcFkeXX
X-Google-Smtp-Source: APXvYqwGFi2KhoX0TZ/8l2jQ6tjI/lTV4QZ096DUcvpggrly8jYXZ80ywQz9uJuUXtTZsJuGbMrmHA==
X-Received: by 2002:a17:906:d1da:: with SMTP id bs26mr31046081ejb.149.1555070436830;
        Fri, 12 Apr 2019 05:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id op3sm6555497ejb.61.2019.04.12.05.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:36 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:36 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:29 GMT
Message-Id: <2e19f538bcc20393468535561b6857ba3ab252f8.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/7] test-tool: handle the `-C <directory>` option just like
 `git`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for moving `git serve` into `test-tool` (because it
really is only used by the test suite), we teach the `test-tool` the
useful trick to change the working directory before running the test
command, which will avoid introducing subshells in the test code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-tool.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 99db7409b8..2b21943f93 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,5 +1,11 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
+#include "parse-options.h"
+
+static const char * const test_tool_usage[] = {
+	"test-tool [-C <directory>] <command [<arguments>...]]",
+	NULL
+};
 
 struct test_cmd {
 	const char *name;
@@ -73,11 +79,24 @@ static NORETURN void die_usage(void)
 int cmd_main(int argc, const char **argv)
 {
 	int i;
+	const char *working_directory = NULL;
+	struct option options[] = {
+		OPT_STRING('C', NULL, &working_directory, "directory",
+			   "change the working directory"),
+		OPT_END()
+	};
 
 	BUG_exit_code = 99;
+	argc = parse_options(argc, argv, NULL, options, test_tool_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_KEEP_ARGV0);
+
 	if (argc < 2)
 		die_usage();
 
+	if (working_directory && chdir(working_directory) < 0)
+		die("Could not cd to '%s'", working_directory);
+
 	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
-- 
gitgitgadget

