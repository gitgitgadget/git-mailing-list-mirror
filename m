Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E26C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A6B239D2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DOILHHQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVQQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 12:16:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50921 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgIVQQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 12:16:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30C7C78348;
        Tue, 22 Sep 2020 12:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fSS80AydJnRxA476YLrfYug3uAM=; b=DOILHH
        Q6MLbY+nEYpYhL1mfYaOfu7LBq3tULKkNZrTsB31b+d/DEu5jS6B45VAkWMjN+ud
        8T3vsRPpq0iiM769jaugKsNKNO3ig4zwOUbJkwNs2vk3O5G7whxp0kVkjbrA9APc
        aG+epvgYOjiMJr6BdnCeJgoAKBmuYQGrz42ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/+1+dU3DvGtOA/RGTXdFp9jgcXgrejL
        w3milyZTSAcC3Ip49cG9IbGgvaBLCQVEPln5XbMSVBjG1phZQM6KyAQ0BDB2Y811
        TYI3STx9ENKoHJftU7xbTj3CqkEJk7P34jf37ly7oYWIE2nUL0Ephjn+1zbMPMiu
        9J5Hmi+RseA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A82878347;
        Tue, 22 Sep 2020 12:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56E3F78345;
        Tue, 22 Sep 2020 12:16:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] commit: reorder synopsis
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
        <80a69318b57348c59e45c0f8df1c342ef84388d4.1600695050.git.gitgitgadget@gmail.com>
        <xmqqft7acre2.fsf@gitster.c.googlers.com>
        <2a14d3d2-743c-215e-aa69-de75a576f685@gmail.com>
Date:   Tue, 22 Sep 2020 09:16:22 -0700
In-Reply-To: <2a14d3d2-743c-215e-aa69-de75a576f685@gmail.com> (Phillip Wood's
        message of "Tue, 22 Sep 2020 14:27:22 +0100")
Message-ID: <xmqqeemtlrc9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F529980C-FCEE-11EA-B546-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> -'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
> -	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> -	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> 	   [-S[<keyid>]] [--] [<pathspec>...]
> +'git commit' [-a | --interactive | --patch] [--amend]
> +	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
> +	   [--reset-author] [--author=<author>] [--date=<date>] [-s] [-e]
> +	   [--allow-empty] [--allow-empty-message] [--no-verify]
> +	   [--cleanup=<mode>] [-u<mode>] [--[no-]status]  [-v] [--dry-run]
> 	   [-i | -o | -p] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>   	   [-S[<keyid>]] [--] [<pathspec>...]

This seems to group them better than the original, including
"--allow-empty" and its two friends that are about sanity checking.

I would actually kick "-a" out of the "--interactive | --patch"
group [*1*].  Unlike the two, it is not about a different operation
mode.  It is closer to how paths whose contents will participate in
the resulting commit are chosen, so it is much closer to the "-i"
and "-o" family, I would think.

What is "git commit -p" you have next to "-i" and "-o"?  I do not
think it belongs there---isn't it a short form of --patch?

Thanks.


[Footnote]

*1* It was originally made that way because the "add--interactive"
based operation mode was incompatible with "-a", I think.  But the
thing is, the interactive one is incompatible with other things like
"-i" and "-o".  Use of the '|' alternative notation to express
things are mutually incompatible inherently does not play well with
the idea of showing common things early.  It would allow us to group
conceptually similar things together, though.  

Do we want to say "[-a | -i | -o | --interactive | --patch]" in the
same [] group and show them as alternatives?  That may logically
make some sense, and if we were to go that route, it belongs near
the end of the list, close to where we show pathspec.  I dunno.
