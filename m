Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D2EC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhLZD7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 22:59:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52865 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhLZD7n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 22:59:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92DBC16CCF9;
        Sat, 25 Dec 2021 22:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dTLgUnGpmsBXRbGS7kKquvMfItv+HGJZGLSuWVDquu8=; b=IIUb
        aeZouHpkSgqokkAMBIBzjdN1yd2EG5071tcOASudAzM0D+fYq1rbXeUvZGBAVP2S
        VZDYN+EbWqgM5figFlP8BTVv1oQe8D0uhoGs5rhp2YM9IF5AYa2cO3WfNK9uG52a
        KSMYfHJDYFgkl80tMroDZSnpclOrLJOYCV0gugQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BCEB16CCF7;
        Sat, 25 Dec 2021 22:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EAF9E16CCF6;
        Sat, 25 Dec 2021 22:59:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 21/29] t7527: create test for fsmonitor--daemon
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <eedaa787c2ebeb56fd745ca23199b1810dd5245e.1634826309.git.gitgitgadget@gmail.com>
Date:   Sat, 25 Dec 2021 19:59:37 -0800
Message-ID: <xmqq1r203tjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F4EA3C0-6600-11EC-B430-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While I was looking at the differences between next..seen to catch
new topics that try to sneak style violations into the codebase, I
found this one (there was another in the same series).

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] fixup! t7527: create test for fsmonitor--daemon

Fix style violation of a shell-function definition

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7527-builtin-fsmonitor.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index e62ec9aa3c..313c4fad34 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -213,43 +213,43 @@ test_expect_success 'status implicitly starts daemon' '
 	test_subcommand git fsmonitor--daemon start <.git/trace_implicit_2
 '
 
-edit_files() {
+edit_files () {
 	echo 1 >modified
 	echo 2 >dir1/modified
 	echo 3 >dir2/modified
 	>dir1/untracked
 }
 
-delete_files() {
+delete_files () {
 	rm -f delete
 	rm -f dir1/delete
 	rm -f dir2/delete
 }
 
-create_files() {
+create_files () {
 	echo 1 >new
 	echo 2 >dir1/new
 	echo 3 >dir2/new
 }
 
-rename_files() {
+rename_files () {
 	mv rename renamed
 	mv dir1/rename dir1/renamed
 	mv dir2/rename dir2/renamed
 }
 
-file_to_directory() {
+file_to_directory () {
 	rm -f delete
 	mkdir delete
 	echo 1 >delete/new
 }
 
-directory_to_file() {
+directory_to_file () {
 	rm -rf dir1
 	echo 1 >dir1
 }
 
-verify_status() {
+verify_status () {
 	git status >actual &&
 	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
 	GIT_INDEX_FILE=.git/fresh-index git -c core.useBuiltinFSMonitor= status >expect &&
-- 
2.34.1-568-g69e9fd72b5

