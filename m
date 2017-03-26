Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F12420969
	for <e@80x24.org>; Sun, 26 Mar 2017 02:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdCZCm5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:42:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33688 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZCm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:42:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id p189so4074270pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMouYPqgSHhpbkli7gTRZl+g6btibOMQ9LzHki6yCr4=;
        b=PwI7shpPZjyEFl2r11IjmG5zD2FM9y1BWGwdvJ4sSbMH5EycNWiH36Wn2Ye7+PYemr
         uDPK7/elrAVJlMLBZoBDJA+o4wi6eoonX42x5fKCnS2BJvj2vxk3Za+n1GB6aOpuz/4n
         bsIQOyQi5hPe9VQaI/ArfUkqexsDDoezPqMv3rvuHbrF3xdHaMw1C46mwc+66gK5w5Pw
         kNss+uzkYYGlRGiJZq7SKLFec5NgjE3nSs4gwL8IU6ugB6NFJy0316Jrvnxa+KO71yDh
         byMXD33bk7HzFssjqKXmR7+ftA+TYOWIxRzsmrcEOt9CYB57tdhTCpESfPP8W80QG6cX
         cpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMouYPqgSHhpbkli7gTRZl+g6btibOMQ9LzHki6yCr4=;
        b=UgNaPjdtNyllkuC+l7ja6ABKQrgn2QfXVzR+qFLqJm2xcxYBtEuYXrzWDkgdy7X80c
         dyF4arOdn5AJxeeXe6+CNe+COtfqmslOWN5eSfW9tiFT8h+eyyHF7SC1Cqiz7jbprJAM
         lDevFCvP9NMpH3ouuR7Md6wBba4j4jYuCUBO7vJLGq76UsJod8u9/qJpb1vIfhIsl3sy
         WJHjmDVtYqy4WL8an2MGNuRRVKNRZojzRUbgVYSEVHEv2D/l9AXb6sI3n26ROJ1ncPzu
         /xaljUWb2OwNzj34Df1NyFlXJ9BfeFLXUWAA/xDLCRfd5LQ0YrpHVlYYH9QcfFMEnPTd
         CXsA==
X-Gm-Message-State: AFeK/H0Gh//vQyBCgCVNadi1s6vEzS2Gj4R2XHzK1yEZAnSCiYgyLYRQA33zPWfKJapo9w==
X-Received: by 10.99.163.91 with SMTP id v27mr17171733pgn.171.1490496175381;
        Sat, 25 Mar 2017 19:42:55 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id a77sm12831830pfj.1.2017.03.25.19.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:42:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:42:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 01/28] refs.h: add forward declaration for structs used in this file
Date:   Sun, 26 Mar 2017 09:42:14 +0700
Message-Id: <20170326024241.31984-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/refs.h b/refs.h
index 3df0d45ebb..2d6b6263fc 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,10 @@
 #ifndef REFS_H
 #define REFS_H
 
+struct object_id;
+struct strbuf;
+struct string_list;
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
-- 
2.11.0.157.gd943d85

