Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0401F463
	for <e@80x24.org>; Fri, 13 Sep 2019 21:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbfIMVMx (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 17:12:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33146 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbfIMVMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 17:12:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id d10so23148596lfi.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0iiBfw1LS4x8/ALg7UcBqHaxr3ejNsOkfoTy8xfGRs=;
        b=VpGuTc/C27PGLsMWwzV/nQ2WJdRNXf0KghC96nOoIFM4mx8HI11wSf0P6hZJ1s43bX
         bnRt522USStfyZHOKkwEpZJzsxfRXAuW0QDN30+auonkkbGiEOV/x+JJb7wr3o4bLLuJ
         lPLdAJPKg+Ldc0rN+jN37eP7wtktz6KSyj0HZdacHpvCF7SIl132BFnk5Q8cGIKB9DWY
         QoIBdUoWp50e5Dcsao08iiqIk9vcnYMVNjg5HVkWFve0tEiy8/Oklti6C69OGCN3jhOh
         g/qWTInZO4MMDx+CZJ/IGKdIRbjR/NrNJv9746ZmJ6oaJXmdrPxIUQeswfJZSeCXx1M0
         mUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0iiBfw1LS4x8/ALg7UcBqHaxr3ejNsOkfoTy8xfGRs=;
        b=kzjc2k9caaqLEoUWKPxTdHkBV/Fv/yivzrQ4MreUvN5DUi6f3TaPejqr/uwaJqL6WJ
         zSLNwjY3YUOj3jQpp+Hw5MeKkW0dkPnM7vJjAgrnlhBKe3hRFp7emnm/PtyZTO4D0ABP
         LFKRs61c9x2HcEzOmoEgh2yS4tWDdmzh0fQfpEY1+56oBhIZx1PerPbPAvhN60oJqLvN
         eiARR3Rn3t+LfAGpRFOQiFi4Z9KKP4X9nFxwlqZbH3RA6QleVVwP+NMNKsXMFxkz543o
         dLDpPh25zwwkZibsELlACYZ+zu3IOmX10sdyya4qQw1V784Wbl+IJbES+2rB66S01lDv
         7YCA==
X-Gm-Message-State: APjAAAUoxruc7Apz58PLymh9P1AsEZp5t0K1bB/43pEE95eLHuRLCL/d
        Kg0Z11yVPP1mqcEMxsywgz5jZ6tjnDk2rg==
X-Google-Smtp-Source: APXvYqykC/Au3BrCVKGzj8N82bz5GBcXpQZKeIGNuTB3L0RQ+NW3JOSuTSOsJ07uggrCdFp00cJrLg==
X-Received: by 2002:a19:7715:: with SMTP id s21mr31100412lfc.98.1568409171462;
        Fri, 13 Sep 2019 14:12:51 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id l7sm5508lji.46.2019.09.13.14.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 14:12:51 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v4] git-gui: add hotkey to toggle "Amend Last Commit"
Date:   Fri, 13 Sep 2019 23:11:52 +0200
Message-Id: <20190913211152.8860-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190913143740.5zkrclivsvyj6k2o@yadavpratyush.com>
References: <20190913143740.5zkrclivsvyj6k2o@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Selecting whether to "Amend Last Commit" or not does not have a hotkey.

With this patch, the user may toggle between the two options with
CTRL/CMD+e.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
Rebased-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..d6e4631 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2640,6 +2640,12 @@ proc show_less_context {} {
 	}
 }
 
+proc toggle_commit_type {} {
+	global commit_type_is_amend
+	set commit_type_is_amend [expr !$commit_type_is_amend]
+	do_select_commit_type
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -2830,6 +2836,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	if {![is_enabled nocommit]} {
 		.mbar.commit add radiobutton \
 			-label [mc "New Commit"] \
+			-accelerator $M1T-E \
 			-command do_select_commit_type \
 			-variable selected_commit_type \
 			-value new
@@ -3837,6 +3844,8 @@ bind .   <$M1B-Key-j> do_revert_selection
 bind .   <$M1B-Key-J> do_revert_selection
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
+bind .   <$M1B-Key-e> toggle_commit_type
+bind .   <$M1B-Key-E> toggle_commit_type
 bind .   <$M1B-Key-minus> {show_less_context;break}
 bind .   <$M1B-Key-KP_Subtract> {show_less_context;break}
 bind .   <$M1B-Key-equal> {show_more_context;break}
-- 
2.21.0.windows.1

