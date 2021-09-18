Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C8FC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9006361164
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbhIRAHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 20:07:35 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:36660 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhIRAHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 20:07:35 -0400
Received: by mail-ed1-f42.google.com with SMTP id v24so35878151eda.3
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 17:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWRSdAebGLjfB8ft/UPC6K9VNM7PuCamQPgiJjNEMZI=;
        b=xEkCJTL7nEDNfj8RHAwSIogrlHgOhnzVDHPtWihZcRFP3RFUMkDbVUbLhnv+v8BUNq
         Xu39H0pUk1x0zdrGFR9wqH+kKHW0sL9PAIufQVeSOMhg6jCfj5JKbSKigeRnMFCrW8AL
         AN+oigFWQZvpASFv8Ywcm3t705sbsSKu+P2WupBXD0mRkbZYQitRL295tCAdcwuPYZ8S
         DNLZMJJnl+GNA18vhPqr4xyD9tL6SpIwmvaMIRpPMxhOaMgjwIxgC2iA1f3LQbtUco6Z
         JSWzldE6TxohthkgTyUyi7UMQJxPxWJRQgQCt9anv4d429xR/a/XY8VZxI7RQKFIhF+O
         /dIA==
X-Gm-Message-State: AOAM531j3RXhL7LNUl1e0XXXYv5OfBt9YJsGMyA7XBEQmODPbomtJg4e
        onzIt667qRUkht6R4U/lj+gCjx+rDDI6akSk2Fj472m00Ac=
X-Google-Smtp-Source: ABdhPJyDbj50uXCUI4Ok5SkkLsuY3VvObGVNcuth7RqzVYO5Zmn0zTfNixa44C6ziFtUv0H3P03Y0dPjAgmyr64Bb/4=
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr15429079edc.97.1631923571285;
 Fri, 17 Sep 2021 17:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv92yg5y6.fsf@gitster.g>
In-Reply-To: <xmqqv92yg5y6.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Sep 2021 20:06:00 -0400
Message-ID: <CAPig+cSJ4tsJFPK2UQsj_m6DxQteLXjYSzVcrP=Wyeox5mJu7Q@mail.gmail.com>
Subject: Re: [PATCH/RFC] range-diff: make output format more useful for
 "rebase --onto"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> In a range-diff output, we often see an early part of an updated
> series having no changes since the previous iteration.  After
> applying an updated patch submission to the same base as the
> previous round,
> [...]
> Now, after noticing that up to step #5 there is no change since the
> previous round, cleaning up the application result with
>
>     $ git rebase --onto 097b89c815 97b89c8150
>
> will help making it easier to see that earliser part did not change
> before committing this in the longer term history.

s/earliser/earlier/
