Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC45C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 19:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7263E61413
	for <git@archiver.kernel.org>; Tue, 25 May 2021 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEYT36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 15:29:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55478 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhEYT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 15:29:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BD7B12F0C3;
        Tue, 25 May 2021 15:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l1y+qeABF+AR
        UtUDj11/3mwEFp/RYX0Iv1tQ0tMkN8M=; b=k5eEqu6W8DkTyicJ8INGWcFJYeg2
        ZHXr/UTbGU88MKQJnvMADpuUpF+5/Hh9amLZ0+tP0OT4bHu/lYDLoORMZfXzwz9F
        ymCONO5MwZzdniqJb3SwDsn7jf2HnSs438mFoqHzzG+vwwvjMbIfouzy5UodnUy0
        4jwJaIDLEDxmJeM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93F3B12F0C2;
        Tue, 25 May 2021 15:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E098512F0BF;
        Tue, 25 May 2021 15:28:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
        <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
        <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
        <xmqqh7iripzg.fsf@gitster.g> <874kerny0e.fsf@evledraar.gmail.com>
        <xmqq35ubgwpy.fsf@gitster.g> <87v977m2q6.fsf@evledraar.gmail.com>
Date:   Wed, 26 May 2021 04:28:23 +0900
In-Reply-To: <87v977m2q6.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 25 May 2021 14:09:35 +0200")
Message-ID: <xmqq5yz6ehpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5FC05CF8-BD8F-11EB-A2ED-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But I'll leave it to you, if you are convinced and do want to take this
> 2/2 after all I'll submit another trivial patch on top to remove the ne=
w
> (then unused) repo_path function, which we expect to go away anyway.

Sounds good.
