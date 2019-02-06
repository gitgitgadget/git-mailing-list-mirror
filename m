Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989171F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBFAVf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:35 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55548 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:35 -0500
Received: by mail-qk1-f201.google.com with SMTP id w28so4795429qkj.22
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v5ncvF0/tMxmsjbrRb4qeq3WPVkNRAUgsE/fIVkGHIM=;
        b=WDLwR7G0XRITznEyAprspJubR6apSRuohq2yzw1iRf3OaCA2aERVW5dTSA2PhY9WKX
         RBGieGL5SuGMfbrH8+wabSmyh9nVbM4/rpFsah7xBNgQR2oxxjxQvke7pK+HYMMXnoR3
         2sBciYzvecRrTnUkXVDbb5FDjvOT9lOYhndrhpkiik7Pd9KRsF6AtGoioYtxj6bDWT5W
         SMj5k3X/HI5m2uOa6jjZDdwWDUhKJewVBI7RECV9s4oCNvoVRyPhEvEeE9qG+T/aSi47
         uELBqTXKTYezvkiU9iPnhKpUEBPrgOEXzuxvqXqAY3QrcfPOXFfo7RLQus+k0vlqWN/W
         Yg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v5ncvF0/tMxmsjbrRb4qeq3WPVkNRAUgsE/fIVkGHIM=;
        b=cnV/iy2G1TgRS28J2Gx2g796Ab/6Gy4Q1cIk3SF1imlvRsPDi7iaV6GCZvFjToHiel
         5t08cdgzZmYXnKJ7saAEYAvsCzUaYvUHjBX9xxaGLSJ9P/ghvZigev3gQhFxkEDPT6pX
         OgnrDRRyEA9ssNe3WCATWZi0X04rWiGkpBzVmPbV5Df9Lxj+i3F55of0U6jkH2LqGE5d
         +6PFYxK9rqtxlTygBEXMVXE8iSP1yzvrjvgH9LL3eVG64v9CnaY+mMBrhtl7wj5wbUPT
         pJ90M5R/UYpBCl3YN0yUI9z1xmjyJkxfqJqKWdJZyAQ38EPkIfKap21sHjI2XvP5VGn0
         lFZw==
X-Gm-Message-State: AHQUAuYMjt8yCGqy7qQRho7Pvx0dr9XGGUAwIbrZF7zHRfPfClKvSARG
        tBSaLNlniTIzc5IeTibHhRGcAso686TRlfqmg5fy2lZXuFJRJuXs4OaLPmIgVH9uYcpaxH9kPip
        oI21nedm/vZ5fShT/Jf+pwjNbDbSPrQ/Ap5r5XtjgYR8qbS90u092r1SWNHnShgHhjV8bZGIh2g
        01
X-Google-Smtp-Source: AHgI3IYeSGKxnu237PxepBc2/ReAl5Fuzq3jfIGV7RIVQAtgY0H4PflZMcgSYboHe8oLmMWzGU5gBVl99ROpMrv6cMtS
X-Received: by 2002:ac8:4647:: with SMTP id f7mr4840163qto.40.1549412493879;
 Tue, 05 Feb 2019 16:21:33 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:17 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <84b3464c07a827a7aa3fd427ab97754b107886a7.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 3/8] t5503: fix overspecification of trace expectation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to extract the wants from a trace, a loop in t5503 currently
breaks if "0000" is found. This works for protocol v0 and v1, but not
v2. Instead, teach t5503 to look specifically for the "want" string,
which is compatible with all protocols.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5503-tagfollow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 4ca48f0276..6041a4dd32 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -47,7 +47,7 @@ get_needs () {
 	test -s "$1" &&
 	perl -alne '
 		next unless $F[1] eq "upload-pack<";
-		last if $F[2] eq "0000";
+		next unless $F[2] eq "want";
 		print $F[2], " ", $F[3];
 	' "$1"
 }
-- 
2.19.0.271.gfe8321ec05.dirty

