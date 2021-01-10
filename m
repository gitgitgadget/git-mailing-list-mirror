Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0CC433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDA422582
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 20:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAJUTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:19:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58851 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbhAJUTR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 15:19:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A7ECA9452;
        Sun, 10 Jan 2021 15:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v88PEpGTWGmyJEhx5Mf/WnI2iA8=; b=TECGOM
        wr++WdVV4aMng54b5yLJugkxFb9ZjXXOcDBiXa8LeoLWrm1TqsCnNNkOnDe7Fcb0
        YbyBu84dqPG/1sCSmzOfJLFFkizmh3kIk5ul2vfydVCEZDg9S/C8uNNldfct3unu
        RQI4P4nFppr+5EXEusYgkOjBdonILgUH6oBp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=evEvywwBLafRAiBagF6SJ4F5DX7WOBlm
        kMz/lmixl74OJSwiTPuKVKYEvhoTcVyLF5FpxyAGkOxb3qOhJG7flZszm1sXJAfW
        77S0brtkwBvZkCehsqpyUzHH30t6K5ZSCoN/xFHnokbNFit4/AdX/+47kP1MyyK3
        HJiIC2V1Grc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 128EFA9451;
        Sun, 10 Jan 2021 15:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8894CA9450;
        Sun, 10 Jan 2021 15:18:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
        <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
        <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
        <87wnwordzh.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
        <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
        <X/i7zvgMJHfOmyZG@nand.local>
        <nycvar.QRO.7.76.6.2101101306310.56@tvgsbejvaqbjf.bet>
Date:   Sun, 10 Jan 2021 12:18:33 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101101306310.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 10 Jan 2021 13:21:38 +0100 (CET)")
Message-ID: <xmqq8s90a6li.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03DEDDF6-5381-11EB-A422-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Taylor,
>
> On Fri, 8 Jan 2021, Taylor Blau wrote:
> ...
>> I think that this could be reasonably addressed. When someone opens a PR
>> (but before the hit /submit), GGG could say:
>>
>>     Your change touches these files, and so suggested reviewers include
>>     X, Y, Z. When you believe your submission is in its last round,
>>     please also include the maintainer, M.
>
> That is an option.

As Taylor created the above suggestion as a counter-proposal, I can
see that I apparently did not express what I meant very well, when I
said:

    Is there a point in the end-user experience flow, starting at
    the time when they push their proposed change to their
    repository, throw a pull request at GitHub, say "/submit", and
    then GGG finally sends out a patch e-mail, where the GGG
    machinery can inspect the change and give the user (preferrably
    before the user says /submit) a hint that says "you may want to
    add Cc: to these people in such and such case, and if you think
    the situation falls into these cases, tell me so by saying
    /submit-with-suggested-cc instead of the usual /submit"?

What Taylor suggested, and what you seem to be agreeing to, is
exactly what I had in mind when I wrote the above in my message.  

So perhaps we three are on the same page from the beginning ;-)

Looking forward to see a new feature that helps contributors to more
easily ask help from appropriate people.

Thanks.

