Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03981F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfIDUK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:10:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36302 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIDUK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:10:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id p13so167615wmh.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAoHavd9gEhtsLp6Fd3abE1R+fYRNr0sGN7AF3r1X70=;
        b=LY3wVlX13hRXN+xoPAGTINlJrkGL/+xeGSefzQsIpnoNcd0d+VkRWTs0CLJYl6MYnz
         xW20XYkOr9y7UL1k4ftiQXbhmr1N+UMCS1GYDK4TvH2TzPGf38vNv+/g4wKwTgQ2euTV
         wq0sv2yUOhmFMwCiAnKRT8WWnNwW1W78FbjDnCPS3FHZc6axu3cx5npL5WlU2QUF9ukL
         sjOTRtB5f2I16GdXotIxVAT0JeoP/UoWAJzLC6bHoZEPI3stBvBLC2VmQ2mKYh0/Bzux
         tooiY0tv6hNITwF6ZUbjsN4dcEODliMG/ClcfjociBVASm/B5ZOnRCR2I4MGBJztXqZM
         vUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAoHavd9gEhtsLp6Fd3abE1R+fYRNr0sGN7AF3r1X70=;
        b=kH2YNFzvvAYuFnHmVEj405ChWyYd/sD+8UonFZhs2sMXzMAwzcnoM3TDehietV+BZi
         Mh/GUw83Xegjpfg2MCOAuOe0O0xc4YjnDDNZLwKGcfdXZJDxZITLLpkF+DPayQpWjrW3
         IbROu/PCRwEiVfO4n9mw1hg0ddsOReUhVHaqmCsutFPoYxEH03teYLbFQPLYb73H/HmC
         kRMypISSwXOsJjR+MIGEz2Tt+4+kXwPyKiycIWwqwMr9hYaDE+obEBqCXN8+/rgkrNzc
         RGCBT4AfiL0S1q8wGY242aXYQXj9pTOxPO1U8PYjqj85yTTV+6I2c8pHS6sVE51zx3QQ
         zFSg==
X-Gm-Message-State: APjAAAX99SXw11rD1WNCXhm8rI18goCx3bcYbu/47O69DfKJL8KTQhHp
        0R7XHDFiM0Ct23Lj+hRCXA==
X-Google-Smtp-Source: APXvYqwvrG1SqKtz9smR64UZajEE/GNPg+Tp5nX5Q2hmZ3w7DDSpid6dH1Ew0morv8OgLi8WypQuSg==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr50765wmb.98.1567627825913;
        Wed, 04 Sep 2019 13:10:25 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:e18b:2076:d6e6:a85d])
        by smtp.gmail.com with ESMTPSA id u83sm5643695wme.0.2019.09.04.13.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 13:10:25 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] git-gui: add horizontal scrollbar to commit buffer
Date:   Wed,  4 Sep 2019 22:10:23 +0200
Message-Id: <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
In-Reply-To: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the commit message widget has a configurable fixed width, it
nevertheless allows to write commit messages which exceed this limit.
Though it does not show this content because there is not scrollbar for
this widget. No it is.

There seems to be a bug in at least up to Tcl/Tk 8.6.8, which does not
update the horizontal scrollbar if one removes the whole content at once.

Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index a491085..fa9c0d2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3363,14 +3363,20 @@ ttext $ui_comm -background white -foreground black \
 	-relief sunken \
 	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
 	-font font_diff \
+	-xscrollcommand {.vpane.lower.commarea.buffer.frame.sbx set} \
 	-yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
+${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sbx \
+	-orient horizontal \
+	-command [list $ui_comm xview]
 ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
+	-orient vertical \
 	-command [list $ui_comm yview]
 
+pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
 pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
-pack $ui_comm -side left -fill y
+pack $ui_comm -side left -fill both -expand 1
 pack .vpane.lower.commarea.buffer.header -side top -fill x
-pack .vpane.lower.commarea.buffer.frame -side left -fill y
+pack .vpane.lower.commarea.buffer.frame -side bottom -fill both -expand 1
 pack .vpane.lower.commarea.buffer -side left -fill y
 
 # -- Commit Message Buffer Context Menu
-- 
2.21.0.789.ga095d9d866

