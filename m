Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CFDC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD386124B
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbhIXUEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:04:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62413 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbhIXUEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:04:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FFFE167726;
        Fri, 24 Sep 2021 16:03:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QWjNFElcYXc7XqHWuKHvOqCY5heE376boyUF4V
        iU0fs=; b=owHoU3PMCjuy/oQyhtFZxi4I3EMVAm5ZDmAO2KF/b+yxTQsEvztm3h
        LhQ3nT0Yhe60VGSVexlO7OyexOj6/32fZtzGBID2P4QN4k/YRzPrx8Qb/2yUtuhD
        wR8wfu5u9b5jWZylX25JKy78cwy+jvJkmRr3/0vQGpP+6UxAZby7k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DA2B167725;
        Fri, 24 Sep 2021 16:03:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B7A2167721;
        Fri, 24 Sep 2021 16:03:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
References: <87zgs34ccx.fsf@evledraar.gmail.com>
        <20210924024606.20542-4-tbperrotta@gmail.com>
        <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
        <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
        <xmqqzgs2vvim.fsf@gitster.g>
        <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
Date:   Fri, 24 Sep 2021 13:03:00 -0700
In-Reply-To: <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 24 Sep 2021 10:34:19 -0700")
Message-ID: <xmqqo88hspvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BEDD440-1D72-11EC-8B17-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> Or do you mean
>>
>>         git send-email <options>
>>
>> and have the <options> placeholder to stand for both send-email
>> options and options meant for format-patch?
>
> the later AND including a non optional part that explains that you
> need to indicate some sort of revision ...

Ah, thanks for explanation.

    git format-patch -2

would be options-only way to "indicate some sort of revision", so
perhaps 

    . git send-email <send-email options> files|directory
    . git send-email <send-email options> <format-patch options>

(where "options" is used to refer to both --options and arguments)
would illustrate the differences better?
