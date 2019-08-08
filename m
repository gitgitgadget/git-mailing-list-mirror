Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94A31F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfHHUHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:07:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57861 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbfHHUHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:07:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF9C282C09;
        Thu,  8 Aug 2019 16:07:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tm28WidccEKpVmHp5QVKu4i289Y=; b=B+gizx
        2Sf5OOc5XK8tfyb6oXPq0m8dFVF6WY9y7hHDRqHdiKSp26sa07h+i29BKxHYgvFP
        b3QttSgkC+/lK+MZYgKa+pqmR/T+Ok/rj9KQBfRfUZTWuQQVUpjajDTp8DVL6UMo
        YAoJK5XyusPbL4rdNGf4D7yTEdzOiGGRfHOFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dTy/ScftI3XTHSTBZ9/SmWYHaJa9xh1y
        x2BEBOB5uGVnkouDcvQ2UWKFyXUWefW2wLIA4v3MbZvqZprJA111MwOP4r3OEO1/
        2g1h6IFOnRnEPz6w2up//n//VrQSnrotMCeTPkx0xAcsd8fmq8FYCXF9xDC1L4KZ
        eG9ZyIvFUrk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6F3182C08;
        Thu,  8 Aug 2019 16:07:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1282782C06;
        Thu,  8 Aug 2019 16:07:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= 
        <avarab@gmail.com>, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
        <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
        <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
        <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
        <CABPp-BH2EHGEmOj3kpeTMV2PpKkRBpPn3FuBfNDHKA8=BkKxFQ@mail.gmail.com>
Date:   Thu, 08 Aug 2019 13:07:48 -0700
In-Reply-To: <CABPp-BH2EHGEmOj3kpeTMV2PpKkRBpPn3FuBfNDHKA8=BkKxFQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 8 Aug 2019 12:19:14 -0700")
Message-ID: <xmqqv9v7e7zf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 331B9680-BA18-11E9-9360-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> However, Stollee's commit message started with "The
> 'feature.experimental' setting includes config options that are not
> committed to become defaults".
>
> If these are settings that are "intended" but not "committed" to
> become defaults, then yes, you're absolutely right.  (And in such a
> case, it might be nice to add that distinction to the commit message.)

My understanding is that the only purpose of feature.experimental
is: "we want to change the default of X this way, but we do not know
if we missed an important use case that would be harmed by such a
change, so let's see if those who volunteered to be guinea pigs by
setting feature.experimental to true find glitches in our thinking
that led us to think the change of the default is a good idea".

