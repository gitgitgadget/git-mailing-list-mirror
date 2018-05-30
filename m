Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3891F42D
	for <e@80x24.org>; Wed, 30 May 2018 23:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeE3X14 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 19:27:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36732 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753734AbeE3X1z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 19:27:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5-v6so4451101pgd.3
        for <git@vger.kernel.org>; Wed, 30 May 2018 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Lsr/H86owXPPrBjqVy8vKZ1Jt1zsnN03GpRMjrL6o=;
        b=qHVqliOAwQxBA6Jep3Bgw4szqh3FOcwJqSEQAp/86neiWHpB9OwUCbPhM7hglX4dFi
         3YLYknRVCFkhSQqTAeVVGaQpZ4FIZT8CjpylS7SHIspMohXIOWl5YcPJhHzf8UKGr4Hg
         BgWRkDY9nDRsslhacFLc27DeiZGpakQ57qGtOGOOHtBVn/ayAyn1tGJLJOWE8Lcycn4b
         ei+5tsMGf02AGQeHifwE8LBfdZ1NRHEI8y9KCn0A4wxJBaVZIa9v9w/qIhwy5WBRoyoX
         Nyrb5uV6ECtLdQoJFUub6itowW5rL6J5B1nyTz+W0fschtTbIdYVaVcsUDln9iTI42bZ
         e1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Lsr/H86owXPPrBjqVy8vKZ1Jt1zsnN03GpRMjrL6o=;
        b=T5TWxvWhVeKWaVnNpId1mdrjbH8ZRKiTZYm1c4R11T+l6cdl6KUkHOYUiC1XIQOPfO
         l5yK4Ds90phI13UHk8a8vUiH1IxMnDQh0JK9qySaf4z+UOAiON9f+ShCP1b44m6tSKZz
         Ed4Sh1dex6l0kQojjE/d7kVviPyiNcamFng2bvU1WCKZCZ+gGAI3sHBRrPHLtr397Uho
         +Q/6FUNE9mUh7dyTi5dT0VI3OH/OJjpy7EFSz7UIkcOOPrM0bUYycFD62JsM5sSM2OOm
         dfpXLqk1GHimVcBJCS8RVRrOW8ABqaceD+oe6chtJUbNuPbuNFYv3E6BsRnMRDkafYcz
         Uu2A==
X-Gm-Message-State: ALKqPwf2EYQFU+2yPtxa4mhbnYggnpo3RBYLXpx/E39zp/Kstpd7OPKl
        57KU1dq3bjDP2nlCsITB/dDaZg==
X-Google-Smtp-Source: ADUXVKLJyfWQPg4A/E2flYN97YkwTnBM8OS4VZLi2K4KqRNxYqeus2CLK+izWpiK4ET0TNo3dDp0Yw==
X-Received: by 2002:a62:2043:: with SMTP id g64-v6mr4611033pfg.12.1527722874923;
        Wed, 30 May 2018 16:27:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d15-v6sm63335554pfh.97.2018.05.30.16.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 16:27:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Announce: unset GIT_PAGER and add minimal usage in header
Date:   Wed, 30 May 2018 16:27:50 -0700
Message-Id: <20180530232750.10432-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running the Announce script in a terminal, the git shortlog will
open a pager, which is confusing as it leads to omission of the rest
of the message inside the pager. Do not page the output to avoid confusion.

While at it, add a basic usage example to the header, which illustrates
how it is used. This might be useful, but the way branch and previous
are set already help a lot.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This applies to the todo branch. Not sure if it is worth it, though.

I played around with the Announce script after I realized that the
announcement emails are not checked in, but generated on the fly.
The reason I played around with the script is the two seemingly same
points

>  * Rename detection logic in "diff" family that is used in "merge" has
>    learned to guess when all of x/a, x/b and x/c have moved to z/a,
>    z/b and z/c, it is likely that x/d added in the meantime would also
>    want to move to z/d by taking the hint that the entire directory
>    'x' moved to 'z'.  A bug causing dirty files involved in a rename
>    to be overwritten during merge has also been fixed as part of this
>    work. 

The second time it appears, it also contains:

>           Incidentally, this also avoids updating a file in the
>    working tree after a (non-trivial) merge whose result matches what
>    our side originally had.

which made me wonder how this message comes to life. 

Thanks,
Stefan

 Announce | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Announce b/Announce
index 91d0ba44cca..7c573e2fc40 100755
--- a/Announce
+++ b/Announce
@@ -1,11 +1,16 @@
 #!/bin/sh
 # Announcement message skelton
+# usage: Meta/Announce <version to announce> <diff-against>
+# e.g. Meta/Announce v2.18.0-rc0 v2.17.0
 #
+
 tmpbase=/var/tmp/git-announce.$$
 trap 'rm -f $tmpbase.*' 0
 branch=${1?branch}
 previous=${2?previous}
 commit=${3-"$1"}
+GIT_PAGER=
+export GIT_PAGER
 
 relname=$(git describe "$commit") &&
 vername=$(expr "$relname" : 'v\(.*\)') || exit $?
-- 
2.17.0.582.gccdcbd54c44.dirty

