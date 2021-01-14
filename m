Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F65C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16D12137B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbhANT7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:59:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62965 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbhANT7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:59:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CF399DA8A;
        Thu, 14 Jan 2021 14:58:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dpBFZMrme1Y2N8lRMCdJTdn97yo=; b=lA3AVE
        kB5TgVkbR3cFnZUDpSawDVlebLShG/O6poJSOlGhF0FDfE3lb24PTcKKCcWLqM16
        xiocPcCOK3EjKGB/7OlxO2q+oUW89ubE2X488tsJcvi1ZVoAb9DJaCcU0IT0nTBd
        OHQsdvJy9w3NYmoOnUDq2K3BX7PowAC9KOvGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D+zl72OuKZ7BKUyyJqWKWBf0LwLj7+hO
        pnmtsXvz+MbzUC2kHw3telFDJag8C6cyMGX5knWVMxxxwSwcrF0lm04e2AGFV5QR
        LY1hYy7XfjImjbwll6Wyr1E76KROj2nlG0ldhgjEsE/Oc37dAwOswF3f4dROL4NQ
        VoqaHRhrMSo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13C729DA88;
        Thu, 14 Jan 2021 14:58:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 979359DA85;
        Thu, 14 Jan 2021 14:58:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-2-avarab@gmail.com>
        <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com>
Date:   Thu, 14 Jan 2021 11:58:15 -0800
In-Reply-To: <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com> (Philippe
        Blain's message of "Thu, 14 Jan 2021 12:41:20 -0500")
Message-ID: <xmqqk0sfxpd4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7939E56-56A2-11EB-B833-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> +SYNOPSIS
>> +--------
>> +$GIT_WORK_DIR/.mailmap
>
> This should be GIT_WORK_TREE, gitmodules(5) is wrong as GIT_WORK_DIR
> does not exists (my series at [1] fixes this).

Well spotted.

Can you make the suggestion into a follow-up patch to the
series to be applied on top?

Thanks.
