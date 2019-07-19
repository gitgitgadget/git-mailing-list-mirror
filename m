Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11531F461
	for <e@80x24.org>; Fri, 19 Jul 2019 15:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGSPKp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 11:10:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64788 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSPKo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 11:10:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FA26840D0;
        Fri, 19 Jul 2019 11:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7GrtqhpdT4ZGQ+nu3cwNrOLnAo=; b=EIazt3
        HcEuu2q4AGITaYsw+E49R3bJhuvfQheylVHt65zusv2nH6zgIa3pYKvZq/SWJoTj
        DtGxpyivMshSip1j5mlec377W1q/dvPge648cXpW1oyoDidaHuougclvPbal3RcX
        HpA7UoYCPM8DUPGvw5TFm5fY3LxzHyT0HwGzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SnppGuceWRDM8m12fOrRF8E5D7QKkUdP
        06ZMYR01sePNLxbnNDWRhWun2z1S9E64YFf1UGJSR0OvqEh05nFXUzNCCFKXK/E3
        zITXnrWgUMHRNIgp6cuMM/y+Kjf+lnH3KcMyyH8kTTimrS3ObKTvn/QxpdEU3ktL
        x95mz7/OZjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88E8B840CF;
        Fri, 19 Jul 2019 11:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3BEA840CC;
        Fri, 19 Jul 2019 11:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9_Scharfe_=3Cl=2Es=2Er=40web=2Ed?=
         =?utf-8?Q?e=3E=2C_SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] clean: show an error message when the path is too long
References: <pull.219.git.gitgitgadget@gmail.com>
        <pull.219.v2.git.gitgitgadget@gmail.com>
        <c7b11fe410196c14e142756a036e2bdae5d4bcab.1563442231.git.gitgitgadget@gmail.com>
        <xmqqef2nz5xe.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907191452270.47@tvgsbejvaqbjf.bet>
Date:   Fri, 19 Jul 2019 08:10:37 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907191452270.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 19 Jul 2019 14:53:33 +0200 (CEST)")
Message-ID: <xmqqlfwuvz4i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E8967C0-AA37-11E9-8DE5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 18 Jul 2019, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > Without an error message when `lstat()` failed, `git clean` would
>> > abort without an error message, leaving the user quite puzzled.
>>
>> Let's drop the first three words ;-)  Sorry for not catching it
>> earlier and parrotting the same mistake in my variant yesterday.
>
> You mean the first four words.

Eek, yes, I cannot count ;-)

>> > In particular on Windows, where the default maximum path length is quite
>> > small (yet there are ways to circumvent that limit in many cases), it is
>> > very important that users be given an indication why their command
>> > failed because of too long paths when it did.
>>
>> s/it is very important that users be given/it helps to give users/
>
> If you really feel it important to invalidate my personal style of
> expression, sure.

I meant it as a pure improvement---I think the importance of this
change to the affected population is so obvious that it does not
need self promoting exaggeration to convince readers by stating
plainly how it helps.

But if it is very important for you, I'll undo the change before
merging it to 'next'.

Thanks.
t
