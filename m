Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A4C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiDNScm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbiDNScj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:32:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5448E41
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:30:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 101471307C7;
        Thu, 14 Apr 2022 14:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g6QKjSLS4qt2
        87U9IyjGCO/9HMgaFKEhIGcKIPRfMOA=; b=VPnJ3BXoFThbIBUanKg0B6nXSEFt
        5t6IL0On0hjYzR7OfeauvXYFo2r9VHlueRNU6pT2xNSVPO4j3zIVZqSjYs3yXFNa
        Ljs5KU1q/+vUzrLVydcgbbKBeGTd6861HWFubWYvAyILDur/AcR85pDY8DpSJbmi
        +dCtDJov1aSl5/U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 071461307C5;
        Thu, 14 Apr 2022 14:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DCC51307C3;
        Thu, 14 Apr 2022 14:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH v4 0/6] CI: js/ci-github-workflow-markup rebased on
 "use $GITHUB_ENV"
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
        <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
        <xmqq35ig2c6l.fsf@gitster.g>
        <220414.86tuavde26.gmgdl@evledraar.gmail.com>
Date:   Thu, 14 Apr 2022 11:30:09 -0700
In-Reply-To: <220414.86tuavde26.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 14 Apr 2022 14:47:30 +0200")
Message-ID: <xmqqzgknzff2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EB2BC24C-BC20-11EC-94A9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> With the other 29-patch series applied on the same base as before,
>> test_failure_ does not have such "fi" inside.  Misapplication of
>> rebase or something?
>
> This re-submission was rebased on "master", so that "fi" in the context
> is from the now-landed ab/test-tap-fix-for-immediate.
>
> I saw you'd fixed that conflict already, but figured rebasing before
> submission (as usual) would be helpful anyway, sorry about the
> confusion.
>
>> In any case, I've wiggled both series in and rebuilt 'seen'.
>> Looking good as before.
>
> Thanks, the end-state of the resolution looks good, and matches what I
> have locally.

OK, I guessed that much.

It may be OK for a topic to be rebased to an updated 'master' when
it is not close to be merged to 'next', but I prefer to see a reroll
to keep the same base, unless the new round starts depending on the
new base in a way more than just textually (i.e. e.g. wants to use a
new API function), as that makes it easier to read the comparison
with the previous round because a reasonably looking range-diff may
not necessarily mean that a patch that hasn't changed much from the
previous round would fit well inside the updated context.  This is
especially true for a series on the large-ish side, as I cannot
trust range-diff for an rebased series as much as I can for an
update on the same base.

This time, I tried to queue the new ones on updated 'master' and
then compared it with the result of merging the ones that I wriggled
to apply to the same base to the same updated 'master' to make sure
the end result is the same while I was working on making them apply
before I sent the message you are responding to, so I am reasonably
happy with the result.

It may not be a bad idea, as we are in pre-release freeze anyway,
for me to discard the two topics and replace them with a fresh
application of the same version on top of 'master', as we have
already verified that the updates from the previous iteration look
reasonable, to prepare for post-release (either merging to 'next' or
taking another reroll).

Thanks.
