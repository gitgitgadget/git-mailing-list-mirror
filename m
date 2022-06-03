Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB48C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiFCRQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 13:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiFCRQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 13:16:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F652527C3
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 10:16:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 481B012E666;
        Fri,  3 Jun 2022 13:15:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8CxqOGfMsLUiNpkvd6zjN7Q8i+uu1nLR6EHmUx
        SMFQ0=; b=gYT4+P2Ru9swKi1zK79+3sOeYuY4DvQv7gknn68++DON9K9XaVJlUa
        YQORttNU/09X7cn2hhoX5aRB0OVB//9Rjm07/jj8YCR4pFkBfrB7GKyJG1jjKSCx
        J6F0Kt+Rgm86JnYHo0H5UavY6hH/DnaL4vJESqyGC2gUWootmmHao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E5CE12E665;
        Fri,  3 Jun 2022 13:15:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C06B12E664;
        Fri,  3 Jun 2022 13:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Aman <amanmatreja@gmail.com>, Git List <git@vger.kernel.org>,
        Konstantin Khomoutov <kostix@bswap.ru>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: About GIT Internals
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
        <Yo68+kjAeP6tnduW@invalid>
        <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
        <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
        <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
        <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
        <20220530115339.3torgv5c2zw75okg@carbon>
        <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
        <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
        <CAJoAoZmPOOp41KF=V4EhUopu+P8=UW55bkUJm6ZYiKziprtWug@mail.gmail.com>
Date:   Fri, 03 Jun 2022 10:15:57 -0700
In-Reply-To: <CAJoAoZmPOOp41KF=V4EhUopu+P8=UW55bkUJm6ZYiKziprtWug@mail.gmail.com>
        (Emily Shaffer's message of "Fri, 3 Jun 2022 08:25:24 -0700")
Message-ID: <xmqqk09xhdma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5E518D6-E360-11EC-A0C8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> 3. Would someone advise, perhaps, to have a look at an older version
>> of the source code? rather than the latest one, for some reason.

For those who want to learn from source files, I would recommend
reading all the files in the very initial commit, cover to cover.

e83c5163 (Initial revision of "git", the information manager from
hell, 2005-04-07)

With only 1244 lines spread across 11 files, it is a short-read that
is completable in a single sitting for those who are reasonably
fluent in C.  It does not have any frills, but the basic data
structures to express the important concepts are already there.


