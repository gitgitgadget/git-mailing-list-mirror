Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5721C207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbcI2Tmo (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:42:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755334AbcI2Tmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:42:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36DEF42037;
        Thu, 29 Sep 2016 15:42:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dy2bob49/cJu7I3R5LwPGLeQNuY=; b=ARY7u8
        U+8XLqsbs+R9kBu8KvgDaHRjPxa1lkx6RmEWAwVV+e30uXONYq9KvauTsA6OJWOw
        MGkoZeZFQjyfWr1UKoqq3FXW+XRvn+6JCHNCwjUA2ryd4VBU+qr5hrM5SZRJgBOS
        RTaTr4+lkOeFyhiFKNCt4Vl3NyrY7zfWFFlpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lJbKoBYCPZfTwPztDpd70wFvQfvco1h1
        PbWsIdnTSvs9KNyZZtMe66ZQuIBGOfL+9Y3Ah3Gk9HT1Yh4vXgvlcfZ7yA/MHuJf
        wDLxrAZIhzQlDgCfrsbAI0UeDTF3DVQRvwlw0CUKQRCHDjzNRjceqjTMZZFjlVrR
        rcn1dPTEE30=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F0A542036;
        Thu, 29 Sep 2016 15:42:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A700542035;
        Thu, 29 Sep 2016 15:42:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com>
Date:   Thu, 29 Sep 2016 12:42:38 -0700
In-Reply-To: <CA+55aFx9Utm9yDZceks+5q9c8ydc2QMYshWwJ0G0GHWWLwSsXQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 29 Sep 2016 12:06:23 -0700")
Message-ID: <xmqq1t02fq6p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1FE096C-867C-11E6-BECB-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Sep 29, 2016 at 11:55 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> For the kernel, just the *math* right now actually gives 12
>> characters. For current git it actually seems to say that 8 is the
>> correct number. For small projects, you'll still see 7.
>
> Sorry, the git number is 9, not 8. The reason is that git has roughly
> 212k objects, and 9 hex digits gets expected collisions at about 256k
> objects.
>
> So the logic means that we'll see 7 hex digits for projects with less
> than 16k objects, 8 hex digits if there are less than 64k objects, and
> 9 hex digits for projects like git that currently have fewer than 256k
> objects.

Whew.  I was wondering where my brain went wrong, as I knew we have
200k objects and 8 hexdigits means 1<<16 = 64k which is way too
short.
