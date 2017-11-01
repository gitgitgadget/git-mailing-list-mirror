Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A84202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbdKAWck (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:32:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46816 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdKAWcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:32:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id k7so3318906pga.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qQa/dNmkXxjX4XTMzZjATfcJtPcJ3RU9qNGm90LH48U=;
        b=OA3Cc5kbmjcV5djZp77j8N1B94MKv1RSWc11rF08fmEfCe+9XkLIq3Gyk9dHyWou6j
         AEJJRPinftpOaLbMV4acHZwgkNg2kWIROp8fB7jiXn/mNfmdnNWdV9yPHqCyUfDKaiWn
         HPWQosJ0dbG3/b36Sh1i0M/DA7f9CN1rAgQ4c/oXTclzf1vYLYaRzbWwuxpdE6zqUUMU
         H57WyH6NbP5JMK3x+zj/0fdYweq9aG4WZdwlO0Pd9Kcj9IT8rwwvGOHDFxTrXmiFVOTk
         oFXCnlrQMMAa/Uex6/CpM0+XpHaGTX/uVZWY8M2SiUasl09MusKI1aNrq28d5vGlRsvX
         gaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qQa/dNmkXxjX4XTMzZjATfcJtPcJ3RU9qNGm90LH48U=;
        b=lMPg81iylsxPiB7z/Nvem1JUSpWZsR7oZcbyy0eunf3g2NocSqV7/IDy34Bkh+sv25
         WBMtz0YV3G4G9KxOA0qzrFUNwB/9DFsxf99EOcIvqYSeR8p/UkpnpHl8Jxvx84ugWrQg
         azGX7NjThkPQSDUe8RvxUQ7a+ulxzE1q19cI6YH7Gt6gXhHbRDHWpJiBdc14OBjj2GCo
         qNSDAIIoTwO3qMUrj3MIngmfYxxNOT/OAxUCKl0K3CqyHLGSp4b+9KN7E3x7PuKxEP7U
         zXYNWpQRmSs48diDU+VQJabVQc8JfIveGl8FegZCKrJZERi4ZvCHXJ/ebwI3+0dM5PUM
         YDeA==
X-Gm-Message-State: AMCzsaUVeFVHfioREBCN0cZ5dYqtaq9p+RNP2yr/7edWblJzNgo9O0fT
        +vAcaxM0uSjXcqVfPNKA2op9fTmoO1Y=
X-Google-Smtp-Source: ABhQp+TYveRyhaWX/9mdu892AIZ+a+nhcBHOT580iVCyTqtqG93LYLdFbOh7S/JPBud+L1xxOg0j1g==
X-Received: by 10.99.95.76 with SMTP id t73mr1342597pgb.57.1509575558137;
        Wed, 01 Nov 2017 15:32:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:8c31:fa03:3db5:a42a])
        by smtp.gmail.com with ESMTPSA id a70sm2668740pfa.94.2017.11.01.15.32.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 15:32:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] config: document blame configuration
Date:   Wed,  1 Nov 2017 15:32:34 -0700
Message-Id: <20171101223234.14527-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options are currently only referenced by the git-blame man page,
also explain them in git-config, which is the canonical page to
contain all config options.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb..b18cead6aa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -949,6 +949,23 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the `--whitespace` option. See linkgit:git-apply[1].
 
+blame.root::
+	Do not treat root commits as boundaries in `git-blame`.
+	This option defaults to false.
+
+blame.blankboundary::
+	Show blank SHA-1 for boundary commits in `git-blame`.
+	This option defaults to false.
+
+blame.showemail::
+	Show the author email instead of author name in `git-blame`.
+	This option defaults to false.
+
+blame.date::
+	Specifies the format used to output dates in `git-blame`.
+	If unset the iso format is used. For supported values,
+	see the discussion of the --date option at linkgit:git-log[1].
+
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
-- 
2.15.0.7.g980e40477f

