Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428DC433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBCC2073B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZ80LJxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgFGRmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:42:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgFGRmu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 13:42:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 586695C7C7;
        Sun,  7 Jun 2020 13:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YPV7JNy/LAaR7RoZU0IETznH6KM=; b=dZ80LJ
        xKvULEzObfWFCNWiGP368RoL9jaFzY8/Z6tJfW/WXd8lq9nrGhIdlBk08bh1KWWj
        ahhkBVwQ63rsV8HOXLJJFXP4mlfd39gAIJWRylZQKKQXny7rmsiaVeHroYSMJGvM
        YnRijOWbo+jy9RDQQj77ZCWJkrJk2iRR6uaDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SS21OhiROL0HOYnJs9uaCh35CEhRQ3/2
        UG3BWaINeJGdB/+mdizMOu8mBFo0Q7E/SRx0ffKbaPoeHZS/Oa8kpxQxT5YQwIr6
        /LhLy63se/wwGZxOGlrr3CJ9D9cidXRKe1+ZFH94jqH3fNJtQs4cuOGjaeUQCRdO
        4qhuP2doae8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 513495C7C6;
        Sun,  7 Jun 2020 13:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CACBE5C7C5;
        Sun,  7 Jun 2020 13:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Russo <antonio.e.russo@gmail.com>
Cc:     git-ml <git@vger.kernel.org>, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 1/3] Clean up t6016-rev-list-graph-simplify-history
References: <456a1271-4f17-5503-5d13-d0c97115e2fd@gmail.com>
        <b215afe1-b6f2-03ca-4d25-f3e369a4f7e3@gmail.com>
Date:   Sun, 07 Jun 2020 10:42:44 -0700
In-Reply-To: <b215afe1-b6f2-03ca-4d25-f3e369a4f7e3@gmail.com> (Antonio Russo's
        message of "Sun, 7 Jun 2020 10:23:41 -0600")
Message-ID: <xmqq1rmqn563.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B5B6EEC-A8E6-11EA-8464-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Russo <antonio.e.russo@gmail.com> writes:

> Subject: Re: [PATCH 1/3] Clean up t6016-rev-list-graph-simplify-history

Hmph, didn't anybody give you guidance on the subjects the last
round?

If this is a second round (I do not recall---I read too many
patches), the subject should begin with

	[PATCH v2 1/3]

and then "<area>: one line summary".  For test scripts, the script
number is enough to identify the area the patch affects, e.g.

	[PATCH v2 1/3] t6016: simplify the way expected history is drawn

> Simplifies the logic used to test rev-list, making adding new tests
> easier.  Uses a heredoc and sed expansion of the expected output,
> instead of shell substitutions and manually escaped echo's.

Justify why this change is a good thing upfront, by (1) giving a
short summary of what is done in the current code and (2) saying
what is suboptimal in it.

    Many tests in this script prepare each line of the expected
    --graph output separately with "echo", using bare object names
    of commits shown in the graph (captured in shell variables), run
    "rev-list --graph" with some other parameters and compares the
    result.  The expected shape of the graph is hard to see and the
    resulting code is repetitious.

And then outline your solution, giving orders to the codebase to
"become like so", in the next paragraph.

    In order to add new tests easier, introduce a helper function
    that takes extra parameters given to the "rev-list --graph" as
    its arguments, and the expected output from its standard input
    stream.  By allowing tagnames to be used in the expected output,
    eliminate the need to capture commit object names in shell
    variables.

cf. Documentation/SubmittingPatches::imperative-mood

> Reviewed-by: Junio C Hamano <gitster@pobox.com>

I didn't review this version (in other words, I think you changed
the patch after I reviewed)---so do not write this line.  It is
misleading.

>  . ./test-lib.sh
>
> +check_graph () {
> +	sed -f expand_tag_to_oid.sed >expect &&
> +	git rev-list --graph "$@" >actual &&
> +	sed 's/ *$//' actual >actual.sanitized &&
> +	test_cmp expect actual.sanitized
> +}

OK, so we prepare the mapping from tagname to objectname somewhere,
feed an expected output that uses tagname to this helper function
and munge it into the file expect, and then compare it with the
actual output.  

Why do we drop the trailing whitespace in the output before
comparing?  Is it because it does not matter?  Is it because it is
cumbersome to spell in the expected output in the source?

Not complaining.  But if we truly aim to make writing new tests
easier, we should tell those who may write new tests what they are
expected to be doing when using this helper function in a comment
before it to help them.  Some points I can think of off the top of
my head are:

 * The file expend_tag_to_oid.sed is created in a single "setup"
   test;  when adding a new test, the shape of the history and new
   tags used in it must be prepared before the "for-each-ref" that
   produces the file in the "setup" test.

 * The arguments to the helper are given to "git rev-list --graph"
   to be compared with the expected graph fed from the standard
   input.

 * The expected graph can use tags and branches instead of object
   names (and it is encouraged to do so) for readability.  You do
   not mimick trailing whitespaces on the lines [*1*].


>  test_expect_success '--graph --all' '
> -	rm -f expected &&
> -	echo "* $A7" >> expected &&
> -	echo "*   $A6" >> expected &&
> -	echo "|\\  " >> expected &&
> -	echo "| * $C4" >> expected &&
> -	echo "| * $C3" >> expected &&
> -	echo "* | $A5" >> expected &&
> -	echo "| |   " >> expected &&
> -	echo "|  \\  " >> expected &&
> -	echo "*-. | $A4" >> expected &&
> -	echo "|\\ \\| " >> expected &&
> -	echo "| | * $C2" >> expected &&
> -	echo "| | * $C1" >> expected &&
> -	echo "| * | $B2" >> expected &&
> -	echo "| * | $B1" >> expected &&
> -	echo "* | | $A3" >> expected &&
> -	echo "| |/  " >> expected &&
> -	echo "|/|   " >> expected &&
> -	echo "* | $A2" >> expected &&
> -	echo "|/  " >> expected &&
> -	echo "* $A1" >> expected &&
> -	git rev-list --graph --all > actual &&
> -	test_cmp expected actual
> -	'
> +	check_graph --all <<-\EOF
> +	* A7
> +	*   A6
> +	|\
> +	| * C4
> +	| * C3
> +	* | A5
> +	| |
> +	|  \
> +	*-. | A4
> +	|\ \|
> +	| | * C2
> +	| | * C1
> +	| * | B2
> +	| * | B1
> +	* | | A3
> +	| |/
> +	|/|
> +	* | A2
> +	|/
> +	* A1
> +	EOF
> +'

I do agree that the resulting test is easier to understand.

Thanks.

[Footnote *1*]

This is a tangent, but I wonder if somebody looked into how feasible
it is to eliminate the trailing whitespace in the graph output.  It
is OK to give whitespaces in anticipation of writing the commit
object names, but on a line in the output that exists only to show
connecting lines, where we know we will not write anything after the
graph, there is no excuse to end the graph part with a trailing
whitespace.

