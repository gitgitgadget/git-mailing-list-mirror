Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB3E1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeJ0PFW (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41833 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeJ0PFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id u21-v6so3101296lja.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LspnNjfgwDKvqAOzDCzdCFBvx1jbAU4j6S2uADShZeM=;
        b=eXkAvY3VJKlNGYRhp12u8F2odiQ7ISxhG/wq3w6bbgI1t2B+MRoQK+yyCTHK7MnCCn
         VyACsZzWdswMGr477dUhX6S/jsXH1+RRFaYYfDuufENnWyPxQczjqTR6Ox4jSJxKdKHh
         E6BI/T1nxgQeL3+6OUC5DhqNxdam9HFoPNttknK4sV5DFKFSx1Q9AOVY54lrg+yXILUw
         tsErZAspR1kv/7zn3QH62eIfVHRM6EDEuaWj8vDwckYHILoA7EaccfYxgv8Tp7ZpnYPW
         zilH6O83/DKCGeEdgsek8QUW0FqTmC7c4o+zuqAkQyBaPzKcbEtyRtyefEiZ3QfKVuaC
         7HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LspnNjfgwDKvqAOzDCzdCFBvx1jbAU4j6S2uADShZeM=;
        b=nYoX8aXrzs9hO1A7szZx14tcK6DmbzJ28m8pWw4WM7X3AqqnAWHBifdGUQceSL9bD7
         YDH8YuNPFPZv19fdZZRkoFDTY3kJasUjufvQ9Wr8VR5GhI/Eq/GwAvFhxONvWAplkS37
         2rouy2+qddazps5wjNOZvkjS+4Y3+qOK67X0CiNSeKSAwbVRnMYtoms+8mK/TyZXViPY
         F323HQ2K4vCYekFNmy0EPopu8e7UEkHLyuJEoMe2fUBfvlX9pAJsV5Ahr7g20Jywbrzz
         4agRZ+EqXndIGM48DT7dDMsem6b8q4VJgl3qF/BXxZ1o9/4X/fTNoXEvO9b9aWdY1dtl
         PrIw==
X-Gm-Message-State: AGRZ1gKltbIADksY9bW3kr6bZhZ9MIrJwkoizczzuPGSxHqWe11gU+Gc
        a2FnsrpVzS+yCqMz8w0hpIWSbRlM
X-Google-Smtp-Source: AJdET5dYNSzPcgY2uCX5yAImpayMVDnJfxiY5SfEL+gVNgmrVG4ArpRnib7a+8E0lyK3qiCewRcx2w==
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr4166222ljd.94.1540621525916;
        Fri, 26 Oct 2018 23:25:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 78/78] config.txt: remove config/dummy.txt
Date:   Sat, 27 Oct 2018 08:23:51 +0200
Message-Id: <20181027062351.30446-79-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This file was only needed when config directory was empty. Now that
the directory is fully populated, it can be deleted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config/dummy.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 Documentation/config/dummy.txt

diff --git a/Documentation/config/dummy.txt b/Documentation/config/dummy.txt
deleted file mode 100644
index e69de29bb2..0000000000
-- 
2.19.1.647.g708186aaf9

