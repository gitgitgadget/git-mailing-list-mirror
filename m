Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422EF1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeCCLkB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:40:01 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45153 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeCCLj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:59 -0500
Received: by mail-pf0-f194.google.com with SMTP id h19so4257506pfd.12
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/+gdfxpVAX0jvsZKarlKpzH9WP2xhU9ba48FRXio0g=;
        b=qzzrr/qZPaHlLw4iV00FIZPsjIIArMY8vpkQq3D7IJQFsASo+ltN8HWUiqnfnN+d6/
         ivsGAO8PvmKeCiaGiFk/Ny8csKFKu/kLkh+jkscVJg5XgHixp9Rynxro2yscyt8GgWa8
         W4npaYLD/xwmcxsEkbSCAoMq5ip8/EnI4J96H1G9PnFdt8yhXckNm4GnOTlWZO31ipPy
         QXfuFPBIQjTH8dmiBSVZ5rV9D6EVccANMIoNlJjnY4+MwT0km7EM8SKSwlBw2lKxfqIE
         63zUWrnye/AxVQPM0Fp/LEMy05Q8z44QIK87eyaGNVwqWKl0Ro3d15cNJDyFXlmKhW6d
         hzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/+gdfxpVAX0jvsZKarlKpzH9WP2xhU9ba48FRXio0g=;
        b=nUV6rVq3pBN7Fm3Ia3TzuGEiFl76ctfOipHcMdmDDWk9qoPDBz00khtZx02Szsa+GM
         C9IRJIIKQwiEpDOnlErcfrr2OjP/6UzTm5lEMN5Ryw6JgcIrnTXrtQy3KYchkzt37W1E
         7pp7N1vFzYRfjq5JEdcRz0hXRLp0dLFE5C+m42O9KUU2ffhqGJp5CKJOkAgGaWKLpQeS
         9Gi/2/iP08kfo0PGEg/H5Y5mCYPs1wbnq6c6RUo55x3GVlJNHRKw62e4w/u6rt+0bWQ7
         b56BmobVcJNevIU1W0JAn1NYq4D6nivohn9gCJqcazp4cGdW84n5SltmMKyl3doPVB0i
         pkiw==
X-Gm-Message-State: APf1xPAVKMqjVLvS7KuSTKMeIDyApjbNXTnRkxQL5MJjHbX9hUekTxKx
        C964yeUiwvjCqPButo8a8oX59g==
X-Google-Smtp-Source: AG47ELtDrm9fH3GZCBv0AsUU9DeoMW9/jtJ8l3SMPHvYKwrYRiwtaeW52cLccOiPQxB2qM+WVML/lA==
X-Received: by 10.101.96.142 with SMTP id t14mr6980863pgu.58.1520077199240;
        Sat, 03 Mar 2018 03:39:59 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id n14sm18280141pfj.154.2018.03.03.03.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 39/44] packfile: allow prepare_packed_git_one to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:32 +0700
Message-Id: <20180303113637.26518-40-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 53db240d0f..52febba932 100644
--- a/packfile.c
+++ b/packfile.c
@@ -734,8 +734,7 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
-static void prepare_packed_git_one_the_repository(char *objdir, int local)
+static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -768,7 +767,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = the_repository->objects.packed_git; p;
+			for (p = r->objects.packed_git; p;
 			     p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
@@ -782,7 +781,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(the_repository, p);
+				install_packed_git(r, p);
 		}
 
 		if (!report_garbage)
-- 
2.16.1.435.g8f24da2e1a

