Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450DFC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1375A61131
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhDHR2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:28:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55116 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhDHR2D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:28:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BCB5114E7A;
        Thu,  8 Apr 2021 13:27:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pLsatnmsE6wu/hImAW1tOSfo5Fw=; b=S5uKLx
        tKnLtWUiD1uKKLzcaRdByMhH+yXnPksVwhva+pXH7nYv1+ia6fm6UQSX5TtdptID
        bU2F8IrKXqs24P29bjgRVn6uVEbK6hlI4YDBzZCbLTHFeksXyDLtFhrFh370kDo5
        sAlETLYJmjZIO2ESnQpFK8YDSK4xOLMJ+x23I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kSnAFwJLz6ZKZ7cjVA+r7jpAlBMujFrL
        FnbZ/o6Cb4HLk0KAF7l2YEUo07w309cfN4Jz8hMi6gFTd5OqASI/jKQ9OHO0EjBy
        jf1ZrcF3rRxhO3WHlc6Z7cUfiOGpZMLpaOrKbSxEG0la6gxLwmThvqF7qbhz972k
        k2DBZeDAfw0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 548F4114E79;
        Thu,  8 Apr 2021 13:27:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A107B114E78;
        Thu,  8 Apr 2021 13:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/9] diff-merges: introduce --diff-merges=def
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-2-sorganov@gmail.com>
        <f6b25ea6-88b1-c167-7fd4-440be8782fcb@iee.email>
        <87eefkdfho.fsf@osv.gnss.ru>
Date:   Thu, 08 Apr 2021 10:27:48 -0700
In-Reply-To: <87eefkdfho.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        08 Apr 2021 17:21:07 +0300")
Message-ID: <xmqq8s5svg8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDC8A4BA-988F-11EB-8090-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Hi,
>
> Philip Oakley <philipoakley@iee.email> writes:
>> Hi,
>>
>> On 07/04/2021 23:56, Sergey Organov wrote:
>>> Introduce the notion of default diff format for merges, and the option
>>> "def" to select it. The default is "separate" and can't yet be
>> "def" feels a bit too short and sounds similar to "define" - why not
>> spell out in full?
>
> Dunno, it just happened. No sound reason. Will change to "default" for
> the next re-roll.

I do not immediately see the point of writing --diff-merges=default
on the command line in the first place.  If what it calls for is the
default, wouldn't it be easier to just leave it out?

But if we have to have it as one of the choice, please do not invent
such an abbreviation, especially without taking the fully-spelled
form.

Thanks.
