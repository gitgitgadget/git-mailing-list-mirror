Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789ABC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbiC3FIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbiC3FHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DC768332
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so27543959wrd.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/dJLnMNPf593DDA+ox52qw4qYfm4mKhrA2SM6fu1eys=;
        b=I9YpkH5faX8/V+akBN1uC2UV72NHOvnYSftgPDgUvHe4Sfh0+Z88nW0svaz43DpZ31
         OTONCfp5O55I2ckAL6GaZn4IOc0O8VaZ8/OoO0Q7pU9Ns/NeH13EzHHl60hPy5+FEhz5
         LMoEjs+0vmCSPfYDEEbD6Lb2VJENggFPunlQTEXVML7KANHwd3e3xEFvgIzgCE8AfVtg
         3GcsobXuoW2Y/zlNdVlaY7jepkb8PCGVTcags9mvc6tzRbroOp2SKZ+i/2RrXKm38tYU
         Qs8TnMHeDP6h45v1lqAOxzPeq1PbbLtsvzQzF/m+g/PaYMV9UnF+pZd+S2PE9OYjr2lU
         Y7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/dJLnMNPf593DDA+ox52qw4qYfm4mKhrA2SM6fu1eys=;
        b=B/Rcd9CmUYFXCUub927e32zgZoGZJKde6vlMfdTMqjqd1E9RYMgYp6k1E6z/PaJbrg
         7ipPlDl5dqVFkW/zfBwHqU64NiQNZFYKPNVYArd8kElMTuYLFi17IikpK1vgBN5hiUS0
         Ue6n3+iLge37fs9c5AArVh2jX9bKLwvpvuMz7ucFCPvetWrH0DnBKb0SZX9odIJW6vdr
         zVgxXogohrc8Uxqbh34lm86E3XCXxwBpSX4li3bUqYQFGp1OmlJ0rUMbXsPNtYnhbD8o
         mSnMMzuEFInG9mzrFhzHvlnqwac4RMVL2IAsVYjhG5/I0OwEoJFT1ANWOHPFBiYEnBuL
         H0fQ==
X-Gm-Message-State: AOAM531VJfeZTR1OLeOTJi4RvgS3fDP4yQ8plnv63qdG2jlkwuuX+G7O
        MB8V6tnMLDtNkTz2KpnsIzBjlsbu+Gc=
X-Google-Smtp-Source: ABdhPJzbNfjZMA8s65SOAfcx+AXxoUE1ZgYdvy2XWUH/2XYSG62HKRQoRceFbjXk34v4UikfDGEa7Q==
X-Received: by 2002:a5d:6208:0:b0:203:dde4:c76e with SMTP id y8-20020a5d6208000000b00203dde4c76emr34897214wru.273.1648616749538;
        Tue, 29 Mar 2022 22:05:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm15357101wri.106.2022.03.29.22.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:49 -0700 (PDT)
Message-Id: <88c1f84d4c3f71bb3cbd6e016771196a56f90bd9.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:32 +0000
Subject: [PATCH v5 14/14] core.fsyncmethod: correctly camel-case warning
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
