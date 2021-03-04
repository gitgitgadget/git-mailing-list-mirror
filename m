Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E547C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492D664F79
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbhCDBPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:15:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58212 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385338AbhCDBGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:06:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 760C8110FD6;
        Wed,  3 Mar 2021 20:05:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GOukuQQTFv0iED67E+5O2R6aliw=; b=hSIZoR
        7OKBORnzzigIVm8IIJN6n5CPs0es6h9+nuFdD6RVPdGMkIGiMale1L2ikPF8E32I
        mSSdbvg2ZR6rgAQgyeN/IVP0GfBMVWc7bcs5X8NwYJUBHCH7PE7iQwwFUt4n2Ack
        cU+xpQmzzogtxflBCxU2sJMXcpWcoteMlM2ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yr9QwM3b7xHsD9VRGpzJeLGXVFFFMAu/
        fhn6Yj+oFjGqtvv/CmRCnQExsx3YVE6AIbmUvmXvDkIlw6Ji1vHNAIaleBCmDJCW
        qmS1UrKwNmEy/Jwr9QkWWGPIJO1mFhbLba/NY1BPM/hmqRSuELylw3h01iFdGPjD
        bWNLWaOttxs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CD86110FD5;
        Wed,  3 Mar 2021 20:05:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F02E110FD4;
        Wed,  3 Mar 2021 20:05:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-7-charvi077@gmail.com>
        <CAPig+cRvwvT7QrO0-aLZX-2vsBPJSq6WO-O7g5A0OjDMNAYmCQ@mail.gmail.com>
        <CAPSFM5c1zR6yz=gATGxih0wL-W18AWgCHQhL_SPno5SeTzGQGg@mail.gmail.com>
        <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
Date:   Wed, 03 Mar 2021 17:05:26 -0800
In-Reply-To: <CAPig+cRiiQyavaMGzgBkXOoGFPhMBC7GbpB61ziFMrckReFbcQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 3 Mar 2021 03:18:25 -0500")
Message-ID: <xmqqczwfg23t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5BFEFE2-7C85-11EB-B3F4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> No, as both `amend` and `reword` suboptions create "amend!" commit
>> only. I think it seems a bit confusing but I will try another attempt
>> to reword the document.
>
> Hmm, I see. So "reword!" is really just an "amend!" with only commit
> message but no patch content. That makes perfect sense from an
> implementation standpoint, but it makes me wonder if it would be
> easier for users to understand if it created a "reword!" commit which
> would be recognized as an alias of "amend!". (But maybe that's getting
> too confusing, and my musing should be ignored.)

Perhaps related, perhaps not, but I wonder if we really need --fixup=amend
and --fixup=reword to begin with.  The "amend" variant,

    $ git commit --fixup=amend:<original> ... other args ...

is about shaping the index with "other args" and recording the
resulting tree with the log message taken from <original>, marked
with the "amend!" prefix.  The --fixup=reword:<original> variant
is a mere special case of it where the recorded tree is made of the
index in the same way as a partial commit with pathspec that matches
no paths, i.e.  If you have --fixup=amend, you can do

    $ git commit --fixup=amend:<original> --only

and you do not need --fixup=reword:<original> at all, no?


