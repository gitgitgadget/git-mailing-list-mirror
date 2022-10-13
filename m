Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D00C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJMVOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJMVNX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:13:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D95192BA3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:13:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 716A015E150;
        Thu, 13 Oct 2022 17:12:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SG7BABTOFgBk0Rx5L2SV+dYSXQ+ITZNXPXeTjgGMPDs=; b=hnSi
        ZIBoGvzIx3MZ3TczvztGPUm/L4vuitpTTILebKjOcTriQR2gMi9CjGGb1uf4nwyX
        gP4TlcHxBVMlGXquMN2+rmKT8P72qK7j2JjImjTCUvCML0ji3/rfT6KrEWnninPZ
        T2wQsPxkumlJQBklDqZhn3j8lT41KFSCpz41Ae8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68DC415E14F;
        Thu, 13 Oct 2022 17:12:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0A6515E14E;
        Thu, 13 Oct 2022 17:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/7] tr2tls: clarify TLS terminology
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <9dee7a75903936f086d97580441c776978d70b43.1665600750.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 14:12:47 -0700
Message-ID: <xmqqmt9zctrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA5ED43C-4B3B-11ED-8347-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  `"thread_start"`::
>  	This event is generated when a thread is started.  It is
> -	generated from *within* the new thread's thread-proc (for TLS
> -	reasons).
> +	generated from *within* the new thread's thread-proc (because
> +	it needs to access data in the thread's thread-local storage).

This is a vast improvement, not just "TLS" -> "thread-local strage",
but the original "for TLS reasons" would not be understood by anybody
who does not already know.

