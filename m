Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6571F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758850AbeD0RFj (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43091 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758824AbeD0RFh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id v15-v6so2423746wrm.10
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jOsmGRkGdCTKSE5GHSNgUvBG7EoaXkBa9gXnyhGpfqw=;
        b=kOfE5SEyiXD8+J8zGQOmsjMVxuhmMkfzKdrJgAlK3VWTJvqHOUxKcLMSkHUmZn1tB5
         CbnhxpRhStYVL+bLQcQehQnxHso9F6x8JWrqvUaaXJrjXyW/8qGZaW2rNrNhmo5aE3uC
         7acN6oz3Hfr9pHaZ/VSX23/DsUOdcB1li8YkjTe1G8t4y7TArT6yWx5olFED7xFJSV+c
         dT64U4kx8sW2Y2dm1O7mYChZbR0VgajxOEdWWOWSuMH8PAfxCsapri9lrrUq5Ozi1O5D
         2VyoBmXbCesO3UNpVfN/VX6di+HhwHBSE9Kbcdek5mIX/GgYRQAwx8rOEn6U1K1tOSKf
         s78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jOsmGRkGdCTKSE5GHSNgUvBG7EoaXkBa9gXnyhGpfqw=;
        b=Oy1tS66y5ff+FMbaly4aScd/FDhd21F8YIPZys+YxpeCRGOh8awBIgg4jM2QJg0XoD
         bMx+/U8HS4faARjC52nEYu74+hw4601IY73m5YhGbE7EeKvcf6TvpWyz+CqBmIBYwnCE
         3QQ4Bym3NKOzl2hEyjS5AQHLvtfihoaezYXFAs2ZUvFbp5bRPYlGnSM77DzwGvTPXSya
         nnS0gvoe280xR5J0p5sx+HLcPcrrlQF9lr6Yf0A9WFOKJ91rQVqAWpYMugvF2ayPAwPJ
         JfRaFFGYO90wo6qaJ1C54Hkm1FCJj2QoFLEQrxPB4NJW+UgyR7LWV07+LcakZNXtyrhI
         Zi3Q==
X-Gm-Message-State: ALQs6tCQcAkhvbhhOSxGJ3CTA7Dj+k7DMQ8wbZBlejEpfdaI3WqNtxqw
        Itv2uyktqjOQD2XV1Evq9c5txf6S
X-Google-Smtp-Source: AB8JxZqxu5p02lsuO+Gh1oOguJGMiIG6QRCSNX+VBleWTXMqSB5pvGA3RBzdb4Em7u047r1uuPu1qg==
X-Received: by 2002:adf:e1ce:: with SMTP id l14-v6mr2401718wri.148.1524848735438;
        Fri, 27 Apr 2018 10:05:35 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:34 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 6/6] doc: add note about shell quoting to revision.txt
Date:   Fri, 27 Apr 2018 19:04:40 +0200
Message-Id: <20180427170440.30418-7-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/revisions.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dfcc49c72c..c1d3a40a90 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -7,6 +7,10 @@ syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list name trees and
 blobs contained in a commit.
 
+NOTE: This document shows the "raw" syntax as seen by git. The shell
+and other UIs might require additional quoting to protect special
+characters and to avoid word splitting.
+
 '<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
   The full SHA-1 object name (40-byte hexadecimal string), or
   a leading substring that is unique within the repository.
@@ -186,6 +190,8 @@ existing tag object.
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
   literal '!' character, followed by 'foo'. Any other sequence beginning with
   ':/!' is reserved for now.
+  Depending on the given text the shell's word splitting rules might
+  require additional quoting.
 
 '<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
   A suffix ':' followed by a path names the blob or tree
-- 
2.16.2

