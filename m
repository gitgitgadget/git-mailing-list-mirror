Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CBB1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 22:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHUBUh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 21:20:37 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36664 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 21:20:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id w202-v6so1319812yww.3
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+zArwJy15BLlwyYtkw4fEBBjtne65aZAO4fMtwqdHw=;
        b=bPBwI+UcdoZC/jWuBd6Nme538Dnb14pNQHiztYs4aE/8qOj1m1ZpW7938RjxSt5j/1
         NIO55TGOr+51rOhEiv9paGzm7WcXi733zF5wOFLINZwvCVYeprquexpUrwLmV3463ypg
         nl7g2HaELODeEes5I1sXlTeiLMgTljhgkjtANRcUAZ1OfAMCGVIKt0OOs23MVyyHnBBm
         l2xmpfBveMSG09cgDqHJ2PLpbzq/NpGBwyDTPQHrt1bgAzpMwttfNWaaQQts0IKSq21o
         CvwYWbU0BrMwhxEApMROkNvRrw0bLPuS2hU5F4Lz1G1jDDO6glRezgW/y9EvKd43JKce
         jorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+zArwJy15BLlwyYtkw4fEBBjtne65aZAO4fMtwqdHw=;
        b=UlmQBgP988sdhwu96z5KDHaVZLmri2Nn5Fan2SYd7V9PwerXJsDIoIgpQEvJe4seAx
         PRDngDpgI0mdKiBtvuYxFYakbhLVYg9u+F9+mjD34zZuRmFWGLidlKSN3ijiWX0vMzi2
         asAULWjHkEK4a1cNc0tOhDms72Set/Q/SkkWfdeuLYtIz2BoVyo5PJq5HgFuIWMBZJx5
         2BUJ0QXPelBDpg+1pLqHFqa1M4krLfzNwSo8p7VLFmaJ8hKoNy1znfTWvsK74QLkGJJU
         SZ2qe++ny1lxn2a5r4IXiBzmusph9FJGrSzmRvYMyDJdbRCURveevO4xUHtT9WfCwNFc
         90qw==
X-Gm-Message-State: APzg51C/Z4HzmY14lbH5wPZl9bhS06axVyRc0+pP+b1cvBaxJtRqW6hG
        yq3q09jR0mdiC74RLpiYjyJAomHavzwkDBhIKWypEJmszH0=
X-Google-Smtp-Source: ANB0VdYHSR+YEX//WDksBcP6/OTQdy7WuKH1WqXmxL2RVDmHftT6t57MTrg2XjQs0xvikHYNDVcnktHwZCo9XTP8428=
X-Received: by 2002:a0d:ccc3:: with SMTP id o186-v6mr4033634ywd.178.1534802595072;
 Mon, 20 Aug 2018 15:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180820165124.152146-1-dstolee@microsoft.com> <20180820165124.152146-9-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-9-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 15:03:04 -0700
Message-ID: <CAGZ79kYVsmw5LDr-saorv7P3CVxbgxZhF4kAxwCYv=OAeuc5Cg@mail.gmail.com>
Subject: Re: [PATCH 8/9] midx: test a few commands that use get_all_packs
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 9:52 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>
> The new get_all_packs() method exposed the packfiles coverede by

s/coverede/covered/
