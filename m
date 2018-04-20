Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5EA1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeDTVIH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:08:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:39365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752744AbeDTVID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:08:03 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC8iq-1fISwo2SiO-008osh; Fri, 20
 Apr 2018 23:07:58 +0200
Date:   Fri, 20 Apr 2018 23:07:42 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 3/4] sequencer: leave a tell-tale when a fixup/squash
 failed
In-Reply-To: <cover.1524258351.git.johannes.schindelin@gmx.de>
Message-ID: <c23608f35af1ac9b8f7e0b9c17e2fa1fdf189ab1.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524258351.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eHUTBnhuKxd7ODRTnURAIiTCzA4jZCSlcqN2srNZgsRCa0NggZy
 DWkRKZRvU8o8yaXDOxLL/KFBGcao/8dFmJS0V3Q8bvqoUHSm0R7Eu/3vWH7rJNm9q/Hsno9
 41+dG6jM+OCW0JNI0mnlMjcPBkMfrEf+ejC0Sc/DUv0cYLBlw344TNQGK59FF4/9d8sZq8I
 cJOzvaH2SUshKtc2HIUHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gh32byxRZSI=:Okw8icevCgv46jxAEzmKYS
 oHk6nw/f+BGt/MYYd6p3L7AU3obSvWvzZ58SqA+kaqcq7nUJaXvxrSTtmgS13aLLFOu6FZTG4
 16aIxwZ2ECJx7T7S2kUn/PNG3xi/o75lNfHjQqu+9CLn1xp7J1rHgicKsSrhs04VZQDf+mtYC
 L3bFwEJ0XiBG8Hy8WdH05x/Yykd47U0ZEoAuQl6UbCjGxZ6P0UmzTQvpaK96us+pgHZOIqdGt
 sK6Vo80+NbgS2+GymwWXE1kXPzzVjGhkkvXxLhp0oFrFQIp8qaVdT1wygNNaWvtkF9qbNJLp5
 2gHYHWovqKYaCoNltq8d8eAviHsfQfts+MNo5ci1OGUGgkg+xB9nWDKCBs1kjctlEW+X12b/s
 gACa0rGSb0LBJ+9wZ6CpkBLUi3Cj8o3CCDK0o0W4eVWu5Lqf4tMhmEvOW8dpOzSa3loT/+Rm4
 lFoJO3MbxCOVw4dNnuPpvaC14sthBC3OO8P4xRZbOOys0IsPW8bxXQFZjL1zkbAjV6HwNT8tH
 5Qq4Am/htpCV0rmdnnHSCZ7uXqZmNDGAMPZwmQFATlVi0oVBwGxqnB6wpK364ltuMSxVVFrb0
 4KEBfNxkzBKru5B2pZdvjlN6A9mCU9HiSQHVNuSdUTtKMDXBQEOaFCqTBQwST7Kt1A/tZoOS4
 ZkHPB8HlxC3Zi4GRHxJy/JRTaos81Y4K11+kfDZoxoYLz7tMHXz3vnCZ28ETdbOncgHI5ApiZ
 1IMc3EoeQGS8jA4XrnxarCld55N5xoJr2+HIk4FTL2U3xdb5vz3EIyMx/gjd2pMvwNRqxmIUC
 PpaIegJ3cqhCVz1vtUDbojzLG6KuuA7VXzAZdpF1OMLU3g2rV4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming patch to clean up fixup/squash commit messages even when
skipping a final fixup/squash that failed with merge conflicts, we will
need to have some indicator what happened.

As we need to remove the message-fixup and message-squash files upon
failure, we cannot use those. So let's just write an explicit amend-type
file, containing either `fixup` or `squash`. The absence of that file
indicates that we were not in the middle of a fixup or squash when merge
conflicts were happening.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index dc482e76a28..a6a4efeaae2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -106,6 +106,13 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  * command is processed, this file is deleted.
  */
 static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
+/*
+ * If there was a merge conflict in a fixup/squash series, we need to
+ * record the type so that a `git rebase --skip` can clean up the commit
+ * message as appropriate. This file will contain that type (`fixup` or
+ * `squash`), and not exist otherwise.
+ */
+static GIT_PATH_FUNC(rebase_path_amend_type, "rebase-merge/amend-type")
 /*
  * When we stop at a given patch via the "edit" command, this file contains
  * the abbreviated commit name of the corresponding patch.
@@ -2400,10 +2407,20 @@ static int error_with_patch(struct commit *commit,
 static int error_failed_squash(struct commit *commit,
 	struct replay_opts *opts, int subject_len, const char *subject)
 {
+	const char *amend_type = "squash";
+
+	if (file_exists(rebase_path_fixup_msg())) {
+		unlink(rebase_path_fixup_msg());
+		amend_type = "fixup";
+	}
+	if (write_message(amend_type, strlen(amend_type),
+		       rebase_path_amend_type(), 0))
+		return error(_("could not write '%s'"),
+			     rebase_path_amend_type());
+
 	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 		return error(_("could not rename '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
-	unlink(rebase_path_fixup_msg());
 	unlink(git_path_merge_msg());
 	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
@@ -2580,6 +2597,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
+			unlink(rebase_path_amend_type());
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 		}
 		if (item->command <= TODO_SQUASH) {
@@ -2807,6 +2825,7 @@ static int commit_staged_changes(struct replay_opts *opts)
 	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
+	unlink(rebase_path_amend_type());
 	return 0;
 }
 
-- 
2.17.0.windows.1.15.gaa56ade3205


