Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D89C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F959619B1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhC3WNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:13:32 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:39822 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhC3WNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 18:13:06 -0400
Received: by mail-ej1-f46.google.com with SMTP id ce10so27092803ejb.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 15:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lGR+2fS9lHYgAvFUV6ETTHImNzFz1SCS0MZplsiEJE=;
        b=hBvto52O3l67/fDmSAvP59syrk5dxErJPo5VO3khiXUBaGFhV5sGGNxqaOKqHOTCtJ
         bHGYZkjSSVxYO1uPNvZS7Cf+mIp/qtQjJx+N8zjxlfPuK5J2f0F3t6WA8Q96EePHHKLd
         aWYahLp0MjgY7pRSpSNgHQH9MQKUjAF2r8Fef+eES2Xg9c6WAMrVzoMMJbeqA9NMUtSP
         akhXbkdJn9Be4MajxBn7Mu9NpE61n0zFxeEGZAxGx6DDusnN983PMSKZHnnBiUxajWTt
         i94xrN3vqSBmelAv/OghCmUyX92mSOlcmJxfiHH+R9SMYY1SE0BvrSNwJ35+a3KK7M3A
         ROWQ==
X-Gm-Message-State: AOAM531dlCqWHpnJXOjF4shCDWqi8i5PE6wY1iu1bnEZeRDBNfPnvoJ4
        gehH7YHfD5TCUtPjrt2t8TinbmgH0ssqu7B1F4o=
X-Google-Smtp-Source: ABdhPJxCOozp9/OXqwXYNh5Jzl7QKRlkM4iqWykAAWAVfKzsp1UYlzwcNQfv2dD0KsInnyW1NapbWN9Gixk2MgnkrLw=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr318573ejg.482.1617142385211;
 Tue, 30 Mar 2021 15:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com>
 <xmqqy2e4cvbl.fsf@gitster.g> <3dd5a0cd-94cc-e7ec-b1b1-feb39c65e85d@gmail.com> <xmqq1rbwcn4a.fsf@gitster.g>
In-Reply-To: <xmqq1rbwcn4a.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Mar 2021 18:12:54 -0400
Message-ID: <CAPig+cRmJLkkzsROuUifah2-RgSoEXmLnBDV8-a8iL3jF0CBLQ@mail.gmail.com>
Subject: Re: [PATCH] persistent-https: add go.mod to fix compile
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dominyk Tiller <dominyktiller@gmail.com>,
        Git List <git@vger.kernel.org>,
        Dominyk Tiller via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> In any case, explaining these things in this response is good, but
> eventually we need to make sure that the readers of the resulting
> commit would not have to ask the same question, without having to
> refer to external documentation.

It might also be worthwhile -- for the non-Go readers -- for the
commit message to mention that this addition of a `go.mod` file does
not hinder those stuck with old pre-module versions of Go (it doesn't
help them either, but that's less significant), thus this change does
not require them to update to a modern version of Go (i.e. we're not
raising the minimum required version).
