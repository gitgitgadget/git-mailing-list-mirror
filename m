Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF22D2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdBWXtI (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:08 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34026 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f42.google.com with SMTP id 1so2733394pgi.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i91viRoTYX7Vn6quQZUaVAOmaqWVCX/B6wZMuT30uRE=;
        b=g/ERKFYOte6CsHml+SMgJPb5Rc3Yx/vw+jpg47WNoTmtcmv3yvPd222rd889vmiQTu
         aWwY2CVZg6Y7fLCwr2mdXPgAP45YPnS1DNU+OSnin3VcScDMdsRlyVPaX2ErVvqaMiLY
         CKKzo0anbFIjGLbXKPeZVOWP8kixeW/ltwFENyMKVC7UO95tjh+jaVd+lFqjQH71rvtK
         O1wWlA7FdjPb8mQfySB8iEZLNPLmZKsFEHUvvPaMa/8KzpqiBnJ02QyQba/VoG1C+Ons
         5JmUW2z4dbjtC56IPwSzbXeH31U/zCkCSVbYpal4DKX+Mkq4nG416PCH14xvcTGN1L0A
         GE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i91viRoTYX7Vn6quQZUaVAOmaqWVCX/B6wZMuT30uRE=;
        b=TSsvCACUj5wjEyvwr01PU91JBkP/KEr5BNQq3nSeOw8nI/Ov2jF9DRtRus/vDbWnn3
         jU2hTQdxomS6PXd3OAT0X72o8RdK9aMf5xdAhOeSHDSlwaJHnzkWxYUhqlBTNSLN0M5z
         zHfSXlBJwbQ+ZWv4oAN479YxeLnQSFmLYCwAUYd7X8T/FFyDGVk78fYFdRGLVTW7Ifzf
         s78YI4FbKqRMPVg/2caS0j6np3jKcxuTc+zJ0oa0RO5kOdVeWVeBaqY9pHGYP4SGjBoM
         BmG4iPzRKJ+lZxt3RPA4z0yfTZxObgVC/ROw/3wGGT+swbkWN4XoGbpHYdLayd8UAw7J
         kB6g==
X-Gm-Message-State: AMke39njrRdVn1ayBuHVaT/5tT3BItyi47AlkroBesgaIIEbZOg3soZZSFFDyCWos85/QvUN
X-Received: by 10.98.214.156 with SMTP id a28mr5201848pfl.40.1487893664771;
        Thu, 23 Feb 2017 15:47:44 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:43 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/10] completion: clone can initialize specific submodules
Date:   Thu, 23 Feb 2017 15:47:22 -0800
Message-Id: <20170223234728.164111-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6721ff80f..4e473aa90 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1138,6 +1138,7 @@ _git_clone ()
 			--single-branch
 			--branch
 			--recurse-submodules
+			--submodule-spec
 			"
 		return
 		;;
-- 
2.11.0.483.g087da7b7c-goog

