Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32621F609
	for <e@80x24.org>; Wed, 28 Nov 2018 22:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeK2JOi (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 04:14:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39537 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeK2JOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 04:14:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so204063edt.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzUp+hAKvw5dK9+gvDn85/oJkI2CLDy9F34ROn+a28Q=;
        b=BLmEzxpEj3WuPvRc69YV/CGnKP+sqB+ligr9RhQrmyNLf0+or8Ck3oI/3UcS352XSm
         dqXGkTjeUhtHUViVKHbYSzToUQoJxOQUl66vn9B6+AIVyPsk6mfeaoiyx6kpfNTbXyF7
         IYQtoJOhBaBbbnFgShf0PpcixFmQXD6U876gZ0GUtPKtgy9NzMXqxbo6CzSFaNd3kDAO
         4YcZKnrqWD/uETMt56F/ie1aZfLEN/jlfw/JjzPNIoPJ+2UWiyv3zOWj0v7MfKtNZC01
         +XOPPj86xbbh8mBZzvzZpzU8Z0uee6FTbb9KNLQJoBJ2laYvP01WMdKejBolOknCNkFs
         t8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzUp+hAKvw5dK9+gvDn85/oJkI2CLDy9F34ROn+a28Q=;
        b=ibQkEH0Y9WIKj/ersqZrgk4dS1u8yywFXc0b8CCvT6PXNTeGHvq7xi1CcswDQnFlkn
         Mryk7iXO/dq+m6qoOj+bBypfMXHoTr8yCBx2cDI9nFy3HsVeWkpB0UIjFmQXo5Jw4Kmx
         EbdenxKU7W7UiAEVpSLYQ5NhIKnS6PF9cBk8cHWkdS3M9K7/bYF4Bin/2YiEE6MXm1wu
         T0RyuzrMAWLd8JUN/f3IuV7ZIPFD4Niq4fiKcuvb5i6jwQ00+IEBO8kh5oqtqy2+ZrWY
         GfKMP1uzWXzRicQlKXV+RQWF6lIMLPFefm1vlDoTIF4ROC71L/RD1booRpSa2y+176Df
         GL0Q==
X-Gm-Message-State: AA+aEWYz10CQ/rogpFyWTdfgCX8dL3CMMsEYhHnljlciyroxot5gkXy9
        /Kh8KM437yHuxPvjJu9kIpxh1G8ggvX5RZiKZmUQEw==
X-Google-Smtp-Source: AFSGD/W6r2R+bsmbXuAJZVFWFvTzBuMRp5xiaMm5It5w+v7JekYXEnDL2JHERKMWdgmy6yx2mPPRIYC1cHRLrEQmJ9I=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr31296904edc.76.1543443089113;
 Wed, 28 Nov 2018 14:11:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.89.git.gitgitgadget@gmail.com> <9d6b8f6d0602e85652b2a748c58eeed4cbf4359e.1543441960.git.gitgitgadget@gmail.com>
In-Reply-To: <9d6b8f6d0602e85652b2a748c58eeed4cbf4359e.1543441960.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Nov 2018 14:11:18 -0800
Message-ID: <CAGZ79kbVGyX=Ky9HvmUGWPoHdLJYqnPTNda2kT3aC8XuHnH3+A@mail.gmail.com>
Subject: Re: [PATCH 3/5] pack-objects: add --sparse option
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +--sparse::
> +       Use the "sparse" algorithm to determine which objects to include in
> +       the pack. This can have significant performance benefits when computing
> +       a pack to send a small change. However, it is possible that extra
> +       objects are added to the pack-file if the included commits contain
> +       certain types of direct renames.

As a user, where do I find a discussion of these walking algorithms?
(i.e. how can I tell if I can really expect to gain performance benefits,
what are the tradeoffs? "If it were strictly better than the original,
it would be on by default" might be a thought of a user)
