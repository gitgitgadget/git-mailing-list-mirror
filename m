Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C5D1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 09:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfFFJfW (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 05:35:22 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:40786 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfFFJfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 05:35:22 -0400
Received: by mail-io1-f41.google.com with SMTP id n5so138739ioc.7
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMl4MQBJoPwGGa3f8AcuIOuWCrwjBEpXDTZDtDoKtQw=;
        b=VnpOFsXAAfuKqiL/C+4lSrnLPS6Asnl7Dcg4OtcbMRIo/7QdeBUh1podWqyEDtYV9h
         F7LTRgvx6hDGfwnJnXC9vb7RJStUWQwKvpytPkk3Q1UsPAK1aA8ur/xAOZowTEhTl/4C
         jFSTLmtnAMtRYAWpAdeGJUT8dbIXZHL2P0aWZxwS7HSiFjHVXC2KsSvgnOvQt2ofFpMT
         WPv1N+F3jJDHC8CZ8UWbJe0XLlNti1KHQe+9AOyzXY/mwdlczHllpqgGDGW2mTmsRqFJ
         u+zYtOmxQD/RXSaa8Yw8/gtja6A9dUmGghGDZX2kVK02H+QNc9in9VHzNTYvELGKcxUr
         fd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMl4MQBJoPwGGa3f8AcuIOuWCrwjBEpXDTZDtDoKtQw=;
        b=dhfErzV0UABU/Qr64qCUE5urAdwELPQ6YVKXSnFx48po9i3WleYGd9AOuiaZ7Hy2Zk
         pZeum9R9Oa3mdhvfRaP8Hw1HPDSxfo6YsQ4lnFgPcZJA1/ebP/hpdwE5kjCN0zV/ei7G
         NNitIcecP4Lu6Z9h3sWtzPkgb4foCw8nb9OyJ+its2n2emKzd4YYmvTjBrCKyi97IRh0
         1WDtWtQhl2rrCU2xsLMtxbCVOjY2C3TmUCwOjl9eTLQwsg7YVJitI0eTAMA0DJ7n5cgu
         Pwy9jIF0H98m/Rh6RZyeJd2OwR8bdxvmID5+TeZfA1v35sEAsShen2vhrDCSgcvkaJVF
         g72A==
X-Gm-Message-State: APjAAAXVndnCH7+v1qUfG2jQpVgmCaXnDORlx3Yj2tZQn+EPZU3/xbGo
        yHO8ILBXQPw9lA4Jyxm+IOZvZkHEFE3xCpFOgpHpZw==
X-Google-Smtp-Source: APXvYqyJQVNJSTjDibmmYGoYk7/d4KoLL8oZYPIU2Lpi6nnUHginl0RnBeFPsktxOnA9p6RtcfXSyeRgW1QprsCuRQA=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr26486778ioq.282.1559813721754;
 Thu, 06 Jun 2019 02:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de> <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
 <CACsJy8CxSN90-EfTpkd6RUHFVp2iGjZXokpMqw7Tf0EMXT5LfQ@mail.gmail.com>
 <CAPig+cQ0po+cqdqohkVqFyk=aowtjuYGM2J=31pFu6ZuPeAUFA@mail.gmail.com>
 <CACsJy8DiueSPST64=iCZc=V6UtU61RXjJqhBHvG59BwFVSh3QA@mail.gmail.com> <cd006427-03ad-4823-e872-96903cc96fd0@gmx.de>
In-Reply-To: <cd006427-03ad-4823-e872-96903cc96fd0@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 6 Jun 2019 16:34:55 +0700
Message-ID: <CACsJy8AKNrC_XY+6bq1FpPCs4MWZa_jCSiAvjmypPjS0g26cHg@mail.gmail.com>
Subject: Re: worktree add already exists
To:     Ingo Wolf <ingo.wolf@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 5, 2019 at 10:30 PM Ingo Wolf <ingo.wolf@gmx.de> wrote:
>
> Am 05.06.2019 um 12:17 schrieb Duy Nguyen:
> > "worktree add --no-checkout --keep-worktree" is quite readable
>
> worktree add --no-checkout -f (orce)
>
> I've expected to work on an not empty directory

Yeah --force works too. Not sure how it interacts with "--force
--force". But --force is already overloaded, I don't think forcing
harder is going to make it much worse.
-- 
Duy
