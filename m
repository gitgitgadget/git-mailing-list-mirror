Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3405C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B4061421
	for <git@archiver.kernel.org>; Mon, 10 May 2021 06:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhEJGLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 02:11:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59448 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhEJGLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 02:11:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 486E012EAF7;
        Mon, 10 May 2021 02:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TRwRUBp06AbQys3f1kC64yR2/5K0APvhGoluUm
        dDU7g=; b=OScvrOLh/PEyBcvKL7A/ujNVDd3unW5VJCF1DXHk2JpJXabDBO+dva
        62XnFQTdy1sCbA+Y69+INN6KyL/fTDaQdaNw8XaR7xnoUw3sVH2qQc/g+AJFqRUP
        V+xgqdOzcRw9uwoXGQvAPT0hJIC2EJqf6miqctlg1teLv6C2KdYGI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40C8912EAF5;
        Mon, 10 May 2021 02:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AAEB12EAF4;
        Mon, 10 May 2021 02:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] graph: improve grammar of "invalid color" error message
References: <20210509212220.29557-1-alexhenrie24@gmail.com>
        <CAPig+cTm7rW7V2DasW2XTArHAY_91rxxm5QaF31U8rB1ZLXOvQ@mail.gmail.com>
Date:   Mon, 10 May 2021 15:10:45 +0900
In-Reply-To: <CAPig+cTm7rW7V2DasW2XTArHAY_91rxxm5QaF31U8rB1ZLXOvQ@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 9 May 2021 18:02:51 -0400")
Message-ID: <xmqqy2cnqftm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 764FD740-B156-11EB-B398-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, May 9, 2021 at 5:23 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>> Without the "d", it sounds like a command, not an error, and is liable
>> to be translated incorrectly.
>>
>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>> ---
>> diff --git a/graph.c b/graph.c
>> @@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
>> -                       warning(_("ignore invalid color '%.*s' in log.graphColors"),
>> +                       warning(_("ignored invalid color '%.*s' in log.graphColors"),
>
> Another possibility: "ignoring invalid color ... in ..."
>
> Even better: "invalid color ... in ..."

The last one, if it does not say what we did to that invalid thing,
is not as helpful as Alex's or your "another possibility".

Betweein "ignored" vs "ignoring", I do not have a preference, but
whichever one is more prevalent in our existing messages should be
used, I would think.

Thanks.
