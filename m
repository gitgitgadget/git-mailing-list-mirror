Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37FA207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 04:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbcI3EKg (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 00:10:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750832AbcI3EKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 00:10:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8008642779;
        Fri, 30 Sep 2016 00:10:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ebf+6dZMaRsg3EdZ27O2abzHapg=; b=u5JJ5Q
        W6vBJNJW5i0m4X9BQj2yRCvHzdUCZpcyxpasC9C02ChCRisFz/PqeY7sXnPb3vl2
        S0sjPxqdzV+TONEX/4eZh0iZ8SwEO354KEiLgsdPr2fCD9ZFD2ZeFE1Y4lsN+F2n
        5n/Gz2CftrVGYJ1UaJ9plKXYAqW/sxKrUfsVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eJVpeWwYyU3eUIsvSUOoWI+kKI9x0OO/
        8qQ1nWPhn82eod9wUXr7jKI5C/vTcDHZk1OtpGXPnbato70TXx40El4HkJ5NeBYW
        vx0wDy/CnpMzjWM92XhioQnQax89lq3bsvpI7dUY03nBNzBe0tPPjzH2YOt/Ndzu
        B/frsXlw5QA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76FDE42778;
        Fri, 30 Sep 2016 00:10:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC55742777;
        Fri, 30 Sep 2016 00:10:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
        <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
        <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
        <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
        <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 21:10:30 -0700
In-Reply-To: <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 29 Sep 2016 20:54:57 -0700")
Message-ID: <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4E3BBB8-86C3-11E6-A2A6-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So this patch may actually be "production ready" apart from the fact
>> that some tests still fail (at least t2027-worktree-list.sh) because
>> of different short SHA1 cases.
>
> t2027 has at least two problems.
>
>  * "git worktree" does not read the core.abbrev configuration,
>    without a recent fix in jc/worktree-config, i.e. d49028e6
>    ("worktree: honor configuration variables", 2016-09-26).
>
>  * The script uses "git rev-parse --short HEAD"; I suspect that it
>    says "ah, default_abbrev is -1 and minimum_abbrev is 4, so let's
>    try abbreviating to 4 hexdigits".
>
> The first failure in t3203 seems to come from the same issue in
> "rev-parse --short".

A quick and dirty fix for it may look like this.

We leave the variable abbrev to DEFAULT_ABBREV and let
find_unique_abbrev() react to "eh, -1? I need to do the
auto-scaling".  "git diff-tree --abbrev" seems to have a similar
problem, and the fix is the same.

There still are breakages seen in t5510 and t5526 that are about the
verbose output of "git fetch".  I'll stop digging at this point
tonight, and welcome others who look into it ;-)

 builtin/rev-parse.c | 14 ++++++++------
 diff.c              |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 76cf05e2ad..f8c8c6c22e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -642,13 +642,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			    starts_with(arg, "--short=")) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
-				abbrev = DEFAULT_ABBREV;
-				if (arg[7] == '=')
+				if (arg[7] != '=') {
+					abbrev = DEFAULT_ABBREV;
+				} else {
 					abbrev = strtoul(arg + 8, NULL, 10);
-				if (abbrev < MINIMUM_ABBREV)
-					abbrev = MINIMUM_ABBREV;
-				else if (40 <= abbrev)
-					abbrev = 40;
+					if (abbrev < MINIMUM_ABBREV)
+						abbrev = MINIMUM_ABBREV;
+					else if (40 <= abbrev)
+						abbrev = 40;
+				}
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
diff --git a/diff.c b/diff.c
index c6da383c56..cefc13eb8e 100644
--- a/diff.c
+++ b/diff.c
@@ -3399,7 +3399,7 @@ void diff_setup_done(struct diff_options *options)
 			 */
 			read_cache();
 	}
-	if (options->abbrev <= 0 || 40 < options->abbrev)
+	if (40 < options->abbrev)
 		options->abbrev = 40; /* full */
 
 	/*
