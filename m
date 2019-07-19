Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6951F461
	for <e@80x24.org>; Fri, 19 Jul 2019 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfGSPMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 11:12:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60229 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfGSPMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 11:12:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2647E15FC54;
        Fri, 19 Jul 2019 11:12:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iUauJJ4IL5fh3h30EVnSpbhZSyg=; b=DlxiW3
        jkYbtesJt8BA+Pmmtn/v5pPq6mrXLnvp/SSmfyPtxyi8WSkIC9FxcafCgkCEOIvp
        eAaD5SQo+W+lNKa9I+9cy26nigKtbr80Mw1YaafvlBo95CRxHKyAFfhYsksIQFhZ
        V0U3pVJgHdz5j7J+JTqvmdyQPfTiYAwQBOh2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rRailTw6Mpg/R5VVd2zx6whaCvh1Cxt6
        kxlGfOckMHx6d1s3BRhlTvsjg37kozHC7Zx/OKNyL7BkgaWNAG0vHpNO/OC79+X2
        VJ1OOa0evFrnA9atYHr9ZyTjHEULYiXBHDLlLctuSEt6FfAtMf/SuycnONF4gWFJ
        Hu1XWGc2s4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B78D15FC53;
        Fri, 19 Jul 2019 11:12:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75F8415FC52;
        Fri, 19 Jul 2019 11:12:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, git@vger.kernel.org,
        peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH] fetch: add "--parallel", which fetches all remotes in parallel
References: <20190717015903.4384-1-palmer@sifive.com>
        <xmqq5znzz17j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907191507420.47@tvgsbejvaqbjf.bet>
Date:   Fri, 19 Jul 2019 08:12:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907191507420.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 19 Jul 2019 15:23:29 +0200 (CEST)")
Message-ID: <xmqqh87ivz1s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98348784-AA37-11E9-AD28-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have to admit that I'd _much_ rather see the strategy of
> `fetch_populated_submodules()` emulated, where it uses the
> `run_processes_parallel_tr2()` function to perform the actual fetches.

Good. Thanks for chiming in.
