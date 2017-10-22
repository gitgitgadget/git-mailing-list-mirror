Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C17202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 17:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdJVRDS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 13:03:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:55855 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdJVRDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 13:03:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id l8so2295543wre.12
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pvRGW9aa3TwFVrhA+zSMKamAPw48pWyvw4+y6Pif1c=;
        b=anMcOPGpO/jUzPUsnLnvKrvaWP8BDULzuR+XvauHH0DNO4MZFvqqN0hkjUtyxPfdF8
         RCklNIqggv5kLrWz7yy7cEiZhPh/F+g8IwcfpoRZS5ZhKPRtrSB1lcxS1TzZjab/p8dJ
         NZZ3b6aJVDcMteM/JSE2JolRBWIc17CfQgHmFvO0r7zmknW8aDB8FYMkrVrs+iORIcfX
         HJ8XVPYsSDaYodDfXL53WTUJvHhcCSkvqALT62IuaprUxuicRNdDwFT5vMdmVGBEyKBg
         KLRms1TPbkMCnMZ90LFjXxE3DqvK35hIDxEJSSukySHVt1gQG62X6IujX8uOB4vzQBXH
         tdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pvRGW9aa3TwFVrhA+zSMKamAPw48pWyvw4+y6Pif1c=;
        b=aGcHZMel3C2EgV3jfv09q++c8YzqFXba970fUrxpZn1XKAIwmzxa/J/062mDvVrvzr
         CRWkYwoNR8f6f7wv3NK4kPD+wOBXre/FT1SwulvYVZKAncub/P17VGjiR9Y9KRHEgXgh
         aTrG2AQP4t5hMGRDJ9i6ISrGtoarIKUHr38OjJT6pm7m9kjYcTi5oY9Ec5Og9HYYkzj2
         jC47RgGBZ5Uh8B8UlGKiyw9FY+MAbA34v5ejHYTjYLVxRlr+oECOJ/lfe98oZrl0UXLY
         Gk+Rh9SrR8SZL33OsUUJjPiTJUohgFUqdv6urJ2GI9r6S3Ahd9ObtedcGIyMgxGaSsSx
         btbA==
X-Gm-Message-State: AMCzsaW4Iowx8wUoK9KIgNUMusG+vTGjUzh9o6/uYb55gP3SKq2/MJFb
        q1lUEabFs2HH8p1XEuUa1Ia++iXi
X-Google-Smtp-Source: ABhQp+R9ElithG07vkzc1RtdvBc0Dp821QaYZMuOuYMcpUNLBBEHPRzkuscO/m6pJdAd7JmqnFKSHA==
X-Received: by 10.223.199.205 with SMTP id y13mr9777332wrg.71.1508691791352;
        Sun, 22 Oct 2017 10:03:11 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id e131sm2869351wmg.15.2017.10.22.10.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 10:03:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/3] stash: remove now superfluos help for "stash push"
Date:   Sun, 22 Oct 2017 18:04:09 +0100
Message-Id: <20171022170409.8565-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.2.g8fac3e73c8.dirty
In-Reply-To: <20171022170409.8565-1-t.gummerer@gmail.com>
References: <20171019183304.26748-2-t.gummerer@gmail.com>
 <20171022170409.8565-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the 'git stash save' interface, it was easily possible for users to
try to add a message which would start with "-", which 'git stash save'
would interpret as a command line argument, and fail.  For this case we
added some extra help on how to create a stash with a message starting
with "-".

For 'stash push', messages are passed with the -m flag, avoiding this
potential pitfall.  Now only pathspecs starting with "-" would have to
be distinguished from command line parameters by using
"-- --<pathspec>".  This is fairly common in the git command line
interface, and we don't try to guess what the users wanted in the other
cases.

Because this way of passing pathspecs is quite common in other git
commands, and we don't provide any extra help there, do the same in the
error message for 'git stash push'.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 3a4e5d157c..4b74951440 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -260,18 +260,7 @@ push_stash () {
 			;;
 		-*)
 			option="$1"
-			# TRANSLATORS: $option is an invalid option, like
-			# `--blah-blah'. The 7 spaces at the beginning of the
-			# second line correspond to "error: ". So you should line
-			# up the second line with however many characters the
-			# translation of "error: " takes in your language. E.g. in
-			# English this is:
-			#
-			#    $ git stash push --blah-blah 2>&1 | head -n 2
-			#    error: unknown option for 'stash push': --blah-blah
-			#           To provide a message, use git stash push -m '--blah-blah'
-			eval_gettextln "error: unknown option for 'stash push': \$option
-       To provide a message, use git stash push -m '\$option'"
+			eval_gettextln "error: unknown option for 'stash push': \$option"
 			usage
 			;;
 		*)
-- 
2.15.0.rc0.2.g8fac3e73c8.dirty

