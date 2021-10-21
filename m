Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C4C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593EA6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhJUO2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJUO1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4460C061224
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so913399wrg.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yX37N4xGrkUrCXyal2nEu6KGGgh5b5JsekoBrlh4mEo=;
        b=iuWYh2TuALnMD09xiC0ZZNafk63/NB0oBegFRyFYyuwmcjULv6vsyyDB9hWKY99Rdz
         0ljNfelPJPXn5CJfGd+kshzQNGWcbFym8EYwaP7xELHw4/LF3kdOSrYpTWbJ/3hQsh7y
         5l8fUkhiiC5BjF3Fj7o+xoH22+q5aXlgjz9wL2idO86/xIpLw4bbZWg91z45P5lP/0/8
         a+LfMaqbjyuDHn3yYqeDcRnPPwi5bwUz6sAi4vpQGniVeUCWO7GPSZscB38fgvXZBNkr
         8hgnnW/RbLDUiUqK9Zu4DWDhFwaBS7pKnrwypczleHPLRrHIGSmQuSi/fu2FjhE0cScm
         YwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yX37N4xGrkUrCXyal2nEu6KGGgh5b5JsekoBrlh4mEo=;
        b=RHd2nmOE578VvpukTmMctp+BngGxPFo+9VIy79jwT3G2CUMjNvmCV7pmdxRyneaSCH
         RgWRoAqiItdQfHEDJGjggNwtRxzCdKTvek0It/+I3wHLvQDWWHsHKcCb2iYU3fP/auCj
         RlzgYWXBQMY5AWkH2lDicmglBKYMzmGYYqHoDJgS2oBNBzddTXTje8pm+WmhaqITjbqO
         IKqa4Kzw0FD7Tp38jEzj5R87TCQBIonrCorLrUIgZpcTeASb4YdZ7w0rDk/PraijHx52
         JSxGfV/3URrY92pfPhxjjXT4v+O1eQtdg1tYTm8ZfwKJQI3bRpYk5CTryaTPRgmsP9YI
         TOSQ==
X-Gm-Message-State: AOAM533sOCpxH0kmZlUMdHTHItmBHidGyJLKQzkhrut8Ysujp3432U2U
        AboJZnKlEydNsHNqGKUkpgMJsphtKic=
X-Google-Smtp-Source: ABdhPJx3+LUNvutGRejeqEKn0TsYqLFKuecIQhcOIC4ONgpaRsxYizbOSk3dPxx3rCxqPmAbDX31rQ==
X-Received: by 2002:adf:c78d:: with SMTP id l13mr7438447wrg.134.1634826325552;
        Thu, 21 Oct 2021 07:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm5044837wrr.15.2021.10.21.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:25 -0700 (PDT)
Message-Id: <1c2eccacff64edc0aba1d60a120f71cb94532e8b.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:04 +0000
Subject: [PATCH v4 24/29] t/perf/p7519: speed up test on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
to touch thousands of files.  This takes minutes off of test runs
on Windows because of process creation overhead.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5eb5044a103..171644ffc90 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -98,6 +98,13 @@ trace_stop() {
 	fi
 }
 
+touch_files() {
+	n=$1
+	d="$n"_files
+
+	(cd $d ; test_seq 1 $n | xargs touch )
+}
+
 test_expect_success "one time repo setup" '
 	# set untrackedCache depending on the environment
 	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
@@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
+	touch_files 1 &&
+	touch_files 10 &&
+	touch_files 100 &&
+	touch_files 1000 &&
+	touch_files 10000 &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
 	git commit -qm "Add files" &&
 
@@ -199,15 +207,15 @@ test_fsmonitor_suite() {
 
 	# Update the mtimes on upto 100k files to make status think
 	# that they are dirty.  For simplicity, omit any files with
-	# LFs (i.e. anything that ls-files thinks it needs to dquote).
-	# Then fully backslash-quote the paths to capture any
-	# whitespace so that they pass thru xargs properly.
+	# LFs (i.e. anything that ls-files thinks it needs to dquote)
+	# and any files with whitespace so that they pass thru xargs
+	# properly.
 	#
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
 		git ls-files | \
 			head -100000 | \
 			grep -v \" | \
-			sed '\''s/\(.\)/\\\1/g'\'' | \
+			egrep -v " ." | \
 			xargs test-tool chmtime -300 &&
 		git status
 	'
-- 
gitgitgadget

