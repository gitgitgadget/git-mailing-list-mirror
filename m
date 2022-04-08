Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F8C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiDHSgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiDHSgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:36:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8311FE02
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:33:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70634117A23;
        Fri,  8 Apr 2022 14:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aP5pieCNvbLk
        qq5xUPs9zrELZAZ6ZiVEn0s4c+AAsWU=; b=XYAtAvtI3fYwLjwdws135dXOhpZX
        TCEHAiVA8z9wJPnYHCUlEpc+zBnumAeIr1Fm/UfYBzdGG+CaoGdoazGhbMvR09eQ
        T+/nmoykjiWnkosmD7kXkqYigMiFtsGmrCmy8ZT90rk4vhXNWEHdSoIN76NBKjE2
        Now/eoZJ/bvt3Yw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67803117A22;
        Fri,  8 Apr 2022 14:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3FA0117A21;
        Fri,  8 Apr 2022 14:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] doc txt & -h consistency: fix recent "cat-file"
 inconsistency
References: <patch-1.1-79404e05d73-20220407T185645Z-avarab@gmail.com>
        <xmqqv8vkr64h.fsf@gitster.g>
        <220408.864k34c4wo.gmgdl@evledraar.gmail.com>
Date:   Fri, 08 Apr 2022 11:33:54 -0700
In-Reply-To: <220408.864k34c4wo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 08 Apr 2022 10:55:46 +0200")
Message-ID: <xmqqee27mnl9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7291D412-B76A-11EC-B6E8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think both should have the long form, but we don't need to argue that
> point here.

Right.

>>     Side note: and no, we do not want to tie the documentation to a
>>     particular build too tightly, and it is a no-no to generate the
>>     documentation source from 'git cmd -h' output.  Even when an
>>     option is conditionally excluded from a particular build, I'd
>>     like to be able to build and publish documentation for wider
>>     audience than just to myself.
>
> I don't have changes to do that, but I think the particular concern
> you're airing here isn't an issue at all.
>
> I.e. whatever other issues we'd enocunter with such auto-generation we
> do not have *options* that are conditional on compilation, nor do we
> have commands that we build and don't build the corresponding
> documentation for.

The above seems to only scratch the status quo, while I was with
maintainer's hat on when I wrote the above, and was considering
future possibilities as well.  I can very much see us accepting a
patch to make "git grep -h" not showing "-P" when Git is built
without pcre support, for example.

Saying "at all", is a bit too strong with the argument you have, I
am afraid.
