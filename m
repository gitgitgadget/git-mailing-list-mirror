Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60C41F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfKFChm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:37:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57656 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbfKFChl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:37:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5B5AA1154;
        Tue,  5 Nov 2019 21:37:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FUsExOt7CTalr/ZQUeaT+0bFzXA=; b=HvzUcc
        H4NTdVLCCW2VKCpO45jR5Rsh7exdFw1Ish7OEp0bWn5t/OyNOA45DFuSukLvCLg3
        I3QaanB4EljmWUvRpsr+hAM70hCccS8/Qb5/cTJdaQAZE8e6BBrk0Tny757QFyk3
        7pe7mpZSIcCBTd/ojzMIomRoqfrjZyWvOlmXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gBmtLo6UTojFXLiykkveAbMX+j00kbw4
        GJQNgljMTRd0PRzcrDhWjo3zNRDZrEBH6DQT0zNaVvQZAA43tvipP/6K7IKI0ZcQ
        pn344bqHtxrrAt9LHqN+3LzG+Pf6/BrVfPF8FOvmoZ94iu1f4Lmvs5BVtbRCPby6
        Tp4H4lW5nhI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD956A1153;
        Tue,  5 Nov 2019 21:37:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 152E8A114E;
        Tue,  5 Nov 2019 21:37:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] t5520: various test cleanup
References: <cover.1571435195.git.liu.denton@gmail.com>
        <cover.1571739459.git.liu.denton@gmail.com>
        <20191024232139.GA76771@generichostname>
        <xmqq5zkdebez.fsf@gitster-ct.c.googlers.com>
        <20191104191739.GA61441@generichostname>
Date:   Wed, 06 Nov 2019 11:37:35 +0900
In-Reply-To: <20191104191739.GA61441@generichostname> (Denton Liu's message of
        "Mon, 4 Nov 2019 14:17:39 -0500")
Message-ID: <xmqqy2wtvifk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 659D939E-003E-11EA-8DA5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Fri, Oct 25, 2019 at 12:44:52PM +0900, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>> 
>> > There haven't been any comments in a couple days so I think this
>> > patchset is ready for inclusion.
>> 
>> It's not like we are in a hurry that we need to fast-forward a topic
>> like this one (i.e. general improvement and clean-up, rather than
>> fixing regressions introduced in the cycle), so "a couple of days"
>> is probably being too impatient.
>
> Since v2.24.0 has been released, would now be a good time to queue this
> patchset?

We'd prefer a positive ack or two.

Since they are rather ancient messages in Git timescale, perhaps
send a new version that is rebased (and retested) on top of 2.24
to ask for reviews?

Thanks.

