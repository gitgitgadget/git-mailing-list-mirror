Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6961F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeGPWXu (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:23:50 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36789 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeGPWXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:23:50 -0400
Received: by mail-yw0-f194.google.com with SMTP id v197-v6so2328617ywg.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6egs6A8M9Zx3ZPtRFFY2K6MHj7aSIKgB5OH7xOLVrTY=;
        b=DAjg2T5hYOdFWGR4L/q0oLQ3NHxf8wvlomcHxY4vMN/i6IIht7al1V4DS22BZiCL4H
         X9tod15qRyeXcr11guCCO2lvr0H/J4i8QjvUYXX6ATsrMr1ma1qOwcx6ehTk0TCdE1p4
         j8wgqaeVBxPjVOvzQef+z2ykv8p0K78c1eLRawWw919R/fkPgOFGHrXi0HyVzyjkf/vg
         W+cc2Ckmyr5TVscOuQMmDqgex5oK++oCTdF+3NqN2+F9h8rxAy1HrSMdmfhZnJ7j/mKi
         rhg3n1UPd3AhFXFthJeFGR2hj32MldfJ26HnYaAfqNV+wkQXZdZDtC46uzrUVxxYFuxW
         LgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6egs6A8M9Zx3ZPtRFFY2K6MHj7aSIKgB5OH7xOLVrTY=;
        b=aJPxHByEvVUqoL0AP4Nc5Dv5b13Jygo+LF2PqR/Gj1DXpuy7ZWNKsy8wH2xbtROuJs
         tV6liQ1n44hA855U4rJHhPkveziKlYtoqzACQyFFm3x3870BoLsZ0qskJLiFWxy5M+Zo
         wXLWo5J882s1rfqME7LkVxkWxzkXFSDMjqgs3j6q8YRHJZ1VTxX5sAryWt8L1t13Hc8I
         DqvH9qdwMhmTtSSa+TjXqKdQl+DYBeYZToNPjvOQYT1Kf6lbKcWOgAXwNGqP/1nDBjak
         H4OYXlfvaak5OcOc122DYANgdKWpo9Lo6dtSF4VyDr9PmeZAjf9dTVnFhpd6a3ebqVGL
         v41w==
X-Gm-Message-State: AOUpUlF5I0XwexjfAM1gKpM1JE0hH55b9x97EIetU2B0iyAYIxnxfHTA
        Y9VgTffTTM46/DkEq3fBHmnuf1LYGKGqdESySAH+HQ==
X-Google-Smtp-Source: AAOMgpf1nHMcilbrbTgovPWOWflMQTSFuKfwBnTJkfjzWtcfH8nHOzGA3Q4qozAzLJ+96rQgJRPMk2joDS7Ve3m7hfc=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr9470932ywd.421.1531778068807;
 Mon, 16 Jul 2018 14:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <95b11ced4c0355aabf458539a284bb3895d73f6f.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <95b11ced4c0355aabf458539a284bb3895d73f6f.1531746012.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 14:54:17 -0700
Message-ID: <CAGZ79kYnVxg2XBWa9ib8Ga7iOPE+10sK=ZPwQAYJXMB+Q8tBAg@mail.gmail.com>
Subject: Re: [PATCH 13/16] test-reach: test can_all_from_reach_with_flags
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The can_all_from_reach_with_flags method is used by ok_to_give_up in
> upload-pack.c to see if we have done enough negotiation during a fetch.
> This method is intentionally created to preserve state between calls to
> assist with stateful negotiation, such as over SSH.
>
> To make this method testable, add a new can_all_from_reach method that
> does the initial setup and final tear-down. Call the method from
> 'test-tool reach'.
>
> Since this is a many-to-many reachability query, add a new type of input
> to the 'test-tool reach' input format. Lines "Y:<committish>" create a
> list of commits to be the reachability targets from the commits in the
> 'X' list. In the context of fetch negotiation, the 'X' commits are the
> 'want' commits and the 'Y' commits are the 'have' commits.

Makes sense. I shortly wondered if we want to s/Y/Z/ as I find X and Z
more distinguishable than X/Y for reading/skimming.

Thanks,
Stefan

> +++ b/commit-reach.c
> @@ -593,3 +593,50 @@ int can_all_from_reach_with_flag(struct object_array *from,
>         }
>         return 1;
>  }
> +
> +int can_all_from_reach(struct commit_list *from, struct commit_list *to,
> +                      int cutoff_by_min_date)

We'll put this method (that is only used by tests so far) here to
not clutter the test tool code too much, or do we see more benefits
from the code
here? If so, docs would be nice.

> +++ b/t/t6600-test-reach.sh

> +test_expect_success 'can_all_from_reach:hit' '
  [...]
> +               Y:commit-7-3
> +               Y:commit-8-1

> +test_expect_success 'can_all_from_reach:miss' '
[...]
> +               Y:commit-8-5

It would be nice if the difference in the list could be easier
to spot as a reader. (There is a lot of repetition).

Maybe we can teach "test-tool reach" to ignore input lines
starting with '#' such that we can annotate the last line in
the miss case?

Why do we omit 7-3 in the miss case? (might be nice
for symmetry to keep around)

Thanks,
Stefan
