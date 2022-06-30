Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848F3CCA473
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiF3VUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiF3VT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919064D157
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q9so372294wrd.8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cIBLDD+97wzDPREu6ywXDSA3a5ZiX5cnBt6UTCqgpi0=;
        b=nvrzzHwAu56vtAw7gKWm3Zl6tg8St5ATmaWEG2phrOhybqGOuLcCOJiqgHrQmX+O0/
         FwpXKYYmcsXzllH6a5yIIVJKyfbQyXTcGJ71KhF1SvhzPcDNfgKFDlNXk4/RkE+iW43Z
         mwdB0PDIj8++KYHAc6S11jAlDc4crwnnzbupUL7mnmlu+ikwBpB+AV3WDSjkCyun2CmD
         MSvRocnrCeb35UUIBmzABuU2lMkqnVelycKLlKJPVLOVdi5W5EhgB0nqfU0IwFygHxdh
         00RMRGV4CR+25ZwLViV0hHbtxXRosWs/INXDK5fEmp2gsk60ciShDCUPWJU2MMcJGFAU
         qZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cIBLDD+97wzDPREu6ywXDSA3a5ZiX5cnBt6UTCqgpi0=;
        b=t9tH//Cg2P8J0v4MUtUY3hO0wgEZYnIgtc54tZ/TartRZQzCG3PS9MLWciOxOl9ycU
         hJn71xlyktWvSpliQOobd6FWZvYjHaQjAh8fD+AEFCkrf5VQynPfMUrO+0knbTeg0r+/
         dpIN/eb6nqKdmQkfTcSG1aVOndmXS4iK3pLczomIGg1mwGLKG0BU9sLq1MAV8FIdCYnq
         3iiC1lrp5/YxvF+GlQjia9cjWA3nHfBEaHll9exm4IBhndeUoaZmEpZ7EZmq8YftMS97
         5IrYBMTu64vyz07EkNRsiTjQGRonqenqxIR7zuvkmSDmX7QrKqoNszVksP+H03ImS1tH
         bqwA==
X-Gm-Message-State: AJIora9fGx3A7G544ppIlZYuX7mdx+s1SyzsejQhP9KpjUBQA3TJyiRE
        1lYLPNxcZ+6v7AoVNPaeZhQuE/NISnk=
X-Google-Smtp-Source: AGRyM1vFTk+wYgVyWDrpSxpLKJQ0ytf/6kzlJgVsV6HnfUHCEwB2M5tiKLH8YCitHy0u1dAXC9KyWg==
X-Received: by 2002:a5d:500a:0:b0:21b:8274:9ddc with SMTP id e10-20020a5d500a000000b0021b82749ddcmr10193313wrt.251.1656623992800;
        Thu, 30 Jun 2022 14:19:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0039c5ab7167dsm3967889wmq.48.2022.06.30.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:52 -0700 (PDT)
Message-Id: <2eec463739745d2110aa5462ba9547fa8d255ebb.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:31 +0000
Subject: [PATCH v2 11/18] git-submodule.sh: use "$quiet", not "$GIT_QUIET"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Remove the use of the "$GIT_QUIET" variable in favor of our own
"$quiet", ever since b3c5f5cb048 (submodule: move core cmd_update()
logic to C, 2022-03-15) we have not used the "say" function in
git-sh-setup.sh, which is the only thing that's affected by using
"GIT_QUIET".

We still want to support --quiet for our own use though, but let's use
our own variable for that. Now it's obvious that we only care about
passing "--quiet" to "git submodule--helper", and not to change the
output of any "say" invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7fc7119fb21..5e5d21c010f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,6 +30,7 @@ GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
 command=
+quiet=
 branch=
 force=
 reference=
@@ -80,7 +81,7 @@ cmd_add()
 			force=$1
 			;;
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--progress)
 			progress=1
@@ -128,7 +129,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -144,7 +145,7 @@ cmd_foreach()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--recursive)
 			recursive=1
@@ -159,7 +160,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
@@ -174,7 +175,7 @@ cmd_init()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--)
 			shift
@@ -190,7 +191,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${quiet:+--quiet} -- "$@"
 }
 
 #
@@ -207,7 +208,7 @@ cmd_deinit()
 			force=$1
 			;;
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--all)
 			deinit_all=t
@@ -226,7 +227,7 @@ cmd_deinit()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${quiet:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
 #
@@ -241,7 +242,7 @@ cmd_update()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--progress)
 			progress=1
@@ -335,7 +336,7 @@ cmd_update()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${GIT_QUIET:+--quiet} \
+		${quiet:+--quiet} \
 		${force:+--force} \
 		${progress:+"--progress"} \
 		${remote:+--remote} \
@@ -396,7 +397,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
 #
@@ -409,7 +410,7 @@ cmd_set_url() {
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--)
 			shift
@@ -425,7 +426,7 @@ cmd_set_url() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${quiet:+--quiet} -- "$@"
 }
 
 #
@@ -496,7 +497,7 @@ cmd_status()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--cached)
 			cached=1
@@ -518,7 +519,7 @@ cmd_status()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
 #
 # Sync remote urls for submodules
@@ -531,7 +532,7 @@ cmd_sync()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			shift
 			;;
 		--recursive)
@@ -551,7 +552,7 @@ cmd_sync()
 		esac
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 cmd_absorbgitdirs()
@@ -572,7 +573,7 @@ do
 		command=$1
 		;;
 	-q|--quiet)
-		GIT_QUIET=1
+		quiet=1
 		;;
 	--cached)
 		cached=1
-- 
gitgitgadget

