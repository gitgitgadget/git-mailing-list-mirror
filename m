Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20AEC433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C9122CB2
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgLUT4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:56:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUT4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:56:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB48F10819D;
        Mon, 21 Dec 2020 14:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HreIcTzPxf33Pntk5ELd99j42qw=; b=AFw0dq
        EtqwRdl22v2f2FfRUqy403kIgYyAssKxtnyVyQKoiW+IHpnU4hNi0q9UJA5D+pko
        tKE17YN2NUPc8PslnXabjjxE6XY/qQDSfuk7SRKHEkyph3p2dKPMDxGA/pIuT8lQ
        5R3+GVWTsjkO7CQukkZDAd92EOc+uYdfjvGu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WPEy3YPLp02xyYFKO6KdJVMJTSqCiJTg
        YDCNi79n3Zk3nW4XxMcq1KJhs8Ss/2N2dwtyTkpgnm0kxyYPMJue7mSMz6cKbZWl
        1B/8RyR2XGplJ0SMkTSbGo8c1luq9aXKBfLJ/7GQLQGa7ulsqf5Mhrg2hMdHCYqR
        rhU9DA2lzVQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2F6510819C;
        Mon, 21 Dec 2020 14:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 285D6108197;
        Mon, 21 Dec 2020 14:55:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: [PATCH] SQUASH??? allow t0031 to run with any default branch name
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
        <CAFQ2z_MtpPNSpL9=OoyPfDRfkFxnCO19qBDnY9bnZiEEGtuMsQ@mail.gmail.com>
        <xmqqim8vm41g.fsf@gitster.c.googlers.com>
Date:   Mon, 21 Dec 2020 11:55:42 -0800
In-Reply-To: <xmqqim8vm41g.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 21 Dec 2020 10:01:47 -0800")
Message-ID: <xmqqsg7zkk75.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82C9F6DE-43C6-11EB-8168-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>>  The "reftable" backend for the refs API.
>>>
>>>  Ejected for now, as it has been breaking the tip of 'seen' for too
>>>  long.
>>
>>
>> Can you provide more information here? The PR at
>> https://github.com/git/git/pull/847 passes all tests (except for the
>> VSBuild, with errors that seem unrelated.)
>
> Sorry, but it has been a long time that I have no more detail than
> the above handy.  Older CI history might know more, but I have no
> time to dig that right now (and I'd be just as efficient as you
> would for doing such things).
>
> I can try including it in one of the today's pushout of 'seen' and
> see what breaks, which would be the easiest ;-)
>
> Thanks for pinging.

I just pushed one this morning, the only change from yesterday's
'seen' is that it has hn/reftable at the tip.

  https://travis-ci.org/github/git/git/jobs/750888904

It seems that we should stop assuming what the name of the default
branch is in a new repository.  One good way to do so would be to
change "git init" to "git init -b primary" so that the tests won't
get affected whether the default name is master or main or any other
value, and then use 'primary' throughout the name, instead of
assuming 'master' will stay to be the name used when unspecified
forever.

I'll queue the following on tip to force the test pass, but please
squash it into an appropriate step in the patch series; fixing it in
a different way may also be acceptable and welcome, if you or others
can come up with a cleaner way to do so.

Thanks.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---
Subject: [PATCH] SQUASH??? allow t0031 to run with any default branch name

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0031-reftable.sh | 54 ++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
index 58c7d5d4bc..ba0738e515 100755
--- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -9,23 +9,27 @@ test_description='reftable basics'
 
 INVALID_SHA1=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
 
+git_init () {
+	git init -b primary "$@"
+}
+
 initialize ()  {
 	rm -rf .git &&
-	git init --ref-storage=reftable &&
+	git_init --ref-storage=reftable &&
 	mv .git/hooks .git/hooks-disabled
 }
 
 test_expect_success 'SHA256 support, env' '
 	rm -rf .git &&
 	GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
-	git init --ref-storage=reftable &&
+	git_init --ref-storage=reftable &&
 	mv .git/hooks .git/hooks-disabled &&
 	test_commit file
 '
 
 test_expect_success 'SHA256 support, option' '
 	rm -rf .git &&
-	git init --ref-storage=reftable --object-format=sha256 &&
+	git_init --ref-storage=reftable --object-format=sha256 &&
 	mv .git/hooks .git/hooks-disabled &&
 	test_commit file
 '
@@ -34,13 +38,13 @@ test_expect_success 'delete ref' '
 	initialize &&
 	test_commit file &&
 	SHA=$(git show-ref -s --verify HEAD) &&
-	test_write_lines "$SHA refs/heads/master" "$SHA refs/tags/file" >expect &&
-	git show-ref > actual &&
+	test_write_lines "$SHA refs/heads/primary" "$SHA refs/tags/file" >expect &&
+	git show-ref >actual &&
 	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
 	test_cmp expect actual &&
 	git update-ref -d refs/tags/file $SHA  &&
-	test_write_lines "$SHA refs/heads/master" >expect &&
-	git show-ref > actual &&
+	test_write_lines "$SHA refs/heads/primary" >expect &&
+	git show-ref >actual &&
 	test_cmp expect actual
 '
 
@@ -54,9 +58,9 @@ test_expect_success 'clone calls transaction_initial_commit' '
 test_expect_success 'basic operation of reftable storage: commit, show-ref' '
 	initialize &&
 	test_commit file &&
-	test_write_lines refs/heads/master refs/tags/file >expect &&
+	test_write_lines refs/heads/primary refs/tags/file >expect &&
 	git show-ref &&
-	git show-ref | cut -f2 -d" " > actual &&
+	git show-ref | cut -f2 -d" " >actual &&
 	test_cmp actual expect
 '
 
@@ -70,12 +74,12 @@ test_expect_success 'reflog, repack' '
 	git pack-refs &&
 	ls -1 .git/reftable >table-files &&
 	test_line_count = 2 table-files &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/primary >output &&
 	test_line_count = 10 output &&
 	grep "commit (initial): number 1" output &&
 	grep "commit: number 10" output &&
 	git gc &&
-	git reflog refs/heads/master >output &&
+	git reflog refs/heads/primary >output &&
 	test_line_count = 0 output
 '
 
@@ -86,8 +90,8 @@ test_expect_success 'branch switch in reflog output' '
 	test_commit file2 &&
 	git checkout -b branch2 &&
 	git switch - &&
-	git rev-parse --symbolic-full-name HEAD > actual &&
-	echo refs/heads/branch1 > expect &&
+	git rev-parse --symbolic-full-name HEAD >actual &&
+	echo refs/heads/branch1 >expect &&
 	test_cmp actual expect
 '
 
@@ -102,7 +106,7 @@ test_expect_success 'peeled tags are stored' '
 	test_commit file &&
 	git tag -m "annotated tag" test_tag HEAD &&
 	{
-		print_ref "refs/heads/master" &&
+		print_ref "refs/heads/primary" &&
 		print_ref "refs/tags/file" &&
 		print_ref "refs/tags/test_tag" &&
 		print_ref "refs/tags/test_tag^{}"
@@ -114,32 +118,32 @@ test_expect_success 'peeled tags are stored' '
 test_expect_success 'show-ref works on fresh repo' '
 	initialize &&
 	rm -rf .git &&
-	git init --ref-storage=reftable &&
+	git_init --ref-storage=reftable &&
 	>expect &&
-	! git show-ref > actual &&
+	! git show-ref >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'checkout unborn branch' '
 	initialize &&
-	git checkout -b master
+	git checkout -b primary
 '
 
 
 test_expect_success 'dir/file conflict' '
 	initialize &&
 	test_commit file &&
-	! git branch master/forbidden
+	! git branch primary/forbidden
 '
 
 
 test_expect_success 'do not clobber existing repo' '
 	rm -rf .git &&
-	git init --ref-storage=files &&
-	cat .git/HEAD > expect &&
+	git_init --ref-storage=files &&
+	cat .git/HEAD >expect &&
 	test_commit file &&
-	(git init --ref-storage=reftable || true) &&
-	cat .git/HEAD > actual &&
+	(git_init --ref-storage=reftable || true) &&
+	cat .git/HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -168,7 +172,7 @@ test_expect_success 'rebase' '
 '
 
 test_expect_success 'worktrees' '
-	git init --ref-storage=reftable start &&
+	git_init --ref-storage=reftable start &&
 	(cd start && test_commit file1 && git checkout -b branch1 &&
 	git checkout -b branch2 &&
 	git worktree add  ../wt
@@ -182,13 +186,13 @@ test_expect_success 'worktrees 2' '
 	initialize &&
 	test_commit file1 &&
 	mkdir existing_empty &&
-	git worktree add --detach existing_empty master
+	git worktree add --detach existing_empty primary
 '
 
 test_expect_success 'FETCH_HEAD' '
 	initialize &&
 	test_commit one &&
-	(git init sub && cd sub && test_commit two) &&
+	(git_init sub && cd sub && test_commit two) &&
 	git --git-dir sub/.git rev-parse HEAD >expect &&
 	git fetch sub &&
 	git checkout FETCH_HEAD &&
-- 
2.30.0-rc1-180-g539a9eda38

