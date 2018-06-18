Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8441F597
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937060AbeFRXn3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:29 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41591 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937005AbeFRXn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:27 -0400
Received: by mail-ot0-f196.google.com with SMTP id d19-v6so20527433oti.8
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2VfwsGRM8TRKo+qIHKBeAd53krkytiNc+gdRqvXTlLo=;
        b=g+nC2aRCCS9eNCjsqahoBdwdBtf1KLWvGYCblOVPpoE/KXPsDECdVZtHk2NHTnJsnX
         rFBbsCx4qQ15x1qOFFtAplmhgln/TxHf740lQz6X5qaT/wWaWGQOgthWu0KrCMKBadj/
         GmR1FZ3XfOuGj0Wqdl5oZEqerZ8BDLGuvN3G+ilCMdBhZR6AWAWNf11zgw7Oef120Pg/
         33qn7hVYr5vCFvzNTXSR5jShlEi0iZAO7OVl4T7Bpbh54K6zIVESm7JoTG01O9hmppFm
         11soWV3ed74Y//3zJ0fLmemKB4huX6qB4wYYOU8zJNbHQ7UpZJKlcbl3Sps8O+z+UuoB
         oBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2VfwsGRM8TRKo+qIHKBeAd53krkytiNc+gdRqvXTlLo=;
        b=nxppcjKdXLuhoI6soR4I9FE/UQNIksCIeTku9ydpdfUr2b+ZWshkeCr+xHTVxedrG6
         p2wX9/o3E1c/u9nz0kbCeITooMZCL/4KkoWxchFFadLsyvgzxtsupHvzaUosw5wcXpCT
         QzFglx0khaGlPaaZkJ1eE/c18j5CSv+Xv3W9VIdU/LbbKlRmZnYZALUiT6TOKFpmamjE
         3tTjuucxVPs7W5+BkWatUrH/C+uoncqvavw7KIOudP26N6K1ANvJgQcQIY7nUPnmdEd9
         Xv/saHKMo6R7E7pBlU1NCwp87wyC7fYkeryjtJoNJlYOV1T4SyyJ2V2YfMGkEvjrij5E
         AyDg==
X-Gm-Message-State: APt69E2+vm+RJ6mhvJOTVNFIZTjV2Hd6zUHbuv9tuePZyWq3lOFIorWO
        viNSLxEVcOXcQmRGvI3hc0YFlZiQIoo=
X-Google-Smtp-Source: ADUXVKIDYCzsKTYGCYj3/ZzbmnVvzVCNB5vEnQZluvtXa8+OQY3BoX0MuPllaPxjl30t3NyeqfvcXg==
X-Received: by 2002:a9d:6314:: with SMTP id q20-v6mr4174534otk.12.1529365405990;
        Mon, 18 Jun 2018 16:43:25 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id m17-v6sm7303752otk.1.2018.06.18.16.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:24 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 7/7] contrib/git-jump/git-jump: jump to exact location
Message-ID: <8819fcfbb1c443b37cbc719f1e4a0d61d6ed808d.1529365072.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of 'git-grep(1)''s new option, '--column' in order to
teach Peff's 'git-jump' script how to jump to the correct column for any
given match.

'git-grep(1)''s output is in the correct format for Vim's jump list, so
no additional cleanup is necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/README   | 12 ++++++++++--
 contrib/git-jump/git-jump |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..2f618a7f97 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -25,6 +25,13 @@ git-jump will feed this to the editor:
 foo.c:2: printf("hello word!\n");
 -----------------------------------
 
+Or, when running 'git jump grep', column numbers will also be emitted,
+e.g. `git jump grep "hello"` would return:
+
+-----------------------------------
+foo.c:2:9: printf("hello word!\n");
+-----------------------------------
+
 Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.
@@ -35,7 +42,8 @@ Git-jump can generate four types of interesting lists:
 
   2. The beginning of any merge conflict markers.
 
-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a
+     line.
 
   4. Any whitespace errors detected by `git diff --check`.
 
@@ -82,7 +90,7 @@ which does something similar to `git jump grep`. However, it is limited
 to positioning the cursor to the correct line in only the first file,
 leaving you to locate subsequent hits in that file or other files using
 the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
+complete list of files, lines, and a column number for each match.
 
 
 Limitations
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..931b0fe3a9 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n --column"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.17.0.582.gccdcbd54c
