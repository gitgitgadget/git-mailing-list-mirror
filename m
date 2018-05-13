Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71361F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeEMFwh (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46214 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMFwb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id 16-v6so3787824lfs.13
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rab1WhVYyPMAz03helNiPmDp8AhqosrHcVoH2fiNsmQ=;
        b=c/d3zR5mGMhpKR5L7hkw+RzrwpDRRamw8l6NTaPFlu/FZVtMNzWvNqccDazVCRFEsz
         pNlHY/kvrEmooE/rYsBL8WvhmH9kitRmU1fbP7PVWgMFpk5xfTfT45nCpiV5g+UR6QlW
         cjAsGUStxolnYDeoTI6Nf9VXLxV+ODKHiadI47K2boX+IhwSeiKY5rmSLWZwEalmQ5XU
         IKikGKW5V1UkenO0eAP38bN+vHJxyYPVgi5GM+7Knu6NB1IZfM+m7gMZ9UPTOtfmK43o
         1mEMlXAXRrbXAaNLC9IlgoG+BJPGWsj3LkKLsS7to1Q9mEXpxdO+09LurA/Jz6WpGPUo
         LIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rab1WhVYyPMAz03helNiPmDp8AhqosrHcVoH2fiNsmQ=;
        b=TI+R7Cj5WkpT4Y3PhSfE8XZQAEK5hlc0oSy7c7YEmYPfJ8UgUcEkJbtC58cO2i6Vzz
         qHoH3DCAGfcIXFDlrHGm7sNANpjh4ZGNivFjjlPSpPNNhSC4LEac9yqrABL7VqSLGnTj
         Wna/CncvT/xsh4k3cxneq4bJD2Igfj9gx+MeEbslUxlta8HsX4YXxIYOBMYJlDLBeQOf
         Idu8hw5PAwyKcoga+JQ0kkICc6yrxHXrLpy2td076LfERUB/WFOlL4zdJAzDFVaDBKIy
         7NmNLEYFTdKo+2oP2n6vEt/dDXOeQK3Q4hiSCyFZ5xo/nRbeYHPxhxQ4bK4TQbLIaXvw
         JFiw==
X-Gm-Message-State: ALKqPwcdRz0JnvXAtaBKoclBXgRQdORo6LFY7fVSNUei6zraffHShdcy
        nkfogaVNg8GoWV+56MpTD4nx/w==
X-Google-Smtp-Source: AB8JxZp5x4mvj1pxOneHfQLXgZZVok9huHaYdTPNjEOPsuRqSPv6hGF3p7+vmxQ+Ti+NemMJuBDFPA==
X-Received: by 2002:a2e:9949:: with SMTP id r9-v6mr1870625ljj.53.1526190749499;
        Sat, 12 May 2018 22:52:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/14] commit.h: delete 'util' field in struct commit
Date:   Sun, 13 May 2018 07:52:08 +0200
Message-Id: <20180513055208.17952-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have come this far, you probably have seen that this 'util'
pointer is used for many different purposes. Some are not even
contained in a command code, but buried deep in common code with no
clue who will use it and how.

The move to using commit-slab gives us a much better picture of how
some piece of data is associated with a commit and what for. Since
nobody uses 'util' pointer anymore, we can retire so that nobody will
abuse it again. commit-slab will be the way forward for associating
data to a commit.

As a side benefit, this shrinks struct commit by 8 bytes (on 64-bit
architecture) which should help reduce memory usage for reachability
test a bit. This is also what commit-slab is invented for [1].

[1] 96c4f4a370 (commit: allow associating auxiliary info on-demand -
2013-04-09)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index 838f6a6b26..70371e111e 100644
--- a/commit.h
+++ b/commit.h
@@ -18,12 +18,16 @@ struct commit_list {
 
 struct commit {
 	struct object object;
-	void *util;
 	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
 	struct tree *tree;
 	uint32_t graph_pos;
+	/*
+	 * Do not add more fields here unless it's _very_ often
+	 * used. Use commit-slab to associate more data with a commit
+	 * instead.
+	 */
 };
 
 extern int save_commit_buffer;
-- 
2.17.0.705.g3525833791

