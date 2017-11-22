Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEE32036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdKVD2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:28:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64667 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751561AbdKVD2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:28:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E7F9BB3E7;
        Tue, 21 Nov 2017 22:28:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LVAMjsfE6oehOVxV+/UwjyuNn/w=; b=vXmRbh
        TnmMBBxYIc1GqwQ2BngYENuKlSXzd5Xhi9klvwME8cOo0P3o27QxSdSbevCyyGoN
        H03qnCdcxeOSCZDSFQKvpv8Wy9M9hH9MUQAJN+mG8cj8Jfz6gcOm3BRjOrEQ0fuz
        Jde7HEjp+MM8abJ39Ga4V7VhBCAmB+RNG1NFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O5Ft7jNUwzpl+beh7W1hwZlRItyA1H4v
        FtOYE8Cf1ZtgAmHkV5qY2EaoqCAGDPuBiylT5Y8F8SzjLejAxp8D430EasuR5HPb
        /Gy9v5sFPpCUkWkWPbq2M97LIOVA/U7tzc5gHhodbmIiuG10wDHMmUEGPKPvMNkT
        NzNGl/S9dg8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7534BBB3E5;
        Tue, 21 Nov 2017 22:28:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E138EBB3E4;
        Tue, 21 Nov 2017 22:28:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: Add missing "-n" (dry-run) option to reflog man page
References: <alpine.LFD.2.21.1711211038410.8568@DESKTOP-1GPMCEJ>
Date:   Wed, 22 Nov 2017 12:28:25 +0900
In-Reply-To: <alpine.LFD.2.21.1711211038410.8568@DESKTOP-1GPMCEJ> (Robert
        P. J. Day's message of "Tue, 21 Nov 2017 10:39:55 -0500 (EST)")
Message-ID: <xmqqh8tnvvom.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33EB65EC-CF35-11E7-9606-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> While the "git reflog" man page supports both "--dry-run" and "-n" for
> a dry run, the man page mentions only the former, not the latter.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---

I have a suspicion that this was deliberately omitted in order to
keep the lines in the description short and concise.  Just adding
5-columns may appear not to hurt too much, but these things tend to
accumulate, so...

Queued, so that I won't lose sight of it, but won't merge unless
somebody else strongly feels about it.

Thanks.

>
>   sorry, i accidentally chopped off the leading lines of the patch in
> the earlier post.
>
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> index 44c736f1a..472a6808c 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -20,9 +20,9 @@ depending on the subcommand:
>  'git reflog' ['show'] [log-options] [<ref>]
>  'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
>  	[--rewrite] [--updateref] [--stale-fix]
> -	[--dry-run] [--verbose] [--all | <refs>...]
> +	[--dry-run | -n] [--verbose] [--all | <refs>...]
>  'git reflog delete' [--rewrite] [--updateref]
> -	[--dry-run] [--verbose] ref@\{specifier\}...
> +	[--dry-run | -n] [--verbose] ref@\{specifier\}...
>  'git reflog exists' <ref>
>
>  Reference logs, or "reflogs", record when the tips of branches and
