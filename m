Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C26520229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966141AbcKJUft (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:49 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35877 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965299AbcKJUfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:10 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so152173459pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4A6ESqSCO5Wjlvl6JT2l/ttFcSD3B5qo8KoR4My3VwE=;
        b=e15JzqurVUIkYJRYxobGlHqtSLDP1s2O6IVezZ/FbzL67crkPdEdCr0zLIxIQjda3Y
         vELfnJqsdqZ+hrgTPxzgNCtLVfxlhHe8/2srvpkYmSnoA0NjLFbgnhciAY0N+Ma8SZQZ
         jYZrSP+6xnGTN18n22JcE6mkgJm5UazJurXxG+4RYx/ByuxvfuI2aThaQOIi/T/RSdss
         q2sMznewdDS7XKzrkWAvW1Rp1hgCgMU47RcZXto8htqBGldJI5SyftLqotxdFGZOMJhS
         E3PZY4Kcs6JS+Pc8SJeT9p4LSXY19mYpMQtba6jHzW7dIMHvgCg63wwWp1a0ZBOBPCds
         A5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4A6ESqSCO5Wjlvl6JT2l/ttFcSD3B5qo8KoR4My3VwE=;
        b=l80FfqYqY6GPrwb2e3EO55w+11IFpogrgOFKWdvfhFZEL9ub+p+BgKc4a4SkX3Mq3h
         WfwQfOnEoA9Gti50izeOtFY2yZo2/elH5BMPlSfZq8AdotRbRNQvBWa4XT+6ynXTfZTe
         t/6GyXBdNRVTGSeSwdYDnU7mxFysqIktZsGWRC7qHmxs3F/S1h2pB1nrRWNaJa1L2e0g
         p5UzS1Cpb9Oij6DTR4riz1dqQIpidwmrkruK3XNml0AXzzATEp9zhilQO+jpAqeBXcyt
         GqpZ/JdHrvXqzdt2Jk4DobyKjlkLLqzGn2l0n0xocGRZeyOU6x8CALGUs7qx3233jcFZ
         tU9A==
X-Gm-Message-State: ABUngveYqzXWzSMdU+a49WCn6WnV0XJqUOC/3182T0FIefmzoqGPV34iaf9BcWu4B3KZB+je
X-Received: by 10.99.5.21 with SMTP id 21mr26617473pgf.32.1478810109362;
        Thu, 10 Nov 2016 12:35:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id x20sm9257997pfa.84.2016.11.10.12.35.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 25/35] attr: make git_check_attr_counted static
Date:   Thu, 10 Nov 2016 12:34:18 -0800
Message-Id: <20161110203428.30512-26-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not used outside the attr code, so let's keep it private.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 4 ++--
 attr.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 60d7eec..19a3651 100644
--- a/attr.c
+++ b/attr.c
@@ -892,8 +892,8 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-int git_check_attr_counted(const char *path, int pathlen,
-			   struct git_attr_check *check)
+static int git_check_attr_counted(const char *path, int pathlen,
+				  struct git_attr_check *check)
 {
 	check->finalized = 1;
 	return git_check_attrs(path, pathlen, check);
diff --git a/attr.h b/attr.h
index 1c6a6d8..7416b14 100644
--- a/attr.h
+++ b/attr.h
@@ -48,7 +48,6 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
-extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.469.g00a8914

