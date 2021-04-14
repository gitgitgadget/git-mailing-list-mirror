Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A845C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 20:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7A861164
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 20:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbhDNUdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 16:33:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56124 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhDNUdt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 16:33:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FE3D12CC89;
        Wed, 14 Apr 2021 16:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5FYtZLKQiZo8c/0/b4U5+aMXSEQ=; b=nOUJwj
        7cuu2NS8EXD9hDrBlKcNlLhI70hL5QEZKMt2T3f/eI8vznpmy319Q/luNC6LoVT2
        wj0JlFGiCDGDGpcStW+Vx4d9AIhvhhqDpyEoA66rFFBwSzbzAQaEYdwbZP36e0Ff
        xvAmAWb9AlNs/v3uk7EbErp7hl/aE6eBFYxIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KCmTm1RtJFAOrKo82Y/sXOwZaiJrGL1O
        jWCoem++vJj0q94OkFstc7222r1AiKvPOCWdzi3E/o6FSO+3yfrOhCT83cUgkBzX
        /xgA3gIrKTczGlq1jkcgyAKvfgo0xkojqyw6Wdr+2JII/ZTtvY3q+eb9T0xNCpIu
        nxHZ/iMfVhY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 584E712CC87;
        Wed, 14 Apr 2021 16:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9AC8712CC83;
        Wed, 14 Apr 2021 16:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
        <xmqqsg3vb51n.fsf@gitster.g>
        <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
        <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
        <xmqq35vum1rn.fsf@gitster.g>
        <CAOLTT8TNK55AprX2tezoX4YjWV31RRyLWc9NJOvidRqqSgBpQQ@mail.gmail.com>
Date:   Wed, 14 Apr 2021 13:33:22 -0700
In-Reply-To: <CAOLTT8TNK55AprX2tezoX4YjWV31RRyLWc9NJOvidRqqSgBpQQ@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 14 Apr 2021 21:27:05 +0800")
Message-ID: <xmqqv98oy5bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A939DD4A-9D60-11EB-9D5C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> So I am waiting to hear why it is not a misfeature.  If it is not,
>> then surely I am fine to keep it for now and add a workaround later,
>> but until that happens, I do not think "commit --trailer" can be
>> used as a way to allow end-users emulate "-s" for their favorite
>> trailer like helped-by, acked-by, etc.
>>
>
> If it is really necessary to solve this "empty execution" in .cmd,

> Maybe we need to consider two points:
> * Do we need a new config flag as you said `[implicitExecution = false]`
> or just drop it? Has anyone been relying on the "empty execution" of
> .command before? This may be worthy of concern.

Yes, if it is useful sometimes to run the .command or .cmd with
empty <value> even when nobody asks for it on the command line with
a "--trailer=<key>:<value>" option, then I agree that the users
should be able to choose between running and not running [*].

> *  Do we need `trailer.<token>.runMode` as Christan said before?
> I rejected his this suggestion before, and now I regret it a bit.

So far, I haven't heard anything that indicates it is a useful
behaviour for .command, so my preference is to get rid of the
behaviour when we introduce .cmd to deprecate .command; yes, until
we get rid of .command, the behaviour between the two would be
inconsistent but that is unavoidable when making a bugfix that is
backward incompatible.

When (and only when) anybody finds a credible use case, we can add a
mechanism to optionally turn it on (e.g. .runMode).

That is my thinking right at this moment, but that's of course
subject to change when a use case that would be helped by having
this extra execution.


[Footnote]

* Right now, all I know is that not being able to turn it off makes
  it impossible to use "git commit --trailer" as a more general
  substitute for "git commit --signoff" without breaking other
  trailers (e.g. --trim-empty may get rid of the result of the extra
  execution, but would remove other trailers that can be
  legitimately empty).  And making it on by default with
  configuration would mean that even though we designed .cmd as a
  better version of the .command feature with its misdesign
  corrected, we'd inherit one misdesign from it, which defeats one
  third of the point of introducing the .cmd in the first place ;-)
