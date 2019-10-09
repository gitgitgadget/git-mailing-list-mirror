Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556911F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 20:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfJIUnv (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 16:43:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36799 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIUnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 16:43:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so2395231pfr.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Gecsx8EgAnaXIBvlCDAES/xSI172609UbMYIpVI7VU8=;
        b=jQQ1Sgzgo768qqr+5jB2FKwjaF3VwA//LMDhL7tObRO5mv/FMX2xyMomN67xaTObZa
         MtuOSHI60GxNGeDg18QIsySmgANF4jt4HoJIvVBxoz8p+EU6PWjMFFyxLnzbKASG2cww
         ujhL9kWIGt+Y/j9fvWuC6/0crfoFqVtA9RuUCiunnAgpdhBzqAsnUXykrgxxkdW1zFGH
         JXhxC6YYCLiQkI8hwVD9UnqicXKcyNcjMRNvrgX5H8HRwpFN4rRp8iNYkQNt74evf6sY
         yJZhNT4NO6LKdgk7VH2zbWXldTVuqQy+fauuShDKxpD2yeeEe037IbhcsJxtCLlLVwlC
         g0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Gecsx8EgAnaXIBvlCDAES/xSI172609UbMYIpVI7VU8=;
        b=axotNJbfsNOt0DTHBEsBis+iK+cqkZxy7eVML7dpo2M2zDZ/Co+rDxAsQe9LhGNild
         xLKHe+X+r7GXxlaOzisia9G0gq0gBvnsGcp6oJ4ttSfoSwryWmZmIf59s7mkV9gDqeZH
         XV+ueFeGIP/oxBKZt2ZKy4dDrhf6VTdNi0UaqZ/jvpXbeMMVvgIixXtBL+7t7sqvrna9
         SiF1Oj1cOmle4shNupeEde6kn4hsO2wybSdKTN8sUDS6myPU7brIctbMLfUVxLF0DpJ2
         kxcMgfjD08o0NpC6Scs7aAFrGnqiXEnw7mG4c9o8FGiA67dOa6sxmW5hG2oIQ9qwkh5K
         V5Bg==
X-Gm-Message-State: APjAAAUbWyI4TkLHARnt7ouIbm1PwtNYCxppHowb5CouQRwSZ0mS8ERx
        5mHcq+C/KZAeyTBv1cI5ZsAlgB03
X-Google-Smtp-Source: APXvYqzAoGQlh+NSpARkaQg33ClMO1kdO30kqleNLt/WTvnrVet5wWsA8Ec02vkRZiWI0p14WuaZ0g==
X-Received: by 2002:a63:e802:: with SMTP id s2mr6410526pgh.188.1570653829528;
        Wed, 09 Oct 2019 13:43:49 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id q20sm3634095pfl.79.2019.10.09.13.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:43:48 -0700 (PDT)
Date:   Wed, 9 Oct 2019 13:43:46 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH] Makefile: respect $(V) in %.cocci.patch target
Message-ID: <977b19bcf3ef34395288933eb0090b6d9c58864f.1570653788.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the %.cocci.patch target was defined in 63f0a758a0 (add coccicheck
make target, 2016-09-15), it included a mechanism to suppress the noisy
output, similar to the $(QUIET_<x>) family of variables.

In the case where one wants to inspect the output hidden by
$(QUIET_<x>), one could define $(V) for verbose output. In the
%.cocci.patch target, this was not implemented.

Move the output suppression into the $(QUIET_SPATCH) variable which is
used like the other $(QUIET_<x>) variables. While we're at it, change
the number of spaces printed from 5 to 4, like the other variables
there.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c99361e719..ae45bfc429 100644
--- a/Makefile
+++ b/Makefile
@@ -1890,6 +1890,7 @@ ifndef V
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
+	QUIET_SPATCH   = @echo '   ' SPATCH $<;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -2818,7 +2819,7 @@ FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-	@echo '    ' SPATCH $<; \
+	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
 		limit=; \
 	else \
-- 
2.23.0.746.g72fc0fc0b9

