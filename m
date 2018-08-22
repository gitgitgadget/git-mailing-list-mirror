Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F321F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeHVTbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41611 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHVTbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26-v6so1788349lfc.8
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAHGauCPcawJTznmbZKUTpp47BMV7ygLZOiJHasf80s=;
        b=QCsQbVtPhjf3USMb+ZGF5LSnksuCgt8k55xbWmO0PNhqyoEdcahQXfxQWpqPUWUb1R
         vhSRGRvoQYFS4vZ3MdfSCHWsLD6hqiVqVMhXM3vPPRJXpXz+8ZVXUaPfRm3/KkJFp4td
         4Dk13allvyQOgfpuQWKdDmFNuBF092M4/EcHZcluyz8mTr7+0aYRRRA8wnb7/lhBnMp6
         df0pmvm53/PdDUeVbeFd74m5Cwt4qqfGBDl/+pwXOV/D+uXQoavWlvZzUinb+QALA+Pg
         zHZ2TsDd2HuJJ7vYzAe7+I8dkmoA1D9Yv8qgq1lqe0Gx+02NIwuI2aWOKrAjZIIG+0YM
         zUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAHGauCPcawJTznmbZKUTpp47BMV7ygLZOiJHasf80s=;
        b=mKUk3XDz5mquaKBSG72wMdXDHMqPQNfAGo9QFl6lTanSqtjVNPhdRQteC3jgZzDnNz
         dy/4OuXfUkaSsKDmQ2yM5jbc1+pxSrZFkj2TnoD8Ntn+YYxNPGUsFxc9e7SwRLy3TYbR
         RmNQ5NKciqXG3gamlii6g44oP/RNtgPCBQ0sZEP+OEtLIfuNiXQcPAqan39HD1DOT24d
         58qsXozuWTm6V2d1bUwovEC9FDa+SYRAgRvGNFliwBh9Y4KWRhiX5ZI4NfOpNT5NrflB
         9Y43z1hMZ6uWW2c3D2RzZvOWQTlD3Bu4+GHPWaA3xMk5NmuQYGsWhiRRexPe2TplQHv5
         81tQ==
X-Gm-Message-State: APzg51Avwin1aGSZH/e/1KJA4PbKpG/3gd75ZfgpShKfkdDtpguMLPv7
        1fN9pjopnk/Vvzd4Mkv+PLHclbkg
X-Google-Smtp-Source: ANB0Vdb+aSH8Wy1Jf/cWZJB/UhcWnBbAgQI3UxOONAD+xNAZ3yKPOKiip/44+1v0UX9Ed57+OXK+Cg==
X-Received: by 2002:a19:96c3:: with SMTP id y186-v6mr4655137lfd.91.1534953976557;
        Wed, 22 Aug 2018 09:06:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/11] config.txt: move push part out to a separate file
Date:   Wed, 22 Aug 2018 18:06:01 +0200
Message-Id: <20180822160605.21864-8-pclouds@gmail.com>
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
 Documentation/config.txt      | 114 +---------------------------------
 Documentation/push-config.txt | 113 +++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/push-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 609b407afc..2d3baf43fb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2551,119 +2551,7 @@ protocol.version::
 
 include::pull-config.txt[]
 
-push.default::
-	Defines the action `git push` should take if no refspec is
-	explicitly given.  Different values are well-suited for
-	specific workflows; for instance, in a purely central workflow
-	(i.e. the fetch source is equal to the push destination),
-	`upstream` is probably what you want.  Possible values are:
-+
---
-
-* `nothing` - do not push anything (error out) unless a refspec is
-  explicitly given. This is primarily meant for people who want to
-  avoid mistakes by always being explicit.
-
-* `current` - push the current branch to update a branch with the same
-  name on the receiving end.  Works in both central and non-central
-  workflows.
-
-* `upstream` - push the current branch back to the branch whose
-  changes are usually integrated into the current branch (which is
-  called `@{upstream}`).  This mode only makes sense if you are
-  pushing to the same repository you would normally pull from
-  (i.e. central workflow).
-
-* `tracking` - This is a deprecated synonym for `upstream`.
-
-* `simple` - in centralized workflow, work like `upstream` with an
-  added safety to refuse to push if the upstream branch's name is
-  different from the local one.
-+
-When pushing to a remote that is different from the remote you normally
-pull from, work as `current`.  This is the safest option and is suited
-for beginners.
-+
-This mode has become the default in Git 2.0.
-
-* `matching` - push all branches having the same name on both ends.
-  This makes the repository you are pushing to remember the set of
-  branches that will be pushed out (e.g. if you always push 'maint'
-  and 'master' there and no other branches, the repository you push
-  to will have these two branches, and your local 'maint' and
-  'master' will be pushed there).
-+
-To use this mode effectively, you have to make sure _all_ the
-branches you would push out are ready to be pushed out before
-running 'git push', as the whole point of this mode is to allow you
-to push all of the branches in one go.  If you usually finish work
-on only one branch and push out the result, while other branches are
-unfinished, this mode is not for you.  Also this mode is not
-suitable for pushing into a shared central repository, as other
-people may add new branches there, or update the tip of existing
-branches outside your control.
-+
-This used to be the default, but not since Git 2.0 (`simple` is the
-new default).
-
---
-
-push.followTags::
-	If set to true enable `--follow-tags` option by default.  You
-	may override this configuration at time of push by specifying
-	`--no-follow-tags`.
-
-push.gpgSign::
-	May be set to a boolean value, or the string 'if-asked'. A true
-	value causes all pushes to be GPG signed, as if `--signed` is
-	passed to linkgit:git-push[1]. The string 'if-asked' causes
-	pushes to be signed if the server supports it, as if
-	`--signed=if-asked` is passed to 'git push'. A false value may
-	override a value from a lower-priority config file. An explicit
-	command-line flag always overrides this config option.
-
-push.pushOption::
-	When no `--push-option=<option>` argument is given from the
-	command line, `git push` behaves as if each <value> of
-	this variable is given as `--push-option=<value>`.
-+
-This is a multi-valued variable, and an empty value can be used in a
-higher priority configuration file (e.g. `.git/config` in a
-repository) to clear the values inherited from a lower priority
-configuration files (e.g. `$HOME/.gitconfig`).
-+
---
-
-Example:
-
-/etc/gitconfig
-  push.pushoption = a
-  push.pushoption = b
-
-~/.gitconfig
-  push.pushoption = c
-
-repo/.git/config
-  push.pushoption =
-  push.pushoption = b
-
-This will result in only b (a and c are cleared).
-
---
-
-push.recurseSubmodules::
-	Make sure all submodule commits used by the revisions to be pushed
-	are available on a remote-tracking branch. If the value is 'check'
-	then Git will verify that all submodule commits that changed in the
-	revisions to be pushed are available on at least one remote of the
-	submodule. If any commits are missing, the push will be aborted and
-	exit with non-zero status. If the value is 'on-demand' then all
-	submodules that changed in the revisions to be pushed will be
-	pushed. If on-demand was not able to push all necessary revisions
-	it will also be aborted and exit with non-zero status. If the value
-	is 'no' then default behavior of ignoring submodules when pushing
-	is retained. You may override this configuration at time of push by
-	specifying '--recurse-submodules=check|on-demand|no'.
+include::push-config.txt[]
 
 include::rebase-config.txt[]
 
diff --git a/Documentation/push-config.txt b/Documentation/push-config.txt
new file mode 100644
index 0000000000..0a0e000569
--- /dev/null
+++ b/Documentation/push-config.txt
@@ -0,0 +1,113 @@
+push.default::
+	Defines the action `git push` should take if no refspec is
+	explicitly given.  Different values are well-suited for
+	specific workflows; for instance, in a purely central workflow
+	(i.e. the fetch source is equal to the push destination),
+	`upstream` is probably what you want.  Possible values are:
++
+--
+
+* `nothing` - do not push anything (error out) unless a refspec is
+  explicitly given. This is primarily meant for people who want to
+  avoid mistakes by always being explicit.
+
+* `current` - push the current branch to update a branch with the same
+  name on the receiving end.  Works in both central and non-central
+  workflows.
+
+* `upstream` - push the current branch back to the branch whose
+  changes are usually integrated into the current branch (which is
+  called `@{upstream}`).  This mode only makes sense if you are
+  pushing to the same repository you would normally pull from
+  (i.e. central workflow).
+
+* `tracking` - This is a deprecated synonym for `upstream`.
+
+* `simple` - in centralized workflow, work like `upstream` with an
+  added safety to refuse to push if the upstream branch's name is
+  different from the local one.
++
+When pushing to a remote that is different from the remote you normally
+pull from, work as `current`.  This is the safest option and is suited
+for beginners.
++
+This mode has become the default in Git 2.0.
+
+* `matching` - push all branches having the same name on both ends.
+  This makes the repository you are pushing to remember the set of
+  branches that will be pushed out (e.g. if you always push 'maint'
+  and 'master' there and no other branches, the repository you push
+  to will have these two branches, and your local 'maint' and
+  'master' will be pushed there).
++
+To use this mode effectively, you have to make sure _all_ the
+branches you would push out are ready to be pushed out before
+running 'git push', as the whole point of this mode is to allow you
+to push all of the branches in one go.  If you usually finish work
+on only one branch and push out the result, while other branches are
+unfinished, this mode is not for you.  Also this mode is not
+suitable for pushing into a shared central repository, as other
+people may add new branches there, or update the tip of existing
+branches outside your control.
++
+This used to be the default, but not since Git 2.0 (`simple` is the
+new default).
+
+--
+
+push.followTags::
+	If set to true enable `--follow-tags` option by default.  You
+	may override this configuration at time of push by specifying
+	`--no-follow-tags`.
+
+push.gpgSign::
+	May be set to a boolean value, or the string 'if-asked'. A true
+	value causes all pushes to be GPG signed, as if `--signed` is
+	passed to linkgit:git-push[1]. The string 'if-asked' causes
+	pushes to be signed if the server supports it, as if
+	`--signed=if-asked` is passed to 'git push'. A false value may
+	override a value from a lower-priority config file. An explicit
+	command-line flag always overrides this config option.
+
+push.pushOption::
+	When no `--push-option=<option>` argument is given from the
+	command line, `git push` behaves as if each <value> of
+	this variable is given as `--push-option=<value>`.
++
+This is a multi-valued variable, and an empty value can be used in a
+higher priority configuration file (e.g. `.git/config` in a
+repository) to clear the values inherited from a lower priority
+configuration files (e.g. `$HOME/.gitconfig`).
++
+--
+
+Example:
+
+/etc/gitconfig
+  push.pushoption = a
+  push.pushoption = b
+
+~/.gitconfig
+  push.pushoption = c
+
+repo/.git/config
+  push.pushoption =
+  push.pushoption = b
+
+This will result in only b (a and c are cleared).
+
+--
+
+push.recurseSubmodules::
+	Make sure all submodule commits used by the revisions to be pushed
+	are available on a remote-tracking branch. If the value is 'check'
+	then Git will verify that all submodule commits that changed in the
+	revisions to be pushed are available on at least one remote of the
+	submodule. If any commits are missing, the push will be aborted and
+	exit with non-zero status. If the value is 'on-demand' then all
+	submodules that changed in the revisions to be pushed will be
+	pushed. If on-demand was not able to push all necessary revisions
+	it will also be aborted and exit with non-zero status. If the value
+	is 'no' then default behavior of ignoring submodules when pushing
+	is retained. You may override this configuration at time of push by
+	specifying '--recurse-submodules=check|on-demand|no'.
-- 
2.19.0.rc0.335.ga73d156e9c

