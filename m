Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DA21FBF4
	for <e@80x24.org>; Fri, 27 Oct 2017 23:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbdJ0X1N (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 19:27:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:54803 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbdJ0X1F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 19:27:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id l24so6341952pgu.11
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lvMCi0uifDsqUSyCK40YGsG49EMihDFxZAgty3tvICQ=;
        b=3NylfDWOAcR1JaBL6V/pQUsejtop3jrwCUo96G5U47p87x+xH1kI5Q+KWdT9pp8D56
         5Fgr88dEXHq5nDFr2nybXFFdXVtYDtO38RDK6Ah7aivCnL1T0Tkjtpd2l5Dn2LfjnIH0
         dK4YpPm/G08z0Y1evbIPFaNdIN3S+qGmt5X6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lvMCi0uifDsqUSyCK40YGsG49EMihDFxZAgty3tvICQ=;
        b=XsQJf76Bh8IYOOe5UZir8u0DUeVjsCCANFvhXEQQIlMgar2nzlOM/z4wldaYdIBkc5
         hYK+Nb78/A8tPACEI5x7v6yBocXwGw8D0XB8MBo4nTRiSxpTxYF9mOhbPlPIOIO5cMYH
         nejtMOMsJ90cXW/jU1O746KqKe1fPWGj6kSVYZSdnXnwPcmbMBSiFoEBjA9wnsGAStHy
         5JvQtd3wJCoA82BvTTsM9qcL9yXoOaAKQEHuDpHVtAXd+b5uvCbCQbpUdhHLejrSxM4O
         vx8268ZptjoyvJEd1DM0IumeSLY6tLVQ2wzseGlK2a90LEuojCH82ITUR46YLyNaKm79
         pxig==
X-Gm-Message-State: AMCzsaVIULzOoFyzuTAzv0sAT/PL3VTi3Kn9gv8ctrjaQR7Lf810eLMZ
        vqNJHDfwK10I2rPGsX/8DcJ1yex7nok=
X-Google-Smtp-Source: ABhQp+ThahsOEHCQAg86S3+b0nE+WAq0/qnqjSZeuMvzALnWGD6KGWCH/nVYcEiCdUDmV7SckvxTIw==
X-Received: by 10.84.240.70 with SMTP id h6mr1498150plt.109.1509146824328;
        Fri, 27 Oct 2017 16:27:04 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id i129sm15442806pgd.21.2017.10.27.16.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 16:27:03 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v3 3/4] fsmonitor: Document GIT_TRACE_FSMONITOR
Date:   Fri, 27 Oct 2017 16:26:36 -0700
Message-Id: <cdf4e3f3310d49751cea5317323e11597a66c966.1509146542.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171027232637.30395-1-alexmv@dropbox.com>
References: <20171027232637.30395-1-alexmv@dropbox.com>
In-Reply-To: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
References: <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 Documentation/git.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1fca63634..720db196e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -594,6 +594,10 @@ into it.
 Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
 
+`GIT_TRACE_FSMONITOR`::
+	Enables trace messages for the filesystem monitor extension.
+	See `GIT_TRACE` for available trace output options.
+
 `GIT_TRACE_PACK_ACCESS`::
 	Enables trace messages for all accesses to any packs. For each
 	access, the pack file name and an offset in the pack is
-- 
2.15.0.rc1.413.g76aedb451

