Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE60C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiBPEw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:52:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbiBPEwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:52:25 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3BA2F0F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:52:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g7so1858110edb.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42v1FnVOh9whrA3naRBDS5uY3V8g05k3aALEl9IzJkM=;
        b=UuoqqJGqgqwObgq+kX3GwSypc/o1bRtmfcsecsLB2CLA8mO0MZyQkeFTXUqUZicpXa
         xQQOxz1EdjUaKsQj9OUILaQJRoAl24KQrDCi1N0D1gBdiD4CuOZsKlF3zEyV7YsUkfZg
         h5zU+l2AQKxU1z8R0CUrThbSF5PTT3A5184hZna1OpeBPlElohztE/4bRnCGf6FmDNZ6
         1WJtLSEycENbrsTbivfWC3KF4kWFGrChjMIiQTliAryzdRN9dPJz7tpPK+jcsqu8Qu69
         ETd/Ry64Cuj7i4N5EOIrMFsod4uEaPidfua1Lbmci7xcskryO5NS0zyRvlqQE4mQc1Ap
         Vssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42v1FnVOh9whrA3naRBDS5uY3V8g05k3aALEl9IzJkM=;
        b=YG8lyEQM9OClQbeaLSn7fpwVUrNjIdIpF/XsbIPiaTFhVknr1yPWsP5p2UOWiCLIlI
         NfgW1QCMD3tm850i4AhYIBc0GZRCOA9aohS0FwqeEkCVVArFUuZMOFgz8Mv3YkgcjAl8
         Gz0hiDelLwJ5gygyRzwcr+wlO+q6ysS9OSZ0BP7tSe9QLHbeigkQqJhElpgz9e9eV86O
         spMD/V0R/0zDRygKWU8ZsqhIEMmAexETCHEnmNp3Csm0cJVt0VZRb817+garCbIxWwDK
         ZxFGHQ6LqgK4LmETPC9KQf4FrGyEu5UH51qx8JJb5E/TUEw0jsQZpwZT6np9MbLvqpKT
         xrcA==
X-Gm-Message-State: AOAM530HTyu4FWHPYhFInDfPrRQQTh6BVvw8OU6C1WisMm2Ib1qIsZRD
        lOYSOl3eMOX9yfMH6i6xOFg4SnI5MGlTG1SGIlo=
X-Google-Smtp-Source: ABdhPJzbzJCCp4ng2jTVVdckdQQeekYPWGbIX5S8pPMkUVgQJsgC9XZH0dVe+pDspsn99WX8RKIawcakgILrIz6XRy4=
X-Received: by 2002:a05:6402:354f:b0:406:c518:56f1 with SMTP id
 f15-20020a056402354f00b00406c51856f1mr1065094edd.309.1644987132810; Tue, 15
 Feb 2022 20:52:12 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0dwyrcv.fsf@gitster.g>
In-Reply-To: <xmqqk0dwyrcv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Feb 2022 20:52:01 -0800
Message-ID: <CABPp-BFOw48k0M3U+fef1J57wHt2uq4hbKo-vnjAj56nYY6m2Q@mail.gmail.com>
Subject: en/present-despite-skipped (Was: Re: What's cooking in git.git (Feb
 2022, #04; Tue, 15))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 12:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/present-despite-skipped (2022-01-14) 6 commits
>  - Accelerate clear_skip_worktree_from_present_files() by caching
>  - Update documentation related to sparsity and the skip-worktree bit
>  - repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>  - unpack-trees: fix accidental loss of user changes
>  - t1011: add testcase demonstrating accidental loss of user modifications
>  - Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>  (this branch uses vd/sparse-clean-etc.)
>
>  In sparse-checkouts, files mis-marked as missing from the working tree
>  could lead to later problems.  Such files were hard to discover, and
>  harder to correct.  Automatically detecting and correcting the marking
>  of such files has been added to avoid these problems.
>
>  Will merge to 'next'?
>  cf. <20220204081336.3194538-1-newren@gmail.com>
>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>

Is there anything specific you're looking for here?

I think it's ready, as I said two weeks ago in the link you provided
above.  All reviewer feedback was addressed to reviewers' satisfaction
over a month ago, so I'm not sure what else to do here...
