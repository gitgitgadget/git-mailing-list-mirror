Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D30211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 02:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725735AbeLBCn2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 21:43:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33863 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeLBCn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 21:43:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so4708381plz.1
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 18:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxAFekF7YyUFFBLb8DrexlZYK4jOjXDRYcX5sG52TZc=;
        b=cJzaUG0NQpLAKsSxFX672T4fXMQNykynDBoXOH707IduJxssU6RrIjCBZrbzV4qbyI
         FMBlpdWx9G7lDtkBNj7J5AXbDP+LtSJ3ztcnOrPeXUiDXAYqhJ7i8EDGPAkYo0kwfZGd
         yJX75Qn7Tk5BgX+JCTicp0nOJUajinHcndlrIkUCut36zpCHVphlu53VF9ZH3vGAJSvx
         Qn0CaXEGMyGuzVT2wvIp18KtDkcwDJNCPbxgn44NWFVaT6gtVTdClF6QMxmfGQh+Oe+Z
         8aRRFtYufGg70ZcNQwCPxRqFVwqahZBhKP7jOl/QKyxCqhRGdHwq+e/T0ICi6bTGDjIt
         wC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxAFekF7YyUFFBLb8DrexlZYK4jOjXDRYcX5sG52TZc=;
        b=leKCoMOl1R7BR5PdchF/qnYDxUydef2yDVDrSZ5f0HJ0xOchRGZjijGIIcKCVNBPoO
         bbVF290CfhkEhn3CEZlgm2VXNKPVDcAtiCTNAlmwTP8PaKVdfXpSxjR/MnS7jkSGP5bt
         feBzP4XPxVNAhwN8alMwLp2bbGW84JkQNeLGg0pQw40vrAnEAxZeUWAXwbGTCqK4mZzs
         U51bmyodHFFPGCqLwNvm5Wma6q8Ls7DKp8NKFXELZagomY1EbyV8zKY32ztmKDouso/y
         p5MARttWiYYO9HtODm1mxznoZABAt5h/YvaFFADHkL8y75+eiU8SOH9U879yAoecV3pD
         9S8g==
X-Gm-Message-State: AA+aEWaW/j8MPou7kdUnKFdW8jEcKTfvklj/xywtQL8jvLS1VAl1kB6a
        ALCD94eLIjlh1yPIpx18at8ibmRx
X-Google-Smtp-Source: AFSGD/W70AZncnk6z08LcgDgjqpcMvhSkovAf/ocGXiKrWVzIrtC9nU4+4U3lrHgc37gJhyOx+Z7hw==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr3151850plh.99.1543718604411;
        Sat, 01 Dec 2018 18:43:24 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h124sm13462792pfg.143.2018.12.01.18.43.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 18:43:24 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] config.mak.uname: OpenBSD uses BSD semantics with fread for directories
Date:   Sat,  1 Dec 2018 18:43:20 -0800
Message-Id: <20181202024320.65160-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this "fixes" test 23 (proper error on directory "files") from t1308

MirBSD likely also affected but this was only tested with OpenBSD and
therefore this specific change only affects that platform

the optional 'configure' sets this automatically (tested with 6.1 to 6.4)
but considering this is a legacy feature it is likely that it affected
all old versions and is probably what most users had been using as a
workaround

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..378ca0a582 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -233,6 +233,7 @@ ifeq ($(uname_S),OpenBSD)
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
-- 
2.20.0.rc2

