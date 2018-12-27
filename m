Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85BD211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeL0Sqs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 13:46:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35772 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeL0Sqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 13:46:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so6152424wmt.0
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9gfvoT2i05zr6rf9LeKTH+pIg4+dHOhaY6wMQVWsxo=;
        b=E42j7G6/59J5ChvX9c3He4MA6b3v0GcqjrBl3FElfV3Box0UZcFvBUawI/JYgEd1PM
         v6n23anSUT4+Jxn/38or4hrRrU/IyKADdROwHBrL/KsA0CY7Pwyi1yuv8XObVwc8O/FG
         Mx+N29cLTKJcA2LUMO9yv/jl7If8t7FIs8GICyzhr+aUX7t7ubHN5y8abJIMjzdiWTbj
         JXmLKXHfztABkyCN2daYNvHCPj8x5WT+UHuv/Y9HI6QIdpnC/87+Jm9b1K29S231w134
         M7arFBlL4NQMza4KZsioXf/Qx46Kz2jsHUa9NG9Ml+ZcaNxyzaizdMZnmuxYv++lqaqK
         qqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9gfvoT2i05zr6rf9LeKTH+pIg4+dHOhaY6wMQVWsxo=;
        b=cJrKbe+LG9PpDFlAAFLXq4voCKldzVHlXXmnwqWztlDpjEhm18diTyvZ2Eb9y45wQu
         Sfz4ug+EwxdjB6L7YzRLWmKcKofhvbga2v+3Wsm08uot3huDcxJnVytSEEtyxCt0Yppo
         zKOtLhRHBeItGWkP4fXKVEhBx1ghaZFxHx/kSkm8FilUuLpghURuG9KYjvO8sqVTvLbi
         ERu6PcMAFbgWlNa1AN3cPsKcuKcZpeCom+TibZ0VZ7ZfFCKHuGuFRSiJfNn7rA8A8tJ7
         x0KynuZ0Qulvts+Y0r0LQb9Qzn5T63IUozfudTXqg84X7Bf8i8A+gEE+t/ZOO34DV97w
         HZxw==
X-Gm-Message-State: AJcUukcerCpQbGsxFGKoK8r7JmO3eIBv0adZBcyq+5Ggnm1grZrFovo0
        vg2sd48k3zMYbtVdP5UuSlLInDZVD/aFNi3Io00g/LDhniTTlw==
X-Google-Smtp-Source: AFSGD/UMXD6hlH9k/oQjzrWisioS91su1kNblHgNb8WQ7NTwICHNHkprUPo35M7OKJ8+m6wgcqUPybeiI6pbAjDrf5k=
X-Received: by 2002:a1c:2457:: with SMTP id k84mr22048575wmk.139.1545936405217;
 Thu, 27 Dec 2018 10:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20181227065855.68632-1-masayasuzuki@google.com> <CACsJy8CM=H1njP3ZzuReS0u_YRPTS6pGhFWWMBHoaKVNBYiXXA@mail.gmail.com>
In-Reply-To: <CACsJy8CM=H1njP3ZzuReS0u_YRPTS6pGhFWWMBHoaKVNBYiXXA@mail.gmail.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Thu, 27 Dec 2018 10:46:34 -0800
Message-ID: <CAJB1erVmZQd_kLU1fqL7cURrEUz2EJ4Br0kgVQt7T-mk3s95dQ@mail.gmail.com>
Subject: Re: [PATCH] Specify -Wformat along with -Wformat-security
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 10:36 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Dec 27, 2018 at 7:18 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> >
> > Without -Wformat, -Wformat-security won't work.
> >
> > > cc1: error: -Wformat-security ignored without -Wformat [-Werror=format-security]
>
> Compiler name and version?

I'm not familar with the tools, so please be patient.

According to Makefile, `CC = cc`. With `cc --version`, it says:

cc (Debian 7.3.0-5) 7.3.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Jonathan said there was the same patch. Looks like
https://public-inbox.org/git/20181012184037.15076-1-t.gummerer@gmail.com/.
I'll check my config again.
