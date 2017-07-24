Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A2D203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756676AbdGXTMg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:12:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55880 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756221AbdGXTKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:10:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D633099A8C;
        Mon, 24 Jul 2017 15:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Kqeebcnx5Dxg
        aALDXCAMujf8gYo=; b=ojrtfNtb/dLfiXSKBYOwBeYMNPXKTBVdnMaFe7puP9A5
        2V+sUxlO0ZtOyeS84Pmfr1yRBwi1pYHsyPmhPJLZ61xVO/nqTtoUnnyzplHqEA1w
        GaZQWQQwwpk7kW8lJZQNM+hZqAQZr5pZa6WI/lIEkBDZl5X1LX3crhYj1LizNnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vNcNJP
        1i/n1Aduek6LsXolFDbMW3+Pe0hBuGHlaa0NqvK/LKuRHfhMpi2D7jNT4/usiLtP
        susV6geBrEgx2ttgQaA3gb5S2OxOZK6iB96qT5OXpIhfy4QHV8AWXBrYqqd9FlxN
        RN4FnZYDf8RNoNIAuS3Epcjms0ZJiGbMQPd5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAF6999A8B;
        Mon, 24 Jul 2017 15:10:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B20299A86;
        Mon, 24 Jul 2017 15:10:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jean-noel.avila@scantech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
        <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
        <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
        <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
        <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
        <2421d5f3-12ee-833b-72d8-de627fbfe26c@scantech.fr>
        <CANYiYbHi2tbRj159LgLpNRb7esMwZWOjetShF2n51rBavGYsGQ@mail.gmail.com>
Date:   Mon, 24 Jul 2017 12:10:01 -0700
In-Reply-To: <CANYiYbHi2tbRj159LgLpNRb7esMwZWOjetShF2n51rBavGYsGQ@mail.gmail.com>
        (Jiang Xin's message of "Mon, 24 Jul 2017 10:02:53 +0800")
Message-ID: <xmqq8tjdejna.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2EE4364-70A3-11E7-A2CA-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> 2017-07-23 10:33 GMT+08:00 Jean-No=C3=ABl AVILA <jean-noel.avila@scante=
ch.fr>:
>> Plus, I hope that some day, instead of translators finding afterwards
>> that a change broke i18n capabilities, developpers would have some kin=
d
>> of sanity check. Requiring special versions of i18n tooling stops this=
 hope.
>
> It would be fun to create some tools to help l10n guys finding l10n
> changes on every git commit.

It is not just fun but would be useful, I would think.
