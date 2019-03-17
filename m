Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5694520248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCQMwN (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:52:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32948 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMwM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:52:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so9425560pfd.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4unOvUIEeB39fk6nRFzXXe4zBrZqMTl0BoGj6OGr3kc=;
        b=um6ChxDcY/JNu6MZnRx2evLJXMlyhTvwTmMETpacJ+blbkVqM5PwhifsMnChACLnW0
         erEW1eYqodG2bRkggElWa461sgJJGKfqjCvXKxqieDTiA7KgTrWkGutmvzmmLQGw9HeH
         NP6MTH1uwI2vHzGNG0QZLELuGxWHJ8tJMI/xMBnm18KL8pHtVOPnzX1Ruhl+uZbDyeEI
         /pEeoEh66JvGGRqTEf93a+rfhxye4FYbmaPxJ5NHS9aoHo7iy7hymFbj3li57l4bHd3f
         GeW9qGGu5PRA8r20HfHefTpuY9XzdybqJMHo+B4LtKsOyCV8J3BrPUz+aD91aXnNM/77
         tEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4unOvUIEeB39fk6nRFzXXe4zBrZqMTl0BoGj6OGr3kc=;
        b=legDVc21FHwFdFK1N47cvTSWRSni7HA03uiBxN6hzSrELbCmY1xa2LCqqo7K2W850G
         2NKtk6MZVGvezP1mL3Xw2orMKUAfw6YgzvIgGkHlG0X7C+5730Y7karXO1iQUvmGR8Gf
         8afwsRQMe5Ze9u4PlEjXppnAcScvxzKUlW0Rqg4jedOBS9SBBVZXVQDVculWmBXUS0zZ
         v8QcE3OnHTqHiJun5hGMkCjIe/dM6ywEiqzWfVR+d19at4kbCgmDiJkKLsCjrJIDBb6G
         ksfIVQ5pZ9BXJacvYvgg0MkuM7vtEgFjty6DfjEov507JkCjbH384t9ejDHIYuAvQKRp
         gHDg==
X-Gm-Message-State: APjAAAVHR+dle3Lvr7gOQBbqDriZWD8oNbb+sra68hhOUXtXDsYl++/P
        Z5Qdcc62vudORH+eUg3rDRx0u72X
X-Google-Smtp-Source: APXvYqxcrmvnaSH/HtP20OEI5mBosdz5DRIl2lyy8+20p6VRwGMdhnsCH0cSwVSwCV3A+pz/DQ8Ujg==
X-Received: by 2002:a62:469a:: with SMTP id o26mr178780pfi.251.1552827132110;
        Sun, 17 Mar 2019 05:52:12 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o76sm20591392pfa.156.2019.03.17.05.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:52:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:52:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 25/26] completion: support switch
Date:   Sun, 17 Mar 2019 19:49:25 +0700
Message-Id: <20190317124926.17137-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion support for --guess could be made better. If no --detach is
given, we should only provide a list of refs/heads/* and dwim ones,
not the entire ref space. But I still can't penetrate that
__git_refs() function yet.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976e4a6548..b24bc48276 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -37,7 +37,8 @@
 #   GIT_COMPLETION_CHECKOUT_NO_GUESS
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
-#     completion (e.g., completing "foo" when "origin/foo" exists).
+#     and git-switch completion (e.g., completing "foo" when "origin/foo"
+#     exists).
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -2158,6 +2159,40 @@ _git_status ()
 	__git_complete_index_file "$complete_opt"
 }
 
+_git_switch ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--*)
+		__gitcomp_builtin switch
+		;;
+	*)
+		# check if --track, --no-track, or --no-guess was specified
+		# if so, disable DWIM mode
+		local track_opt="--track" only_local_ref=n
+		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
+		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
+			track_opt=''
+		fi
+		# explicit --guess enables DWIM mode regardless of
+		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
+		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
+			track_opt='--track'
+		fi
+		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
+			only_local_ref=y
+		fi
+		if [ $only_local_ref = y -a -z "$track_opt" ]; then
+			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
+		else
+			__git_complete_refs $track_opt
+		fi
+		;;
+	esac
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.21.0.548.gd3c7d92dc2

