Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FB0C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC84220663
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fA1lR96t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbgDMWFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:05:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63601 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbgDMWFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 18:05:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8F6E52B66;
        Mon, 13 Apr 2020 18:05:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pgDhK7ub/heUhvoglKgIH6UCKzI=; b=fA1lR9
        6tUDeXWzAGkTiMg1wMv1HcJu8Ov7EtFeNFBJDExIpXnNYoW9Anp6rAUO3HFFCfG5
        ymqW1Jikei/aM/ty5vAO1uk92dB8jp/FhdF5iWPx0Ja8cAQxDlCuwhCpZUbhn/p/
        KnvZq1dHeGM9VDf3biHKqej5Pz9Et8IV7pcos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G83Af/lC9QEJtJ9FyoNNe7mGdrZa8CV7
        abCTA71D9KhFxKJ0NBzt+MQ9CEOvWBXizALXJrNf5SIibnz9CUMddCmz+bndz+Ur
        ELwmDEfdF6AS9nFsdbDrQiE3tY741xTs5w3y0APfA/Qci4yUZhU0ehsG5KBGChx4
        /1D4BeRGKq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EE5E52B65;
        Mon, 13 Apr 2020 18:05:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1773152B64;
        Mon, 13 Apr 2020 18:05:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200407141125.30872-2-phillip.wood123@gmail.com>
        <CABPp-BEnmpET=6rEdDXJWnPjzV33a2x6rKB6FQ-o8y+8ssK4jw@mail.gmail.com>
        <xmqqv9mbroqw.fsf@gitster.c.googlers.com>
        <xmqqlfn7rnj2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004121944590.46@tvgsbejvaqbjf.bet>
        <43d06bc0-b2ee-0ae6-f22c-9850e4033d45@gmail.com>
Date:   Mon, 13 Apr 2020 15:05:41 -0700
In-Reply-To: <43d06bc0-b2ee-0ae6-f22c-9850e4033d45@gmail.com> (Phillip Wood's
        message of "Mon, 13 Apr 2020 10:58:34 +0100")
Message-ID: <xmqqy2qzavnu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB383E02-7DD2-11EA-8DE2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I agree that it would make for a much nicer read if the entire patch
>> series was simply rebased on top of v2.26.0, with drops instead of
>> reverts. I suspect that 4/6 will not even become a fixup, but that the
>> resulting patch is really more of an `Initial-patch-by: Rohit` material
>> with Phillip as the author on record.
>> 
>> As to the changes, I had a brief look over them, and I have nothing to add
>> to Elijah's review except to stress how excited I am about the increased
>> test coverage. From my perspective, this makes the patch series 10x
>> better.
>
> Thanks for all your feedback, I'll reroll as a new patch series based on
> master

Thanks, all.
