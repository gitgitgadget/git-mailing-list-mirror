Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A6CC433DF
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9184920708
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vHnFm3I/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgHPR1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:27:43 -0400
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:58477 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHPR1m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 13:27:42 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Aug 2020 13:27:40 EDT
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 710F2349E3;
        Sun, 16 Aug 2020 13:17:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KmjyIYclRgj9
        /bU9YqSJdUdSOBc=; b=vHnFm3I/plVlJolG7sMT1TkUeVpkwN8ya9XTEs3nFYNE
        pS08DPT7V0k9hqsrJ8pRPOdvDFw+alxwJ2qWdST19GqDDJD7cRvdk18EI4o/Y46t
        Kt2vpLmP7gvX+fp7qCCu3FqUtyJ49O0AIrKPKtPIOFRyDIIZOvY8b6j2BEs88Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ykswTJ
        uizPCs3t2zVT/BdO+UtrZGfeYWIt5/WRr93PBk1IqDG8FNxsG6p0n2l5GDHWEIUS
        uT0pBnW4bgq9Ei5ssnBX0PEqnat6poCalWHiyie8dlQ9xZEYc7bdeesmAmLpQJ0c
        fg20S/ZecrGWwgeymUVItOzhSobaZbrAi1kzM=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 5D6A4349E2;
        Sun, 16 Aug 2020 13:17:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA3A77B71C;
        Sun, 16 Aug 2020 13:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
        Andreas Schwab <schwab@suse.de>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Ed Maste <emaste@FreeBSD.org>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sun Chao <sunchao9@huawei.com>, Sun Chao <16657101987@163.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Update .mailmap
References: <20200805065408.1242617-1-martin.agren@gmail.com>
        <20200816153037.1143576-1-martin.agren@gmail.com>
Date:   Sun, 16 Aug 2020 10:17:34 -0700
In-Reply-To: <20200816153037.1143576-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 16 Aug 2020 17:30:37 +0200")
Message-ID: <xmqqsgcm4ij5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6054612A-DFE4-11EA-91C9-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Acked-by: Ed Maste <emaste@FreeBSD.org>
> Acked-by: Damien Robert <damien.olivier.robert+git@gmail.com>

It may be a good idea to also add two addresses for Andreas Schwab
who already answered that these should not be unified with a comment
for documentation purposes, perhaps something along the lines of...

    # These two addresses are used on purpose---do not merge.
    Human Readable Name <address1>
    Human Readable Name <address2>

to help future contributors who want to follow up on your effort.

Perhaps we also may want to have the proposed but not yet acked
entries in comment for documentation purposes, like so:

    # Asked, but not acked yet
    # Human Readable Name0 <address0.1> <address0.2>
    # Human Readable Name1 <address1.1> <address1.2>
    # ...

Thanks.
