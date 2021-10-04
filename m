Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3CAC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420066140D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhJDStH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:49:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54035 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhJDStF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:49:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37A71EC021;
        Mon,  4 Oct 2021 14:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EMzTFbtlhxJfDAy6c8P0g8V5b8OD32BxtWO6QV
        9lcC8=; b=OdtQr+R6IStUFwZlCsYWmyE+mf5tLjViAus9lSIR1rtttthRC36s+3
        i8BpkB7mfYDgvk2SGGurtXLd6HCUgT+RB8DfWzcZWvoA+weIDGYoBU1UzYgrNxcS
        Nd49CcQOFnGWkNsSoyxysYojsRSJlcQnRCcnwFDtdjZSrx/4asTeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ECBAEC020;
        Mon,  4 Oct 2021 14:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C192EC01F;
        Mon,  4 Oct 2021 14:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git send-email splits name with comma
References: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
        <87r1d0svy4.fsf@igel.home>
        <CAMuHMdUk5=sqFvy51nxv5g3UFPhQnZ-6dBOS=xVDWdTxuLKuRQ@mail.gmail.com>
Date:   Mon, 04 Oct 2021 11:47:14 -0700
In-Reply-To: <CAMuHMdUk5=sqFvy51nxv5g3UFPhQnZ-6dBOS=xVDWdTxuLKuRQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 4 Oct 2021 19:18:35 +0200")
Message-ID: <xmqqczokwrt9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E79B0F6-2543-11EC-B857-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Andreas,
>
> On Mon, Oct 4, 2021 at 4:31 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Okt 04 2021, Geert Uytterhoeven wrote:
>> > If the name of an email address contains a comma, it will be split
>> > incorrectly into multiple addresses.
>>
>> If you want to include a comma in the display-name part of an address,
>> you need to use the quoted-string form of the phrase.
>
> Adding more quoting like:
>
>     git send-email --to "\"foo bar, geert\" <geert@linux-m68k.org>"
>
> indeed works.  But I feel git send-email could do better, given it already
> receives the full email address in a single argv[] entry.

Sorry, but I do not quite follow.

If I were to send a message both to the list and to you, wouldn't

    git send-email --to "l-k@vger.k.org, geert <g@l-m68k.o>"

a valid way to do so?
