Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB23E1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbdJ0RH6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:07:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:53191 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdJ0RHy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:07:54 -0400
Received: by mail-io0-f194.google.com with SMTP id f20so14107370ioj.9
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=opjzDxc4BEC8x0LmIhnoZCK87HJF7HK8EcjJ9RAI9iQ=;
        b=LkHjMt/sU/l21t/dFuy+FoSK9IcP2MZ2GKSJhaaRz7PAnJwhDfme/HLNRXP+/GxQKn
         9OAtvOg6qe35KOXUNJOkH+W/oD7dIQXdfmq9g3K/SiSLDMmpSGW7Gn38u+fOSB4DWO+K
         MfSDBozaR+3tC2KqasTywgF0Du6Xt5l65y61IUo9Yxe3x9OS+fkjih2AXgkwq5QFYjGj
         pyHRhi9/v2hxgeFjkePfo44vhEaPyI1WVKAu4o+cjgGqcAYGwmAKZvupg+vsnpY05xOH
         s1WZkpL8jXsNVU6KpFO0KPxDXeH8M0B6SyeZlTPdvbG5XKfPwPt10BgWNsdxFxOPyns5
         JwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=opjzDxc4BEC8x0LmIhnoZCK87HJF7HK8EcjJ9RAI9iQ=;
        b=BNF6cPHM+LcjW4oG0D4CRQlj3CDkn3+6DkA+iUJ2Bg9AvItNs90qe1mxaU/cPaW7GO
         qxbAh+rnwHnPR4+/Gojj56NsLRfn5bpy4dWnq6lvBcs+CNdPFwQz9t8whyBcpV/IqzkI
         CocyP65iUSzI+SSnzuyQKEjhXrFQoKVUVYa67r7GhVi1g5dgEgcxjQSm3t4Whgb5gHFv
         00FrJOi+29uoI7dqNAjEAlQ3qiYbJKIzjvtpZKxkdwZ1IfC6lpLuGcdQcoaF4sjWYJBa
         psIeEd2znnC1oIgz12ry967Ep388yp0E21L5+k4TzDNbxKaXSpRB0H/nM5TWn0aquT14
         /SdQ==
X-Gm-Message-State: AMCzsaX60kP6V5ijVDSK0A8BNyPShDG2hjl6XoF2xoejrDoN0kYFpVp8
        y0yAHaqtHnZpGBLj5KL2wXSv4g==
X-Google-Smtp-Source: ABhQp+RNwpsQ/7TBluy/WZDtSmGHxiBe9GM0i7Lcj1b+hiwLGxH6qLIvQ8GAhDKeulmP5H/8N8t0hQ==
X-Received: by 10.36.238.73 with SMTP id b70mr1454812iti.127.1509124073237;
        Fri, 27 Oct 2017 10:07:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id a29sm1105754itj.8.2017.10.27.10.07.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 10:07:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, larsxschneider@gmail.com, peff@peff.net,
        sbeller@google.com, tboegi@web.de
Subject: [PATCH 2/2] xdiff/xdiffi.c: remove unneeded function declarations
Date:   Fri, 27 Oct 2017 10:07:45 -0700
Message-Id: <20171027170745.2125-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171027170745.2125-1-sbeller@google.com>
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
 <20171027170745.2125-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to forward-declare these functions, as they are used
after their implementation only.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xdiffi.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 93a65680a1..0a4ea948f9 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,34 +22,17 @@
 
 #include "xinclude.h"
 
-
-
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
 #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
 #define XDL_SNAKE_CNT 20
 #define XDL_K_HEUR 4
 
-
-
 typedef struct s_xdpsplit {
 	long i1, i2;
 	int min_lo, min_hi;
 } xdpsplit_t;
 
-
-
-
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
-		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
-		      xdalgoenv_t *xenv);
-static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2);
-
-
-
-
-
 /*
  * See "An O(ND) Difference Algorithm and its Variations", by Eugene Myers.
  * Basically considers a "box" (off1, off2, lim1, lim2) and scan from both
-- 
2.15.0.rc2.443.gfcc3b81c0a

