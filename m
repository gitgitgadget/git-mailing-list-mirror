Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E7C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbeFFHkl (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:41 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37213 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeFFHjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so5571091lfb.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJPM0EHj3Pyl6myYvW5lcWKLMThRXm45oJJpKLrbBmY=;
        b=fpg2rrAL228Wklz0ttNYd6px65FgAbbRRTLUhnIK3SEsqRyURSiCubmUXpUHzDAfB7
         fVB9nTORyXpMfpPQOjMTCx/B5U1conjSFTPCOSivgLjBjPiAYXudaYaldGqPSTj/QTtL
         3qrJ+zVF4VraDOcFu3/YWIEmDNxzUOm7eOAzn0XZcFql4zx/fiUtntcYtJsNeE9tcKXK
         sC3RVKCCYWNcaAHtAmhLvONymNocCW0V+E7onrcvF/qNvG+uoP0zaHq00YBoZBFI47eZ
         rxqTt187YBbLx7asAUvG0eUm2vIgj0692srYHCxv9BuLuhruMwna/ypMDIgYVYwbtCIX
         Yy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJPM0EHj3Pyl6myYvW5lcWKLMThRXm45oJJpKLrbBmY=;
        b=bZ4UTeK8FWl5YREORjhIGVokHk5KZiM5RUrDA6KCv1fVaoJiPeEOi7Lkhr326GTaJa
         jkRmgBDuCQsH6wi1oMwnjz46rrbw0yFNDXUGZ4hw9I8aRVpI6pSM3qwZrHLfJS5xBhAw
         3rOywhOPhjgdc38TrSqszO0AMdgFX/V+UIntcJc/Js/LFwMXe9XH/4h8dfGlxLnG+FCE
         HY0Iy3X0Qk+umTdAuZH0PcXDBw6TttkLsSt/3zHlWmuoCxlRUOwOz0JIK1Er/W7mSyTC
         KylgTINAWAxqcfevSE6EEiJLGeN/a5fhjoWK8TMsTKQOpp+JscZ2gheJ/sZ2OVnN5Zq0
         yCOA==
X-Gm-Message-State: APt69E1mRYEhMMBECUUxTiSNnGEAj3Fz/FbA5bysTr8OjvmMCW3JTl5X
        qcPvsbZXGH5ElMNl+ArhElg=
X-Google-Smtp-Source: ADUXVKL4smLEweTVlR90cGPeVees/XT+fY+VAFoboxmqIXSgQZQ6bOJK+boo90s5dgKOpUR7OPMZUw==
X-Received: by 2002:a19:6387:: with SMTP id v7-v6mr1107151lfi.74.1528270791418;
        Wed, 06 Jun 2018 00:39:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 06/20] attr.h: drop extern from function declaration
Date:   Wed,  6 Jun 2018 09:39:19 +0200
Message-Id: <20180606073933.14755-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/attr.h b/attr.h
index 442d464db6..46340010bb 100644
--- a/attr.h
+++ b/attr.h
@@ -42,31 +42,31 @@ struct attr_check {
 	struct attr_stack *stack;
 };
 
-extern struct attr_check *attr_check_alloc(void);
-extern struct attr_check *attr_check_initl(const char *, ...);
-extern struct attr_check *attr_check_dup(const struct attr_check *check);
+struct attr_check *attr_check_alloc(void);
+struct attr_check *attr_check_initl(const char *, ...);
+struct attr_check *attr_check_dup(const struct attr_check *check);
 
-extern struct attr_check_item *attr_check_append(struct attr_check *check,
-						 const struct git_attr *attr);
+struct attr_check_item *attr_check_append(struct attr_check *check,
+					  const struct git_attr *attr);
 
-extern void attr_check_reset(struct attr_check *check);
-extern void attr_check_clear(struct attr_check *check);
-extern void attr_check_free(struct attr_check *check);
+void attr_check_reset(struct attr_check *check);
+void attr_check_clear(struct attr_check *check);
+void attr_check_free(struct attr_check *check);
 
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
  * of the internal data structure; it should not be modified or freed.
  */
-extern const char *git_attr_name(const struct git_attr *);
+const char *git_attr_name(const struct git_attr *);
 
-extern int git_check_attr(const char *path, struct attr_check *check);
+int git_check_attr(const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-extern void git_all_attrs(const char *path, struct attr_check *check);
+void git_all_attrs(const char *path, struct attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
@@ -76,6 +76,6 @@ enum git_attr_direction {
 void git_attr_set_direction(enum git_attr_direction new_direction,
 			    struct index_state *istate);
 
-extern void attr_start(void);
+void attr_start(void);
 
 #endif /* ATTR_H */
-- 
2.18.0.rc0.333.g22e6ee6cdf

