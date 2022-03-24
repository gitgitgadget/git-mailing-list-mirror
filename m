Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E7C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346844AbiCXFAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345226AbiCXFAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723882DD6F
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t11so4943222wrm.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/dJLnMNPf593DDA+ox52qw4qYfm4mKhrA2SM6fu1eys=;
        b=KP4cHSFMBx+l9IVhPuUwBeNIKsyUNAfxdT5j2ZM4IR3Z1meDkaTYeMWbyKhJga9KNo
         5akPQi1q1ZWKrF12Ja43VPfQAOUSYhHS9dW1yba8uUdITr9yid+vasgUkf0+sYtr2IRe
         1z/fxtLUrB6FKNU3IN1RKSBlp02GKb6aTRn3tahXTk+rcLNJMl0V/N+BRPHYGTty9G0j
         sTdLTzTln3XMsJwbwPvbt5O2ijSe5iuwy+O9Xypnlr+NwY+w56mvXkuezZAF6dj50mAt
         lnMkPytHc18jx4TOTyVOCa0pmy1rZuNg41oos01lhvJlGcqqEY6NygEiofgVyp8ypIcU
         PWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/dJLnMNPf593DDA+ox52qw4qYfm4mKhrA2SM6fu1eys=;
        b=4L3AxOeFUOMf9lM8sclL5Vwj8wlIKxgLycV3c8qpjiJCZGRQQ0JmNfbmsN8UINmE/j
         RegKO7h5E6wWlSS4FIc1T2vpT6mLan8ixfcuttoJ/W7yXUFxn5KXgOqYK93f3v7eRJjU
         tvd+8RjN2F7OLaGLmaQ88feVvBMTQaG1XiyJijkDwx/VAs2xcFq/TwzebvVnMh6GrjZX
         Gf3G89V0dQQHG8jf79bjPooaX9SYyiPMGCmjEuRy5A/VD8hCs8gW9tXlNiiwEpJK17fj
         WeADIe5fsY73wFr4vhrvBQ7oL9HN7Uw9H+Vdqc9WgvENu3hP28HW/FxgWakOup3wEjbr
         zVXA==
X-Gm-Message-State: AOAM5308Bs/hEQNoMUXuRj7SqukuDWnpFnLw9/VW8m1M8p5REsZ7jwT3
        VNuOT6q/crLG6rFTyc4a/XEnkzYIGjg=
X-Google-Smtp-Source: ABdhPJxSVGPbdNW6nR6vanvQu8ggIBRIKI7rXxMDrWrfjr0OdQgqa7fjn34W5EFCy75gBt/DGky1UQ==
X-Received: by 2002:adf:a302:0:b0:1ed:bf30:40e3 with SMTP id c2-20020adfa302000000b001edbf3040e3mr2854332wrb.270.1648097924626;
        Wed, 23 Mar 2022 21:58:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm1109269wmc.25.2022.03.23.21.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:43 -0700 (PDT)
Message-Id: <6b832e89bc47f00af4bd186b71577409914970f7.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:26 +0000
Subject: [PATCH v3 11/11] core.fsyncmethod: correctly camel-case warning
 message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
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
