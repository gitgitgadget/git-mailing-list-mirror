Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B638120248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfBXKL3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40572 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfBXKL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so5207130eds.7
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e/kkoqFiMnKOKsd4pRiVbgsvC/7a9DF4GVrtGAMNKMs=;
        b=ezBqc26IYhFtEdL+YWzoZ98yjxrrpYClTcVSPsg2iG6uxohATkfRHlWazlR+0OA8yK
         by4mNxWnNBCdj+2PC9w3yaWcTEwjRunAOMCC+kqkFKxMw4+a/vonLX/r7hcLlStch6M8
         E/qUFHdBStBI/C8jyeBBaInlR4QJrnML89pZNMy7y+A6Pv67jEm0cjZEm4OVdRuBfBM+
         oXUbe42D5BmxfSjCQsR7DWebqAdSKO+teRvGkeDtD+DHjtH9A5NgtVHTUwowyzqjSniy
         4+A7QFY0u44qThElZeTZ+4ME+W0oRVvkUAKDgfiD83Dk05Y4xye7Xq+SF6xCwx3cmwdJ
         uS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e/kkoqFiMnKOKsd4pRiVbgsvC/7a9DF4GVrtGAMNKMs=;
        b=M1edro3ub8vt8mdCrPLjokSABlnMnGZPaLfpdhwxtwWQnJbyecefvdPntK7WuiVvmK
         f20+Y1i7OR0A4Qo5VAfAu85qG6iwwKQpBm5CXgz/MqYDtO2tikQz97EzsAoAR0qvsCIM
         akDhOi2td7+pVwGha8QPmg8GoM6Ag+AGM461Ak2suY4VQhnJJczT8xD0Rz1LxUM+cxAN
         C8oUsd/J5KWzVpRwVplyF3PTYL8rAtikDpP8oxzwnjxV75BvLGmlB3Gi+WpCcDKY6EkH
         VSzi3VitVRWpRNquHdHqTbheQ0PMVlxhJZY7e81OgNy2ov47SjeZrA7IfrDqPAjbQuMf
         aQtQ==
X-Gm-Message-State: AHQUAubQieccKgZnEpfvmUDScUShgB8xPAu6OVhJiuQfx1o0cpuRHzwD
        l2SYx3U5T+ADjwhR4hQ5rOBt8r4J
X-Google-Smtp-Source: AHgI3IZqk21RT3DQkcDYi8YZbjNG7FOhtVBza94cu3OUPMfNxwmq4URV21p2vLrFDabVeN7qdDxFDw==
X-Received: by 2002:a17:906:28c4:: with SMTP id p4mr9246242ejd.63.1551003084392;
        Sun, 24 Feb 2019 02:11:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq4sm1195860ejb.75.2019.02.24.02.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:23 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:23 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:59 GMT
Message-Id: <c4b5884f657c5670409b669afcd2a71583794920.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/26] bisect--helper: Finish `bisect_start()` conversion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

With the conversion of `bisect_auto_next()` in previous commit,
`bisect_start()` has been successfully ported to C.

Add the subcommands to `git bisect--helper` and call it from
git-bisect.sh.

Remove `bisect_start()` shell method and call `git bisect--helper --bisect-start` subcommand
from git-bisect.sh.

Removing the part about signals as we are not doing anything
anymore to trap signals. While at it, "trap" is changed to
"handle". As "trap" is a reference to the shell "trap" builtin,
which isn't used anymore.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 29 +++++++++++++++++++++++++++--
 git-bisect.sh            | 29 +++--------------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2f19924471..d538cb04fb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -697,9 +697,9 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		return -1;
 
 	/*
-	 * In case of mistaken revs or checkout error, or signals received,
+	 * In case of mistaken revs or checkout error,
 	 * "bisect_auto_next" below may exit or misbehave.
-	 * We have to trap this to be able to clean up using
+	 * We have to handle this to be able to clean up using
 	 * "bisect_clean_state".
 	 */
 
@@ -743,6 +743,31 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
 	strbuf_release(&bisect_names);
+	if (res)
+		return res;
+
+	res = bisect_auto_next(terms, NULL);
+	/*
+	 * In case of mistaken revs or checkout error, or signals received,
+	 * "bisect_auto_next" below may exit or misbehave.
+	 * We have to trap this to be able to clean up using
+	 * "bisect_clean_state".
+	 * return code -11 is special code that indicates special success.
+	 *	-> bisect_start()
+	 *	   . res = bisect_auto_next()
+	 *	    -> bisect_auto_next()
+	 *	       . return bisect_next()
+	 *	       -> bisect_next()
+	 *		  . res = bisect_next_all()
+	 *		  -> bisect_next_all()
+	 *		     . res = check_good_are_ancestors_of_bad()
+	 *		     -> check_good_are_ancestors_of_bad()
+	 *			. res = check_merge_bases()
+	 *			-> check_merge_bases()
+	 *			   . res = -11
+	 */
+	if (res && res != -11)
+		bisect_clean_state();
 	return res;
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 7531b74708..fec527e1ef 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -63,35 +63,13 @@ bisect_autostart() {
 			[Nn]*)
 				exit ;;
 			esac
-			bisect_start
+			git bisect--helper --bisect-start
 		else
 			exit 1
 		fi
 	}
 }
 
-bisect_start() {
-	git bisect--helper --bisect-start $@ || exit
-
-	#
-	# Change state.
-	# In case of mistaken revs or checkout error, or signals received,
-	# "bisect_auto_next" below may exit or misbehave.
-	# We have to trap this to be able to clean up using
-	# "bisect_clean_state".
-	#
-	trap 'git bisect--helper --bisect-clean-state' 0
-	trap 'exit 255' 1 2 3 15
-
-	#
-	# Check if we can proceed to the next bisect state.
-	#
-	get_terms
-	git bisect--helper --bisect-auto-next || exit
-
-	trap '-' 0
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -184,8 +162,7 @@ bisect_replay () {
 		get_terms
 		case "$command" in
 		start)
-			cmd="bisect_start $rev"
-			eval "$cmd" ;;
+			eval "git bisect--helper --bisect-start $rev" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
@@ -284,7 +261,7 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		bisect_start "$@" ;;
+		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
-- 
gitgitgadget

