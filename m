Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07533C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAAF61038
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhHQTdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:33:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56781 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHQTdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 15:33:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15029CDB1C;
        Tue, 17 Aug 2021 15:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:message-id:references:date:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nLwAiVbV8iTj
        vp4vPS++J336FW1dt0peb9P3seGc1f4=; b=EAe5M/tRUNbqwj/WYdzi7Dq+pCQP
        gRPzGAmGf/vPuCKk8FnV4HrC/1XDNVRdZGGWfAigu6ESoEds//9Amqox042KdrB6
        j5+QYKUzuncDRoaW/JyCgu+3vzWVB/j0vQXl4BDa3ZSDzj2AHrA96NGsRKJEkP2G
        BVgObMjP0/ihUVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BCD8CDB1B;
        Tue, 17 Aug 2021 15:32:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85F65CDB15;
        Tue, 17 Aug 2021 15:32:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Joel Klinghed <the_jk@spawned.biz>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
In-Reply-To: <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com> (Phillip Wood's
        message of "Tue, 17 Aug 2021 11:20:47 +0100")
Message-ID: <xmqqh7fonhlo.fsf@gitster.g>
References: <xmqqv945ng61.fsf@gitster.g>
        <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Tue, 17 Aug 2021 12:32:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC5B9A44-FF91-11EB-97D2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20210817193255.e7-9qhD5EZyGJNFbpSx2zPp6pXXRq5aMFbInG-_RoCk@z>

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

Thank *you* for the series, and you do not need to comment on your
topic only to say that.  But if you need to _stop_ me from merging a
topic to 'next' (because you want to replace it one more time, or
you see something wrong with it), please don't hesitate to do so.

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

My impression was that everybody liked the ability to use systemd
timers as an alternative to cron, but as Derrick summarised in the
message you pointed at, the implementation is not quite there, I
think.

So "Waiting for reviews" was a mislabel; we are waiting for a
reroll.

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
