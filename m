Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECEBC6FA82
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIPQFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiIPQFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:05:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC78D11A31
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:04:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C89BD1A8401;
        Fri, 16 Sep 2022 12:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q2v6Ac4F2EJecxdZyVALGqEtk0SmilxZ7lr9US
        NRqLI=; b=UyZJQudyheSbjorbT9pECklSOgFhHQSrL/LB7b8muoK4W2D/YL/Ygr
        YPAbM0+tiRdytrsXg9JsSpLbyzLxIbXHuJdaJIOLgmw8eo9C+HvKn2cM5EEs+MCF
        xiGJTgjEb3Naw9EwzCp5OsGc7IY+19jKMY8BAdWpzfRqSc6hn3v2w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0F6D1A8400;
        Fri, 16 Sep 2022 12:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C1F21A83FE;
        Fri, 16 Sep 2022 12:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fangyi Zhou <me@fangyi.io>
Subject: Re: [PATCH] bugreport: add missing closing bracket in usage line
References: <pull.1329.git.git.1663326823401.gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 09:04:52 -0700
In-Reply-To: <pull.1329.git.git.1663326823401.gitgitgadget@gmail.com> (Fangyi
        Zhou via GitGitGadget's message of "Fri, 16 Sep 2022 11:13:43 +0000")
Message-ID: <xmqq4jx7joez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D0D64FC-35D9-11ED-AFFD-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fangyi Zhou <me@fangyi.io>
>
> Signed-off-by: Fangyi Zhou <me@fangyi.io>
> ---
>     bugreport: add missing closing bracket in usage line
>     
>     Signed-off-by: Fangyi Zhou me@fangyi.io
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1329%2Ffangyi-zhou%2Fbugreport-usage-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1329/fangyi-zhou/bugreport-usage-fix-v1
> Pull-Request: https://github.com/git/git/pull/1329
>
>  builtin/bugreport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 530895be55f..a4a5a88840d 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  }
>  
>  static const char * const bugreport_usage[] = {
> -	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
> +	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]]"),
>  	NULL
>  };

OK, this came from aac0e8ff (builtin/bugreport.c: create
'--diagnose' option, 2022-08-12), which gets the SYNOPSIS
in the documentation right but misses the usage text.

An identical fix already exists as 63407051 (doc txt & -h
consistency: add missing "]" to bugreport "-h", 2022-09-05).

It may help the project more to help move the topic that contains it
forward by reviewing them, than independently coming up with an
identical fix.  The topic with the existing fix appears at

  https://lore.kernel.org/git/cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com/

Thanks.
