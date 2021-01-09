Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBFCC433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0EA239FE
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAIXVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 18:21:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62169 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIXVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 18:21:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D0468BE5D;
        Sat,  9 Jan 2021 18:20:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7NZF3vsR3EaC
        w9BYez9SMNQ3KHw=; b=O1Em4O4UnKRmKljuLK7a/0At5lPTxN/Ixd+JPVqk70oN
        TgCp2c7r5ATi42wwfO/aTpD80wLWTtkgxBvPCdjFDk/lgkmOXDm6P50WqJXD+ncr
        CEY4sNHx7CAFt4xZmoOTXjPdJq1oS6qYfkialjI4Q4Gm1mzOSR8WbP/WEXl1vFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IpMcQq
        fJi7gByTqbx9vwOc2XvYCgBIlRFLb4q+imuCNRqe2lni+BtVrUDXGTnybkiy3+h3
        WGrAhJTSCnXhjVggco/YTOw1pBKicpPPubdIde4iTN2kiCyLBn3EvQ7PLFipcVUf
        +6m9DHnEvG3bt7Y1j2JQGn2pFsTTyWq07YbhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 651EE8BE5B;
        Sat,  9 Jan 2021 18:20:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4B038BE5A;
        Sat,  9 Jan 2021 18:20:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
        <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
        <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
Date:   Sat, 09 Jan 2021 15:20:25 -0800
In-Reply-To: <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sat, 9 Jan 2021 22:05:37 +0000")
Message-ID: <xmqq4kjpelza.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 411BE714-52D1-11EB-B04D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> > FWIW there was since a re-roll on 2021-01-03, but the discussion is
>> > sort-of outstanding, so maybe that's intentional...
>>=20
>> I had an impression that those 4 or 5 patches haven't gained
>> concensus that they are good as-is.
>
> There will be another reroll.  I'm hoping to get to it this weekend.

Thanks.
