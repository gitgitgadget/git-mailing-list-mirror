Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA7C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiAQSa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:30:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55757 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiAQSaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:30:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77C26177075;
        Mon, 17 Jan 2022 13:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FLq9NkQzQiQdYwDgxiikasEU+wD5IIMpZc+yf0
        QiIaE=; b=uJq95BjZWXTSLxhvYKW5IXSfLjMU/SkPhb+WdLn0oIGPipQwSiNuDy
        Zeju1kQVkscD4WfSujocIjMOP1n56R4OsZi7/NxHgwf59rReTanXQrQuGMB9oGYn
        TuBbTqEuHf7So3IyXEZwvbk3cTYJdsEEaQZVArxHUWJx/J+SX2WgY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70A28177074;
        Mon, 17 Jan 2022 13:30:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6AB4177071;
        Mon, 17 Jan 2022 13:30:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2022, #04; Fri, 14)
References: <xmqqy23h4nss.fsf@gitster.g>
        <CABPp-BEROAzba2jDrBhyq1tzZZDYUqROAUGTNp4fNOHfYB3vOg@mail.gmail.com>
Date:   Mon, 17 Jan 2022 10:30:51 -0800
In-Reply-To: <CABPp-BEROAzba2jDrBhyq1tzZZDYUqROAUGTNp4fNOHfYB3vOg@mail.gmail.com>
        (Elijah Newren's message of "Sat, 15 Jan 2022 20:25:53 -0800")
Message-ID: <xmqq35lmw6xw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A1D9E44-77C3-11EC-B3A2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sat, Jan 15, 2022 at 9:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * en/present-despite-skipped (2022-01-14) 6 commits
>>  - Accelerate clear_skip_worktree_from_present_files() by caching
>>  - Update documentation related to sparsity and the skip-worktree bit
>>  - repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>>  - unpack-trees: fix accidental loss of user changes
>>  - t1011: add testcase demonstrating accidental loss of user modifications
>>  - Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>>  (this branch uses vd/sparse-clean-etc.)
>>
>>  (NEEDSWORK: BY DOING WHAT), cope better with files on the working
>>  tree that should not exist according to the sparse checkout
>>  settings.
>>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
>
> Perhaps:
>
> In sparse-checkouts, files mis-marked as missing from the working tree
> could lead to later problems.  Such files were hard to discover, and
> harder to correct.  Automatically detecting and correcting the marking
> of such files has been added to avoid these problems.

Thanks.
