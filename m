Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B989C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F0964E90
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbhCDAXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359438AbhCCOTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 09:19:33 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14E9C06178A
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 06:18:51 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y12so15943010ljj.12
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=aFeMjByTtux/1Yc5qn8a1GfzayX9+vizJil+eRJdAUQ=;
        b=iLTXctb+SVvKDzec/IBWUVktSaroKztrhYegeOqmhjSeJ2kKnYl1/rQKwlztuwgArn
         Y6tjCklzczA8aJZKpdSmj3UjbzWCCHyND+FJZKthRgT3jUA7T1RxBHEP2GXpy2qytMlQ
         KvavcWaMosHgniK6ZeiB/haPzj45pv9IdReQSrnClEi3QxnOeUHxkhsVYCwO65wxEYqb
         R2NBKRGf4JXGJg0TYWxZzsf2YsWI56iUQBQoW9ZDMyfSCEUVZ6t3GKoS6GXpekqKuL7Y
         +VymdaDhGbd1lxQFqaKz9oXuppC6OKaHXwhQM2AlP/3Dd5gNsvHNZGeY9Z/tYww7S2UI
         0nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=aFeMjByTtux/1Yc5qn8a1GfzayX9+vizJil+eRJdAUQ=;
        b=mrd0P4Fe5NGSvbqhPGEUk12YCk1gSxkfOhinaCClbHGe09ds5j4Jsi/sJyKh/Oq+ol
         CIFflGNjcMd3D73TQo5OxlAs66rgjoSQmpIt7BgHik64SouA91k5jXnSVxVl6rnmDCXk
         3eMRErCfgJfTVipzCksKiNdyvULP+UuRA3xX1cNjqj6kQ8HbEVdCgDNExleG41nYX9q9
         aCVH4wRtFIqEv3LxykmkTKPsSCSSUpZvADZxL55GypK74CDrawprFsae012p8wIqwSAH
         K4aL31vRBRvDMX1NjmSKQiemit4XeMqAWnBwDh7mlM8s4Lllo5oldudrhLrDMvVHiEQk
         Ed7A==
X-Gm-Message-State: AOAM531nRaIAHita08hnxV31HB8bzQh7vn/gTgyUsYgYJ1xTwr6szxYe
        NDkE3koaNwB6pvTX9KpaBmbam2WcjGw=
X-Google-Smtp-Source: ABdhPJzcdMm3z2nuDpl1+RWwwuoWRl72I0+X6m6dcz+kpMsy2W1GlfjUZ5od5HBzJybk8OFl/Ti9ZQ==
X-Received: by 2002:a2e:8018:: with SMTP id j24mr5813018ljg.188.1614781129700;
        Wed, 03 Mar 2021 06:18:49 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h10sm3141256ljb.101.2021.03.03.06.18.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:18:48 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: git pull unclear manual
Date:   Wed, 03 Mar 2021 17:18:47 +0300
Message-ID: <874khsqq0o.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here is how "git help pull" begins:

<q>
NAME
       git-pull - Fetch from and integrate with another repository or a local
       branch

SYNOPSIS
       git pull [<options>] [<repository> [<refspec>...]]
</q>

From this, how do one figures how to "integrate with ... local branch"?

Is "git pull" useful to integrate with a local branch at all?

Thanks,
-- Sergey
