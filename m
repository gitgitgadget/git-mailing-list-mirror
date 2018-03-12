Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C1D1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeCLCUG (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:20:06 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38181 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeCLCUF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 22:20:05 -0400
Received: by mail-qk0-f194.google.com with SMTP id s198so9861266qke.5
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 19:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=NkPbo+icYHlIspwSjnS0fQzRcY3V6osgMq2EX1JhR5I=;
        b=UUEs2hryR0ZaqR7pw8J95F0Y4xOpy5mXnikxAp5QStN5x4EDV+A342IZp+cqjmPdoV
         HT8/EwgeO2acyIpqW/KLJtInWIYHHb9J21xIK4PdkoAaBmzKL/m6UQbDSdBOfip2pRmT
         6MRVpNFsGUh+Xanhbic/QT/O8vafqGa+SMPzWOiwiCh6miSY17TNLeMyd95ny7IHmY/V
         8s/16LO8dIKHeRRHuchomucutX97vN2NcPwmC7MzaCIEJmafGeR/1TgInlOaYPKkhjan
         GvZKwG0NTIiA6ti4X3BruTJhv/WY9TO/Eqh0YNVdiYIiKrOED06Fk1W7HCc5xcLu06dx
         51ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=NkPbo+icYHlIspwSjnS0fQzRcY3V6osgMq2EX1JhR5I=;
        b=L3aTfgOyy0UNUVGlY5Ip0aB9CZgcSDnbmmYeKBIHmFx+u1lOTFfho4g+Es6I9dwfLN
         lOsr+1PjJ59a3cvhXEfITrsc0S/KEA5isIYnwED3KFA8yjuGZtn39NOzjFixoW7k4t21
         duT1ZPzzBAFS3iT1Xn9GOOUQvGJ2Y9FbjFXZXfLMu3Hei+YPPnAdaol0FD+f7DBupSPs
         6HEbtRDxN6mWH3zz9YCQltfHOdy+UlEf1yKxGMqMqb+NiU3MRJVI6tj4woheKU3lkm28
         g/zeHQ1XdlGUe6C3iW/4LvsrWqGCutsxaXdOt0D4mz8L8FkyUZt7zVFq8GlwnqUxbCDK
         poWw==
X-Gm-Message-State: AElRT7HR/nDrHYFD7NWAxWiulM5M2AwZm+z9h47yfgQ0YP14KHq+gsqU
        8VVkJESyyjNgH+sj/9ZD3fxq5Q==
X-Google-Smtp-Source: AG47ELtKPlSCCRfdoDqdTIm9JgV907r9oqLYhslaNeiAMJYKi9UAd3LDF0vffAwr94sFaJ4tyNN+/g==
X-Received: by 10.55.8.147 with SMTP id 141mr4388304qki.228.1520821204781;
        Sun, 11 Mar 2018 19:20:04 -0700 (PDT)
Received: from viet-VPCEA32EG.hsd1.pa.comcast.net ([2601:4a:c102:100d:4cb9:45fc:db31:c0f9])
        by smtp.gmail.com with ESMTPSA id 1sm2036697qtr.85.2018.03.11.19.20.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Mar 2018 19:20:04 -0700 (PDT)
From:   Viet Hung Tran <viethtran1620@gmail.com>
To:     Git List <git@vger.kernel.org>
Subject: [GSoC][PATCH] git-ci: use pylint to analyze the git-p4 code
Date:   Sun, 11 Mar 2018 22:20:03 -0400
Message-Id: <20180312022003.8844-1-viethtran1620@gmail.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da
In-Reply-To: <20180312020812.7883-1-viethtran1620@gmail.com>
References: <20180312020812.7883-1-viethtran1620@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is my submission as a microproject for the Google Summer of code.
I apologize for not setting the [GSoC] in my previous email
at <20180312020855.7950-1-viethtran1620@gmail.com>.
Please ignore it.

Add a new job named Pylint to .travis.yml in order to analyze git-p4 Python code.
Although Travis CI have yet to implement continuous integration for multiple
languages. Python package can be installed using apt packages. From there, pylint can be
installed using pip and used to analyze git-p4.py file.

Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
---
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3b..581d75319 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,16 @@ matrix:
         - docker
       before_install:
       script: ci/run-linux32-docker.sh
+    - env: jobname=Pylint
+      compiler:
+      addons:
+        apt:
+          packages:
+          - python
+      before_install:
+      install: pip install --user pylint
+      script: pylint git-p4.py
+      after_failure:
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
-- 
2.16.2.440.gc6284da

