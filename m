Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2541120248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfCVJdR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53385 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfCVJdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so1418593wmj.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rgI6yxKGMPqEI7PNifLp7tOQA/X7/mI8l/sGLVPHjs=;
        b=LMbNbRPA9ByQQpmb1EFuQoMNxco2GBDTgovR1SjeUBEXvu9C2Agfy9uwY0oDCD7Fwu
         Cbdh6zLAwrqM1NlIDJSm35/0yj4xxRtbisFWHL2KOrYZXCG9NVtgYue23cyUs+hU/2Vs
         LtN1IhczQaoav1l28+J6/YoGYUut7I9Iv3dxdLcAzMEMiaEYOZSgu9TRwGhxQVNutevc
         laBYO3HpshiS4/9po5gZ25kvDEoSWSwK7j17+0AvUe2ughF5ykmoW/HmMXYa4Dn0IVJd
         KHwO/W2iRsdutflHXawIaHaIR/gWv1Q6wtlh8OqS9FcZ/BZdY8DzEBhn164Dw/uK4g7E
         yQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rgI6yxKGMPqEI7PNifLp7tOQA/X7/mI8l/sGLVPHjs=;
        b=rx0TZkL5kzyFSkbsrLTGGizG3G1O7TZRWJwIWfFlVgNLKhVgGsL/zgQEEyZIzd5+R8
         B0pemTcvMmFQSVzFbLnLogrtufcEhl8Gib8mjXXXYLSf5Hb4oT9adriWTqLrunTHe9Hy
         nzz1San7SxKePD1yF0D/Agd38KlxSqSwMa7tBZzgDeac9AlnbIcNPvt2bmr8DJJiYXIB
         KMHhuMKlH5LwaCfJY1buYy0CCfLy7Mwxx5KfnCflV2o5C9KdPQ6XS9PRLxIunIbgPmIJ
         qmKK6MU6kHyl1DL0qJlbAKz8nFxByKPIqgKzmI279o5FfnRvi8O4B/8W9TBXsFrFuwQX
         GgIQ==
X-Gm-Message-State: APjAAAVeY0uTtqqsFwn1uyiawd7k/o6TC6LzXYJPpLLAjfXJGX/SD9e1
        SSpmU91jkz5tkjdFaNyBJwx/BOMcCKI=
X-Google-Smtp-Source: APXvYqzmwG6j74yfwCClb4fF4ttykh6MHrqif52M37BO7jEzpWkFC0eV4v+N5Z2/dJgQUaAgiE2WFA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr2422279wma.35.1553247193698;
        Fri, 22 Mar 2019 02:33:13 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/11] gc docs: remove incorrect reference to gc.auto=0
Date:   Fri, 22 Mar 2019 10:32:42 +0100
Message-Id: <20190322093242.5508-12-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The chance of a repository being corrupted due to a "gc" has nothing
to do with whether or not that "gc" was invoked via "gc --auto", but
whether there's other concurrent operations happening.

This is already noted earlier in the paragraph, so there's no reason
to suggest this here. The user can infer from the rest of the
documentation that "gc" will run automatically unless gc.auto=0 is
set, and we shouldn't confuse the issue by implying that "gc --auto"
is somehow more prone to produce corruption than a normal "gc".

Well, it is in the sense that a blocking "gc" would stop you from
doing anything else in *that* particular terminal window, but users
are likely to have another window, or to be worried about how
concurrent "gc" on a server might cause corruption.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 49aec5435b..2af503bdb1 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -141,8 +141,7 @@ mitigate this problem:
 
 However, these features fall short of a complete solution, so users who
 run commands concurrently have to live with some risk of corruption (which
-seems to be low in practice) unless they turn off automatic garbage
-collection with 'git config gc.auto 0'.
+seems to be low in practice).
 
 HOOKS
 -----
-- 
2.21.0.360.g471c308f928

