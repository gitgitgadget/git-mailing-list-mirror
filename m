Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1DF1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfHAPqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:46:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57196 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfHAPqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:46:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21BFF749FF;
        Thu,  1 Aug 2019 11:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1EQAg8GyzkiAlrn/wTA5TGTh+CU=; b=WqSA++
        blDFdKcDwMY8+o60yhh5GZNnbfLi78AFjMdSYCQE6ngd0AIR4llWw0jg3cKnapSb
        k68UzEojEy+MQrPgnAcIiNtlEnpyWPeG1QukYUHXspSWSH/DQEI/LHircsal6k3B
        LqB6fCMyjoG2KHLCPVbvBP4OO7Dek18aC7JdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EvH+rIo8xpJ9YQbymMUmVDuAEpDofBW5
        rKtHYlGJPsG1Cpznntlm0RbvoF3Zp6LYOY6j/93Ub1LUyEo0N1JqAtUvcSjcgsuf
        ZzBHHEoXM6jhIchJ0+SMH+0vjEnYjsCOdzc8Q3TSro7LbodWOTuc1DxLW4/TdBTv
        ZHEO94mhJCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19424749FE;
        Thu,  1 Aug 2019 11:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DF9A749FC;
        Thu,  1 Aug 2019 11:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
        <20190731231848.GC1933@sigill.intra.peff.net>
        <20190801002125.GA176307@google.com>
Date:   Thu, 01 Aug 2019 08:45:54 -0700
In-Reply-To: <20190801002125.GA176307@google.com> (Jonathan Nieder's message
        of "Wed, 31 Jul 2019 17:21:25 -0700")
Message-ID: <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 740BEC76-B473-11E9-9F0E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Although as Dscho mentions, it's particularly irritating because it is
> not part of the paginated output.
> ...
> Let's bite the bullet and jump straight to --use-mailmap in case (4).
>
> While at it, add a new log.mailmap setting "auto" that can be used to
> explicitly request the new automatic behavior (so that e.g. if
> log.mailmap is set to "true" system-side, I can set it to "auto" in my
> per-user configuration).

While I think "revert to hardcoded default" may be a good idea, I do
not think the hardcoded default you implemented that changes the
behaviour based on the output destination makes much sense.  If I
want to eradicate junkio@cox.net from my paged/interactive output, I
want to eradicate it also in the output piped to the script I use
for authorship stats.  

I suspect that you may have misread the "is interactive" bit in the
original; that was used only to decide if we are going to warn.

Anyway, how about this much simplified version?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 1 Aug 2019 08:32:44 -0700
Subject: [PATCH] log: flip the --mailmap default unconditionally

It turns out that being cautious to warn against upcoming default
change was an unpopular behaviour, and such a care can easily be
defeated by distro packagers to render it ineffective anyway.

Just flip the default, with only a mention in the release notes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.23.0.txt |  8 +++-----
 builtin/log.c                     | 16 +---------------
 t/t7006-pager.sh                  |  2 --
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/Documentation/RelNotes/2.23.0.txt b/Documentation/RelNotes/2.23.0.txt
index 19e894a44e..6ef8f21b56 100644
--- a/Documentation/RelNotes/2.23.0.txt
+++ b/Documentation/RelNotes/2.23.0.txt
@@ -10,6 +10,9 @@ Backward compatibility note
    prerequisite patches in an unstable way, which has been updated to
    compute in a way that is compatible with "git patch-id --stable".
 
+ * The "git log" command by default behaves as if the --mailmap option
+   was given.
+
 
 UI, Workflows & Features
 
@@ -91,11 +94,6 @@ UI, Workflows & Features
    commit-graph files now, which allows the commit-graph files to be
    updated incrementally.
 
- * The "git log" command learns to issue a warning when log.mailmap
-   configuration is not set and --[no-]mailmap option is not used, to
-   prepare users for future versions of Git that uses the mailmap by
-   default.
-
  * "git range-diff" output has been tweaked for easier identification
    of which part of what file the patch shown is about.
 
diff --git a/builtin/log.c b/builtin/log.c
index 1cf9e37736..40b4cbf57d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -156,16 +156,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
-static char warn_unspecified_mailmap_msg[] =
-N_("log.mailmap is not set; its implicit value will change in an\n"
-   "upcoming release. To squelch this message and preserve current\n"
-   "behaviour, set the log.mailmap configuration value to false.\n"
-   "\n"
-   "To squelch this message and adopt the new behaviour now, set the\n"
-   "log.mailmap configuration value to true.\n"
-   "\n"
-   "See 'git help config' and search for 'log.mailmap' for further information.");
-
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -214,12 +204,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
-	if (mailmap < 0) {
-		if (session_is_interactive() && !rev->pretty_given)
-			warning("%s\n", _(warn_unspecified_mailmap_msg));
-
+	if (mailmap < 0)
 		mailmap = 0;
-	}
 
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 7976fa7bcc..00e09a375c 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -7,8 +7,6 @@ test_description='Test automatic use of a pager.'
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success 'setup' '
-	: squelch advice messages during the transition &&
-	git config --global log.mailmap false &&
 	sane_unset GIT_PAGER GIT_PAGER_IN_USE &&
 	test_unconfig core.pager &&
 
-- 
2.23.0-rc0-144-gce799e40b3



