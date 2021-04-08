Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70182C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 07:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F338610F7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 07:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhDHHdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 03:33:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60465 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHHdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 03:33:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C055312AA05;
        Thu,  8 Apr 2021 03:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=oO7JZoNCcCsOcw6VMAGbuSHBg
        1Q=; b=H7p8TApRS51MO9jKv0VgNZwMB203JaLoAXHLux+jhyz4qUgHPc63reKWS
        ckW8gtXMryoVw3O3ZAW45YYXCR3JWZZcOs8saJ+G0k6h/JHHZiTU4B1jY1f0ivYF
        ZWAC7erUseKoo06GV03MVDXowdLRau8VrqOH7wiVFooJW2I+4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=tkjC3voQuiDiVXHtUz2
        wGaBTBczIDnyYqLNLGSobZ3wVxZmVhhGCAgOPTHZXz9xz0v03VFXfDuzkxs8AFkx
        NWnzq7cC+CifK2gHB0vfha7F2HurT0nMxV/dR46OSl2TU9gxm8noupvYztfcu3or
        qlg3cyXe3PhOkzU1bU9fpp9Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B914B12AA04;
        Thu,  8 Apr 2021 03:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1064712AA03;
        Thu,  8 Apr 2021 03:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
        <87r1jmjxdg.fsf@evledraar.gmail.com>
        <b3e00d3e-c782-9f2a-14e0-f576e50a7e55@gmail.com>
        <87czv5kaxw.fsf@evledraar.gmail.com> <xmqqy2dtww0h.fsf@gitster.g>
        <871rblk8ct.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 00:33:05 -0700
Message-ID: <xmqqsg41ut72.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A94DA1F0-983C-11EB-BF71-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But yes, it seems even more straightforward to do away with passing the
> refspec at all to "git fetch", and instead pass some (maybe internal
> only, and documented as such) "--refspec-dst-prefix=3Drefs/prefetch/"
> option to "git fetch".
>
> I.e. get_ref_map() over there is already doing a version of this loop
> over "remote->fetch.nr".
>
> So instead of "git gc" doing the loop, then passing all the refspecs on
> the command-line, it could tell "git fetch" to do the same munging when
> it does the same iteration.

That direction makes quite a lot of sense to me.

> Doing the munging in builtin/gc.c's fetch_remote() just seems like a
> relic from when we didn't care what decision builtin/fetch.c made about
> refspecs, we always wanted our custom one.
