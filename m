Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF55202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 16:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdGEQ7M (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 12:59:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36546 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdGEQ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 12:59:11 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so36739650pfk.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1a+KLHNnnWBUjrPb27ztJf5hIrS6d799jfxS0/RaQc=;
        b=Pj+vOqnzeeazLZSpqu4GoXMdmk79w3sUGM2m229NNwSAwRzkhNmWJRuWEVZVG/nYRn
         JlHXUzMALmzOUyafq5G4JrkXm7JI350WN5c1d89sR8fAQbgEHfAp4bNf27XBx/Oq+VjJ
         5e6iIqBqd4dVY47Ti7lBTcp0/5sXY9l5Xyus/Fbhc8K9DdaV1JWgOKXIMOceGVnmPHJj
         P0Nam7PszWeTEPSKoIqWNJS1RNPt8ZydfyQ9dM8fI4ztHrXKOdw/kSaIIWKoXfE0f7Qk
         UoV5T+cE5MzNlmCTM6z3wLwFIztLSIo1kds6CLsAymGVRe8XVqMT1clX4mQj4neLrWis
         s80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P1a+KLHNnnWBUjrPb27ztJf5hIrS6d799jfxS0/RaQc=;
        b=nKXGjRcpZUoQUratShE/ZCVKxVmjWDbFMqcd77SC9Wqj8+/T1xRsoF0VIOAwhD55BB
         V+qDfGC/a/vRiOUKz45lSunv+609zK36VvIjtV34i+irGjVLT6RpAePBNuhmIpkPV4oh
         pVO5piWr26e7i7JlYvJ2nLCeef7JFULRkPqTC8wqxZalYv7O/idOkdQxUPUTjvHrECL1
         g4ud5IX4GRk9Aa7HfRXo+TAV77htTVl1oEd/8P8d40uucPr/HIa0l/s6CuLgALv+FW03
         YPR4cKUZoZ4Up76jFOssxw85dB78BSthpzpC46ZGWHlw7jUH81kYDNzXBj0g8XJy+232
         NUeg==
X-Gm-Message-State: AIVw1126z4Tt+IRHQh4s9etIllvrqZKJpB7/NEbWDdYgTLs+fij9zUFw
        415T0ugruAVXTw==
X-Received: by 10.84.232.69 with SMTP id f5mr22996019pln.249.1499273950411;
        Wed, 05 Jul 2017 09:59:10 -0700 (PDT)
Received: from localhost.localdomain ([117.209.188.103])
        by smtp.gmail.com with ESMTPSA id i5sm38380777pgk.61.2017.07.05.09.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 09:59:09 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] hooks: replace irrelevant hook sample
Date:   Wed,  5 Jul 2017 22:21:14 +0530
Message-Id: <20170705165114.20662-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.29.g419244dab
In-Reply-To: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
References: <20170702112728.15757-1-kaarticsivaraam91196@gmail.com>
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
 This one's the final proposed patch for this simple hook. I have
 requested for suggestions for alternative scripts in the mailing
 list[1]. In case something interesting turns out, we could use that
 instead of this one.

 [1]: http://public-inbox.org/git/1499273152.16389.2.camel@gmail.com/T/#u

 templates/hooks--prepare-commit-msg.sample | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..0e2ccef11 100755
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
@@ -20,17 +21,20 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
-  merge,)
-    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+sed -e '/^# Please enter the .*/ {
+  N
+  N
+  d
+}' "$1" >'.sed-output.temp' && mv '.sed-output.temp' "$1"
 
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
2.13.2.14.gb9bd03b20.dirty

