Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB591F461
	for <e@80x24.org>; Sat, 22 Jun 2019 00:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFVAqg (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 20:46:36 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39713 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVAqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 20:46:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id v6so5050524pgh.6
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=boTxckQs4yBeT0dWT0f0nO43Pwj6lL0kFULjS/A7vKI=;
        b=M+pLkTMRHDva2dqUQmDZMak6NBqUV7ts3LqQBSbWmSBJ/aStUBRP/P/jNuO+YEJHiC
         nHjWZ7qLXTuHEnVnnbBQiHutOkVksgvtpF/4MYD1OP0mwrefHefW0tXHe/tPIWiN3yuq
         Nu2yte9fpqq7jaiuaiNrJy/heAFELouSUipP8RntDbBaslgXCza5spbVCPXFWSfUUznf
         RigK+YMAwL4S0WXJoria54jCxuDk8kCalBvQse207nKmsmgfLxxVkJveXrnjCk5XLfc9
         +5ymPnPcWuMSxoA9SRavIU66Aop2Q83yjv14awULeX5r5x2PicVkaFFUsf4LmnsOcT70
         9FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=boTxckQs4yBeT0dWT0f0nO43Pwj6lL0kFULjS/A7vKI=;
        b=dJ1y+TZNEXe3OyG6NJ713mRJLp7Hl/v0SK3is/fP0ZvsR73m3II8MEE4yqg9HbclON
         1eMNmIx4OPtm8C6DKQwwSalUUOFG0ufmfLTFc/AEPjJ1b2sXDdJBKE2y0FwtsJWy+f3R
         IBjr1nUplX46eYWHnlxYcneHwgaXqM+kizZCCQH3ApD+kiEYyuqW7TWEvRD1/9UkmD8Y
         7gN3mf+Ih8aL53kRqdmdCfuYskB5q9JAxTdsM2numtDgAzOdM7XMuqJF1Vl1YMg45fQG
         LJ5CZ1s7ui9Xd0K2xDtMsFaVHRcgeO9EwNME/rPz3EaAEeOswzirQi+pzK4e0SCsvm7e
         FSOA==
X-Gm-Message-State: APjAAAUDBi9JxbvDWN4SNsyXTjXY94cgWpbdQ8HKIP3GUOxGjTHt61gL
        SjLsnx7VFcMtiR5lgzAqj/bNW/ddhoxNCIpSHbl6
X-Google-Smtp-Source: APXvYqwKyN1apflKCfD+uLYFMoo4UeuQ9FAtYYtPg/JvnbG2iPfXYIycYTlXIwFU2TDXQkf/koqFUB18nNw5fvZPRsvy
X-Received: by 2002:a63:6c4a:: with SMTP id h71mr20887596pgc.331.1561164395129;
 Fri, 21 Jun 2019 17:46:35 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:46:31 -0700
In-Reply-To: <2f7566f697be759614a04c1277194f974bdcd662.1560558910.git.matvore@google.com>
Message-Id: <20190622004631.251573-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <2f7566f697be759614a04c1277194f974bdcd662.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH v4 10/10] list-objects-filter-options: make parser void
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This function always returns 0, so make it return void instead.

And...patches 7-10 look straightforward and good to me.

In summary, I don't think any changes need to be made to all 10 patches
other than textual ones (commit messages, documentation, and function
names).
