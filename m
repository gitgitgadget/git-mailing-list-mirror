Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA2F1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJTUuq (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39264 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeJTUuq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id p1-v6so33095054ljg.6
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCDwu0Jd3Ls19torW3N88tVwTwWbxE+Pm9onZ4jlDi4=;
        b=Z7mhZZs9Osbah7dtqxchRQ8WjrT7kBtopfWZMBPxwTgscZZsfYKi9YzT6+plnYHhT/
         jAAFnNRghkNWPS4j3DL7oKzwp41wwBoRG8pgar+Ik52qqYb12gjcq6w2fBaAZAkDwG8s
         g7j3hLiai7GO/MRcdJGsUZWPgO8RUvrR+O/xfNuHvrEoJJzOhMzbW84HLTKFVBiNbZ/Q
         IbzjyLetCZPonBy1QrUVLJPBAR7EDqW2lzdbgv0NtVnth4MMpGv7hF5Rp2/pBi77/en2
         djGdO0UZGjRhhhj7OSXl9afecySwguY5bgM7n9JrNzD/ytipHtb1bJAQqMRGK/5pHeuk
         X/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCDwu0Jd3Ls19torW3N88tVwTwWbxE+Pm9onZ4jlDi4=;
        b=HrBsMeD3Rd/yIvbxdGFmJjQudl8ejjI9bTs9mBUTbqFiR95XngBshTTDcztkHVWnKw
         +uADNjrlosN11bk3jFubn9UZoxr1cqfx9QHnL+bFHRmqY1IinUQaugAASTv0+M7GWosY
         QdhAVhglipHR4TiV3X3fw32vaktFplMg0VksYep1ES4sG8AUgUwROxNVHjaMgP2NynU7
         SQjypD1d922HfLjAcJSXzI93NL+D6MtlHGhY86gYS1hHklrKf/DLvKRdkNpJZO7f7o/3
         mqG0+KRTdjSEmFLDfHMaZP1stA9jTIN1Lbm6ABfZNY+oUlcktjhUba/zqtWAK/L1Vbb/
         jGew==
X-Gm-Message-State: ABuFfojOASfHCn6QUZ3BE9I915UyvkoFGPF5XCQFN1xUGkuLsSON2nW9
        xPPnYZKCe4xDh+VVZKSw5SIyIYYI
X-Google-Smtp-Source: ACcGV61QIHAW0X3TJQIg8TZscPZx1gsKQu2av6w0bMvTUTj+y2oHJPFo+bjIfB3UKYiF29VmpXRUGw==
X-Received: by 2002:a2e:1b9c:: with SMTP id c28-v6mr24915360ljf.73.1540039222374;
        Sat, 20 Oct 2018 05:40:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 54/59] config.txt: move uploadpack.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:43 +0200
Message-Id: <20181020123848.2785-55-pclouds@gmail.com>
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
 Documentation/config.txt            | 66 +----------------------------
 Documentation/uploadpack-config.txt | 65 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/uploadpack-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fef310d47d..f2c3c12ded 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -674,71 +674,7 @@ include::transfer-config.txt[]
 
 include::uploadarchive-config.txt[]
 
-uploadpack.hideRefs::
-	This variable is the same as `transfer.hideRefs`, but applies
-	only to `upload-pack` (and so affects only fetches, not pushes).
-	An attempt to fetch a hidden ref by `git fetch` will fail.  See
-	also `uploadpack.allowTipSHA1InWant`.
-
-uploadpack.allowTipSHA1InWant::
-	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
-	to accept a fetch request that asks for an object at the tip
-	of a hidden ref (by default, such a request is rejected).
-	See also `uploadpack.hideRefs`.  Even if this is false, a client
-	may be able to steal objects via the techniques described in the
-	"SECURITY" section of the linkgit:gitnamespaces[7] man page; it's
-	best to keep private data in a separate repository.
-
-uploadpack.allowReachableSHA1InWant::
-	Allow `upload-pack` to accept a fetch request that asks for an
-	object that is reachable from any ref tip. However, note that
-	calculating object reachability is computationally expensive.
-	Defaults to `false`.  Even if this is false, a client may be able
-	to steal objects via the techniques described in the "SECURITY"
-	section of the linkgit:gitnamespaces[7] man page; it's best to
-	keep private data in a separate repository.
-
-uploadpack.allowAnySHA1InWant::
-	Allow `upload-pack` to accept a fetch request that asks for any
-	object at all.
-	Defaults to `false`.
-
-uploadpack.keepAlive::
-	When `upload-pack` has started `pack-objects`, there may be a
-	quiet period while `pack-objects` prepares the pack. Normally
-	it would output progress information, but if `--quiet` was used
-	for the fetch, `pack-objects` will output nothing at all until
-	the pack data begins. Some clients and networks may consider
-	the server to be hung and give up. Setting this option instructs
-	`upload-pack` to send an empty keepalive packet every
-	`uploadpack.keepAlive` seconds. Setting this option to 0
-	disables keepalive packets entirely. The default is 5 seconds.
-
-uploadpack.packObjectsHook::
-	If this option is set, when `upload-pack` would run
-	`git pack-objects` to create a packfile for a client, it will
-	run this shell command instead.  The `pack-objects` command and
-	arguments it _would_ have run (including the `git pack-objects`
-	at the beginning) are appended to the shell command. The stdin
-	and stdout of the hook are treated as if `pack-objects` itself
-	was run. I.e., `upload-pack` will feed input intended for
-	`pack-objects` to the hook, and expects a completed packfile on
-	stdout.
-+
-Note that this configuration variable is ignored if it is seen in the
-repository-level config (this is a safety measure against fetching from
-untrusted repositories).
-
-uploadpack.allowFilter::
-	If this option is set, `upload-pack` will support partial
-	clone and partial fetch object filtering.
-
-uploadpack.allowRefInWant::
-	If this option is set, `upload-pack` will support the `ref-in-want`
-	feature of the protocol version 2 `fetch` command.  This feature
-	is intended for the benefit of load-balanced servers which may
-	not have the same view of what OIDs their refs point to due to
-	replication delay.
+include::uploadpack-config.txt[]
 
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
diff --git a/Documentation/uploadpack-config.txt b/Documentation/uploadpack-config.txt
new file mode 100644
index 0000000000..ed1c835695
--- /dev/null
+++ b/Documentation/uploadpack-config.txt
@@ -0,0 +1,65 @@
+uploadpack.hideRefs::
+	This variable is the same as `transfer.hideRefs`, but applies
+	only to `upload-pack` (and so affects only fetches, not pushes).
+	An attempt to fetch a hidden ref by `git fetch` will fail.  See
+	also `uploadpack.allowTipSHA1InWant`.
+
+uploadpack.allowTipSHA1InWant::
+	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
+	to accept a fetch request that asks for an object at the tip
+	of a hidden ref (by default, such a request is rejected).
+	See also `uploadpack.hideRefs`.  Even if this is false, a client
+	may be able to steal objects via the techniques described in the
+	"SECURITY" section of the linkgit:gitnamespaces[7] man page; it's
+	best to keep private data in a separate repository.
+
+uploadpack.allowReachableSHA1InWant::
+	Allow `upload-pack` to accept a fetch request that asks for an
+	object that is reachable from any ref tip. However, note that
+	calculating object reachability is computationally expensive.
+	Defaults to `false`.  Even if this is false, a client may be able
+	to steal objects via the techniques described in the "SECURITY"
+	section of the linkgit:gitnamespaces[7] man page; it's best to
+	keep private data in a separate repository.
+
+uploadpack.allowAnySHA1InWant::
+	Allow `upload-pack` to accept a fetch request that asks for any
+	object at all.
+	Defaults to `false`.
+
+uploadpack.keepAlive::
+	When `upload-pack` has started `pack-objects`, there may be a
+	quiet period while `pack-objects` prepares the pack. Normally
+	it would output progress information, but if `--quiet` was used
+	for the fetch, `pack-objects` will output nothing at all until
+	the pack data begins. Some clients and networks may consider
+	the server to be hung and give up. Setting this option instructs
+	`upload-pack` to send an empty keepalive packet every
+	`uploadpack.keepAlive` seconds. Setting this option to 0
+	disables keepalive packets entirely. The default is 5 seconds.
+
+uploadpack.packObjectsHook::
+	If this option is set, when `upload-pack` would run
+	`git pack-objects` to create a packfile for a client, it will
+	run this shell command instead.  The `pack-objects` command and
+	arguments it _would_ have run (including the `git pack-objects`
+	at the beginning) are appended to the shell command. The stdin
+	and stdout of the hook are treated as if `pack-objects` itself
+	was run. I.e., `upload-pack` will feed input intended for
+	`pack-objects` to the hook, and expects a completed packfile on
+	stdout.
++
+Note that this configuration variable is ignored if it is seen in the
+repository-level config (this is a safety measure against fetching from
+untrusted repositories).
+
+uploadpack.allowFilter::
+	If this option is set, `upload-pack` will support partial
+	clone and partial fetch object filtering.
+
+uploadpack.allowRefInWant::
+	If this option is set, `upload-pack` will support the `ref-in-want`
+	feature of the protocol version 2 `fetch` command.  This feature
+	is intended for the benefit of load-balanced servers which may
+	not have the same view of what OIDs their refs point to due to
+	replication delay.
-- 
2.19.1.647.g708186aaf9

