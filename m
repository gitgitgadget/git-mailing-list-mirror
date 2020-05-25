Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A81C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C652071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388351AbgEYXez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 19:34:55 -0400
Received: from smtp-1.his.com ([216.194.195.13]:38855 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgEYXey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 19:34:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 8C82C609C6
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:50 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yiohw2w7CYcd for <git@vger.kernel.org>;
        Mon, 25 May 2020 19:27:50 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 360016090C
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:50 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 9FFEE6025F
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-ASG-Debug-ID: 1590449269-061c4120542f3540001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id OEnC7xJBrRoAk8kF for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 19EC5601CD
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id D7CCC177EA1;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XTbBPdlv1lx7; Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id C0B69177EAC;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tFb2dJyJ2Jhy; Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from wings.local (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 99568177EA9;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from wings.fios-router.home (localhost [127.0.0.1])
        by wings.local (8.15.2/8.15.2/Debian-10) with ESMTP id 04PNRm1M021160;
        Mon, 25 May 2020 19:27:48 -0400
Received: (from keni@localhost)
        by wings.fios-router.home (8.15.2/8.15.2/Submit) id 04PNRlaI021159;
        Mon, 25 May 2020 19:27:47 -0400
From:   Kenneth Lorber <keni@his.com>
To:     git@vger.kernel.org
Cc:     keni@his.com
Subject: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
Date:   Mon, 25 May 2020 19:27:24 -0400
X-ASG-Orig-Subj: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
Message-Id: <20200525232727.21096-4-keni@his.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525232727.21096-1-keni@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200525232727.21096-1-keni@his.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1590449269
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 3188
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82102
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a file of guidelines to prevent the namespace collisions
mentioned in git help config without any guidance.

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 .../technical/namespace-collisions.txt        | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/technical/namespace-collisions.txt

diff --git a/Documentation/technical/namespace-collisions.txt b/Documentation/technical/namespace-collisions.txt
new file mode 100644
index 0000000000..2a0cb312c5
--- /dev/null
+++ b/Documentation/technical/namespace-collisions.txt
@@ -0,0 +1,72 @@
+NAMESPACE COLLISIONS
+--------------------
+(Note that the recommendations in this section are under development
+and subject to change.  At this point they should be considered only
+suggestions.  If they do not work for your use case, or you are considering
+distributing your extension widely, please send a note to the mailing list.)
+
+Git uses identifiers in a number of different namespaces:
+
+* environment variables
+* files in $GIT_DIR
+* files in the working trees
+* config sections
+* hooks
+* attributes
+
+In order to reduce the chance of collisions between names Git uses
+and those used by other entities (users, groups, and extension authors),
+the following are recommended best practices.
+
+
+Names reserved to Git:
+
+* file or directory names ending with `.lock`
+* file or directory names starting with `.git`
+* filenames in $GIT_DIR
+* directory names in $GIT_DIR unless allowed by a rule below
+* environment variables starting with `GIT_`
+* configuration file sections unless allowed by a rule below
+* file or directory names in `$GIT_DIR/hooks` unless allowed by a rule below
+* attributes unless allowed by a rule below
+
+
+Names reserved for individual users:
+
+* The directory `$GIT_DIR/my`
+* Environment variables starting with `GIT_MY_`
+* Configuration section `my`
+* Files or directories in `$GIT_DIR/hooks` starting with `my_`
+* Attributes starting with `my_`
+
+Names reserved for individual repos:
+
+* The directory `$GIT_DIR/this`
+* Environment variables starting with `GIT_THIS_`
+* Configuration section `this`
+* Files or directories in `$GIT_DIR/hooks` starting with `this_`
+* Attributes starting with `this_`
+
+Names reserved for the lowest level group of people:
+
+* The directory `$GIT_DIR/our`
+* Environment variables starting with `GIT_OUR_`
+* Configuration section `our`
+* Files or directories in `$GIT_DIR/hooks` starting with `our_`
+* Attributes starting with `our_`
+
+Aliases
+~~~~~~~
+Aliases are a special case.  Users need to type them so they should be
+short, but there is no way to prevent such short names from colliding.
+So the documentation or installer should construct something like:
+
+  [alias]
+     test = !git my-test
+     my-test = !echo made it
+
+while detecting collisions for the short name.  Then users or local
+policy can deal with collisions on the short name.
+
+This is not meant to cover every possible use case - a policy that
+detailed would be ignored and thus of no use.  Please play nicely.
-- 
2.17.1

