Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6D21F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbfHZQHR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:07:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64773 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbfHZQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:07:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BF1C72C48;
        Mon, 26 Aug 2019 12:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ATu1kPJrLtOh7aMP3E/tA4968iQ=; b=SHK58f
        +ClbQA3cDsGMUEn07DlEEOQwd2PL4GKtbt4tXLzvU+I4KPdORdPfRIAPsp59vvHi
        PiH9Qmf53IawF1FWgl8mPgoP7vylNnAca/9LK5iDbCKNgNfumxCEFFtzRAbzBqSq
        xIQ9bpEzHC/nCGl2q+kzTnVEZNerUZdkDxDJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IKDD951rBx1lTqS/46zrbAnDCjOwlop5
        BNCtgUayhuN06ME+WlrzYSdaMH1jhvCvHZ97I+5SelqjabU+8J3I/KOQl7e9gTcE
        LovbyE4NrBCMrOwg7kNeAxkYSjo3dwSWBlVPIkrBoTypuo7PCMnB3wCLacqF0IaX
        9BtSEplZ0SI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8342E72C47;
        Mon, 26 Aug 2019 12:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADA7572C3F;
        Mon, 26 Aug 2019 12:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 12/13] Doc: add more detail for git-format-patch
References: <cover.1566285151.git.liu.denton@gmail.com>
        <cover.1566635008.git.liu.denton@gmail.com>
        <a97f861e6a9889545a61a750791257757fc5b8df.1566635008.git.liu.denton@gmail.com>
        <xmqq1rx8kl76.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Aug 2019 09:07:09 -0700
In-Reply-To: <xmqq1rx8kl76.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 26 Aug 2019 08:20:13 -0700")
Message-ID: <xmqq7e6zkj0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90028F46-C81B-11E9-9B5A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> In git-format-patch.txt, we were missing some key user information.
>> First of all, document the special value of `--base=auto`.
>>
>> Next, while we're at it, surround option arguments with <>.
>
> I'd suggest squashing this in to complete the above.
>
> cf. <xmqq1rxfveym.fsf@gitster-ct.c.googlers.com>
> cf. <xmqqimqqs7cm.fsf@gitster-ct.c.googlers.com>
> ---
>  Documentation/git-format-patch.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Ah, I see that you have squashed this into the next step.  I do not
think it belongs there, though.
