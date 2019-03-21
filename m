Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6234020248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfCUNRZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:17:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:17:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so4140744pgg.13
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zj4bMNkMonc0IZGMhvpFbFXKW36q0Bn1KEm6XkaUqsY=;
        b=Ni6EAYIp+Hs9bWdc4JtuiHzWQmvxaisTI0KpFxUxrILl7tgXc75qv8BZLES9EtY6S/
         ph88q5a6/bEeCNmXXxu5A/NedriHQ0gBmL3fObk9oULNzVtNmxRDfdoCVviWwehi6WBJ
         /fQt+wUrgkx5OHQmT4OnKidNGUNHuoLpffy4CB7/2quGBWjYx+MdKt6UMMelkuRrp7Q5
         YfJSX16BWkvFrFSttiFc+3RJPkTc6iuM/9rqiGv8OtFpK+eWOJ6HCHxP9VwIk/H6h/Lm
         dfEpqFjza2WbRcJwk2djbv2S0u5SQtm3uPbfur9ocSwvpnaMvU+sgHFyt2oCw1r4xRq8
         yQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zj4bMNkMonc0IZGMhvpFbFXKW36q0Bn1KEm6XkaUqsY=;
        b=JMQGS1OKmRKdVZIHzqCjc5ljqyzZl/eXPfr7UhQexmATdYvfrLHn2hXRLQDibklOGL
         JjDt+uli29UQ5+D8Dkmvl3WIoSAf7ik+UbfGy0bNUMRaRgQeWWyNTKC9P/jl2PSr9ULK
         hEg3TA7VDCm/Y6ptVvhctHGlNJhQiRLwN2Am9yreu0Iq2qADYRXkFPbKIhcfLFUZgtY7
         FZ4l7QBXW878jVF3KiNQh5DZo/IvxkqtVTkc7TXdYR1tkC0HaWQJMayBGHy5lBqXR55J
         jsVATLRa2zt9rGfeGIquc0sy02BaMyobJ8woyO0WLMu6QbyFevxZwxj42VUeqUVqMJTG
         hKWQ==
X-Gm-Message-State: APjAAAV8oOaBriEw7RUW9u+5Ne81GWgRX691+4JN0Fy0lzulZabudzAj
        yJqlkWZ57MUsWqoTTPREBbg=
X-Google-Smtp-Source: APXvYqyetPQnjSkeaQaD74jTN0LvbNNEEOObuZ3ieN6XWs+iH0bAQbO9TsmSqvBQ6BrGhGILixYpfw==
X-Received: by 2002:a65:5189:: with SMTP id h9mr3234783pgq.304.1553174244342;
        Thu, 21 Mar 2019 06:17:24 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id v1sm7488928pff.9.2019.03.21.06.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 02/26] git-checkout.txt: fix one syntax line
Date:   Thu, 21 Mar 2019 20:16:31 +0700
Message-Id: <20190321131655.15249-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<branch> can be omitted in this syntax, and it's actually documented a
few paragraphs down:

  You could omit <branch>, in which case the command degenerates to
  "check out the current branch", which is a glorified no-op with
  rather expensive side-effects to show only the tracking information,
  if exists, for the current branch.
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 99c8c0dc0f..28817cfa41 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,7 +23,7 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' <branch>::
+'git checkout' [<branch>]::
 	To prepare for working on <branch>, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	HEAD at the branch. Local modifications to the files in the
-- 
2.21.0.548.gd3c7d92dc2

