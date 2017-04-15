Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996E51FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 20:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbdDOURU (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 16:17:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34238 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdDOURT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 16:17:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id z129so886927wmb.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=r3ZzNmgWnvN7/QT4RBiqAJLD7K+4KLIqTsRdfMcvmIM=;
        b=D69pOYBwlMiXVcc5O6cVm3TmT5X/JZ9l9/KnemxAXKJ8q4Cl/wREKK/YtCl56hK5Ic
         k/by1QZIUFf6oSTQnvJByQ5CrKEzcaGfKO4XiIiqm75lbNy804+nTUOAyA8mVXb2irYW
         dLsZq4RtseJ6wSmOH9QqIPNBFrKLksu4T6/GVPjUcB34+cnKSpjGp0QDP+ss9fiqqcJX
         1GradF5WxI9ksSGDbSoR1vr61Z+jf0YU5cDMfdWG1nYtSsbfBHAnjBZGvvPNL5P9O8j9
         6fddzPYqV6AJDrm5fgtp8pndAo7AGHmv8gYBAvL+bwrqtANymgq/vPgwCd+9SJTA6nFy
         t53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=r3ZzNmgWnvN7/QT4RBiqAJLD7K+4KLIqTsRdfMcvmIM=;
        b=W6vnoK4djoWHGrcieB/xBofItJ83p69CFSfA4+LgJz03i/FUORNIz+TRXSCSB221S9
         gN6NnTyKKPvvruZLnJlflzpBOtfPZG0YGWUuSHqH/jrUQ1eofFKrhacm5ZqSkypgTfrI
         /fodYNzSZZC9CEXxHqDBb+q4u4OkjZIV301ugp0jms0U+M/iUUVVIuFMQKROYQQXiHHO
         bidvVcMNW7oXfA00hbc3FbiqhAUawsM/oEJtpUO2HgS29A0OuS419r2eT512ZCE2d962
         4P3eErmhLQWYrviNRad86Gsynux2FD1rJVEYvP48jKkqa3pPZE6pJL6sVsbRUUabLMi+
         BJ9w==
X-Gm-Message-State: AN3rC/7lOay4aCqfpYk9CX4vsF6Nnr96gqx2J7U2rlVMfaz4Uf8fZoY4
        +QyRFUrOmaYXeHcK
X-Received: by 10.28.211.210 with SMTP id k201mr3363915wmg.129.1492287437726;
        Sat, 15 Apr 2017 13:17:17 -0700 (PDT)
Received: from christoph-laptop-16-04-2.fritz.box (p5DD3053C.dip0.t-ipconnect.de. [93.211.5.60])
        by smtp.googlemail.com with ESMTPSA id l141sm3788668wma.32.2017.04.15.13.17.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Apr 2017 13:17:16 -0700 (PDT)
Message-ID: <1492287435.14812.2.camel@gmail.com>
Subject: [PATCH] Documentation/git-checkout: make doc. of checkout
 <tree-ish> clearer
From:   Christoph Michelbach <michelbach94@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Date:   Sat, 15 Apr 2017 22:17:15 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While technically in the documentation, the fact that changes
introduced by a checkout <tree-ish> are staged automatically, was
not obvious when reading its documentation. It is now specifically
pointed out.

Signed-off-by: Christoph Michelbach <michelbach94@gmail.com>
---
 Documentation/git-checkout.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8e2c066..cfd7b18 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -85,9 +85,10 @@ Omitting <branch> detaches HEAD at the tip of the current branch.
 	from the index file or from a named <tree-ish> (most often a
 	commit).  In this case, the `-b` and `--track` options are
 	meaningless and giving either of them results in an error.  The
-	<tree-ish> argument can be used to specify a specific tree-ish
-	(i.e.  commit, tag or tree) to update the index for the given
-	paths before updating the working tree.
+	<tree-ish> argument can be used to specify the tree-ish (i.e.
+	commit,	tag, or tree) to update the index to for the given paths
+	before updating the working tree accordingly.  Note that this means
+	that the changes this command introduces are staged automatically.
 +
 'git checkout' with <paths> or `--patch` is used to restore modified or
 deleted paths to their original contents from the index or replace paths
-- 
2.7.4
