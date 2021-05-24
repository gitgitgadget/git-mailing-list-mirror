Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9FC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E2361261
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhEXRx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 13:53:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55280 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhEXRx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 13:53:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DFFB713D234;
        Mon, 24 May 2021 13:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LlZ+nKkI2kEGj5QZFAIwZpZCEDKh+qQkoMIfyHs1Ka0=; b=emPO
        TJddVCcBBiVmSvyidHY7BBliKy7Jlaf+o9fmhF6VWeJVLV3bi084SZaz1cjFaUZ8
        F0Xlh1YB3SSLOYEZs9PNBHS8WWDMhRWrj9SezyeWxSyhqG396C6H6c1AsspSU3XB
        P/6EX9P3tVT7qXPjv0zRFRNiA3jY88/mlS/XsWw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D829C13D233;
        Mon, 24 May 2021 13:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 30EA613D232;
        Mon, 24 May 2021 13:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/5] doc: asciidoc cleanups
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
Date:   Tue, 25 May 2021 02:51:54 +0900
Message-ID: <xmqq7djoj9z9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAFE2294-BCB8-11EB-BEB9-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This patch series is an attempt to cleanup the Makefile of the documentation.
>
> Since v2 only certain $(RM) commands are moved from one patch to another.

The above description is correct.  I can see that the end result is
identical to the previous one.

>  Documentation/Makefile | 77 ++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 48 deletions(-)

Is this satisfactory to everybody (I haven't taken a look beyond
comparing the end results)?

It does not seem to play well with what brian is already doing in
'seen'; it overlaps with its changes in interesting ways.  Is this
series meant to be a superset of the topic and supersedes it?  How
are you two coordinating to avoid duplicated work and stepping on
each other's toes?

Thanks.


