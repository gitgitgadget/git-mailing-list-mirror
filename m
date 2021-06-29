Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F45C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC87F61CC9
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhF2BpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:45:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhF2BpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:45:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 688ABC54C4;
        Mon, 28 Jun 2021 21:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=b3L0r2s8hFl8Pg3Hbs8yhPVRp74fvMfm6O8p4owHhCc=; b=jezt
        oxaQNwnipL2gCt0WWaQR7iYC4y3abKcPlmH+w0au9fLsZ1mb6AbhOhfZJs8inOUi
        pc3aq75p7kJ4a3PzDHWVlOjC8Elj5RMHmufNjyon0L4mQbr51MKPIBtUKnaRYPLK
        amvt5PjNKFf3fgjGDOQvDtO6gEbF7gpe/NtRKGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56576C54C3;
        Mon, 28 Jun 2021 21:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9949EC54C2;
        Mon, 28 Jun 2021 21:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
References: <xmqq4ke8pig9.fsf@gitster.g>
        <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
        <YNPM4yvk/71oeAPx@coredump.intra.peff.net>
Date:   Mon, 28 Jun 2021 18:42:41 -0700
Message-ID: <xmqq7did30q6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B0A7A80-D87B-11EB-9C58-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> .... But from your
> description (and I think the code matches this), doing:
>
>   [color]
>   ui = false
>   man = true
>
> would still disable the man-colors. So there's no way to enable this
> feature without enabling colors everywhere else. I think it should
> simply be independent of color.ui (with the exception that it may
> eventually use it as a fallback like all the other color.* booleans,
> _if_ we want to move it to default-to-on).

That matches my perception.  Thanks.
