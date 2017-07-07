Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1435D202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 16:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdGGQIN (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 12:08:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33921 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGGQHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 12:07:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so5157358pfe.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 09:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wGusbA2SmydaUnWWjxr/cKhDlc6maymKRmMg9/m11J4=;
        b=TVSSokjocgilDdw8tMGSz0Xt5pKn4Q6gLlp2yAaR5npxilNEGxhRWZlwx+dmYWN8fd
         2nWPSwfGtsHE0j2JUB2pzgJ5HLO8mHZJNijc89go3JpkRkTMvrCudwTPyOGsMYjw5kop
         u1qYfIt2jkHyeuxg11IQ0RNeP5x52Y3k6rXDgRtcd/FVkuiESD5LWHOkopbG9qy1PP/J
         P4B7ej51TwKOt/6L2akNmGipULrsU0xsL9aLBP/FUpyHf51hwAzCXwnoArN5SANgRF/V
         jgvMMhzYksKnnEFgWjdBRBs+SUxF33O3E772rIJ2xZZku21GlGqVfBLXCON71u8UQSnw
         NB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wGusbA2SmydaUnWWjxr/cKhDlc6maymKRmMg9/m11J4=;
        b=W1SUJp6+iNYBCLnAEjVAta0Ocpr6wlWZYIdB15gG00ZE9B4rz3odU4gsE0/eaY7E9t
         K8mDF6tsFkSJRqstOXlIgKVUxyWrBEnH7if38ITvTdGCsPvV5jwRDw8qhUPbMoYJ6WWn
         zNWtkzx2WAlSYCinXMY2d48yJVCX/HIUxwpGqZQImF80Gd3vefpMmLbmhHBzgK68ibN4
         mUqs65NZ5FDdGyVaOATtaAxBUuJxlp/85aq2JciiVskR5/Yd3vHSoY6Cb8Go3aRLg6o7
         2ZP0+lRI5GFb3FfHvPypl1/uh5JpI7j1shNMubCkEtYCDrpImr1HJaboqwjlk6d0hVOT
         G7xA==
X-Gm-Message-State: AIVw110uSoo/b/jSFYcB94TRWchw09kVRxEZc+Q4ZM9V1UZBbCZnkMgF
        qWVDAMm9+9u8Yw==
X-Received: by 10.99.178.20 with SMTP id x20mr2181045pge.220.1499443658963;
        Fri, 07 Jul 2017 09:07:38 -0700 (PDT)
Received: from localhost.localdomain ([117.243.19.92])
        by smtp.gmail.com with ESMTPSA id 10sm7778603pfo.134.2017.07.07.09.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 09:07:38 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] hooks: replace irrelevant hook sample
Date:   Fri,  7 Jul 2017 21:37:39 +0530
Message-Id: <20170707160740.9748-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.879.g2ab69f31a.dirty
In-Reply-To: <1499441062.6829.1.camel@gmail.com>
References: <1499441062.6829.1.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-commit-msg hook sample has an example that comments
the "Conflicts:" part of the merge commmit. It isn't relevant
anymore as it's done by default since 261f315b ("merge & sequencer:
turn "Conflicts:" hint into a comment", 2014-08-28).

Add an alternative example that replaces it. This ensures there's
at the least a simple example that illustrates what could be done
using the hook just by enabling it.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 I have made the second patch depend on the first one to avoid
 conflicts that may occur. Further, it was meaningful to join
 the two patches as they would go together (or) not at all.

 templates/hooks--prepare-commit-msg.sample | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..5a638ebda 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,8 +9,9 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes three examples.  The first comments out the
-# "Conflicts:" part of a merge commit.
+# This hook includes three examples.  The first one removes three
+# comment lines starting from the line that has the words
+# "# Please enter the" in it's beginning.
 #
 # The second includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
@@ -20,17 +21,16 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
-  merge,)
-    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+sed -e '/^. Please enter the commit message /,/^#$/d' "$1" >'.sed-output.temp' && mv '.sed-output.temp' "$1"
 
+# case "$2,$3" in
 # ,|template,)
 #   @PERL_PATH@ -i.bak -pe '
 #      print "\n" . `git diff --cached --name-status -r`
 #	 if /^#/ && $first++ == 0' "$1" ;;
-
-  *) ;;
-esac
+#
+#  *) ;;
+# esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
-- 
2.13.2.879.g2ab69f31a.dirty

