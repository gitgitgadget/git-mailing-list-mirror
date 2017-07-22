Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E760F203F3
	for <e@80x24.org>; Sat, 22 Jul 2017 02:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbdGVCo6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 22:44:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53708 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751922AbdGVCo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 22:44:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 728859FE02;
        Fri, 21 Jul 2017 22:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R4eh81hofW1JFVr61gS963cEPIQ=; b=rFqn0k
        2li3nleu5ND8khVeRyLEzJ6FCWsUXH2B7myRCzXZxLByU20S0Z5+95P+rTchAkyV
        laWiqatus7TH2c6udzwWE+St39448MYezfqxRm6ZQpijf6IL/JLSNuuqjvC7eoo5
        L3CobYtIbvGns7E9RTgy5l5Nu5Q5ixgZgGA04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IGWJVsoLmzyeDFHusLEIktsYtKIMm5O6
        I+y1zrYFVVWYHDSp4TiJ3vlgmVP7A3Rz4IyKfTE5ZqGjQ805KsKuL90N2CAPf2dB
        2fYReFZ0ImkaVDpUDHq54MBFEzH53UwX3duorgMmnb5b/9WrkeHau1pbSt1lC8tA
        tgTHNIuDpV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 692E99FE01;
        Fri, 21 Jul 2017 22:44:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE5B79FE00;
        Fri, 21 Jul 2017 22:44:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
Date:   Fri, 21 Jul 2017 19:44:48 -0700
In-Reply-To: <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
        (Jiang Xin's message of "Sat, 22 Jul 2017 08:43:18 +0800")
Message-ID: <xmqqmv7xfavz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB35AA8A-6E87-11E7-9F97-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> But it is rare to maintain po/git.pot file for 'maint' branch.  And if
> I need, I will switch to a different version of gettext.  Makefile
> will throw a error message, if I use a wrong version of gettext.

Is that the "v1" in the check in your Makefile patch is about?  That
is, when we need to change the underlying type, your updated gettext
would say something different from "v1" and you will have Makefile
update to expect that new version?  Then it would be workable, I'd
guess.

>> Compared to that, Dscho's "hack" at least ties what PRItime is
>> replaced with and what the source code says by being in the
>> Makefile, which is tracked alongside the rest of the source.  So I
>> somehow feel that the approach has smaller chance of going wrong.
>
> Benefit of using the tweak version of gettext:
>
> 1. `make pot` can be run in a tar extract directory (without git controlled).
> 2. do not need to run `git reset --hard`.
> 3.  it's quick (nobody cares).

This is about a tool and workflow only you (and your successor, when
the time comes) need to use, so ultimately I'd prefer to leave it up
to you, but I'd want to make sure you are making your decision with
sound rationale.  I personally do not think 1. and 2. above are real
issues in practice, because (1) you'd be committing the result of
"make pot" so that translators can work off of it---which at least
to me means that being able to run on a tarball extract is not a
useful feature, and (2) when you are about to run xgettext to
extract strings from the message, you do not want to have local
modifications, extracting potentially modified strings with
potentially offset line numbers in the resulting pot file, so
having to run "git reset --hard" at the end is not a problem.

I do not know if 3. is a practical issue or not (I did try "make
pot" with the tip of 'master' tonight myself, and I didn't find it
much slower than the unmodified one).

Having said all that, again, I'd prefer to leave this up to you, so
unless I hear that you changed your mind, the tip of 'master' I'll
tag, probably sometime tomorrow my time, will have your patch to the
Makefile to rely on your private edition of xgettext.

Thanks.
