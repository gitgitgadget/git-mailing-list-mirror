Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2C620A40
	for <e@80x24.org>; Fri, 24 Nov 2017 04:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbdKXEpW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 23:45:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50210 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753346AbdKXEpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 23:45:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75B82B618D;
        Thu, 23 Nov 2017 23:45:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCGJdeWVdr7Hy3vkYhjOFxf4ssw=; b=fLAuM6
        X2ZWqendQIiE18c3+GfnmmqZiVu5hSPUxbQB6sB1Vsy0UQLFTewQbo+zlOs4bPNo
        v5LTyioS7EDKzPnt6LvlZMTp4Q3vqYbeYyzDJhM8zcB3nr0Uu2EJQOryYMaZuEQ7
        jZaUbM4xVWpc4p4w40Y2dHRxP+tLRxrJ9wFTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=upi8f8RGpeAwCNK4GBlL7i+v+sLPOS5S
        v0DFgeIYIPB+v1ZreiKFbER5SnRYxKS/3CDKx2373LcU18T0NrA24+jxR9V74XNZ
        FKUmw2IdUv2tBMyPGQKIQlYhCi5/yhgDU/0574ymPWCk9PgN++gRHpaNMm0OgURg
        QBlp9Q6AXCY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D5B5B618C;
        Thu, 23 Nov 2017 23:45:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D19BDB618B;
        Thu, 23 Nov 2017 23:45:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: clarify that "git bisect" accepts one or more good commits
References: <alpine.LFD.2.21.1711220729230.13545@DESKTOP-1GPMCEJ>
Date:   Fri, 24 Nov 2017 13:45:16 +0900
In-Reply-To: <alpine.LFD.2.21.1711220729230.13545@DESKTOP-1GPMCEJ> (Robert
        P. J. Day's message of "Wed, 22 Nov 2017 07:32:14 -0500 (EST)")
Message-ID: <xmqqh8tkp9nn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45147DCE-D0D2-11E7-AB28-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>  This command uses a binary search algorithm to find which commit in
> -your project's history introduced a bug. You use it by first telling
> -it a "bad" commit that is known to contain the bug, and a "good"
> -commit that is known to be before the bug was introduced. Then `git
> -bisect` picks a commit between those two endpoints and asks you
> +your project's history introduced a bug. You use it by first telling it
> +a "bad" commit that is known to contain the bug, and one or more "good"
> +commits that are known to be before the bug was introduced. Then `git
> +bisect` picks a commit somewhere in between those commits and asks you

Good.

> -Once you have specified at least one bad and one good commit, `git
> +Once you have specified one bad and one or more good commits, `git
>  bisect` selects a commit in the middle of that range of history,
>  checks it out, and outputs something similar to the following:

Good.

> @@ -137,7 +137,7 @@ respectively, in place of "good" and "bad". (But note that you cannot
>  mix "good" and "bad" with "old" and "new" in a single session.)
>
>  In this more general usage, you provide `git bisect` with a "new"
> -commit that has some property and an "old" commit that doesn't have that
> +commit with some property and some "old" commits that don't have that
>  property. Each time `git bisect` checks out a commit, you test if that

Good.

> @@ -145,19 +145,19 @@ will report which commit introduced the property.
>
>  To use "old" and "new" instead of "good" and bad, you must run `git
>  bisect start` without commits as argument and then run the following
> -commands to add the commits:
> +commands to identify the commits:

I am not sure if this is an improvement (see below).

>
>  ------------------------------------------------
> -git bisect old [<rev>]
> +git bisect old [<rev>...]
>  ------------------------------------------------

Good.

> -to indicate that a commit was before the sought change, or
> +to identify one or more commits before the sought change, or
>
>  ------------------------------------------------
> -git bisect new [<rev>...]
> +git bisect new [<rev>]
>  ------------------------------------------------

Good.

> -to indicate that it was after.
> +to indicate a single commit after that change.

As to "identify", I would say it is better to consistently use
"indicate" like the original of these two hunks at the end says,
i.e. "indicate that it is bad/new (or they are good/old)".

Regarding the earlier "add the commits", I do not think the original
is confusing and any reasonable reader would get that the verb is a
casually (or "carelessly") used short-hand for "add the commits to
the set of commits the bisect algorithm cares about", and turning it
to "identify" adds much clarity.

As it is immediately followed by two illustrations to use old and
new, I would think that we could just stop the sentence at "then run
the following commands:" without saying anything else.

If you really want to phrase it differently from the two sentences
to describe use of old and new, because this is acting as a headline
for these two, perhaps it is an improvement to say something like
"then run the following commands to limit the bisection range"; that
would explain _why_ these commits are "added" and would give additional
information to the readers.


   

	
