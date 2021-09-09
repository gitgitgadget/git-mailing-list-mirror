Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBEC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132316105A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbhIISPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:15:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52169 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbhIISPN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:15:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15B3513F9AA;
        Thu,  9 Sep 2021 14:14:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=naQeUmw/8h3LPNo5F3SSZhIkWj6cDNHtNAREv3
        1gazU=; b=R5rs00UmsbPG9Xp9SRa1dq+B4BOSNfVG6N/E4pWX27LSAlSz1EIBlU
        +uFWb1P6lMXOKZgw9yriVYGRGNnhRV5eh2vZtmSXhA7YsSnoK6Bc5weAMev/8GyN
        EUNRenKPg8h1tIfWUXTKS91uw/O7qKBZsIRhHwa7MugolQWuSln5A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E24F13F9A9;
        Thu,  9 Sep 2021 14:14:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46B1313F99E;
        Thu,  9 Sep 2021 14:14:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] gc: remove unused launchctl_get_uid() call
References: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com>
        <patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2109091222260.59@tvgsbejvaqbjf.bet>
        <87bl52dkv1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109091541370.59@tvgsbejvaqbjf.bet>
Date:   Thu, 09 Sep 2021 11:13:58 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109091541370.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 9 Sep 2021 15:45:33 +0200 (CEST)")
Message-ID: <xmqqwnnpzkex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4D32ADC-1199-11EC-B22F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes. You want to refrain from forcing every reader to have to go look at
> the definition of that function at that revision. The accumulated time
> spent tallies up rather in disfavor of doing the work diligently on the
> contributor's side and save every reader some time. I mean, you forced me
> to spend the time, and then to spend more time to point out the missing
> analysis, and then you provided the paragraph as a question, forcing me to
> spend even more time on answering. All this time could have been saved in
> the first place. In this instance, it is too late to do anything about it.

While I very much like to see that you subscribe to the principle,
and I do wish that the "question" were posed as a comment after the
three-dash-line in a rerolled patch that is written under the
assumption that the answer to the question is "yes", which would
have saved one extra roundtrip, I do not think the question was not
something to be scolded like the above.

All writers tend to assume that their readers know more than they
do, and that is where the "do not force the reader to know or go
look at things if they don't" principle comes from.  But you're
assuming that your "what's the fallout?" question did not need
clarification, but it is understandable if it weren't.

> But I'm sure you plan on contributing other patches. Hopefully it will be
> more efficient next time.

Thanks.
