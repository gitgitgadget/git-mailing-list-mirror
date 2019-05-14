Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F571F461
	for <e@80x24.org>; Tue, 14 May 2019 12:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfENMeG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:34:06 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:55828 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENMeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:34:06 -0400
Received: by mail-it1-f173.google.com with SMTP id q132so4608981itc.5
        for <git@vger.kernel.org>; Tue, 14 May 2019 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p41Iulnd6jeA2Cnp6DdMwzRyjp6+wUFaY/O+ThyDzxM=;
        b=T0nFK613KOcrGWk2dw1KzuzNRGWuycqUWzwiQsYj9JLXBoPcLtF1znYb4q3J1n7rJc
         oUXotMmTYgE9wq/c4Z7Npes+KWcU3efbdUbyHAhGPGZfXubxXztPLxeYmmshDn5l5x7P
         nfuPibRPQO4VcBEBmZNaYzhPCWrkic+ShRVHf/UbPpgz+M8P0uHE2znWEErMMUeYnKx1
         Q+1PULc2aCJRyQ7RLhdz3jYBlFnQ0ZlI/X9awZ3NuYhVq8W4AnOJZnYU/eHiMQG+Cgqv
         yVX3iU6858+5g2GPpleftU23d79oIRDn+asZf2zcK//41VwqFbSBOjcFrH0xQSVRUnQf
         dIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p41Iulnd6jeA2Cnp6DdMwzRyjp6+wUFaY/O+ThyDzxM=;
        b=UI4ILAHYi4LDFVOV9dr5nnRLkTs2r+fWUlDFe94URxSux7mVbLuf8PujLFujZ7Ip4p
         TJLMxHqIqTBQwIkdQKg7gHZ5erAlN2oy3e1cpvqXWhN/aKdo65JDYNPZFaSgzE6zWpHB
         7jpDRWd58d53L8XaQZkQo0JjWyzId1xbXFspoLbWboGoHmZLxdlEVIeBZmiMT9AyqDZ7
         tszkxxKCm9yW1WPCKxZYY9osr66ijMfOhJ/Xs6UyBGt3zQoDiImJ9OpQA4XarQQaY2X5
         LwirOk4Dh7vbTdQpl9lgQ3bZHFc9Qe9vCaD8JZC4I0HgOe2830fGBoEJqgAOuH6G+Ns2
         oBOw==
X-Gm-Message-State: APjAAAWvOCKoELZt5hxb+s0G1qGdGhQ2YJ8NhZyE+jDnTpaliDEwn56x
        U/h360vboO9OSLi3FZTbpYJ2AOVAQ15YZL/44i4=
X-Google-Smtp-Source: APXvYqzxMkuFQoA+YCHcGrpXfQ4WIQrLYEfmvr+6Z0hQwYuiPK4rOPnmu7OPx63UCcPesL7A4CwU87rG7qeK1XOGAW0=
X-Received: by 2002:a24:56c1:: with SMTP id o184mr3235085itb.123.1557837245605;
 Tue, 14 May 2019 05:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <CACsJy8C++Ds4kfs_Wc8UiVQgni-ypbyJ+0bFg1m5brt+s0Tfig@mail.gmail.com> <CAHAc2jf2Ojve=NaEshXx9qk8rtD4NHxqLEpqZq8c9t0yE4m_Qw@mail.gmail.com>
In-Reply-To: <CAHAc2jf2Ojve=NaEshXx9qk8rtD4NHxqLEpqZq8c9t0yE4m_Qw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 19:33:39 +0700
Message-ID: <CACsJy8DnmQxO+r3ybg2zpCSMZJaTwc_C8V3QMCDjvga09sBigw@mail.gmail.com>
Subject: Re: "add worktree" fails with "fatal: Invalid path" error
To:     Shaheed Haque <shaheedhaque@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 7:55 PM Shaheed Haque <shaheedhaque@gmail.com> wrote:
> The original code used the more obvious "git worktree remove" rather
> than "git worktree prune" but I switched partly because remove seemed
> slow (I cannot now quantify what caused me to think that), and partly
> because I was having other issues which, I now realise, you probably
> addressed in your recent "stat versus mkdir race" change.

It should be as slow as "git status; rm -r". The first command _could_
be slow. But if you find it significantly slower than that, I will be
glad to receive another bug report.
-- 
Duy
