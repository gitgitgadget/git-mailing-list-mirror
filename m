Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0575D1F462
	for <e@80x24.org>; Wed, 29 May 2019 17:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2Rba (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 13:31:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58698 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2Rb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 13:31:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C91EC14D430;
        Wed, 29 May 2019 13:31:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1eXjUXvDEv5z
        +LfJUoy1PdtZUK0=; b=WqxIYOmks2JkAuuVBQm6pQrckFxfwexcd1jtlbGOtZZr
        QzG6SbMnME8wiIuAv/CSuGkr1xrXMF9kaLy5gwVkrmC7S/JLgcmM/vw7WzSUDMuL
        4EhJTo6TKlZNbdSCda7PWcvPu2aP6BhBPH/kPJb4yLWr3KQQ1oxvjBjO8uLGOTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BHbrVs
        BD3FO1JnZqV4rZ+IG4jT9qXMtOq7yOOXMZtxc/dMAL9jQroEaaEz4nQiepRxVNnf
        LFL/wxSjhHyg0OKkWMxy50s8gB1VxKnOd9UcunMpofCE+YDoBIqaH1qkYiAO1cwF
        F7chhq9ppclw6jVejnccAvq5q/PEKxJuGuaCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C096614D42F;
        Wed, 29 May 2019 13:31:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F9CE14D42D;
        Wed, 29 May 2019 13:31:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: ab/send-email-transferencoding-fix, was Re: What's cooking in git.git (May 2019, #04; Tue, 28)
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905291424140.44@tvgsbejvaqbjf.bet>
        <877ea9mo98.fsf@evledraar.gmail.com>
Date:   Wed, 29 May 2019 10:31:22 -0700
In-Reply-To: <877ea9mo98.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 29 May 2019 14:36:03 +0200")
Message-ID: <xmqqh89dyxp1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94AF5F9E-8237-11E9-B7A0-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, May 29 2019, Johannes Schindelin wrote:
>
>> Hi Junio & =C3=86var,
>>
>> On Tue, 28 May 2019, Junio C Hamano wrote:
>>
>>> * ab/send-email-transferencoding-fix (2019-05-19) 7 commits
>>>  - send-email: fix regression in sendemail.identity parsing
>>>  - send-email: document --no-[to|cc|bcc]
>>>  - send-email: fix broken transferEncoding tests
>>>  - send-email: remove cargo-culted multi-patch pattern in tests
>>>   (merged to 'next' on 2019-05-13 at 38c6a1e7e0)
>>>  + send-email: do defaults -> config -> getopt in that order
>>>  + send-email: rename the @bcclist variable for consistency
>>>  + send-email: move the read_config() function above getopts
>>>
>>>  Since "git send-email" learned to take 'auto' as the value for the
>>>  transfer-encoding, it by mistake stopped honoring the values given
>>>  to the configuration variables sendemail.transferencoding and/or
>>>  sendemail.<ident>.transferencoding.  This has been corrected to
>>>  (finally) redoing the order of setting the default, reading the
>>>  configuration and command line options.
>>>
>>>  Will merge to 'next'.
>>
>> I just sent a reminder that the tip commit is broken under NO_PERL, an=
d
>> accompanied the report with a diff that could be squashed in. =C3=86va=
r, please
>> have a look and say yay or nay, and please let's only let this enter
>> `next` once it is fixed (because otherwise the Azure Pipeline will spa=
m me
>> every tim `next` is psuhed -- thanks, Emily, now I mistype this every
>> single time).
>
> Sorry about missing this. Your prereq addition in
> <nycvar.QRO.7.76.6.1905291106540.44@tvgsbejvaqbjf.bet> looks obviously
> correct to me.

Yeah, I recall that one from previous week.  Let's queue it on top
(and find the right place tos quash it in).

Thanks, both.
