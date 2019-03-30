Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309FF20248
	for <e@80x24.org>; Sat, 30 Mar 2019 22:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfC3Wtk (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 18:49:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfC3Wtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 18:49:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id z76so3493482qkb.12
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTqzu4bkX97p2Gg0BAbqbU1HqIJ2T97IuvkxCs0Dmio=;
        b=g4x7a5t/Dv9fJhAmdSG1/UodWNhpnSxUAqkellaaLGUbFQfXTLc1Bc4cXdVYCT4Qb1
         tF+XRZMGR2vte/9J8+CMT9773/BOHuA04rNdCIrDYL8+HgjPz5qT/TihoFSqeqhbpgrY
         2lWRWG+nxI0IlWgGQaU8KNVm4O2M/EUy0Y0hZM2W6knsm0jA7guTueeIKG4pDLpFXYRY
         wIHFkwWgAwVF742lmTI4N+1tOASQp7hZ5BpMIxSoG3SHxNN7xZiv30dcpHD47pH8BWi+
         3iAjUmHz2mjXj9xaAhK8BVvc+UHUgNb/j8/Gd4EKLYUTAjl9Yc+XPIwdMWCDXpk4Tbim
         tKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTqzu4bkX97p2Gg0BAbqbU1HqIJ2T97IuvkxCs0Dmio=;
        b=RzhgL45VxowAldmhKm144imgouSQf/mqGR2inrtL45Nx2mPzrwN9e9hcQDNiD07njJ
         JDPivP1CbiKl8+hhXEF0ZLdnk2bkW8JLF2reBAmfHjtRF18fL4itMveleLiZjmmdJjis
         Mm4zlSJoQrz4UmrMwWvwPbOA8fy39srjcQouVpxErzgawaNq/43MBDyL0F3mKDYZkgth
         GaGb+Y7qW8p4ICiJeyW0J9prVs43H5IJIoGOZYRMzQlS/WKBmt8bujNLN7QpAPuDvomw
         LeX4b+jBQKKd/4Tdvf0TyI9uoDjkIuwodXfnUAgzn0BUUoiiZ/eWGUc4Jj6XmMICW8Bu
         a3hg==
X-Gm-Message-State: APjAAAWBCMHAWnhHaXV7OUU0rzK83wLygvZMVauXaLTOvQSnDa+ux+wu
        Fb3tlfHDGvP0y7LurwEjezMEUw==
X-Google-Smtp-Source: APXvYqy9JVjoy/Ywt+waxf4o3OI15PuQd7CfMSDgTGWhIC/ITLPV9fLXAC9flXk5SeWowiuRNgHgYA==
X-Received: by 2002:a37:4c8e:: with SMTP id z136mr3383807qka.149.1553986179752;
        Sat, 30 Mar 2019 15:49:39 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::4])
        by smtp.gmail.com with ESMTPSA id x191sm3139943qka.78.2019.03.30.15.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 15:49:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v5 7/7] clone: replace strcmp by fspathcmp
Date:   Sat, 30 Mar 2019 19:49:07 -0300
Message-Id: <20190330224907.3277-8-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330224907.3277-1-matheus.bernardino@usp.br>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
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
index ebe8d83334..bf56a01638 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -439,7 +439,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		}
 
 		/* Files that cannot be copied bit-for-bit... */
-		if (!strcmp(iter->relative_path, "info/alternates")) {
+		if (!fspathcmp(iter->relative_path, "info/alternates")) {
 			copy_alternates(src, dest, src_repo);
 			continue;
 		}
-- 
2.20.1

