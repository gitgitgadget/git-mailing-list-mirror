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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5F31F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfILTUw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:20:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40243 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfILTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:20:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so6914785wru.7
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BdkdGSGpgYSJHNdvd9LKF7DOSnrQahjBcS9/x/ilOk=;
        b=XJp1K0VxjuyJBMfLJfXrbewpjjmGdISnlkeKncHfeAc3JIqR6TeStI640Wmq1Wgq4S
         fb1Fo/DWGi6Inq7oK4gjkdpg0KE3qwZtbF3i3td4Ia6l1BIMQ3ABiLs7ZD7b/3s7hIO4
         9Qhwb5Re1vY94C/feobwtftjKqdIdE0WV708YtDzvnXSEkePHqhlX2aFshxWjuB88KfS
         G/j+WHcI85eYHu5eqAX8kWBYeW/Kj6XahykWHQN2qBkHW0Ww/MLQfr3z/mAmiskMfLqC
         tZ32PT380bMua7D3I3CuZqNRxCzwOzyt3PzT3dVjwSeMP2j9GNhZ8iZslUk5g4Kgd+SS
         ZrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BdkdGSGpgYSJHNdvd9LKF7DOSnrQahjBcS9/x/ilOk=;
        b=tNwhwMDWf5+x37QCnO06Cm/rI0GQRr+zroJwkPMHYtVifkFpP4JNCE/dl9rx+7Woy0
         J3heIRFOzFXp96jcdKkXWmpaHb0KOnvCynJYH+7kajPXHlOH5VezMlOcMVEyT1s23hxE
         lf0jVqRLUaAgLKErHt3jK+ZJ0lLenw4W7ev8zGaFT3VQpiuIkWb/IXSSFjsxX8IOimkW
         nRqUdRyei44Xr06PvzaDmslmJIK4cgGBrKsVSRKlmJRyS//Yvisw7OhJnl06HCQKUod5
         WVnY2rptQJdVL8ZEz77S1MAFD+722DnI9vPyyAphCzniY/y/TiwRiMJ244+HvEuG8+7B
         5Wcg==
X-Gm-Message-State: APjAAAWHntOQXdcv8YeGwuL7FkbSwdnL3T+I6Q9UwdrNNV5hOJfh7egn
        srJRH4IiqV9j4CHoL4Fl2w==
X-Google-Smtp-Source: APXvYqx+vKokyXhpOkPDxQlwgE7Z9B9uIaOek+vJe/DvTFS2Z7cCAY+afyzFO6rSMEles6VVxtk5mA==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr35993014wrw.53.1568316049150;
        Thu, 12 Sep 2019 12:20:49 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id y12sm17061473wrn.74.2019.09.12.12.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Sep 2019 12:20:48 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH] git-gui: add horizontal scrollbar to commit buffer
Date:   Thu, 12 Sep 2019 21:20:47 +0200
Message-Id: <f9bf70bfae825228a7afee705babc1915b579072.1568315704.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the commit message widget has a configurable fixed width, it
nevertheless allowed to write commit messages which exceeded this limit.
Though there is no visual clue, that there is scrolling going on. Now
there is a horizontal scrollbar.

There seems to be a bug in at least Tcl/Tk up to version 8.6.8, which
does not update the horizontal scrollbar if one removes the whole
content at once.

Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..032ebd6 100755
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

