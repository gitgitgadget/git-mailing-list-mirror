Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53D320954
	for <e@80x24.org>; Mon, 20 Nov 2017 04:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbdKTEGZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 23:06:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750974AbdKTEGY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 23:06:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7F47B7D29;
        Sun, 19 Nov 2017 23:06:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QO1nEi46i8XyKkL+EPIXsp1rYTQ=; b=jBptqF
        ehGlg2C1/PNvI74zdf5HENZRFlhddAtt8mwK1UFwdy/NYnhMR8iZfFgdTwFogK/3
        bU6AW5PYlAr0JyR+KOsg3nQDf9e4+aIPLCqSc0wMbqU3/W+2MPympqw2u6R9sRMw
        aRDh6Inxl01jjrIkPTATz2y3WVSXwaI1lrhCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j0Oi16Md8yzHNHPHH3TW0URAd/rVYTtv
        c6fvSB4Ph1AFgT0L/64Tk+mdWDSZcJ0KxQyuIsIfYTemBRDYgoJB1QgDMLgSwGVv
        YEPAvEHFyKG5h0UMRxbeRxILIV1+pyDEPctQazI/xS+ITyO6GCQ2Fjji+tG+zd0y
        T+rxcdcsCgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFE81B7D28;
        Sun, 19 Nov 2017 23:06:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60BACB7D27;
        Sun, 19 Nov 2017 23:06:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v3 5/5] Testing: provide tests requiring them with ellipses after SHA-1 values
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
Date:   Mon, 20 Nov 2017 13:06:22 +0900
In-Reply-To: <20171119184113.16630-5-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 19 Nov 2017 19:41:13 +0100")
Message-ID: <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF9F47C-CDA8-11E7-819D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> *1* We are being overly generous in t4013-diff-various.sh because we do
> not want to destroy/take apart the here-document.  Given that all this a
> temporary measure, we should get away with it.

I do not think the patch is being particularly generous.  If
anything, it is being unnecessarily sloppy by not adding new checks
to verify the updated behaviour.

The above comment mentions "destroy/take apart" the here-document,
but I do see no need to destroy anything.  All you need to do is to
enhance and extend.  For example, you could do it like so (this is
written in my e-mail client, and not an output of diff, so the
indentation etc. may be all off, but should be sufficient to
illustrate the idea):

    while read cmd
    do
            case "$cmd" in
            '' | '#'*) continue ;;
            esac
            test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
            pfx=$(printf "%04d" $test_count)
            expect="$TEST_DIRECTORY/t4013/diff.$test"
            actual="$pfx-diff.$test"
   +        case "$cmd" in
   +        X*) cmd=${cmd#X}; no_ellipses=" (no ellipses)" ;;
   +        *) no_ellipses= ;;
   +        esac
   -        test_expect_success "git $cmd" '
   +        test_expect_success "git $cmd$no_ellipses" '
                {
                        echo "\$ git $cmd"
   -                    git $cmd |
   +                    if test -n "$no_ellipses"
   +                    then
   +                            git $cmd
   +                    else
   +                            PRINT_SHA1_ELLIPSES=yes git $cmd
   +                    fi |
                        sed -e ....
        ...
    done <<\EOF
    diff-tree initial
    diff-tree -r initial
    diff-tree -r --abbrev initial
    diff-tree -r --abbrev=4 initial
   +Xdiff-tree -r --abbrev=4 initial
    ...
    EOF

There is a new and duplicated line with a prefix X for one existing
test in the above.  The idea is that the ones marked as such will
test and verify the effect of this new behaviour by not setting the
environment variable.  The expected and actual test output for the
new test will have X prefixed to it.  t4013 is arranged in such a
way that it is easy to add a new test like this---you only need to
add an expected output in a new file in t/t4013/. directory.  And
the output with these ellipses removed will be something we would
expect see in the new world (without the escape hatch environment
variable), we would need to add a new file there to record what the
expected output from the command is.

I singled out the diff-tree invocation with --abbrev=4 as an example
in the above, but in a more thorough final version, we'd need to
cover both "abbreviation with ellipses" and "abbreviation without
ellipses" output for other lines in the test case listed in the
here-document.
