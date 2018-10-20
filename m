Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF44B1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJTUtX (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44777 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeJTUtX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so33057915ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFRP4rtb7lqT/qAET2p1hdlIVKin8ebEJAL50hZPLVY=;
        b=s3InJy9wyFSdvC6yLIf5ybvtrT2nDFqYflwTeE8aTyFDzl++a8Me296P3kxzQmkiKO
         k7ArGxfWOp3XMAYuYrCgcMT0aOq1UONKLOV6ZolCOO4HgzQN4myGb3twMUqOGwmhpUFQ
         3tMH/XwhaOF0Bt2ltGwp9sMJ01S1eRizYcE/OZn2P/Ssjzb+qLRI3zP/N9E+Cz19uguz
         h5BBsVEysAZxHrpAJn7T+gyF0aEUk/Y/RIb0bwMZ1sYFsB0nc7QdEcnffnhHJTpQui25
         /mlwBtwUMigsNHWowVHI+D/oGB57h4hjnBCOnMXZwE59O0jII6CAkalwN7+6jSpdhVnl
         Ze2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFRP4rtb7lqT/qAET2p1hdlIVKin8ebEJAL50hZPLVY=;
        b=uD03nK69NsJvWezn36lQH2HLLB8TsABh8ftaMk6rkjpksM/PTtowopNUb+jlfdZcHW
         J4ASqNvz9d8AD3u7L8A9bF51JQIrbkDvEj1gFnW9v1id4fG3Hdf3yEVtM5rsuPCLc6sF
         ptYn2AJPg3lt+Gl8Odtr6sENRPexM4cUQMNg5s2Zu1ViBqDUGvNlTbnTW9pR885aGK9H
         VxHC0+OgYundiXRD8Jr/BarpYRlsqTzAJB462NesR8JS4+vOJImKaRU4CO+ZQqdWf/OG
         TK8ffMUWOYTNlZjwW2AjKvYI1boZ7Mc5mLL9z2kcw19Z3pLeOtlPC6iBSh77nKI2FpYy
         QVOg==
X-Gm-Message-State: AGRZ1gIUyPLvvNhFcVm8bpL+fvb01dMAmDC3lz7I5QRDYAk3XE08KMKW
        hteWsWWKaIdEHEG4VDbaix1B9Xgi
X-Google-Smtp-Source: AJdET5dWZU/HMVjUYKEgn4tOe3kXFB6mW3LNGZ40ihihq7GxVpORDpEco91qY/n7RZTf+IB12g9jEA==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr6323450lji.29.1540039141039;
        Sat, 20 Oct 2018 05:39:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/59] config.txt: move alias.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:53 +0200
Message-Id: <20181020123848.2785-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/alias-config.txt | 18 ++++++++++++++++++
 Documentation/config.txt       | 19 +------------------
 2 files changed, 19 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/alias-config.txt

diff --git a/Documentation/alias-config.txt b/Documentation/alias-config.txt
new file mode 100644
index 0000000000..0b14178314
--- /dev/null
+++ b/Documentation/alias-config.txt
@@ -0,0 +1,18 @@
+alias.*::
+	Command aliases for the linkgit:git[1] command wrapper - e.g.
+	after defining "alias.last = cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD". To avoid
+	confusion and troubles with script usage, aliases that
+	hide existing Git commands are ignored. Arguments are split by
+	spaces, the usual shell quoting and escaping is supported.
+	A quote pair or a backslash can be used to quote them.
++
+If the alias expansion is prefixed with an exclamation point,
+it will be treated as a shell command.  For example, defining
+"alias.new = !gitk --all --not ORIG_HEAD", the invocation
+"git new" is equivalent to running the shell command
+"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+executed from the top-level directory of a repository, which may
+not necessarily be the current directory.
+`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
+from the original current directory. See linkgit:git-rev-parse[1].
diff --git a/Documentation/config.txt b/Documentation/config.txt
index a52e0b3592..5b46310dd4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -293,24 +293,7 @@ include::core-config.txt[]
 
 include::add-config.txt[]
 
-alias.*::
-	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining "alias.last = cat-file commit HEAD", the invocation
-	"git last" is equivalent to "git cat-file commit HEAD". To avoid
-	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored. Arguments are split by
-	spaces, the usual shell quoting and escaping is supported.
-	A quote pair or a backslash can be used to quote them.
-+
-If the alias expansion is prefixed with an exclamation point,
-it will be treated as a shell command.  For example, defining
-"alias.new = !gitk --all --not ORIG_HEAD", the invocation
-"git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
-executed from the top-level directory of a repository, which may
-not necessarily be the current directory.
-`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
-from the original current directory. See linkgit:git-rev-parse[1].
+include::alias-config.txt[]
 
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
-- 
2.19.1.647.g708186aaf9

