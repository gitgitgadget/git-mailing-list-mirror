Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A86C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 09:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiBZJMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 04:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiBZJMI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 04:12:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542E243E85
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 01:11:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g20so10509991edw.6
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 01:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaO5Lc5VROKWJon2apxh7fcJcNsTpB3VYW+cNi8mzIM=;
        b=jKKRqJg3A/BazYuysJHoLQdwAcqhFhj1I6IobvTQBAWY9L8OptuvPibAZeHse4x9nb
         OuPRu4pQXQeRNlouQgIsMqQ8x7a+otYjy00YmGYMqEI585W+Q727OZiibEeeEY0+yGx3
         VRwnlrqvdPSjNhQViPQq5GrFvvCwH85MA/fFCKWBSVnMFuTyTKxlNKPsoH/fa+UaWEMB
         0sg4hqA5Xxd0XhbC1JgjwTGj5FdYJCXr7cuyRZ812ovVK1Sr9yFSCtAIrfLlL0BUnMKn
         WMCUM2M4ohz0i5O6Dzlg2OCFUizvP114yBhSwO4CWDmUCEprQWw67gXzshIzM2TpVxOD
         KLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaO5Lc5VROKWJon2apxh7fcJcNsTpB3VYW+cNi8mzIM=;
        b=boYcjfjekf698+Vw2j7RH8jcyqy4HjzY8rfkdhiIZy/K/DSjvl3Fz6JWt4t76DZ7ef
         WMAwWURAE50w5vm0sexSDt5mHCIzob13QRolo7D43W/XAqOf+ltKgdp6IwlE8Aw+LRvP
         LYNwLwoWm6bZT0fkFPtE1IbhrMUiQFd6VytPqU4o75TiqqW0AK/mJ4dT7DP0TdKo/moF
         IMyDxbBmE9bhPP0EK4A1WkYfZA7mAVs79H8PD8rk6KtZFk0a5X7hI4+tM5q9UDYRY2yJ
         VGHEsD74VGlfVO0TeAoGs12KOdBgj2LL7qxtvaw5i1HPdsMtwFKRr53PpeB8ONplf9yh
         cwrQ==
X-Gm-Message-State: AOAM531XpweD9RpK9n9ZsEeK0VCq6hFZ+UI3Yy0UogjmwK2Sc67LU2tc
        z7R40GGI9yS1Yzatq+RbdV/6K8eaWFMR88XDoRo=
X-Google-Smtp-Source: ABdhPJwpc6IiUGOE4ltay2O56nCTDd2Zp3HAU6KsCCDovdTgX57DMS1xpMRC9nkBiFU+zSMQ1oW8l5Rpt+ElWcPI3fw=
X-Received: by 2002:a05:6402:27ca:b0:410:1249:7c85 with SMTP id
 c10-20020a05640227ca00b0041012497c85mr10372181ede.192.1645866692614; Sat, 26
 Feb 2022 01:11:32 -0800 (PST)
MIME-Version: 1.0
References: <xmqqee3q73e1.fsf@gitster.g>
In-Reply-To: <xmqqee3q73e1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Feb 2022 01:11:21 -0800
Message-ID: <CABPp-BGX1+5KYeKLmUv4GN1--G5G0x0pRLxa9RRFBDSzkBc9AA@mail.gmail.com>
Subject: en/present-despite-skipped (Was: Re: What's cooking in git.git (Feb
 2022, #07; Fri, 25))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/present-despite-skipped (2022-02-25) 7 commits
>  - repo_read_index: add config to expect files outside sparse patterns
>   (merged to 'next' on 2022-02-15 at 960873fdad)
>  + Accelerate clear_skip_worktree_from_present_files() by caching
>  + Update documentation related to sparsity and the skip-worktree bit
>  + repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>  + unpack-trees: fix accidental loss of user changes
>  + t1011: add testcase demonstrating accidental loss of user modifications
>  + Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>
>  In sparse-checkouts, files mis-marked as missing from the working tree
>  could lead to later problems.  Such files were hard to discover, and
>  harder to correct.  Automatically detecting and correcting the marking
>  of such files has been added to avoid these problems.
>
>  Will merge to 'next'?
>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>

Clearly you're asking about the bonus/final patch, since the others
are already merged to next.  I think it's now ready, but I did just
send a v4 at [0] that hasn't been explicitly acked yet.  However, in
terms of prior acks:

Jonathan already gave his Reviewed-by on v3 at [1], though he also
provided some wording suggestions for the docs.  I rolled those and
your suggestions into the v4.

Stolee sounded like he was happy with v1 in [2] ("This patch looks
like a good solution to the concerns...Should we update [the
docs]?...The only concern here really is if we want to be picky
about...references in the commit message.") and seemed to agree with
the rename of the option in [3] ("Creating a sparse.* namespace is a
good idea.")

Dscho never acked it, but his multiple suggestions on wording and
config naming suggest he was otherwise okay with the patch in general.


[0] https://lore.kernel.org/git/20220226061222.797107-1-newren@gmail.com/
[1] https://lore.kernel.org/git/YhkE2vxI4nM3ut0K@google.com/
[2] https://lore.kernel.org/git/54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com/
[3] https://lore.kernel.org/git/d33e3253-dc2f-18a7-04b7-2c8a44405f6b@github.com/
