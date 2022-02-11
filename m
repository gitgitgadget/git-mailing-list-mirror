Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62608C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiBKU5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353545AbiBKU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59311D81
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so7993435wme.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q3goY1GdVlthOCI6hGoARgEhGFIoVa50Yt1nUcmE53k=;
        b=geqALb5JKzR61UJyGfGApaFzOCnU5mc3t9y6/SAv7L8/ewK4DnvRdzajJhSXUnPrKm
         3Nwne9IRAOOGV0Pndw6wAxp4oB6+iAxnJCj3VkiP7i1FmwmVC7Rlh059FNJwFZfaPvyS
         x0Ow2ij7Dkb0IFj8JyhZL9diLxRFydSiHpBQYPlop85XvO1aII4QlCfdwhWVlgTu2cQ7
         KF2ei0hxBclpMGEmN3pQ/BhDGGo32pyRFVidQVkPBD644yW9BpOaIB2P/WV3i/+t/9+P
         +kNsLR4kOyLwmSC38VUiCcFfRmt3/RtHR9zy5WlJZ/NOPt4iTChsQWfu1cN7NzeCpoLl
         XxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q3goY1GdVlthOCI6hGoARgEhGFIoVa50Yt1nUcmE53k=;
        b=xnP9tngY89VDhK7rjmdSfe36GE1IUBrko+3D5p2Uw0VlGlnSZzcSUeXJ2O2K54mAdU
         Jc7rhl+hQsoZbDT+CXu437JcspXANDvdjqT/ehQlosyA+r5DfIEUVv5Z4sd4ochg3ApE
         mcVUySEyo+oTeE9Ds7l0a1GDnSd5h2O28/BgSVH3P3fXJb4LJkjUGgjqfE63FAL6OFFm
         0YccQblxapyqX8zlf3xc0INpBnnNoSAcmVH3drdeFdTV7nDZBej15clFQKnj28OHgVBX
         Wh/GpavlusrY3Y1Z6GPeyMeZnLhCElRVJwIWAlrjAJN4ZRO5aNIuNNST/RjR6MjKqWqn
         aMNw==
X-Gm-Message-State: AOAM531hLo26VhsNoNfxdYSVqo8ZWJzEEcb6u8A4X9rIpSx4a2gSGHC1
        R1AoyNdnE3wlyRzYqI7/qgldESf6tuk=
X-Google-Smtp-Source: ABdhPJwv1YioMto8TJ/HS/G2t22jIZDY5Yo3HPK/l83xCRvq+RcNryyrK743uhV1ESThkTCtLqTF5g==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr1677311wmf.163.1644613001780;
        Fri, 11 Feb 2022 12:56:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm5807647wmj.32.2022.02.11.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:41 -0800 (PST)
Message-Id: <198f47bda5a03460532581a14528df52a3b90a83.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:14 +0000
Subject: [PATCH v5 25/30] t/perf/p7519: add fsmonitor--daemon test cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 054fc8d5d1d..9a2288a622d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -182,7 +182,10 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite () {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -293,4 +296,28 @@ test_expect_success "setup without fsmonitor" '
 test_fsmonitor_suite
 trace_stop
 
+#
+# Run a full set of perf tests using the built-in fsmonitor--daemon.
+# It does not use the Hook API, so it has a different setup.
+# Explicitly start the daemon here and before we start client commands
+# so that we can later add custom tracing.
+#
+if test_have_prereq FSMONITOR_DAEMON
+then
+	USE_FSMONITOR_DAEMON=t
+
+	trace_start fsmonitor--daemon--server
+	git fsmonitor--daemon start
+
+	trace_start fsmonitor--daemon--client
+
+	git config core.fsmonitor true
+	git update-index --fsmonitor
+
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget

