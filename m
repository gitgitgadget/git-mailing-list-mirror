Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D850AC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjAHOqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHOqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 09:46:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD096FAF1
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 06:46:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m3so4504740wmq.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 06:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InnoFkWSMns9yjFQb/dU5ODsmZuZJDlZkFt/Tn/b/7Y=;
        b=nyO3dUPJ2myjg637uk6odtzIlXV9Glgmyfo3JR45g4RHF2BVDy6U80XEw1sDAwUzvy
         6YzHS5zApThYYE701Gp1ldlyr2tY3+W59cbi2qOazcwaJvC0KGVrr2x2s3/9WrLJPZZz
         hDdsgTnxHyP6qVAeYKE2ueBoJDqsP8NYKGGhs3IEbWiXkq9Xbt45bu1K/jZfjUC+m++l
         X7ZnQfdYAYWYlXcZpHJN02aRKP9N7W9X6vDIntgwXiXFzAaOHNzVXB386ZZfYf7YYLXJ
         VguUWdW9O5M0g2QVmUT+R2bHGJcb3vvkvRhUDAboNzKzgpm2ApTHNfaKgqxR44tk2A3y
         JazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InnoFkWSMns9yjFQb/dU5ODsmZuZJDlZkFt/Tn/b/7Y=;
        b=DC1apJY81OKtGtzmOCUNRdpKW0LOzZkh4+wIF4STY0Dk5dq/xItkJOeITsj3sbeo/m
         nVuxjHfqr3/vLL5LH5dMuLP1OKIPJqkk0RsVOq6Il/g9uJ4E+YLzGIp79j1ACDwHqsgd
         etWON7d5bSAZWwRLnXnmuXB9F598hWC9F2IH1UyygAkd8pr4YJuLS8IOnsnNTN2LrvkP
         wAGCJ7Ce63Kn3FUKtq6LI2PTqOTIAX6f2WSjBiucmh1pSRx9STGSi9OGvLNw9PZKSzpZ
         1GfwAeEBPPs1sqNF9QfbKv8TH1ZNHprLtZ610F79jlFOs2Il6Yzytr5KcdYvuDYAMsp8
         uZ8Q==
X-Gm-Message-State: AFqh2ko2y2irSJFjDWblcCy8BVvflTuXZ92PsHZv18mmLC7a8mTJVfwG
        BYHM5Nku1WqHuHI5M55zp1aCpqDgnfo=
X-Google-Smtp-Source: AMrXdXs3mA31oLOvdMVFkO0WuAqKnLye+WwiBGX7sh7NGEXo2hVcXlPCTBbN8qQGN2lcXbHPcOyirA==
X-Received: by 2002:a7b:c8ca:0:b0:3cf:728e:c224 with SMTP id f10-20020a7bc8ca000000b003cf728ec224mr44435818wml.6.1673189174128;
        Sun, 08 Jan 2023 06:46:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c35c500b003d98f92692fsm9105125wmq.17.2023.01.08.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 06:46:13 -0800 (PST)
Message-Id: <pull.1413.v2.git.git.1673189172832.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.git.git.1671740551466.gitgitgadget@gmail.com>
References: <pull.1413.git.git.1671740551466.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 14:46:12 +0000
Subject: [PATCH v2] mingw: check that the file attributes are valid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

If the attributes are invalid, return -1
to indicate an error.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: check that the file attributes are valid

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1413%2FAtariDreams%2Fset-hidden-flag-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1413/AtariDreams/set-hidden-flag-v2
Pull-Request: https://github.com/git/git/pull/1413

Range-diff vs v1:

 1:  d2992745f3f ! 1:  f1cc7d9a98b mingw: check that the file attributes are valid
     @@ Metadata
       ## Commit message ##
          mingw: check that the file attributes are valid
      
     -    If the attributes are invalid, return an error.
     +    If the attributes are invalid, return -1
     +    to indicate an error.
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      


 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..01bafa01e92 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -435,6 +435,11 @@ static inline int needs_hiding(const char *path)
 static int set_hidden_flag(const wchar_t *path, int set)
 {
 	DWORD original = GetFileAttributesW(path), modified;
+	if (original == INVALID_FILE_ATTRIBUTES) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+
 	if (set)
 		modified = original | FILE_ATTRIBUTE_HIDDEN;
 	else

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
