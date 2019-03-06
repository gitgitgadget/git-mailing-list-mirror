Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E84F202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfCFGbf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:31:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41374 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfCFGai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25so9818096ljk.8
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 22:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1u2C3HiAov1ZtE9L5OPD4t+SE1CMKObYrhXhj2/ZuBk=;
        b=Dd6IjEqjBCB4Joqaktzl6TKYIINFdXJi994MVUbpvXEBJ5wtW5fi0Qj02s2ml7SB1h
         gl+AUQ1MrfDspXO1glXXwbGcig2fwEoiZwt5YEkcsx1A++UDBdMtDbBpxdqNLcHjrqqk
         zfSphWao9vkc86p55LBVlFJfk7y4Ej4JZBYjm0MYFFrgyVm96XLYDOxExs15H9a+0GMx
         wsUGY/eBHiy7HEWMkBurPiITr0kvvhK+ZfZ/VvK8ZJQBAUgQRPWla6KcvVMQ+pBp1o9o
         nXD1ZCmHQRHvtE2p45Cx/F1g6bVtFtj38h5mQwqbWPKDMxb39HFNrPz+rHnqvTZmJnOF
         pX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1u2C3HiAov1ZtE9L5OPD4t+SE1CMKObYrhXhj2/ZuBk=;
        b=ddpmQr9Lsd8dmEeoWFnt8W+D1IjSiGj9AakyuNS634Ni8CF5/yHfeiibwhrAskNxTd
         4p92dgSx5Vguh1JI8Y3FDAblHAlC0YrT/BQgBEIXuo9hZcTin9kDLvZeLwK7NVxZz3Hq
         g9g1BregU0Rx9zkHwE33Tno+U5sJaqk9AQNSYd3/lmYg2JlZB97i7qqY58oXdzyfWe50
         VzUWQaNC28B00OqNaB3HrOq1DZxQAAYfMrmRNoK5YGF2jL2pgffMRkdVtRucaPdu/5Iq
         +o4XYEML+h3bQObLj26j5EZUvBlt++DX4xPAMmVcW3qdzHiQr9c6Ui8+2zClXRoUPICz
         46XA==
X-Gm-Message-State: APjAAAVcnGE2umL06QudxmNZ1T085zLWNP9v6XAi+0XDlhdCWPluqnU6
        A8FDk8BdlcYmi88q7HpqScJCeaso
X-Google-Smtp-Source: APXvYqy83pvDkPr2VV9SG1XOF1kktFo2Q07njxgdYpZkXRCsEuOGF06jnm0VFS0vEA0iIQ4eHskPaA==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr1469028ljg.146.1551853835543;
        Tue, 05 Mar 2019 22:30:35 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u29sm149715ljd.84.2019.03.05.22.30.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:30:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] config/diff.txt: drop spurious backtick
Date:   Wed,  6 Mar 2019 07:30:14 +0100
Message-Id: <d72eb8a53daa9e24b6f0b815827aa7d3018a2f4d.1551853194.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551853194.git.martin.agren@gmail.com>
References: <cover.1551853194.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config/diff.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index e48bb987d7..7a1bae116a 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -10,7 +10,7 @@ diff.autoRefreshIndex::
 
 diff.dirstat::
 	A comma separated list of `--dirstat` parameters specifying the
-	default behavior of the `--dirstat` option to linkgit:git-diff[1]`
+	default behavior of the `--dirstat` option to linkgit:git-diff[1]
 	and friends. The defaults can be overridden on the command line
 	(using `--dirstat=<param1,param2,...>`). The fallback defaults
 	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
-- 
2.21.0

