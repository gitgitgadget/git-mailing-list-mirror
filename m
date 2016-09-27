Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441FE20986
	for <e@80x24.org>; Tue, 27 Sep 2016 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935435AbcI0Qvk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 12:51:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54392 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934860AbcI0Qvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 12:51:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 576FC3F3EE;
        Tue, 27 Sep 2016 12:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hn+VdYpE2bs61Aouu7f7Fh92OVI=; b=DqTRP1
        GSQ4Xo61movsp9SPiye3QTrxos5xRUb1BBDsFEKhXq7ZJNNF/kg3zGVpBPgJoH1q
        yO4gCbu9X+KzSHdDda5VBDRZWzYM/9foeohrBqWIGSOI5AsZJqg39S4cI8JFP2ey
        F5ojdB0sh8l7JYC4LwjXNUdTsIEOsjbSjwFRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eh2vsdjMVRVqTZu9uhv79Kuy+00Ojpyp
        hHIG/C3bG82t9TRfbqf3ueKwrpFjus6lUC6JX6HNobNmbYkGlsT7Vli+DCQFe8Qb
        AKi5+8pWlD1lZ+Tpf4SAA/C4bOYVE8m9LuE8IiYn7LARq8InGTjRzwiAQwA1CkQE
        NJO0+5EZWgA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 437B73F3ED;
        Tue, 27 Sep 2016 12:51:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B51B13F3EC;
        Tue, 27 Sep 2016 12:51:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rev-list-options: clarify the usage of -n/--max-number
References: <201609271240.19759.sweet_f_a@gmx.de>
        <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
Date:   Tue, 27 Sep 2016 09:51:22 -0700
In-Reply-To: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 27 Sep 2016 14:10:22 +0000")
Message-ID: <xmqq1t05qoad.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A03A8542-84D2-11E6-89FC-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> -n=<number>, -<number>, --max-number=<number> shows the last n commits
> specified in <number> irrespective of whether --reverse is used or not.
> With --reverse, it just shows the last n commits in reverse order.

I think it is easier to understand if you updated the description of
"--reverse", rather than "-<n>".  "rev-list -n $N" that stops after
showing $N commits is something everybody understands.  What often
dissapoints some users is that "--reverse" kicks in _after_ what
commits are to be shown are decided.

>  Documentation/rev-list-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 7e462d3..6b7c2e5 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -18,7 +18,7 @@ ordering and formatting options, such as `--reverse`.
>  -<number>::
>  -n <number>::
>  --max-count=<number>::
> -	Limit the number of commits to output.
> +	Limit to last n number of commits to output specified in <number>.

These essentially say the same thing.  The original does not mention
where and how <number> is used, but "Limit the number of commits" as
a description for "-<number>" would be understood by anybody halfway
intelligent that the given number is used as that limit, so I do not
think an updated description is making it easier to understand.

There is a paragraph of interest in an earlier part of "Commit
Limiting" section (which is the section "-n" appears in, among other
options):

    Note that these are applied before commit
    ordering and formatting options, such as `--reverse`.

So the documentation already makes an attempt to avoid confusion
Ruediger saw, i.e. "rev-list traverses, limits the output to N, and
then shows these N commits in reverse" is what it expects readers to
understand, and that it also expects it would lead naturally to
"these N commits are still from the newest part of the history,
hence 'rev-list --reverse -n N' is not how you grab the earliest N".

But apparently the attempt by the current documentation is not
enough.  Let's see how it describes the '--reverse' option:

    Commit Ordering
    ~~~~~~~~~~~~~~~

    By default, the commits are shown in reverse chronological order.
    ...

    --reverse::
            Output the commits in reverse order.
            Cannot be combined with `--walk-reflogs`.

Perhaps "Output the commits chosen to be shown (see Commit Limiting
section above) in reverse order." would make it clearer?
