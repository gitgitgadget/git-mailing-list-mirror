Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0B81F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161223AbeEXTfj (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:35:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38198 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034603AbeEXTfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:35:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id m129-v6so8430705wmb.3
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZCml6CeWvNRbU/JV/uQaMdPHyF+9XhpAqw+bG7NkBsY=;
        b=T0tn3bppcwISNGyNrsNVubOkVxBqSH7oLV/LGgDfgxPMR3fPJjIafGBCmK2MyM9zc+
         dHmHmoN6nb1WLIrX//5s+AsRDvtyawGQqKMBYkEbN9RP02JgqEnF9gNSiAtTsuX9/gVW
         +7q/dhNSAL5y/YvPZYjdqbZLJR9ovuEgLnLt/UEnMR3VKk7Qf1474MydCzfWnhvDnOXG
         Nzr5aagxSjlqIsU+WPh8AG5ct/efkNBR1USi3vLztzzo2tekDaqV8cKVZxNCn57QXs+r
         5Ha8ETI6fB1kYNtc1azjK/kq0orF3n/B4pkh7TUEWyHmASjGvfuOsKa2td603teNZMHi
         rPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZCml6CeWvNRbU/JV/uQaMdPHyF+9XhpAqw+bG7NkBsY=;
        b=sHlMElRVuL1AssLST6g913Sr6qBLneBPiwuh3wuctA7cxO5yVTQue+/1KHYSSxYIsO
         feUIuSIye0W09Y3uQbr7F+yj48aCGOVs0e8UxkUQA4jjgQ0mbxz+/EbeN/GNXHc1xxpM
         NuiTB1WdlkKlxp2KQJhHAMNSLiqfBozl0OS39NH1b1lO136UssiY1CN0JOdhbTPs4Gz3
         KmE04qewwbOF2yaNkKU649l96M/RNh7X6zQbSMmc6pLOMLB01zukaWM9NheEcmCY/9PF
         PJ+D0xg5e/AsnYqPbFMETbIYKk5qahHqks3hJ6N6/X36lAWKDlYBdu5fkWCIiZcrQu/K
         E8Fg==
X-Gm-Message-State: ALKqPwfFZlm6waW1oYZiv0ufaiVFUVyc4W/yMGGPDB1fvQeQ92xbaneV
        SGKR11WRw1bFzU2iVbRnK+OEkzXZ
X-Google-Smtp-Source: AB8JxZqLTLcT7pHeGVE7GqGGIfYbJDSW36FEqJiA6Z2nGoGyl5lkpXqwihiyGkO8p3oWV9KVl23xng==
X-Received: by 2002:a1c:5946:: with SMTP id n67-v6mr7852852wmb.32.1527190529590;
        Thu, 24 May 2018 12:35:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 136-v6sm7056887wmo.12.2018.05.24.12.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 12:35:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] config doc: unify the description of fsck.* and receive.fsck.*
Date:   Thu, 24 May 2018 19:35:14 +0000
Message-Id: <20180524193516.28713-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
In-Reply-To: <20180524190214.GA21354@sigill.intra.peff.net>
References: <20180524190214.GA21354@sigill.intra.peff.net>
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
 Documentation/config.txt | 74 ++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 623dffd198..351c541ab8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1554,23 +1554,41 @@ filter.<driver>.smudge::
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
-	The path to a sorted list of object names (i.e. one SHA-1 per
-	line) that are known to be broken in a non-fatal way and should
-	be ignored. This feature is useful when an established project
-	should be accepted despite early commits containing errors that
-	can be safely ignored such as invalid committer email addresses.
-	Note: corrupt objects cannot be skipped with this setting.
+	Like `fsck.<msg-id>` this variable has a corresponding
+	`receive.fsck.skipList` variant.
++
+The path to a sorted list of object names (i.e. one SHA-1 per line)
+that are known to be broken in a non-fatal way and should be
+ignored. This feature is useful when an established project should be
+accepted despite early commits containing errors that can be safely
+ignored such as invalid committer email addresses. Note: corrupt
+objects cannot be skipped with this setting.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
@@ -2849,26 +2867,16 @@ receive.fsckObjects::
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

