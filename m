Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01BE1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 19:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfFYTmc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 15:42:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57921 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfFYTmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0694716C288;
        Tue, 25 Jun 2019 15:42:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qsC/UTml3GxZMT/AzZU6h0RdThY=; b=mMQnKR
        mIZ2aht4z1nRJY1oGUsWdtkbwzKJwsRjOmBzHKuvZexSyqzFeb6F7Ylo3KdAeEEl
        Jn5xS3s6GyggKQI61/8nDsnqrTab4K6mOqFDlDSy97dtJ8bcBre/koIRvxyC2a2v
        I1vrSW3mkTI7s9uvZr4pcLZ/uoyDDJBQBPkEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qkuBoJ6ttOJ840cnQv9Bpi86DJ809X1O
        +nAiIXYYC5s8QH90B1aJfb3v42dX1t3I4wFgxVbVmEtnM8ZXueSS0zaIhFSRRZQW
        Lz3wNpf/OOvZbzZ+d4aKrI+n18MG5FJy2MnH3sdlQCE7q1Cjf62ve6OQ9aUuoa9N
        7Akokpx/pmk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0E6716C287;
        Tue, 25 Jun 2019 15:42:29 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6290B16C286;
        Tue, 25 Jun 2019 15:42:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: vger vs GitGitGadget, was Re: [PATCH v3 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.v2.git.gitgitgadget@gmail.com>
        <pull.151.v3.git.gitgitgadget@gmail.com>
        <1f0ceee8687e9032a7777f764b34b1c9ccc68f38.1561379363.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1906241938450.44@tvgsbejvaqbjf.bet>
        <xmqqftnyhkyu.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906251147581.44@tvgsbejvaqbjf.bet>
Date:   Tue, 25 Jun 2019 12:42:28 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906251147581.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 25 Jun 2019 12:50:00 +0200 (CEST)")
Message-ID: <xmqqa7e5fo4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF158D6-9781-11E9-8763-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > 	Again, re-sending, as something in the mail (my guess is the
>> > 	non-ASCII character in Martin's surname) seems to upset vger so
>> > 	much that it drops the mail unceremoniously.
>>
>> Hmph, but in the copy I am responding to, I can see non-ASCII
>> Martin's surname in the CC: header just fine, so vger may not
>> be at fault, perhaps?
>
> You can see the non-ASCII surname fine because you are responding to my
> reply, which I sent via Alpine.

Ah, OK. So the difference is on the sending end and vger is merely
being a coalmine canary for detectig broken sender.

> So I have a theory now why vger regurgitated on that mail: it had the
> unquoted name brian m. carlson in the Cc: line.

Ah, yes, I used to get that when sending out my messages, as
Gnus/message mode lets me write any garbage on To: or Cc: line ;-)
