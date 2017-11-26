Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DIET_1,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FB020954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdKZDRj (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:17:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751975AbdKZDRh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:17:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43D86AE134;
        Sat, 25 Nov 2017 22:17:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=R/rWvJ6RtlVdubmZjraWVsZyneI=; b=AW+FQ7QwSJJWRmzXW6x8
        IHud85Fq1u0R212mpEzjmPpJgSgr45AdjqVePeHWssO6Y3RRSUV6dDuzG4Jlqw5k
        dljcr50391q1oAG3g+mqw+NWl7F/KNVEHXN7Z58SCdPp5EdH5VAi0uHwG/JbHXbY
        6ORQFJeK9oHw/1tElpqkRsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=q/Z54OxUJvs+oAxxaqno2Q0vf79pYL35yP/ztgvYiWnEr3
        zQaup90C0KgROQHUURzkP6Vm7sC+nYHymoFKpM1L8xjhzKWi5AZBMfZndUXdFUGn
        E9t9ojIse9hOiIo2IDJrmDbflngvireUS75bJuD++/nbzUzIm9gQVbUwVMnls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B353AE133;
        Sat, 25 Nov 2017 22:17:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2E4FAE132;
        Sat, 25 Nov 2017 22:17:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v4 1/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 26 Nov 2017 12:17:34 +0900
Message-ID: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 596EAB50-D258-11E7-9899-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for sticking with this topic---very much appreciated, as we
> saw many newcomers get tired of doing repeated polishing and abandon
> their topic in the past.  I have to go offline now, but will comment
> later when I come back.

Regarding the overall structure of the series, I think 1/6 will
break tests and the breakage will stay until it is fixed at the
last step.  Also, now print_sha1_ellipsis() is prominently not about
"diff", it may want to move out of "diff.[ch]".

So, perhaps this may be a better structure:

 - 1/6: What we see in [v4 4/6] as an independent typofix.

 - 2/6: What we see in [v4 3/6] that is not about the output from
        "git checkout" (e.g. the use of ellipsis to shorten the
        example input the user gives, as if the user is using full
        40-hex and we are not bothering to show everything in the
        documentation), with "there is no need to use full 40-hex to
        identify the object names like the examples hint at by
        omitting the tail part of an object name as if that has to
        be spelled out but the example omits them only for
        brevity. Give examples using an abbreviated object names
        without ellipses just like how people do in real life", or
        something like that, as an explanation.

 - 3/6: Introduce a helper print_sha1_ellipsis() that pays attention
        to GIT_PRINT_SHA1_ELLIPSIS environment, and prepares the
        tests to unconditionally set it for the test pieces that
        will be broken once the code stops showing the extra dots by
        default.  What we see in [v4 5/6] may also want to be rolled
        into this patch.

        Nobody calls print_sha1_ellipsis() function yet at this
        step.  cache.h and environment.c may be a better place for
        the declaration and definition of the helper.

	Mention that the removal of these dots is merely a plan at
        this step and has not happened yet but soon will be in the
        proposed log message.

 - 4/6: What we see in [v4 2/6], optionally with two additional
        tests that looks at the output with and without the
        environment variable (it is optional because the output is
        purely for human consumption sent to the standard error
        stream).  Parts of [v4 3/6] about the output from the "git
        checkout" command also belongs to this step.

 - 5/6: What we see in [v4 1/6] (except for introduction of the
        helper, which already happened in an earlier step).  Move
        the promise of covering this new output format with a follow
        up series to the proposed log message of this step from [v4
        6/6].

 - 6/6: Realize the promise made in 5/6.

	Alternatively, just like the step 3/6 above prepares the
        tests for "upcoming" feature without exercising that
        preparation, a part of this can be split to allow annotating
        the "here-document" test vectors with "does this test expect
        that ellipsis will be missing in the output?" (i.e. change
        the logic in the loop that parses "<<EOF") without adding
        anything to the test vectors, and made into a separate step
        between 4/6 and 5/6 above.  Then we can include an update to
        the test in 5/6 that looks at the new output format without
        the environment in 5/6, which makes it clearer what the
        change is doing when viewing 5/6 alone.


For rererence, here is what I just whipped up that would come in
between the steps 4/6 and 5/6 in the above outline (i.e. split from
6/6 to be placed before 5/6 happens).

-- >8 --
Subject: [PATCH] t4013: prepare for upcoming "diff --raw --abbrev" format change

Most of the t4013 tests go through a list of sample command lines,
and each of them is executed and its output compared with an
expected one stored in t4013/ directory.  Allow these lines to begin
with a colon followed by magic word(s) so that test conditions can
easily be tweaked.

The expected use that will happen in later steps of this is to run
tests expecting the traditional output and run the same test without
the GIT_PRINT_SHA1_ELLIPSIS=yes environment exported for (perhaps
some of) them, which will have to expect different output.  Since
all of the existing tests are meant to run with the environment,
use the magic word "noellipses" to cause the variable not to be set
and exported.

As this step does not add any new test with the magic word, all
tests still run with the environment variable, expecting the
traditional output, but it will change soon.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4013-diff-various.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9bed64d53e..7288b54045 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -118,20 +118,37 @@ test_expect_success setup '
 EOF
 
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
-while read cmd
+while read magic cmd
 do
-	case "$cmd" in
-	'' | '#'*) continue ;;
+	case "$magic" in
+	'' | '#'*)
+		continue ;;
+	:*)
+		magic=${magic#:}
+		label="$magic-$cmd"
+		case "$magic" in
+		noellipses) ;;
+		*)
+			die "bug in t4103: unknown magic $magic" ;;
+		esac ;;
+	*)
+		cmd="$magic $cmd" magic=
+		label="$cmd" ;;
 	esac
-	test=$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
+	test=$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
 	pfx=$(printf "%04d" $test_count)
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
 	test_expect_success "git $cmd" '
 		{
-			echo "\$ git $cmd"
-			GIT_PRINT_SHA1_ELLIPSIS="yes" git $cmd |
+			echo "$ git $cmd"
+			case "$magic" in
+			"")
+				GIT_PRINT_SHA1_ELLIPSIS=yes git $cmd ;;
+			noellipses)
+				git $cmd ;;
+			esac |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
-- 
2.15.0-479-ge11ee266c9

