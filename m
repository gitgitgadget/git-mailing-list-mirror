Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5291F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 01:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfJGBOn (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 21:14:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50020 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfJGBOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 21:14:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2B73215BE;
        Sun,  6 Oct 2019 21:14:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V3uc0L09un9ZTQ6sl66Gk4Gp+Yo=; b=l/ktH3
        ITG9yDP6Z4g6yskgQR2WIcDtgC9L6bkuVMcsFi9FQOzPEFEW2TlrbW+e3RUC7Fen
        zpLm0HXqqRH/ftTuscsySW2ENkqiFjLpGBZC4jbU/Yd4tYWXZM68qK36r1X3NF1H
        aAnvwuUUqIgp4MPd8mjV6n3PCK557YS65Yp9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o1aFrMsjDIaYK1AGyLrDYBQKuzThVtJd
        euMGq9jzC2jvf27H/y7Aks4om6vpyNvPcpM2OVi9ZcjKpBx9axGet04e9KDduMfn
        oLByFBtB57Zj6ZhzYEnEMLuoqorgr6UufEQpJ/CXCMDBY4OA+4tRufpyAU/KlLCj
        ZumVq0U1loA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9FA8215BD;
        Sun,  6 Oct 2019 21:14:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC7E8215BC;
        Sun,  6 Oct 2019 21:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
        <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
Date:   Mon, 07 Oct 2019 10:14:39 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 6 Oct 2019 22:38:26 +0200 (CEST)")
Message-ID: <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D697A9B0-E89F-11E9-A72E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I just implemented this here:
>> https://github.com/gitgitgadget/gitgitgadget/pull/128 (it still needs to
>> be reviewed and merged before it takes effect).
>
> FWIW this is now merged.

Nice.

I didn't quite understand this part, though.

    The default creation factor is 60 (roughly speaking, it wants 60% of
    the lines to match between two patches, otherwise it considers the
    patches to be unrelated).

Would the updated creation factor used which is 95 (roughly
speaking) want 95% of the lines to match between two patches?

That would make the matching logic even pickier and reject more
paring, so I must be reading the statement wrong X-<.
