Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DC41F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeJ0PFO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47068 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ0PFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3-v6so3089788lji.13
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFKMWA5mZt0wpeWHIU10sq8oBMrLWaqJnkJsbnGzeAc=;
        b=ZE/Fvce82mORrg5Mcj0vgJt+duuQ3xFbJzPS3HvozRWQiOH/f8k0YIVX14AtHptjp0
         LbkuFycDTOMWncpWPnFhKrPTovGq1qW9zxpojBUX6raySzR03wfX0Pr3OErhS6nMgGar
         btvN+8Qj0wuZg5M0ZjPsfKzECy0/N3eCAzYQnRr9VhAzvqpRgMLOCIw7RXpyVY++7e5I
         g2AQU7kNuV9GdVVX855uJT6I1WeECK3tp4rIToU1FqkUKu3G16eoLWlK3N6lqAcLXXB4
         ZupZV1fKR9Y6yO38KReNHoPgmT4X+duB4za8anXSMp+XmqpMSHyS/gKYiQ0N2GNIzlLU
         CXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFKMWA5mZt0wpeWHIU10sq8oBMrLWaqJnkJsbnGzeAc=;
        b=GDRTgNVjBnFB57+PCZVZ5R4lVx6KD4Ob0E6mjOKeiTaP7Vz83Bikh6JiOe79hTkHmM
         SBhENt3E7oA1cUdYdlFc7IIAFDTU8szGFeg+ARy/wwLIe3hSmG15XlBDBa/E0tgj2g5Z
         IVDVMj5GJj1jLFT2JKCrEP8rgzERhc2ca1An7S7TPO4ltZ4/C/oSj4VVPvyxeuawsJ0E
         60tRcYXCf4cTLbKZ5xnQuN7YcpA2w16xm/0RPCGf+NVkK+funtBGqYRfhavY9xl2cTyF
         5tHxqWRcAE8I0lkOQDs+VpiAPah/TVS2bTkgjmuJwTqNGHGy7fp4JPuOQimAsPdaBRM6
         Bggw==
X-Gm-Message-State: AGRZ1gKSPuDdRCaG03RSgKU39tXKxzBE+PwsV43z6/ZIYoIymrXqnySs
        8/1ksu1bd64hKr+k4tSAUh5DkzU6
X-Google-Smtp-Source: AJdET5cjdc+y2yTlDAoCry+NsdqyNiNjLdAznhiQXLMu2pmixol0zw1Mf2SB/nZjKMyUE0hQxgDegA==
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr4088418ljd.148.1540621516678;
        Fri, 26 Oct 2018 23:25:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 70/78] config.txt: move transfer.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:43 +0200
Message-Id: <20181027062351.30446-71-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt          | 72 +------------------------------
 Documentation/config/transfer.txt | 71 ++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/config/transfer.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1db9c58e8d..07100e236e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -421,77 +421,7 @@ include::config/submodule.txt[]
 
 include::config/tag.txt[]
 
-transfer.fsckObjects::
-	When `fetch.fsckObjects` or `receive.fsckObjects` are
-	not set, the value of this variable is used instead.
-	Defaults to false.
-+
-When set, the fetch or receive will abort in the case of a malformed
-object or a link to a nonexistent object. In addition, various other
-issues are checked for, including legacy issues (see `fsck.<msg-id>`),
-and potential security issues like the existence of a `.GIT` directory
-or a malicious `.gitmodules` file (see the release notes for v2.2.1
-and v2.17.1 for details). Other sanity and security checks may be
-added in future releases.
-+
-On the receiving side, failing fsckObjects will make those objects
-unreachable, see "QUARANTINE ENVIRONMENT" in
-linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
-instead be left unreferenced in the repository.
-+
-Due to the non-quarantine nature of the `fetch.fsckObjects`
-implementation it can not be relied upon to leave the object store
-clean like `receive.fsckObjects` can.
-+
-As objects are unpacked they're written to the object store, so there
-can be cases where malicious objects get introduced even though the
-"fetch" failed, only to have a subsequent "fetch" succeed because only
-new incoming objects are checked, not those that have already been
-written to the object store. That difference in behavior should not be
-relied upon. In the future, such objects may be quarantined for
-"fetch" as well.
-+
-For now, the paranoid need to find some way to emulate the quarantine
-environment if they'd like the same protection as "push". E.g. in the
-case of an internal mirror do the mirroring in two steps, one to fetch
-the untrusted objects, and then do a second "push" (which will use the
-quarantine) to another internal repo, and have internal clients
-consume this pushed-to repository, or embargo internal fetches and
-only allow them once a full "fsck" has run (and no new fetches have
-happened in the meantime).
-
-transfer.hideRefs::
-	String(s) `receive-pack` and `upload-pack` use to decide which
-	refs to omit from their initial advertisements.  Use more than
-	one definition to specify multiple prefix strings. A ref that is
-	under the hierarchies listed in the value of this variable is
-	excluded, and is hidden when responding to `git push` or `git
-	fetch`.  See `receive.hideRefs` and `uploadpack.hideRefs` for
-	program-specific versions of this config.
-+
-You may also include a `!` in front of the ref name to negate the entry,
-explicitly exposing it, even if an earlier entry marked it as hidden.
-If you have multiple hideRefs values, later entries override earlier ones
-(and entries in more-specific config files override less-specific ones).
-+
-If a namespace is in use, the namespace prefix is stripped from each
-reference before it is matched against `transfer.hiderefs` patterns.
-For example, if `refs/heads/master` is specified in `transfer.hideRefs` and
-the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master`
-is omitted from the advertisements but `refs/heads/master` and
-`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
-"have" lines. In order to match refs before stripping, add a `^` in front of
-the ref name. If you combine `!` and `^`, `!` must be specified first.
-+
-Even if you hide refs, a client may still be able to steal the target
-objects via the techniques described in the "SECURITY" section of the
-linkgit:gitnamespaces[7] man page; it's best to keep private data in a
-separate repository.
-
-transfer.unpackLimit::
-	When `fetch.unpackLimit` or `receive.unpackLimit` are
-	not set, the value of this variable is used instead.
-	The default value is 100.
+include::config/transfer.txt[]
 
 uploadarchive.allowUnreachable::
 	If true, allow clients to use `git archive --remote` to request
diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
new file mode 100644
index 0000000000..4a5dfe2fc1
--- /dev/null
+++ b/Documentation/config/transfer.txt
@@ -0,0 +1,71 @@
+transfer.fsckObjects::
+	When `fetch.fsckObjects` or `receive.fsckObjects` are
+	not set, the value of this variable is used instead.
+	Defaults to false.
++
+When set, the fetch or receive will abort in the case of a malformed
+object or a link to a nonexistent object. In addition, various other
+issues are checked for, including legacy issues (see `fsck.<msg-id>`),
+and potential security issues like the existence of a `.GIT` directory
+or a malicious `.gitmodules` file (see the release notes for v2.2.1
+and v2.17.1 for details). Other sanity and security checks may be
+added in future releases.
++
+On the receiving side, failing fsckObjects will make those objects
+unreachable, see "QUARANTINE ENVIRONMENT" in
+linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
+instead be left unreferenced in the repository.
++
+Due to the non-quarantine nature of the `fetch.fsckObjects`
+implementation it can not be relied upon to leave the object store
+clean like `receive.fsckObjects` can.
++
+As objects are unpacked they're written to the object store, so there
+can be cases where malicious objects get introduced even though the
+"fetch" failed, only to have a subsequent "fetch" succeed because only
+new incoming objects are checked, not those that have already been
+written to the object store. That difference in behavior should not be
+relied upon. In the future, such objects may be quarantined for
+"fetch" as well.
++
+For now, the paranoid need to find some way to emulate the quarantine
+environment if they'd like the same protection as "push". E.g. in the
+case of an internal mirror do the mirroring in two steps, one to fetch
+the untrusted objects, and then do a second "push" (which will use the
+quarantine) to another internal repo, and have internal clients
+consume this pushed-to repository, or embargo internal fetches and
+only allow them once a full "fsck" has run (and no new fetches have
+happened in the meantime).
+
+transfer.hideRefs::
+	String(s) `receive-pack` and `upload-pack` use to decide which
+	refs to omit from their initial advertisements.  Use more than
+	one definition to specify multiple prefix strings. A ref that is
+	under the hierarchies listed in the value of this variable is
+	excluded, and is hidden when responding to `git push` or `git
+	fetch`.  See `receive.hideRefs` and `uploadpack.hideRefs` for
+	program-specific versions of this config.
++
+You may also include a `!` in front of the ref name to negate the entry,
+explicitly exposing it, even if an earlier entry marked it as hidden.
+If you have multiple hideRefs values, later entries override earlier ones
+(and entries in more-specific config files override less-specific ones).
++
+If a namespace is in use, the namespace prefix is stripped from each
+reference before it is matched against `transfer.hiderefs` patterns.
+For example, if `refs/heads/master` is specified in `transfer.hideRefs` and
+the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master`
+is omitted from the advertisements but `refs/heads/master` and
+`refs/namespaces/bar/refs/heads/master` are still advertised as so-called
+"have" lines. In order to match refs before stripping, add a `^` in front of
+the ref name. If you combine `!` and `^`, `!` must be specified first.
++
+Even if you hide refs, a client may still be able to steal the target
+objects via the techniques described in the "SECURITY" section of the
+linkgit:gitnamespaces[7] man page; it's best to keep private data in a
+separate repository.
+
+transfer.unpackLimit::
+	When `fetch.unpackLimit` or `receive.unpackLimit` are
+	not set, the value of this variable is used instead.
+	The default value is 100.
-- 
2.19.1.647.g708186aaf9

