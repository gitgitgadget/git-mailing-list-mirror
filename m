Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DA0C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D45D61166
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKWdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:33:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61727 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:33:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 074C61215B8;
        Tue, 11 May 2021 18:32:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MMb5r0poS1WeXUIl6DpkTFnHNLvACsvPwCgYBW
        fvmUA=; b=qmjMqRWAxBDrnzUinyDDxOUVEechRJ97q1uB5Lo+zbQZ63OGt21Nci
        rOsh/wmPSRf9g6JbuUFg47Bzig7Rhu6E/0zSKbONGz35Ix+BwifBNH00Ep/xY/xf
        6qJRnRIa5nu1fhmJOwVbp/uQO/7CpXpZqwIpkJs4v/V+SrpgPfyjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F40E41215B7;
        Tue, 11 May 2021 18:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 392E41215B6;
        Tue, 11 May 2021 18:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/8] [RFC] ls-files: error out on -i unless -o or -c
 are specified
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <44a1322c44026e675ea254a00f3b50d4955ac56e.1620503945.git.gitgitgadget@gmail.com>
        <xmqqbl9jrx8f.fsf@gitster.g>
        <CABPp-BE7V233NYJARGXaTUZdt+L=N55B27UrV6pOuKaKOUWRWA@mail.gmail.com>
Date:   Wed, 12 May 2021 07:32:13 +0900
In-Reply-To: <CABPp-BE7V233NYJARGXaTUZdt+L=N55B27UrV6pOuKaKOUWRWA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 May 2021 10:40:45 -0700")
Message-ID: <xmqqy2ckj40i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC8CD5C0-B2A8-11EB-BA5F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> If we are not defaulting to cached, then
>>
>>         die("ls-files -i must be used with either -o or -c");
>>
>> would also make sense.
>
> Ooh, that wording is much nicer.  I'll adopt the latter suggestion,
> but let me know if you'd rather I went the warning route.

Even though warning would be safer, I have no strong prefeference.
Either way will resolve my puzzlement.

Thanks.
