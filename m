Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AAD1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeJIARw (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 20:17:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33017 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJIARv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 20:17:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so8120570pge.0
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=G4zHh+AbFpioT/y4cfgQUl9FMrBiwXM5OJtPeHJ2r+0=;
        b=l6QWZlEBL+cXaW2kW52F65UlKmFwiF7MGhBn1MKlQJqJT1U3kOMDP2qgLcxYCxm8zD
         QPV+UzeZDep8Pjl2gD+V07Jd9gbyVCZkqRy2YMmiQ5luMP3NkRoz9u1XotiYiOfhNjT4
         zoeKGnFjcmdiVT/moZ6h/rE51LA0D1RjAYGMq+PgsVtdrdICguaghZtslVJwQaqJn1o1
         U7G8yoMKtomSiHg5jyw/5pOBCbqwDfec4j83MZ66cmVrb/wr0EsQ95OtIlwkwNiSC1xC
         RH0Zjvj8Pmwk7/lourxP5PT0+dAgdX6qTrYg6LSe/ABITkLmcfTwuprkJLJ+MYkPEt0K
         udDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G4zHh+AbFpioT/y4cfgQUl9FMrBiwXM5OJtPeHJ2r+0=;
        b=BbQpXMC9pT3Fxnyxc+hLeAJkvuoOks6DtaS9JzjJhCptW9p/EyLIA7tQlroDRhM94b
         wFnY7vgmnPNK5Ukoa4LrAFH27V8eW7lq5LdrWL7pQcgy9qA776TQzjEikQvx5JjZQgTM
         WB9lo1LN6aLTBPHPZQ0T2Q7nur7hvpvniE6z8FE1ziNAT38R+VXtbGKPA1yQJMxojEDB
         0DxDGkxpvMF9TxWNzpwFpW1NtRj4Pg/u8g6YIrEFFaOAjGOqNEHNsHoems7CCaus20I6
         fgqfGJZRf/9URltFVk80l+nN4jZypQSL73XmCmfiuMVTZKDA0ojgBqCHb9LFGzzFhhTP
         6olQ==
X-Gm-Message-State: ABuFfojDNGXoKfTCnIMXz0keCdDVPO0HZ0S9S8fybwS0VIBWGJT9nkdB
        cDWQ991hfxd+bBjENy/2joTj61rl
X-Google-Smtp-Source: ACcGV63Wheb3vgEhFA+TWEzPADcvqS7rKk7tW0xE01k0FoF0jD0PzUoVgwcYwUTmBGmCN7jhmDh4Dw==
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr26247828pfe.255.1539018311599;
        Mon, 08 Oct 2018 10:05:11 -0700 (PDT)
Received: from manohar-ssh ([116.75.87.35])
        by smtp.gmail.com with ESMTPSA id t12-v6sm18381326pgg.72.2018.10.08.10.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 10:05:10 -0700 (PDT)
Date:   Mon, 8 Oct 2018 17:05:05 +0000
From:   Ananya Krishna Maram <ananyakittu1997@gmail.com>
To:     christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h in
 header files
Message-ID: <20181008170505.GA13134@manohar-ssh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All, 
I was searching through #leftovers and found this.
https://public-inbox.org/git/CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com/

This patch address the task discussed in the above link. 

From: Ananya Krishan Maram <ananyakittu1997@gmail.com>

skip the #include of git-compat-util.h since all .c files include it.

Signed-off-by: Ananya Krishna Maram <ananyakittu1997@gmail.com>
---
 advice.h             | 1 -
 commit-graph.h       | 1 -
 hash.h               | 1 -
 pkt-line.h           | 1 -
 t/helper/test-tool.h | 1 -
 5 files changed, 5 deletions(-)

diff --git a/advice.h b/advice.h
index ab24df0fd..09148baa6 100644
--- a/advice.h
+++ b/advice.h
@@ -1,7 +1,6 @@
 #ifndef ADVICE_H
 #define ADVICE_H
 
-#include "git-compat-util.h"
 
 extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
diff --git a/commit-graph.h b/commit-graph.h
index b05047676..0e93c2bed 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,7 +1,6 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
-#include "git-compat-util.h"
 #include "repository.h"
 #include "string-list.h"
 #include "cache.h"
diff --git a/hash.h b/hash.h
index 7c8238bc2..9a4334c5d 100644
--- a/hash.h
+++ b/hash.h
@@ -1,7 +1,6 @@
 #ifndef HASH_H
 #define HASH_H
 
-#include "git-compat-util.h"
 
 #if defined(SHA1_PPC)
 #include "ppc/sha1.h"
diff --git a/pkt-line.h b/pkt-line.h
index 5b28d4347..fdd316494 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -1,7 +1,6 @@
 #ifndef PKTLINE_H
 #define PKTLINE_H
 
-#include "git-compat-util.h"
 #include "strbuf.h"
 
 /*
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e07495727..24e0a1589 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,7 +1,6 @@
 #ifndef __TEST_TOOL_H__
 #define __TEST_TOOL_H__
 
-#include "git-compat-util.h"
 
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
-- 
2.19.0.272.ga00e0029e

