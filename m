Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFAF20899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdHHRpf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:45:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54452 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752100AbdHHRpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:45:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 589189B2CD;
        Tue,  8 Aug 2017 13:45:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w7PIOmFnx1stYOU2UR+2Mo8r9nk=; b=uvjdHk
        8o/q/znrmmKedd3BmQFFjCbcIUiDZ85k7SwunDM0PAXzHDBZsKC5Wr0xQDSLqYJV
        lU3UR+S3lUdc/ma5iW6ZiRdSqnACyOH5q/u0qaI4+o4SIEJ4pvzPwYE0LfaKR/yM
        BU9rt2M1jLoU3Bw/dfC2NJmJUTmD8Jnb/HCOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cZ0M1IEzIHMidLqV10RQNWUkP15JmTBi
        GoV74GzoMSwOc4OnNA8J/iVQD4gRgZqsffZ1olXu7EFMMPseSpFJsVXs98BcbhwA
        K8Nwsdy0Eb64SAATXDMLbAxUIGNSepMomGBY7H2Ic3h45keQdUYDWVADvwps9ast
        c5XL+oAr8fM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EB7D9B2CC;
        Tue,  8 Aug 2017 13:45:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87C739B2CB;
        Tue,  8 Aug 2017 13:45:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
Date:   Tue, 08 Aug 2017 10:45:24 -0700
In-Reply-To: <20170808012554.186051-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 7 Aug 2017 18:25:54 -0700")
Message-ID: <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C0736B8-7C61-11E7-B3BF-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add a '.clang-format' file which outlines the git project's coding
> style.  This can be used with clang-format to auto-format .c and .h
> files to conform with git's style.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> I'm sure this sort of thing comes up every so often on the list but back at
> git-merge I mentioned how it would be nice to not have to worry about style
> when reviewing patches as that is something mechanical and best left to a
> machine (for the most part).  I saw that 'clang-format' was brought up on the
> list once before a couple years ago
> (https://public-inbox.org/git/20150121220903.GA10267@peff.net/) but nothing
> really came of it.  I spent a little bit of time combing through the various
> options and came up with this config based on the general style of our code
> base.  The big issue though is that our code base isn't consistent so try as
> you might you wont be able to come up with a config which matches everything we
> do (mostly due to the inconsistencies in our code base).
>
> Anyway, I thought I'd bring this topic back up and see how people feel about it.

I gave just one pass over all the rules you have here.  I didn't
think too deeply about implications of some of them, but most of
them looked sensible.  Thanks for compiling this set of rules.

Having said that, it is easier to refine individual rules you have
below than to make sure that among the develoepers there is a shared
notion of how these rules are to be used.  If we get that part wrong,
we'd see unpleasant consequences, e.g.

 - We may see unwanted code churn on existing codebase, only for the
   sake of satisfying the formatting rules specified here.

 - We may see far more style-only critique to patches posted on the
   list simply because there are more readers than writers, and it
   is likely that running the tool to nitpick other people's patches
   is far easier than writing these patches in the first place (and
   forgetting to ask the formatter to nitpick before sending them
   out).

 - Human aesthetics judgement often is necessary to overrule
   mechanical rules (e.g. A human may have two pairs of <ptr, len>
   parameters on separate lines in a function declaration;
   BinPackParameters may try to break after ptrA, lenA, ptrB before
   lenB in such a case).

We need to set our expectation and a guideline to apply these rules
straight, before introducing something like this.


>  .clang-format | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 .clang-format
>
> diff --git a/.clang-format b/.clang-format
> new file mode 100644
> index 000000000..7f28dc259
> --- /dev/null
> +++ b/.clang-format
> @@ -0,0 +1,166 @@
> +# Defaults
> +
> +# Use tabs whenever we need to fill whitespace that spans at least from one tab
> +# stop to the next one.
> +UseTab: Always
> +TabWidth: 8
> +IndentWidth: 8
> +ContinuationIndentWidth: 8
> +ColumnLimit: 80

I often deliberately chomp my lines much shorter than this limit,
and also I deliberately write a line that is a tad longer than this
limit some other times, if doing so makes the result easier to read.
And I know other develoepers with good taste do the same.  It is
pointless to have a discussion that begins with "who uses a physical
terminal these days that can only show 80-columns?" to tweak this
value, I think.  It is more important to give a guideline on what to
do when lines in your code goes over this limit.

A mechanical "formatter" would just find an appropriate point in a
line with least "penalty" and chomp it into two.  But an appropriate
way to make such a code that is way too deeply indented readable may
instead be judicious use of goto's and one-time helper functions,
for example, which mechanical tools would not do.

That is an example of what I meant above, i.e. a guideline to apply
these rules.  We would not want to say "clang-format suggests this
rewrite, so we should accept the resulting code that is still too
deeply indented as-is"---using the tool to point out an issue is
good, though.

> +
> +# C Language specifics
> +Language: Cpp

Hmph ;-)

> +# Add a line break after the return type of top-level functions
> +# int
> +# foo();
> +AlwaysBreakAfterReturnType: TopLevel

We do that?

> +# Pack as many parameters or arguments onto the same line as possible
> +# int myFunction(int aaaaaaaaaaaa, int bbbbbbbb,
> +#                int cccc);
> +BinPackArguments: true
> +BinPackParameters: true

I am OK with this but with the caveats I already mentioned.

> +# Insert a space after a cast
> +# x = (int32) y;    not    x = (int32)y;
> +SpaceAfterCStyleCast: true

Hmph, I thought we did the latter, i.e. cast sticks to the casted
expression without SP.

Thanks.
