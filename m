Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA1C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D0923133
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgLVTXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 14:23:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgLVTXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 14:23:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1998A1106B6;
        Tue, 22 Dec 2020 14:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2S4wqC7FCIdNni+z0zzJffOmasE=; b=aVNY4g
        BngFf48MBhzpZxOSRj/wBBK5tYBavUG9A8m+zKC/Lpd9I26obxSASGOkWXwGI7wP
        IrayUxmG2hEV9GdZdieEUmdhLIBQlixY/7wT1J/E9tCPPe0imQAgj2aZEEms0zwU
        L/1a+Tahcvty4sRUq2HxSF1l5kyxeDdIIKeyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r/YVhiz5jxjoRbCVHtkK0ml40ZdpuPFy
        bcRy5J7IrnmhsMOD04hNCw7qpbT9Qi6nEQZke95jsKPIm88sUZceOBot0ARcKMif
        4+Bmm7GNxbRt9UqMcTOTYRRt0nAXnVYp3NjuEioNXdF2XbJFG2Q25RrmoAi9thoY
        +3K2pRVPUt8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 125B91106B5;
        Tue, 22 Dec 2020 14:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DDF21106B4;
        Tue, 22 Dec 2020 14:22:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] Modernizing the t7001 test script
References: <20200925170256.11490-1-shubhunic@gmail.com>
        <CAPig+cTwHuTA=puzPfpOiMcMUkYPsbOca1GQK=dS1hJJeZZBGg@mail.gmail.com>
        <CAD=kLpvWo3AuBsY8-tQSiuTOnAt5hp-hyO90SzCX5fFmKfahuQ@mail.gmail.com>
Date:   Tue, 22 Dec 2020 11:22:24 -0800
In-Reply-To: <CAD=kLpvWo3AuBsY8-tQSiuTOnAt5hp-hyO90SzCX5fFmKfahuQ@mail.gmail.com>
        (Shubham Verma's message of "Thu, 1 Oct 2020 11:12:23 +0530")
Message-ID: <xmqqk0t9ir2n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 066E360C-448B-11EB-885F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shubham Verma <shubhunic@gmail.com> writes:

> On Fri, Sep 25, 2020 at 11:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
>> > In this patch series modernize the t7001 test script by changing the
>> > style of its tests from an old one to the modern one and by cleaning
>> > up the test script.
>>
>> Thanks for tackling this task. I presume it was prompted by [1] or
>> [2], as this series covers many of the items mentioned in [1].
>> Overall, the series looks good. I'll leave comments in a few of the
>> individual patches.
>>
>> [1]: https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
>> [2]: https://git.github.io/rev_news/2020/08/27/edition-66/
>
> Eric, Actually I follow the Instruction that you pointed out in [1].
> Okay, I improve the commits and make changes according to your comments.
>
> Thank You!

This series has seen quite a many review comments, and as far as I
remember, none of them was a suggestion that was hard to decipher.

It has been almost 3 months---has an update been posted that I
missed?

Thanks.
