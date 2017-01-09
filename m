Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4995C205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 01:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031386AbdAIBsv (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 20:48:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965517AbdAIBsv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 20:48:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 037D55EB77;
        Sun,  8 Jan 2017 20:48:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JH5j7qos4IRVGq6eHwhoX2vu0Xs=; b=kcxolQ
        9zuUCi3vXsCSCvk1X/MuyknDrKHBePiUGLOJEgwu6I94EX9L8XiubhjEFS/iLfXb
        rz1fxZ4g58sm77K1cCXtOQHoq34J2KSauS/pChn2yWMUgrH+kWaIV3bv/0G8FAD0
        0OrEcKb5DPiKRkf9kVrGKDyhlrc0fB05r0bjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PhPP9Qrs8f+GGZAAK9HYYiN4YuI4D2zr
        vUj0VH7AyzyphYtzOf/iOYS+O9zRAjSX1ZGvngtcY9AaH3xnDydmKiIzHWWzJNYI
        rp8zVxOSXwFLbdrw7sNPtxxOyHEfWBIQ5H9EvDjaj/WGG8nr9YzuoMxK1WIYjujp
        pLTbCgyJkJ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7C895EB76;
        Sun,  8 Jan 2017 20:48:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 556EF5EB73;
        Sun,  8 Jan 2017 20:48:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] stash: fix USAGE text
References: <20170103155356.11213-1-marc.strapetz@syntevo.com>
Date:   Sun, 08 Jan 2017 17:48:48 -0800
In-Reply-To: <20170103155356.11213-1-marc.strapetz@syntevo.com> (Marc
        Strapetz's message of "Tue, 3 Jan 2017 07:53:55 -0800")
Message-ID: <xmqqpojxypdr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C40FB3DE-D60D-11E6-82A8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> Add missing usage description for stash subcommands
> 'create' and 'store'.

I think we didn't add them to usage description when we added them
because these two are not end-user facing commands but for script
writers (who do not use "$ git stash -h <ENTER>" to learn how to
use).

I dunno.

> Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
> ---
>  git-stash.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 10c284d1a..c6b9db694 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -9,7 +9,9 @@ USAGE="list [<options>]
>     or: $dashless branch <branchname> [<stash>]
>     or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
>  		       [-u|--include-untracked] [-a|--all] [<message>]]
> -   or: $dashless clear"
> +   or: $dashless clear
> +   or: $dashless create [<message>]
> +   or: $dashless store [-m|--message <message>] [-q|--quiet] <commit>"
>  
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
