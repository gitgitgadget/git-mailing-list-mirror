Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A08A1F45F
	for <e@80x24.org>; Thu,  2 May 2019 14:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEBOtR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:49:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37250 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEBOtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:49:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so1602141qkk.4
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCNwQ0xRP+5inD0eWz03EA3NndimqjIs1EhXIu81xYk=;
        b=RMF2rVPvrI8uK0hCGNgJXIhWHnnczCMUsEKp4pbjgW3W6redFbSE+VVx5fXDkNOjoo
         RTVXChbfRAN/e+3AwPGLHCd+ARpg0sw53YV0TkAW5a3m/XRmEFZ36DkS4ZxR4iq/oQB3
         HqISWLjUdGmhPXVRE93+1dRPxF3IfrkpSck5xAiIwoR4CytYTRVEUFa6UDKmLmpsmj2e
         oLcFKrDahSeX5tvHLMEoEvs6tsZQ1HfQqGkI0Sl4iJ+sEs8eSgiFge0NW+j9lBxFI6LV
         QdP8g7b1SmzH6XqsASDSqkn/nTXe5X4Vw0ks5qX9VMLlv9osQbE/+CZBwhWdeHcdQfg/
         NWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCNwQ0xRP+5inD0eWz03EA3NndimqjIs1EhXIu81xYk=;
        b=pYM4d2gTqQdx0UKaBmC7w7jFeeOgYL53FgQPHYVxNBEXgZXO8yIt0I8pmovOO+VojB
         Qv07rIvFYMVaKI3jIOuP/N8TIGBqhSbGSMkqkMbpTmvdqd30LjA6q3aK6Tejcr0SI1ur
         rHo/CMj4elvKkigFSAc3uUElTzh0CsCfHeeVoWeNVvQ6OUjeAZwvzzUYgjRt6bg5eag8
         kpd8j/Co/ha1Br5Ka9FEH3biiKZYWCgrFFezD3d71Dj77S6iXEp4sadSyYTQuJSUEym7
         zHv/Ot0nnTiCrZl7YlatNAsP0rAz4QOoM8dxSZE2fD0l1lA4fzbG01CVf4+obCzRb0Fm
         XXHA==
X-Gm-Message-State: APjAAAW8xWNpmZ+mZpCd0vjO3JBfdz4t7ZoI4efr6eTeYOYOpHGb8pqW
        lH8jJ5NTCXKXAbO7flD/U7a6KINtNQw=
X-Google-Smtp-Source: APXvYqwD0lmsn+qiyv3D6LuQM1ahO/j0S88zRzB8AxY3Rwnnh18juIlN+8b/KbnWamJW+Xpgu+Y0AQ==
X-Received: by 2002:a37:6087:: with SMTP id u129mr3338110qkb.300.1556808555953;
        Thu, 02 May 2019 07:49:15 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:49:15 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v6 10/10] clone: replace strcmp by fspathcmp
Date:   Thu,  2 May 2019 11:48:29 -0300
Message-Id: <20190502144829.4394-11-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of strcmp by fspathcmp at copy_or_link_directory, which
is more permissive/friendly to case-insensitive file systems.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f99acd878f..6e0f194c3b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -442,7 +442,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(iter->relative_path, "info/alternates")) {
+		if (!fspathcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
-- 
2.20.1

