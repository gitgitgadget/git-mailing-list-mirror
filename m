Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47526C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204F86108D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbhIGRQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:16:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57349 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhIGRQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 13:16:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B932B143059;
        Tue,  7 Sep 2021 13:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=16tpLIGMD3HL
        UatDvky9guz6gs2g75yyDMHVcQwujmg=; b=sjzbuKs0KMlYxuqGWjZwZIq8Xf45
        ncnlPpNEUeE8chCzL+cD1mDdM3sF3MU1oP8mnTQSP3MlRHEEWpnProkfqWaRujQC
        +vJJKkuv+d/6UOe055jW+8WIwL+pFowb/EMlVJ0CNZB2U4E/mdJcSBXvBZHKpIWV
        FWIx6pmqShIYHe0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1E77143055;
        Tue,  7 Sep 2021 13:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C3FF143052;
        Tue,  7 Sep 2021 13:15:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
References: <xmqq35qmiofp.fsf@gitster.g> <87ilzcn0v0.fsf@evledraar.gmail.com>
Date:   Tue, 07 Sep 2021 10:15:23 -0700
In-Reply-To: <87ilzcn0v0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 07 Sep 2021 12:13:54 +0200")
Message-ID: <xmqqh7ewcno4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30C06818-0FFF-11EC-9733-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Sep 02 2021, Junio C Hamano wrote:
>
>> * js/retire-preserve-merges (2021-09-01) 7 commits
>...
> There's an outstanding re-roll of this topic that hasn't yet hit the
> list. If you've got Johannes's git.git on github as a remote:
>
>     git range-diff origin/master gitster/js/retire-preserve-merges dsch=
o/drop-rebase-p
>
> I.e. this is in response to some of my comments about now-dead code &
> loose ends. Not all of that was addressed, e.g. the git-sh-i18n.sh
> change, which is fine & per the discussion there can be done as a
> follow-up, but I believe the current state per the above is that
> Johannes is still going to submit a (hopefully final) v3.

Thanks.  Will mark as such.

>> * gh/gitweb-branch-sort (2021-06-10) 1 commit
>>  - gitweb: use HEAD as secondary sort key in git_get_heads_list()
>>
>>  Tie-break branches that point at the same object in the list of
>>  branches on GitWeb to show the one pointed at by HEAD early.
>>
>>  Waiting for reviews.
>
> I reviewed this & left a note in the last What's Cooking at
> <8735qnax0o.fsf@evledraar.gmail.com>. I.e.:
>
>     I don't use gitweb anymore, but looked this
>     (<20210609192806.45406-1-greg@hurrell.net>) over just now. Looks
>     good to me.
>
> Perhaps it's better if I respond to the patches themselves with such
> notes instead of to What's Cooking?

Comments on the original thread is probably easier to handle for me,
but it ultimately is up to you.  As long as the patch author is made
aware of the comments so that they can act upon (if needed), I am
fine either way.

Thanks for helping.
