Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F7C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E44860FD9
	for <git@archiver.kernel.org>; Tue,  4 May 2021 23:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhEDX4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 19:56:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65119 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhEDX4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 19:56:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B63BB3B11;
        Tue,  4 May 2021 19:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M5dahjst6GMgNlFPB5gKdyfoUEBA0C1/4diGO3
        bY/+c=; b=d2K5IIxQDGO3/33xhmFRJpsMsBRyOb1IDMGu/DfNdqmZIwLXEGr0Gd
        QdOjVRPEAAh5ym03QKfZV3eDJnOP+gKz7IF5ruirlwBhR0+yEbQfBqJgmPDsgFqr
        fFShiJlne6N8xSnLjWwYKPBeeZcvAwtlRT14wTXd1sinRRN3ahxuE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71DDAB3B10;
        Tue,  4 May 2021 19:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C43C3B3B0F;
        Tue,  4 May 2021 19:55:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
References: <xmqqfsz4a23x.fsf@gitster.g>
        <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
        <xmqqsg348k9j.fsf@gitster.g> <xmqqo8ds8k6r.fsf_-_@gitster.g>
        <877dkgxk9p.fsf@evledraar.gmail.com> <xmqqpmy76w31.fsf@gitster.g>
        <87czu6wuf3.fsf@evledraar.gmail.com> <xmqq7dke7jeo.fsf@gitster.g>
        <87a6pawmyu.fsf@evledraar.gmail.com>
        <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
Date:   Wed, 05 May 2021 08:55:20 +0900
In-Reply-To: <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 4 May 2021 23:17:57 +0000")
Message-ID: <xmqq35v26olz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F49633C-AD34-11EB-88CF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> One of the main reasons the Austin Group is having trouble standardizing
> it is because some shells implement it with lexical scoping and some use
> dynamic scoping, but if we try not to make too many assumptions, we'll
> probably be okay.

Thanks for raising that one.  As long as we make sure that our
script would work with anybody's "local", I do not care very much.
I just didn't think we want to spend the effort to explain that in
the documentation and enforce it---compared to the effort, just
saying "no" is certainly easier.

But if somebody wants an incremental patch on top to spell out how
"local" is allowed to be used in our scripts, that's fine by me.
