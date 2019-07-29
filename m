Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226FD1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390068AbfG2UFD (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:05:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389784AbfG2UFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:05:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so19966366pgu.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCIhji/dyLlgOhvJKKLCLgJYoY3lvzAzl0a5cND5xJs=;
        b=aFFQtBKywCfZLJZivE7aUORu9TwNeAkTRwj5FfRgsVsG/8yc4JqK4USWFbrTKONSnp
         AsdftXNkr7HI9GFvTOMsCLibk4TPv7M2nrLz0gUXE2IwpgUwqUfHqYXA2VWSHW2zGK5M
         CIFI/q0vYlGepabcp+PJHxDwIuUghIGt5f6xdMv9F+JrNdaV6cuE1e/yqV6FwtMrCSu8
         TVFQ0DzlTQyt9twixN4wNg4iVolFF8c238NNutzh5Bd7uy6xnmWkmsmpDv4HALMQtcj7
         oOzO8FJNIfoh5CN4Sf5l3bxQ34BT43CrJ1urgp1vSgbhJdvR6jUM0mfmEOFZ1FfsM46r
         BTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCIhji/dyLlgOhvJKKLCLgJYoY3lvzAzl0a5cND5xJs=;
        b=qjSHnvYsy6jpzrXRwAC1JLpaM2ffaU0qo9Zq21NZxiJ70vK9fteAy/9xSl+ZObtnK0
         nRcpxUrltsu3ONPbywAO8Qp2K4u/D3RfcILIsDx0uCmeymXYoxfLwTvhQEmShGy2FIXS
         jUGfzZF0dDHralZ+sdufLG4iISj6JaYcJyaY2nWUbqOCdRd4AP4hDzrvsfNQaCaha9jb
         cF4e7YzAi0CrsKmN/+eId1q4i8o3KsOgJ4dXwUaN2JphIoLgObbgWEuvezk3MXYV+8+m
         ad5ZxDXiG/QfjxFZUjJOHj5NkDaGbNtYt33U35kL6ya/76FyGkwlEd/6ZtbampRBujuj
         GjFA==
X-Gm-Message-State: APjAAAXIXjbdD0+lj8eNiuHA8KEvoaTdl+yJUekbsXfpNjBy4KbiCyES
        awpAHgHAeR2TwH1Yp8yD9xZbNYW5T/FXK14NN7A=
X-Google-Smtp-Source: APXvYqy2GPcywDtNVb+E8NuV9vi4iHsOr8D3zptXWk6H3i/6aE1vvdCY3fT1t87kaeZOCz9YHnQ7dsQjrrMI+WYghN0=
X-Received: by 2002:a17:90a:ab0b:: with SMTP id m11mr117190148pjq.73.1564430701702;
 Mon, 29 Jul 2019 13:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
 <69dc3696e715f9be9e545e0142244e16bdd489cc.1563490164.git.steadmon@google.com>
In-Reply-To: <69dc3696e715f9be9e545e0142244e16bdd489cc.1563490164.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 29 Jul 2019 22:04:49 +0200
Message-ID: <CAN0heSoU7XUN8GOFzzBrLG0RbY65hhYUn_-_Ax1DfFsNZ64hpA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] t7503: add tests for pre-merge-hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Jul 2019 at 00:57, Josh Steadmon <steadmon@google.com> wrote:
> +test_expect_success '--no-verify with succeeding hook (merge)' '
> +
> +       git checkout side &&
> +       git merge --no-verify -m "merge master" master &&
> +       git checkout master
> +
> +'

This test doesn't even try to verify that the hook was actually ignored.
That left me puzzled for a while...

> +test_expect_success '--no-verify with failing hook (merge)' '
> +
> +       git checkout side &&
> +       git merge --no-verify -m "merge master" master &&
> +       git checkout master
> +
> +'

... but this would then (most likely) fail, so we would notice
something's wrong.

This script seems to me like if it passes 100%, we can be fairly sure
we're ok, but if some individual test fails, we shouldn't be surprised
if its oneline description is a bit off compared to the bug. Similarly,
quite a few tests could pass, despite their oneline description inducing
the thought of "but surely, if /that/ were the problem, /those/ tests
would fail".

Anyway, I realize this is just following the existing approach. I guess
you could argue it has served us well for a long time.

I would probably prefer seeing the various hunks in this patch being
squashed into the relevant commits (1/4 vs 3/4) to make those patches
more self-describing.


Martin
