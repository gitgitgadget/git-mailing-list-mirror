Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F1CC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 07:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhL1HBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 02:01:34 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:25719 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhL1HBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 02:01:33 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4JNQSC2N8nz5tlB;
        Tue, 28 Dec 2021 08:01:31 +0100 (CET)
Message-ID: <2a540fb3-df24-3b95-1088-f2ee228d175c@kdbg.org>
Date:   Tue, 28 Dec 2021 08:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 06/11] i18n: factorize "--foo requires --bar" and the
 like
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        git@vger.kernel.org
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
 <f83ed5cb7995e2ce3c9aac9eb4971f45bcf94e89.1640647438.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <f83ed5cb7995e2ce3c9aac9eb4971f45bcf94e89.1640647438.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.21 um 00:23 schrieb Jean-Noël Avila via GitGitGadget:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>

Two questions:

- Is "%s requires %s" already used elsewhere or is it a new translatable
string? The commit message should clarify the choice.

- Do translators know that the two %s will be substituted with options
(mostly)?

> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -297,7 +297,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  	struct packet_reader reader;
>  
>  	if (args->stateless_rpc && multi_ack == 1)
> -		die(_("--stateless-rpc requires multi_ack_detailed"));
> +		die(_("%s requires %s"), "--stateless-rpc", "multi_ack_detailed");

Here, the second %s is not an option. I hope that does not invalidate
any translation of the string.

-- Hannes
