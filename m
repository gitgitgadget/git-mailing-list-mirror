Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D476ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIIOdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIIOdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C983F16CA
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bz13so3099236wrb.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=ewWdgINeDogjbAxyhyHuxTCApDJunU7409v6MqwQtl4=;
        b=cf3i4XXSRFR6TjpopzvRoMT1cavOKG4YLqipW3RgDBt0mAvgq6QSHIoV9xrIVNYW2L
         8L9STi9JFJ1F+zZt8IwSoKBDZjWiZxUXlIhKy39ShkYclF66OJl0N1Cj9vvYw/GflHLj
         WdctLmQfTUPGHdbruxnInE2qVE6iiXgNZR0jmIVwlEHU9y8NV/uR0SiRImni8pLG6tzx
         jUxytQMIjRuizcAEOb7GYNLGbGcm0wSrNBFXacefyu91Yz8mVBQyvk7EvMNWlfQw7eG4
         DCY6gb2pWnMP8n1gvgzMqVYaeVTNN6KEa5YkBN6SkxEWkGVmX7o2xr2AQVmx5l00u1WH
         y9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ewWdgINeDogjbAxyhyHuxTCApDJunU7409v6MqwQtl4=;
        b=Y2sE69iT3WOduacC7StRYeHKRiHBjM6+lf9l5oPtCBIW5zxwtefQW/Gg2sm3sbRcwA
         ZcWy4GbDKia2m61IIqXDPRmqc4CqBx/8FEJsqiYti1LCkRXLguwtSGDT8Uyj87nQqfM3
         mcGmKtI69xVIVD9NK34qZPvdiRIP+NyuBECxIuGFgki7wIT78EeRwyxFrEWs1lrPN4IB
         qn1EUfEol0UtrgFru/8g1tINUR0durIcWXgrhLwk4W0V6drXyFpBuA5UN2mR6Hw7hE9d
         NYfjiOrDNgXyRAkcAqGliqQbCceu6am/QhB46nwn7gYzHS89oSM0b/wSrhfyoJrhpSSo
         FCRw==
X-Gm-Message-State: ACgBeo3Dm+VOZOMhdbvXpaji64wjwygC/oT1JSrEN30NEMTfe33EHtFe
        a+xnZFO8ReWuyaAF4tF8DYbW7l2VIv8=
X-Google-Smtp-Source: AA6agR68CyNVpRLHSBlnpUfiBmJcUIwCEK6gjrfDIY0tf99tXjQ2T0GT1YLes/L4MAc64eO7TvO8Sg==
X-Received: by 2002:a5d:4c4c:0:b0:22a:35bd:84a9 with SMTP id n12-20020a5d4c4c000000b0022a35bd84a9mr3896044wrt.103.1662734019457;
        Fri, 09 Sep 2022 07:33:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0022587413219sm706303wrh.16.2022.09.09.07.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:38 -0700 (PDT)
Message-Id: <2ca431e6c377f42d70ea9ce0ac74058fc983ea2c.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:27 +0000
Subject: [PATCH v2 1/9] bundle-uri: short-circuit capability parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When parsing the capability lines from the 'git remote-https' process,
we can stop reading the lines once we notice the 'get' capability.

Reported-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4a8cc74ed05..7173ed065e9 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -56,8 +56,10 @@ static int download_https_uri_to_file(const char *file, const char *uri)
 	while (!strbuf_getline(&line, child_out)) {
 		if (!line.len)
 			break;
-		if (!strcmp(line.buf, "get"))
+		if (!strcmp(line.buf, "get")) {
 			found_get = 1;
+			break;
+		}
 	}
 	strbuf_release(&line);
 
-- 
gitgitgadget

