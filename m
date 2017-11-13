Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD145201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 04:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdKMEPK (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 23:15:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61443 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751330AbdKMEPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 23:15:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 046939826E;
        Sun, 12 Nov 2017 23:15:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WtrNfFLet8rZlrPnlyJspeBX4jg=; b=wHZ/wE
        zjww/6+eR+at30nSD1e9T9daikmD5sSrhNH4UkDj3/prV0omHoqlR/oVbYA6EAjd
        CD1pWMVRRDItNaaQeeEQ0wIrm8LjJIJapdMcNbyUyrq7CRNh0Ln99WGpnjjqZAtJ
        FKPFJWYpRi1JqRf1XgTNoSoZsNxMS1Jceb+MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DKgRQCTkFa7LVx9sYqIwxTkqslmkUCoX
        soU2iX8lwxH/S50jyF+zJOmHa63dn5O1FRV4D9iG56LrqRpt6EKAVL9p6i4J0MwR
        DYcynMrYLpv6KdECC7VA597mYlKR7I+Hi2+Pjwp1wWsrz784pWiIKK++2XPgMivy
        nOeFnF4QbKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEF959826D;
        Sun, 12 Nov 2017 23:15:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74F709826C;
        Sun, 12 Nov 2017 23:15:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Remove explanation of "--" from several man pages
References: <alpine.LFD.2.21.1711121600170.7904@localhost.localdomain>
Date:   Mon, 13 Nov 2017 13:15:07 +0900
In-Reply-To: <alpine.LFD.2.21.1711121600170.7904@localhost.localdomain>
        (Robert P. J. Day's message of "Sun, 12 Nov 2017 16:02:56 -0500
        (EST)")
Message-ID: <xmqq8tfaak6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C0F39C8-C829-11E7-A17D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> There is no value in individual man pages explaining the purpose of
> the "--" separator.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   unless every man page explains that option, it's pointless to have
> just *some* man pages explaining it, so might as well remove it from
> all of them.

Please do not remove diffstat that format-patch gave you at this
point.  While commenting on the hunk on "git add", I wanted to see
if you touched "git rm", and the diffstat at front _is_ the go-to
place to do so for reviewers.

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index b700beaff..69d625285 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -180,11 +180,6 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>  	bit is only changed in the index, the files on disk are left
>  	unchanged.
>
> -\--::
> -	This option can be used to separate command-line options from
> -	the list of files, (useful when filenames might be mistaken
> -	for command-line options).
> -

I do not think if this removal alone is a good idea.  

Before this can happen, the description for "--" in other pages,
(like gitcli(7), may need to be extended.  Right now, gitcli's
mention of "--" is only about turning off disambiguation between
revs and pathspecs, and it does not cover this case

	$ >./--foo-bar
	$ git add -- --foo-bar

even though the description you are removing would have helped the
reader to understand why "--" is there.  The hunk on "git rm" shares
the same issue.

>  Configuration
>  -------------
> diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> index aa3b2bf2f..0ae2523e0 100644
> --- a/Documentation/git-check-attr.txt
> +++ b/Documentation/git-check-attr.txt
> @@ -36,10 +36,6 @@ OPTIONS
>  	If `--stdin` is also given, input paths are separated
>  	with a NUL character instead of a linefeed character.
>
> -\--::
> -	Interpret all preceding arguments as attributes and all following
> -	arguments as path names.
> -

This also has a similar issue.  "--" here is not between revs and
pathspecs but is between attributes and pathspecs.

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index d153c17e0..93ebb020c 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -171,9 +171,6 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
>  and in the working tree ("w/<eolinfo>") are shown for regular files,
>  followed by the  ("attr/<eolattr>").
>
> -\--::
> -	Do not interpret any more arguments as options.

These removals would become a good idea, once we say that we would
use "--" to mean "you will not see any --flags after this point" (as
commonly seen in programs that are not Git) somewhere central like
gitcli(7).
