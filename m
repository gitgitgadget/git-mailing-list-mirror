Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC55C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiCGRGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiCGRGK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:06:10 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A5710DC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:05:15 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B495110CDF8;
        Mon,  7 Mar 2022 12:05:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mJ8LaMTlCxrb
        djF5dfGLJsTpbW/Uhiu7H5MUR0z7ui0=; b=uT9Pvnw3gy7wAtjasgB1NMeFPIva
        ZVp0YoqHtWASc7HZ15KDZgzUQMHzWGDpxqfM80Mr0Dhzku8+6yqULvVI4MYDiZiF
        FFUrOpbOrL3n1qaPpm8IbO9+S6BtA2vN/HgS2rOoS3WBc4nBXoIBjvpDZKr03uCw
        N9+js3prUnMx+bQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACD7910CDF6;
        Mon,  7 Mar 2022 12:05:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13DC410CDF4;
        Mon,  7 Mar 2022 12:05:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g>
        <220304.86mti6f4ny.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2203071649100.11118@tvgsbejvaqbjf.bet>
Date:   Mon, 07 Mar 2022 09:05:13 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203071649100.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 7 Mar 2022 16:51:07 +0100
        (CET)")
Message-ID: <xmqqmti1u20m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C15BDA52-9E38-11EC-B91F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I said that the current output is only useful to veterans. The output t=
hat
> hides the detailed log, under a separate job that is marked as
> non-failing.
>
> That's still as true as when I said it. :-)

I think getting rid of the separate "print failures" CI step and
making it more discoverable how to reveal the details of failing
test step is a usability improvement.

I am not =C3=86var, but I think what was questioned was the improvement
justifies multi dozens of seconds extra waiting time, which is a
usability dis-improvement.  I do not have a good answer to that
question.

I am probably nearing to be a veteran who knows when to brew my tea
in my work cycle, and waiting for an extra minute or two while
browsing CI output is not a problem for me.

But new "non-veteran" users may not share that.  That is something a
bit worrying about the new UI.

Thanks.


