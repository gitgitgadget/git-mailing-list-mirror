Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F1C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 17:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiHDRYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiHDRX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 13:23:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36762A255
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 10:23:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82F301AE132;
        Thu,  4 Aug 2022 13:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCOgrLxzgHwqLDVSQ/JnB3FLfUf1h494ccqQgc
        Dqc9U=; b=GiFTWduSRA7kG/45+GmC0yubenrt9D78qwC6SAOOb/PZ+EBRHjteni
        6pV7jT/PbSIxTp0/QwgA9d58cqeYKGgtcV6FQCsZUkSqbirxdKmOgk/hNohS8J+z
        hTLbv1ug1My2A03UA0tzHJ8Li/MPO+0SP6ShgEc8Z00bzG2hBkuv8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AB521AE131;
        Thu,  4 Aug 2022 13:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2652F1AE130;
        Thu,  4 Aug 2022 13:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 02/10] t4207: test coloring of grafted decorations
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
        <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com>
        <CAPig+cTUTXuBov4m0xvxehVFbbPjVPrAHAFfPWO5Yv4C9imyaQ@mail.gmail.com>
        <220803.86les5fpfg.gmgdl@evledraar.gmail.com>
        <CAPig+cSjHf3d6xKT71biR8Cd0iKHqBpQ6Q9_bd_w9Hgg_uE=0g@mail.gmail.com>
Date:   Thu, 04 Aug 2022 10:23:54 -0700
In-Reply-To: <CAPig+cSjHf3d6xKT71biR8Cd0iKHqBpQ6Q9_bd_w9Hgg_uE=0g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 4 Aug 2022 00:05:22 -0400")
Message-ID: <xmqqsfmb6hxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37884CA4-141A-11ED-9D86-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> it's hardly a cause for concern at this point (though, I still
> reflexively write the more portable notation as used by `OID_REGEX`
> and `_x05`, etc.).

Yeah, use of predefined constants we have in our test framework
releaves us from having to worry about the issue, which is why
I too am in favor of using them.
