Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7EF1F454
	for <e@80x24.org>; Thu,  1 Nov 2018 05:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeKAOWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 10:22:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeKAOWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 10:22:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so18769270wre.7
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4Vi3tEW0RNX6dgZiamfvP7RTgaXUP2QqNqBSvDYl98s=;
        b=QmN8pnDguQG0ClJFwC5rc8WQw7f9g35rgDbS55FWnrRrpax9uN7TfOZlKoOfrmOs36
         ZqhvmfKeZrL89AsjvKLPlv9r5SG0dcCuuRoOJS99zOcfGyde3j58N2nsw2RIdRQKrd32
         7UsSeI8cU8ZGNHyQUK+8BLpC9Eg7xD0qlmZ9IoRSo3bxSZCNLT2kuDUjyIc2GX5uzKJ5
         /GWqkKkxTTHXOLY5R5N0VmP7L0P4wbVk2SjMvgtP39L9v9h+f1a+fqXBb24NhBKAw/34
         8X5a3w+j1aT/1TcYpxr7Uu2ZTPRCTTStI935DEOW9m6OA7JooSiyuV22CeTYeGYQ9/Vq
         hkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4Vi3tEW0RNX6dgZiamfvP7RTgaXUP2QqNqBSvDYl98s=;
        b=iMnP3ssEwVIuyewi2+SD9JhBIavsiwV83akZGpfz/Y+QKK2DvpmuPXxvro25LFfpNU
         KL1VgeASY5zUt2LTycl0qSF7W996OZjn5DPfKJIjLYI/4lO4oSd4moMKToDHjSa+Wm4C
         is75rXsW7XIaPyOrEKNVxf2h3+yJ/6gqJsVkNw00ITGR4tYyp/UgPDLzDkV260pU8Smf
         IT0Rsmg1sY3U2h6MQoutaE4cxvf03rmY2Rz4h+mXQYNtSz07C1Kp9IW007MxX7PpCoLF
         2pOr5BwbUx4TO1LgaYx/e7LYvgxvv7h78jQ6Tw9CNSdEWJ5+DNQOR8SbXQFzq756fkcr
         6fxg==
X-Gm-Message-State: AGRZ1gLHhVgyVK31FJdOojSnXk96MUfeZUJjgJAgKb+kcNp/V/Wt0aU6
        z6F+w35v7Ck2nWsaxm94shY=
X-Google-Smtp-Source: AJdET5fT7agK+JRLXSXgLFLR9mHmaoVfIsNUyUTldbbww24WMEUAFcJDBH3v15l0LcmGS2fWrqjrPg==
X-Received: by 2002:a5d:65cf:: with SMTP id e15-v6mr5082730wrw.149.1541049684935;
        Wed, 31 Oct 2018 22:21:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l5-v6sm5977474wrv.84.2018.10.31.22.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 22:21:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 0/7] Use generation numbers for --topo-order
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Nov 2018 14:21:21 +0900
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Tue, 16 Oct 2018 15:36:35 -0700 (PDT)")
Message-ID: <xmqqpnvptlta.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series performs a decently-sized refactoring of the revision-walk
> machinery. Well, "refactoring" is probably the wrong word, as I don't
> actually remove the old code. Instead, when we see certain options in the
> 'rev_info' struct, we redirect the commit-walk logic to a new set of methods
> that distribute the workload differently. By using generation numbers in the
> commit-graph, we can significantly improve 'git log --graph' commands (and
> the underlying 'git rev-list --topo-order').

Review discussions seem to have petered out.  Would we merge this to
'next' and start cooking, perhaps for the remainder of this cycle?
