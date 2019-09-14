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
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5961F463
	for <e@80x24.org>; Sat, 14 Sep 2019 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfINJSu (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 05:18:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35320 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfINJSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 05:18:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q22so24702600ljj.2
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ss5vy8RCU4V/W4z0W8awGhphA9OMZdSkV8/LTKscrXU=;
        b=WuwBg67ov16LCEyeLizyJcr7pIzD8yNmArbsebsW6XWcOls1A6bOie69Rt98eG23ha
         gGqM/lPFW1/8yzF+51J+MFNcRSrR3qI+BPMJI9M0icp7xRw/NvwAF1Id25pmTvzR/SRF
         0hBzOYwCBjOhaP56Y1uCjwzags7cXAwtZ34XekhlJ7z4fw/N5/HZYUfoQZdLkY2sKYss
         Vqh7sQCUQaLptz0J0pB/QOukrWRTxVG5gER2vOvPy//aTQX2KYp0O2JUi0LyRzdG73ao
         AFt7StQALGQuJDFb3VAfJeBwl16FMBXWFf66UcR20qFHD7d4R20RfDnDcO23y6iqAUlm
         L3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ss5vy8RCU4V/W4z0W8awGhphA9OMZdSkV8/LTKscrXU=;
        b=Pu1gXef5AWnHT6OFoXVaSoCTinkeGGe1nBm2w9vG5+zhD2x5PUQit+HbCirjcf1xW1
         pCS4KHAKtWc7k/26l3la5ZqZHoRf0fxvoZEU7jVfPu0MqCsC08f4iZLnfpKJhGBk/yAK
         0tLU+VOuVlaAhs5LCipVkH9hEaAefWG9L4lD3shngOD+z4vATU+Pd25Lq7XznaqSPOCN
         vD/ez/VQfwbLNPISFQJcM7ssZg+EztSOYuyIrCOphWvu+OpLWrNikS71VKl7d1nudFNu
         atcSr1HZ1+vl5BibIiN4Xnj5Q+PWLSST+QuMOgVGp/552zHGkYvEijfGCr6vFS6iAg6o
         uj7g==
X-Gm-Message-State: APjAAAWABEWqxkA7HUZ1Q1WPmluFfY79xbOq2H1s7dYuhPIryjtzzkQP
        dyZaY3vZA6ChQ9wxNKb4YUlabAgttLYDHQ==
X-Google-Smtp-Source: APXvYqx0rcPGoWm9Yaj2Po1UwXnqRAZuAVoFS1PBp5YHbjcerid1GmphgkpToRJRgPWMn8ZLDS24QA==
X-Received: by 2002:a2e:8012:: with SMTP id j18mr32744034ljg.36.1568452728070;
        Sat, 14 Sep 2019 02:18:48 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id f22sm7518007lfa.41.2019.09.14.02.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 02:18:47 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v5] git-gui: add hotkey to toggle "Amend Last Commit"
Date:   Sat, 14 Sep 2019 11:18:35 +0200
Message-Id: <20190914091835.11236-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CAGr--=LmC2VwGCdfRuv_G2mXTt2H8XMDGsLnHU_2oHGhvbdNsg@mail.gmail.com>
References: <CAGr--=LmC2VwGCdfRuv_G2mXTt2H8XMDGsLnHU_2oHGhvbdNsg@mail.gmail.com>
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
 git-gui.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index c7d9103..790adf1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2664,6 +2664,12 @@ proc focus_widget {widget} {
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
@@ -3892,6 +3898,8 @@ bind .   <$M1B-Key-j> do_revert_selection
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

