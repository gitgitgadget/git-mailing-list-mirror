Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B9C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E27610FF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhKHURt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:17:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52752 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbhKHURs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:17:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03577FEDDF;
        Mon,  8 Nov 2021 15:15:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5xtn+hcv5/268nhslfidpQSTnQIV+2xvXr7F5Z
        fkl2s=; b=Cfn9TU8WmfHHa8LalyOIsX4VrvN5/+SiYpx04VGtPTy3rV/+bK+Nj6
        pasxKf1PYP+mApjFZzw2BA0jBTp/Xo0pKh5kgX6ex9AFchceLZQjgHlO29Gs1k71
        ZKRR91wXZtzBgi9K/htPZ464G/HKnV7FKeNLcS6xNxvY9tFkGkIDU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD39FEDDD;
        Mon,  8 Nov 2021 15:15:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CF26FEDDC;
        Mon,  8 Nov 2021 15:15:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #02; Wed, 3)
References: <xmqq8ry44vve.fsf@gitster.g>
        <CAFQ2z_P8QGvSs5zwyOcBsbBiq+-rXSJpXzgOwwi_eg1ZB6cSSA@mail.gmail.com>
Date:   Mon, 08 Nov 2021 12:15:00 -0800
In-Reply-To: <CAFQ2z_P8QGvSs5zwyOcBsbBiq+-rXSJpXzgOwwi_eg1ZB6cSSA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 8 Nov 2021 11:33:25 +0100")
Message-ID: <xmqqfss6tnej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DF61AD0-40D0-11EC-8CEF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Nov 4, 2021 at 1:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Here are the topics that have been cooking in my tree.  Commits
>> prefixed with '+' are in 'next' (being in 'next' is a sign that a
>> topic is stable enough to be used and are candidate to be in a
>> future release).
> ..
>> * hn/reftable (2021-10-08) 19 commits
>>  - Add "test-tool dump-reftable" command.
>>..
>
> As this topic has no interaction with any other code in Git, leaving
> it cooking in 'seen' for longer doesn't provide any extra test
> assurances.

Yeah, as long as it does not break how well the existing file-based
ref backend works, it would be OK, because even if we later find a
big bug in the reftable code, nobody would get hurt by the code we
currently have in 'seen'.

> Is there something stopping this topic from graduating to next, and if so what?

Post release rebuilding of 'next', I would say, at this late point
in the cycle.  If those who are tired of waiting can start reviewing
each other's topics and work on improving them in the meantime, it
would help us to use our time better during the next cycle, I would
guess.

Thanks.
