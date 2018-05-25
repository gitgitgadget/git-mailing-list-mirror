Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0553A1F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968080AbeEYT22 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:28:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46700 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYT20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:28:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id x9-v6so10940633wrl.13
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aKb2RIIq43w6TwefBgU3SDQymUuGcrlvwSkTfo78jFY=;
        b=K4MXjWS9lRQkCq5CmFXhKW3NLFrpLFsycITPq7niJ8xrVUOdWKVQmcEI+Dn9stwjC0
         7WFjviZu3NUs7TCCp8Fh3ZqvzLxb+pOCgodZ4BP0Zr9BNAc5uOpLBoRKes4+doGUiwwG
         +hA4ht0LDrjzAm65Q2OBEGAmB5v7JHHpOMMS2334g+qdTIVBQqTXkY7SS3R7QHIrrgs3
         xfgJL4ffsX8I6ceD1gHc9MGzFbHhp0ZwdJ/uAMCc69SGs4BEt/SP87btzzHi/fvpWAZ0
         qBcnHWUtqx1x/Pua+8d1jXVPiUZX+ppqDlgeUeuhbnVn46POxfR5eCjX3SDE5vwIcmMx
         /W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aKb2RIIq43w6TwefBgU3SDQymUuGcrlvwSkTfo78jFY=;
        b=LebY1U3ydcqN1g9mFIPZ9RR+EYlKdF7z87rshjT1bWv7+nCiH6ZA8IKug8t3Km3i4m
         ivjmmWAHJNzte0Mc1Pk1KlCcHXqp/AvQrMn2RqVMOwOtbVisM2dSDsr8vVJUN699IJhw
         kf8q0v20Sd0U6ku5YlrZbFCxASp8VhL3borVBeBoBgDQUa+bTAOVuyujZuVSqykyCqFY
         C7gK8N/L3SrkLlhGAWmZdns6Mzh5NX7YEDzWzQxUYu25KgKEDwU4iCSRkRl9bwH5GVAT
         /pxTDjKZfIPe+FD/BVdqsWjkZtGU0mEbyGx4MQgnKSIjZstNJhWaHluZEKxL8pDoegIJ
         +7aA==
X-Gm-Message-State: ALKqPwdJBkVknF9yZ/BDBHdTzWo4pinDKrf2KDLbUJRbHxIAaUT0hHId
        SiBKQjx34idmsSPL8Qyi3UhHHyym
X-Google-Smtp-Source: AB8JxZo8qTP5XzFuYi2/fsrdOD9qXPbjOjr4yM5XdScuMVTK6QRNihc2MFJC6QQtk0+Wv718JuPDKg==
X-Received: by 2002:adf:9404:: with SMTP id 4-v6mr2996891wrq.274.1527276504441;
        Fri, 25 May 2018 12:28:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a69-v6sm7276518wma.7.2018.05.25.12.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 12:28:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
Date:   Fri, 25 May 2018 19:28:08 +0000
Message-Id: <20180525192811.25680-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the fsck.<msg-id> and receive.fsck.<msg-id>
variables was mostly duplicated in two places, with fsck.<msg-id>
making no mention of the corresponding receive.fsck.<msg-id>, and the
same for fsck.skipList.

I spent quite a lot of time today wondering why setting the
fsck.<msg-id> variant wasn't working to clone a legacy repository (not
that that would have worked anyway, but a subsequent patch implements
fetch.fsck.<msg-id>).

Rectify this situation by describing the feature in general terms
under the fsck.* documentation, and make the receive.fsck.*
documentation refer to those variables instead.

This documentation was initially added in 2becf00ff7 ("fsck: support
demoting errors to warnings", 2015-06-22) and 4b55b9b479 ("fsck:
document the new receive.fsck.<msg-id> options", 2015-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 73 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 623dffd198..af7311e73f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1554,23 +1554,42 @@ filter.<driver>.smudge::
 	linkgit:gitattributes[5] for details.
 
 fsck.<msg-id>::
-	Allows overriding the message type (error, warn or ignore) of a
-	specific message ID such as `missingEmail`.
-+
-For convenience, fsck prefixes the error/warning with the message ID,
-e.g.  "missingEmail: invalid author/committer line - missing email" means
-that setting `fsck.missingEmail = ignore` will hide that issue.
-+
-This feature is intended to support working with legacy repositories
-which cannot be repaired without disruptive changes.
+	During fsck git may find issues with legacy data which
+	wouldn't be generated by current versions of git, and which
+	wouldn't be sent over the wire if `transfer.fsckObjects` was
+	set. This feature is intended to support working with legacy
+	repositories containing such data.
++
+Setting `fsck.<msg-id>` will be picked up by linkgit:git-fsck[1], but
+to accept pushes of such data set `receive.fsck.<msg-id>` instead. The
+rest of the documentation discusses `fsck.*` for brevity, but the same
+applies for the corresponding `receive.fsck.*` variables.
++
+When `fsck.<msg-id>` is set, errors can be switched to warnings and
+vice versa by configuring the `fsck.<msg-id>` setting where the
+`<msg-id>` is the fsck message ID and the value is one of `error`,
+`warn` or `ignore`. For convenience, fsck prefixes the error/warning
+with the message ID, e.g. "missingEmail: invalid author/committer line
+- missing email" means that setting `fsck.missingEmail = ignore` will
+hide that issue.
++
+Depending on the circumstances it might be better to use
+`fsck.skipList` instead to explicitly whitelist those objects that
+have issues, otherwise new occurrences of the same issue will be
+hidden going forward, although that's unlikely to happen in practice
+unless someone is being deliberately malicious.
 
 fsck.skipList::
 	The path to a sorted list of object names (i.e. one SHA-1 per
-	line) that are known to be broken in a non-fatal way and should
-	be ignored. This feature is useful when an established project
-	should be accepted despite early commits containing errors that
-	can be safely ignored such as invalid committer email addresses.
-	Note: corrupt objects cannot be skipped with this setting.
+	line) that are known to be broken in a non-fatal way and
+	should be ignored. This feature is useful when an established
+	project should be accepted despite early commits containing
+	errors that can be safely ignored such as invalid committer
+	email addresses. Note: corrupt objects cannot be skipped with
+	this setting.
++
+Like `fsck.<msg-id>` this variable has a corresponding
+`receive.fsck.skipList` variant.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
@@ -2849,26 +2868,16 @@ receive.fsckObjects::
 	`transfer.fsckObjects` is used instead.
 
 receive.fsck.<msg-id>::
-	When `receive.fsckObjects` is set to true, errors can be switched
-	to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
-	setting where the `<msg-id>` is the fsck message ID and the value
-	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
-	the error/warning with the message ID, e.g. "missingEmail: invalid
-	author/committer line - missing email" means that setting
-	`receive.fsck.missingEmail = ignore` will hide that issue.
-+
-This feature is intended to support working with legacy repositories
-which would not pass pushing when `receive.fsckObjects = true`, allowing
-the host to accept repositories with certain known issues but still catch
-other issues.
+	Acts like `fsck.<msg-id>`, but is used by
+	linkgit:git-receive-pack[1] instead of
+	linkgit:git-fsck[1]. See the `fsck.<msg-id>` documentation for
+	details.
 
 receive.fsck.skipList::
-	The path to a sorted list of object names (i.e. one SHA-1 per
-	line) that are known to be broken in a non-fatal way and should
-	be ignored. This feature is useful when an established project
-	should be accepted despite early commits containing errors that
-	can be safely ignored such as invalid committer email addresses.
-	Note: corrupt objects cannot be skipped with this setting.
+	Acts like `fsck.skipList`, but is used by
+	linkgit:git-receive-pack[1] instead of
+	linkgit:git-fsck[1]. See the `fsck.skipList` documentation for
+	details.
 
 receive.keepAlive::
 	After receiving the pack from the client, `receive-pack` may
-- 
2.17.0.290.gded63e768a

