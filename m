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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1031C1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfIBT43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:56:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38544 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBT43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:56:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id h3so6988533ljb.5
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/BIFVUVH1kthaQKvm8pelUnMmCxI2qo4mUom7cCOQo=;
        b=DrcUg3AwTTN77dN3BVtNXpVeKfZEO3Cszqv+avuINuLWHnVMb3Ai3u6rsID32lWp/L
         bMasVexO5rE80oFERINk1oRcHAkOPlOk2CyucUw4qHKcQE7Z3xbB1e2fuxcTCUaLqLEA
         CrFI8GCZdgpVztLiaZWr1MoEsLAUv7W0ZK7jibyis1gqGam7/cPiZ5J6490eeJJKV5yn
         L0bGwcKjl7FghP2bdgbvLUlJ2VvNaNV4FZMHkuLz3Og6Y1iEry7KrQQeErj0f4iuwB22
         ZEaoBKf6DdSjEnJqloYNZlxS0cqcOmKdeT4blrnCEbOPwrkeIZ9fpuVg3b1uFCpauB2Z
         JKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/BIFVUVH1kthaQKvm8pelUnMmCxI2qo4mUom7cCOQo=;
        b=ocK8HUQOlURYCC06d1JrbeJPKd6tzwkVUcShpO48otJjZS2gXocWH8KrO7tHt27da9
         VHUTwnti10ZGcepGcX94H0n/tBH6X6O4+FJROEFKeN3IeUCW2qcrp21Vg9VK4GARrRSr
         YW1vluGSLxVdpeEZDrLu7ZuIS3upn8VqZzWbUMu3sRGIqfRGPKxFv5l9H1wgTNNz3poG
         kNi3gDX6WAZa6vIQzTYxM8+mSo88G5SnCyb8Lf59XyDOuTInv2Oih8ObkunrDJzZvL2x
         zznn9SFlm7e3uDgXMMQ6xrAjLSjMn2pYn1lVxvpVmaj3VUH1rjkd8LgicZ+kIT5fcSiA
         trRA==
X-Gm-Message-State: APjAAAXtVaTSZLlkmflsPGrBEDC3Ui2LM5NQvZ8IN5wkpaTW/LAbQHJn
        YsDqL88swwTV0ridnbiTqFALfaMe0CCpcA==
X-Google-Smtp-Source: APXvYqxUoNw14B6UUqsz03JgmJzLRHnQ/qOX60Uag8u7STJUrDiKWckr7gfzXNyM8rmfIJuKiaoSGg==
X-Received: by 2002:a2e:90cc:: with SMTP id o12mr3657949ljg.74.1567454187428;
        Mon, 02 Sep 2019 12:56:27 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id b9sm2502645ljd.52.2019.09.02.12.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 12:56:26 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH] Add hotkey to toggle "Amend Last Commit" radio selector
Date:   Mon,  2 Sep 2019 21:56:18 +0200
Message-Id: <20190902195618.3820-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
References: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Selecting whether to do a "New Commit" or "Amend Last Commit" does not have
a hotkey.

With this patch, the user may toggle between the two options with
CTRL/CMD+e.

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
---
 git-gui.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..14be1e0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2640,6 +2640,16 @@ proc show_less_context {} {
 	}
 }
 
+proc toggle_commit_type {} {
+	global selected_commit_type
+	if {[string match amend* $selected_commit_type]} {
+		set selected_commit_type new
+	} else {
+		set selected_commit_type amend
+	}
+	do_select_commit_type
+}
+
 ######################################################################
 ##
 ## ui construction
@@ -3843,6 +3853,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
 bind .   <$M1B-Key-plus> {show_more_context;break}
 bind .   <$M1B-Key-KP_Add> {show_more_context;break}
 bind .   <$M1B-Key-Return> do_commit
+bind .   <$M1B-Key-e> toggle_commit_type
 foreach i [list $ui_index $ui_workdir] {
 	bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
 	bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
-- 
2.21.0.windows.1

