Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E061C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4904961008
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhHQTld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:41:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51080 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQTla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 15:41:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D09A4CDBBE;
        Tue, 17 Aug 2021 15:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AEhZ9Wkj85R/
        6FW3uqkSu9BQgSnsqbqh7jPq2pgqMzU=; b=qWw51H0o0ceZYHhK6ZYlIqF3qsGs
        VyV0RK/Iz81lQQ24uF9A8LpzKmiGdtn3blj64AvLMrT7x2MQIDVu/bA1mjfBjdL5
        2H7kWNiRmuCkhiOnap9bJOmsQvZt0FyJQSq6cNflBPrqovkXF2WTNfif4yX7g4wJ
        VjDAQ2AywE6lraw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C95A6CDBBD;
        Tue, 17 Aug 2021 15:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CEA9CDBBC;
        Tue, 17 Aug 2021 15:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
References: <xmqqv945ng61.fsf@gitster.g>
        <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com>
        <12bc51e2-21c5-d401-4189-8cb20b529245@gmail.com>
Date:   Tue, 17 Aug 2021 12:40:55 -0700
In-Reply-To: <12bc51e2-21c5-d401-4189-8cb20b529245@gmail.com> (Philippe
        Blain's message of "Tue, 17 Aug 2021 13:00:36 -0400")
Message-ID: <xmqq7dgj506w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A519CDC-FF93-11EB-AD42-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio and Phillip,
>
> Le 2021-08-17 =C3=A0 06:20, Phillip Wood a =C3=A9crit=C2=A0:
>> On 17/08/2021 00:06, Junio C Hamano wrote:
>>>
>>> * pw/rebase-skip-final-fix (2021-08-13) 3 commits
>>> =C2=A0 - rebase --continue: remove .git/MERGE_MSG
>>> =C2=A0 - rebase --apply: restore some tests
>>> =C2=A0 - t3403: fix commit authorship
>>>
>>> =C2=A0 Checking out all the paths from HEAD during the last conflicte=
d
>>> =C2=A0 step in "git rebase" and continuing would cause the step to be
>>> =C2=A0 skipped (which is expected), but leaves MERGE_HEAD file behind=
 in
>
> This should be MERGE_MSG, no ?

Yup, you're absolutely right.  Will update.

>>> =C2=A0 $GIT_DIR and confuses the next "git commit", which has been
>>> =C2=A0 corrected.
>>>
>>> =C2=A0 Will merge to 'next'.
>>=20
>
> Philippe.
