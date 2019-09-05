Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249881F461
	for <e@80x24.org>; Thu,  5 Sep 2019 20:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfIEUJ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 16:09:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbfIEUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 16:09:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so4205826wrd.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VV7/mU0INXPaBJmRx19QMqJNm9YJO7+7DCgSHJ697FU=;
        b=h44ncltztTOKD3C+YbHpiMqCZrn6nr4K/oWR+ZIf0mf8KFMSTnI/wNgaskhb5F7ifk
         RsXPL3xjvSmcrmF0dECrQiz74ZH7ja/XM52IMornZ9OkKaJo9gf1oRC5RWsO1sH5WDRk
         9U/FQIwLmBAhKg2oPStVxS5XfEaGgHsf5SKPmOeynzD4b9XVQ0VOxvwVVTjCgdpcaI09
         O2dazfNj63LZ/nHfJLO8/FTMlfnbnErkJ4us0NFkjZfPnl487jSHTKyqwZMLl32pS4Uf
         Fr38LuXVBVeta/RnSCsH8FOLSJ8qs7MK/3xdeQphNYXQlRotsndVFlQe6y9ATs9BUkR8
         g0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VV7/mU0INXPaBJmRx19QMqJNm9YJO7+7DCgSHJ697FU=;
        b=CRJ2Zwo/kndmH8/ub1hxjV2EHnJZNksXcWLUF5SRvHeSRdnEA+ih54omyfxAXASqBL
         tWnNAVXt/Ok6qWvKg9v77OX1WDEMyKio5GJjtfGWJBEQDsbvtUM9xc0uCec21bDyTk5U
         +gIWIirPl6HEYxn8pbFLzIqsi4zLOLEW/wq5gSXUHi38Nq6V1Ee18ojnjin0TuL7C41C
         8GFZ598uHFbxnMdUW6LLS3WkR8fU2saX7gh5ZZwZgjqUxCoWKj3SsnvkxhY//oZwpfrj
         tuYVo29SJWv+4T7mobDzoHC9cgt71X18JBkBNsQcl1TsScPcnXWSLqMCGJCibLn1UNjg
         QHKA==
X-Gm-Message-State: APjAAAV2uiELxen7owveVIXsURbRZH3gUzZRjhpMJpq+YQXn9psEaJQQ
        VAXGfXXtu8PEGMB6rWhTFw==
X-Google-Smtp-Source: APXvYqwlH9TdPOOvLDYVfnngDpMG2VgDZUidz4ec+EBj7tDmZlhK5qHPdg+yaeT35+LkEgTTNH/FQg==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr4273041wrs.151.1567714196272;
        Thu, 05 Sep 2019 13:09:56 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:dd24:86d0:1477:aa12])
        by smtp.gmail.com with ESMTPSA id b1sm4083937wmj.4.2019.09.05.13.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 13:09:55 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit" check button/menu
Date:   Thu,  5 Sep 2019 22:09:53 +0200
Message-Id: <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
In-Reply-To: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Birger Skogeng Pedersen <birger.sp@gmail.com>

Selecting whether to "Amend Last Commit" or not does not have a hotkey.

With this patch, the user may toggle between the two options with
CTRL/CMD+e.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
Rebased-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 80a07d5..8b776dd 100755
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
 		.mbar.commit add checkbutton \
 			-label [mc "Amend Last Commit"] \
+			-accelerator $M1T-E \
 			-variable commit_type_is_amend \
 			-command do_select_commit_type
 		lappend disable_on_lock \
@@ -3825,6 +3832,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
 bind .   <$M1B-Key-plus> {show_more_context;break}
 bind .   <$M1B-Key-KP_Add> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
+bind .   <$M1B-Key-e> toggle_commit_type
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
 	bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
-- 
2.21.0.789.ga095d9d866

