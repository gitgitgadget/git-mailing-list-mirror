Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A23E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeKOI0u (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 03:26:50 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40487 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOI0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 03:26:50 -0500
Received: by mail-wm1-f45.google.com with SMTP id q26so6133305wmf.5
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ylcPmI7byNB3OQW2WVyeHFtnQhw44ad+nkC4aSjInI=;
        b=NdMR7wzmJS+7D8rykz1IWM+SY937ujE8X6FxAq+CoG136U+FTToVSbnenOovNRpByU
         /nza2PIrlL+aZKybVoZLp0nFCcKoCXHmwgpW40X+fzrpszBrKS9mZsUYVsrZ1iiRrSfQ
         Nmi6JnX0SZFaa/OG/aPF7KXY/Q2mxVP5lG0PvQb4r4hNgmoKXa4rLVqUQKDNG1P9ra5m
         +h6Ffo5VqI28mVUKXOd8stGyZRfhQSLtCwYX3NFk9Vy1EVQ8HRAykOSZIunB4VAcw5EB
         4RtZTHs5WeqGhTkabY+GBPTh61AXRmB2AwIpWlmKmrJiMf3sHHo/T8QmPI4luEjtSzai
         D1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ylcPmI7byNB3OQW2WVyeHFtnQhw44ad+nkC4aSjInI=;
        b=D0Df0TW7TQkUZNDo6IW1DT7RfS27bUxvpH+D4cGLQtHYoavh7Lenib5Hj4VP/tTNto
         /c640EW2d8PauJgCNTRivV3lXx7M9dkq5ExUKIIEoJWNKJHVJohCqdR5KkZhxoMWTRh0
         kX3UM2vi1+i4ev9fD41q5/V2Bf3IORjbsQB2RmPN86rrjWq14duKGFXO0I3tGCGIxUKv
         URBoPlje03rssrQsUxg+myLrgSiCLKKmsu1wRr5UEwGNhhvsyxNuFRhQMbdEDyHpsps/
         e+L/UsYgs0BY2S8JEdNbCAwM8DGHGo81YBE4pTvicezHu7aK4UCFOkh1mSbgWaoa/FXG
         1JRQ==
X-Gm-Message-State: AGRZ1gLTgG6P8nDzu7g8f1ylG+pgM7YqQgfebH3IK+VEzHpLtSj+vQTE
        OET6364nnB4TYWwqLUuDkBo=
X-Google-Smtp-Source: AJdET5dk7RmsJre3BU7eUbfTOeWZFueAJk0OHGsCLGm034Ds3L0OpVnTYJGOEGVqSyabAj7O1F7LWQ==
X-Received: by 2002:a1c:6783:: with SMTP id b125-v6mr3161953wmc.147.1542233651991;
        Wed, 14 Nov 2018 14:14:11 -0800 (PST)
Received: from localhost.localdomain ([31.223.156.217])
        by smtp.gmail.com with ESMTPSA id z6-v6sm25569211wrs.19.2018.11.14.14.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:14:11 -0800 (PST)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH v2 0/2] [Outreachy] make stash work if user.name and user.email are not configured
Date:   Wed, 14 Nov 2018 23:12:18 +0100
Message-Id: <20181114221218.3112-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe
In-Reply-To: <20181101115546.13516-1-slawica92@hotmail.com>
References: <20181101115546.13516-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
	
	*extend test to check whether git stash executes under valid ident
	(and not under fallback one) when there is such present
	*add prepare_fallback_ident() function to git-stash.sh to 
	provide fallback identity

Slavica Djukic (2):
  [Outreachy] t3903-stash: test without configured user.name and
    user.email
  [Outreachy] stash: tolerate missing user identity

 git-stash.sh     | 17 +++++++++++++++++
 t/t3903-stash.sh | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.19.1.1052.gd166e6afe

