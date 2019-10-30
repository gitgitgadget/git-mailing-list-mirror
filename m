Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F14F1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 03:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfJ3Dhx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 23:37:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50880 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJ3Dhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 23:37:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C60349EDD5;
        Tue, 29 Oct 2019 23:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U+zX+xnPT9KxV/WYF9wQM6BIHV8=; b=SZCbs5
        grVAscuTZNUqVaZEmsDmA3b/QPN/hc/9V2ayE/Ix25/IbmA+a6RqFo5nTcL9TR4Z
        T1zJBxwm/vKFsCV7nDVm1nbd5FUHmH4Aw1n9WBF5R9sjARWjLJrMAQuvZ805xGwg
        YxYOdISfAkX0nau08DBT5uE7hkGOwV7UjWLTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MPFRRUZkj2iUGSuSfnFSwfdt5e2EbEfa
        7wMqLHHmJYlweKFY7xajYA3g3ua1rdX13VC3CXGbOikhk6CwF1qEnXLMzXguj0++
        22tZEypUdcVzkKIBK4CDrjOASlOX6z/s6fi61aXc0390anTpUX/vH90w2/Sl1fJ6
        C6ylE38dIG0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE8D99EDD4;
        Tue, 29 Oct 2019 23:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E4EDE9EDCC;
        Tue, 29 Oct 2019 23:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, chrisadr@gentoo.org
Subject: Re: [PATCH] apply: clarify that index information is embedded, not the index itself
References: <20191030015503.156441-1-alexhenrie24@gmail.com>
Date:   Wed, 30 Oct 2019 12:37:42 +0900
In-Reply-To: <20191030015503.156441-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 29 Oct 2019 19:55:03 -0600")
Message-ID: <xmqq36fa52ex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2930838-FAC6-11E9-9A2C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> The Spanish translation got this wrong.
> ---
>  Documentation/git-apply.txt | 2 +-
>  apply.c                     | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index b9aa39000f..474be244ca 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -92,7 +92,7 @@ OPTIONS
>  	with the `--reject` and the `--cached` options.
>  
>  --build-fake-ancestor=<file>::
> -	Newer 'git diff' output has embedded 'index information'
> +	Newer 'git diff' output has 'index information' embedded
>  	for each blob to help identify the original version that

Thanks.  

While we are looking at this paragraph, let me remind us that this
"Newer" refers to the output from "git diff" and friends newer than
ec1fcc16 ("Show original and resulting blob object info in diff
output.", 2005-10-07); it way outlived its freshness and we probably
should drop it.

> diff --git a/apply.c b/apply.c
> index f8a046a6a5..86f7cb3d88 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4987,6 +4987,10 @@ int apply_parse_options(int argc, const char **argv,
>  		OPT_BOOL('3', "3way", &state->threeway,
>  			 N_( "attempt three-way merge if a patch does not apply")),
>  		OPT_FILENAME(0, "build-fake-ancestor", &state->fake_ancestor,
> +			/*
> +			 * TRANSLATORS: Information about the index is embedded, not the
> +			 * index itself.
> +			 */

I am not sure if this helps much.  The term "index information" was
coined purely based on where this piece of info appears (i.e. on the
"index from..to" line of the diff output).  We use "object names on
the 'index' line of the patch" to build the temporary index to
perform --3way, and it is fair to say "object names are embedded on
the index line", but calling the information "index info embedded on
the index line" feels quite redundant.

It is too late for this cycle to touch the translatable strings, but
I think it is better to revamp any docs and messages that say
"embedded index information" soon after the next release.

>  			N_("build a temporary index based on embedded index information")),

Perhaps

	N_("build a temporary index using object names in the patch")

or something.

Notice I kept saying "object names" and not "blob object names"?
That is because we can show commit object name when the diff
involves a submodule.  We have a choice to make here. (1) strive to
technical correctness, somewhat sacrificing readability by avoiding
the word "blob", or (2) tell a white lie for the sake of simplicity
and pretend there is no submodule involved.  I actually think the
latter may be more appropriate here, in which case

	N_("build a temporary index using blobs recorded in the patch")

may be easier.  The documentation needs to match, but it already
pretends that there is no such thing as submodule ...

> +	Newer 'git diff' output has 'index information' embedded
>  	for each blob to help identify the original version that

... probably because the paragraph predates the invention of
the submodule mechanism.

