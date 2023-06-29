Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A7EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 21:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjF2VVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2VVl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 17:21:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41746A2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 14:21:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 814A11996D1;
        Thu, 29 Jun 2023 17:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wVbKbOcyWnDjB5QBbdRrCX/4eQYxbespYojdcs
        rFM6Q=; b=NqaLR59SdGznI/WRPjChR7ZwbJq9v3vAHDDFn8hJrLCIMUChv1pWjh
        Ix4g+uGbGDk0ErF5comNxU2NRRBvGH8L/TvhyTYCNncRfnhV0LXSJCnr8IDeAhfm
        gj7GtWF1QdPe/23RtTV73QdkDsXWBEJiZAYw3u8y2hd9HTtP0pDkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7999E1996D0;
        Thu, 29 Jun 2023 17:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D37041996CF;
        Thu, 29 Jun 2023 17:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
        <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
        <owlybkgy837j.fsf@fine.c.googlers.com>
Date:   Thu, 29 Jun 2023 14:21:37 -0700
In-Reply-To: <owlybkgy837j.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Thu, 29 Jun 2023 12:42:56 -0700")
Message-ID: <xmqqedlu7yn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF4525BE-16C2-11EE-93BA-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> ...
>> +https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
>> +https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
>> +|=====
>
> This table is a little hard to read. Do you have your patch on GitHub or
> somewhere else where this table is rendered with HTML?

Great suggestion (veiled in a question).

> It would help to explain each of the answers that are filled in
> with the word "Partial", to better understand why it is the case. I
> suspect this might get a little verbose, in which case I suggest just
> giving each framework its own heading.
>
> The column names here are slightly different from the headings used
> under "Desired features"; I suggest making them the same.
>
> Also, how about grouping some of these together? For example "Diagnostic
> output" and "Coverage reports" feel like they could be grouped under
> "Output formats". Here's one way to group these:
>
>     1. Output formats
>
>     TAP support
>     Diagnostic output
>     Coverage reports
>
>     2. Cost of adoption
>
>     Vendorable / ubiquitous
>     Maintainable / extensible
>     Major platform support
>
>     3. Performance flexibility
>
>     Parallel execution
>     Lazy test planning
>     Runtime-skippable tests
>     Scheduling / re-running
>
>     4. Developer experience
>
>     Mocks
>     Signal & exception handling
>
> I can think of some other metrics to add to the comparison, namely:
>
>     1. Age (how old is the framework)
>     2. Size in KLOC (thousands of lines of code)
>     3. Adoption rate (which notable C projects already use this framework?)
>     4. Project health (how active are its developers?)
>
> I think for 3 and 4, we could probably mine some data out of GitHub
> itself.

Great additions (if we are mere users do we care much about #2,
though?).
