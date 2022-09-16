Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DABECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIPQTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIPQTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:19:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF50B6034
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:19:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86C4713554E;
        Fri, 16 Sep 2022 12:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/9kD2XzujwpxFwnHnaKu8/uWRSqsaJh8SR/0uw
        McHi4=; b=gnpRc3MnGMaSWCEsu8wNSSULuyAN86b5GPydzF65zBaA1Jzyk08meX
        GJjOkKaNNQ8Pjijd8WOHFmVFNeDQNqPJTh+XIOOVcjehljwwjEe+BTbSlWNYZRDA
        5gCfXQvBfOM17U9ng2XEJF3x+nItrP90hbwoqKnmflnrI2egd/37o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A4E713554C;
        Fri, 16 Sep 2022 12:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADF7513554A;
        Fri, 16 Sep 2022 12:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fangyi Zhou <me@fangyi.io>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] help: reword explanation line for developer interfaces
References: <pull.1330.git.git.1663333529294.gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 09:19:17 -0700
In-Reply-To: <pull.1330.git.git.1663333529294.gitgitgadget@gmail.com> (Fangyi
        Zhou via GitGitGadget's message of "Fri, 16 Sep 2022 13:05:29 +0000")
Message-ID: <xmqqsfkri96i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50C18E32-35DB-11ED-9AE0-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fangyi Zhou <me@fangyi.io>
>
> Signed-off-by: Fangyi Zhou <me@fangyi.io>
> ---
>     help: reword explanation line for developer interfaces
>     
>     Signed-off-by: Fangyi Zhou me@fangyi.io

> -	{ CAT_developerinterfaces, N_("Developer-facing file file formats, protocols and interfaces") },
> +	{ CAT_developerinterfaces, N_("Developer-facing file formats, protocols and other interfaces") },

Yuck.  Thanks for catching this.

>  	{ 0, NULL }
>  };
>  
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 4ed2f242eb2..dbfc5c82676 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -231,7 +231,7 @@ test_expect_success "'git help -a' section spacing" '
>  
>  	User-facing repository, command and file interfaces
>  
> -	Developer-facing file file formats, protocols and interfaces
> +	Developer-facing file formats, protocols and other interfaces
>  	EOF

Apparently the writer of the test was not doing a good job; and of
course the reviewers, too X-.

These all came from 844739ba (git docs: add a category for file
formats, protocols and interfaces, 2022-08-04), as a part of a
large series.

Will queue.
