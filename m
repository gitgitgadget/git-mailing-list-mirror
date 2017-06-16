Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B3B20D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbdFPRjH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 13:39:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35493 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbdFPRjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 13:39:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id d64so6257352wmf.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lniPrj+iY6WhY3h2Yl1aw6SmdtZmWdL0fzz2w1RR+LY=;
        b=ije4wcXh3znHLrDWUuxBTIQ0qmICyNBjsO7DWBlkOxAMmWwp9lckEVfHm2ud1XHR+h
         UWZrBEnpV7Ov6RkZcfsIzgOjE8vx/6ogoR1EpVXkvR0GhaG+L2JyAr3qRzuK5u5ce7DJ
         9IiM2PaL8ZkXcaVPh7xpgCAVZGlPb59ejY21WX3yyspxqLhNOwdKxW11Mm8tAoXWtKtx
         sAQ5SI4dBLA2o37IH3fEBynPB60j5MI6tlMolv2BTpnUdrBafLmFYBkPNM+DW6fSCidX
         LgA/VsIqLyDKobzxP2esFhilh/J7QZzK4dz9mfOkfDrEzk+qsde5i2AwbBuy6a4vKBVk
         fEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lniPrj+iY6WhY3h2Yl1aw6SmdtZmWdL0fzz2w1RR+LY=;
        b=MM1E1TbXGU8rpJQDTouiDyH7vIFutZ+AIJDHkvhoplxYHXSHciIE/u2jHuWLhjnBqa
         mq5996qlRqVIdkPr4Wkqkj0GR8YRl7kZHn/JfJ9WX0+X99dneNetc9UceOzDPXhwR3Ra
         7gblehnyKPjVTjuiWV+4s5FoRnb5mJ4KMivU+tshSIhN1RuThLzKfk02KKkc7T0WiSk8
         ZwRjzoLBRfkxe1nDeEboO1vh++Y+yJt6d4Ve0+F0plOAdXbuIT+aWh7yigGQP0MvVe/B
         e2f4AQU6bAD8+o/gAbxoe6dOiZ+gPfZIT0C/FtIhfv4S31zWXiP3ggZogCq1++mzlj5V
         PabA==
X-Gm-Message-State: AKS2vOymlG4pRYyj1tTZDWLPADqRaWRagl+OCpLR0+PMU95ATAt9GzUe
        XRcSuN09tH5C+A==
X-Received: by 10.28.11.145 with SMTP id 139mr5028359wml.11.1497634744132;
        Fri, 16 Jun 2017 10:39:04 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id e14sm3785438wmi.16.2017.06.16.10.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 10:39:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv5 2/2] Documentation/clone: document ignored configuration variables
Date:   Fri, 16 Jun 2017 19:38:49 +0200
Message-Id: <20170616173849.8071-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.505.g7cc9fcafb
In-Reply-To: <20170616173849.8071-1-szeder.dev@gmail.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to limitations/bugs in the current implementation, some
configuration variables specified via 'git clone -c var=val' (or 'git
-c var=val clone') are ignored during the initial fetch and checkout.

Let the users know which configuration variables are known to be
ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
documentation of 'git clone -c'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-clone.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ec41d3d69..5ceccb258 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -186,6 +186,11 @@ objects from the source repository into a pack in the cloned repository.
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
 	additional fetch refspecs to the origin remote.
++
+Due to limitations if the current implementation, some configuration
+variables do not take effect until after the initial fetch and checkout.
+Configuration variables known to not take effect are:
+`remote.<name>.mirror` and `remote.<name>.tagOpt`.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-- 
2.13.1.505.g7cc9fcafb

