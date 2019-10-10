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
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A0E1F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 19:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfJJThJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 15:37:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36955 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJJThI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 15:37:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so4301594pgi.4
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=onTshEyorgjRb5JB1xsoeoeai/hucWdwMlxWd0Kzi4s=;
        b=gT57ScEcyJPTB9DVtsWQv4N0sb+JM5uwtf23LmLoOKEbXiXAJkqOD+EeQ9hIBaczeG
         Lc+tszjYu4BgR35K5cyjq0E4zJFqkBNumaR2ac8Qm/4Dy6Rrn4BZkvjGWaSDqhesxv8S
         lFl7hJPmnZEpO5NOuyBjegvpt1ECRUjnRwZgXTsON1ca9Q+AcEit7Xs1THQkTUutCBAi
         mM7GWnl2vizf9z7KIBCyet3XaqL1YArJV0BEJImPTZLL5Xc3TymBNb2wPGwUvONjbG7T
         6xXfjirNDO20hWBiIOPp5sqKBBnahMTcd6HJITJw6qt42HnqkWIvGSk33Lzg2GHUmfMA
         oHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=onTshEyorgjRb5JB1xsoeoeai/hucWdwMlxWd0Kzi4s=;
        b=iETgvbdSAI1QF/LoiXljqD0J9ypAfPXjYKrf5T6i4nFkJgQv/PHoBEX4GdMSVURZv2
         EyiNapi+mYPib9MdjPoP/wL0jYPFA9+NAM+ZtERf4ZGSKp6N2CEMASvHYb26Ys6aqF/K
         v57GrxBUM08AETaWvR369WHB4PS2Hc5va5XwkF4ACFfZeT6aFEUcfKsJ/QNwR7gOSoDz
         xeJZBuX8a00cD00fNbtwzBriUnhRYXBbO1kAhRyTfLCkk6b4QGBSFGmU5uHEmnRtUr9+
         Pzazrh+G4k8iCXr8pFdBVcECid3wOSd1G3QI6hShPocySQKka8I+mSxZbxl1KNU8+vJl
         V4Hw==
X-Gm-Message-State: APjAAAVT8APU0DN32fLTVrNfkRvFr5kAr+jzRPaTGbXyuHI9xX4YxShb
        fRYpHyzpyAiv863MkpSBQ0diXDBz
X-Google-Smtp-Source: APXvYqzMC0xzZjUM31x6pCoeo8A57nV96Q7ad4VzRpo2YPsY8ZoU2upbrdO+87Cq0aFcNwS1FWbOvw==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr469575pgt.245.1570736227692;
        Thu, 10 Oct 2019 12:37:07 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id e127sm7091388pfe.37.2019.10.10.12.37.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 12:37:07 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:37:04 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] pthread.h: manually align parameter lists
Message-ID: <b3d6dfe44a76c4f3bf00eb901c1844b12300c66e.1570736137.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous patches, extern was mechanically removed from function
declarations without care to formatting, causing parameter lists to be
misaligned. Manually format changed sections such that the parameter
lists are realigned.

Viewing this patch with 'git diff -w' should produce no output.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
I missed a step in 'dl/compat-cleanup'. This patch can be applied on the
tip of that branch.

 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index f1cfe73de9..737983d00b 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -51,7 +51,7 @@ typedef struct {
 } pthread_t;
 
 int pthread_create(pthread_t *thread, const void *unused,
-			  void *(*start_routine)(void*), void *arg);
+		   void *(*start_routine)(void*), void *arg);
 
 /*
  * To avoid the need of copying a struct, we use small macro wrapper to pass
-- 
2.23.0.746.g72fc0fc0b9

