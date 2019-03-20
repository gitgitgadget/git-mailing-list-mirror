Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C7C20248
	for <e@80x24.org>; Wed, 20 Mar 2019 00:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCTAYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 20:24:03 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:54776 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTAYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 20:24:03 -0400
Received: by mail-wm1-f50.google.com with SMTP id f3so18882345wmj.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JYd8FdpgQFGypejprSr/l8bsKDOIeoHzZHn6Ff9Fido=;
        b=QOX+EjgwEKzJ5HZNQRWizZjFh/EegDf+hdABNFxNeRTVCNQ5oFwiWfN3u79kPssPWk
         hCm0pe5o9RvuVTY+X6VZOvoxb1BU+yZ5WXZ05/1j5MASTN8fN85dNQ+53hQpTSSAx4HW
         JVNBoZsUoMBb8S815i8ziPS2eWSVi+UCf2C1bUbZEM2DlTasA13uOoe3sIICp+sdTs6f
         MNwc886nrHBhvbSSg35rSQ9oDfzV+Ql9zpMrZp3NrQ5LpfKxm9erIm3PgFdy62e/FGML
         o37Jq2RzNyuo41MDasujDLufbAvUKl3WdKt9I4Er1dqX42pwNy6zlPry/Hy5ByCgzvuK
         FW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JYd8FdpgQFGypejprSr/l8bsKDOIeoHzZHn6Ff9Fido=;
        b=CTOukAmYa2b2tXWJ89bbh1kQOphINWGbPisF6N5joxbY7r7t5BDuNTp/D1IJZn2uXl
         ise26F8/KNVgqGxzpQpL5xC6ZXfK5aALyFWdB7W/+S651j0caHs2ywLz6WBTFgBjKvzQ
         wQFGA7utTRnbLhe92Iv6P0OoPM0KFocSSuz/uzz1ynmIhJDUM3zcoYTnSRE8d9fmb7bK
         y/HMFPcVKu17fEsI3Kuub32OMojSmCP3zQ5FZa2COlLZbzAWYaf/yTPZzmP6HbIJSk4o
         jFttgrxilSynIyqJQw5vGTE0i68PSDPXaMjC2tGyVLgepLzDd+4JAR2eb463cGTPMzWX
         1B/A==
X-Gm-Message-State: APjAAAVAZu37ErvUPx+RbXPMwzEroHBm3+AXK2PsN05M/uK9fHqJfBuf
        W/m9ITy1b57aLj5rREHiyUff7UyCu4Q=
X-Google-Smtp-Source: APXvYqxMYGOiB7TqUVZOODEEJsV4yIUau9/aGJeeJt9vG+Duiy42iDwJvvrfKSQr0JUHqlx8e/yV5Q==
X-Received: by 2002:a1c:4d08:: with SMTP id o8mr5960853wmh.18.1553041440785;
        Tue, 19 Mar 2019 17:24:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c10sm340208wrr.1.2019.03.19.17.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:23:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     phillip.wood123@gmail.com, git@vger.kernel.org, newren@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
        <20190319093910.20229-1-pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 09:23:57 +0900
In-Reply-To: <20190319093910.20229-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 19 Mar 2019 16:39:10 +0700")
Message-ID: <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> If you have staged changes in path A and perform 'checkout
> --merge' (which could result in conflicts in a totally unrelated path
> B), changes in A will be gone. Which is unexpected. We are supposed
> to keep all changes, or kick and scream otherwise.
>
> This is the result of how --merge is implemented, from the very first
> day in 1be0659efc (checkout: merge local modifications while switching
> branches., 2006-01-12):
>
> 1. a merge is done, unmerged entries are collected
> 2. a hard switch to a new branch is done, then unmerged entries added
>    back
>
> There is no trivial fix for this. Going with 3-way merge one file at a
> time loses rename detection. Going with 3-way merge by trees requires
> teaching the algorithm to pick up staged changes. And even if we detect
> staged changes with --merge and abort for safety, an option to continue
> --merge is very weird. Such an option would keep worktree changes, but
> drop staged changes.

I think "checkout -m <otherbranch>" with a dirty index should refuse
to run; there is nothing to "continue" after such a failure, so I am
not sure what you mean by "an option to continue" (iow, I do not see
a need for such an option, and if that option makes the whole notion
strange, we can just decide not to have it, can't we?).
