Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3480220248
	for <e@80x24.org>; Wed, 27 Mar 2019 09:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfC0JQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 05:16:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33309 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfC0JQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 05:16:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so786038pfd.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9q4MrIGBUbms/u/4/1EAZUPfOysVodT9y7IOBD+YYw=;
        b=d+pofsNi+RAxKHZEjnDDUx8sJcimt7TE2g8NXi8eRFWtCcOSPrNThEaAU4Qr7gDNLI
         cTgzqDQpQZK759YQDdgYeZo2TGkBvfq9mxszbReBm0erPZik09NK2qp35RiI9xnoOH5v
         ebqfquRgeHL6G5K8UUG8aKtCO9TrRcgY0+eFThQMxSxJirUu3Kj2FMVaxDN71jNRj/ZH
         PnRO9yWIFRSo34tuMWnw1x3Db6a6Q7aWCGORk11W6VokdeFslSwJITGmX4sVdMFQFMJB
         4IX9pISqYaaV84it/x1LFS2n1jRikvx98RgZs1d8WSAOCAgdvH8Xqfx7sJXeKVc51xL5
         qg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9q4MrIGBUbms/u/4/1EAZUPfOysVodT9y7IOBD+YYw=;
        b=hEgbD7m1KWjPnLtOBlwm/FLDPoiZN3sYZmwMuwMmS5RxxJqKMXyUGI9GGWwN889E54
         oHKsuWdSn8ixl0Fk+U50b9eVm5UOLrNou85GlNNqucwy1nwMtnxqTWbvnXb7FW54jz0m
         tKB6bDc8BSYjYKwxKz9FGTxY8utFcQ7ktzlxVQDQyD1wXNZSHHkzD1ieolvgRH/KfkOR
         P15kRpksM21Y5kQrgcLMsDye6HOYioJexFGyIw9Lao0jhcRZqnSJNTNLSOsMuhhe5fMT
         d50TkTMJhHkXJgAqdiSqM5rWjrmGsDw3dsSgkoMP3UYBMQWHSXe6/ZzDDR9eylSY6Bpm
         5PCQ==
X-Gm-Message-State: APjAAAWLvE+81a3eEx+dcCn8Ari+g7fQl3WRScJmchARZsE2+cRD0zR5
        BoGkzGcPprUYLoqrxscd1GPbXi9F
X-Google-Smtp-Source: APXvYqzkTSWZNhn45qbpFZkl6aMnjzrnu80dRsPAgEE7tsQDWOvXo9k1+/XqmEGae+yaQlxQFhKoHw==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr33377750pgi.310.1553678197058;
        Wed, 27 Mar 2019 02:16:37 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id d15sm5502243pfo.34.2019.03.27.02.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 02:16:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Mar 2019 16:16:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] interpret-trailers.txt: start the desc line with a capital letter
Date:   Wed, 27 Mar 2019 16:16:28 +0700
Message-Id: <20190327091628.22102-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This description line is shown in 'git help -a' and all other commands
description starts with an uppercase character. This just makes that
printout a bit nicer.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index a5e8b36f62..96ec6499f0 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - add or parse structured information in commit messages
+git-interpret-trailers - Add or parse structured information in commit messages
 
 SYNOPSIS
 --------
-- 
2.21.0.479.g47ac719cd3

