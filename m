Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F5C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJGRyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJGRyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 13:54:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6103D77DE
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 10:54:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA4D015BCB0;
        Fri,  7 Oct 2022 13:54:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6+1/6b+Mvzgi
        ipep5iiXz6Mg8YiVipQ/X9Z7Zqbx2cI=; b=Xgp8r4WOf0Y4IhxqxDuiq7LoEurP
        WwCML/K6pabYJzMRrPuIn6Y3SKb/SBfRZlai19Bn9+bhKVN8UipZV7ZP2CvFhkOt
        jY9LEe+OQ29rRrEs88kzXVyAgIA4S6j1el1akyKEZeloFXFWWbQvzTKQDvfq9XmD
        R/+L2xC4/XL/g90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E02A415BCAF;
        Fri,  7 Oct 2022 13:54:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 281A815BCAE;
        Fri,  7 Oct 2022 13:54:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/5] CodingGuidelines: various C99 updates
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
Date:   Fri, 07 Oct 2022 10:54:00 -0700
In-Reply-To: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 7 Oct
 2022 11:30:29 +0200")
Message-ID: <xmqqk05bfrk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0708AB92-4669-11ED-A2DB-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series:
>
>  * Rephrases CodingGuidelines so that we note we're on C99, and then
>    lists exceptions and features we use. The previous prose assumed
>    C89 by default.
>
>    We still explicitly avoid opening the "feel free to use an C99
>    feature" floodgates.

The above contradicts with each other.  A sensible position to
support the "we do not open the floodgate" is that when in doubt
stick to C89 but use C99 features that are explicitly allowed.

>  * Mentions that you can use dynamic C99 initializer elements. See the
>    recent discussion at
>    https://lore.kernel.org/git/221006.86a668r5mf.gmgdl@evledraar.gmail.=
com/

Good.

>  * Allows us to use "for (int i". I didn't set out to (slightly) jump
>    the gun on this, but just pulling the trigger around ~20 days early
>    makes it easier to ...

This is a welcome change.  As anything this set of patches won't
become reality in any released version until mid December anyway,
this is the cycle to "revisit around November 2022".

>  * ...add the natural follow-up section of C99 features you explicitly
>    shouldn't be using yet, to which I added the two cases I could
>    remember (in 4-5/5).

And we do not have to say we do not use these from C99 if our base
is C89, with explicitly allowed features from C99.
