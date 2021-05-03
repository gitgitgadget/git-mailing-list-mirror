Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC7C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 06:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A90061185
	for <git@archiver.kernel.org>; Mon,  3 May 2021 06:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhECG3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 02:29:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65123 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhECG3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 02:29:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEFFBBBB0C;
        Mon,  3 May 2021 02:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7p6vLGceCXMNCvXzRkRwbJn/eYbksh9zGU33OV
        2PPaI=; b=FRDQNUpM/MLUBqeJ1G3O9oP8QTSJaHeqqPdxGuIkVjclKWUGBf57xo
        1Kw4XAdt6Rl2kYBB/vCuH0kFwTz7q+TiA52WaE8318SY3ODpG3OvKAdqCdZ7Q4j1
        GvXuKPknKEmVdM5mbNP/FYzzxalFUC7CIeo/04t9jWvCcyrURdpdc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C61CEBBB0B;
        Mon,  3 May 2021 02:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EABABBB0A;
        Mon,  3 May 2021 02:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Josh Soref <jsoref@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/2] merge: fix swapped "up to date" message components
References: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
        <20210502051423.48123-1-sunshine@sunshineco.com>
        <20210502051423.48123-3-sunshine@sunshineco.com>
        <xmqqwnsg8kaf.fsf@gitster.g>
        <CAPig+cTf6bTpqpi2b27N2jDd_cS26VC6M6GcTRB_FSAn3m5CsQ@mail.gmail.com>
Date:   Mon, 03 May 2021 15:28:56 +0900
In-Reply-To: <CAPig+cTf6bTpqpi2b27N2jDd_cS26VC6M6GcTRB_FSAn3m5CsQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 3 May 2021 01:50:37 -0400")
Message-ID: <xmqq7dkg8h5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7015E52-ABD8-11EB-9EF4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 3, 2021 at 1:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > +     if (verbosity >= 0) {
>> > +             if (squash)
>> > +                     puts(_("Already up to date. (nothing to squash)"));
>>
>> The original scripted Porcelain may have said so, but the placement
>> of full-stop in the above feels a bit strange.  Should we rephrase
>> it to
>>
>>         Already up to date (nothing to squash).
>>
>> as we are fixing the phrasing now?
>
> I don't have a strong opinion about it, and can go either way with it.
> Josh's patch did place the full-stop after the closing parenthesis. I
> can re-roll if people think that would be preferable (unless you want
> to change it locally while queuing).

I am fine to leave this outisde the topic.
