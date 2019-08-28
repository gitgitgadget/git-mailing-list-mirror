Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44ADC1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1PHB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:07:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55887 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1PHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:07:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E635880FB1;
        Wed, 28 Aug 2019 11:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ylYT1Gc5zngYu7womSDiveBIDU=; b=GFALns
        W86uZ312PYWDGMRsVVDPcWAaS+H/mgxQaIF9abxNRv8RTRU4t6SbzS+oBl50OWMD
        9lU5X+WH79ExMPt3Kr1hXt1VkGNjK0X7e2yTSv6r5XiJHwsZzEFUIYLfYfrqtExB
        YKKX5V1hY0EhfoJA6iium1VXVCMTGhSMer2w0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MsrXbt8JIXdF55J6VinrP1+gyBnY36DF
        OFJNASkzBsBWQm0RDYEqeIscoOXfuFkO4/PTfnarg//az1Oj4p5pbdfbC77DgK8E
        pJxIc1jEk6W1uui0tW0WCr+4bY4Gnpv2FETSkh6QYg1++jzDo4yTg3T5euw4Vhbu
        1DCfxBfyv3I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9A7280FB0;
        Wed, 28 Aug 2019 11:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E480280FAB;
        Wed, 28 Aug 2019 11:06:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
        <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
        <20190823030059.47ftwfne6y436e5j@dcvr>
        <CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1908281307250.46@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Aug 2019 08:06:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908281307250.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 28 Aug 2019 13:09:21 +0200 (CEST)")
Message-ID: <xmqqsgpl1g8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79AA1508-C9A5-11E9-9C42-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW if anybody cares about my opinion: I would be totally fine with
> integrating git-filter-repo into git.git, have it there for a major
> version or two, then patch `git filter-branch` to spew out a deprecation
> warning, and then remove that latter command a major version (or two)
> later.

Yup, that's just the usual deprecate then delete sequence.  The
compatibility wrapper brought up in the discussion earlier would be
a big plus ;-)
