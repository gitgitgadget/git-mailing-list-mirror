Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F0C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 18:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbhLOSyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:54:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbhLOSyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 13:54:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCD1E16EDCA;
        Wed, 15 Dec 2021 13:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WIU1gguURYBD
        7JpRWRngsybAn7ANKv3/ZlOUiXpvQkw=; b=SUhnUSP4HmUqqPfGUmMPgMQmG9FN
        yS0NSdxnPUC48I+gXcLCj0qPtgau4HBwXUB2p+zGTlXmF+UHuXbCg72WJ6XCGe+u
        GWaJpAM0uqd9tp8W07hwbqjcRn9LZg6SuHM1E9rJz97+yspVcwK7OqdekG2B+NQO
        RJDLGBb5wBhy3q8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B584416EDC9;
        Wed, 15 Dec 2021 13:54:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18FD416EDC6;
        Wed, 15 Dec 2021 13:54:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
References: <xmqqilvvluoa.fsf@gitster.g>
        <fa070547-45f3-e3d9-e5ac-ffc9fa5261c0@gmail.com>
Date:   Wed, 15 Dec 2021 10:54:27 -0800
In-Reply-To: <fa070547-45f3-e3d9-e5ac-ffc9fa5261c0@gmail.com> (Phillip Wood's
        message of "Wed, 15 Dec 2021 11:10:20 +0000")
Message-ID: <xmqqee6d7l7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6E942F0E-5DD8-11EC-AD32-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 11/12/2021 02:52, Junio C Hamano wrote:
>> * pw/fix-some-issues-in-reset-head (2021-12-08) 14 commits
>>   - rebase -m: don't fork git checkout
>>   - rebase --apply: set ORIG_HEAD correctly
>>   - rebase --apply: fix reflog
>>   - reset_head(): take struct rebase_head_opts
>>   - rebase: cleanup reset_head() calls
>>   - reset_head(): make default_reflog_action optional
>>   - reset_head(): factor out ref updates
>>   - create_autostash(): remove unneeded parameter
>>   - reset_head(): remove action parameter
>>   - rebase --apply: don't run post-checkout hook if there is an error
>>   - rebase: do not remove untracked files on checkout
>>   - rebase: pass correct arguments to post-checkout hook
>>   - t5403: refactor rebase post-checkout hook tests
>>   - rebase: factor out checkout for up to date branch
>>   Fix "some issues" in a helper function reset_head().
>>   source: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
>
> Thanks for your comments on this series, I'll re-roll but probably not
> until the new year now.

Sure.  Thanks.

>
>> * pw/diff-color-moved-fix (2021-12-09) 15 commits
>>   - diff --color-moved: intern strings
>>   - diff: use designated initializers for emitted_diff_symbol
>>   - diff --color-moved-ws=3Dallow-indentation-change: improve hash loo=
kups
>>   - diff --color-moved: stop clearing potential moved blocks
>>   - diff --color-moved: shrink potential moved blocks as we go
>>   - diff --color-moved: unify moved block growth functions
>>   - diff --color-moved: call comparison function directly
>>   - diff --color-moved-ws=3Dallow-indentation-change: simplify and opt=
imize
>>   - diff: simplify allow-indentation-change delta calculation
>>   - diff --color-moved: avoid false short line matches and bad zebra c=
oloring
>>   - diff --color-moved=3Dzebra: fix alternate coloring
>>   - diff --color-moved: rewind when discarding pmb
>>   - diff --color-moved: factor out function
>>   - diff --color-moved: clear all flags on blocks that are too short
>>   - diff --color-moved: add perf tests
>>   Correctness and performance update to "diff --color-moved"
>> feature.
>>   Will merge to 'next'?
>
> I think it's ready, Dscho had a fairly detailed look at it and seemed
> happy, Elijah and =C3=86var read through previous versions. I'm not awa=
re
> of any issues with it.

Yup, let's merge it down.  Thanks for these improvements.  They made
a pleasant read.
