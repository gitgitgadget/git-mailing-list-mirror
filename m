Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D4C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbiCJNgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiCJNgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:36:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67814E97B
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t11so7995145wrm.5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J7U5T8h62SL5kf6xL7rgmnc8pWVeQiTCqeaqExiGVPw=;
        b=f8tXhHHonqIbILWtNED25vNGSBGndwMPLgwIyXm6Qpakajxepg/m2fbhLh92vzjobt
         kNygQCIPS/WVk4IbjQ56MQAGktyTUjXTw6DbOmfzrWeiD7sI6BCdAkzqowIgViqvz6+v
         +FC+3zeXDYn0lvPVC5Ar+3wKqclDJhAyU6mjrWgjV6OSwlAmCVy43ZvRgSEruVbRmPzW
         9LUpbMYSS4KxzQDNq/YklYUeqOjse36a2QE5nNPuBlqSqvdIv8bMyiCRaGWNiN+PlstI
         /DZVbzR6FvByMEAMC1M/ybuZg6FKKYPMNiMrX/oPhqojWYRUKmA/TfSQDaJIT3MI5tVT
         mptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J7U5T8h62SL5kf6xL7rgmnc8pWVeQiTCqeaqExiGVPw=;
        b=MoRZ0GlyBA6oEI4YYCUPV9eZvHfzdcm+HhvkmgvyOAt77+C/XO+0y4QY5W+6Se8HI2
         xn4mZEhWNaaYb+xN476ZcUsXgcc+1AupiV8bY1OTI2Ne03MQEbDuXy6tT58ySCFqbPe5
         TGLIM4G8/z/L4XWgtO5eT9zHSJudY6cOS8hzBJVbjuumFBSOTZKfX+iSzkAYhp3Y4ILQ
         MjGVkCYd9seyWhDX33rXzzw+ICJIU0v8/Ohuv8tp3bfSOm8cK4QqF0hd/110P01uLOEo
         J9D2eFvaCpQEKNU6P1opAphiJOGrqtDSJBKk5F4zwAjjBz58NJqT0vjURij6HdNCsjAO
         mH7w==
X-Gm-Message-State: AOAM531QgYm8xKqgk8gaMzU+gZwUYXF2BQCtDqHQb1dj3uyuEh7uSBCf
        BNTtuZQiX/JKJRsrCrz6dsPkSveRvFY=
X-Google-Smtp-Source: ABdhPJwwAM16/UL7y/L9hopA9LCk+56IMUFfda/4isz5JkoRWKVZZC7dKBEnnWgBfUgj4oNyTQW61A==
X-Received: by 2002:a5d:5342:0:b0:1ef:7f26:df46 with SMTP id t2-20020a5d5342000000b001ef7f26df46mr3545218wrv.600.1646919336543;
        Thu, 10 Mar 2022 05:35:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020adff8cd000000b001f03439743fsm4249670wrq.75.2022.03.10.05.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:35:36 -0800 (PST)
Message-Id: <2eecea50e5132b09574451f37ca76a5d4af8697f.1646919331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 13:35:31 +0000
Subject: [PATCH 4/4] trace2 docs: clarify what `varargs` is all about
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 285f713ed84..91985512867 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -170,7 +170,7 @@ Some functions have a `_va_fl()` suffix to indicate that they also
 take a `va_list` argument.
 
 Some functions have a `_printf_fl()` suffix to indicate that they also
-take a varargs argument.
+take a `printf()` style format with a variable number of arguments.
 
 There are CPP wrapper macros and `#ifdef`s to hide most of these details.
 See `trace2.h` for more details.  The following discussion will only
-- 
gitgitgadget
