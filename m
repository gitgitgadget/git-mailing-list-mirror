Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8491F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdBAWIA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:08:00 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:4712 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdBAWIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:08:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 5BFA71E3070;
        Wed,  1 Feb 2017 23:07:56 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cokle5n3cOHp; Wed,  1 Feb 2017 23:07:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 01DAC1E3086;
        Wed,  1 Feb 2017 23:07:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3XB6uGYd8K68; Wed,  1 Feb 2017 23:07:55 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-21.dynamic.mnet-online.de [185.17.206.21])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 9A36D1E3070;
        Wed,  1 Feb 2017 23:07:55 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH] doc: add note about ignoring --no-create-reflog
Date:   Wed,  1 Feb 2017 23:07:27 +0100
Message-Id: <20170201220727.18070-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The commands git-branch and git-tag accept a `--create-reflog` argument.
On the other hand, the negated form `--no-create-reflog` is accepted as
a valid option but has no effect. This silent noop may puzzle users.

To communicate that this behavior is intentional, add a short note in
the manuals for git-branch and git-tag.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---

Notes:
    In a previous discussion (<xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>) it
    was found that git-branch and git-tag accept a "--no-create-reflog" argument,
    but it has no effect, does not produce a warning, and is undocumented.

 Documentation/git-branch.txt | 1 +
 Documentation/git-tag.txt    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1fae4ee..fca3754 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -91,6 +91,7 @@ OPTIONS
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 	Note that in non-bare repositories, reflogs are usually
 	enabled by default by the `core.logallrefupdates` config option.
+	The negated form `--no-create-reflog` is silently ignored.
 
 -f::
 --force::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5b2288c..b0b933e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -152,6 +152,7 @@ This option is only applicable when listing tags without annotation lines.
 --create-reflog::
 	Create a reflog for the tag. To globally enable reflogs for tags, see
 	`core.logAllRefUpdates` in linkgit:git-config[1].
+	The negated form `--no-create-reflog` is silently ignored.
 
 <tagname>::
 	The name of the tag to create, delete, or describe.
-- 
2.10.2

