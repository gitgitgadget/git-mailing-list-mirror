Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98308C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBORzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBORzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:55:43 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617411BAC6
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:55:42 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id v13so6230192iln.4
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJcuK09Bu4snKgpc0bo6IhCCIck6/7V8EUL2s/8F/1E=;
        b=pukLAicPVg11BHy1I+lviC1erOMpgmpEL1fpE5edVeUi8A3qLkDUmzxQk268eN06cs
         RMWmd+nCZuKdWY/zI0aQwe5yr4gPfnx3yPPMRtjqFr0MU210eqTkHeYUc61dY1KxcuK3
         +FgWbl6/PjuEvfg4hIzgIaeA5UZLCCf+1QjASPc2HvsycPLgjxRQYsFUeB6srY60+8tD
         Tvq1dGwkAxcymWhMK4GDy3zuT+3SxO0NATRbUEfKoojNIIdfGuUI8v5h5ZMruY3PNf06
         kIJcV/XebL6MLjT1v8jfyTDsvoxxptXbcZryV3H/eLVxviT16XVrKRdaRRJ+BKua3aBx
         DCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJcuK09Bu4snKgpc0bo6IhCCIck6/7V8EUL2s/8F/1E=;
        b=vOyS1i5eC+q1uN/dMSGEdFNSGvVzYW/XLH8/q0TsQRo+12qMAs9gHzQRW4sT52iItH
         x1aXZoKp+oht5KrYsuyPxzBZQhoqsWH/90AsbwcGyvy94RjjEXEMyPx0p/SchFsB4uFz
         xd8iPF262p6FCeY8pxojnzfnsxPK8pxJhkEReczYMVDvd3kxWuV2WTgXWri03wJyRVX9
         8gb2Lgwk5YxjLMFYNy4j9P52FN+yfounti2htKPGmzSFYiEvh/pZztaiBu9VdxFxPvd1
         lad4htm3fPs5vCI+ieHAUkR3im5OgqUHPH9qM1UWJ3/w3q7owFEhxXrJNP2wTF4HNpdU
         UtYg==
X-Gm-Message-State: AO0yUKURgBClW2cVE1AQv02DnbTqWU0Uug+SYcC94s+Q1K3xVs7GcxyU
        1WoNqb9qeMR5XeRsV5/BItgS0I5okEcnKQ==
X-Google-Smtp-Source: AK7set97r3CdGiTP6wfHTOOu7d0AktDb/trS5Z+OoRb+f7shyqkxlqGMs57V9xFEpRTUR7U15vBuCw==
X-Received: by 2002:a92:440e:0:b0:315:3b94:9911 with SMTP id r14-20020a92440e000000b003153b949911mr2113922ila.15.1676483741204;
        Wed, 15 Feb 2023 09:55:41 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id k18-20020a02c772000000b003c4f77e61d3sm155521jao.64.2023.02.15.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:55:39 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: Re:[PATCH 1/1] [gsoc][patch] trace.c, git.c: removed unnecessary parameter to trace_repo_setup
Date:   Wed, 15 Feb 2023 12:55:10 -0500
Message-Id: <20230215175510.3631-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215104246.8919-2-mcsm224@gmail.com>
References: <20230215104246.8919-2-mcsm224@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello  Idriss,

I have some suggestions：

Seen like you didn't describe the existing problem and how you fix it
in the commit message. You can start with a description of the
existing problem in the present tense in your commit message. Also,
you should use the imperative mood to describe the change you make.

Maybe you can write something like the below in your commit message
after you use git commit -s.
----------------------------------------------------------------------------------------
trace.c, git.c: removed unnecessary parameter to trace_repo_setup

your description of the existing problem.............

Fix them.

Signed-off-by: ...
-------------------------------------------------------------------------------------------





Regards,
Shuqi


