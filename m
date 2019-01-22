Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349621F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfAVA0s (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:26:48 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46947 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfAVA0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:26:47 -0500
Received: by mail-pl1-f175.google.com with SMTP id t13so10527798ply.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaCP/E5Z++2qkz2B4bFDcEhzeP6npECxKatP+i0FYOk=;
        b=d5A13q3GRhvJ56ThI5GsypumOD2rPc85pwpts2EHbhyRUpzsEJWLit/xlBmSc15QF3
         Rp+hEae31UptxpFxeVjIu0AHfZMOfQqCNFPW0hNMFzZPyQqO3k0Hwn2OlhSP3zM+Sn/j
         A0wYinhBUav1+D7TKKrgOfHIl0vECBybc9j7MltY65M5dxboxHu3RP/KvbW/yBqN0BTN
         /lJ9dnD/v5UkvQCjqms4ETHCJdNk5fBxm0hesLL3aMnmwxG+jhozKpzZCC5Qk5DymYdF
         En6p8VvTTjN/dPgJ4Mj+imQ+cIa5/BCB3eK/6+6SpYbgpXHGFSH09h0QBqdrYou43qfj
         USrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaCP/E5Z++2qkz2B4bFDcEhzeP6npECxKatP+i0FYOk=;
        b=lshMcHqcv1LsOzt9uPxkLuuCOxxGjLTM6M5gATiZ6tDkL8qaZ4Wxy5RpDMzpLen4/C
         /1rgKEuBJZ3le1RHGNAuangCPiC4RXTB45v/FoNprXsQ47wXOR8cWIDplNzFuBJ/hvWH
         kh4P3+xC8nhtupEvncPZBCgW0VlZtrujP3AwiOlfoXXN51tYInfgr7Dtcf1JuWW5knMK
         yAjmHKbWMWZgqKALh8tEZQFl4QIHW/OTuhyS5EGdFxX8CizPuZYavmJGL175VkMfTxl/
         S0xg214QaCCo3cvASAxpSTLPFqos02vQNeIy22gX9/lwv4hopSu/XHMRMJT+WeOw3wJe
         dWIw==
X-Gm-Message-State: AJcUukcwngWQIeL2A45dMlNSvxG25n5vrqW+eI8IK4aXFArOomp/VGag
        guibeFY59V1yRySUbcJ62vhy6fUG
X-Google-Smtp-Source: ALg8bN40gjrxRwvgNccaVY+Dv0NJ0ffPUxRXP2rUlPvC2MGsOmsiUbOKdEBsLAFWOePf2RC2BTyu3A==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr32631873plb.10.1548116806761;
        Mon, 21 Jan 2019 16:26:46 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u123sm21306640pfb.1.2019.01.21.16.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:26:46 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] diff.c: simplify diff_opt_break_rewrites()
Date:   Tue, 22 Jan 2019 07:26:35 +0700
Message-Id: <20190122002635.9411-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122002635.9411-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index da5ba835ce..2351571251 100644
--- a/diff.c
+++ b/diff.c
@@ -4814,20 +4814,15 @@ static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
 	int *break_opt = opt->value;
-	int opt1, opt2;
+	int opt1, opt2 = 0;
 
 	BUG_ON_OPT_NEG(unset);
 	if (!arg)
 		arg = "";
 	opt1 = parse_rename_score(&arg);
-	switch (*arg) {
-	case '\0':
-		opt2 = 0;
-		break;
-	case '/':
+	if (*arg == '/') {
 		arg++;
 		opt2 = parse_rename_score(&arg);
-		break;
 	}
 	if (*arg != 0)
 		return error(_("%s expects <n>/<m> form"), opt->long_name);
-- 
2.20.1.560.g70ca8b83ee

