Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F83420966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdCZCne (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:43:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34228 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdCZCne (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:43:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so1928803pga.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVuZx0qrsX66LLVeycCTLGA+IgT43nOeG6Ww1xCEU0k=;
        b=iYtiT7IbSUGBhJ6WlS5au6ONbxvwL5mU6ppXkM4wOTRBvJ4BlP/0D2/01kodJqNKr0
         E3Kf/EnN4frcD7Qrx76LA+kHEmxFnpmfevLj/3acCBhSP1XoYn4Kj9gbb72hshRV5fIi
         T4ZSv5+ujKFDYEyux+5BCZUxVOlEvGfzDKv/esV95A9+CZsoDe0c4P28X2JPo5CCjzJ5
         GSaKTgbDW9eaY/aJqPFGWdorMvVB6YXbV5neFggy3QVqSRihkOmX3hlgCcfxGoCSLAQc
         xKyqMP75U6Y6F1POIZqHVUm4CAHCf/QeXhgLIBmNPzscaRoa6Qar+dxMUX9HJqsgZKmg
         0+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVuZx0qrsX66LLVeycCTLGA+IgT43nOeG6Ww1xCEU0k=;
        b=gOlEAxoxX6SH5QJka6lEKkzJ2S5sN9noTVeV4J/aWSWcDznkX9MW7UsmjlMNixvHEr
         HY+LAd6HnBG5OrPU4GIJWQEDhZkpqst7/4DPMTk9Pv3QrWaYYGV8uF9btnQjBhVGqwkC
         nqOpFTz7JjEcnkTM0+ZF/LrlQ74PinMAO3STw6oZjXDPzs01Bem0aq/Jy9ola/xrFwca
         /RcIzdZeF4D/5CE3ev1sLOtWlBXkdAf1Kc3JAzBYAiQdHIReOXhtkiVM4MOidLj5F0Vf
         XTwEBE+gyxQWeh68K3rGkxxv4m45YEhdhSrGJKm7eD6GDDasLTPUJO5RJgxEXbnk6K5j
         zAnQ==
X-Gm-Message-State: AFeK/H3Hubmnrs5w3HjIhste4eCa0fAVUHNI/JIBXLWDjy6GasfZfzPUVyQ+24gYu8JHuw==
X-Received: by 10.98.48.196 with SMTP id w187mr18050043pfw.179.1490496187723;
        Sat, 25 Mar 2017 19:43:07 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id q194sm12794721pfq.43.2017.03.25.19.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:43:07 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:43:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 03/28] files-backend.c: delete dead code in files_ref_iterator_begin()
Date:   Sun, 26 Mar 2017 09:42:16 +0700
Message-Id: <20170326024241.31984-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not in the diff context, but files_downcast() is called before this
check. If "refs" is NULL, we would have segfaulted before reaching the
check here. And we should never see NULL refs in backend code (frontend
should have caught it).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 42c0cc14f3..caeb8188fd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1897,9 +1897,6 @@ static struct ref_iterator *files_ref_iterator_begin(
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 
-	if (!refs)
-		return empty_ref_iterator_begin();
-
 	if (ref_paranoia < 0)
 		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
 	if (ref_paranoia)
-- 
2.11.0.157.gd943d85

