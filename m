Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B33FC388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 05:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF4C2225F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 05:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dE3ImVFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503025AbgJVF4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 01:56:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409018AbgJVF4I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 01:56:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7A37101F80;
        Thu, 22 Oct 2020 01:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=114QJHV63l+BofyvWyUH8KcC/sM=; b=dE3ImVFOaJ8QwZJu6ifb
        X81IruNl/dHZnbY3dMJx+m/PRZhjAWVnX43h7DFuq7bmzcQh1VKNnvuq2jyydry5
        F4UoZwI1zaLdt+ZTIu8t4EUPv7RU7ULcd204RIyQwQdilM806lEmu3jhgCDaRh3c
        HF7P+ActARtGpjp6JRtHV3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=goiWIAuTsT0o5X2WkB4vUBUHDB9ld+Y3Ptb4mpEzm17koB
        /2bZGIGCOJHseUQv8PMf73SU9njWj2qvMgzzBwiaa5Rg1fGCRkqMX9L6uObRAcct
        nSyvvDs97k66XicldxrVouPLIx6LH2M7MEiZuXjTl7JRDdwY1GxNI/tZ8Ga0w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B36C5101F7F;
        Thu, 22 Oct 2020 01:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC841101F7B;
        Thu, 22 Oct 2020 01:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after
 redirect operator
References: <20201020121152.21645-1-charvi077@gmail.com>
        <20201021124823.2217-1-charvi077@gmail.com>
        <20201021124823.2217-4-charvi077@gmail.com>
        <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
        <xmqq36264xx5.fsf@gitster.c.googlers.com>
Date:   Wed, 21 Oct 2020 22:55:58 -0700
Message-ID: <xmqqh7qmolch.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42AEC9AA-142B-11EB-B3C5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also, this is outside any test_expect_*, which is unusual in
> modernized test scripts.  There are many other instances of
> preparing expected output outside test_expect_* in this file,
> so we may need another patch to clean them up.
>
> For now, within the context of this patch, let's just fix the space
> after the << here-doc redirection operator, as you spotted.  The
> attached I'll squash into this patch.

And the other clean-up patch would look like this.

--- >8 ---
Subject: t7102: prepare expected output inside test_expect_* block

That way we can notice if there is a breakage/bug in the parts of
the test that prepare the expected outcome, which is how modern
tests are arranged.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7102-reset.sh | 244 +++++++++++++++++++++++++++----------------------------
 1 file changed, 121 insertions(+), 123 deletions(-)

diff --git c/t/t7102-reset.sh w/t/t7102-reset.sh
index 07acaa2beb..821e8bb94d 100755
--- c/t/t7102-reset.sh
+++ w/t/t7102-reset.sh
@@ -82,15 +82,15 @@ test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
 	test_i18ncmp .expected .actual
 '
 
->.diff_expect
->.cached_expect
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-EOF
-
 test_expect_success 'giving a non existing revision should fail' '
+	>.diff_expect &&
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	EOF
+
 	test_must_fail git reset aaaaaa &&
 	test_must_fail git reset --mixed aaaaaa &&
 	test_must_fail git reset --soft aaaaaa &&
@@ -191,38 +191,38 @@ test_expect_success 'resetting to HEAD with no changes should succeed and do not
 		check_changes $head5
 '
 
->.diff_expect
-cat >.cached_expect <<EOF
-diff --git a/secondfile b/secondfile
-index $head5p1s..$head5s 100644
---- a/secondfile
-+++ b/secondfile
-@@ -1 +1,2 @@
--2nd file
-+1st line 2nd file
-+2nd line 2nd file
-EOF
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-EOF
 test_expect_success '--soft reset only should show changes in diff --cached' '
+	>.diff_expect &&
+	cat >.cached_expect <<-EOF &&
+	diff --git a/secondfile b/secondfile
+	index $head5p1s..$head5s 100644
+	--- a/secondfile
+	+++ b/secondfile
+	@@ -1 +1,2 @@
+	-2nd file
+	+1st line 2nd file
+	+2nd line 2nd file
+	EOF
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	EOF
 	git reset --soft HEAD^ &&
 	check_changes $head5p1 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
 			$head5
 '
 
->.diff_expect
->.cached_expect
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-3rd line 2nd file
-EOF
 test_expect_success 'changing files and redo the last commit should succeed' '
+	>.diff_expect &&
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	3rd line 2nd file
+	EOF
 	echo "3rd line 2nd file" >>secondfile &&
 	git commit -a -C ORIG_HEAD &&
 	head4=$(git rev-parse --verify HEAD) &&
@@ -231,54 +231,54 @@ test_expect_success 'changing files and redo the last commit should succeed' '
 			$head5
 '
 
->.diff_expect
->.cached_expect
-cat >.cat_expect <<EOF
-first:
-1st file
-2nd line 1st file
-second:
-2nd file
-EOF
 test_expect_success '--hard reset should change the files and undo commits permanently' '
+	>.diff_expect &&
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	first:
+	1st file
+	2nd line 1st file
+	second:
+	2nd file
+	EOF
 	git reset --hard HEAD~2 &&
 	check_changes $head5p2 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
 			$head4
 '
 
->.diff_expect
-cat >.cached_expect <<EOF
-diff --git a/first b/first
-deleted file mode 100644
-index $head5p2f..0000000
---- a/first
-+++ /dev/null
-@@ -1,2 +0,0 @@
--1st file
--2nd line 1st file
-diff --git a/second b/second
-deleted file mode 100644
-index $head5p1s..0000000
---- a/second
-+++ /dev/null
-@@ -1 +0,0 @@
--2nd file
-diff --git a/secondfile b/secondfile
-new file mode 100644
-index 0000000..$head5s
---- /dev/null
-+++ b/secondfile
-@@ -0,0 +1,2 @@
-+1st line 2nd file
-+2nd line 2nd file
-EOF
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-EOF
 test_expect_success 'redoing changes adding them without commit them should succeed' '
+	>.diff_expect &&
+	cat >.cached_expect <<-EOF &&
+	diff --git a/first b/first
+	deleted file mode 100644
+	index $head5p2f..0000000
+	--- a/first
+	+++ /dev/null
+	@@ -1,2 +0,0 @@
+	-1st file
+	-2nd line 1st file
+	diff --git a/second b/second
+	deleted file mode 100644
+	index $head5p1s..0000000
+	--- a/second
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-2nd file
+	diff --git a/secondfile b/secondfile
+	new file mode 100644
+	index 0000000..$head5s
+	--- /dev/null
+	+++ b/secondfile
+	@@ -0,0 +1,2 @@
+	+1st line 2nd file
+	+2nd line 2nd file
+	EOF
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	EOF
 	git rm first &&
 	git mv second secondfile &&
 
@@ -288,46 +288,45 @@ test_expect_success 'redoing changes adding them without commit them should succ
 	check_changes $head5p2
 '
 
-cat >.diff_expect <<EOF
-diff --git a/first b/first
-deleted file mode 100644
-index $head5p2f..0000000
---- a/first
-+++ /dev/null
-@@ -1,2 +0,0 @@
--1st file
--2nd line 1st file
-diff --git a/second b/second
-deleted file mode 100644
-index $head5p1s..0000000
---- a/second
-+++ /dev/null
-@@ -1 +0,0 @@
--2nd file
-EOF
->.cached_expect
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-EOF
 test_expect_success '--mixed reset to HEAD should unadd the files' '
+	cat >.diff_expect <<-EOF &&
+	diff --git a/first b/first
+	deleted file mode 100644
+	index $head5p2f..0000000
+	--- a/first
+	+++ /dev/null
+	@@ -1,2 +0,0 @@
+	-1st file
+	-2nd line 1st file
+	diff --git a/second b/second
+	deleted file mode 100644
+	index $head5p1s..0000000
+	--- a/second
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-2nd file
+	EOF
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	EOF
 	git reset &&
 	check_changes $head5p2 &&
 	test "$(git rev-parse ORIG_HEAD)" = $head5p2
 '
 
->.diff_expect
->.cached_expect
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-EOF
 test_expect_success 'redoing the last two commits should succeed' '
+	>.diff_expect &&
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	EOF
 	git add secondfile &&
 	git reset --hard $head5p2 &&
-
 	git rm first &&
 	git mv second secondfile &&
 	git commit -a -m "remove 1st and rename 2nd" &&
@@ -340,15 +339,15 @@ test_expect_success 'redoing the last two commits should succeed' '
 	check_changes $head5
 '
 
->.diff_expect
->.cached_expect
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-3rd line in branch2
-EOF
 test_expect_success '--hard reset to HEAD should clear a failed merge' '
+	>.diff_expect &&
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	3rd line in branch2
+	EOF
 	git branch branch1 &&
 	git branch branch2 &&
 
@@ -366,14 +365,14 @@ test_expect_success '--hard reset to HEAD should clear a failed merge' '
 	check_changes $head3
 '
 
->.diff_expect
->.cached_expect
-cat >.cat_expect <<EOF
-secondfile:
-1st line 2nd file
-2nd line 2nd file
-EOF
 test_expect_success '--hard reset to ORIG_HEAD should clear a fast-forward merge' '
+	>.diff_expect &&
+	>.cached_expect &&
+	cat >.cat_expect <<-\EOF &&
+	secondfile:
+	1st line 2nd file
+	2nd line 2nd file
+	EOF
 	git reset --hard HEAD^ &&
 	check_changes $head5 &&
 
@@ -460,12 +459,11 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
-cat >expect <<EOF
-Unstaged changes after reset:
-M	file2
-EOF
-
 test_expect_success '--mixed refreshes the index' '
+	cat >expect <<-\EOF &&
+	Unstaged changes after reset:
+	M	file2
+	EOF
 	echo 123 >> file2 &&
 	git reset --mixed HEAD >output &&
 	test_i18ncmp expect output
