Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFEC1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfIQJcK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 05:32:10 -0400
Received: from mail-pl1-f225.google.com ([209.85.214.225]:37840 "EHLO
        mail-pl1-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfIQJcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 05:32:09 -0400
Received: by mail-pl1-f225.google.com with SMTP id b10so1274521plr.4
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 02:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:date:subject:mime-version
         :content-transfer-encoding:message-id;
        bh=BTvsTFC6r5RXm1eJSOcaT1gFfHYps2Y4g8TMlDVBU+Y=;
        b=spmFd/kPJQ0rA2Swl9odweZUMJQnyHeYdPoqSZ6FQRZ1/U0pQMLADNRTwwrd2N0Q3F
         g7wEP7Wv7rJIUntMM1JmRGmJfRIkp8MP2cE8gHbvGn2ioTHO1Wo0cWYNbCplYSX1OHe4
         8hKlxYwjAkZuk96fI9s+xQET6jv2CnagBAdBCDnEXArKV9FhOr9OyFzsHDDBmvEjcbyc
         basm+9lgiAt4ZacPCYbAKUBanvsQ23pUCX3YmiBmcOiN6WKmMnN/wtm533bEcz0jbEy8
         NSZILpL767MMhLUH+FxLmxn7Xrycs3350AcV6ZxcIaB4BGCFp0ROLQ2JESeN+hiko4bS
         g/IQ==
X-Gm-Message-State: APjAAAVdBhFzA1LOkc6aUCcKe0pfPnyUk2k8Ry5E219jy21oID6NVWCJ
        cDtclZQQfAgQu6gZPn/67W5IJ3fzYkn/YvjjIT4tiAJqUBgXQnHujX5e0FFbYmh76Q==
X-Google-Smtp-Source: APXvYqw9urRmQ3vqr23Hnyd58z+HybwsTbGVpJhYC71LdO2nXPSbs1Wm2uu3Fk1UvnN4TktKMdN+dQwrdOhv
X-Received: by 2002:a17:902:9695:: with SMTP id n21mr2710658plp.310.1568712727231;
        Tue, 17 Sep 2019 02:32:07 -0700 (PDT)
Received: from daria.daz.cat (daria.daz.cat. [2403:5800:7100:2c00:cccc:ffff:feee:8001])
        by smtp-relay.gmail.com with ESMTPS id a101sm142021pje.2.2019.09.17.02.32.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 02:32:07 -0700 (PDT)
X-Relaying-Domain: azabani.com
Received: from daria.daz.cat (localhost [127.0.0.1])
        by daria.daz.cat (OpenSMTPD) with ESMTP id 2731b0d8
        for <git@vger.kernel.org>;
        Tue, 17 Sep 2019 17:31:59 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=daria.daz.cat; h=from:to
        :date:subject:mime-version:content-type
        :content-transfer-encoding:message-id; s=ADFAF306CC552; bh=zHhvb
        HeLnQi+1kCUePAbrQNBpCs=; b=NsSFfX4rYwiC2+UKQtdmIM0oQsDel5wURUlNg
        haYq9S+FTb6EJc5zhqo2CtJr570fC0H1wtRKFbaGFRuktM/1h9qH34w6/XL6jpF2
        Qp7U0rYgOm7mwaYrVemtMdGnNxpbhCHeY9NfqJVyP87R8CZ52LrHjJk3/yvjCX6B
        fKWU1MLPiSTipMW0UcVDjQqGiM/qHWAQ0eLGLSBvlpZ3DapqAKOWvSwNoDOBUk8N
        8xgNwQWwqYm5A3RmP33unXzuongQ5+apPeUe1DnSUtSNoCPMP6H5qukOv7wQtfw5
        jlEFLp1vT+tLyA/33uOgY3d32SSId9Xs+K2ix1knNdYAEfzVR0TbyjH+P13IH3K1
        a/82rQ0r5TSjxhGyBp9iSyYPBkZ8ya8v/jvKxJnS2okIlGI94/k+AXcQds5op4Gy
        izhuQ876+4hXG5hFTxGeq7EiKLa7jsKKr5CIrV9BqTjOQcZhStiCf5te8Wql2BiI
        /fktd0+hqikuBfNPfDO+j9uGPP9VRZd/8O+kh7uKGIHpFXEdXDZT6VQUN4+mjqbw
        Z+qqn7coXhxKKUY7R5msrx1AwrUMr4fpMn9hR4B4ygRkrN4g7d0zauA/cV7FXScv
        7Fr/1eJ9frHaBo48BIIbN5CQxLRH+T22FV6Nmk5wFsqIUE1LjhbJ1v5A8c1l9g00
        +datk8=
Received: from localhost (daria.daz.cat [local])
        by daria.daz.cat (OpenSMTPD) with ESMTPA id 4c3c93ba
        for <git@vger.kernel.org>;
        Tue, 17 Sep 2019 17:31:59 +0800 (AWST)
From:   Delan Azabani <delan@azabani.com>
To:     git@vger.kernel.org
Date:   Tue, 17 Sep 2019 18:30:00 +1000
Subject: [PATCH] rm: accept -R and --recursive in addition to -r
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <76f0d8e57866db57@daria.daz.cat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX rm(1) accepts both -r and -R, so we accept -R here by analogy
with that and with commands like cp(1) + ls(1) + grep(1), where on
many or all platforms it’s the only way to recurse. For completeness
with GNU coreutils, we also accept --recursive here.

5c387428f10c2 introduces a mechanism that might have been nice to use
here (OPTION_ALIAS), but I didn’t use it because we would need to add
two different long options, and it’s primarily there to fix a problem
that won’t happen anyway unless there are two similar long options.

Signed-off-by: Delan Azabani <delan@azabani.com>
---
 builtin/rm.c  |  3 ++-
 t/t3600-rm.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 19ce95a901..36c4cea256 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -242,7 +242,8 @@ static struct option builtin_rm_options[] = {
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
-	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
+	OPT_BOOL_F('R', NULL,           &recursive,  N_("allow recursive removal"), PARSE_OPT_HIDDEN),
+	OPT_BOOL('r', "recursive",      &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
 	OPT_END(),
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66282a720e..b2ddbba83c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -212,6 +212,26 @@ test_expect_success 'Recursive with -r -f' '
 	test_path_is_missing frotz
 '
 
+test_expect_success 'Recursive with -R' '
+	mkdir -p frotz &&
+	touch frotz/R &&
+	git add frotz &&
+	git commit -m R &&
+	git rm -R frotz &&
+	test_path_is_missing frotz/R &&
+	test_path_is_missing frotz
+'
+
+test_expect_success 'Recursive with --recursive' '
+	mkdir -p frotz &&
+	touch frotz/recursive &&
+	git add frotz &&
+	git commit -m recursive &&
+	git rm --recursive frotz &&
+	test_path_is_missing frotz/recursive &&
+	test_path_is_missing frotz
+'
+
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 	test_must_fail git rm nonexistent
 '
-- 
2.19.2

