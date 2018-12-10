Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C0F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 03:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeLJDs4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 22:48:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeLJDs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 22:48:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so9695906wml.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 19:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CFhwiH1DAPRRRhFHQwDfDMM8z3KbCjtF/5N4DT0bRBQ=;
        b=mzS1985FRXCVKrg291tfqB17pdA+KnPWvpAQg5tmoNidBmj+Fe2wnMYQINJEW3/uKX
         s6PgpuI2tPiIA1g1KVVZ+1kV1ATBN/b4vjaYHxgrSARcFoO20kQSiuH4DFE5aHkl+eq1
         86CTTfoqz/sM9tumvjitzqL3UDgszpw6EHhohN7gFZPgnelbEXT157Cx7qwZ/Lf9Tq/6
         xM7ypm6nPhutmHI5L7t2v0Hqg+PKJWByw/npgSKSPJoGQsu5LpKSsw5Ks/yPPI5M3nVl
         Kj0CFgnRWZ0xV7MXmmrJh8/N5uOMbRdCUjdt1ezUvUl92bBdZ2sq5OHRmCe1msyBxFB7
         +TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CFhwiH1DAPRRRhFHQwDfDMM8z3KbCjtF/5N4DT0bRBQ=;
        b=Vm0kZnTYvz1TZKSaDzmRmlXcL9sp2arI7St4LZExGvCOP/i+g1J1K/tWFtb0BHUz9N
         lxQxEjNLD/yy23/Lw/E8ORr6e+eQkNqsM2t/ZXenFNcumPOqK7pJ3idR19RbCsAZL7BS
         NvqFH6W+U33LRr+dVEk5BE+ExqO441r0IECkHwrzayQOeKLbOWaG443A38FiWjMrVOm1
         luMUHJ+MmKcmW9T5JpVmO+VM0oP8qKumR/9nyOf8AwPJxbcbvM/lHB7KbJKXIFxLgg8S
         dPFjOEpcFpq5ynHI90EpgYsROh8XPNDYw8zSGRx2GT6QaH0aBCjPQi2Ak40rdSzEnNeJ
         CMLg==
X-Gm-Message-State: AA+aEWZPeWpd5tG8iP+W7bcA13RIENTk65XM7GuX+AhzjFyTZWYJdrZL
        f4cTRkWbeE1dpjnC3EN4giw=
X-Google-Smtp-Source: AFSGD/VdEDkr7om7cFz2nMsctcJm82h6MACXXq0DQ9MVB//o/XvEv/EUi/8H6MrbVSuukgmJI/raBw==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr9418214wmn.128.1544413733998;
        Sun, 09 Dec 2018 19:48:53 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q12sm8150227wmf.2.2018.12.09.19.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 19:48:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] move worktree tests to t24*
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-2-t.gummerer@gmail.com>
Date:   Mon, 10 Dec 2018 12:48:52 +0900
In-Reply-To: <20181209200449.16342-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 9 Dec 2018 20:04:42 +0000")
Message-ID: <xmqq5zw22g9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> The 'git worktree' command used to be just another mode in 'git
> checkout', namely 'git checkout --to'.  When the tests for the latter
> were retrofitted for the former, the test name was adjusted, but the
> test number was kept, even though the test is testing a different
> command now.  t/README states: "Second digit tells the particular
> command we are testing.", so 'git worktree' should have a separate
> number just for itself.

That probably was written in the old world where there were only 10
commands in each category ;-) Nevertheless I have no problem with
this move (and I do not think there are in-flight topics in these
areas).

Thanks.

>
> Move the worktree tests to t24* to adhere to that guideline. We're
> going to make use of the free'd up numbers in a subsequent commit.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/{t2025-worktree-add.sh => t2400-worktree-add.sh}     | 0
>  t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} | 0
>  t/{t2027-worktree-list.sh => t2402-worktree-list.sh}   | 0
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
>  rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
>  rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2400-worktree-add.sh
> similarity index 100%
> rename from t/t2025-worktree-add.sh
> rename to t/t2400-worktree-add.sh
> diff --git a/t/t2026-worktree-prune.sh b/t/t2401-worktree-prune.sh
> similarity index 100%
> rename from t/t2026-worktree-prune.sh
> rename to t/t2401-worktree-prune.sh
> diff --git a/t/t2027-worktree-list.sh b/t/t2402-worktree-list.sh
> similarity index 100%
> rename from t/t2027-worktree-list.sh
> rename to t/t2402-worktree-list.sh
