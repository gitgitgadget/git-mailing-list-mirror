Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4425DC4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F87561444
	for <git@archiver.kernel.org>; Tue, 25 May 2021 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhEYIJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 04:09:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62993 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhEYIJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 04:09:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CE3D136768;
        Tue, 25 May 2021 04:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9Z/6iqQY7Sxv
        joD5TwOUahyzZ+rkeYu28gtl9tgmbYs=; b=g7YWafQofVjipMYbFTbyR42yobvA
        RbNlw/Ffg/dZD1rbjHPsQREHsQdoUvaOl2OesKiW4HlLMr+IlKJojcsKzRTARGJj
        fng8h0W93RekpSUg3+tDgQ+Q66ryFjmlwZbjd0jJ9nHxjVfKe3POB7u6DqnTCTaK
        t2HlnMYN1jU9law=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07289136767;
        Tue, 25 May 2021 04:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D70A136766;
        Tue, 25 May 2021 04:06:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
        <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
        <YKxBIP4lkoPeCYvb@nand.local> <87y2c3mezw.fsf@evledraar.gmail.com>
Date:   Tue, 25 May 2021 17:06:33 +0900
In-Reply-To: <87y2c3mezw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 25 May 2021 09:39:02 +0200")
Message-ID: <xmqq35ubfd9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1FB0D41C-BD30-11EB-B5CD-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Well yes, it works in the sense that instead of arbitrary big value for
> delay we have the biggerest and largerest value we can manage :)
>
> I mean why do just that when we can also do this:

Don't make unnecessary changes before any release.  If a breakage
can be fixed without risking to introduce any new breakages with
code change, postpone such a change and save bandwidth to finding
and fixing _other_ regressions.

Thanks.

