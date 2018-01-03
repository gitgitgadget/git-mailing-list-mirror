Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA3E1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeACUto (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:49:44 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41327 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeACUtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:49:43 -0500
Received: by mail-wr0-f195.google.com with SMTP id p69so3013558wrb.8
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Kjob4zYc5hj3b8XXIUitmNe1DV6E0W4Kc58Y8MUxsX8=;
        b=qx4mvdyqSHAYWypjjW5cvtadzkK/1KfyN7l3ndzgQ9GIjp5gmWaCr5mV0OrQuzK89t
         nxd+3yfjArbkfRFwoUGZxP1p7Co8d0W+pEv0wE2KIyph+3JylDThoWQ6PPiBLFpcB81h
         K2uO6Ouq5XHwtdQCTWY1tx/cKT0/VWb8RWdv/3WYN1XD2tXVgUmBNf76ScCEI5Ipi7Rl
         T6tUOwAjUxa0yTyYCAsEGFCdV+f0ru3J48a5+DoejQ51Iknob9M1gxO056Un0k3+mSgF
         X3H4mxXoa6+vjtK+krR5mUA5KJNCBxF4KfazVgeAhJiw9ysdAELb3Q9nU0zOziCH7MT4
         EY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kjob4zYc5hj3b8XXIUitmNe1DV6E0W4Kc58Y8MUxsX8=;
        b=iQ8I2mBbYA8g7nTYQzT/yAq/355PWhNwciCYlaMy0kSWYPNoNgyNLJHoM9uZqFUGbi
         p5GF4p33DLqaJhqNCu7rw0qCA+MeSRbZiWo0We3TlldCVkLb31v8VBC6S2OMt1B7JlEK
         ni70WtzuiHlRE8pdXxND+TG0lqS6QKPKDdIZ0lnQ+VGHsWuUX7M2d7FGKscYTr1sThBO
         FEOtdxHb0hgDgMuPBWoY8vWlogtZYpiyhxSI9POEyfOWezkdpP8Ph2foKj0z6uIXBIw2
         AqToS6MPaW8OOLNquvzlXIIAppj5qQbsKQ3a1S1Qis3UeUGWnn4kySfp5nglSLDbbv8M
         OCcw==
X-Gm-Message-State: AKGB3mKts0hyThZVsZsCxrZ5eIaxytV2CB5Uqllv6q4cbpmINjqr+RPW
        vFndu3Sfc9262BG6CxyBHnNcNsdn
X-Google-Smtp-Source: ACJfBosXPBjMR3LEDEtBISLiY3VlwoxVZVDjrL4WiKhIIz0kUqKEWcLDZ+pABlGxbtMeCDaxDtdUxg==
X-Received: by 10.223.150.20 with SMTP id b20mr2647813wra.5.1515012581854;
        Wed, 03 Jan 2018 12:49:41 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l9sm1908443wrb.45.2018.01.03.12.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 12:49:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] dir.c: avoid stat() in valid_cached_dir()
Date:   Wed,  3 Jan 2018 20:49:25 +0000
Message-Id: <20180103204928.3769-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180103204928.3769-1-avarab@gmail.com>
References: <20180103204928.3769-1-avarab@gmail.com>
In-Reply-To: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

stat() may follow a symlink and return stat data of the link's target
instead of the link itself. We are concerned about the link itself.

It's kind of hard to demonstrate the bug. I think when path->buf is a
symlink, we most likely find that its target's stat data does not
match our cached one, which means we ignore the cache and fall back to
slow path.

This is performance issue, not correctness (though we could still
catch it by verifying test-dump-untracked-cache. The less unlikely
case is, link target stat data matches the cached version and we
incorrectly go fast path, ignoring real data on disk. A test for this
may involve manipulating stat data, which may be not portable.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30e..edcb7bb462 100644
--- a/dir.c
+++ b/dir.c
@@ -1809,7 +1809,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 	 */
 	refresh_fsmonitor(istate);
 	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
-		if (stat(path->len ? path->buf : ".", &st)) {
+		if (lstat(path->len ? path->buf : ".", &st)) {
 			invalidate_directory(dir->untracked, untracked);
 			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
 			return 0;
-- 
2.15.1.424.g9478a66081

