Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAA3202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdJBFZf (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:25:35 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:44479 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdJBFZe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:25:34 -0400
Received: by mail-pg0-f50.google.com with SMTP id b1so946889pge.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRmm+WwLhr/arDluE0TLWR5xmjxtlWiyuLLS6qtlmC4=;
        b=gnfSvC2w8pdgMrfN7ernM3wD3TrH4svb7EkwuFd25hbimLZ6HTX75tdjC7fWbj4gNd
         ZgW2/BOmLhfwYBIXEQAL6lB9okMOwnlCr6sh262Ccl8bGo2nKL79dx0lG0OcbWjzM02K
         +JC9gP3ZzXxPLCY5QX1aufsllwIoTCKox6X0svAKH3/LiS2oDDW6QfphPpv+OsfKLf12
         gR+y26P6IbWqr+zfxeEMwWRh3ZCAjq+5VvdOPjqzRcxvzdH/CYhxCkGN2QtlvpeHX7zi
         9NxxyBsPGtpnrLA06QXcE0JyxsMuY4NpNGs5di2GAwzsQKK4UcqCtJJHdHyPw1BlcrYp
         4fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRmm+WwLhr/arDluE0TLWR5xmjxtlWiyuLLS6qtlmC4=;
        b=o2gQJyyavruLTFBGx/IHbOo/9h2XrZjlzwEFmEGvL0dSjAzYyUgBWalCGEBOGyBBzw
         dAEpoDwiWQ4k8REswy/6uyzbZDZgNH/ZX/IjJf4qwQj102yS5bNh+E4YPpaZIi0MFvJx
         t09xa5vYZm6aF7KVheKXPjrqqK0lmRuMZtkn8QNbyAVMvPdRGYYylv5b0ETaiPx45rUL
         h2Bly08OuqWoRGRCoCCKOjHQXa0FIpsPqY3fQFmW5u+8ayjcmf4SoDAcdT3Jznhr+BdC
         o0BomSHvni5411UU28Mqa/MMcBmtxr3p9kd12sIaHsjm5Mh9BFLKAP7jm3zPvAd1zQVX
         uwMA==
X-Gm-Message-State: AHPjjUh7VJ0WqTPyVOmWhMB5tGx81cC5LxBooCkxoL+P11GccsZZcuJZ
        WUJdm83uiLFs4yVbBxWWG0cP/fTmocY=
X-Google-Smtp-Source: AOwi7QB0KMZBsmCPs4akKqBc40Iwomi7zPYFUKJ5x3MlsNkCLg+0RF6JjHHtfiy9bUvSYoGvckf4AQ==
X-Received: by 10.159.244.9 with SMTP id x9mr13140470plr.34.1506921933414;
        Sun, 01 Oct 2017 22:25:33 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id a18sm14226918pgd.57.2017.10.01.22.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:25:32 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v6 3/7] doc: 'trailers' is the preferred way to format trailers
Date:   Sun,  1 Oct 2017 22:25:20 -0700
Message-Id: <20171002052524.12627-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002052524.12627-1-me@ttaylorr.com>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation makes reference to 'contents:trailers' as an example
to dig the trailers out of a commit. 'trailers' is an unmentioned
alternative, which is treated as an alias of 'contents:trailers'.

Since 'trailers' is easier to type, prefer that as the designated way to
dig out trailers information.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 66b4e0a40..323ce07de 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -217,7 +217,8 @@ line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'contents:trailers'.
+are obtained as 'trailers' (or by using the historical alias
+'contents:trailers').
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
-- 
2.14.1.145.gb3622a4ee

