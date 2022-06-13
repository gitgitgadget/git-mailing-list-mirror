Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7BC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 17:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbiFMRSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiFMRRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 13:17:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63284A181
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z9so2870773wmf.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Mcp4qADT0nEz4UZjFIbo2qISJfvc6UHwUirymNm32o=;
        b=Kj5NFmagZJJ7SfIDObCYJo6sCVR1NM0bLP+skouYgvw79gLc/pRo7XCSoi6nfNIlg5
         /sUd60DkBaiNJHuXYwUzuh4y++fBjWOjzq81jcqtAXBfz3Wb6L+WidRoc3SkcX5nqf4b
         h7v7sRfHnDguInGnOtiQofcgs77OxzZnvZEoTElR7ywaU1fiX0tUH9MxwzQfpK2b4jP+
         D5r1JTFxlk1kU4kwpeOSAz4dPvo0MzAmvSBJ+aeMLIOYO3EZLiKy/dwajwo+waEzsv4M
         9Vhx4lJDGbmDbZDjx6HVPQeYugQ4anomvfJdvJy+MjKZb/AXzyjpHer7cXNbo/N4M5Hj
         VMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Mcp4qADT0nEz4UZjFIbo2qISJfvc6UHwUirymNm32o=;
        b=B0N9ZMxIeLDCWhDOi4Vrg6YCDlD3UDY3erANdiY13gpBrelGyruvW50PnCtuNOeEGy
         e6Pve9aY9908Z32xltG2HVWPGX0diCe7WtGIS9RIRzz6JZcTL8Q6ym8S+QGM7iw6RFbr
         rqSg8J9Fu6w5M5RVISUoclJ0gAzS6Z9f+cZMDD0kGS+YVkWCq9FOHxbfkKpHPC7AJo5Y
         /vSS647aqtr+2u5Z4+ZYnknQIsZuPsbSTJhIwYFLAztT5fnDkm3JQucPkkglxDJ01y8j
         qs7PoNI+JoM7w8kQw4GmEVjcnhibJzffnttK3kI81HqBe8ccazYdM3yELTFiLABGp0iV
         5qjQ==
X-Gm-Message-State: AOAM532I0DZykSlPHCSHEgwZVb5va2tI63xbse+5PMuviT3/zN+kYqpT
        KQr1YcosONR5ZYKfMMlezim/VkGyyp0HlQ==
X-Google-Smtp-Source: ABdhPJyjMrPEJySrpM3uDsreZ1/bp35ZWndDG3Xhja/NeM4GszEYHh+4Pw2WyZnD0mzmUrofrKeK+g==
X-Received: by 2002:a05:600c:3d99:b0:39c:55ba:ecc3 with SMTP id bi25-20020a05600c3d9900b0039c55baecc3mr14862973wmb.42.1655123385626;
        Mon, 13 Jun 2022 05:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj15-20020a0560001e0f00b00210288c55d0sm8682250wrb.52.2022.06.13.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:29:44 -0700 (PDT)
Message-Id: <6eaf9b3829fa8f7300bc0123c916d5ffa7c7d80b.1655123383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 12:29:41 +0000
Subject: [PATCH 1/3] diff-format.txt: fix ancient copy-paste error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Fix what is probably a copy-paste error dating back all the way to
b6d8f309d9 ([PATCH] diff-raw format update take #2., 2005-05-23).

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/diff-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 7a9c3b6ff4c..b8319eeb41d 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -43,7 +43,7 @@ That is, from the left to the right:
 . a space.
 . sha1 for "src"; 0\{40\} if creation or unmerged.
 . a space.
-. sha1 for "dst"; 0\{40\} if creation, unmerged or "look at work tree".
+. sha1 for "dst"; 0\{40\} if deletion, unmerged or "look at work tree".
 . a space.
 . status, followed by optional "score" number.
 . a tab or a NUL when `-z` option is used.
-- 
gitgitgadget

