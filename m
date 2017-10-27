Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3EE1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbdJ0RH4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:07:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:47204 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbdJ0RHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:07:52 -0400
Received: by mail-io0-f196.google.com with SMTP id h70so14128190ioi.4
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=to7uAZxJMElmVud24t7Z0rjTNyCUI9f/jXQGY3LI25I=;
        b=qN3HRU2rq4NT+6noCJGR/E9Hk4nII40AYgA+ALHn7pDZDKmJsQD2gIwBXPaFQBLcYB
         b+a6X43MuQl9a6xPNkVSYCZ9/F+JZIpL4WRpKg1qEGUZ/XLzD5o+S1adpZIEHshT7Zc2
         sIGfrGU0+dCrcC1Rsk1UCHKI7PfDPvLC9yCWajd3tjeHr680vEUdlxRtrj65z1Ml0jag
         EDiZjpU5IjxER6BHQ7tRVjX3lc9L8Qj3N88aQhep3fOJfBUOAm2nNjLnyADl0imRIJ1R
         nKxtQXmN2Z1X6pq551KmWodI3ZgjL31X9J76wsJVg96U6djwTKaRrBMZcwKr4Y/HjhqO
         uPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=to7uAZxJMElmVud24t7Z0rjTNyCUI9f/jXQGY3LI25I=;
        b=TayFENKlEwsXujyV1BRVnmNZnQMbAn7sw/2lE07x6V0pYpAGPxc4QcqorGPWWd2KZ9
         61+gNOBJ+VV313Heps6CJIaf2PJ8Ik1xBqf1TAggyM9DZTRkpk8QvDRFTyg2gpSEaP1D
         Ali7O+G6Jsh+ULpgmnYuRIjsdQe4yAQB+6LJ9YbA1brp1Rm+yY2cuxu2ro1knsjaQ6qO
         UmGeLAHabXOcKqeI+ToVXMDtkjkICsm5DFbIIxQQZrob1RFOEZgDznY3NCA5cpelH+iZ
         N6l2lFKErBuD/ZqzMUY2LwWmWZQdevffpIUSt7mXPbJ9M7Pu3/rtX0S8nmvcm8mpMadA
         /Qqg==
X-Gm-Message-State: AMCzsaV6hf41/q74wrzXYOkMmPRswllriZ9Wf9dvvHUN0zuMsbOVcGXl
        fmGwjsDvyHsvDDPPbiIP5jOQbcSLwGw=
X-Google-Smtp-Source: ABhQp+TQ8DgexGX/CUUtfZBxUlge69e2BkPOHzvl0MWXC8vEbUzUzdZy/VhGQVFO7J8iKSVHV/0msg==
X-Received: by 10.107.142.131 with SMTP id q125mr1532466iod.71.1509124071722;
        Fri, 27 Oct 2017 10:07:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id i62sm3586530ioe.31.2017.10.27.10.07.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 10:07:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, larsxschneider@gmail.com, peff@peff.net,
        sbeller@google.com, tboegi@web.de
Subject: [PATCH 1/2] xdiff/xdiff.h: remove unused flags
Date:   Fri, 27 Oct 2017 10:07:44 -0700
Message-Id: <20171027170745.2125-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171027170745.2125-1-sbeller@google.com>
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
 <20171027170745.2125-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These flags were there since the beginning (3443546f6e (Use a *real*
built-in diff generator, 2006-03-24), but were never used. Remove them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 457cac32d8..0a41f5e500 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -48,14 +48,6 @@ extern "C" {
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
-#define XDL_MMB_READONLY (1 << 0)
-
-#define XDL_MMF_ATOMIC (1 << 0)
-
-#define XDL_BDOP_INS 1
-#define XDL_BDOP_CPY 2
-#define XDL_BDOP_INSB 3
-
 /* merge simplification levels */
 #define XDL_MERGE_MINIMAL 0
 #define XDL_MERGE_EAGER 1
-- 
2.15.0.rc2.443.gfcc3b81c0a

