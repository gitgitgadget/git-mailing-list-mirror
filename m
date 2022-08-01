Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A846C3F6B0
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiHAVPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiHAVPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB7186DE
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m13so11656274wrq.6
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U/XZpKfFcJKIdssrs3gETOYX7HaU26FzV0n23UpU6+g=;
        b=ZDrKK+Vf4xE3Wh0kL4/4JqLXc2qh2uKw9amP7ywE3xYutcyHHyR3mWZlRgqHxQULmW
         O8V43szfzCu9QsMqxPL5RspyVreZj3snhfU4A/ahdGoODuyOFpo9VPROxVmHLuY5wGSX
         NiLCcm84oUJt6Iiz9HjzwL/4QUQAa1Mb+sqkBpNm6BF+R0U2/OBIzdh6DzRm1KPPdWxp
         mUeKexbVH/0zTeNBXtg+uXaRBKqSI7s7KH0SvVCHPcorBpVYAOUGCD3PmyBSDAmhG4AE
         X0+V7q9xgnHYUB1I3pA/K0GkzHcTZ03kmCwfdrXm1PoaBMZ8HatOLyLPXpvACqE4CLRP
         zUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U/XZpKfFcJKIdssrs3gETOYX7HaU26FzV0n23UpU6+g=;
        b=ZfwrSGG0fp58oSb7rrbMwlIfWuQWvhzLBoSy2j+WGdlblcFNqnsl11YdxYM1fFWN1E
         qzWKJ6A70ahtw2/Un2YEDcg1YLGDGBcNBqiLptl47BaBBBLBtwrvC++bIS8rHIE7Hx1a
         QmpJN0YIHT16lfMCIk0LP2ew2iOhKtUVLs9GNTjV8vJaD/jbFxkJEVSgQ6U9ZYw/uz+5
         L4txRuMEqkN8/aawgMkqRg1c0f7KQRSZRo/rOVYKdWepGf1hk0KAVPXBT2AbcwoFYrFW
         bSdjqJ43g0DSxBIp2mjdU/caBNrcTFakr9CxVUAW2zgVeu/U00gR/Xnb8an80Mlw6IS7
         wxbQ==
X-Gm-Message-State: ACgBeo0w+SmbUwMTspWj/9cuH8PuqE/mFaOq3NN38MoojCz+BxXXni8I
        qU8xSDCFh3k1lXevTWoA473mWF6giAQ=
X-Google-Smtp-Source: AA6agR4a8g2LfuIvPrGXw/pr6AA3HRFNo60Vft8khQqOJG3g6KyrnHuwjNiweDH6dhTMnKnMiHUMsg==
X-Received: by 2002:a05:6000:1a4e:b0:220:5e43:9843 with SMTP id t14-20020a0560001a4e00b002205e439843mr5934744wry.566.1659388502966;
        Mon, 01 Aug 2022 14:15:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020adfe507000000b0021d65675583sm13174421wrm.52.2022.08.01.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:02 -0700 (PDT)
Message-Id: <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:54 +0000
Subject: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Avoid size_t overflow when reporting the available disk space in
'get_disk_info' by casting the block size and available block count to
'uint64_t' before multiplying them. Without this change, 'st_mult' would
(correctly) report size_t overflow on 32-bit systems at or exceeding 2^32
bytes of available space.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 35b1fc48bf1..720889a37ad 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -258,7 +258,7 @@ static int get_disk_info(struct strbuf *out)
 	}
 
 	strbuf_addf(out, "Available space on '%s': ", buf.buf);
-	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
+	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_bavail);
 	strbuf_addf(out, " (mount flags 0x%lx)\n", stat.f_flag);
 	strbuf_release(&buf);
 #endif
-- 
gitgitgadget

