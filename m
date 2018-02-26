Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456E81F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeBZUur (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:50:47 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:43732 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeBZUuo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:50:44 -0500
Received: by mail-yw0-f170.google.com with SMTP id p70so5568759ywg.10
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LmYLtXUqovUMyuumrOxhqvwyIKO+7NQKSOMMsn6m3rc=;
        b=a4+KrJBVFfqPMpi4SzTGyzXWDUtx1/fL4dCrN882vSQdpSIs3vY1CJ0SDyhlgmnE6q
         qgjSh/RUSRAmbsflWyE6fHhLtF1A4ZVEjivROAyAZrqStA+iG3qJY+FBKLJg4r6XSgqe
         Xch9lmn7QjYXc801+gIMZ+HrknyQJcnxYNrppNB0dLFPYHWqagFVTiHMxcs4YDBJnpFl
         zhwe4StsrD6Wjp2Y8srzBlS0La1+oaYxHwMTDxNx3e532dpfW88b3XDCr7vDaMjmgjr/
         GrpEYy42Fh6zhdqnCK51w2x6fktJRSjFRl1pZR19SfWpMTmpfUynnpxWLozxrrR6hgi0
         KwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LmYLtXUqovUMyuumrOxhqvwyIKO+7NQKSOMMsn6m3rc=;
        b=I23aNiqcOxYa96kZb+qHnMQHNzb8K9PmT7UlvyjUV7ImA2gbW7/drf9rRUi887DBgs
         NJkM6es4RfFloRafMtvo0e2d1f5PCldnWs6BMXoN/1JGll58XSk6SdBYePjWJxz70Rnl
         rw4DycS5eGQlzk6LKKdV43zJVhgQCr49lUB8+xCluOnszzcH/zq2HANfMmS4qyw89HCI
         4b7KejIWvPcX/q1yyc8eQlBX3+5ZU4W1qTPCx10auEkxXT4OFtd/W0m+PAQ+/VeQYZOw
         JYQaQu4PwzKRur00DUzaCbc62vWs4ezGzCfci9AvO1FYdzFDyZrUaHTkK+279eJfNhgR
         msPA==
X-Gm-Message-State: APf1xPDFoBzzrqNIi+RW5TkgFfaTmIgTRT7zTYU/pgJKhq1CIluo8lt2
        JyX+wNuyzzIHw4fdj8yoNyYsCffN9bLmA5+fAb3Bfg==
X-Google-Smtp-Source: AH8x225XquT1yeMCF/jT7ccvoI2svrlG0nSSSHYSIm+EJ7jat0uYXsUNxvnMvaEpuwwZ9noa5u4Iz1M8djkzcwAt6eo=
X-Received: by 10.129.25.214 with SMTP id 205mr7910004ywz.340.1519678243163;
 Mon, 26 Feb 2018 12:50:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Mon, 26 Feb 2018 12:50:42
 -0800 (PST)
In-Reply-To: <CACsJy8AS5RiuXeM2u34i0hjKXJqEhsrb4Ysi9Md9OhRpP4_B-A@mail.gmail.com>
References: <20180221015430.96054-1-sbeller@google.com> <20180224004754.129721-1-sbeller@google.com>
 <CACsJy8AS5RiuXeM2u34i0hjKXJqEhsrb4Ysi9Md9OhRpP4_B-A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Feb 2018 12:50:42 -0800
Message-ID: <CAGZ79kbgYwCjDT3wviFXakqhAKf51AvTyJOPDCW_6OtxGax87g@mail.gmail.com>
Subject: Re: [PATCHv4 00/27] Moving global state into the repository object
 (part 1)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 7:00 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> I notice that there are a few global state (or configuration rather)
> left after this: packed_git_window_size, packed_git_limit and
> delta_base_cache_limit. These can be changed by $GIT_DIR/config, but
> since it's still global, a submodule repository will use the same
> settings of its super repository. If $SUBMODULE/config changes any of
> these, they are ignored.

That sounds all packing related, which I plan on working on next.

> The natural thing to do is move these to raw_object_store too (and
> repo_submodule_init needs to check submodule's config file). But one
> may argue these should be per-process instead of per-repo though. I
> don't know. But I thought I should mention this.

For now a process and a repository is the same as git-gc or git-repack
doesn't know about the --recurse-submodules flag, yet.
I wonder if we ever want to teach those commands the submodule
recursion, because of the issue you bring up, which settings do we apply
for a submodule? Traditionally we'd just have the command line override
the configuration, which I don't know if it is a good idea for these settings.

Thanks,
Stefan
