Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A62C1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 09:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfBKJkV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 04:40:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35081 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 04:40:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so4721196pgs.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 01:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96q3kvCTPV3fFmJ+VJbxQXFMzgnECraqdmA+NaU4r30=;
        b=k6PmENwpDpv2VOdwYNwTU9eXt1eGt+a0lwdD1RG4SGYwi3TzG+6ADi26Ed156SAUae
         Ft8Zw7WjJ8mFBiMjqvxMLJGhPARg3LBNiIkuBKSX7/Azh7DQlEji1gX1R6QII4n2PbSv
         QjfkN+ZttoyzPtyXUCi8y0DO3l8TBQy2d4CWOmB1OquozyqhSfxdsCCr27cvQS7ZO4/i
         3YlnBFYVhn0j2SD2EAOdUxrIl8xmd59mhg2cJwjvbDkAvykzRj9tphsnJGJ8of/ntJ8R
         EYmh14ekGz0/ZvcoCO0yIUZWfLPsXbVzc2bo5tRT7kDffzwg1yWJ2LYzGi9g/h6BCeWO
         UndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96q3kvCTPV3fFmJ+VJbxQXFMzgnECraqdmA+NaU4r30=;
        b=CxlnDShiWnTHXclH3y6/+X1EDSGi1Pvb5rNgwe/tf/ay9GIlwoMWvLZbAgfIwPPD/S
         71QFbqoVx0qKXhibwMuIgFtTuSN3nSEPv5vIgtATSWmLV78cOVHtlXUVKGXmrf6GCnSJ
         VCAJs5ZOw10+mVTDiRLjuNYd+DVIELKUF97duaJJH0eCtJ9B1v2LEST1uoSJGmF51Y26
         07yH7ET2La+cQr2MCAyDgalO4Mxos8I+4TMxuna8mHkYxEPMs801qwLUJcvptAJtIxhH
         jWo2A7EFGd+HLYCz6V227vwQxKlZkSO8jagdjTrUbPOq8HllcuqS4ZUNJo7FMR5h9SRl
         DqJA==
X-Gm-Message-State: AHQUAuY/77ygPm2G0RjMclhQ+YJ2wCwyEjO+7fk/J+0vv+QY7oEPVFZ3
        hdHjPepbQg7Ew9bKeFhnIIYXPgDl
X-Google-Smtp-Source: AHgI3IYjf17KvolwqGS7Uo7p7uzca67Kv0TCfiCgNL1Fp7tgUZKHwffbLvw/sbi5p2MvloQGZGkxcw==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr18179215pgi.361.1549878020442;
        Mon, 11 Feb 2019 01:40:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q28sm13958945pgl.35.2019.02.11.01.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:40:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 11 Feb 2019 16:40:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] imap-send.c: add a missing space in error message
Date:   Mon, 11 Feb 2019 16:40:11 +0700
Message-Id: <20190211094011.8833-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Jiang Xin's typo patch [1] made me quickly go through all multi-line
 strings. This is the only bad string I found.

 [1] https://public-inbox.org/git/CANYiYbGf6Oj0k3-K+s0DSO-bZZ2EXcVcoyxoJtqSbbmHEtg_bQ@mail.gmail.com/

 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 18ca6ba10a..6c54d8c29d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1114,7 +1114,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 
 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
-					fprintf(stderr, "You specified"
+					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
 						"but %s doesn't support it.\n", srvc->host);
 					goto bail;
-- 
2.20.1.682.gd5861c6d90

