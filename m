Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6581F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935846AbeCCCrV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41767 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935762AbeCCCrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:20 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8-v6so6738200pli.8
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CrW8HigdFwSeZAUQ44cdaix6gm6zOJGxlLxROjtR0g=;
        b=hAedgllLz00WYLFEufcBAOAa2Y54f49uzsTx0LtA2PNS5J8NqUWUcjUQLfpCNRrbwe
         XYFs6ak3E2qVRjQ9c8I5gjzIS5hYxg1Hc0iULqQbPN3UljAkfaESJ4xdMEEDhOUynmTj
         bQQHqQLCwaZxD/lLPQOxECNVltnyXj2sK/D1xM4mxHoJ+yqghXuyaLgcMUXaB8goJ++q
         Zk4AOFGgdCMWGSzBlGSkSOKKBxjoHW6d3juJOqR50vvOs18Z6/Vram+tVtdZldppbos/
         qJNtQl0QEGPlf/SRgO8AkRWythcKlQ3tqrMC1ncXYkEiu3DH0WZri1/Aw1KJsH8cnfgR
         n8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CrW8HigdFwSeZAUQ44cdaix6gm6zOJGxlLxROjtR0g=;
        b=hL2p1BvZ9P5Xl3eHI7LN+3OIrEjmP3p1ecmqQg1qxT3pa1q7oUZq82uK06eVpm9i1f
         FjWtYfywa8diKs8A3kg8c1g1XTLlzcXdGyxOQ4Otv9TGZ581M0DuO7bXbwLuPnVFkR+H
         uIKqX0DfVOa0K6h7i2A1QwAIc02nhGl6My/5C7f5fXUb+blBju0Or+AqAEG6MsSzAA+a
         qEgoqdSgwFGYyXXOGA9aFEzuRvKtQsVpXYDjtylDBCfhWtJ5QnFRVBtO0dQLtbe2uL/X
         mXaNzqVARvHhFmhYC3mmkPyzYurmWdQHsS9bDt0HjLULYtY5JPDsIN1P3mkbd1P32BEj
         hAdw==
X-Gm-Message-State: APf1xPDkSO1jTazkmYzLQY1KdpDk1MmAUEnRAaRHxZmUyOz65KXHp2Gz
        1kLJiekWdTsr0qxftpAJw27b+g==
X-Google-Smtp-Source: AG47ELtgN7EIGdm+hvtiUywB185M6qtY5oq/xU1KPWT/1dgDcTYi6GF+fRzqkjSz1wgwI1lGRpv8aA==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr7040151pll.274.1520045239638;
        Fri, 02 Mar 2018 18:47:19 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id t14sm3907411pfa.178.2018.03.02.18.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 1/9] pack-objects: document holes in struct object_entry.h
Date:   Sat,  3 Mar 2018 09:46:58 +0700
Message-Id: <20180303024706.31465-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
References: <20180301091052.32267-1-pclouds@gmail.com>
 <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..720a8e8756 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -28,6 +28,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 
+	/* XXX 28 bits hole, try to pack */
 	/*
 	 * State flags for depth-first search used for analyzing delta cycles.
 	 *
@@ -40,6 +41,7 @@ struct object_entry {
 		DFS_DONE
 	} dfs_state;
 	int depth;
+	/* size: 136, padding: 4 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

