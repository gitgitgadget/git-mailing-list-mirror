Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B4D20248
	for <e@80x24.org>; Sun, 17 Mar 2019 23:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCQXLb (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 19:11:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45657 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfCQXLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 19:11:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so15004139wrh.12
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 16:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2A3MINmm7QWXOJf0rsnZzmR6fBO3mVUpzO+x1gGl30=;
        b=A+Ix6HRTzzAEpTZJazsM8uNiPQ95Rn2uXR/oDlaG0nUqdXW5z//UHDocITxqEVpDel
         DgUAWu08HXneaufIX7YIrv5qMouTrIhN9mDjajv+HJQtlpt2erdmGRwev0FCv4RyU1Uy
         JwXcF76Ifizb4DwbpMTwHyetZvkefu78ffcpEHncoWG6PlL+ZfrR3e2ggIiHQsNz9dE/
         QM+YSSvv97A44J3FT70JBWVhCIUKpmrK1gxYy+0EZ5WWqxsj7OrLZo7vTZTDrFPFcHtd
         K/L0ZcIBAcfFSyJGk0TConTVAAwSx7G2YNUrelX4kAHxwlpyoyhVNzSkv/7NTYTHTGjg
         fg/w==
X-Gm-Message-State: APjAAAUpUjAhUAW4n6thxLG7qxLdWLIoril+m3rBUhteFgjqM1Eal1QY
        4oX0PSFSHGGOwdK4K8YdPWb0MvODbJ6Ehx3Zq8A=
X-Google-Smtp-Source: APXvYqwl7kFlYR6KUw4ScKHY6vXRiEsdnRqlZKDqh3T72RkeYJymkDsP7tECUygYx79tONq9TiwBn8fT4Psm7q74DuU=
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr4816024wrv.282.1552864289551;
 Sun, 17 Mar 2019 16:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190317230239.10131-1-tmz@pobox.com>
In-Reply-To: <20190317230239.10131-1-tmz@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Mar 2019 19:11:18 -0400
Message-ID: <CAPig+cR5uqE+9smKcvZr0oaw2XyqWsYORwAga4WLUX5N+hU4bA@mail.gmail.com>
Subject: Re: [PATCH] t4038-diff-combined: quote paths with whitespace
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 7:02 PM Todd Zullinger <tmz@pobox.com> wrote:
> d76ce4f734 ("log,diff-tree: add --combined-all-paths option",
> 2019-02-07) added tests for files containing tabs.

s/files/filenames/

> When the tests are run with bash, the lack of quoting during the file
> setup causes 'ambiguous redirect' errors.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> I noticed these failures while running in a repo where I happened
> to have TEST_SHELL_PATH=/bin/bash set.  I wonder if we should
> have a test matrix which uses bash to catch these sort of things?

Maybe just extending "make test-lint" to catch these would suffice.
