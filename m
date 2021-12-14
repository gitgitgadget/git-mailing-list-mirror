Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 05:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhLNFVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 00:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLNFVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 00:21:38 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDCC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 21:21:38 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so4713872oov.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 21:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qTRTSvXu1XVANNXj75inlcxAF8hm4fpj2zl4AfHea9o=;
        b=gvBYmanCaz/BRvi4kUBr/FfNOxYTQPFqLJU9FlmpLs7QWPzeklRH7jxXrqdxLYAZ7b
         AFUONz5YWOML9WGbhuiaYuL0VSIDyK+449DNDFggmeV/Y1wOh72wslT8Am7CFS7y5z5C
         6rU4/1nSu3wmbxGH/lsKYkf54Zfk8qMQOa1jQTqogVMtrT8/nOF/nbHC3tRez6fV9N90
         YaYTnGwY5osU6e1B5uwH1wt+1RB62RNKYsysKqSOT50r7riImfK5rxKZMvVa4HyqJO4f
         o49mgIMN7jxEJsRTuv0fmGwQJOAYAbYavH61CBAmHbDSpHFI6/37QvC13u+/vd+JUChb
         CXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qTRTSvXu1XVANNXj75inlcxAF8hm4fpj2zl4AfHea9o=;
        b=1hT8sXHakAqdvGHtlyrs4oq40ehay50TEDg5SuwLtj50AoVd+J3ZvmNCCL9NY/Milm
         6RG1Q1Yn4oGpySbnt98M2ySJuxVhnXSBOQgtvOnb4TAKyMOK5awuR2JkY78KPxlFtkJj
         /rGlEZchFdJPk1ybkmXkgqX15S7x1qH1lkfgDGpDwvaUGA6BxIhJvLujnBLXprBHUtj7
         +sC4eOUdhMTbVytjW7d/JdHGchR975wTBuWL/JLj5iIo7rXuhzWr/OUg75W7bueuKajP
         MQtAdDT8mH26SK8V5ZxZrLDGJK6XGllm6nYe/xVcWOVqsu4OfHaK2n+iYvv0oGjhdmZ4
         PTWw==
X-Gm-Message-State: AOAM532Uy+hAH6zhMlOG1yL5VQrYNVMgnIFCGMjkRnx7sgwmvNb14zcq
        R/turrLXzm1Cd1rURw0j8FUKNspVCiZfAjPPQS4=
X-Google-Smtp-Source: ABdhPJzAp1TDdQxkDZa2Zo4b/xGzNTNMCIdRmYLZiQG5KR5P8Nsng/cc/P3MbL7AhfkqJzBf584GAjmb4n3+4YCY6TQ=
X-Received: by 2002:a4a:245a:: with SMTP id v26mr2047878oov.67.1639459297938;
 Mon, 13 Dec 2021 21:21:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:748c:0:0:0:0:0 with HTTP; Mon, 13 Dec 2021 21:21:37
 -0800 (PST)
From:   =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>
Date:   Tue, 14 Dec 2021 08:51:37 +0330
Message-ID: <CANv3_vpJAdhyT=SsjQNfhQL60NJi3sHTZR4saqLu29mRWpvuqg@mail.gmail.com>
Subject: =?UTF-8?B?2YXaqdin2YYg2YfZhdix2LPYp9mG24wg2LTZiNiv?=
To:     11898207+NAQ1S@tickets.livechatinc.com,
        =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>,
        Cmail@gmail.com, freesupervpn@mail.com,
        "GearBest.com" <newsletter@edm.gearbest.com>, git@vger.kernel.org,
        info@bischoff-guss.com, M@gmail.com,
        Mapbox <newsletter@mapbox.com>, maskvpn@hotmail.com,
        media@campaign.who.int, opencovidpledge@gmail.com,
        support@alohabrowser.com, support@zendesk.com,
        ytandroid-support@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2KfbjNmF2YTZhSDYsNiu24zYsdmHINi02YjYrw0K
