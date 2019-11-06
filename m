Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FDCB1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 12:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfKFMPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 07:15:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63010 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfKFMPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 07:15:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38A61886F5;
        Wed,  6 Nov 2019 07:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x9qmu9JjFzQDKe/mQ8VEG6G2HYg=; b=EP4dVV
        gDS2A0tLTTWr5R0cNpIZ+LDbY3m9/3YwZMoKm5UYLsbrx0ZdNVgxb7rn7ThS6fPD
        RMYB8lRuwNaowAAqMaCJlNGtHKJhfpU+xMrqSRw2sXJglAzHaaesRLAAm2bRIZLc
        mV3B0nPh6STFDXT+XYAee4xryaLdkLv6xR2F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AArjAWnEwtq0F7r/Ac/2enK3H7+5D5BV
        LdUDYiNqz/vQS1h0tfAKrlV/7uWnB9SMC5S65OCV/h7vIqRGDrD57E4dKlO2KtDh
        iNUE+aRdHDOGpRxswWb2EMeUipywjm0DQ0fnrdG1HrEkMmhsbwcvGR1z5gsnlDCZ
        6/4Ket0yRmM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30343886F4;
        Wed,  6 Nov 2019 07:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60431886F3;
        Wed,  6 Nov 2019 07:15:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/1] remote-curl: unbreak http.extraHeader with custom allocators
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 21:15:13 +0900
In-Reply-To: <pull.453.v2.git.1573034695.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 06 Nov 2019 10:04:54
        +0000")
Message-ID: <xmqq36f1td4e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16FACEE0-008F-11EA-AF6E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Johannes Schindelin (1):
>   remote-curl: unbreak http.extraHeader with custom allocators
>
>  http.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> base-commit: 93b980e58f5624ee4e3b2dc0d0babaa97ef66d19

This fixes by immediately building on top of the patch that caused
the issue, so I should do the same so that any integration branch
(either mine or somebody else's) that has the breakage can merge the
fix in.  Good.

Thanks.
