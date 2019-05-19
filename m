Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834CF1F461
	for <e@80x24.org>; Sun, 19 May 2019 02:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfESCAG (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 22:00:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54741 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfESCAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 22:00:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55E1952E40;
        Sat, 18 May 2019 22:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=riFioPy0208/U9pvtD5WII3BzgY=; b=siPtMX
        sXsYxBDtQ9b/jU2mX7GiLTlB7Rbf7Wnf77XExa5fl6KoGcMwrJZDdUmD0y4qV7g4
        /giy11Gws4nQdLqs5/8PWgLPCdiOF0lQWiZgHct6fl/yMeBJ3jjijSS2O3Q9c+2g
        tgWE7xK1hy7FigY4zNc8sCewII5BNDnsU3O1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CE/IuLNTVtm9kTilOhQ15HnScHa1WoWM
        hePxruz2EWQboWB7n+1R7zVZP3W0Inq3GkD5B4Citpc4H11PdhR2lno1YYGwipLU
        OLj6p4Eo5WtP7azV2OZGsZvnGwAl9Ze0Mhr0EgTqdd+LMlZ5tNqcSgkR2klpE6oL
        AUVZaHlZz2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EC6852E3F;
        Sat, 18 May 2019 22:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7786052E38;
        Sat, 18 May 2019 22:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash-rules more readable
References: <20190518141337.14919-1-admin@in-ici.net>
Date:   Sun, 19 May 2019 10:59:59 +0900
In-Reply-To: <20190518141337.14919-1-admin@in-ici.net> (Adam Nielsen's message
        of "Sat, 18 May 2019 16:13:37 +0200")
Message-ID: <xmqqo93z19wg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFF04930-79D9-11E9-8CE3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> gitignore.txt: make slash-rules more readable
>
> Make all paragraphs valid, even if they are not read
> in strict order.

I think you are giving up on this, and I do not think that is
particularly a bad thing ;-)

> + - A slash `/` is used as a directory separator. A leading and trailing
> +   slash have special meaning and are explained in the following.
> +
> + - If the pattern ends with a slash, it would only find
> +   directory `foo`, but will not match a regular file or a
> +   symbolic link `foo` (this is consistent with the way how
> +   pathspec works in general in Git).
> +
> + - If the pattern does not end with a slash, it would find a match
> +   with a file or directory.
> +
> + - If the pattern contains no slash or only a trailing slash,
> +   the pattern is matched against all files and folders (recursively)
> +   from the location of the `.gitignore` file.
> +   For example, `frotz/` matches `frotz` and `a/frotz` that
> +   is a directory (relative from the `.gitignore` file).
> +   Otherwise the pattern is matched relative to the
> +   location of the `.gitignore` file.
> +   For example, `doc/frotz/` matches `doc/frotz` directory, but not
> +   `a/doc/frotz` (relative from the `.gitignore` file).

OK.

> + - The above pargraph also includes the case of a leading slash.

Now you (not you the author of the document, but figuratively "any
reader of this document") must have read all the four before this
point ;-) To put it differently, your reading of the above four
bullets are incomplete unless you read this too.

Typofix: "pargraph" -> "paragraph".

In any case, I cannot guess what 'also include the case of a leaning
slash' wants to say.  Perhaps

      Note that the above rule means you cannot easily say "a file
      whose name contains 'hello' and in this directory only, not in
      its subdirectories." because a pattern 'hello.*' does not have
      any slash.  To work around this limitation, you can prepend
      your pattern with a slash, i.e. '/hello.*'; the pattern now
      matches 'hello.txt', 'hello.c' but not 'a/hello.java'.

as the third point of the above paragraph (the first is about a
pattern without a slash, the second "Otherwise" is about a pattern
with one or more slashes, and the new "Note that" becomes the
third) may make it easier to follow and keep your "each bullet point
is independent".

> +   For example, the pattern `/bar` only matches the file or
> +   folder `bar` that is at the same location as the `gitignore`
> +   file. Whereas the pattern `bar` would also match in folders
> +   below the `gitignore`  file.
> +
> + - An asterisk "`*`" matches anything except a slash.
> +   A pattern "foo/*", for example, matches "foo/test.json"
> +   (a regular file), "foo/bar" (a diretory), but it does not match
> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
> +   patter does not match "bar/hello.c" which has a slash in it.
> +   The character "`?`" matches any one character except "`/`".
> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
> +   one of the characters in a range. See fnmatch(3) and the
> +   FNM_PATHNAME flag for a more detailed description.
>  
>  Two consecutive asterisks ("`**`") in patterns matched against
>  full pathname may have special meaning:
