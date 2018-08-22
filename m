Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2491F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeHVTby (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42962 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeHVTbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so1777460lff.9
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9sKnTQKfM6pM+QRxobm6togybqwllE+7v5NV441tLs=;
        b=P+asiM2YDElCU/2RKSTUDnqhVU/qlT9qOBMl+ZpCGl19KY+GbaIvz9eLMdunSRURk5
         Cfchkd2dybwXzi+LvYLmlTXGR1qI1LS3+0TwmDkgbFI5RqUiz41kUUwtbeWpXfDbi3DA
         cwP9LZUMcmMriMyFA5kFJxYfaKM/mZpaol1OJ2WhJmMdAArbXDzl6uCnjsInGYX0JPwD
         XUO+q1IEYf9gFAWUYDwKvamukEBJXjvQwSDSmIG9bE0a7CVPRlTkKXwz64EvQFkdA+1W
         5ebLFy9uZSAd8C9ebLZDniXClayH+7lMOdzEdcd+o8gTJ3+OlDpTxNO6Lj+bmIH1R4QY
         hJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9sKnTQKfM6pM+QRxobm6togybqwllE+7v5NV441tLs=;
        b=QVCnvAxaeicBPqubD27GhdZT7zeZ6gxs8WKCkmPMcCkpm7FhAM9/aIcGCqj2eMdzqK
         Iv8ORuBn2BU9jcUWoCNauxbiUhruTuevZBU54sQ0K8cv3g8uawaO0EODuYVChmCDllvR
         gBbx+KbVT3l2h/wWrI8KbmcQ2EOEgE6VBAoj4rnFfq1XsALf/YKqh2cfr1bUqlRZodAW
         pQJLXIObeq2TYAhqOa39KvOXS45Bcl9pO8RGQaCVNLUwjGVJLbtd1TafvyVWOFnb5b3m
         WR/RXryGh0rFhPiugIrqR4h+l5qdqxyIfKk4OjpZF/oTe4cnXiz7TT/wgDkqIcAx2uRO
         StlA==
X-Gm-Message-State: AOUpUlH4tb6tpWTbzxoAmGS6rqQyzbYgvoX0kVKI/2qxJyyPHWEczOCU
        MYMwQgwQJvZ9VGi24udIs+/3KCOy
X-Google-Smtp-Source: AA+uWPxGOS29gT17aJ5SVOL8Gyp+HAMQnziqxGWTAzUzLkrBmPxwko7QKoJKqx+aGxAceunnJswuqw==
X-Received: by 2002:a19:53d6:: with SMTP id h83-v6mr21261148lfl.15.1534953981224;
        Wed, 22 Aug 2018 09:06:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/11] config.txt: move submodule part out to a separate file
Date:   Wed, 22 Aug 2018 18:06:05 +0200
Message-Id: <20180822160605.21864-12-pclouds@gmail.com>
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
 Documentation/config.txt           | 83 +-----------------------------
 Documentation/submodule-config.txt | 82 +++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/submodule-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0eaf40564..b7b557d0e7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2791,88 +2791,7 @@ stash.showStat::
 	option will show diffstat of the stash entry.  Defaults to true.
 	See description of 'show' command in linkgit:git-stash[1].
 
-submodule.<name>.url::
-	The URL for a submodule. This variable is copied from the .gitmodules
-	file to the git config via 'git submodule init'. The user can change
-	the configured URL before obtaining the submodule via 'git submodule
-	update'. If neither submodule.<name>.active or submodule.active are
-	set, the presence of this variable is used as a fallback to indicate
-	whether the submodule is of interest to git commands.
-	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
-
-submodule.<name>.update::
-	The method by which a submodule is updated by 'git submodule update',
-	which is the only affected command, others such as
-	'git checkout --recurse-submodules' are unaffected. It exists for
-	historical reasons, when 'git submodule' was the only command to
-	interact with submodules; settings like `submodule.active`
-	and `pull.rebase` are more specific. It is populated by
-	`git submodule init` from the linkgit:gitmodules[5] file.
-	See description of 'update' command in linkgit:git-submodule[1].
-
-submodule.<name>.branch::
-	The remote branch name for a submodule, used by `git submodule
-	update --remote`.  Set this option to override the value found in
-	the `.gitmodules` file.  See linkgit:git-submodule[1] and
-	linkgit:gitmodules[5] for details.
-
-submodule.<name>.fetchRecurseSubmodules::
-	This option can be used to control recursive fetching of this
-	submodule. It can be overridden by using the --[no-]recurse-submodules
-	command-line option to "git fetch" and "git pull".
-	This setting will override that from in the linkgit:gitmodules[5]
-	file.
-
-submodule.<name>.ignore::
-	Defines under what circumstances "git status" and the diff family show
-	a submodule as modified. When set to "all", it will never be considered
-	modified (but it will nonetheless show up in the output of status and
-	commit when it has been staged), "dirty" will ignore all changes
-	to the submodules work tree and
-	takes only differences between the HEAD of the submodule and the commit
-	recorded in the superproject into account. "untracked" will additionally
-	let submodules with modified tracked files in their work tree show up.
-	Using "none" (the default when this option is not set) also shows
-	submodules that have untracked files in their work tree as changed.
-	This setting overrides any setting made in .gitmodules for this submodule,
-	both settings can be overridden on the command line by using the
-	"--ignore-submodules" option. The 'git submodule' commands are not
-	affected by this setting.
-
-submodule.<name>.active::
-	Boolean value indicating if the submodule is of interest to git
-	commands.  This config option takes precedence over the
-	submodule.active config option. See linkgit:gitsubmodules[7] for
-	details.
-
-submodule.active::
-	A repeated field which contains a pathspec used to match against a
-	submodule's path to determine if the submodule is of interest to git
-	commands. See linkgit:gitsubmodules[7] for details.
-
-submodule.recurse::
-	Specifies if commands recurse into submodules by default. This
-	applies to all commands that have a `--recurse-submodules` option,
-	except `clone`.
-	Defaults to false.
-
-submodule.fetchJobs::
-	Specifies how many submodules are fetched/cloned at the same time.
-	A positive integer allows up to that number of submodules fetched
-	in parallel. A value of 0 will give some reasonable default.
-	If unset, it defaults to 1.
-
-submodule.alternateLocation::
-	Specifies how the submodules obtain alternates when submodules are
-	cloned. Possible values are `no`, `superproject`.
-	By default `no` is assumed, which doesn't add references. When the
-	value is set to `superproject` the submodule to be cloned computes
-	its alternates location relative to the superprojects alternate.
-
-submodule.alternateErrorStrategy::
-	Specifies how to treat errors with the alternates for a submodule
-	as computed via `submodule.alternateLocation`. Possible values are
-	`ignore`, `info`, `die`. Default is `die`.
+include::submodule-config.txt[]
 
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
diff --git a/Documentation/submodule-config.txt b/Documentation/submodule-config.txt
new file mode 100644
index 0000000000..0a1293b051
--- /dev/null
+++ b/Documentation/submodule-config.txt
@@ -0,0 +1,82 @@
+submodule.<name>.url::
+	The URL for a submodule. This variable is copied from the .gitmodules
+	file to the git config via 'git submodule init'. The user can change
+	the configured URL before obtaining the submodule via 'git submodule
+	update'. If neither submodule.<name>.active or submodule.active are
+	set, the presence of this variable is used as a fallback to indicate
+	whether the submodule is of interest to git commands.
+	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
+
+submodule.<name>.update::
+	The method by which a submodule is updated by 'git submodule update',
+	which is the only affected command, others such as
+	'git checkout --recurse-submodules' are unaffected. It exists for
+	historical reasons, when 'git submodule' was the only command to
+	interact with submodules; settings like `submodule.active`
+	and `pull.rebase` are more specific. It is populated by
+	`git submodule init` from the linkgit:gitmodules[5] file.
+	See description of 'update' command in linkgit:git-submodule[1].
+
+submodule.<name>.branch::
+	The remote branch name for a submodule, used by `git submodule
+	update --remote`.  Set this option to override the value found in
+	the `.gitmodules` file.  See linkgit:git-submodule[1] and
+	linkgit:gitmodules[5] for details.
+
+submodule.<name>.fetchRecurseSubmodules::
+	This option can be used to control recursive fetching of this
+	submodule. It can be overridden by using the --[no-]recurse-submodules
+	command-line option to "git fetch" and "git pull".
+	This setting will override that from in the linkgit:gitmodules[5]
+	file.
+
+submodule.<name>.ignore::
+	Defines under what circumstances "git status" and the diff family show
+	a submodule as modified. When set to "all", it will never be considered
+	modified (but it will nonetheless show up in the output of status and
+	commit when it has been staged), "dirty" will ignore all changes
+	to the submodules work tree and
+	takes only differences between the HEAD of the submodule and the commit
+	recorded in the superproject into account. "untracked" will additionally
+	let submodules with modified tracked files in their work tree show up.
+	Using "none" (the default when this option is not set) also shows
+	submodules that have untracked files in their work tree as changed.
+	This setting overrides any setting made in .gitmodules for this submodule,
+	both settings can be overridden on the command line by using the
+	"--ignore-submodules" option. The 'git submodule' commands are not
+	affected by this setting.
+
+submodule.<name>.active::
+	Boolean value indicating if the submodule is of interest to git
+	commands.  This config option takes precedence over the
+	submodule.active config option. See linkgit:gitsubmodules[7] for
+	details.
+
+submodule.active::
+	A repeated field which contains a pathspec used to match against a
+	submodule's path to determine if the submodule is of interest to git
+	commands. See linkgit:gitsubmodules[7] for details.
+
+submodule.recurse::
+	Specifies if commands recurse into submodules by default. This
+	applies to all commands that have a `--recurse-submodules` option,
+	except `clone`.
+	Defaults to false.
+
+submodule.fetchJobs::
+	Specifies how many submodules are fetched/cloned at the same time.
+	A positive integer allows up to that number of submodules fetched
+	in parallel. A value of 0 will give some reasonable default.
+	If unset, it defaults to 1.
+
+submodule.alternateLocation::
+	Specifies how the submodules obtain alternates when submodules are
+	cloned. Possible values are `no`, `superproject`.
+	By default `no` is assumed, which doesn't add references. When the
+	value is set to `superproject` the submodule to be cloned computes
+	its alternates location relative to the superprojects alternate.
+
+submodule.alternateErrorStrategy::
+	Specifies how to treat errors with the alternates for a submodule
+	as computed via `submodule.alternateLocation`. Possible values are
+	`ignore`, `info`, `die`. Default is `die`.
-- 
2.19.0.rc0.335.ga73d156e9c

