Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9671F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbeGWOxJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:53:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41776 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWOxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:53:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so1025368edr.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1g7HCBovMKBTUihwJjU3Rren4dQgrtOQDG/H8SP8SQ=;
        b=tNWwBRy8rZDMjxxExi0bfXlTr34WllKtnYHjuYWBP5+KQoKa0pT/x6oZSOejTd6jKj
         lQfEX2H50tzuDuIdmPo7J9K8YgZ0wspmI9Vr3EQhOll8V8bspIyDdHljKyytwgtXclWP
         kTF/keFrZCAl0UPzkqDmedcjClYtvkcmMLDNMYRhx9ELlZs5pROEmjMy7DgZPfjxfzz6
         6zJQYSWEf1Zab+LSw/RgV8DDJlBc/zCGBtoIi27mWiAMDJA8l7EsJQRU0aUGTSxKzZ2B
         IumlzFK1ux3YNGgJlOCjieovuOHuR5uKRTRV6YMLH0U6kmEKTlyhOO+osWn/y92zxEOt
         gXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1g7HCBovMKBTUihwJjU3Rren4dQgrtOQDG/H8SP8SQ=;
        b=gom0e20Jyi7IrOOHk7r+UILBaHNhOqFnQ9fJuGqt3CA0XBkUzk52FSOf+aaWDsNBAx
         z1aeU5dz9oHTF9mKLswJzg4koGqDkdq/IjibVVpQGiTyhuw5gZWM163hWE+1cLcQj657
         cMhLxCM133zhXKs2L0rwUwljsWvl9CKlYIRMSeExsWAq7IVB3VMDfnOgVRsK3mbf5Nbc
         HRNja8YGxy2+x+Sjg4js8yj4bUNrK8mrsISv1HPfNXrHdrB+BKu9cRyo0OUbzkvn6RcE
         M0b7+i4FX+9PnunhaOkV2NHPFY9u4qTijk8v9NTaELg+tcV2WMiH/yOwB9vj2tmWozMM
         J6Rg==
X-Gm-Message-State: AOUpUlGItLc2wVnITl+X4FtEZv8EAChGY6LONLIBLTABWyGwKjKGFyEf
        LoPrc9DKTmHC69/CsydGtMg=
X-Google-Smtp-Source: AAOMgpdeIiEQS1C2+z36OSSjuvc3VHwop6QA7gx/dd+HvoOz7++dZBmAaqS9jBs7v38SxpaZ3+m5MA==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr14634470edm.106.1532353906813;
        Mon, 23 Jul 2018 06:51:46 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a11-v6sm494277edn.95.2018.07.23.06.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:51:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] coccinelle: put sane filenames into output patches
Date:   Mon, 23 Jul 2018 15:50:59 +0200
Message-Id: <20180723135100.24288-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coccinelle outputs its suggested transformations as patches, whose
header looks something like this:

  --- commit.c
  +++ /tmp/cocci-output-19250-7ae78a-commit.c

Note the lack of 'diff --opts <old> <new>' line, the differing number
of path components on the --- and +++ lines, and the nonsensical
filename on the +++ line.  'patch -p0' can still apply these patches,
as it takes the filename to be modified from the --- line.  Alas, 'git
apply' can't, because it takes the filename from the +++ line, and
then complains about the nonexisting file.

Pass the '--patch .' options to Coccinelle via the SPATCH_FLAGS 'make'
variable, as it seems to make it generate proper context diff patches,
with the header starting with a 'diff ...' line and containing sane
filenames.  The resulting 'contrib/coccinelle/*.cocci.patch' files
then can be applied both with 'git apply' and 'patch' (even without
'-p0').

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 73e2d16926..72ea29df4e 100644
--- a/Makefile
+++ b/Makefile
@@ -564,7 +564,7 @@ SPATCH = spatch
 export TCL_PATH TCLTK_PATH
 
 SPARSE_FLAGS =
-SPATCH_FLAGS = --all-includes
+SPATCH_FLAGS = --all-includes --patch .
 
 
 
-- 
2.18.0.408.g42635c01bc

