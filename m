Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442FF20248
	for <e@80x24.org>; Tue,  5 Mar 2019 00:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfCEAnG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 19:43:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40081 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 19:43:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so7549314wrp.7
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 16:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqQnofDR4ttstxwCtRezh8DgvxwsaWGA8zV5c3xB0M0=;
        b=EKiww8Hok9CdPXgfZkfdcM7EP9bmI8GkMS0CHid8dPsfjF1CNk5TYBjQBG9laoQ7+D
         +6xXUcMWPV6yGnm+54fLd0GmhOss2ueYXcZnLRlp7rhNeMp1QOLTaaSaur1b361oTETx
         DyV+wZhSQeYo+myD0Fq9IRGlu8aDTeL+4eAjvsdGj6OUSzdwqwY8pZg8BjVFWX2f1F/S
         pPMdake9NdpUs02FRkwV2Wef+90aHeCB0b/ZKvhlNK0K3VsS4zK6ZxxsWjc/22G/grAr
         OHf4hy7xJpIHc3kZdFJV+bl1pSuJ203M+sU6dWfGxjFqBZet692B9TrzqJu0Jie5l7KR
         0KHw==
X-Gm-Message-State: APjAAAXQrUUlq0+3gP1l+cJemMru8CGYtxzaQ9QX2FSQhmWYILlezq9o
        AsinWR1nzrejIrFU8K2oJop3Aj1JxGU2WgIqPy8=
X-Google-Smtp-Source: APXvYqxOZ7d961f0wEht4CM0l/ACI18fH8Y7SSrj8GGSjZ24NOGa+/7cM3pOrKE8YZtV79m0qTyuycZrOXMRdlA0Rr0=
X-Received: by 2002:adf:dc10:: with SMTP id t16mr14730917wri.40.1551746584280;
 Mon, 04 Mar 2019 16:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190304120801.28763-1-rohit.ashiwal265@gmail.com> <20190304120801.28763-4-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190304120801.28763-4-rohit.ashiwal265@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Mar 2019 19:42:53 -0500
Message-ID: <CAPig+cSKOSC+CckNbjr7HahT5jXkp47WuOxbDov_KQi4XNnbQQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 3/3] t3600: use helpers to replace test -d/f/e/s <path>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 4, 2019 at 7:09 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> Previously  we  were  using  `test -(d|f|e|s)`  to  verify  the  presence of a
> directory/file, but we already have helper functions, viz, `test_path_is_dir`,
> `test_path_is_file`,    `test_path_is_missing`    and    `test_file_not_empty`
> with better functionality.

As with the commit message of 2/3, many of the words in this message
are separated by multiple spaced. Please fold out the excess so there
is only a single space between words.

Also, no need to say "previously" since readers know that the patch is
changing something. Rewrite in imperative mood:

    Take advantage of helper functions test_path_is_dir(),
    test_path_is_missing(), etc. to replace `test -d|f|e|s` since the
    functions make the code more readable and have better error
    messages.

> These helper functions make code more readable and informative to someone new,
> also these functions have better error messages.
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
