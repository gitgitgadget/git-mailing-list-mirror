Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C2A1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfIDLJt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 07:09:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44470 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDLJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 07:09:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so11054548pgl.11
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wrzOIpcjjEmvJMim6T4s9RZRsdulem8x4zoj8A+eRUs=;
        b=KHcEt0Sx6QDMG1LwpoCavj1S2Zz1Lc89CELzwlX7PLUYslLa/YgwFBMaM8Sp5Rb0Mg
         abpXS0A/8IVIw4Q+K6l7vx1Istj/7esf5VvaNdBDcbrBXTYqS2pfvk6bm2EnY49rPAtG
         0D+yGVKsgBsD8qSTNA09puxa2mWdvW3ZTnuwvqapZZttQJzSUk9DN15ceq8VXS09wid/
         MEvATExPvaCuG/S4wNThtYhU8UA1WxXRAf0mreGzYXvoP2PZ6RHtUV++B0nbEbbVi0iL
         jU7ILJVJRnM4Ej7ujVluXcZ2mrevFq/vtA1TMNsuDgNx20JoE0isSFM8krnUHsePEWj5
         Mlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wrzOIpcjjEmvJMim6T4s9RZRsdulem8x4zoj8A+eRUs=;
        b=Ee+k15zeiyxND5vRO3o5yfGDDxPfsFuyZLwYJUMJNqWSMsTMfU/0OJC0oAx8P6CC0u
         gKqbkVtEPehymgCdjLkyP/e6xwyThjOIvISjqB2DF2+fWTZv9FzBKh5S5Omlw6ENqAjn
         BVugG1I5lI6BhqmboEO+l+tR38v6RwEkvTo+Yqo65GM1oqeUAyBeVKgIiyMza7zcDQVI
         TNOEWdMDG3ORmfHkHFJ5y+inuQCewskGu/GYAMLBETII0YcxPtT3Dgv9z12B3oORjwhc
         eHpC0losOF3t9ZDAnhklXKKRxHQt8GyObx8Lsam2VLqwl+cijCHM5P02cub8QevF5Q3W
         tOYw==
X-Gm-Message-State: APjAAAVBPbtF4l0sUyTY5DjhBf87MDL9Em3qcNL3+yqW/EVDU8vXcRKw
        1HTTyB99akVLAbZLdoa6YwsXbPkFOEw=
X-Google-Smtp-Source: APXvYqxg6fWzGzmbjsqMJfCX1OHVIBCfGuGpYGAmhxXUdso8kQCawYjRcArGCkDQz7be1v9NMcRCaw==
X-Received: by 2002:a63:316:: with SMTP id 22mr3785710pgd.242.1567595387826;
        Wed, 04 Sep 2019 04:09:47 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id x22sm41410481pfo.180.2019.09.04.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 04:09:47 -0700 (PDT)
Date:   Wed, 4 Sep 2019 04:09:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] mingw: apply array.cocci rule
Message-ID: <dcb92cffd7bd0643e7af68d825f7517d490dcf16.1567595331.git.liu.denton@gmail.com>
References: <cover.1567595331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567595331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After running Coccinelle on all sources inside compat/ that were created
by us[1], it was found that compat/mingw.c violated an array.cocci rule
in two places and, thus, a patch was generated. Apply this patch so that
all compat/ sources created by us follows all cocci rules.

[1]: Do not run Coccinelle on files that are taken from some upstream
because in case we need to pull updates from them, we would like to have
diverged as little as possible in order to make merging updates simpler.

The following sources were determined to have been taken from some
upstream:

* compat/regex/
* compat/inet_ntop.c
* compat/inet_pton.c
* compat/nedmalloc/
* compat/obstack.{c,h}
* compat/poll/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 738f0a826a..a3b1e9e3bb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1265,7 +1265,7 @@ static wchar_t *make_environment_block(char **deltaenv)
 		}
 
 		ALLOC_ARRAY(result, size);
-		memcpy(result, wenv, size * sizeof(*wenv));
+		COPY_ARRAY(result, wenv, size);
 		FreeEnvironmentStringsW(wenv);
 		return result;
 	}
@@ -1309,7 +1309,7 @@ static wchar_t *make_environment_block(char **deltaenv)
 			continue;
 
 		size = wcslen(array[i]) + 1;
-		memcpy(p, array[i], size * sizeof(*p));
+		COPY_ARRAY(p, array[i], size);
 		p += size;
 	}
 	*p = L'\0';
-- 
2.23.0.248.g3a9dd8fb08

