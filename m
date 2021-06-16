Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BDC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 07:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D313D6128C
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 07:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFPHbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:31:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61134 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhFPHb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 03:31:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F4029145672;
        Wed, 16 Jun 2021 03:29:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HsTJPVweyJU7o9JpLFFZl4NPhqK5lQLN0OIBbV
        OrXWw=; b=WGNQw6BBxi1X/njzi+S5pd/Si6m5qBQIaeEVrX/CccG1RwdYUn3cv9
        U2vLICSLsQyp+igFwfBiYgVnF3OdpmrlQ+uwioL4AnEuTEu+1RggDcZRnMfTCE2P
        ngedTpxRDuuuTG+hJPxxZ/ybEChtupW5ugrdgjXz7GwkgnJu04iVQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA9AD145671;
        Wed, 16 Jun 2021 03:29:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5827D14566F;
        Wed, 16 Jun 2021 03:29:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 0/9] [GSOC][RFC] cat-file: reuse ref-filter logic
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
Date:   Wed, 16 Jun 2021 16:29:12 +0900
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Tue, 15 Jun 2021 13:28:56 +0000")
Message-ID: <xmqq5yyeqncn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D1AA4BA-CE74-11EB-AC00-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series make cat-file reuse ref-filter logic, which based on
> 5a5b5f78 ([GSOC] ref-filter: add %(rest) atom)

Hmph, does anybody have 5a5b5f78?

The way to deal with this and avoid resending the same patches
(assuming that this is not a 9-patch series, but only 5 of them are
new) is to rebase your topic on 723bc66d (ref-filter: add %(rest)
atom, 2021-06-09), which will allow you to discard the 4 earlier
patches, and force push, with base set to 723bc66d, I think, but I
am not a GGG user, so there may need an extra step or two on top of
that.
