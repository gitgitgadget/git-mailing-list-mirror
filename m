Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FD71F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbdGYUtz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:49:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52180 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752483AbdGYUtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:49:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 854A06D929;
        Tue, 25 Jul 2017 16:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KPpo5aRRfOiwllltAHqyt0fam0M=; b=DAAgIo
        Yg9dPlEC9r2du7QvzNFe3/5rVVRqC/OQ79xhxmbLpaCJdRIbww5eMdn+pK5NduAl
        QOeSJ40+RUgfHj41IXQCA4w/YDC6rXvzU2pUCe7/7LRMLR3OIjSZnO4Z1VbfmNwH
        cJUlpJClMtTDDLqEvPo+8OX3BfFUmFxW/A/zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CTaGe417YKGH7MnpAn/KGcQYNOJajBH1
        kYrxsJqH0H9uAZgAH6lYz82zB1tHbLjvehnrfHbspX3fSFLBNeKXOgPlScs9mPHl
        2GRRFFRFfBNNymgJKJXwsyguO9JDqxUnxxn2afKhO3bV8fSstzjpHlH/rGtbWljX
        AdC4ku22g4w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D7E76D928;
        Tue, 25 Jul 2017 16:49:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB2D36D927;
        Tue, 25 Jul 2017 16:49:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
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
        <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
        <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
        <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
        <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
        <alpine.DEB.2.21.1.1707221323420.4271@virtualbox>
        <xmqqeft8fp5j.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707251221160.4271@virtualbox>
Date:   Tue, 25 Jul 2017 13:49:50 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707251221160.4271@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Jul 2017 12:22:12 +0200 (CEST)")
Message-ID: <xmqqbmo8utqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE4BB524-717A-11E7-BD2A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 22 Jul 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> >> A very small hack on gettext.
>> >
>> > I am 100% opposed to this hack. It is already cumbersome enough to find
>> > out what is involved in i18n (it took *me* five minutes to find out that
>> > much of the information is in po/README, with a lot of information stored
>> > *on an external site*, and I still managed to miss the `make pot` target).
>> >
>> > If at all, we need to make things easier instead of harder.
>> >
>> > Requiring potential volunteers to waste their time to compile an
>> > unnecessary fork of gettext? Not so great an idea.
>> >
>> > Plus, each and every Git build would now have to compile their own
>> > gettext, too, as the vanilla one would not handle the .po files containing
>> > %<PRItime>!!!
>> >
>> > And that requirement would impact instantaneously people like me, and even
>> > worse: some other packagers might be unaware of the new requirement which
>> > would not be caught during the build, and neither by the test suite.
>> > Double bad idea.
>> 
>> If I understand correctly, the patch hacks the input processing of
>> xgettext (which reads our source code and generates po/git.pot) so
>> that when it sees PRItime, pretend that it saw PRIuMAX, causing it
>> to output %<PRIuMAX> in its output.
>
> Oh, I missed that. That's even worse, as it precludes what you were
> wishing for: to replace timestamp_t by a signed data type eventually.

Yup, Jiang's plan was to update the custom edition of xgettext when
it happens and the Makefile patch has a provision to avoid mistakes.

If Jiang's patch were extended so that xgettext would take a command
line option "--custom-priformat=PRItime=PRIuMAX" and upstreamed
and wildy deployed already, that would have been a good solution.
That might be a preferred outcome that may benefit other projects,
but it won't happen for at least 3 years if not more X-<.
