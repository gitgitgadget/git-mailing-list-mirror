Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB95D1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfFXPsj (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 11:48:39 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34045 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfFXPsj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 11:48:39 -0400
Received: by mail-wr1-f50.google.com with SMTP id k11so14484418wrl.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDJbLC5vFjTr1H7bfdHHfqSNQe9tgcM0xdX7cOShsdI=;
        b=O6a3u3NXn53uA8lZIKM6JJ/Ry+xmV6vXKos5T/Bp0XZByqy80yuJ5m7nUM53CJFsp8
         eW9x1VTaprjHwl/+AXPdu+aXZ3iGFuqBWYrKmpStpLGWL7hblMCuCOOfyVFHEHLTPiBf
         UhG1jQ5C/PYHxLAbLabM/WNNiEgYEOmkn1clcI0C6GP2GszkMbfgTAFTNaYzsGLit+aI
         +AoMWaoqFFlCSxpmxuSKAK3vyanPXr70UQUXiRAo/g9+BG6T9fi1QXucbpz7jTv1/xbr
         clrQf9gmSVIDxdeSn4PRxNWJ6TVGZQ48T6vGhdviK8yu1CZO7i9+TfKqYuVR12tbjuw6
         Dkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDJbLC5vFjTr1H7bfdHHfqSNQe9tgcM0xdX7cOShsdI=;
        b=H001ZhFey5rxJ7d7yH21G9J1RCKg1275GZT9lnR2UsW1RJV/ThNVX41KBubuR/74wd
         kaAjEEM7lcneMpKl9w8ap4H1wzsvwRHja0u/+hXLV2Q+o4DHMiBFurwZMtbHJBc8m+rC
         /I+c90WTqF9yyaXFanQHtIXDEcC3IrS+jlbgj6jNCD/hAeLkGiVcV54esE12jBMwlfR1
         hvLyBGaOr+kt9wOudTA8Iq0afVTag5+pnigjrB/087KTtX7O06r7fgYBYAwkYzKROrAS
         MeG/wM3k0Co1X7qp/J8Mhj2q7ZJdg3LMAN8V6kKmxVA9Eh9EyqTmpsGsB1XfumKtq+6G
         nx0w==
X-Gm-Message-State: APjAAAUE36xklp+7ZRookmcL6Qs4YH3g2QOkOKRfLebOxeTfCETJFVnO
        YlOeL4GhGtXDMu0y+u6AiHg=
X-Google-Smtp-Source: APXvYqxWxCMLso+ylTzklqdBPpeH/4gZGcu9oEW+uOv7M9QxZyyIRc1JTT4Jex+wgjCRO2uv9JA/pg==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr19441942wrw.279.1561391317307;
        Mon, 24 Jun 2019 08:48:37 -0700 (PDT)
Received: from linux-16.fritz.box (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id y18sm3505070wmi.23.2019.06.24.08.48.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:48:36 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <MorianSonnet@googlemail.com>
Received: from linux-16.fritz.box (localhost [127.0.0.1])
        by linux-16.fritz.box (8.15.2/8.15.2) with ESMTPS id x5OFmZFj020227
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 17:48:35 +0200
Received: (from momo@localhost)
        by linux-16.fritz.box (8.15.2/8.15.2/Submit) id x5OFmZGm020226;
        Mon, 24 Jun 2019 17:48:35 +0200
To:     moriansonnet@gmail.com
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, sunshine@sunshineco.us
Subject: submodule foreach: fix recursion of options
Date:   Mon, 24 Jun 2019 17:47:50 +0200
Message-Id: <20190624154750.19842-1-MorianSonnet@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624154050.9943-2-MorianSonnet@googlemail.com>
References: <20190624154050.9943-2-MorianSonnet@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the right testing git now.


