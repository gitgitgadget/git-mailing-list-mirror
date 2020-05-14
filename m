Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31583C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CC2206F1
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgENVKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:10:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43955 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgENVKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:10:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id i15so537031wrx.10
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaESi8Sh4A7wTY3Twa+nYy/EDKBFNYw2FwqSmbZQSXM=;
        b=CY+VSzvn0Alz2XtuA/coGicwWo0/fisfHsymRM2EFjLp3w3WL72OkUCjGryOezWtVr
         GnOtiTiocAitqVjfo7hOr6UuuL7loWPd2CGvaViPY5pdTCgcmOt/gW3nL+J5X2TFa1WO
         xNYw8JXk0l6bviLBzFbDayAAn/V1IcZUc2M8qlp47Wfz/uj4nyu5Fau9yyPOIuyyJee7
         eoJeUX1OcfHqEJlbDUgIF2Dlq+veJ3k5CMKhWmVPut16+G6hqpEloeBEgn0E5lVvbcNX
         vq2kGddKyYgwKy1KdO7RjEuEX0bkzGlkfWiOxfAhJpySU3I6ANP3WHCJnH+B1XpgMy1k
         jOBQ==
X-Gm-Message-State: AOAM531hiFhpheQxKIhaE82L/26JAiu//zA9Z1MqgedGTrS1en30WaOq
        q+w+5x3gvJbpTUs42yzepZrAZeRRWVgV/AiZE7qoTQ==
X-Google-Smtp-Source: ABdhPJziZTXx+uKaWwAE+JZTpIIGFyf6fNckJxmxhl1n8hXHj/jyeQ++qO0XdOjXC+WkoFA66Y/b6BqeqbD50HVkU30=
X-Received: by 2002:adf:f651:: with SMTP id x17mr370768wrp.277.1589490607914;
 Thu, 14 May 2020 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local> <20200514210501.GY1596452@mit.edu>
In-Reply-To: <20200514210501.GY1596452@mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 May 2020 17:09:56 -0400
Message-ID: <CAPig+cR4GBkd2==5G1d_514bcsAULYaFQatQg7odmO-ZmHHohg@mail.gmail.com>
Subject: Re: Add a "Flattened Cache" to `git --clone`?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Caleb Gray <hey@calebgray.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 5:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> If the goal is a git local cache, we have this today.  I'm not sure
> this is what Caleb was asking for, though:
>
> git clone --bare https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git base
> git clone --reference base https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4

For that sort of use-case, git-worktree may also be a suitable solution.
