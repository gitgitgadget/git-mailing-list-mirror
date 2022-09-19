Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C97ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiISQbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISQbb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:31:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09E31366
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:31:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 431811BE8EE;
        Mon, 19 Sep 2022 12:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CkumhizkY12p
        M/u5Mp1JrSP2J8+I8Gt2UUmLqIxGt+M=; b=rFYWwHDa7LDKtgscGGJNWNk0Y16f
        jr1CGUamU4rhJFsrPEj/DH/GFxRBM66aoQ7zXBPoIIZ7RaGETksISR2dQH4HoSeu
        7JLvFiv3f2H5AuEDy8+2beNRzccVuAQKoN10KrAoC8veee0SpJEaHfIo3B+1hLrl
        S36QQ9v9tMnM2EI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B8A11BE8ED;
        Mon, 19 Sep 2022 12:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49D5B1BE8EC;
        Mon, 19 Sep 2022 12:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
        <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
        <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
        <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
        <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
Date:   Mon, 19 Sep 2022 09:31:25 -0700
In-Reply-To: <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 19 Sep 2022 15:19:44 +0000")
Message-ID: <xmqqfsgncoma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81ABA58C-3838-11ED-9732-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-09-19 at 11:20:13, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
>> I.e. I think a "deadname" use-case of this would probably:
>>=20
>> * Have some comment at the top of .mailmap about why some values are
>>   over-encoded (or perhaps it would be obvious to everyone working on
>>   that repo why someone was encoding the "plain ASCII" A-Za-z0-9 space=
).
>
> I don't think we need to do this.  First of all, it makes people curiou=
s
> and nosy, and it draws attention to the situation when in many cases,
> other contributors might not even notice as they're updating the
> mailmap.  Adding lots of attention is going to add the potential for
> harassment.
>
>> But should not:
>>=20
>> * Assume that other tools such as "fsck", "check-mailmap" or even "log=
"
>>   won't have future features that make de-obscuring these values easie=
r,
>>   or something that's part of a normal workflow.
>
> Your statement that you intended to write exactly such a feature was th=
e
> main reason I dropped the SHA-256 hashed mailmap series.  I don't think
> it's constructive to offer or propose to offer such a feature in Git if
> we're trying to obscure people's names in the mailmap, ...

Yes, I remember that exchange, and I find your position reasonable.
Yes, we all know how to build such a feature.  Yes, we know a
third-party implementation of such a feature may materialize.

But we do not have to be the ones to encourage use of such a
feature.

> I also have an alternate proposal which I pitched to some folks at Git
> Merge and which I just finished writing up that basically moves persona=
l
> names and emails out of commits, replacing them with opaque identifiers=
,

That part I can agree with.

> and using a constantly squashed mailmap commit in a special ref to stor=
e
> the mapping.

This part only half (the "special ref" half, not "constatntly
squashed" part, even though I know why it matters more to your
goal).  My gut feeling is that auditing and merging will become
nightmare.


