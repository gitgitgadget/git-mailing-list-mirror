Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE591F4B9
	for <e@80x24.org>; Fri,  6 Sep 2019 12:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391824AbfIFMNd (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 08:13:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36983 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfIFMNd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 08:13:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so6849856wme.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o05IhCKSBid0C4HYnqqE9+HEemdo/T8LBL11ecee520=;
        b=ZpchtlxLyDO3jUJ0h1/KBQBMJHqdRcTG8Ag8Tu2ZlIixuoT91ZJ0yNXspmF2/eij4L
         rYds5RtK4mphOB0g6crDab82XgfXrJ5wV7E6gL+CQQQaMK9F2Q36Y/LPOJh2JXA7h4FX
         ns+YKmhZrW0GG4QtBajqVt+xFSDGwG30s34/JIio2LSANxVoNLBSzxb1rt96awpiRho/
         b7MNZppCQuQwOwh5aXrUHCNC/0W2MA/ofiKy03FfUGZh3jBWuij24RrHiDXYswMisdiq
         Lug6UlRC5axxCHhT6DNRIaoFsJixrNTtB0Tum0t23UscZX6b+/zcgPgxF+rSMOjXtaAq
         5nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o05IhCKSBid0C4HYnqqE9+HEemdo/T8LBL11ecee520=;
        b=KGblzZz3gxnrCa9lCGMeuHty9OdoOOR5IYrU5gogeKvx9k7tz3kxPP0SEbhp0RKxv1
         pr6zsFD0ml38bjXxrExPsyKpIp5Q5U08r64sPloL1k/dHVjpvqiDlGzNMACeFwuSoct1
         wZEG/SNO9BqHyxbwpU4cmguSdFmhRQ5bE9BYVMT3Jf5aRDU5l26rf2kWqzaAFzHimdJ7
         LlYQyBhjqzVGc/wiKogiuBARASXKeDHZIwivQNwNRSBmcjrPRbOBzte5PDMX6FMuDiMW
         7Upq3sypjvH/OSJ3poQSKLUW872IXqAmRGyGSpNj9lLyGCNSJm5b/Jvggoc+63ElIU/L
         4zsw==
X-Gm-Message-State: APjAAAXRJQO2rbsW5QlCZIMa+3pCcvaFhrmN+YtR/Be3aUGCbQ/5v5bF
        xn7E534GWRPW3DjbuEWsNBs=
X-Google-Smtp-Source: APXvYqzWrlarrFuMHPQA9IrLHw6rcMEyQLt1NKSAvaGBb9dHYFFQT6wEeIVTWcwDGmi4xn5Mi7sGNw==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr7670128wmk.161.1567772011195;
        Fri, 06 Sep 2019 05:13:31 -0700 (PDT)
Received: from localhost.localdomain (x4db936a8.dyn.telefonica.de. [77.185.54.168])
        by smtp.gmail.com with ESMTPSA id e15sm4416826wru.93.2019.09.06.05.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 05:13:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] t/lib-git-svn.sh: check GIT_TEST_SVN_HTTPD when running SVN HTTP tests
Date:   Fri,  6 Sep 2019 14:13:25 +0200
Message-Id: <20190906121326.23056-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190621101812.27300-8-avarab@gmail.com>
References: <20190621101812.27300-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time the GIT_SVN_TEST_HTTPD environment variable needed to
be set to enable SVN HTTP tests [1].

Then 3b072c577b (tests: replace test_tristate with "git env--helper",
2019-06-21) came along, and attempted to turn GIT_SVN_TEST_HTTPD into
a bool, but while doing so it mistyped the variable name, and started
to check GIT_TEST_HTTPD instead.  Consequently, if someone explicitly
set GIT_TEST_HTTPD to true and has only the general 'git-svn'
dependencies installed but not the Subversion server modules for
Apache (libapache2-mod-svn), then a couple of 'git-svn' tests fail,
because they can't start httpd due to the missing module.

We could simply fix this by checking the GIT_SVN_TEST_HTTPD
variablewith 'git env--helper', but notice that the name of this
variable doesn't conform to our usual GIT_TEST_* convention.

So let's check the GIT_TEST_SVN_HTTPD instead.

[1] a8a5d25118 (git svn: migrate tests to use lib-httpd, 2016-07-23)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-svn.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 5d4ae629e1..bc0b9c71f8 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -69,7 +69,7 @@ svn_cmd () {
 maybe_start_httpd () {
 	loc=${1-svn}
 
-	if git env--helper --type=bool --default=false --exit-code GIT_TEST_HTTPD
+	if git env--helper --type=bool --default=false --exit-code GIT_TEST_SVN_HTTPD
 	then
 		. "$TEST_DIRECTORY"/lib-httpd.sh
 		LIB_HTTPD_SVN="$loc"
-- 
2.23.0.331.g4e51dcdf11

