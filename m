Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC0C43217
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B117322D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 18:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbhAESM7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 5 Jan 2021 13:12:59 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41051 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbhAESM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 13:12:58 -0500
Received: by mail-ej1-f42.google.com with SMTP id ce23so1495268ejb.8
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 10:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ywf4+xpImmzxb+4teIVQD02mZ0yiS1+D6/AkIhLvYc0=;
        b=T+RMRicxfGKCwbEnuuTTtZvcwKSvQpgbBShpI0ykOOL3Yt2en86f6XR/DY0Uv8tskb
         75gfYnmerCM3nlGIkT7QM5A7xksyN6zf4U7WsBBbszBKvtWTkegR9il69t9ZJZaLKjtl
         WytBfRilvdloP5f4K2UQyXomgxXVrqPVsyvHwkLxg6cI64b/I6oyw7inXdAHDddp04AD
         V6j+wLU1fkeNIfH6PHuoKTwLijzJzW6RGp9x7lI7Ku2pBfBgFYA9VVCOq4Eehh3xlq+R
         cU/JLEJdwVguXLRnyF3o86a/hCl45mwsrZgu7jmdzQs1HK8YCCUaJiyjCRRaJQQZ90qN
         FdwA==
X-Gm-Message-State: AOAM532DJfQYd0R4fzSKzPbcpJeHmpPGdnZBhB7RK07grPYFm7nFsYM7
        uSwVg0cqTGxAN20XA1vH0lSweLG+hgXRq0lksiM=
X-Google-Smtp-Source: ABdhPJzWxLHNR4kDxyIGbfapwfBRxsNcOv9Noj8PmIY646mZuX4uBdVwBENvbL8gECjjUhB+Vlvp1kyqsXp2bih2nQk=
X-Received: by 2002:a17:906:6b88:: with SMTP id l8mr335316ejr.482.1609870337051;
 Tue, 05 Jan 2021 10:12:17 -0800 (PST)
MIME-Version: 1.0
References: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net> <34b425b5-0237-fb46-5613-e90346bd7114@daenzer.net>
In-Reply-To: <34b425b5-0237-fb46-5613-e90346bd7114@daenzer.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jan 2021 13:12:06 -0500
Message-ID: <CAPig+cSe267W7hO8a38ifCw_r4eabUA6WB9MDhS=GttTxELpVg@mail.gmail.com>
Subject: Re: Bug report: git rebase ignores different context, resulting in
 subtle breakage
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Git List <git@vger.kernel.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 4:34 AM Michel Dänzer <michel@daenzer.net> wrote:
> On 2020-12-14 3:37 p.m., Michel Dänzer wrote:
> > (Originally reported as a GitLab issue:
> > https://gitlab.com/gitlab-org/gitlab/-/issues/292754)
>
> Does the lack of response mean this is considered not a bug?

Perhaps the original slipped under the radar of the area experts.
Adding Elijah to the Cc: list...
