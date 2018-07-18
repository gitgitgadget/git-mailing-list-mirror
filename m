Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCACA208E9
	for <e@80x24.org>; Wed, 18 Jul 2018 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeGRUVL (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:21:11 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34790 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbeGRUVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:21:11 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so2327141ybq.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpUkgcmzkGXkpbkX2PCb671gHQl5MV1KY9TLBO25wgw=;
        b=LqLcZgZqOuhrq7GX303bZlfWrJgvPdwo8DSRUznHJATuQrdLR+f+d7Ir0va1aLTDrl
         Hn0XbuxvJxIydP/pesvGNGRIuv5m1wy2p6wxK/EMdo7lXsgX6O9wgURGHe/kttWzEXiz
         CnI+e1xHwYx6GYxYa2kXT6+UcEHvy94jzetS/YFaD5fM60JFdNIsada8EfAzIUADe242
         3G5ryRnlW8snyEk5DAtXAEKSDLoqAAmjn/Mf2gzPXBtiZvFEGnXRvPlFjEv4Bv6MoIPx
         8RwHjuWbXr/D7aI2kC26Y5R38+9SU8tZ5vhsSbqZO3Z8kH4Ek36/MpMy1O+z/Hzx3oKS
         H51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpUkgcmzkGXkpbkX2PCb671gHQl5MV1KY9TLBO25wgw=;
        b=sZ3baRTxDfZa95KyCad0Bz6Z7RnnWnP/niQoG8DI9jHeXH82vBOFTr72/k/J+TwyaV
         fkY8XiymLxREkgwMxMPlmUnGaxkFGVR58NdKlfdXVZQWddwLGnyBiDnQfffxTfKdBsGu
         GxQXN6YvHpJfrV9uiIjGWnXGhDgzCG6zihyK8oKT7s/xgichHgBib+8dPO3SC4l6rR/n
         rjzxpRdRCrfv2WJ8zuCaLGZoLNaDoSTleiesOmzYewFoui5Ela7dYaDjf/yoAcZlw4vI
         /sxVbsX3F7iyqVqrlt4Ya/7Y1Inxrms7V9hLU9T+vExqlwfRrreOMmKhUlkgzKLSB69R
         Enpw==
X-Gm-Message-State: AOUpUlF6KrMOUWkaizH8Cc15YHLqI5qXDviOIkGAsDVyimhA1usarbeV
        aKSZtBpVuCqRSzlFecjozk7aDYKslLXeSBXlCD7/7qMuSHI=
X-Google-Smtp-Source: AAOMgpeAZ7P7IANVPfEi+2t7LCC8YMwoyk/vzdhCqUcrhlna/dQ8MZZmLE5/Ug6n4qQZWPad8etK6ZEEpQFNiX3Qv90=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr3967286ybp.352.1531942909194;
 Wed, 18 Jul 2018 12:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180712194754.71979-1-sbeller@google.com> <20180712194754.71979-7-sbeller@google.com>
 <e5366f75-3669-bfbb-2561-ee06751b923d@gmail.com>
In-Reply-To: <e5366f75-3669-bfbb-2561-ee06751b923d@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 12:41:38 -0700
Message-ID: <CAGZ79ka1Y4ocnES8=iKv+GuCBpuprrjrasU3UQ04CmUQu8QxyQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] submodule--helper: introduce new update-module-mode helper
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 8:00 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/12/2018 3:47 PM, Stefan Beller wrote:
> > +     fprintf(stdout, submodule_strategy_to_string(&update_strategy));
>
> This line is causing build failures on 'pu' for certain setups:
>

yeah, will fix in a resend.
originally reported at
https://public-inbox.org/git/20180717075959.30594-1-szeder.dev@gmail.com/
