Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72209C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 16:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIUQlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIUQlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 12:41:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3249F8D7
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 09:28:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C75AB1CD8B8;
        Wed, 21 Sep 2022 12:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1L5OXsoRHPZ6ICofs75SQahDC5vVDjGtDBs3GZ
        4Vkpc=; b=rDcNjH+CJj6jaRFSW0l1bLLQOiHjG5LEJE+mb14eXFHNL1YYxqz4vt
        oy4gqeehPXLxwQffSm6a0F2sOHQpkNiiYd6ENGNJw1B2h+PL4AhKR54hZK7qud4N
        VJpQHCs1QPdquNMIZfYNVAJwyi89U/zgNXN8e3Q5u6KVS4yu4vqAI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C14171CD8B7;
        Wed, 21 Sep 2022 12:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6828B1CD8B6;
        Wed, 21 Sep 2022 12:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Skrab Sah <skrab.sah@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: what if i use makeheader tool to generate c header file, it
 would be accepted.
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
        <220919.86zgev635z.gmgdl@evledraar.gmail.com>
        <xmqqbkrbb6ua.fsf@gitster.g>
        <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
Date:   Wed, 21 Sep 2022 09:28:01 -0700
In-Reply-To: <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
        (Skrab Sah's message of "Tue, 20 Sep 2022 14:10:05 +0530")
Message-ID: <xmqqpmfo66b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CF9CEF6-39CA-11ED-ABAF-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skrab Sah <skrab.sah@gmail.com> writes:

> Let me elaborate to you, how and why I wanted to implement the

No, I won't let you ;-), and that was the most important part you
seem to have missed in the message you are responding to: we do not
work with the handwaving.

>     2. no need to declare anything in the header file, which is
> time consuming and a headache for developers.

This alone is enough to convince me that this should not be done.

Unless the tool can infer the intent while generating the headers
and place comments describing why it exists and what it and its
parameters mean next to the function definition it produces, that
is, in which case I may be OK.  As developers become more and more
experienced, they will invest more and more time in getting the
interface right.  We shouldn't target developers who find the time
to do so a waste and headache.

Thanks.
