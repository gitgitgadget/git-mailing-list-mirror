Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45656C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbiCXRgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352294AbiCXRgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:36:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD09A9B5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:34:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6AC412B83C;
        Thu, 24 Mar 2022 13:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zPK3AZy/701O
        1th3B7EbrekHTUnKcgk7Mpe8qK/ghEg=; b=dKvdaL8qq4wJwCqBKxwmnVImdV0b
        cUtNv39NE17TY7b9FE43uVAArRIH4vnQ81Uq32lzu/MZLXKs8aiCDE4a2uErLxR2
        rsIe7JIiNWgzaZ7ct2qMZ3YAo+doYQKs4yTOv0ac8IlpUoHLS5W1VvpvIRLqE+68
        e7DfwKhz89YzlXw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADB4712B83B;
        Thu, 24 Mar 2022 13:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E4FC12B83A;
        Thu, 24 Mar 2022 13:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/27] t/helper/test-fast-rebase.c: don't leak
 "struct strbuf"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-01.27-8fbafe61053-20220323T203149Z-avarab@gmail.com>
        <xmqqr16sm1im.fsf@gitster.g>
        <220324.86pmmbmglo.gmgdl@evledraar.gmail.com>
Date:   Thu, 24 Mar 2022 10:34:34 -0700
In-Reply-To: <220324.86pmmbmglo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 Mar 2022 17:57:39 +0100")
Message-ID: <xmqq35j7jlud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC0A8D5C-AB98-11EC-8880-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But I'm pretty sure if I left this out I'd have gotten questions about
> why these seemingly unrelated leak fixes are here as art of series
> implementing release_revisions(), from either you or someone else :)

That is an indication that these changes are outside the scope of
the series, and should be done as a preliminary and separate series,
isn't it?
