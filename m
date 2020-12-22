Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61106C433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B8820705
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgLVT6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 14:58:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60176 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVT6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 14:58:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16DE31109B7;
        Tue, 22 Dec 2020 14:58:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mvwlwWOzL3aj4B4+xLdAzeX6358=; b=d6hQbb
        OwglYOaRXLJ7TflxPbtxYiwTrkNbVi+o92wEIdiwy3zPMJ6Dhw6oNg6zpMEZWeZJ
        uL3KmaZvjCYyHCg5FFP0hliFv4RfLK4W6Q/txkLZUhwScykoO0OKe23hk08FX25H
        MwdbjxHb1jWj89vfcWJGhzaFdneFEYuIL6fDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h7p0LsMmPXk6eQLdcVQHpTr87pb2szfP
        cwgeuTb2eakXtqq+AeWYfOH/dBGaZcHTYLttHiiL1GSL5+sxZZ+OC2rxHu6rRA+9
        aKaeYoImAFj0RUgD93oywkC4zMOUnAG9cFJgx+HPT+8Uxo/UKxCxEPGB7goZMj2f
        1Do+ZA9ZtqU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1001D1109B6;
        Tue, 22 Dec 2020 14:58:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FE1D1109B5;
        Tue, 22 Dec 2020 14:58:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-send-email.txt: Mention less secure
 app access might need to enable.
References: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
        <20200829153920.17155-1-vvavrychuk@gmail.com>
        <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
        <xmqqft85i72s.fsf@gitster.c.googlers.com>
        <xmqqmu224lpm.fsf@gitster.c.googlers.com>
Date:   Tue, 22 Dec 2020 11:58:03 -0800
In-Reply-To: <xmqqmu224lpm.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 06 Sep 2020 14:52:21 -0700")
Message-ID: <xmqqwnx9haus.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01614B86-4490-11EB-92E4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Vasyl Vavrychuk <vvavrychuk@gmail.com> writes:
>>
>> Another thing I forgot to say.
>>
>> Subject: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
>>
>> Especially with grammofix s/to enable/to be enabled/ applied, the
>> above is way too long as a title and would stand out like a sore
>> thumb in "git shortlog --no-merges v2.28.0..v2.29.0" output.
>> Something like
>>
>> Subject: [PATCH] send-email doc: mention less secure app access with GMail
>>
>> perhaps.
>>
>> Thanks.
>
> Anything new on this topic?  No rush, but I'd hate to see a
> basically good topic to be left in the stalled state too long.

Just pinging old threads that we have been expecting a reroll, but
it has been more than 3 months.  Has an update been sent that I
missed?

Thanks.
