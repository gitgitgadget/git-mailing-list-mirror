Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF2C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8121775
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTH1TxwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgIYGJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:09:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58699 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIYGJO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 02:09:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E2796B404;
        Fri, 25 Sep 2020 01:59:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=3FY9t644Vbr+ScW/WVXrfN4Gi
        EU=; b=pTH1TxwSx+wCKZ27t1rAfQsTIUy6sc5DyEM/AM11wzB6dq02R0E+bvTXp
        zbW1H+toSkGAEuUSXTvwJyxnP2qwcrLdXtuaRYgDLUOvvKeyrhZuHTgJIZxuSC/s
        J0icxxJVWl43jrFBnBqJ3NAqQbRb46gHXYl+X2OmiuZSYnJrBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=rSm1gx9RbpcDlSSyoNh
        6erby3QaOh1nRlZECYB1b0jWw5Zn9FRldune8fbwTN8RgbpVBXxJw6+Ygxx9vuE3
        sn6yJtyT5d+ilOY+sRJYRplIBektjNbtFdPPAtEDZADOcGi1XqTVUr9pwCcMS+uk
        RokXDz3PBMJsDX3VlZ2je7fs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 560DD6B403;
        Fri, 25 Sep 2020 01:59:59 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C90556B402;
        Fri, 25 Sep 2020 01:59:58 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] t8013: minimum preparatory clean-up
Date:   Thu, 24 Sep 2020 22:59:51 -0700
Message-Id: <20200925055954.1111389-2-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-718-gd8d5e3da39
In-Reply-To: <20200925055954.1111389-1-gitster@pobox.com>
References: <20200925055954.1111389-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 57E664F0-FEF4-11EA-A582-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closing sq for each test piece should be placed at the beginning
of line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t8013-blame-ignore-revs.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 36dc31eb39..67de83ae2b 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -31,7 +31,7 @@ test_expect_success setup '
 	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
 	git rev-parse X >expect &&
 	test_cmp expect actual
-	'
+'
=20
 # Ignore X, make sure A is blamed for line 1 and B for line 2.
 test_expect_success ignore_rev_changing_lines '
@@ -44,7 +44,7 @@ test_expect_success ignore_rev_changing_lines '
 	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
-	'
+'
=20
 # For ignored revs that have added 'unblamable' lines, attribute those t=
o the
 # ignored commit.
@@ -67,7 +67,7 @@ test_expect_success ignore_rev_adding_unblamable_lines =
'
=20
 	grep -E "^[0-9a-f]+ [0-9]+ 4" blame_raw | sed -e "s/ .*//" >actual &&
 	test_cmp expect actual
-	'
+'
=20
 # Ignore X and Y, both in separate files.  Lines 1 =3D=3D A, 2 =3D=3D B.
 test_expect_success ignore_revs_from_files '
@@ -82,7 +82,7 @@ test_expect_success ignore_revs_from_files '
 	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
-	'
+'
=20
 # Ignore X from the config option, Y from a file.
 test_expect_success ignore_revs_from_configs_and_files '
@@ -96,7 +96,7 @@ test_expect_success ignore_revs_from_configs_and_files =
'
 	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
-	'
+'
=20
 # Override blame.ignoreRevsFile (ignore_x) with an empty string.  X shou=
ld be
 # blamed now for lines 1 and 2, since we are no longer ignoring X.
@@ -120,7 +120,7 @@ test_expect_success bad_files_and_revs '
 	echo NOREV >ignore_norev &&
 	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
 	test_i18ngrep "invalid object name: NOREV" err
-	'
+'
=20
 # For ignored revs that have added 'unblamable' lines, mark those lines =
with a
 # '*'
@@ -138,7 +138,7 @@ test_expect_success mark_unblamable_lines '
=20
 	sed -n "4p" blame_raw | cut -c1 >actual &&
 	test_cmp expect actual
-	'
+'
=20
 # Commit Z will touch the first two lines.  Y touched all four.
 # 	A--B--X--Y--Z
@@ -171,7 +171,7 @@ test_expect_success mark_ignored_lines '
=20
 	sed -n "4p" blame_raw | cut -c1 >actual &&
 	! test_cmp expect actual
-	'
+'
=20
 # For ignored revs that added 'unblamable' lines and more recent commits=
 changed
 # the blamable lines, mark the unblamable lines with a
@@ -190,7 +190,7 @@ test_expect_success mark_unblamable_lines_intermediat=
e '
=20
 	sed -n "4p" blame_raw | cut -c1 >actual &&
 	test_cmp expect actual
-	'
+'
=20
 # The heuristic called by guess_line_blames() tries to find the size of =
a
 # blame_entry 'e' in the parent's address space.  Those calculations nee=
d to
@@ -227,7 +227,7 @@ test_expect_success ignored_chunk_negative_parent_siz=
e '
 	git tag C &&
=20
 	git blame file --ignore-rev B >blame_raw
-	'
+'
=20
 # Resetting the repo and creating:
 #
@@ -269,6 +269,6 @@ test_expect_success ignore_merge '
 	grep -E "^[0-9a-f]+ [0-9]+ 9" blame_raw | sed -e "s/ .*//" >actual &&
 	git rev-parse C >expect &&
 	test_cmp expect actual
-	'
+'
=20
 test_done
--=20
2.28.0-718-gd8d5e3da39

