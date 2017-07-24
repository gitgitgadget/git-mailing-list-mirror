Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D27203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbdGXUgC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:36:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33800 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdGXUgB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:36:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id v190so12659978pgv.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=X/4EY5U+2f3Dmk+zZ9oIzd4VAxmxJlKZ99CTcjlEbBas62MCHm8TSwzALkocIpZe7R
         mYyo+tXwim05HAKuVNXaEMIj/YxJdy9IL5Oa2pE5v5rT0zkX3VZr+qiAM2zPC8pNodi7
         DKVEiKti2M9fJtd/PupVlCQRVgSomiwDs0QP+4FDG5epNyNDNPHwK/unIWfAEsujD3Z5
         k4EJfYg2X1Id06Gcpb+r7PhqOkBEefJbtigW2ILh4K5YLa/C0sIgqsBDt89INNdKbZmP
         k1LFZdBb5Jy1F2lJRqCAaUL4ZKnqJeb24EZrHNdQWDCeIc6IUifyHRptmEzq/mWJrggL
         TF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=p9LcgCAedCNDV8WWUFJ4onWbwlIvO2ju13612MP2JHLNr2NbCj+zRBPsCoEUVxE8mH
         hJimX7x9elwuP0gK3Gf3qrPKnBIwLHvO2BCyyYINZZ3PEehKOMvg7GFi+948tCVNQrMZ
         4dxPcZctuOsY4IYac4FXZGytzzGoeMDbAVvLp2T0PrCHTcplNaXBTK/imDat37PYHpXH
         vCaQjbyzX7IfOJGahKu/y10GiHACgX6HsZ7OludeDXhogqBMhpgQltBZwJgtzpj4NUiV
         J6B8e66BSyxMG0e23j/rezMvZvO9acju0cnqEKSoANpmgRnu5eoUN/EsiBm3HwN5xeVn
         s3Zw==
X-Gm-Message-State: AIVw11300uO/7/FeUZJZ9Ka4opE0nYGh76fbcqlxV6tyXCLlOJwUDbef
        C9wQzXk9Bo8xtllQ/cY=
X-Received: by 10.84.194.228 with SMTP id h91mr18917696pld.46.1500928560355;
        Mon, 24 Jul 2017 13:36:00 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:59 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 11/13] submodule foreach: clarify the '$toplevel' variable documentation
Date:   Tue, 25 Jul 2017 02:04:52 +0530
Message-Id: <20170724203454.13947-12-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not contain the topmost superproject as the author assumed,
but the direct superproject, such that $toplevel/$sm_path is the
actual absolute path of the submodule.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a23baef62..8e7930ebc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,7 +188,8 @@ foreach [--recursive] <command>::
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
 	$sha1 is the commit as recorded in the superproject, and
-	$toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to its superproject, such that
+	$toplevel/$sm_path is the absolute path of the submodule.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
 	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
-- 
2.13.0

