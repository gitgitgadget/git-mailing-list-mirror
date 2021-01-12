Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D05AC433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F282310E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393099AbhALTlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:41:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50277 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393019AbhALTlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:41:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8D3D9CC54;
        Tue, 12 Jan 2021 14:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5fLhabQL7GUK4OkBpUaJSTq0oc8=; b=RWEZmX
        FJwmGJOoO8qYyJ+AoG94w+MJKrIT+Jw1iAjK8fBoYvRDvfpoCDfVC+e/Le+LiUHW
        K56gEB1Ukbuj8XoTGc5R8z3i0mQ2JLWy6E+raBOaa1G+TSnTHTkSRRUoOuykNa9Y
        SSwVFnTpRnzfu7R7CM4iJHcjuzONKt8GE26PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aywDIowh4ue8ZWjmMFAkitzVkmCCUu/Q
        rxh1pF1824oM8w8ytYgpeBh6p+rSjV4+pJbEFRKigMBQ7igMJu2q11IyExTdBMTN
        xA9TFMDsFPQ+Qicr2w9adWhOLN218onq86yF69/9STopwGgiPLvKMj10pi4J1vks
        oaMZaKVNup0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0F9B9CC53;
        Tue, 12 Jan 2021 14:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C23A9CC52;
        Tue, 12 Jan 2021 14:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/11] sha1dc: mark forgotten message for translation
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <8f2c08474a75793c24af7d4ae44d73d2b23920bc.1610441263.git.gitgitgadget@gmail.com>
        <X/2J8KL/Jig/xttF@coredump.intra.peff.net>
Date:   Tue, 12 Jan 2021 11:40:21 -0800
In-Reply-To: <X/2J8KL/Jig/xttF@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 12 Jan 2021 06:37:20 -0500")
Message-ID: <xmqqim823pwa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 027D3D48-550E-11EB-B2F2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 12, 2021 at 08:47:35AM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> diff --git a/sha1dc_git.c b/sha1dc_git.c
>> index 5c300e812e0..fecf5da1483 100644
>> --- a/sha1dc_git.c
>> +++ b/sha1dc_git.c
>> @@ -18,7 +18,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
>>  {
>>  	if (!SHA1DCFinal(hash, ctx))
>>  		return;
>> -	die("SHA-1 appears to be part of a collision attack: %s",
>> +	die(_("SHA-1 appears to be part of a collision attack: %s"),
>>  	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
>
> I didn't find any list discussion, but I think I may have actually left
> this untranslated intentionally. Like a BUG(), we'd expect it to come up
> basically never. And when it does, being able to search for the exact
> wording online may be more important than providing a translated
> version.
>
> It probably doesn't matter that much either way, though.

I can believe if this was intentionally left untranslated for the
reasons you stated.  Without introducing "message ID" that can be
universally readable, so that customers can report "We got E42234
when running Git version 1.2.3.4", that is the best we could do.

But I am OK to see this translated, too.

Thanks.
