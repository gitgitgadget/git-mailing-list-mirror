Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25651F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeHVTbn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36843 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeHVTbm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id c21-v6so1796495lfh.3
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oP66ZmTXmIVNqHGuCZZLoH3cne/VoO1lSshlaWf1y64=;
        b=n8Es8QEC31fZlj7J88BGyK2n/JGPlkz+jt4HUPkbK3nuNwgsdI+C3iUtLHbhLW9U5+
         1USRVHsscA1Gr8VcL90/xt0E0FLf6GcFuNfauSqSSmoj839L5mf8cHSOB7xyZKlnUNeB
         tCaJOXbRT+LK/MOFiUsjdl5zkqsjg6gb0aKU6Xx9Q9E8UO+437L4WaIdbg6Zp9Z6h0lb
         FmoVs4dEM4zqTItUifsf+KjDXayjad34kha7RWO5SqBEwwrRgkGGdVBYr4gmxyUQPFtx
         u2yJbPUS4lb3oBOabxCqRoVaUwjJ+ktb8wtm3YWGVf0A/heCUMAkktqIfgwdZilL6H75
         Ptow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oP66ZmTXmIVNqHGuCZZLoH3cne/VoO1lSshlaWf1y64=;
        b=Y8SipDuNgGvLU8Rq9LSCUObswhhwIGAHf685zCLZim1mcSJLgLngOy6x4vZli0D6ZB
         1iK9FfPjCayWam9wiYE5ryeO1TvQsOSWX6UP0HRwlMZ8r6tlphntGM8AAwmd5xvucqfb
         lWSJ+/Kw66I9ycwpdJ5iCPCpWZNa1Xmag82pQpfTC1CgdVH2QUJZEwQfq79XODzxgxcV
         koCtCoyAAQyMF2+p2FlYCOIIykO8YxNm6UQsbaFaIpeB/+hj6h6j7kacUFEvV1Kkem75
         OQ7IqriZb3Hr/mdrao4ZOfvFpIPUYnbIR8q3m4D3emmMLRiGICX3J9YVY59OudIO7Vt9
         XARw==
X-Gm-Message-State: AOUpUlEMU9A7wGJFar19zTMV5zbIrvQxmbRh6wtbHSH3S2CbC/PDlY2R
        UFgmBI13A06iu4GY2Xz6csD0IfHL
X-Google-Smtp-Source: AA+uWPxcdNyH8c2/nTqsBWZOnkd1mEoWDhstsHRB4k66mL+SRzfbE+OgO4xFZYVtPiyAGVMz9dEb3Q==
X-Received: by 2002:a19:2545:: with SMTP id l66-v6mr7869603lfl.73.1534953970739;
        Wed, 22 Aug 2018 09:06:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/11] config.txt: move fetch part out to a separate file
Date:   Wed, 22 Aug 2018 18:05:56 +0200
Message-Id: <20180822160605.21864-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt       | 66 +---------------------------------
 Documentation/fetch-config.txt | 65 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/fetch-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 30adca61ee..33ba7ca2cd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1505,71 +1505,7 @@ fastimport.unpackLimit::
 	operation complete faster, especially on slow filesystems.  If
 	not set, the value of `transfer.unpackLimit` is used instead.
 
-fetch.recurseSubmodules::
-	This option can be either set to a boolean value or to 'on-demand'.
-	Setting it to a boolean changes the behavior of fetch and pull to
-	unconditionally recurse into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand' (the default
-	value), fetch and pull will only recurse into a populated submodule
-	when its superproject retrieves a commit that updates the submodule's
-	reference.
-
-fetch.fsckObjects::
-	If it is set to true, git-fetch-pack will check all fetched
-	objects. See `transfer.fsckObjects` for what's
-	checked. Defaults to false. If not set, the value of
-	`transfer.fsckObjects` is used instead.
-
-fetch.fsck.<msg-id>::
-	Acts like `fsck.<msg-id>`, but is used by
-	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
-	the `fsck.<msg-id>` documentation for details.
-
-fetch.fsck.skipList::
-	Acts like `fsck.skipList`, but is used by
-	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
-	the `fsck.skipList` documentation for details.
-
-fetch.unpackLimit::
-	If the number of objects fetched over the Git native
-	transfer is below this
-	limit, then the objects will be unpacked into loose object
-	files. However if the number of received objects equals or
-	exceeds this limit then the received pack will be stored as
-	a pack, after adding any missing delta bases.  Storing the
-	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.  If not set, the value of
-	`transfer.unpackLimit` is used instead.
-
-fetch.prune::
-	If true, fetch will automatically behave as if the `--prune`
-	option was given on the command line.  See also `remote.<name>.prune`
-	and the PRUNING section of linkgit:git-fetch[1].
-
-fetch.pruneTags::
-	If true, fetch will automatically behave as if the
-	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
-	if not set already. This allows for setting both this option
-	and `fetch.prune` to maintain a 1=1 mapping to upstream
-	refs. See also `remote.<name>.pruneTags` and the PRUNING
-	section of linkgit:git-fetch[1].
-
-fetch.output::
-	Control how ref update status is printed. Valid values are
-	`full` and `compact`. Default value is `full`. See section
-	OUTPUT in linkgit:git-fetch[1] for detail.
-
-fetch.negotiationAlgorithm::
-	Control how information about the commits in the local repository is
-	sent when negotiating the contents of the packfile to be sent by the
-	server. Set to "skipping" to use an algorithm that skips commits in an
-	effort to converge faster, but may result in a larger-than-necessary
-	packfile; The default is "default" which instructs Git to use the default algorithm
-	that never skips commits (unless the server has acknowledged it or one
-	of its descendants).
-	Unknown values will cause 'git fetch' to error out.
-+
-See also the `--negotiation-tip` option for linkgit:git-fetch[1].
+include::fetch-config.txt[]
 
 format.attach::
 	Enable multipart/mixed attachments as the default for
diff --git a/Documentation/fetch-config.txt b/Documentation/fetch-config.txt
new file mode 100644
index 0000000000..cbfad6cdbb
--- /dev/null
+++ b/Documentation/fetch-config.txt
@@ -0,0 +1,65 @@
+fetch.recurseSubmodules::
+	This option can be either set to a boolean value or to 'on-demand'.
+	Setting it to a boolean changes the behavior of fetch and pull to
+	unconditionally recurse into submodules when set to true or to not
+	recurse at all when set to false. When set to 'on-demand' (the default
+	value), fetch and pull will only recurse into a populated submodule
+	when its superproject retrieves a commit that updates the submodule's
+	reference.
+
+fetch.fsckObjects::
+	If it is set to true, git-fetch-pack will check all fetched
+	objects. See `transfer.fsckObjects` for what's
+	checked. Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
+
+fetch.fsck.<msg-id>::
+	Acts like `fsck.<msg-id>`, but is used by
+	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
+	the `fsck.<msg-id>` documentation for details.
+
+fetch.fsck.skipList::
+	Acts like `fsck.skipList`, but is used by
+	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
+	the `fsck.skipList` documentation for details.
+
+fetch.unpackLimit::
+	If the number of objects fetched over the Git native
+	transfer is below this
+	limit, then the objects will be unpacked into loose object
+	files. However if the number of received objects equals or
+	exceeds this limit then the received pack will be stored as
+	a pack, after adding any missing delta bases.  Storing the
+	pack from a push can make the push operation complete faster,
+	especially on slow filesystems.  If not set, the value of
+	`transfer.unpackLimit` is used instead.
+
+fetch.prune::
+	If true, fetch will automatically behave as if the `--prune`
+	option was given on the command line.  See also `remote.<name>.prune`
+	and the PRUNING section of linkgit:git-fetch[1].
+
+fetch.pruneTags::
+	If true, fetch will automatically behave as if the
+	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
+	if not set already. This allows for setting both this option
+	and `fetch.prune` to maintain a 1=1 mapping to upstream
+	refs. See also `remote.<name>.pruneTags` and the PRUNING
+	section of linkgit:git-fetch[1].
+
+fetch.output::
+	Control how ref update status is printed. Valid values are
+	`full` and `compact`. Default value is `full`. See section
+	OUTPUT in linkgit:git-fetch[1] for detail.
+
+fetch.negotiationAlgorithm::
+	Control how information about the commits in the local repository is
+	sent when negotiating the contents of the packfile to be sent by the
+	server. Set to "skipping" to use an algorithm that skips commits in an
+	effort to converge faster, but may result in a larger-than-necessary
+	packfile; The default is "default" which instructs Git to use the default algorithm
+	that never skips commits (unless the server has acknowledged it or one
+	of its descendants).
+	Unknown values will cause 'git fetch' to error out.
++
+See also the `--negotiation-tip` option for linkgit:git-fetch[1].
-- 
2.19.0.rc0.335.ga73d156e9c

