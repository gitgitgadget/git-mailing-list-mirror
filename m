Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A475125CB
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwikKPqz"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE98C6
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 01:50:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a936f4a9so4443204e87.1
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697619045; x=1698223845; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cjC1/wfySI3EM1R1mrTEKo0rVXmoo62IPy8/h7bQRKQ=;
        b=mwikKPqzOnA+Tyotrh2fh8SsoFYCkX2HRaG2UKW0nS7kQa/yq2a/hpD/iHhRZreah4
         v17iVDWJZGBaEPoOjehLan1SdNBKyGTS8SmlHM5S0uWr5w+Wu3krvdZuQIk7e9NMQYHI
         dGkdeDPwEngBSPA4jGvgXmTFRCbX3XRTKsTJTLCIJlX2iVcYKevdKtj9Fm+afpiEPerN
         DT8vt9R/XY+E7bSRV5zRmv/QVxJzSyqYn9PnoH0miNSSrYOuNZyB3cr1ird+P6XAc4W7
         CfP9VCIgibEjKioHLGyxe95zOhTZ7cT2nW/Z7oegFnUxioeQy0/d5O4HaXHufihE9ucR
         hb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619045; x=1698223845;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjC1/wfySI3EM1R1mrTEKo0rVXmoo62IPy8/h7bQRKQ=;
        b=Z+ZYqqShUP+VdK1/AThfXiSwxBuYhjY80p9cgHP2GSaqaOMTepTgkXjZQbrwHe0HHl
         b7EG10PE9EdFcwITv8nbhj3G+RmUcCFaAdz/fBye2XHcvzFeQ84N9V87k10cUSjDdEPR
         h4oy0sBETMi5DKvpbNvMBHjPDzxX4FvEgVgSzzxiAAblkLdgIg+m0SMqV5y5j0DIBJ74
         K9bZbuUuZcYA62AFh7IbCkjJMGiiKRcZeBzbQOf79GnstxbqkACJ0o8BDwRfRLIJZp6i
         sbAMx5tiNF9I9DzIzumA3pz5b/9MYgxhFuX7CiIsjoa6WTB4EdON39UAjYfq7rC67fKz
         Dnxw==
X-Gm-Message-State: AOJu0YwlU7gUAqEAKOKWC2RKFP9YTwBWkO2qhhMEwFBAMXpeCwml2i7c
	a91A/c9A2myFAy74/QqwCZBYu5YPJL8=
X-Google-Smtp-Source: AGHT+IF9NLwYsQiIa9Z7tL4piY+1o9xVNSFmcWTB+ZHJQ/imx4jqfNrjNiK2mymr6dnJJQ4wGGUF3Q==
X-Received: by 2002:a05:6512:b8a:b0:507:a0d6:f178 with SMTP id b10-20020a0565120b8a00b00507a0d6f178mr4363764lfv.35.1697619044733;
        Wed, 18 Oct 2023 01:50:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020adfef45000000b0032ce54bacb1sm1651511wrp.0.2023.10.18.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:50:44 -0700 (PDT)
Message-ID: <pull.1599.git.1697619043944.gitgitgadget@gmail.com>
From: "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Oct 2023 08:50:43 +0000
Subject: [PATCH] git-gui: add support for filenames starting with tilde
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Pratyush Yadav <me@yadavpratyush.com>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

When git-gui encounters a file name starting with a tilde character (~),
TCL "helpfully" expands that tilde into a (probably non-existing) users
home directory. But in git-gui we're often not dealing with user supplied
paths, where such an expansion might be expected, but actual names of files.

Prevent TCL from doing tilde expansion on these literal filenames.

This fixes https://github.com/git-for-windows/git/issues/4349

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
    git-gui: add support for filenames starting with tilde
    
    I've originally submitted this patch as a pull request to Pratyush's
    git-gui repository [1] on March 23rd, but that hasn't received any
    feedback in almost seven months, so I'm resubmitting it on the mailing
    list, with an improved patch description.
    
    [1] https://github.com/prati0100/git-gui/pull/96

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1599%2Frimrul%2Fgit-gui-tilde-filenames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1599/rimrul/git-gui-tilde-filenames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1599

 git-gui/git-gui.sh    | 1 +
 git-gui/lib/diff.tcl  | 1 +
 git-gui/lib/index.tcl | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3e5907a4609..e8d60cf3324 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2273,6 +2273,7 @@ proc do_explore {} {
 # Open file relative to the working tree by the default associated app.
 proc do_file_open {file} {
 	global _gitworktree
+	if {[string index $file 0] eq {~}} {set file ./$file}
 	set explorer [get_explorer]
 	set full_file_path [file join $_gitworktree $file]
 	exec $explorer [file nativename $full_file_path] &
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 871ad488c2a..b7686caa962 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -190,6 +190,7 @@ proc show_other_diff {path w m cont_info} {
 		set max_sz 100000
 		set type unknown
 		if {[catch {
+				if {[string index $path 0] eq {~}} {set path ./$path}
 				set type [file type $path]
 				switch -- $type {
 				directory {
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index d2ec24bd80e..2fbe1447975 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -617,7 +617,7 @@ proc delete_helper {path_list path_index deletion_errors batch_size \
 
 		set path [lindex $path_list $path_index]
 
-		set deletion_failed [catch {file delete -- $path} deletion_error]
+		set deletion_failed [catch {file delete -- ./$path} deletion_error]
 
 		if {$deletion_failed} {
 			lappend deletion_errors [list "$deletion_error"]

base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
-- 
gitgitgadget
