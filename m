Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F6CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 21:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjIVV4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVV4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 17:56:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B2483
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:56:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FE542AC76;
        Fri, 22 Sep 2023 17:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=YUEw3jUP7nVOfAsTS1M8EIhCw/d2DwW/g8T6wt
        v77ys=; b=hO7zMIl4OimbzypSRr1f/qA+bMTKsFMU300GOW+MMFYBGrpQEOp87s
        Fb+/Nt/QLpWeLnJGMgQ38juVEZPTmXO65lYHIh2oMp2/MQBKKTq2gAhsRjmMOJlA
        W4f774MAvat7Bh5d7etun0nIWN53wXW/6O8Y4pXfAjU4p1tPwLp60=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47C132AC75;
        Fri, 22 Sep 2023 17:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C74232AC74;
        Fri, 22 Sep 2023 17:56:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
In-Reply-To: <pull.950.git.1695391818917.gitgitgadget@gmail.com> (Josh Soref
        via GitGitGadget's message of "Fri, 22 Sep 2023 14:10:18 +0000")
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:56:20 -0700
Message-ID: <xmqqsf75zxbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDEB0898-5992-11EE-BF4B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> * two spaces after periods for sentences

Although I admit I tend to hit my spacebar twice after a sentence, I
think more people tend to just do with a single space and let the
formatting software (like AsciiDoc) take care of the inter-sentence
spacing.  To me, this falls into "it would be nicer if we did this
when we write a new sentence, but it is not worth the patch noise if
somebody already wrote with a single space to change them" category.

The title of the patch may have been written after you did the
above, but now it includes other changes listed below, so it may
want to be revised.

> * comma (before/)after `i.e.` and `e.g.`

That's modern American English.  I think our documentation is
mixture so this may also fall into "if it is already written that
way, it is not worth the patch noise to change" category.

> * comma after `etc.` when not ending a sentence

There is one instance that says "A, B, C, D, etc., are all accepted."
without the comma after 'etc.' and the patch corrects it.  OK.

> * space before `(`

If you mean by the above that we used to say

	... as described below(see linkgit:git-config[1]))

and you added a SP before "(see", that is a definite improvement.  I
however didn't find an example of a line that lacks SP before '('
that got corrected to have a SP there.

> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---

Thanks.

>     pretty-formats.txt: fix whitespace
>     
>     follow-up-to:
>     https://github.com/gitgitgadget/git/pull/939#discussion_r624652778
>     
>      * two spaces after periods for sentences
>      * comma (before/)after i.e. and e.g.
>      * space before (
>     
>     Signed-off-by: Josh Soref jsoref@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-950%2Fjsoref%2Fwhitespace-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-950/jsoref/whitespace-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/950
>
>  Documentation/pretty-formats.txt | 68 ++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index d38b4ab5666..f64c0a2d92e 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -15,7 +15,7 @@ There are several built-in formats, and you can define
>  additional formats by setting a pretty.<name>
>  config option to either another format name, or a
>  'format:' string, as described below (see
> -linkgit:git-config[1]). Here are the details of the
> +linkgit:git-config[1]).  Here are the details of the
>  built-in formats:
>  
>  * 'oneline'
> @@ -96,15 +96,15 @@ stored in the commit object.  Notably, the hashes are
>  displayed in full, regardless of whether --abbrev or
>  --no-abbrev are used, and 'parents' information show the
>  true parent commits, without taking grafts or history
> -simplification into account. Note that this format affects the way
> -commits are displayed, but not the way the diff is shown e.g. with
> -`git log --raw`. To get full object names in a raw diff format,
> +simplification into account.  Note that this format affects the way
> +commits are displayed, but not the way the diff is shown, e.g., with
> +`git log --raw`.  To get full object names in a raw diff format,
>  use `--no-abbrev`.
>  
>  * 'format:<format-string>'
>  +
>  The 'format:<format-string>' format allows you to specify which information
> -you want to show. It works a little bit like printf format,
> +you want to show.  It works a little bit like printf format,
>  with the notable exception that you get a newline with '%n'
>  instead of '\n'.
>  +
> @@ -136,13 +136,13 @@ The placeholders are:
>  	    default, colors are shown only when enabled for log output
>  	    (by `color.diff`, `color.ui`, or `--color`, and respecting
>  	    the `auto` settings of the former if we are going to a
> -	    terminal). `%C(auto,...)` is accepted as a historical
> -	    synonym for the default (e.g., `%C(auto,red)`). Specifying
> +	    terminal).  `%C(auto,...)` is accepted as a historical
> +	    synonym for the default (e.g., `%C(auto,red)`).  Specifying
>  	    `%C(always,...)` will show the colors even when color is
>  	    not otherwise enabled (though consider just using
>  	    `--color=always` to enable color for the whole output,
>  	    including this format and anything else git might color).
> -	    `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
> +	    `auto` alone (i.e., `%C(auto)`) will turn on auto coloring
>  	    on the next placeholders until the color is switched
>  	    again.
>  '%m':: left (`<`), right (`>`) or boundary (`-`) mark
> @@ -177,7 +177,7 @@ The placeholders are:
>  			  spaces
>  '%><( <N> )', '%><|( <M> )':: similar to '%<( <N> )', '%<|( <M> )'
>  			  respectively, but padding both sides
> -			  (i.e. the text is centered)
> +			  (i.e., the text is centered)
>  
>  - Placeholders that expand to information extracted from the commit:
>  '%H':: commit hash
> @@ -225,9 +225,9 @@ The placeholders are:
>  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>  '%D':: ref names without the " (", ")" wrapping.
>  '%(decorate[:<options>])'::
> -ref names with custom decorations. The `decorate` string may be followed by a
> -colon and zero or more comma-separated options. Option values may contain
> -literal formatting codes. These must be used for commas (`%x2C`) and closing
> +ref names with custom decorations.  The `decorate` string may be followed by a
> +colon and zero or more comma-separated options.  Option values may contain
> +literal formatting codes.  These must be used for commas (`%x2C`) and closing
>  parentheses (`%x29`), due to their role in the option syntax.
>  +
>  ** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
> @@ -235,7 +235,7 @@ parentheses (`%x29`), due to their role in the option syntax.
>  ** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
>  ** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
>  		      Defaults to "{nbsp}`->`{nbsp}".
> -** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
> +** 'tag=<value>': Shown before tag names.  Defaults to "`tag:`{nbsp}".
>  
>  +
>  For example, to produce decorations with no wrapping
> @@ -277,7 +277,7 @@ endif::git-rev-list[]
>  	"X" for a good signature that has expired,
>  	"Y" for a good signature made by an expired key,
>  	"R" for a good signature made by a revoked key,
> -	"E" if the signature cannot be checked (e.g. missing key)
> +	"E" if the signature cannot be checked (e.g., missing key)
>  	and "N" for no signature
>  '%GS':: show the name of the signer for a signed commit
>  '%GK':: show the key used to sign a signed commit
> @@ -287,7 +287,7 @@ endif::git-rev-list[]
>  '%GT':: show the trust level for the key used to sign a signed commit
>  '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
>  	minutes ago}`; the format follows the rules described for the
> -	`-g` option. The portion before the `@` is the refname as
> +	`-g` option.  The portion before the `@` is the refname as
>  	given on the command line (so `git log -g refs/heads/master`
>  	would yield `refs/heads/master@{0}`).
>  '%gd':: shortened reflog selector; same as `%gD`, but the refname
> @@ -302,48 +302,48 @@ endif::git-rev-list[]
>  '%gs':: reflog subject
>  '%(trailers[:<options>])'::
>  display the trailers of the body as interpreted by
> -linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
> -a colon and zero or more comma-separated options. If any option is provided
> +linkgit:git-interpret-trailers[1].  The `trailers` string may be followed by
> +a colon and zero or more comma-separated options.  If any option is provided
>  multiple times, the last occurrence wins.
>  +
> -** 'key=<key>': only show trailers with specified <key>. Matching is done
> -   case-insensitively and trailing colon is optional. If option is
> +** 'key=<key>': only show trailers with specified <key>.  Matching is done
> +   case-insensitively and trailing colon is optional.  If option is
>     given multiple times trailer lines matching any of the keys are
> -   shown. This option automatically enables the `only` option so that
> -   non-trailer lines in the trailer block are hidden. If that is not
> +   shown.  This option automatically enables the `only` option so that
> +   non-trailer lines in the trailer block are hidden.  If that is not
>     desired it can be disabled with `only=false`.  E.g.,
>     `%(trailers:key=Reviewed-by)` shows trailer lines with key
>     `Reviewed-by`.
>  ** 'only[=<bool>]': select whether non-trailer lines from the trailer
>     block should be included.
>  ** 'separator=<sep>': specify a separator inserted between trailer
> -   lines. When this option is not given each trailer line is
> -   terminated with a line feed character. The string <sep> may contain
> -   the literal formatting codes described above. To use comma as
> +   lines.  When this option is not given each trailer line is
> +   terminated with a line feed character.  The string <sep> may contain
> +   the literal formatting codes described above.  To use comma as
>     separator one must use `%x2C` as it would otherwise be parsed as
> -   next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
> +   next option.  E.g., `%(trailers:key=Ticket,separator=%x2C )`
>     shows all trailer lines whose key is "Ticket" separated by a comma
>     and a space.
>  ** 'unfold[=<bool>]': make it behave as if interpret-trailer's `--unfold`
> -   option was given. E.g.,
> +   option was given.  E.g.,
>     `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
>  ** 'keyonly[=<bool>]': only show the key part of the trailer.
>  ** 'valueonly[=<bool>]': only show the value part of the trailer.
>  ** 'key_value_separator=<sep>': specify a separator inserted between
> -   trailer lines. When this option is not given each trailer key-value
> -   pair is separated by ": ". Otherwise it shares the same semantics
> +   trailer lines.  When this option is not given each trailer key-value
> +   pair is separated by ": ".  Otherwise it shares the same semantics
>     as 'separator=<sep>' above.
>  
>  NOTE: Some placeholders may depend on other options given to the
> -revision traversal engine. For example, the `%g*` reflog options will
> +revision traversal engine.  For example, the `%g*` reflog options will
>  insert an empty string unless we are traversing reflog entries (e.g., by
> -`git log -g`). The `%d` and `%D` placeholders will use the "short"
> +`git log -g`).  The `%d` and `%D` placeholders will use the "short"
>  decoration format if `--decorate` was not already provided on the command
>  line.
>  
> -The boolean options accept an optional value `[=<bool-value>]`. The values
> -`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> -sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> +The boolean options accept an optional value `[=<bool-value>]`.  The values
> +`true`, `false`, `on`, `off`, etc., are all accepted.  See the "boolean"
> +sub-section in "EXAMPLES" in linkgit:git-config[1].  If a boolean
>  option is given with no value, it's enabled.
>  
>  If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
> @@ -361,7 +361,7 @@ placeholder expands to a non-empty string.
>  * 'tformat:'
>  +
>  The 'tformat:' format works exactly like 'format:', except that it
> -provides "terminator" semantics instead of "separator" semantics. In
> +provides "terminator" semantics instead of "separator" semantics.  In
>  other words, each commit has the message terminator character (usually a
>  newline) appended, rather than a separator placed between entries.
>  This means that the final entry of a single-line format will be properly
>
> base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
