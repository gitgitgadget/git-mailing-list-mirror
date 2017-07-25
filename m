Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17471F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdGYUqp (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:46:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54786 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752546AbdGYUqn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:46:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41A8C74763;
        Tue, 25 Jul 2017 16:46:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wrgTTWjNKu1m
        PYDY2pqvKuuYtIs=; b=tyWPxUFwYW8swphTaI9MVegIXEZIlrp5RqJJDnlliEu/
        DhvIqSSWSIzWxsnOrBaXTTmihg60VB6xe6Q+HdVpreIq84FSboz1O6rNzCZHq1BS
        1cMIRYuZoTTmLVBoWQSvAmMZRfB9ZOuElGmhB3/LcqcGFTV8gDgsyiY4Wvufrew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=om+sQn
        3lIttboSmvUvCuSGi1AM8n4P7wwDnrYeScJlP/Zxsyk6hT1XX+tdJ99lU1acEqoc
        0YXGSE3V1F0WCB/DsHLoFsAl7gSIxU7gX26NfdkgzmvadDCyJjn0Olj5s4fYLBby
        c6neYaEJmMY3Vhi6cr6PFNtzTZdZqkEyqzIsk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A89574762;
        Tue, 25 Jul 2017 16:46:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A67A574761;
        Tue, 25 Jul 2017 16:46:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
        <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
        <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr>
        <xmqq7ez1j0wv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707221320350.4271@virtualbox>
        <xmqqa83wfoxj.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707251219480.4271@virtualbox>
Date:   Tue, 25 Jul 2017 13:46:35 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707251219480.4271@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Jul 2017 12:20:47 +0200 (CEST)")
Message-ID: <xmqqfudkutw4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 59F0988E-717A-11E7-950E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Sat, 22 Jul 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> > On Fri, 21 Jul 2017, Junio C Hamano wrote:
>> >
>> >> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
>> >>=20
>> >> > Le 20/07/2017 =C3=A0 20:57, Junio C Hamano a =C3=A9crit :
>> >> >>
>> >> >> +	git diff --quiet HEAD && git diff --quiet --cached
>> >> >> +
>> >> >> +	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
>> >> >
>> >> > Does PRIuMAX make sense for perl and sh files?
>> >>=20
>> >> Not really; I did this primarily because I would prefer to keep
>> >> things consistent, anticipating there may be some other things we
>> >> need to replace before running gettext(1) for other reasons later.
>> >
>> > It would add unnecessary churn, too, to add those specific exclusion=
s and
>> > make things inconsistent: the use of PRItime in Perl or shell script=
s
>> > would already make those scripts barf. And if it is unnecessary chur=
n...
>> > let's not do it?
>>=20
>> Sorry, but I cannot quite tell if you are in favor of limiting the
>> set of source files that go through the sed substitution (because we
>> know PRIuMAX is just as nonsensical as PRItime in perl and shell
>> source), or if you are in favor of keeping the patch as-is (because
>> changing the set of source files is a churn and substitutions would
>> not hurt)?
>
> I was in favor of keeping the simplest strategy: simply cover all files=
,
> including Perl and Unix shell scripts. It would not bring any benefit t=
o
> exclude them.

OK.  I actually was OK to limit the potential damage to C sources,
but it does not matter that much in the bigger picture.

