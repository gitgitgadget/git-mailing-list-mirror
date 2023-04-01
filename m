Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA01C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 19:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDATIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDATIN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 15:08:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F030ED
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 12:08:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a44so7749107ljr.10
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 12:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680376090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwDeI7HjAN3Y0SkJECUWvaAFRqmkyv2haHMn0eDKGw4=;
        b=gBRF22POF9CEwf3nDQ6mjgeWPEwd4K5Kjt13ygJyrL48kKchwmTP+gqXA7gjbg8W5c
         c2XCZcPpo0WELXwyq7iQReNJD07Im+ZY6BeJ4sEvkylo9M9vfyrNZ0DiSIIq7nKNaFYg
         YZdyMNjuikVu/saOR95nyynYpJ5x9SbB4ZJdzq8OxdhPFHfZxN/1VhRXLtR2zWMtExO+
         rINAwdPZkfD/s5NW5JBAkH/t9lKcF7PfDM5Uhh1Xkhbzm5Yfw1c9JZWy3oaSJyCBVN1K
         6/YbVVzhhRmYaCseYuNWSNwh80dw9SjP4q4O+9HVJ5HA6LwcMRQVt8eMWv9eBWAjpSK0
         Tc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680376090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwDeI7HjAN3Y0SkJECUWvaAFRqmkyv2haHMn0eDKGw4=;
        b=YORsscThz+pYhqf4zoR1ZqFk6F0kNjHevlFd0zu4NL8plbiIAR9+QTWd6M70zJkywr
         l+sj+/G+AjQScj9M+aFkrYnIXMz7UpCHxjxGEliMIrtno9HsQiB2M/rFdCnQ9d2xUHuH
         Qnmu0W1C6pktjPE9JCI3Pqfd0PSo//D1HeiSdIhYYSmMz6C94BGpE4NxVAXUspwLcXd6
         MT1pkEk+4bie9d6R0EwZhaObBFKWrwu0I7rFN16kTo3/INTspibFyLiHfGwOZ2uQQn15
         6a7BsmSBwdLiZ/xv01R3umTJPsFDFRppkyw58brigCFeIDJLNZFGsud5ENMjFyrFiWI0
         wrow==
X-Gm-Message-State: AAQBX9f6LJh559jR759ktbWw1de32taKQZEdshanew1x/6FggbVOgcsg
        pGHXJDQaIHiSsNTxURDSC5qcXFXre8afRBB9XLE=
X-Google-Smtp-Source: AKy350Z0VDlJDe+ouktNG5Pe3yNZIz4boeQF2WZJ1OF86GaofI6Yc5vQsbMjLRcJTRLP6Gy1dxHIEqd12GRkzhWvdDQ=
X-Received: by 2002:a2e:240b:0:b0:29c:9226:33f7 with SMTP id
 k11-20020a2e240b000000b0029c922633f7mr9396435ljk.1.1680376090377; Sat, 01 Apr
 2023 12:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv8ij5g83.fsf@gitster.g>
In-Reply-To: <xmqqv8ij5g83.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 12:07:58 -0700
Message-ID: <CABPp-BGoPuGCZw+9wCgdYyRR4Zf4y9Kun27GrQhtMdYWpOUsYQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just a comment on a couple series I've looked at today:

On Wed, Mar 29, 2023 at 4:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> * ad/test-record-count-when-harness-is-in-use (2022-12-25) 1 commit
>  - test-lib: allow storing counts with test harnesses
>
>  Allow summary results from tests to be written to t/test-results
>  directory even when a test harness like 'prove' is in use.
>
>  Needs review.
>  source: <20221224225200.1027806-1-adam@dinwoodie.org>

Maybe mark as expecting a re-roll?  (based on Peff's review and your
follow-up at https://lore.kernel.org/git/xmqqr0u1agq8.fsf@gitster.g/,
plus the typo I just spotted in the commit message)?

Alternatively, if we want the --counts option (as per Peff's "The
patch itself looks correct, if we want to go with a --counts
option."), then just fixup the typo I spotted in the commit message
(https://lore.kernel.org/git/CABPp-BGBYUHeYtsyM-gYvr0CsKGAmJ1OKqcmnHiKYy0ps=
6NrCg@mail.gmail.com/),
and then merge it down?

> * cw/submodule-status-in-parallel (2023-03-02) 6 commits
>  - diff-lib: parallelize run_diff_files for submodules
>  - diff-lib: refactor out diff_change logic
>  - submodule: refactor is_submodule_modified()
>  - submodule: move status parsing into function
>  - submodule: rename strbuf variable
>  - run-command: add on_stderr_output_fn to run_processes_parallel_opts
>
>  "git submodule status" learned to run the comparison in submodule
>  repositories in parallel.
>
>  Comments?
>  source: <20230302215237.1473444-1-calvinwan@google.com>

Perhaps this could be marked as needing a reroll, based on both
https://lore.kernel.org/git/CAFySSZDk05m6gU5-V1R+y3YnQ5PPduVW54+_gjBwD0rmac=
sLsw@mail.gmail.com/
and https://lore.kernel.org/git/xmqqv8jczbs0.fsf@gitster.g/ ?
