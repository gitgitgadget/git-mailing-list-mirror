Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415ED20401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdFNJdW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:33:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33491 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbdFNJcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:32:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so37562193wrb.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c5Cia/oCgm8Z/kljxxonpQlYMpOtIDqcdEARaLPuFSc=;
        b=dIHhXyveA8K31387Kr6os6yJ9vCth+Zw8/4sZSqdA41kGfbZXlMDT6q1yRcFmhhQMQ
         vqpQOZV/Xtbnkz+Rz0z/SXjlhr7UhSAX0iVXF+1TmAj/jCEhE17SyoeTQtKS4JDEjll+
         OFeIiBsZtSjyJZB2t4KyzUdvs4QdiQMGFy/L2jZl0jVem1IVaKBYnHphV0xrfvkPcWKm
         8DYVbUCqgvcdBQuK7Q39R+7rOWM7tS+xxm+u+7IZ9xqK5uRlM4VlewIBPV080yDzH2f3
         a0hIbkeZiFE04A5GJBa9iQOma36LSQeFYbVGt1GeCAZqB5r2dIqrsNbdu85hIN0tWqXC
         bhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c5Cia/oCgm8Z/kljxxonpQlYMpOtIDqcdEARaLPuFSc=;
        b=W8B9/fGOgVFTWQRwDqKd3GCowDOTlOOtJdaYwP7TA1ZUzJkmRKMBfoof48Ou4zB/T2
         ecZVjdkNAr0oD6Q/CAk8yOrxSZJRJz4iVKJUEsP9bKlJvFK7Gox1K0ergYRGdD3fAKKn
         ijt1gyyCk59mUpqzBwWHOp/4HJ7daNbUInNj4DwNVGwlm84MQWukcY8w/ycCyr6SRSYg
         B9AakLM8/y+odj/4g/oML1zWVtE+ldBxz6NTzsmD95JvELmCSkxgIhwbLeQadwDUKUtV
         pumYHL0cyW0JXizAf8s7KjbHBQMPYhEPi9uVKrIwZ9+ZoSdrLUb5Mp+iuM7edX9gnsHl
         kcjg==
X-Gm-Message-State: AKS2vOzCwhlFKKCQDvsIZYfTM0BaLNlzu9Mx+/HaCcjLiCaXqHNNVfAS
        yRcL40liHg0b7+yi4y8=
X-Received: by 10.28.144.20 with SMTP id s20mr292361wmd.85.1497432743679;
        Wed, 14 Jun 2017 02:32:23 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3418:f00:e584:54f4:675a:b9ca])
        by smtp.gmail.com with ESMTPSA id z194sm572928wmc.31.2017.06.14.02.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 02:32:21 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Wong <e@80x24.org>, Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] git-svn: document special options for commit-diff
Date:   Wed, 14 Jun 2017 11:31:38 +0200
Message-Id: <20170614093138.11861-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some options specific for `git svn commit-diff` where not documented
so far.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-svn.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index fba0b4eec..aa2aeabb6 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -459,6 +459,21 @@ Any other arguments are passed directly to 'git log'
 	(URL) may be omitted if you are working from a 'git svn'-aware
 	repository (that has been `init`-ed with 'git svn').
 	The -r<revision> option is required for this.
++
+The commit message is supplied either directly with the `-m` or `-F`
+option, or indirectly from the tag or commit when the second tree-ish
+denotes such an object, or it is requested by invoking an editor (see
+`--edit` option below).
+
+-m <msg>;;
+--message=<msg>;;
+	Use the given `msg` as the commit message. This option
+	disables the `--edit` option.
+
+-F <filename>;;
+--file=<filename>;;
+	Take the commit message from the given file. This option
+	disables the `--edit` option.
 
 'info'::
 	Shows information about a file or directory similar to what
-- 
2.13.1

