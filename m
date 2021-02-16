Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167AAC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EA264DFF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBPH0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:26:51 -0500
Received: from [93.83.142.38] ([93.83.142.38]:56592 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229713AbhBPH0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 02:26:51 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 518E91C52D;
        Tue, 16 Feb 2021 08:26:29 +0100 (CET)
Subject: Re: [PATCH 2/2] diff: test and document -W interaction with -U<n>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210215155020.2804-3-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e8cd8834-0d98-9b2f-51f5-ae4f9296b9d2@kdbg.org>
Date:   Tue, 16 Feb 2021 08:26:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215155020.2804-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:50 schrieb Ævar Arnfjörð Bjarmason:
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   Documentation/diff-options.txt | 8 ++++++++
>   t/t4018-diff-funcname.sh       | 5 +++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 8ca59effa7..3c19c78616 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -88,6 +88,11 @@ endif::git-log[]
>   --unified=<n>::
>   	Generate diffs with <n> lines of context instead of
>   	the usual three.
> ++
> +Under `-W` generates diffs with at least <n> lines of context, if the
> +number is lower than the context `-U<n>` would extend the diff to then
> +`-U<n>` takes precedence.
> +

How about (not as separate paragraph):

When combined with `--function-context`, this specifies the minimum of 
context lines.

>   ifndef::git-format-patch[]
>   	Implies `--patch`.
>   endif::git-format-patch[]
> @@ -763,6 +768,9 @@ endif::git-format-patch[]
>   When showing the whole function for context the "@@" context line
>   itself will always be empty, since the context that would otherwise be
>   shown there will be the first line of the hunk being shown.
> ++
> +See the documentation for `-U<n>` above for how the two options
> +interact.

How about

Use `-U<n>` to specify a minimum of context (default three lines).

so that readers do not have to search.

-- Hannes
