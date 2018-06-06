Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6791F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933676AbeFFRC7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:02:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41540 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeFFRC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:02:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so10204920lfa.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJPM0EHj3Pyl6myYvW5lcWKLMThRXm45oJJpKLrbBmY=;
        b=ADHfpl13rs0IJou+oAypZQ0x4ws12LF2gin45oaAnFSAgH3ndKJbp2x3hc5WPJkeyv
         b+jGnbH2bmrD9GXfHR2ci+HSRvSTdrWEAYGJmgBlPbnrjnCMzjHGDN3GV3NYPUodiY9B
         uoAKx+NVoxq1+vP+yjHaHcAFstr0xPnXeMJx8Uj+KEybaqKaiy06s/j+GVgnnmmG/5yl
         oU9Jr19j3+FuhwefYCdL4f6h/w2GMC/EzNtEEw6F2u5eDyI2Li5gxZyzGmSc3EtypL91
         PfY4X7zB1SRY3KPlQ51ZriHlFSXn9p17bXY1AYS8MlcuG2m2CYfHGG0vz4U6jEZS2fgf
         KuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJPM0EHj3Pyl6myYvW5lcWKLMThRXm45oJJpKLrbBmY=;
        b=f6Xz6fxfWa4skhbZmIExmMCMkpQBYMnXYm0e7C4T8S7KZBJqzEnpPQpLtyYCTQ/inR
         dN3E4Fb+LmPFg43zqZsa5sX8cI3hC7YJ0u7/tOpKhmeJx2vqkKiVXZbQSdCPEpWgVmne
         AojOyvAAq3I9tJ8DoQiUpVnNPQ0bRQYaUuZ+AlU47XbdR81vxsPB+aeBw1qQG7YvBLaW
         gLMmitj2/6ZuttsIFFbC0nFsi8MKrq0EIx3MlGvmRoHbwzHgldo2Oj4KpUf/45HK1Ccb
         DbK+zHbXjGi/VfU41NZVLtg8F8kC7S3u4qSqo8MeHOj9uThQ4uJxxtFwZaLzsiFdbsro
         sSRg==
X-Gm-Message-State: APt69E0ezWV/p0rKCLfxGauMORZF2KUT5Up+C+by5x4PGSrKE/mfZi9D
        YrUQiQfzxqTR3/Rsbq0n0n0=
X-Google-Smtp-Source: ADUXVKKLjaD7imMxm/5ik6fmxeY6lawNp8kpHs32/P5IBbaq4umFhquZPEiKfeXIepa+mREPCiOBtw==
X-Received: by 2002:a19:7316:: with SMTP id o22-v6mr2163686lfc.6.1528304575050;
        Wed, 06 Jun 2018 10:02:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:02:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 06/23] attr.h: drop extern from function declaration
Date:   Wed,  6 Jun 2018 19:02:26 +0200
Message-Id: <20180606170243.4169-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
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

