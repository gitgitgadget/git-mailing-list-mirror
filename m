Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779431F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeIAATc (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46202 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIAATb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so12220234wrc.13
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PhnzPCu307aCqvandQXDK0rMyPereNqNkBK7u0x2qE=;
        b=U+yaoQSFObXYTd4i0ASlywDkhOik+jJA8deH5K++of1VJBcTTRNPaJ+lLs0rNeYjFz
         sCQfRb9WPHH4rIAKHlgxHSXGCuRettZ+tIIk+D9qTdVKUxKm83ufFWfQLp1CNpH0hUCY
         pXrpVvu13edeTY9t++RUBHQzaW7dKeEjE4VqZbpNQkFIS446J+PZWBkJ13thdKpcfQxE
         CGOuEZUaxFYNSBs+28ivqmU5iBtyHwdN+n1tVV1IcCB4ulTmYWIRlmA3Usa890DUf4JJ
         66n1KzQGwOup8ep3ZzuI5FPMq293HwgS6+QjD1q7b/sWc8WG9QvZlPX4o1duUPBlt4Lj
         lTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PhnzPCu307aCqvandQXDK0rMyPereNqNkBK7u0x2qE=;
        b=OcGji5lruJ80pqT1wYIpB9/Ml9IEVpr9t01RtRRQmPgbnQi8jfGV7l0aLAuN6YWDlU
         Lqc3ppU+QgtcfQDf3v9ETdlBFONEQ/dlnr7O9wZ7sxVnIqFPUDp/EXCldSJt5zPAEV1l
         dWVHsWdaOYw1ql9WOCmp3ss7z60UJhHu//1LtEsawg13dxd5T6Lch8Of3qABJ3fgtJXy
         r7IQsZFKO21O2IVdTQZvLWtuoDJRX4DZ1BHQ+ztmF70F/FAAsghZTPLwtMaE45zf4tio
         m+8cE9okRSyyPcW7nRL6f5535qrN84CuCl1z1ykrpPqw4Toy8PE3eRj86vDar0wsmOwd
         1gkg==
X-Gm-Message-State: APzg51DvByseJLSlu93VeTBc9KMWca2Mcjpr7jWx/yrb5qc8IJaKPc1g
        O+CHWOGicaDFdEJhc9kZaCym6cPM1hU=
X-Google-Smtp-Source: ANB0VdbT7Fgsv/vUhddwjqyw/2Gl2DYMheZSxIEu/qnZ3F+Wlk4GI9sPix1U1w0cQwzGsBImDIgQug==
X-Received: by 2002:adf:e14f:: with SMTP id f15-v6mr11794254wri.42.1535746226807;
        Fri, 31 Aug 2018 13:10:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/9] push doc: move mention of "tag <tag>" later in the prose
Date:   Fri, 31 Aug 2018 20:10:01 +0000
Message-Id: <20180831201004.12087-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change will be followed-up with a subsequent change where I'll
change both sides of this mention of "tag <tag>" to be something
that's best read without interruption.

To make that change smaller, let's move this mention of "tag <tag>" to
the end of the "<refspec>..." section, it's now somewhere in the
middle.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-push.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 83e499ee97..71c78ac1a4 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -80,8 +80,6 @@ a tag (annotated or lightweight), and then only if it can fast-forward
 the <dst> ref even if it is not allowed by default (e.g., it is not a
 fast-forward.).
 +
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
-+
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
@@ -89,6 +87,8 @@ The special refspec `:` (or `+:` to allow non-fast-forward updates)
 directs Git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.
++
+`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 
 --all::
 	Push all branches (i.e. refs under `refs/heads/`); cannot be
-- 
2.19.0.rc1.350.ge57e33dbd1

