Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1805C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiC2Aor (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiC2Aoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740AB23D5B7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a1so22585976wrh.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/dJLnMNPf593DDA+ox52qw4qYfm4mKhrA2SM6fu1eys=;
        b=NKjoEGPpy6A19aPx/7Mf9IQrxPL+mZqYdLELJK5EVA6io6Etn2qSieGtjQ5JBBRNL8
         LIcm9X8YTGFXESonmJ6OVKDWbMxCLtEQM357Uo3pPybIhiIazUiW+jEuw/Ze3UWYq+t4
         eg/T6zasww5xt8Fwqok9tGgMHEpnkgZ8kabvoYHOmzrBfywgaGjt+FKgLPGwrBdpxJxU
         AdahylYziw+ybTacYCHxIMeTsApiBrPXuuX8fCOWqzQEdN4r2HIcJn3/+Y7saWnn3/pm
         Qfs7tAkfL5YVnf0GllEOPVXj8H98RUg5V7eMeiPPWhh9HI38iJIG3eLV2y+bpeQ4OyqE
         +kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/dJLnMNPf593DDA+ox52qw4qYfm4mKhrA2SM6fu1eys=;
        b=uHgFdLKrE3D3rGbWj1lIc1EDcSK4c2c5jjHj6SvFC67Tq6FGDDHSjUIvxBxQSEYQ2L
         ruuPc5aj64UFxjE9fz0nfdAqnYQeWVvePCSdqJY4b4D8O3Kqc67m2hntHk+ypFO95acp
         f748rurxnDOyl+JOrs57dgyS12/d1BYvLsMIHuqmTTgItxrnxeoTTd8YVaSsDp2oubsP
         pQO8BCwBGGbDq77CjiiMHxOQc/P4rsB7Dz9L+xUiF44ErDY1PLlRtJc6/n+Zk4xmEzQm
         IH3ZmypGHm+uT0XMLo95lzB6l61JyT/ZfT4ta/kD8gWac2tbMAulLQi3F4XADZvYW8cx
         DNlA==
X-Gm-Message-State: AOAM533goa09pRVP8vwkXX2OLrfnYU51tXaJXBZs6/KMNcS6+sjPtLBS
        OUf/uml/PalR31j1NOAEq9NKoAqk/To=
X-Google-Smtp-Source: ABdhPJxoYZVYUVr+UTSjWkLrV7SobpR7Rh/1Ne/XFWg/vB+FtBy5yib5518Y82Tm0QjxOq+crj6kxg==
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id u16-20020adfed50000000b00203da73e0fdmr27923895wro.516.1648514565853;
        Mon, 28 Mar 2022 17:42:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm14246163wri.48.2022.03.28.17.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:45 -0700 (PDT)
Message-Id: <fb30bd02c8d240cbc8d50a335ac9b52884f06413.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:30 +0000
Subject: [PATCH v4 13/13] core.fsyncmethod: correctly camel-case warning
 message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The warning for an unrecognized fsyncMethod was not
camel-cased.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index e9cac5f4707..ae819dee20b 100644
--- a/config.c
+++ b/config.c
@@ -1697,7 +1697,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
 		if (fsync_object_files < 0)
-			warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
+			warning(_("core.fsyncObjectFiles is deprecated; use core.fsync instead"));
 		fsync_object_files = git_config_bool(var, value);
 		return 0;
 	}
-- 
gitgitgadget
