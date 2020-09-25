Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D143C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677B52399A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgIYRlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:41:00 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43308 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgIYRlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:41:00 -0400
Received: by mail-ej1-f67.google.com with SMTP id o8so4698880ejb.10
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4CAiYbvYTqMs+GclhmuAS2rKClJWXTW/tBzZSz3Slg=;
        b=ar9deIrBQimT7iaJlTSsyrTETd1xH4Bd5megnpgboikryYPNTwZF57kGqScWdurxH2
         E2kd9v3K8hk0clSQY9dSwNqq7GogjEMClzO6Q/HwHTY2g9LTxIOHdIQjc+wI7x28mDJG
         oSn3Cb44M56nTeVXYBdFlwIR6euLsyDY4VxfCLV1kVAQMk8PILYGTV5q/EQ9/WdDAbt2
         XnFeFYtd6AKuBP9lCfX0lHgNV29vaarp31GvaKizTgAC+aUSqmiTT9K61JXdo44/kqjD
         PwBdX2YePvpB2UVHplhsFynlaykVBcQCBeFuX7rIpPR4+FbqXqawQjnJ71/vVfld2tbA
         k7MA==
X-Gm-Message-State: AOAM531d0wd1QMsbMuSr+F/duqDB7tDmYNh9EdW5KgitgWAbe9PGDNi6
        oZp5hZyNarOObPIyCOA/iyW7NXTv+Eyugjr5/i0=
X-Google-Smtp-Source: ABdhPJy32R4NEAUzTwGav9BbRpE+4Hfrgo4T/5U4EaQ0CFwKyxf4brntud/ypKPGAEXjIBpDYOLRjcggw7q3FXBrBps=
X-Received: by 2002:a17:907:1116:: with SMTP id qu22mr3605378ejb.231.1601055658186;
 Fri, 25 Sep 2020 10:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-2-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-2-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 13:40:47 -0400
Message-ID: <CAPig+cQz5GjWH8PXkTsZ_cygmjjaxLBhRrZd_k2k23-aznRxhg@mail.gmail.com>
Subject: Re: [PATCH 01/11] t7001: convert tests from the old style to the
 current style
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> t7001: convert tests from the old style to the current style
>
> To modernize the t7001 test script, let's change the style of
> its tests from an old one to the modern one.

This commit message could help reviewers more by giving an example of
how the style is being updated because it's not so easy to pick up the
details from the patch itself since it's so noisy. Perhaps the commit
message could say something like:

    t7001: modernize test formatting

    Some tests in this script are formatted using a very old style:

        test_expect_success \
            'title' \
            'body line 1 &&
            body line 2'

    Update the formatting to the modern style:

        test_expect_success 'title' '
            body line 1 &&
            body line 2
        '

> Signed-off-by: shubham verma <shubhunic@gmail.com>
