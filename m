Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72812C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A63360E93
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhHKQTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:19:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55321 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKQTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 12:19:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 001F1D1FB8;
        Wed, 11 Aug 2021 12:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vUlYvlARMhOc5tU/axc/SjUQ1I6GbUdMkN13Dw
        0ydJ4=; b=R4jPyTap8JuyiI9wS3t2LcQnxVBm5lGvs94WqxIYyPZ32plPqgLxIg
        IlLo/kR2ILPL5USnS3mhNTDDypSahFObiwPlbcSJDWNMOHX3dAsXZnt1085Bh5bF
        XEfcPx86IkCEINf0l6LJ690jff+AvPZU0Ygt5xme4y7gagIxHQE/w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC126D1FB7;
        Wed, 11 Aug 2021 12:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6ACEBD1FB6;
        Wed, 11 Aug 2021 12:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
References: <xmqqh7fwbx86.fsf@gitster.g>
        <7fc86441-add0-b08f-17ae-9e0dc5b010b0@gmail.com>
Date:   Wed, 11 Aug 2021 09:19:16 -0700
In-Reply-To: <7fc86441-add0-b08f-17ae-9e0dc5b010b0@gmail.com> (Phillip Wood's
        message of "Wed, 11 Aug 2021 10:51:02 +0100")
Message-ID: <xmqqlf589cor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E058EDD6-FABF-11EB-8348-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * ab/progress-users-adjust-counters (2021-08-05) 3 commits
>>   - entry: show finer-grained counter in "Filtering content" progress line
>>   - midx: don't provide a total for QSORT() progress
>>   - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>>   The code to show progress indicator in a few codepaths did not
>>   cover between 0-100%, which has been corrected.
>
> I think the midx patch wants to be dropped
> cf. <87v94jzoxj.fsf@evledraar.gmail.com>

Thanks.  I was not expecting it to advance as-is; will make a
comment as such.


>> * zh/cherry-pick-help-is-only-for-sequencer (2021-08-03) 2 commits
>>    (merged to 'next' on 2021-08-04 at 9ea14ed106)
>>   + cherry-pick: use better advice message
>>   + cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
>>   "git cherry-pick" loses its state file when a stray
>>   GIT_CHERRY_PICK_HELP environment is present, which has been
>>   corrected.
>>   Will cook in 'next'.
>
> Sorry I missed this going into next, I thought the conclusion was to
> drop these[1] in favor of[2]

Thanks again.  Let's make sure the "better advice message" will be
the approach we'll take in the next cycle.
