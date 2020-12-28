Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC10C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 10:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CA52242A
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgL1Kki (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:40:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59592 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgL1Kki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 05:40:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 787BD9BB15;
        Mon, 28 Dec 2020 05:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=BOpZK9SWDCsqSdHIcz/+iSPBQyg=; b=EpACDNkMscPlHewDhLJL
        1Ol3aJ+7i8nk77cZeLvGud2UJyCf5fml0twRIVRXGop1ZFrKf6KkC8LUkUiaufSX
        TTzszkymWFMj3nv1zdcGoU1goXRzLvIUB2QUc5TYXVqNBLav+WVSMa4srds85rDK
        ax2mX2siXr7rE6XUdrZN0xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=V75CvUwMP93j6Tps160kdncSQrXFRb3gngbN37JDzNh22o
        dBIUCH2CkU70X1bwSRJ1My7GwEv9G4us+oXUB0WUMMiK2cULLrx8OIAmHcn8Nmsl
        kVbvrezgAxobp28K+/0UZjnlTgZViF4RAt1BZpPqbaa0sSrofBen9yslQKd7E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D2339BB14;
        Mon, 28 Dec 2020 05:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF4519BB13;
        Mon, 28 Dec 2020 05:39:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Subject: Re: Nobody is THE one making contribution
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
        <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
        <5fe2c64bd3790_17f6720897@natae.notmuch>
        <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
        <5fe2d89c212e8_18dc12083e@natae.notmuch>
        <xmqqzh248sy0.fsf@gitster.c.googlers.com>
        <5fe36790793ae_2354120839@natae.notmuch>
        <87r1ngufmf.fsf@evledraar.gmail.com>
        <5fe424d0528a2_7855a208d3@natae.notmuch>
        <87o8ijv124.fsf@evledraar.gmail.com>
        <5fe4b33dbc028_19c920834@natae.notmuch>
        <xmqqtusa24oa.fsf@gitster.c.googlers.com>
        <5fe8c464bc190_e22d2086a@natae.notmuch>
        <xmqq5z4nqey1.fsf@gitster.c.googlers.com>
        <5fe8d6bf1a1a3_f1c220893@natae.notmuch>
Date:   Mon, 28 Dec 2020 02:39:53 -0800
Message-ID: <xmqqmtxyjjt2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 056CC896-48F9-11EB-AD4D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> >> But if you are arguing that when you write "Signed-off-by:" your
>> >> sign-off can mean something other than what DCO says it means,
>> >
>> > The DCO has clause (d), which clearly states the developer must agree
>> > that a record of his/her contribution is maintained indefinitely (and
>> > that includes his/her sign off).
>> 
>> Yes.  Are you saying that you are OK with (a)-(c) but not (d)?
>
> I'm saying if the author of the patch states "I don't agree with a
> record of my contribution being maintained indefinitely with my sign
> off", then clause (d) isn't met.

Yeah, but then why does such an author add Signed-off-by: trailer to
begin with?  Here is what Documentation/SubmittingPatches tells the
authors:

    === Certify your work by adding your `Signed-off-by` trailer

    To improve tracking of who did what, we ask you to certify that you
    wrote the patch or have the right to pass it on under the same license
    as ours, by "signing off" your patch.  Without sign-off, we cannot
    accept your patches.

    If you can certify the below D-C-O:

    [[dco]]
    .Developer's Certificate of Origin 1.1
    ____
    By making a contribution to this project, I certify that:

    a. ...; or
    b. ...; or
    c. The contribution was provided directly to me by some other
       person who certified (a), (b) or (c) and I have not modified
       it.

    d. I understand and agree that this project and the contribution
       are public and that a record of the contribution (including all
       personal information I submit with it, including my sign-off) is
       maintained indefinitely and may be redistributed consistent with
       this project or the open source license(s) involved.
    ____

    you add a "Signed-off-by" trailer to your commit, that looks like
    this:

So, "by making a contribution", the author who added a Signed-off-by
trailer is certifying that (a|b|c)&d is true.

Perhaps we can tighten the language to say "If (and only if) you can
certify" and that may reduce confusion?
