Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C56C1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeJXGP4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 02:15:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42448 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXGPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 02:15:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so1279495pgq.9
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnFTY2Xr/X5Q/rVAcBIG7tVw8WXMQ9TVFIrESBCDqiY=;
        b=c8UJLg6UaKnS1b0GjTmGMtPteTxTmdN4lSzHNe90itHvRbIi2Vtbqu4QJ0tL0lcOJ0
         Ci5dgHZKpmGOjoZv9GIr4C12KrRldSO8iA4oyn4Gfy4rd8uYs3YsVvGIwl9FjBdLF9Bo
         F9hxqwCFQGYowQr+MAgh8pT8oEAAc8ILZ4k+RBtpsbm2jd8p2uaKdJGZXHZEytSHdSMC
         M3qpJa1LU6LiMVAA/8Hvwc+wxPRI//gmMv6eP65sab3H2EwDrYMvbCvZYV/W+xJ3VDmd
         o0QfDrK6m1k2Wnd7ngLA5Ns0/Af0wc2HTGt9NeRGheJPcgOYyxZg60k/Xtm8AXKsFdXl
         AgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnFTY2Xr/X5Q/rVAcBIG7tVw8WXMQ9TVFIrESBCDqiY=;
        b=a8hrzrtc5Ex03Mgxz3HfdfOFPtu0sNrgxw8Z+PZPSKeMChos/2EwP6DHWYCUw4s/YV
         2TWfSajd8uhq6ARVhkz3p6zgnjQ2xwD4YeBYbgCu0LVAgOCHbBTDSGMrZqcAuWQ28bIM
         VfZ1llm18JOki9bzFnRg0HSvKGcJRfoBrQ965byw1wOjpKBlDPkp0lWY6myHrovhEjfH
         6YUl2K0jnJR9Giv8Qra/Oo1T6fEuTSf8RIq2LsoA6Rj44BC/eACmS3IyPYsSEBiteeAu
         exDHNJBGmR4+j+VWd9Ee7QD53yVJu8iQ5CyhNePPsdX1Kqm8GOOdFwBH/w2x0npHdvIm
         YIpQ==
X-Gm-Message-State: AGRZ1gLdGk8g2mURap7fM0DjR71uHXgS2NKWWumsxSzsAln8It2Bps7y
        94ZZFmCplEkkyBJ6zSCEsNA4xe9VfjI=
X-Google-Smtp-Source: AJdET5e+uOqXJzg53GOUKPaeEDgUz39sz3mjksas0GuBRBc3TzFbW+aSH7R6i0AsMDTjRn4qXhQf+g==
X-Received: by 2002:a62:5103:: with SMTP id f3-v6mr11805pfb.107.1540331440399;
        Tue, 23 Oct 2018 14:50:40 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2766810pga.64.2018.10.23.14.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 14:50:34 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/2] delta-islands: avoid unused function messages
Date:   Tue, 23 Oct 2018 14:50:18 -0700
Message-Id: <20181023215020.18550-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
References: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the macro generated code from delta-islands (using khash) triggers
some unused function warnings in macOS, OpenBSD and some linux with a
newer version of clang

Carlo Marcelo Arenas Belón (2):
  commit-slabs: move MAYBE_UNUSED out
  khash: silence -Wunused-function for delta-islands

 commit-slab-impl.h | 4 ++--
 git-compat-util.h  | 2 ++
 khash.h            | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.19.1

