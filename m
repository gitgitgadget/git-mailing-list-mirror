Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B06C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 06:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAED233EE
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 06:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAOGjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:39:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52639 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbhAOGjg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 01:39:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE172A1FB8;
        Fri, 15 Jan 2021 01:38:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bZPIgr2ocNQ+lvo6yhM4LPcworg=; b=ZejK39
        doRGOG6Xr97dcdxkDPaHrgoWuIlF+L88FY4159An6bsOh4vQc/Lmh+PLoBlfFeDv
        4Qrbj9Z0tq2FSo9YWuGk8y8zY8iOTkx7MdAur1kDboB2jgdYl/Fq1vPJaA+4kgID
        am9N99nWczfxxAgreJ0B7mAEL7wiSqBm3nK1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E5+1bBYDtS9679AFDjrcweuuNPExqYwj
        SpKQlgQIZSUS0+44LCw/iWM0Y1Jn1SEFf+QQlkFRsMMdUYipRDF/MdpsKflbG1ds
        8kpmRhATaFIeioI49YmgqVUQyy5Qzov3DbrJLF9ycocckNsL5aISD/uCFnxbIWVE
        NXRU4V2zlsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E57CFA1FB7;
        Fri, 15 Jan 2021 01:38:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73472A1FB6;
        Fri, 15 Jan 2021 01:38:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <YADOf41CcaRuToD7@google.com>
        <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
        <xmqqr1mmu2nx.fsf@gitster.c.googlers.com>
Date:   Thu, 14 Jan 2021 22:38:52 -0800
In-Reply-To: <xmqqr1mmu2nx.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 14 Jan 2021 22:36:50 -0800")
Message-ID: <xmqqmtxau2kj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55B939A4-56FC-11EB-9323-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here is how eventual merge of the topic into 'master' would resolve
> conflicts.  The straight merge chain from master..seen would have
> such a merge with the resolution shown below, but 'next' already has
> a mismerge, so I'll be applying a single-parent commit to fix the
> mismerge directly on 'next' (which I'll send in a separate message).

And this is the 'next' mismerge fix.

----- >8 ----- >8 ----- >8 ----- >8 ----- >8 -----
Subject: [PATCH] Fix mismerge of ds/maintenance-part-4 topic

At 1f98c859 (Merge branch 'ds/maintenance-part-4' into next, 2021-01-08)
the ds/maintenance-part-4 topic, which had an incorrect invocation
of internal "git config" when $(pwd) had ERE special characters, was
merged into the mainline that added "--fixed-value" feature to the
"git config" command to address this exact issue, and also changed
how test-tool stubbed out crontab calls.

The semantic conflicts for the latter have been fully resolved at
that commit, but four places that "git config" was invoked to look
for entries with the same value as "$(pwd)" were not adjusted to use
the "--fixed-value".  They should have been.

Helped-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7900-maintenance.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2e0c8a4c31..1074009cc0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -487,7 +487,7 @@ test_expect_success 'start and stop macOS maintenance' '
 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
 
 	# start registers the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	ls "$HOME/Library/LaunchAgents" >actual &&
 	cat >expect <<-\EOF &&
@@ -512,7 +512,7 @@ test_expect_success 'start and stop macOS maintenance' '
 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance stop &&
 
 	# stop does not unregister the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >expect &&
@@ -538,7 +538,7 @@ test_expect_success 'start and stop Windows maintenance' '
 	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
 
 	# start registers the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	for frequency in hourly daily weekly
 	do
@@ -551,7 +551,7 @@ test_expect_success 'start and stop Windows maintenance' '
 	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance stop &&
 
 	# stop does not unregister the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	printf "/delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >expect &&
-- 
2.30.0-386-gfb533afdb4

