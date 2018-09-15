Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE5C1F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIOViM (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45837 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOViM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id r4-v6so10259009lff.12
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+Kj1VaD6rVVILNrJ+wkHEV4pP1IUVxxYcORiVww0Cc=;
        b=IsSWPwGVCWaKNJFAhD+u1RL4d6ArDScMBey/Dz51mBxj4G6hvlcMio3s0WBTjZ0IUR
         am66P7iqeh8FcNLlYvxAJr12lfLtYSxQs1Z7GTOcRroNVgfaPHdlX1zmoInW8GY1kULx
         HeuOETwP+0uOFu1BEmIPmzkqkVqolHNqVdNUpTve7siBvYOxTaX/5WHpU6D3mM5QHQYW
         czOSCEPNs//E7L494X7++ORxDePqN35gRMq2irnjLuGKfJDjFMPRLOs1cxm7Bv3Q4ghd
         RyAnBiEm/+zB06L7w79g0xvsXyfasJRcvdki+mOgxpHIDzIN25KSNeA4eJ1CbGjKyT5t
         Yj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+Kj1VaD6rVVILNrJ+wkHEV4pP1IUVxxYcORiVww0Cc=;
        b=dkggpx0p+6gDnkTqgfwMoVppJjsAwvplYaEqYqF5dcTamyXniF67vDUG21+oNhTJ5e
         q0cXXy1XLXalLiGeM2U6zvGHIQ6a9C07gRJZv25gfC487navh6Ju3DGWfHOxw2b1VlYB
         YS+TzzZawspibZASu1rS4SHelkZ/Fp3Cs+wvHWheYhWeEt1jEJR4DnrRjdU6CN5zSvSl
         8lSR3zHeYmIicVzaeOdyC2HGBqsEIiZCkgDXIcB5FInve8nbqSrrdBwJi1tGvaQsVgy9
         tBGt5s+9V7oEl61rGgKEK/hA5lK9hkcf7JHDlBJaYpEgeEOvSj/Z3Yn+hDkqDlYAfTxX
         k5rA==
X-Gm-Message-State: APzg51D/d2ehsgGPac+pN7E4kEpC6i2k3JMN7wJT6AXPK0ZNm+MejorD
        UjHW0LArGosNzxLeNM/IyYMgRweF
X-Google-Smtp-Source: ANB0VdYhYBEfimmcMlQge8bSr8/jPsHPre9J9+N6yMFEEKdzpzPEp2T30cqRvkDsc7K4zT+dyNgkOg==
X-Received: by 2002:a19:cd8c:: with SMTP id d134-v6mr11413632lfg.41.1537028320542;
        Sat, 15 Sep 2018 09:18:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 02/23] read-cache.c: remove 'const' from index_has_changes()
Date:   Sat, 15 Sep 2018 18:17:38 +0200
Message-Id: <20180915161759.8272-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function calls do_diff_cache() which eventually needs to set this
"istate" to unpack_options->src_index (*). This is an unfortunate fact
that unpack_trees() _will_ destroy src_index so we can't really pass a
const index_state there. Just remove 'const'.

(*) Right now diff_cache() in diff-lib.c assigns the_index to
    src_index. But the plan is to get rid of the_index, so it should
    be 'istate' from here that gets assigned to src_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h      | 2 +-
 read-cache.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4d014541ab..260e4ee44a 100644
--- a/cache.h
+++ b/cache.h
@@ -703,7 +703,7 @@ extern int unmerged_index(const struct index_state *);
  * provided, the space-separated list of files that differ will be appended
  * to it.
  */
-extern int index_has_changes(const struct index_state *istate,
+extern int index_has_changes(struct index_state *istate,
 			     struct tree *tree,
 			     struct strbuf *sb);
 
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..86134e56a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2122,7 +2122,7 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(const struct index_state *istate,
+int index_has_changes(struct index_state *istate,
 		      struct tree *tree,
 		      struct strbuf *sb)
 {
-- 
2.19.0.rc0.337.ge906d732e7

