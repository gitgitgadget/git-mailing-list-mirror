Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C2BC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 04:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjBWEKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 23:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjBWEJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 23:09:59 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6F4346F
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 20:09:58 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17211366c6aso12464853fac.13
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 20:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hugsJn4mH2NhdJl/Xfnor4JNOeUm44FUXk0iNfS7G/c=;
        b=BK/jlRAuzxVp5QvqlMOhHslZkDexrowOgKbc12loWaIEWz5Wj8cqUomdX+FoBHS0jQ
         KLp6zz+nfbMjzalwOoXqhYN+WoTVaAa84ZHizY7HLUPIh7LnRqizGQ/G7gc5b9l7gG2k
         9XIWrJqQ7VWsV3HlsQFuvcro3CqCv4GEcVl9luMF3W+Oepqlk6POjb3k8WLXUmbn6fiN
         MFKaDGiXQm90fqCBF3UTNwz2MgBeayIjHrawOAH7ZZ06dYt8naJLcZq3Zd4C8dN/8pSW
         7i3y2iIkR2h1GHr+abMM2t2CHEXjhNEpos6JuhYhyR/ZwZA4aev/UH7EXbq7rKbkTie0
         LNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hugsJn4mH2NhdJl/Xfnor4JNOeUm44FUXk0iNfS7G/c=;
        b=Vw512PV/3fpzr+DWKmXqILOytGIEtN6udhoOGCg9c967n75gXK76dwU4j3y05/fzOu
         7qf3tld43LgVWXpULS/55vCfIn2WIsx+CLAhVWnz3ifbIcN6bcdYc+RU/m5RcPT07h1q
         gH2CAZIIctWSROuwHLzV27y4Xcn/xqMn1JAaDmWpF+h9+OZaxfu48GbFM1beNDm/T+/v
         9hceZyzI70pdCdmLzpoeKbez/LfC+eFBlm/dU9E8CBORwMzxl2D4WSXgLuLqso6y6Bv7
         oqmmkx1Rtlg0e2add00Mtk1fFpTp6YXi9DU+Zq8ZpuSNpFPOu8eb2P1XCDNJAZUbtZ0Q
         J0kQ==
X-Gm-Message-State: AO0yUKVMypf0N/Yklc00E3izohEnWTBChgIxzQsciAkKKsZw99gsNAtu
        9A08SxKV6m7aPQ6poS1+CyZTh1esN5K2LeW2DjUNgn1JGPg=
X-Google-Smtp-Source: AK7set+oaPMnxa3YI8WDc1rQdD6dOILZQQyRJZJ5yqP9TxbsJ7Ln6lgYaeWjey17CAHfUPVY4PyPcsl/hWwYLu5F8+0=
X-Received: by 2002:a05:6870:414b:b0:163:ce19:4435 with SMTP id
 r11-20020a056870414b00b00163ce194435mr2688329oad.229.1677125398026; Wed, 22
 Feb 2023 20:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20230222011317.97943-1-gvivan6@gmail.com> <a6b0cf3b-af44-3d35-3de1-62aaf65f1543@github.com>
In-Reply-To: <a6b0cf3b-af44-3d35-3de1-62aaf65f1543@github.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Wed, 22 Feb 2023 21:09:46 -0700
Message-ID: <CADupsJNVV+GqV9+On6rWiDfVE4ryCvtwzcLAN_GuDcysKXyACQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/MyFirstContribution: add setup template for
 git send-email
To:     Victoria Dye <vdye@github.com>
Cc:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It's generally good practice to CC contributors that have been recently
> and/or heavily involved in the code you're changing. Given that, I've CC'd
> Emily Shaffer (original author of the doc, including the section you'd like
> to change).

I see, will do in the future.

> Earlier commits related to this file start with just "MyFirstContribution:",
> so you can leave out the "Documentation/" prefix to stay under the 50
> character width.

Noted.

> The section you're replacing explicitly states that providing example
> configuration is out of scope for this document. That's for good reason; the
> example config you've provided isn't universal to all developer setups. It
> would be more confusing to a new contributor if we recommended a config
> that's incompatible with their setup than if we left it open-ended as it is
> now.

Oh, I thought you had to set these parameters, i.e. smtpServer, smtpServerPort,
smtpEncryption, smtpUser, and smtpPass in gitConfig regardless of the setup (I
did some googling as well). However, I'll take your word for it that it may be
incompatible with some setups. Thanks for pointing that out!

> However, if you still want to make the guidance in this section more
> specific, you could add a 'linkgit:git-config' link and note that the
> relevant SMTP configs are under the 'sendemail' section.

That sounds like a good addition! I'll do it then. Thanks!
