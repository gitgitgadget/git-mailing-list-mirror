Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56430C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 01:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiGSBRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 21:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiGSBQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 21:16:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC12F643
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 18:16:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C42814F44B;
        Mon, 18 Jul 2022 21:16:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Cb5brFyKlzw3ojQ4pxMkUDJE9
        3xAhkQkGuqnWCxI0pE=; b=ODYZHMwKjaJMv5YVeUvxtcCpZNaaEu8Ghw0YiFvQr
        axTWCKy16S0F3oNPe0Lytzh51hn73F+okHFtwdGXZnX5Z9qdE6C/B6fok02uNuQ+
        5Y1wnozPHQPoKvQxzIbs34qlvBAYkfgoKWRFCviMmUt7sdgwiRGz3qJhyN0W1sWw
        y4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 211AD14F44A;
        Mon, 18 Jul 2022 21:16:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EF8114F449;
        Mon, 18 Jul 2022 21:16:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-repack doc: remove discussion of ancient caveat
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
        <xmqqsfn21fmt.fsf@gitster.g>
        <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
        <xmqq1qujt334.fsf@gitster.g>
        <220718.86tu7eyhvz.gmgdl@evledraar.gmail.com>
Date:   Mon, 18 Jul 2022 18:16:02 -0700
Message-ID: <xmqqk089ewbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B7DC660-0700-11ED-9CCA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Which I may have misread, but I understood as going beyond suggesting
> that we cover #2 over (or in addition to) #1, and into speculation that
> the change being suggested here was suspect because I hadn't carried ou=
t
> a "solid study of history".

OK, so there was a study of history, but the resulting commit did
not interpret and reflect what's significant in the history
correctly.  Sorry for mischaracterizing your mistake.

Lets put it this way.  Here is a statement:

    Since 1.6.0, people started to need to worry more about
    compatibility with 1.4.4 and older.

Now that statement, while it may be still correct, is irrelevant.
Why?

Even if there were tons of people who still use 1.6.0 (or 1.5.3 for
that matter, which happens to be one of my favorite releases in the
era), as long as nobody uses 1.4.4 or older, we can safely remove
such a statement from our end-user facing documentation set.  Some
archaeologists in us may care, but it is irrelevant to the general
public, as long as 1.4.4 or older have died out.  "As continued use
of 1.4.4 by people stopped being an issue long time ago, remove the
warning about interoperability" is the only thing we need to say
about this change.  We can add "that we needed to add in 1.6.0 era"
at the end but that is already too verbose.

Please do not be one of those folks we had to deal with in the past
who for whatever reason cannot admit that they were wrong.

Thanks.
