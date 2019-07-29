Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2571F462
	for <e@80x24.org>; Mon, 29 Jul 2019 21:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfG2VcF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 17:32:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59102 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfG2VcF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 17:32:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AEF316C266;
        Mon, 29 Jul 2019 17:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2t4xtw2eRK0Q
        cg7iyfyku9MtrLw=; b=P5aU3xghaqc56WWSr12D6UBAMNXCRbVj76DZ1BdZcAyp
        DR8FpZwWKLQ5BZR6vu44N+Zh+biGunv+8r1r0wixOp22cgt+gtrpJIVMyaeRDmZn
        fmUoWKE7T/7tFFKPfrO1SdL2KqDtuIXyGSAR1zgF8wCS78iTLt3j5cnZd3ZVonw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pvhpsz
        EXoyXTDQAZGGTyVliY4xktktpq3wAdC27s5OMZATdXiAPnHzQ/1NTux7GUsGEaLC
        kaGwz+TJLCrMzmKsUow3g0iv0ESDRqa9jh1ADjq3+3UqmIv1SAUd+DSe2LytCyiU
        etlG+KmXddt+/MSpk7zHv0W9T+pguBpOZjrfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7283116C265;
        Mon, 29 Jul 2019 17:32:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DABFF16C264;
        Mon, 29 Jul 2019 17:32:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Olivier Bornet <olivier.bornet@puck.ch>
Subject: Re: [PATCH] Documentation/git-fsck.txt: include fsck.* config variables
References: <20190729093928.GP20404@szeder.dev>
        <20190729095914.30573-1-szeder.dev@gmail.com>
        <87sgqo6ejk.fsf@evledraar.gmail.com>
        <xmqq36iox2nn.fsf@gitster-ct.c.googlers.com>
        <20190729201236.GF14943@sigill.intra.peff.net>
Date:   Mon, 29 Jul 2019 14:32:01 -0700
In-Reply-To: <20190729201236.GF14943@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 29 Jul 2019 16:12:36 -0400")
Message-ID: <xmqq5znkv86m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E184352-B248-11E9-8D58-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 29, 2019 at 08:48:28AM -0700, Junio C Hamano wrote:
>
>> > Before this include let's add:
>> >
>> >     The below documentation is the same as what=E2=80=99s found in
>> >     git-config(1):
>>=20
>> I actually do not think we would want to do that.  I am all for the
>> kind of 'include' proposed by this patch, and we should strive to
>> make it easier for us to make sure the duplicated text are in sync.
>>=20
>> But that would mean that the readers will have to see the "is the
>> same as the other one" over and over.  If our documentation set is
>> consistent, they should not have to.
>>=20
>> I think we *must* make such a note in a total opposite case,
>> i.e. "here are the summary of the most often used options; for full
>> list, see git-config(1)".
>
> I disagree. _We_ know that the content is the same, because we are
> looking at the source that says "include". But as a user, how do I know
> when I get to one section or the other that it is something I have
> already read and can skip over?

I want to raise the user expectation so that they would expect from
our documentation, unless we say "these are different", we would
never say conflicting things in two places.

So,... I disagree.
