Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA1D20A42
	for <e@80x24.org>; Wed, 22 Nov 2017 03:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdKVD3z (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:29:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55648 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751451AbdKVD3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:29:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 726D5BB407;
        Tue, 21 Nov 2017 22:29:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zw4cTZyOa7dZNrz5+fDByC1ETBI=; b=F21K6n
        rzLOGpqnD3QOzQqcNrxQjw+8SyIHdW9qi8FKCv7e2NuXyDBzxg8DdSDSNZe0uQiC
        Q1Iq4yH4YBdFzhIC9N2gzpoQRwYJib6On2VjQ8dEBBpLWoDr54NOq0LJFoiz4tXk
        bR25HRzohyDGnFo7wsStutOIczOf4ky9j21iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eVPEPvg082/ua7NyviTd5OmGM6VbEdnS
        J3fRDTpuimYkELXv8S9zvD2Nxn2JOfpRkOVJxO8eSGy0QtNCIHWn90l/GFrJXsVm
        FU6KEfd4ngNjcB6+K64IyArd+Jp0jdy3F7rCsd9DhzyEZ7EX+eJBobOyi4QYsN65
        qtov8RSxxko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B335BB406;
        Tue, 21 Nov 2017 22:29:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB0B0BB405;
        Tue, 21 Nov 2017 22:29:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] prune: add "--progress" to man page and usage msg
References: <alpine.LFD.2.21.1711211048400.8726@DESKTOP-1GPMCEJ>
Date:   Wed, 22 Nov 2017 12:29:52 +0900
In-Reply-To: <alpine.LFD.2.21.1711211048400.8726@DESKTOP-1GPMCEJ> (Robert
        P. J. Day's message of "Tue, 21 Nov 2017 10:51:52 -0500 (EST)")
Message-ID: <xmqqd14bvvm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67C31EB4-CF35-11E7-8925-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> Add mention of git prune's "--progress" option to the SYNOPSIS and
> DESCRIPTION sections of the man page, and to the usage message of "git
> prune" itself.
>
> While we're here, move the explanation of "--" toward the end of the
> DESCRIPTION section, where it belongs.

Thanks, both changes make sense.  Will queue.

>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
> diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
> index 7a493c80f..a37c0af93 100644
> --- a/Documentation/git-prune.txt
> +++ b/Documentation/git-prune.txt
> @@ -9,7 +9,7 @@ git-prune - Prune all unreachable objects from the object database
>  SYNOPSIS
>  --------
>  [verse]
> -'git prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
> +'git prune' [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]
>
>  DESCRIPTION
>  -----------
> @@ -42,12 +42,15 @@ OPTIONS
>  --verbose::
>  	Report all removed objects.
>
> -\--::
> -	Do not interpret any more arguments as options.
> +--progress::
> +	Show progress.
>
>  --expire <time>::
>  	Only expire loose objects older than <time>.
>
> +\--::
> +	Do not interpret any more arguments as options.
> +
>  <head>...::
>  	In addition to objects
>  	reachable from any of our references, keep objects
> diff --git a/builtin/prune.c b/builtin/prune.c
> index cddabf26a..d2fdae680 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -8,7 +8,7 @@
>  #include "progress.h"
>
>  static const char * const prune_usage[] = {
> -	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
> +	N_("git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"),
>  	NULL
>  };
>  static int show_only;
