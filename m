Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E231C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhLTTIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:08:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhLTTIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:08:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFDE6179B52;
        Mon, 20 Dec 2021 14:08:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WzNGceeoB9upyr96glrj3RtMyt/O8QobbTdzZ/
        PuDqA=; b=OjLGcK6wn0IcUvYdCNfZMb3gK61qjDxDOMRGhCvkTtvmMMx3gwsPxQ
        eYWKI3xkaAzEniLra/o62QL4msty8owmD73+1N5I1W279ZiwlOiaUkEIy4H9Qli7
        JT0L0HqtbtpuEcEMuy4aww7LIe+8sa1i9acABsb3njJFcYBTRfBHA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8751179B51;
        Mon, 20 Dec 2021 14:08:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26B26179B50;
        Mon, 20 Dec 2021 14:08:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] CI: remove support for Azure CI
References: <patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2112201834050.347@tvgsbejvaqbjf.bet>
Date:   Mon, 20 Dec 2021 11:08:10 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2112201834050.347@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 20 Dec 2021 18:38:04 +0100 (CET)")
Message-ID: <xmqqwnjzw0v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D397304-61C8-11EC-AF98-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It feels premature to remove the remnants of Azure Pipelines support
> already now. It would be better to hold off a little, as much fun as
> deleting and refactoring code may be for some of us.

Some of us? ;-)

> The reason is that there are still some things that Azure Pipelines can do
> that GitHub workflows cannot, for example:
>
> - present the logs of failed tests in an intuitive manner,
>
> - re-run _only_ failed jobs.
>
> At this stage, I am not convinced yet that we should bet completely on
> GitHub workflows.

Hearing directly from somebody who knows how Azure thing is used by
this project is a good sanity check for me.  Thanks.
