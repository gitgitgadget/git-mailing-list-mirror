Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27DCA2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966191AbcJ1Sz2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:28 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34301 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbcJ1SzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:25 -0400
Received: by mail-pf0-f173.google.com with SMTP id n85so41586432pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPNj05xYr7uwoth2TR92lDl0IBBn94zIqDo3vpJrNOA=;
        b=L+iA36q8oeCU2FEpivGd4WpGkum/9/zeEmbdBaj/KW3Wg8sCWtYR+cbT0sSPd1Eoy8
         aiGQqmVfjyywOFckgxvFgSyZXPTUlAyQ5NQwFLtbBq/o/hOycrAqFVR3SXBhXijvKIU6
         bECEfmwnG9tbykQqXGU2pj0WgDeXF5cd6+HMo3UgNAS2NUwwaCaI3dmhuA13sum0vfhN
         trNzztA9D3xuehze6Rff1HZhPsQoeQv105/zqOENitHadADOAMTAhBBCcN0MNZsECpOL
         C6jRY5dkEPlq94cNGV2azy216bits3nBhgJ225Hrwh5DEM7RQEncQ+Kq/FttxIPrhVAj
         egQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPNj05xYr7uwoth2TR92lDl0IBBn94zIqDo3vpJrNOA=;
        b=LSzT+HSUTgnIlCsRk0b5kAd6Fz5vSF/6t9u4G+P3vMSPvhGVAf5wugXmrPWLlSlfIP
         wqiwPjsAeMRzDPwme9bTpRsS26NKeQK3Ku6HQ9L3hUuVt3xyEAGAnqD9AJnm+veo1DLR
         vITaiWrOzmiQnXJandWSBpCPH9hzpgkn+30+UgGDCS4dXQsncGAV2ByRY62nRhHWAFL1
         Mxr/fPj25XsUuMHOGtXfwXGrkRvx/nKWac55SHBntpcNfjjBITNDrKlt3kQeeLh6DrSN
         Rdw3zT//pKwxew86LXgQLbsygSNJZe2xR6FdYX9GCdYEFDguYKEeYB79dUszYqStHZWI
         tNWg==
X-Gm-Message-State: ABUngvcIuHN1RceE0tJzluvCIAFtBZj30rqRqqYNbhUFNzo6KDYmJP0poGVlafHPLEk3LHg4
X-Received: by 10.98.17.196 with SMTP id 65mr27078418pfr.55.1477680924299;
        Fri, 28 Oct 2016 11:55:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id f81sm20534081pfd.84.2016.10.28.11.55.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 03/36] attr.c: update a stale comment on "struct match_attr"
Date:   Fri, 28 Oct 2016 11:54:29 -0700
Message-Id: <20161028185502.8789-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When 82dce998 (attr: more matching optimizations from .gitignore,
2012-10-15) changed a pointer to a string "*pattern" into an
embedded "struct pattern" in struct match_attr, it forgot to update
the comment that describes the structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 04d24334e8..007f1a2995 100644
--- a/attr.c
+++ b/attr.c
@@ -131,9 +131,8 @@ struct pattern {
  * If is_macro is true, then u.attr is a pointer to the git_attr being
  * defined.
  *
- * If is_macro is false, then u.pattern points at the filename pattern
- * to which the rule applies.  (The memory pointed to is part of the
- * memory block allocated for the match_attr instance.)
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
  *
  * In either case, num_attr is the number of attributes affected by
  * this rule, and state is an array listing them.  The attributes are
-- 
2.10.1.714.ge3da0db

