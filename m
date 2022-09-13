Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0139EC6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIMT0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIMT0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6911726A9
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id cc5so12531188wrb.6
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=nux1mDXV6UAP3b2Yui30zaM88WL6NE924cP9WN28Wz4=;
        b=KVNa+ziCJpWIbhXYmqBa0yFAYr/PMC2J7FubRNXq2VpZhkZ4gyRudZkn2iUZBANbIZ
         eaKPX/XhsUVPZCJG2Kz14WGXa1CFJiAHAZqX77ZnBoLAUQmASKRak0ZrUPxjlqkPsp+x
         4fJ2U6Waa4A/TDAn6MXueCUcOnQfLJuKBdCA5HExoangs3xYRmRkzS8wBGrm1lFNKcLW
         RHSwbEzmg3/GXEzSb3twg/wfYAYCLo8FofJQIFeiVIatm5HUJF8fREHx4UYOPu5mpl+3
         cB9cvT9KfqPJFToqBZS6F/OmPwfVZjtHjZmqqhJ1xiy0eokGcfoB7dkDZ3TGgKtQ5S15
         eaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nux1mDXV6UAP3b2Yui30zaM88WL6NE924cP9WN28Wz4=;
        b=Ya1sB11+5dPyccXzB4HgbOUQ2+0UOQpt6VI8IRGsYIqiSva2IfLjHL0rYD2xlPEwRY
         5ETHE/HhBIw8JFDaB1yJQD49vKgOhUapRh+2kT1W/6USdl36QIseUE1euexIb5nKbmb6
         M2wf4jHme4HSnU60/q7VPAHWYwA+6SEWpBGBcRKPtc11EI0DqXLiXviDl+iMKyOmRpvx
         Ri/BaCC7W/Kn/NLbPbHOBw8cI7kAl/rqPNShNRQBMZNzui4eQedvdob1IKLTyhyVVZCF
         uKN28Q2qPLaTePEA48e+XZzc83ZZhBmPSmvHb5s/peuSo5B3bxwVb2MUFK0Qx6X0BdMN
         pbFQ==
X-Gm-Message-State: ACgBeo1ouNlvBNeGqjjfPzP/FNj5TD9bwEbFBOygiREEMJJh0Fau+xha
        rKoSWTa43sGVl58JBAtsTt+QwKn8WtM=
X-Google-Smtp-Source: AA6agR6A76rThjpUken2JGLk57sc1KXbhnvzTuSMGZJSnPWAkjVrb0ZWPEkRuemGEBl5cYNomrVWcg==
X-Received: by 2002:a5d:58da:0:b0:22a:c3cb:e3cb with SMTP id o26-20020a5d58da000000b0022ac3cbe3cbmr1563941wrf.34.1663097158966;
        Tue, 13 Sep 2022 12:25:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a4f08495b7sm15329742wmq.34.2022.09.13.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:25:58 -0700 (PDT)
Message-Id: <6426f9c3954866b3fd9259d1a58d2c41dc42e17f.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:49 +0000
Subject: [PATCH 1/8] wincred: ignore unknown lines (do not die)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

It is the expectation that credential helpers be liberal in what they
accept and conservative in what they return, to allow for future growth
and evolution of the protocol/interaction.

All of the other helpers (store, cache, osxkeychain, libsecret,
gnome-keyring) except `netrc` currently ignore any credential lines
that are not recognised, whereas the Windows helper (wincred) instead
dies.

Fix the discrepancy and ignore unknown lines in the wincred helper.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/credential/wincred/git-credential-wincred.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 5091048f9c6..ead6e267c78 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -278,8 +278,11 @@ static void read_credential(void)
 			wusername = utf8_to_utf16_dup(v);
 		} else if (!strcmp(buf, "password"))
 			password = utf8_to_utf16_dup(v);
-		else
-			die("unrecognized input");
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
 	}
 }
 
-- 
gitgitgadget

