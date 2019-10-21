Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9E31F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfJUTtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:49:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63653 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfJUTtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:49:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AA962AE70;
        Mon, 21 Oct 2019 15:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnzzhl9a7MEiVWj9XyVOOV+5fTk=; b=xUmP62
        qNGPGR0q3ex435ToprAsApx7D7WMnJT8n3IaJ2tyPwp38jtpalTDQ7OHipN8b6Z1
        ViTjJjO6GSm48F9FD/X2Ua3yt/0VSS9c+QyPbslfdI6g7Z/lqkrrWGHj7gPuaA0M
        23oL25VwPkQBU/J3NVSoy5IfAvoFK5D4SMNEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GzCqTFYP40IHB9Oue9Se6vhM/CetJh84
        EJ1VylAbuwrDyit3PynbRkC1ew1WHX85ldjrvZHFeCSbUcKLk1dyBr6s5CNWsogc
        OStHllILxvgYJg6QUio11f1ES+J4ho/Vd/X1bbqj6pXwtTw3nfSnXGrCTsakjIMK
        W5Qo804zKlI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E6C02AE6F;
        Mon, 21 Oct 2019 15:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C64522AE6E;
        Mon, 21 Oct 2019 15:49:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
References: <cover.1571246693.git.liu.denton@gmail.com>
        <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
        <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
Date:   Tue, 22 Oct 2019 04:49:19 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 21 Oct 2019 20:44:40 +0200 (CEST)")
Message-ID: <xmqqblu9lw00.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFE82786-F43B-11E9-963D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ... I do not particularly see this change (there may be similar
>> ones) desirable.  I'd find it it be much more natural to sort
>> "commit-anything" after "commit", and that is true with or without
>> the common extension ".o" added to these entries.
>>
>> In short, flipping these entries because '.' sorts later than '-' is
>> making the result look "less sorted", at least to me.
>
> The problem with this argument is that it disagrees with ASCII, as `-`
> has code 0x2d while `.` has code 0x2e, i.e. it is lexicographically
> _larger_.

I am saying that sorting these in ASCII order did not produce result
that is easy to the eyes.

You are saying that Denton's patch sorted these lines in ASCII order.

I agree with you that it did correctly sort them in ASCII order.

That does not make the patch right ;-)

