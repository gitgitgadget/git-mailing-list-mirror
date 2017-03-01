Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77AA41F5FB
	for <e@80x24.org>; Wed,  1 Mar 2017 11:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdCAL1T (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 06:27:19 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34480 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdCAL1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 06:27:17 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so5573112pgb.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 03:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSwXFd9OWK+Ilz1WM9eLWx5Ojei8uURDfKQAW8QeGus=;
        b=ds8MWEdBnQqyx1reJ0cYI02NQN7NMcL2FRWj96i6GGLzMW3DElOFKlgIP6CkBtPyma
         Qy/PNFvkJVf7eR6BqC5073W3fTtF4lVnVUM6HdZklB+culfr3dtx3dsaTCsOd9HRB4hL
         LQ7iSJhV3ZdVPRH+gSWwOWo1vbrBmyusiOOJf0vklFPy/HzKt7Ylzcfdfx8tkRHnsXeF
         SIHlI+H9H/uHgq6V+CEhtwTsuCme2rfmf0koFgFIQqqzSOWzV0eN80RvqxFs51k9Mv1l
         UOqMFe7DWUBEOrihXl7J02XvMxGrXZd5xOyEJfFqeH9cngU2hFiF+6P2VZEhGScutSQ0
         1brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSwXFd9OWK+Ilz1WM9eLWx5Ojei8uURDfKQAW8QeGus=;
        b=EIFWNIGGu+dy33HfbTwfCjIRJ5Kj4wV57ALFzsPWjV25vGNCKWVGMQbK8w2cn+MxlI
         bUQaEOn3UKMV+RbRXh2ek/5yOLPw+mcFMIOT76JhpMDL4NsH1oauTjax7VMHVu8IbHfx
         Afird7uIMClv5KnS/VU5yRSA/2HchFiejGbsFATSEx5nGZf5fG1X4b3rpTm2TWqjtsKZ
         uyzndJZuXmo2OIVrqaeryBmnYWARy22UPYwUeQzepVhHbY8rf0j/acEPX/3CBkm6JrLn
         6IYcYOU+yygCkqeoEvRVkFzCxkPdcLfEuEWWnM8Zl54EFXEXm7Suv1ivta2cdqdMVPwY
         GT9w==
X-Gm-Message-State: AMke39kNh2kRXH/zxPIv3UkhCbAJB+HoPYcdd6nkbq1ndoXkDP0Qh0EpGTwPhMUel9kSuA==
X-Received: by 10.98.71.7 with SMTP id u7mr8319560pfa.76.1488367616712;
        Wed, 01 Mar 2017 03:26:56 -0800 (PST)
Received: from ash ([115.73.169.226])
        by smtp.gmail.com with ESMTPSA id q90sm10008728pfk.73.2017.03.01.03.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 03:26:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 01 Mar 2017 18:26:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 2/3] config.txt: reflow the second include.path paragraph
Date:   Wed,  1 Mar 2017 18:26:30 +0700
Message-Id: <20170301112631.16497-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170301112631.16497-1-pclouds@gmail.com>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4748efbf36..1fad746efd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -84,12 +84,11 @@ You can include a config file from another by setting the special
 variable takes a pathname as its value, and is subject to tilde
 expansion. `include.path` supports multiple key values.
 
-The
-included file is expanded immediately, as if its contents had been
+The included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
-`include.path` variable is a relative path, the path is considered to be
-relative to the configuration file in which the include directive was
-found.  See below for examples.
+`include.path` variable is a relative path, the path is considered to
+be relative to the configuration file in which the include directive
+was found.  See below for examples.
 
 
 Example
-- 
2.11.0.157.gd943d85

