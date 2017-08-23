Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAA6208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 00:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbdHWAkQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 20:40:16 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35869 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdHWAkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 20:40:14 -0400
Received: by mail-pf0-f172.google.com with SMTP id c28so1044770pfe.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eG70iIc0Y5f8CBH0eKdRb1rURxtw1pbTOdYes2nXoXk=;
        b=IephLsy0+OxIO6+3XKZTfbQKYiBn+DkM/cWm4+3da/ZSvzQ8TZ+5i8asrmHAHm9399
         AyZ7ncqtHC0S98k8D6DLObTuyydjnW3vbY6ImR3odXzn1ZUeRycWNPnJ4yz6sJnpr7Rp
         sTHOw/7G/A2/OMbm84+SdzGRt1guEhgkWbyj8P/WM13hj6wapz4hKraiMOkUIX3XoBZT
         CQtq92FWkh9Ieud7Cgq+LP0CGPQdBqPBZ+qtV8C/kXxkRMcLSn18PRsE5JCnvr8KdmrP
         cXhpDOveWHH10mVns6+ZkxPmg3sgUTZP2QuI84jlKx7iW/Yp1+kqCvlLBRfT7EFW2IyJ
         XDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eG70iIc0Y5f8CBH0eKdRb1rURxtw1pbTOdYes2nXoXk=;
        b=tIjz9Islo2J76ZMeouOUdzUwKpdEEGOs9k1wr3/lBkLBUs9/qE5T6runmiPcSYnPat
         5JbbNLlsSLyUsejTJ/6QtVHi9G3X8BgTjhh1fwLOSvxe7TiMh3mgE+QDDwkg7bddSlUu
         AyWQP51bKA+8G+Wy0CAqm5wGGYc1xLlFmQIwODn8JD1q5/BDLmUmqjzF1wgKPfDHY260
         WzNAH6/T224qdlPw4E7or9KJfL0RR2MTUis/fcx4qZe7YFQ6+bMq0lOlYmICs8dj8vU4
         F9AxX5L1EdDfbxaDTYHgyKulEaM+UWGQLkJczep9N2+XegWYlkIjdIOm9S5w8sk1mL00
         csbw==
X-Gm-Message-State: AHYfb5gquG1V6gqxyFm+XVP5wQ850aRbOBcRZdEFeC+9aX/y5A0R0MaU
        dAnbBYmzkoWy8Bi+v3x03Q==
X-Received: by 10.98.34.208 with SMTP id p77mr882986pfj.315.1503448813628;
        Tue, 22 Aug 2017 17:40:13 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id p67sm211754pga.79.2017.08.22.17.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 17:40:12 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v2] Doc: clarify that pack-objects makes packs, plural
Date:   Tue, 22 Aug 2017 17:40:10 -0700
Message-Id: <20170823004010.3077-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for pack-objects describes that it creates "a packed
archive of objects", which is confusing because it may create multiple
packs if --max-pack-size is set. Update the documentation to clarify
this, and explaining in which cases such a feature would be useful.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks. I've reverted the NAME change and used some of your suggestion
for the --max-pack-size documentation.
---
 Documentation/git-pack-objects.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8973510a4..473a16135 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -18,8 +18,9 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads list of objects from the standard input, and writes a packed
-archive with specified base-name, or to the standard output.
+Reads list of objects from the standard input, and writes either one or
+more packed archives with the specified base-name to disk, or a packed
+archive to the standard output.
 
 A packed archive is an efficient way to transfer a set of objects
 between two repositories as well as an access efficient archival
@@ -47,9 +48,9 @@ transport by their peers.
 OPTIONS
 -------
 base-name::
-	Write into a pair of files (.pack and .idx), using
+	Write into pairs of files (.pack and .idx), using
 	<base-name> to determine the name of the created file.
-	When this option is used, the two files are written in
+	When this option is used, the two files in a pair are written in
 	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
 	based on the pack content and is written to the standard
 	output of the command.
@@ -108,9 +109,13 @@ base-name::
 	is taken from the `pack.windowMemory` configuration variable.
 
 --max-pack-size=<n>::
-	Maximum size of each output pack file. The size can be suffixed with
+	In unusual scenarios, you may not be able to create files
+	larger than a certain size on your filesystem, and this option
+	can be used to tell the command to split the output packfile
+	into multiple independent packfiles, each not larger than the
+	given size. The size can be suffixed with
 	"k", "m", or "g". The minimum size allowed is limited to 1 MiB.
-	If specified, multiple packfiles may be created, which also
+	This option
 	prevents the creation of a bitmap index.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
-- 
2.14.1.342.g6490525c54-goog

