Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E2C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 08:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376710AbiDTI0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376693AbiDTI0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 04:26:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2861324F19
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 01:23:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2012E129BF4;
        Wed, 20 Apr 2022 04:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=gB+0jnkCTXLst2kvkGvD//ZY6
        RHVYU8sYozz4etdos0=; b=EFssh44oJ7D69wVeNROLjESd6JnZBKGnPEB9LU24V
        yQS5h5NyGxu7KnP2lTYGtEat8cle9hlbfWz9xioHru1benzqfvmWm41JFYBzeplJ
        DT09KEjAnUfvNjUG2ilM7bVQHgFywc3VyPCSSAXfelmcQw0Ni6kdA9Hc4cu6UBV3
        DI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17F22129BF3;
        Wed, 20 Apr 2022 04:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74ECA129BF2;
        Wed, 20 Apr 2022 04:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly
 written log messages
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-3-gitster@pobox.com>
        <YiFYQBWBVq/HQULM@google.com> <xmqqv8wu5zpr.fsf@gitster.g>
        <xmqq8rs82m4f.fsf@gitster.g>
        <220414.86lew7d7tb.gmgdl@evledraar.gmail.com>
        <Yl89hMGLN3DqIkJ7@google.com>
Date:   Wed, 20 Apr 2022 01:23:24 -0700
Message-ID: <xmqqbkwwrwn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2626A7C0-C083-11EC-BB03-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Thu, Apr 14, 2022 at 04:04:59PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>  ...
>> For our CodingGuidelines I think it would be useful to have some versi=
on
>> of "if you can explain something with prose or tests, prefer
>> tests".

I was going to ignore this part as it is merely showing personal
preference, but I guess I need to weigh in here.

Demonstrating what you meant to say in the log message with tests is
fine, but that should be in addition to prose, explaining how the
scenario is set up and what the user wanted to do, before showing
that a command is giving an outcome that does not help what the user
wanted to do.

IOW, in our CodingGUidelines, we should have "tests can be a good
way to augument what you want to say, but explain it well to those
who are not so familiar with the area."  You do not necessarily have
to explain it to 5 year old, but the audience should not have to be
whoever writes the patch themself to understand it.

> So as I'm deciding what to review, I definitely would prefer Victoria's
> commit message. Plus, like I mentioned, it gives the extra safeguard of
> allowing reviewers to check: does the patch actually do what the author
> meant for it to do? If we're never told what the author meant for it to
> do, then we are missing information needed for that part of the review.

I have nothing to add here.

> Anyway, I haven't watched Victoria's talk yet, but I will do so soon :)

I do not necessarily agree with the presentation order in a proposed
log message she suggests, but overall, it's good investment of your
time.  Highly recommended.
