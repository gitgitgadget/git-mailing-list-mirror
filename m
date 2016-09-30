Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E3F207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 20:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbcI3UBU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 16:01:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932805AbcI3UBS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 16:01:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 571783ECCB;
        Fri, 30 Sep 2016 16:01:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dPQ4AkSFXQBPAt495BDnOMAQztw=; b=mlpCwX
        LjLD9fEmm+7BbGHTgr5tUHa8gSWj2c0GR11pJJsSseGmKWX+IJUNmhnEP4LdoicY
        Gck9pJetLzcbAQgrG00WqQz9GeuAwOxUhrK6kZqCDVtzCkHyKlAmRlG459OaEtwI
        V/XC/42RolmurtkeDd3i5ocFR+62eK8zVydHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YRhugXbO6EbsoY1b0n/imO5eoyigjpvq
        YstpSHNG/FQk2vMyxMEXir/V6MaYcAbnFLmvzf5y8m+VkuY3l+1Hvt80zqapsqWv
        te78RLnkDiwPyFvp07cU6Rrq70BBJ4/w3T6U7Geizcua56jCWl0V73yGAIPeHzY5
        ZJMJ/bb+n/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5017D3ECCA;
        Fri, 30 Sep 2016 16:01:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE1E83ECC9;
        Fri, 30 Sep 2016 16:01:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
        <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
        <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
        <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
        <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net>
        <CA+55aFxW1S6FNUh8YjSXkfC8=F5dka1rY-As6PWfG2rqmrsXXA@mail.gmail.com>
        <CA+55aFxyF=xX84AXr8MG14MRHwdrQw00PBM20UfqBdidaeqdMg@mail.gmail.com>
Date:   Fri, 30 Sep 2016 13:01:14 -0700
In-Reply-To: <CA+55aFxyF=xX84AXr8MG14MRHwdrQw00PBM20UfqBdidaeqdMg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 30 Sep 2016 11:21:08 -0700")
Message-ID: <xmqq4m4x9myd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B05682-8748-11E6-BD53-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Sep 30, 2016 at 10:54 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>> So IMHO, the best combination is the init_default_abbrev() you posted in
>>> [1], but initialized at the top of find_unique_abbrev(). And cached
>>> there, obviously, in a similar way.
>>
>> That's certainly possible, but I'm really not happy with how the
>> counting function looks.  And nobody actually stood up to say "yeah,
>> that gets alternate loose objects right" or "if you have tons of those
>> alternate loose objects you have other issues anyway". I think
>> somebody would have to "own" that counting function, the advantage of
>> just putting it into disambiguate_state is that we just get the
>> counting for free..
>
> Side note: maybe we can mix the two approaches, and keep the counting
> in the disambiguation state, and just make the counting function do
>
>     init_object_disambiguation();
>     find_short_object_filename(&ds);
>     find_short_packed_object(&ds);
>     finish_object_disambiguation(&ds, sha1);
>
> and then just use "ds.nrobjects". So the counting would still be done
> by the disambiguation code, it just woudln't be in get_short_sha1().
>
> So here's another version that takes that approach. And if somebody
> (hint hint) wants to do the counting differently, they can perhaps
> send an incremental patch to do that.
>
> (This patch also contains the few setup issues Junio found with the
> new "default_abbrev is negative" model)

Sorry, but I do not quite see the point in the difference between
this one and your original that had a hook in get_short_sha1(), as
it seemed to me that Peff's objection was about the counting done in
find_short_object_filename() and find_short_packed_object(), which
is (understandably) still here.



