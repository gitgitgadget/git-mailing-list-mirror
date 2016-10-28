Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588D8203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034310AbcJ1S4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:18 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33462 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030936AbcJ1S4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:09 -0400
Received: by mail-pf0-f172.google.com with SMTP id 197so41760898pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJPdZqq/0ihiynBkb+gJfc1i/d73RQdI7BYHZ/MfpVI=;
        b=DsRBQFvXZRb3IJ2Neenp/zxxSBaAfuxhBVJ6oU+XoX57f/fYQHIc0VmPnNhvBEgdgO
         dqqjMk07qhHcGupmf1ST0OFO7EukCzcHMMxeesPyNlPavyxC1ho35alsC9ezesW6QWqK
         Jxov+jheqXkd46xOy4J/lJx3SjShadaVUITONASbFmFQwzYJMBtE0IheTtlyZEx8JISO
         m0uAcIxScZsi2fxkBFfnIWHPTZPCyBMPEMMvvWnxS32DTwsRUy7zhf405l9MK1N2NOne
         DA29cWwmjAiXr4YIyUUL8H6U029jC7CfvFPp4K429hurD77xX2OyfKIsqJzQHYlyWThc
         zF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJPdZqq/0ihiynBkb+gJfc1i/d73RQdI7BYHZ/MfpVI=;
        b=Md0i1s1vv7CCX307WDCFa52xURabWaqVVkiXpEhHB+5XLbiTlPcd/q3LeAs42udtk0
         rL7EddLhxmfrXEHoEZNaLw/bzzPKVT2BCA3yofAd8cth4wv9S2jqk/sR13FSfWZKwZCg
         9tHRnyL3kCh9yF4EpZv/ZN1ReEY5c29G5kEL1+Rw7I8ZFuPlp62gUXColU3Ujn466V8+
         +16/td9vrjmZ4c9oFPBx4mT0444bGELc6XC9O0eiHHp6Oo8h7+MqArggthKDsSvhBaE2
         3EcqjWnSX7o2Tpd62o69rXC3Pwx/VtEZzAnlwrFznOrLcF/AP0VoyObuSj37hJkjoGbG
         ITcg==
X-Gm-Message-State: ABUngveDxUNij0VGFTu7c4D1G+yPs/+z/8SxOvTTD09am7uDcA4H7WyP4fglHAY4bcWfVf5/
X-Received: by 10.98.9.147 with SMTP id 19mr27436177pfj.68.1477680969005;
        Fri, 28 Oct 2016 11:56:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id a7sm20584400pan.34.2016.10.28.11.56.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 26/36] attr: make git_check_attr_counted static
Date:   Fri, 28 Oct 2016 11:54:52 -0700
Message-Id: <20161028185502.8789-27-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not used outside the attr code, so let's keep it private.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 attr.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 10f2042fbb..9f2da42e5f 100644
--- a/attr.c
+++ b/attr.c
@@ -896,8 +896,8 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
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
index fe26f3a588..292d56fe0f 100644
--- a/attr.h
+++ b/attr.h
@@ -51,7 +51,6 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
-extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.714.ge3da0db

