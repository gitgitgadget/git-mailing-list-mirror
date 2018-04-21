Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A0C1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeDUHgD (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:36:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:45397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbeDUHgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:36:02 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsgvV-1ePcKk02iv-012Iw2; Sat, 21
 Apr 2018 09:35:59 +0200
Date:   Sat, 21 Apr 2018 09:35:42 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 3/4] sequencer: leave a tell-tale when a fixup/squash
 failed
In-Reply-To: <cover.1524296064.git.johannes.schindelin@gmx.de>
Message-ID: <55cc358a9baf4e96b50087da1f295f1c8e301d63.1524296064.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524296064.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w0iQhiCAb6odj0Oc5QxNacfhmLsXUbB9DHooEG19VmVJ9Dw4xlr
 XNwUUGVhrbpPTA3vnIGs/A2gNTrGyn1c4dYwGVkEovFPFbmlc6goegQO9p6vGpA7CYRwSCN
 gk3yaK1KncnJIdwFIoWCDvTv0ylJ/7WQgpwwbfL2yj68q0be6TzV5qh3oeVMUz3fWS/7ehl
 aGHegoIi/DZiaH3IEtFzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H0b5eB+B8QQ=:cOxlZG6jJao7QGQveUyNET
 bTavz2AJAexTzP5GAe482GHhO0ESjAVvom5bfzdXF+kEsrR0Iukfpz3kp1rxpaGiqgJVxVMcU
 ROukajVShSElzHRRZ50eBYuafMHoc/4tcrcc4yl8yPCVxr50lDLdLjwADGBsetaU1YVtOPtxw
 ABYSMf69FGIEe5BVUUTjciq7DNv75H6N4VVKDXo1v9RVjBb0J53TAKk2hoUHHY80czwnGyXeO
 9L95OySVEm4cd0tu3rxTKzGSCbCilOH83LMq7Z3C4Zb/hG0eZ4VbkyUvbRhY7jAT8nBydFt/n
 N+Mv2FsKRMlcBOeWHSmodWycTJ8cBcVFbPQ1KQTmCHJkbBH5YQU++9ZyL9eazM82IzZPb88Lv
 RhvDpi1XPaQDitdlQ8BtHpLvl1kPEv4DVeL3SomHqmuAggu1feKFHzTbNTaa/SPOHsgmennyz
 7Z1QrqTUvgUQsttI5zVbqJ6T0Tym10cTwSztaqV3jih3o6JUawC++k1gyr6MdWp2NA6t0lVfg
 FS3tn/Ui3QyLTYrrtzU1Qa82TQ4qMBytCAByhLj53bydcSpnYR8i/iPwosm5kTpTuag1O4FWf
 H83BCPiXmdFdHoe/DNTtUT5oK+vzomlR3T+ZV1qFISnD2eTJ7mOSgdCqLd1jUYaoFQffCIlhe
 h+HGGjVoGqXziE7wtLjp2TegvWFpkSEhH1w2ppl0wKJudeJe6UHtuaMHgQNNtpTay1PL/iWLc
 sVntBSpR2T50iftGE7OJrbIvdDeHHoA4QD+MP1bzQ1fmlR6iQat7mGhA9u0FmtMASMNfvsVZh
 HCtwXDr77QN/re4PVcMkTtxIWgGoab6P6f2/NxkK99AQsIQ3Nk=
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
 sequencer.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index dc482e76a28..9a85b705a84 100644
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
@@ -2400,10 +2407,21 @@ static int error_with_patch(struct commit *commit,
 static int error_failed_squash(struct commit *commit,
 	struct replay_opts *opts, int subject_len, const char *subject)
 {
+	const char *amend_type = "squash";
+
 	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 		return error(_("could not rename '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
-	unlink(rebase_path_fixup_msg());
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
 	unlink(git_path_merge_msg());
 	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
@@ -2580,6 +2598,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
+			unlink(rebase_path_amend_type());
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 		}
 		if (item->command <= TODO_SQUASH) {
@@ -2807,6 +2826,7 @@ static int commit_staged_changes(struct replay_opts *opts)
 	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
+	unlink(rebase_path_amend_type());
 	return 0;
 }
 
-- 
2.17.0.windows.1.15.gaa56ade3205


