Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7281F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeJ0PFP (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeJ0PFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id a28-v6so83158ljd.6
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kPXhBMtV4wpt/F5q2FXzewzVtypLCRSUOO+QlK9yRA=;
        b=NnABP61bf/xwDZHCiB9U5y5AqNn0P9w6Lj7S2n2xHCN04zcJioUjO/pZ0fOMM4ztIU
         4XgFqVoKyr/Sp21dTVZ5bsYw/g3fjniCil/F0s8mJtRlEav86uKvOAnqZjNwZGQTpAcb
         yGS1CX8F3jybmDs+X3FqQuZZYoHQkgjAGgR7tHgTw1hVPMb0wZFHy4qO67EPGIzJc5Mh
         2aqQMFtIG3TbChsjF9W2/WZg+2sdJOVmXRTa1m+hzf90SWtIrHmDu0vfGYYqUHmZbFJo
         e+ms3iVsffeeuZqGRJGg8ybjIw8f4uGoCp1eFxd/W2qrCGo3RCJ1YVe/g8YXpnVbcM44
         +awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kPXhBMtV4wpt/F5q2FXzewzVtypLCRSUOO+QlK9yRA=;
        b=aA+ZcVeMXWUcJX2h5se5KxuDF5gNf13B/XR6L2VMvLsJPmTSPMGVcElMs7ZKQaOHXH
         KVrRAV+lOxbBbZP95q4zLklBPfe616teYEaENxZoHNFMov8cb93auenPw0iA8ZUmwtJe
         g99AoJdWTaITZoFCe8ZD5lU4g+PltAt6L8cfXmKpPMPgyTmSj0G6IDd5ZvWx6oZ+7waJ
         wfyJBTOpEClYkkhMWEyXrk2oFYoVEmXNt2Pblqm9t19bkcWgs6IDMDjQIWvfwYJn3Kzi
         25gIzfjCByy7Pl6oj/X9hlcZJmoA64sWfe3Odd4OxM/T2oDB7UL7IwGsSPUd/Ay0LtKw
         tRNA==
X-Gm-Message-State: AGRZ1gJU5qAhKLa1VBh9udPsqj8Q+2RwgcdNAjydhgEcxK4EKBA7UUv3
        HW0v694vKXPIlPL3aJCfjMDC5oyy
X-Google-Smtp-Source: AJdET5c7b9gDBhSK4l8M1Mx5MEfZ71Q4UJkXztNEGSeF0PPHrqs9XDMSDH7k+5U2XA+s3+kwaK3PEg==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr4035093ljc.37.1540621518805;
        Fri, 26 Oct 2018 23:25:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 72/78] config.txt: move uploadpack.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:45 +0200
Message-Id: <20181027062351.30446-73-pclouds@gmail.com>
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
 Documentation/config.txt            | 66 +----------------------------
 Documentation/config/uploadpack.txt | 65 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/config/uploadpack.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 00cc2791b5..451c9fe2b3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -425,71 +425,7 @@ include::config/transfer.txt[]
 
 include::config/uploadarchive.txt[]
 
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
+include::config/uploadpack.txt[]
 
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
new file mode 100644
index 0000000000..ed1c835695
--- /dev/null
+++ b/Documentation/config/uploadpack.txt
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

