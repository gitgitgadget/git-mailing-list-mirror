Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56866C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1198264DE1
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhBBFgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhBBFf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 00:35:59 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2DC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 21:35:19 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y14so9898908ljn.8
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 21:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=b+SQ0GinRgW44InZPnq2e21jQ0j4j2LV9o6Cke9aUHE=;
        b=tg14FibbAJLJFUbpOwnswf5QgssxV+zZh0h5UmLrAtoDQfpUURAvspUHWZITinQmKp
         zwI0rDA2TT3RfdjYHY4esmeKyl1e1oLeqwh7elhRz8vgh0f8VywgqHV38IqTlor88af9
         dv3ZuYlMVw7IkU3nVrv7CwrfKY9sxVov+bg+Btu4PU2kUfqnrEl1obwGk2FL6KRjraHN
         74NiufphBt1So/GicE4qhZect8b1utSVUJTeJP9YZ4DrjIZ5cTopugDAjHwf6IX7XDbs
         q//+cUtdEQnx2196T7uD3JDj/pRelGLmazzdbpKqPzB1y3QyxCTIllYDOpOZ5TGQGY35
         rm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=b+SQ0GinRgW44InZPnq2e21jQ0j4j2LV9o6Cke9aUHE=;
        b=LooJepXAtWYyec57kyHQzvV31B1KP1PyG0IeWkW/Us/1Ebi+qckXPyJoun4SJ5iIBf
         HTpPihvdCvVNtnX0ukji2+TKIU+pHfzIok6FqG8TwpzKoG/wI/cAh8QT3Nw2XlZD8hXz
         IjnZzT6xOXdCWqwMZxQyy+MlE3ji/M/X9gij/3okmep3xdrdnaURDMxoEBWyJScgL5fZ
         3lNR6scyUcBOtfdq6S7aeIlhli902/Ft2LxItT6FurLHNAPELmZGHpX6CQqcyLrh1P8Q
         FCU9cdjawNgu1+vxKjeIYpuIJE+d9yIu7Xwc/kpYifupznCvKK8XAMYDGs0Q6dkJMywh
         QHEg==
X-Gm-Message-State: AOAM530tX3hp3LcV6UUt7MQ0LoWhkIOdy67EbjCuUD121dal7+PbpRTH
        2oY+mIV4fFoKS6FZb5KF6Dxq1CBuq/S9rAd2rF2H9F6iTdpYUidc
X-Google-Smtp-Source: ABdhPJxvwhJnsT6RjxuqkPPkKTvNRUts0Ed1fTPKJ4iZZzXqhnsCwpRTZq1wOOUCqftQEqAD43IQzPKPJvPznF3uEPg=
X-Received: by 2002:a2e:98d3:: with SMTP id s19mr12395673ljj.481.1612244117708;
 Mon, 01 Feb 2021 21:35:17 -0800 (PST)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 13:35:06 +0800
Message-ID: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
Subject: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Considering that the mail number per day of this mailing list is quite
large, is there a way to only receive the topics I participated in or
initiated on this mailing list?

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
