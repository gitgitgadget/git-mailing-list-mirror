Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C998EC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF33761A3D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 11:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbhKRLZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 06:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbhKRLZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 06:25:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B67C079794
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:16:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p18so4926323wmq.5
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8c6w/5FQqrraaIDUHGAySYZhA829PZ6OkSt+IgB9jP0=;
        b=kqGIgaVCRo/YCP3/mCEC/t4RDbA/fYvoyC6H/RcbEgVlMexTmK5tYNKVQ6fx2kOmwf
         +/Z01NcnjYgnZWJzRZ55VVmlJfYLP7JDmQRjcv03dfXHpDsujzKAVsipDS6qNW489Ns9
         lOPmd0O+t21Vfc3VgrTQQROhNy/36TVZa6AkmodDIpGPVp2yDsiWWJrYumnaw1ZlFXko
         HNpUWS6yv3WypSFPD+xkK+Oipy0YvIDzOiJhctnhf9NT3i7cUNfNlE3g/cpQzAs+9MJE
         upVRwFdcDoYKVAdYH8YTIji0oeev0/FkxE1Z3uYKfqeTJDxqA3AHu3is4eaNecG+K7v+
         aQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8c6w/5FQqrraaIDUHGAySYZhA829PZ6OkSt+IgB9jP0=;
        b=OfYjsZg2GwxN5JV8Yi4aevnbtV0Vq9M4FFFKzPGX1oNZfmOu6Q0lqeFuoy9cByAIV0
         RjvMgdO3bHzJysLypcT+cGp60IWdg02GgnziWzF4cSzrzMPCpS68ON9LS9ehjU0/byJU
         w7pOqucyjxJ5vs83wNYWMHpF0VL41HpQmgtQvvN2dyIFrEI4kz0EEIBFERpwlMwQZt4H
         u/BCOTysXZ6EoLQ/SETu2wgLCmATNoS9e37tJXBHaZIEAzdN2SQ18ogiMzKzc+I4hcMp
         Ar+vfbHANMIsAxNkmmB25cJIY0QZdw6ccTrBGfojIHajvjDa1giQ4AaKHauZPSTAHJpA
         e5vA==
X-Gm-Message-State: AOAM531A+QVBkWih8wo/SfUt8d3IOn+m74lxFfDiiOHcn32kEJhRlakq
        cM7Ti78svEnMGM8i5C3YLy83ibK6360=
X-Google-Smtp-Source: ABdhPJyDcFfTJCIPwOpSTWZGoEEFvY/O2Ma2cjyV/oPYdSgFsnM5UDT967pmO6fe46JL4Rd/AmLYWA==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr8777759wmg.71.1637234204774;
        Thu, 18 Nov 2021 03:16:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm2650593wrt.64.2021.11.18.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:16:44 -0800 (PST)
Message-Id: <pull.1141.git.git.1637234203401.gitgitgadget@gmail.com>
From:   "TimTIM via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 11:16:43 +0000
Subject: [PATCH] http-protocol.txt: add missing flush to example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     TimTIM <t2@live.hk>, TimTim Wong <t2@live.hk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: TimTim Wong <t2@live.hk>

Signed-off-by: Timothy Wong <i@timtim.hk>
---
    Fix example in documentation
    
    wants must be flushed with 0000 before haves

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1141%2Fwegylexy%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1141/wegylexy/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1141

 Documentation/technical/http-protocol.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index cc5126cfeda..facb315a993 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -314,8 +314,9 @@ Clients MUST first perform ref discovery with
    C: Content-Type: application/x-git-upload-pack-request
    C:
    C: 0032want 0a53e9ddeaddad63ad106860237bbf53411d11a7\n
-   C: 0032have 441b40d833fdfa93eb2908e52742248faf0ee993\n
    C: 0000
+   C: 0032have 441b40d833fdfa93eb2908e52742248faf0ee993\n
+   C: done
 
    S: 200 OK
    S: Content-Type: application/x-git-upload-pack-result
@@ -337,9 +338,9 @@ server advertises capability `allow-tip-sha1-in-want` or
 `allow-reachable-sha1-in-want`.
 
   compute_request   =  want_list
+		       "0000"
 		       have_list
-		       request_end
-  request_end       =  "0000" / "done"
+		       "done"
 
   want_list         =  PKT-LINE(want SP cap_list LF)
 		       *(want_pkt)

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
