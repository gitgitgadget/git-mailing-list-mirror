Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6F21F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbeG0P74 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:59:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38795 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeG0P74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so5684541wmi.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DIaVVvI6SAnyhXpXxNP7XdH0mlx+6+UJogQnUjfzP0=;
        b=hnqRQy08Qzi0eXn2ptbhc8ZE9o9WBvFLEuaMGEo8kwWgy5gSyI/WjHSFy8olP6uhTB
         +VV4c2MQkA89HFMqn04xU8lybmdgV8bmK1zSS4+deRpct3RiFs4AZuRaU4GYmPJZ48rd
         M9YwrL31gEK6oI+N/jrHcbs/hDrmZxlJPRXbeWxl3ZTZLH0TYAzBxOenHhxo6S7nGYID
         kqXJKmJcHXn7sPPNRyDCJG1+zrJqtnPMxLMW8J2IO0wr8tK19fwGqx5TUFIQKKp2wYdI
         u/SAvwXhBb8RjX8na7Y8gejZ/8kPULgcTAwI5iZF+1x7VUlscFN4dq2EgCBSHKugWjmu
         EtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DIaVVvI6SAnyhXpXxNP7XdH0mlx+6+UJogQnUjfzP0=;
        b=oKcmo6qDLA+S25GLSbwah5R4rRiMDRv1FNUw/QIKO8ncifR2sLNQ3LFSdLb6z4jC7w
         9U+cjE3iaNfrXto7rkl+hj4EwnkYlsxz/r9RDX4NOTi9PEShZHUKIr8OpAgEktCj2Qbr
         6kH05awNYl5NPICOKn/RcuyeZT49J7ZIG5hC+kjRcWf3qP7wQZxlJuowrfRbCxmWx0ZG
         4CSM2wtj9RmdILK7jfw/3n1/080sYe2nsauB9pFjBwK2bqYCLOH8SnuRMGRrt7Gkc1D4
         eb8R/WW9+z8Mr5eMXukzcrgxU5hcsZYnirqfeAJ7s1gdGCHgEAcQK2k1ysfQfAHiHfr7
         iPKg==
X-Gm-Message-State: AOUpUlEgq3uSC2Pl6ooC8ayVrErjbblcOg99nqodTKZFrtuviPlOescF
        tKVGMhDkg/CgLRqLXtzI239nuuE6Qt4=
X-Google-Smtp-Source: AAOMgpdhPjW1lO2zMsK32dAqnPOXkhYhdfZktYFlfTIb9PS8j+xteO7ID1H7B48PsmILTBKSLGGPKA==
X-Received: by 2002:a1c:4885:: with SMTP id v127-v6mr4378683wma.161.1532702261134;
        Fri, 27 Jul 2018 07:37:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/10] config doc: unify the description of fsck.* and receive.fsck.*
Date:   Fri, 27 Jul 2018 14:37:13 +0000
Message-Id: <20180727143720.14948-4-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
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
 Documentation/config.txt | 62 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b99cf8d71..8d08250a5b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1595,15 +1595,30 @@ filter.<driver>.smudge::
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
+to accept pushes of such data set `receive.fsck.<msg-id>` instead.
++
+The rest of the documentation discusses `fsck.*` for brevity, but the
+same applies for the corresponding `receive.fsck.*` variables.
++
+When `fsck.<msg-id>` is set, errors can be switched to warnings and
+vice versa by configuring the `fsck.<msg-id>` setting where the
+`<msg-id>` is the fsck message ID and the value is one of `error`,
+`warn` or `ignore`. For convenience, fsck prefixes the error/warning
+with the message ID, e.g. "missingEmail: invalid author/committer line
+- missing email" means that setting `fsck.missingEmail = ignore` will
+hide that issue.
++
+In general, it is better to enumerate existing objects with problems
+with `fsck.skipList`, instead of listing the kind of breakages these
+problematic objects share to be ignored, as doing the latter will
+allow new instances of the same breakages go unnoticed.
 
 fsck.skipList::
 	The path to a sorted list of object names (i.e. one SHA-1 per
@@ -1612,6 +1627,9 @@ fsck.skipList::
 	should be accepted despite early commits containing errors that
 	can be safely ignored such as invalid committer email addresses.
 	Note: corrupt objects cannot be skipped with this setting.
++
+Like `fsck.<msg-id>` this variable has a corresponding
+`receive.fsck.skipList` variant.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
@@ -2893,26 +2911,16 @@ receive.fsckObjects::
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
2.18.0.345.g5c9ce644c3

