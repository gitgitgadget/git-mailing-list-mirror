Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F3C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiECKac (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiECKa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D8E84
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:26:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 129so9652676wmz.0
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yae+hIRcjXLrQt0lyKLvVSmPN1iLZsCTIpUH/JeqsHo=;
        b=a+exiVV5ZpeLrxX9RdHKXMmfzev0i5MyTPQFY+ifrfk3o2MzlWElih1zEOgN6Fzt5S
         pvqnwSnYY3JPHYgyxtbRM5dftmW5iSecuaUwGEhk87HD44ENwslTMlcW+pJuPTUZeGfB
         Jl0TgcV7sorFPxUFR11FnyCs79njLGw/AF2ex5X+7ng4XItQ2rCjk/gxpkCJk3jt1u2k
         Kf77wDncogW/jBxDggtGO8PkRGFpsqNEmfnTROhkT7WolW1PT9NxNFgEh8RobmDqIZr0
         wMM6tdNqxhyw/L++vW7z2intURmRYFHTGQ2PipVX9XeqR3gCB8ThIykt769+o58oJ4rY
         QWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yae+hIRcjXLrQt0lyKLvVSmPN1iLZsCTIpUH/JeqsHo=;
        b=0Z6+i8diicAnAIAwz5Gbb/l49pQypBmB5Ed+/c+dhz6cNlM40UaZ7RCRvvQG7ORTnc
         0l9o/rUJlqq4S6EAzQoh1fN0ilo7T8gOI96x90AKmb70Yi74Qdvl6ZvQ3DdNfdJFvG7N
         My3w2x+JZOp6HwJrUc3D/dRqVcpC7Q929yWlIf+Ywskr/dI8/PyaVTbF31KWxlDkIJYk
         Y3kaUNUhrH3twM1OVEkigbuDuqc93p8Iye2zc3KvIeL5jBJdx5InDBlUvZsQWKxvZ6Bl
         p1T9qTGdT1I0UPIxOdt9cPH4uFaphWZ4qqj6RtTwPMO5taPOECD0V604PPJC4N819por
         NwFw==
X-Gm-Message-State: AOAM530eE0KgaioVht1H6YdcpIvRUFl35p5uZ7axOb3kBhplZoei4ZSp
        IdhuC0ZPaEmUZ8EpYHPOTwqsMgs9qJI=
X-Google-Smtp-Source: ABdhPJyOXI7fImY/EZ5vIKZ0QlhIKPcJJAwZuvA3uJn4YahxoBTnjx4TwBwsnowSxyVRXG5NMiuUBA==
X-Received: by 2002:a05:600c:3ca3:b0:392:990b:af11 with SMTP id bg35-20020a05600c3ca300b00392990baf11mr2716684wmb.173.1651573612973;
        Tue, 03 May 2022 03:26:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2-20020adfa182000000b0020c5253d915sm8999096wru.97.2022.05.03.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:52 -0700 (PDT)
Message-Id: <3c1ca34927a6634bcfaf444cf0712f74ac48311e.1651573607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:43 +0000
Subject: [PATCH v2 2/6] trace2 docs: "printf" is not an English word
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We append an ellipsis and enclose it in backticks to indicate that it is
a function elsewhere, let's also use that here.

While at it, ensure the same for `waitpid()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index adf867e1013..1f1a06eabc6 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -5,7 +5,7 @@ information to stderr or a file.  The Trace2 feature is inactive unless
 explicitly enabled by enabling one or more Trace2 Targets.
 
 The Trace2 API is intended to replace the existing (Trace1)
-printf-style tracing provided by the existing `GIT_TRACE` and
+`printf()`-style tracing provided by the existing `GIT_TRACE` and
 `GIT_TRACE_PERFORMANCE` facilities.  During initial implementation,
 Trace2 and Trace1 may operate in parallel.
 
@@ -34,7 +34,7 @@ Format details are given in a later section.
 
 === The Normal Format Target
 
-The normal format target is a traditional printf format and similar
+The normal format target is a traditional `printf()` format and similar
 to the GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
 environment variable or the `trace2.normalTarget` system or global
 config setting.
@@ -234,7 +234,7 @@ Events are written as lines of the form:
 	is the event name.
 
 `<event-message>`::
-	is a free-form printf message intended for human consumption.
+	is a free-form `printf()` message intended for human consumption.
 +
 Note that this may contain embedded LF or CRLF characters that are
 not escaped, so the event may spill across multiple lines.
@@ -300,7 +300,7 @@ This field is in anticipation of in-proc submodules in the future.
 	indicate a broad category, such as "index" or "status".
 
 `<perf-event-message>`::
-	is a free-form printf message intended for human consumption.
+	is a free-form `printf()` message intended for human consumption.
 
 ------------
 15:33:33.532712 wt-status.c:2310                  | d0 | main                     | region_enter | r1  |  0.126064 |           | status     | label:print
@@ -588,7 +588,7 @@ with "?".
 
 `"child_exit"`::
 	This event is generated after the current process has returned
-	from the waitpid() and collected the exit information from the
+	from the `waitpid()` and collected the exit information from the
 	child.
 +
 ------------
@@ -609,7 +609,7 @@ process may be a shell script which doesn't have a session-id.)
 +
 Note that the `t_rel` field contains the observed run time in seconds
 for the child process (starting before the fork/exec/spawn and
-stopping after the waitpid() and includes OS process creation overhead).
+stopping after the `waitpid()` and includes OS process creation overhead).
 So this time will be slightly larger than the atexit time reported by
 the child process itself.
 
-- 
gitgitgadget

