Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDDC1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 02:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfJPCJm (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 22:09:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51235 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPCJm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 22:09:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65D917C573;
        Tue, 15 Oct 2019 22:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=msmJCb/haLEdGRZldW9CyZkzCZ8=; b=qnsmrL
        Waw4VoQG2lbVxlXNfW3PthhGb6B+IhIEH8jpj6fcODLqByqfp7SKxyd9H06AABgk
        cciDQjhA8+TDCz3LtxWk7tJKVoio99ygryoPWFH1quKX8Fz4aKIlm3UeLiICbyHd
        8H/3fYwWSJci6wjWqlgLktSLc/dPdbghsdMts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mpsApOwGR796kmHB5KhMrRx1q9wWKB5l
        5vVWzPmo+TmP4Et+HuHcfheiQMflgbETsVlEurBqvqKKxSaOyOupJD/TGzwtk29h
        /U4xvZZLbpTUr1a721mWq6JA/iASxfUgq1r3Ts7AY5Qkxad9u8Yjc8Nid4Q1U85T
        6mL8+dZQkO4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D9B67C572;
        Tue, 15 Oct 2019 22:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CF327C571;
        Tue, 15 Oct 2019 22:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        <20190921121104.GA6787@szeder.dev>
        <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
        <20191007172951.GC11529@szeder.dev>
        <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
        <20191009013231.GF29845@szeder.dev>
        <04342d12-fffc-afb6-fa4e-c2e2bf88d1b6@gmail.com>
Date:   Wed, 16 Oct 2019 11:09:35 +0900
In-Reply-To: <04342d12-fffc-afb6-fa4e-c2e2bf88d1b6@gmail.com> (William Baker's
        message of "Tue, 15 Oct 2019 13:00:45 -0700")
Message-ID: <xmqqh849a1b4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0147F75C-EFBA-11E9-8979-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

> At this time there are no other MIDX_* flags and so there's always the option
> to revisit the best way to handle multiple MIDX_* flags if/when additional
> flags are added.

I do not care too deeply either way, but if you wrote it in one way,
how about completing the series without changing it in the middle,
and leave the clean-ups to a follow-up series (if needed)?
