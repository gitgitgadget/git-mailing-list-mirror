Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D3C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EBD60F5E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHQQsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:48:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64854 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 12:48:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CD1FCC4E4;
        Tue, 17 Aug 2021 12:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zUyHYUVQMbNb
        h404gAwEAlE01jKG1u665ImCm8JOkjk=; b=bacG7SN8M5IsKakJdqpY8FeBZ6kN
        qZFY3fy4CwxXnhNoOqaz9f/DiCNZpgBSFWG50yAjtF98jZZ5w+Uc+pc9y3roRqcM
        9YNppYzjX68zhLUc+7vsIWDzl1OCxO/OsgLaYTXgdHR6df6ys1AHoGAlesvEzu0c
        hk/mE7Iu40qDfio=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03569CC4E3;
        Tue, 17 Aug 2021 12:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 712BCCC4E1;
        Tue, 17 Aug 2021 12:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
References: <xmqqv945ng61.fsf@gitster.g>
        <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
Date:   Tue, 17 Aug 2021 09:47:31 -0700
In-Reply-To: <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com> (Phillip Wood's
        message of "Tue, 17 Aug 2021 11:20:47 +0100")
Message-ID: <xmqqh7fonhlo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D12366EC-FF7A-11EB-A965-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * pw/rebase-skip-final-fix (2021-08-13) 3 commits
>>   - rebase --continue: remove .git/MERGE_MSG
>>   - rebase --apply: restore some tests
>>   - t3403: fix commit authorship
>>   Checking out all the paths from HEAD during the last conflicted
>>   step in "git rebase" and continuing would cause the step to be
>>   skipped (which is expected), but leaves MERGE_HEAD file behind in
>>   $GIT_DIR and confuses the next "git commit", which has been
>>   corrected.
>>   Will merge to 'next'.
>
> Thanks

Thank -you- for the series.  You really do not need to comment on
your topic only to say that.  But if you need to _stop_ me from
merging a topic to 'next' (because you want to replace it one more
time, or you see something wrong with it), please don't hesitate to.

>> * lh/systemd-timers (2021-07-02) 3 commits
>>   - maintenance: add support for systemd timers on Linux
>>   - maintenance: `git maintenance run` learned `--scheduler=3D<schedul=
er>`
>>   - cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" func=
tion
>>   "git maintenance" scheduler learned to use systemd timers as a
>>   possible backend.
>>   Waiting for reviews.
>
> I'd really like to see this merged, there was some discussion a couple
> of weeks ago (cf <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>), it=20
> petered out but no one seemed to be objecting to merging it.

Thanks for paying attention to this item.

My impression was that everybody likes the ability to use systemd
timers as an alternative to cron, but as Derrick summarised in the
message you pointed at, I think the implementation is not quite
there.

So "Waiting for reviews" is a mislabel; we are waiting for a reroll.

>> * zh/cherry-pick-advice (2021-08-14) 1 commit
>>   - cherry-pick: use better advice message
>>   The advice message that "git cherry-pick" gives when it asks
>>   conflicted replay of a commit to be resolved by the end user has
>>   been updated.
>
> I think this is getting there now, I need to look at the tests in v5
> but the changes to sequencer.c looked good to me.

Yes.

>> * jk/commit-edit-fixup-fix (2021-08-15) 1 commit
>>   - commit: restore --edit when combined with --fixup
>>   "git commit --fixup" now works with "--edit" again, after it was
>>   broken in v2.32.
>>   Will merge to 'next'?
>
> Yes please, there was a new version posted at the weekend but I've
> just checked and you've already picked it up in seen.

Yes, this looked good to me, too.

Thanks.
