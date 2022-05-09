Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23AC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiEIRPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiEIRPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:15:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1024B13CEE
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:11:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D91B3133F81;
        Mon,  9 May 2022 13:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Su0DMNk82G52KCZXTosq778spQBviilze5vk75
        cfWus=; b=s3UDI0dwcorsYWlqIeJWoLTzdmOyTUjHw21bGE85iQgSNiMP/+tDuL
        t4ovcwOwG5ach6r01xCgW1isrBiVaB/pVcu+PEKbax7M01Vw7UCZ9G1pXq6N53Ze
        DYQbPdr0f9dGW5BUk9P1h3HNMNG41abZKNiOgFns5WdCvsdSs4vuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF6AC133F80;
        Mon,  9 May 2022 13:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 406D3133F7F;
        Mon,  9 May 2022 13:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Halil SEN <halilsen@gmail.com>
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Christian =?utf-8?Q?Gr=C3=BCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
        <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
        <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <xmqqzgjuocjk.fsf@gitster.g>
        <CAOeUTuufDgsyp7FgJj4T+h=JOMaWYVBkMx8S6fNRQ3cdVo6tOw@mail.gmail.com>
Date:   Mon, 09 May 2022 10:11:06 -0700
In-Reply-To: <CAOeUTuufDgsyp7FgJj4T+h=JOMaWYVBkMx8S6fNRQ3cdVo6tOw@mail.gmail.com>
        (Halil SEN's message of "Mon, 9 May 2022 14:46:45 +0200")
Message-ID: <xmqqtu9yd42d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 047D7620-CFBB-11EC-B005-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Halil SEN <halilsen@gmail.com> writes:

> Junio C Hamano, <gitster@pobox.com> wrote:
>> I didn't look at it back then primarily because
>> the patches were made against a wrong history
>
> I remember looking for Paul's repository but I
> failed to find it so created the patch against
> the main git repo. Maybe I should have
> mentioned this in my message since I knew
> the documentation included that note.
>
> I am happy to rebase my patch if someone
> could point me in the right direction.

Thanks for giving me a chance to double-check what we have in
Documentation/SubmittingPatches is not stale:

- `gitk-git/` comes from Paul Mackerras's gitk project:

	git://ozlabs.org/~paulus/gitk

I just made a fresh clone of it just to make sure.  The latest
commit in the repository is 6cd80496 (gitk: Resize panes correctly
when reducing window size, 2020-10-03).  It seems to be related to
the topic you are working on?

Again, I wonder if Paul's been too busy for (or no longer interested
in) maintaining it and perhaps he can use a replacement maintainer?

Thanks.
