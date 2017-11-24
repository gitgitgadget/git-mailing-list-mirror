Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF2220A40
	for <e@80x24.org>; Fri, 24 Nov 2017 05:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbdKXFC0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 00:02:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51260 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750715AbdKXFC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 00:02:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EEE2B64FF;
        Fri, 24 Nov 2017 00:02:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zv3eU8dNJD9AR1aZnYOvGP/uCAU=; b=UQwrPx
        3V+OBed1WTGgvq5kJCkQpExClhFs1DvfgzGXvR+q8VKYIpCFhFxbskYKbcXX8Hw1
        qm9lFBGDYkDkHxsD4rCz4TiQd8tI1YlObLn0yS1KgfaFj8p0Q/NEAnFGvBn3mg15
        Cf7X78eYdRYriHijwtv0Se8jC7yD+BoqhdiyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ABS/LjZZH5mmz7KXJSKB9rkMdmYWDbuf
        oIjBmdZ6Uyjun5y8Vw817HROYyGEf9lBMzH9lO6yMME7P71Qp2x8Q8VHY+PllYbA
        H5ns54lqpRBbfVQs82ey8QKCCXQh5uwofC5q75FbHKV/Yt3VtNs4b7aYTDwVpavr
        gajXb7ixvmM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85CC4B64FE;
        Fri, 24 Nov 2017 00:02:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0457BB64FD;
        Fri, 24 Nov 2017 00:02:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] doc: tweak "man gitcli" for clarity
References: <alpine.LFD.2.21.1711220701070.12544@DESKTOP-1GPMCEJ>
Date:   Fri, 24 Nov 2017 14:02:23 +0900
In-Reply-To: <alpine.LFD.2.21.1711220701070.12544@DESKTOP-1GPMCEJ> (Robert
        P. J. Day's message of "Wed, 22 Nov 2017 07:03:09 -0500 (EST)")
Message-ID: <xmqqd148p8v4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A950417C-D0D4-11E7-9F49-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> -This manual describes the convention used throughout Git CLI.
> +This manual describes the conventions used throughout Git CLI.

OK.

>  Many commands take revisions (most often "commits", but sometimes
>  "tree-ish", depending on the context and command) and paths as their
> @@ -32,32 +32,35 @@ arguments.  Here are the rules:
>     between the HEAD commit and the work tree as a whole".  You can say
>     `git diff HEAD --` to ask for the latter.
>
> - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> -   file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
> + * In cases where a Git command is truly ambiguous, Git will error out
> +   and ask you to disambiguate the command.  E.g. if you have a file
> +   called HEAD in your work tree, `git diff HEAD` is ambiguous, and
>     you have to say either `git diff HEAD --` or `git diff -- HEAD` to
>     disambiguate.
>  +
>  When writing a script that is expected to handle random user-input, it is
>  a good practice to make it explicit which arguments are which by placing
> -disambiguating `--` at appropriate places.
> +a disambiguating `--` at appropriate places.

The above "truly" is misleading by giving the information the other
way around.  We ask to disambiguate when we cannot readily say the
command line is *not* unambiguous.  That is different from asking
when we know it is truly ambiguous.

Also see <xmqq7eugqykq.fsf@gitster.mtv.corp.google.com> if you want
to know more.

>   * Many commands allow wildcards in paths, but you need to protect
> -   them from getting globbed by the shell.  These two mean different
> -   things:
> +   them from getting globbed by the shell.  The following commands have
> +   two different meanings:
>  +
>  --------------------------------
>  $ git checkout -- *.c
> +
>  $ git checkout -- \*.c
> +$ git checkout -- "*.c"
> +$ git checkout -- '*.c'

I do not think these two additional ones add any value.

And if you do not add these two, you do not need any of the change
we see before or after this example.  The changes you made to these
paragraphs are primarily there because you need to explain that the
latter three are equivalent to each other now because of these two
extra ones, while the original did not have to say anything like
that.

Because this is not a tutorial for shell scripting and its quoting
rules, highlighting the difference between the case where Git sees
the asterisk and you let shell to expand asterisk and do not let Git
see the asterisk _is_ important, but the fact that you can quote the
asterisk in different ways from the shell is *not* important.  We
shouldn't clutter the description with the latter, I would think.

I would however be receptive if the change were to only replace the
backslash quoting of asterisk with the one that uses a single quote
pair (and with no changes in the surrounding paragraphs).  That
change could be justified by saying that a pair of single (or
double) quotes would be more familiar for people new to the shell.

Thanks.
