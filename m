Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0489C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbiFJA0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345559AbiFJA0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45653E19
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so11351956wra.9
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mRG7yNLMxPzB3gYu6cJqrAyeSHZjTd7Rpjd7TwS7rPo=;
        b=NCcpr+hGKyUJvP9fJqmQ3tJiq5+QLivLAIGP69hE/YrSvgL/ayLqTNifF1aY9ehO46
         IRwIpse/JVE4np7UpzWczQGjrsOGnlGwcxqo5fZZaJ0ulswhyWvYl61u4Mv5P4ITpnDp
         m9EpIqOcfQyQV+DrtzY1jjrLn5KE3yBTY0gkXWt34jayDmk5rdnrLKtswrcUbbtfRaUv
         GcWWh1SwNqxXQv1Uzp3vOX9ymAbMKkFCvdNWth7d/sbdK7CZZZfXDF3iWMioYzLWENx8
         knM7BUKKfWHWR3CZscqNkdR97ZDRR71k7nM1ul2skHlzg4Y6AcLUIplcVp28sNB/ZrFN
         XKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mRG7yNLMxPzB3gYu6cJqrAyeSHZjTd7Rpjd7TwS7rPo=;
        b=wfVDWlbaFbvFOE3VuJCMD/UMgT3TNIBUiNquZfOfPuSOmLEl7cpL0OSXMrVunx6i/u
         d173WObhkoRoB4cT6oYMNXezhjXRmz5z3AGAjb8WfZAPAPvM9nXeoTUDzBBRLPiy1Igr
         TcLm5iKtZCEAySiTmff50aBD9JrCUvYLMxj3PETk0xpbnSiAua+PT7diqAOMAKnCA9t4
         O1CE9/Wn3YSmzLH3lTurDbcRZifqsYfSQsnLHNhUP6M9/reZ1mQx8SCW0Mda07UGcbp3
         8v3YTH4F8QNS6jDCCJyzAVPYU7FFWr6AQg5Flv+CNr0C/swfilOWAx9JYkLr5Ljb+C/Y
         t4cg==
X-Gm-Message-State: AOAM531DhOYlCWy4849jvlOE+/7mH9UN7XcFXrGELJ1EJTi+rClHyS+6
        rBXEsOUcPMAoEqL36lwBFXqoGTqk66FK1n20
X-Google-Smtp-Source: ABdhPJxhDm4ExfMtZWhd9p4rIOGNzXzpFGUqO8vEyMY+W9kpy0fBjeafQ+Pkm3c8Qquz7m8V1ZiA8Q==
X-Received: by 2002:a05:6000:178c:b0:218:5e44:e9a0 with SMTP id e12-20020a056000178c00b002185e44e9a0mr11846361wrg.76.1654820791912;
        Thu, 09 Jun 2022 17:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c510600b0039748be12dbsm778708wms.47.2022.06.09.17.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:31 -0700 (PDT)
Message-Id: <6c496ef31526c45686b0ac6e685f655bdbb003de.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:20 +0000
Subject: [PATCH 7/8] submodule update: stop parsing options in .sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

cmd_update()'s option parsing loop is now obsolete - it only
appends options to `opts` without doing additional parsing. Remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 git-submodule.sh | 101 -----------------------------------------------
 1 file changed, 101 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6b3f161dc53..e9d93e91d21 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -236,110 +236,9 @@ cmd_deinit()
 #
 cmd_update()
 {
-	opts=
-	# parse $args after "submodule ... update".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			opts="$opts $1"
-			;;
-		--progress)
-			opts="$opts $1"
-			;;
-		-i|--init)
-			opts="$opts $1"
-			;;
-		--require-init)
-			opts="$opts $1"
-			;;
-		--remote)
-			opts="$opts $1"
-			;;
-		-N|--no-fetch)
-			opts="$opts $1"
-			;;
-		-f|--force)
-			opts="$opts $1"
-			;;
-		-r|--rebase)
-			opts="$opts $1"
-			;;
-		--reference)
-			case "$2" in '') usage ;; esac
-			opts="$opts $1 $2"
-			shift
-			;;
-		--reference=*)
-			opts="$opts $1"
-			;;
-		--dissociate)
-			opts="$opts $1"
-			;;
-		-m|--merge)
-			opts="$opts $1"
-			;;
-		--recursive)
-			opts="$opts $1"
-			;;
-		--checkout)
-			opts="$opts $1"
-			;;
-		--recommend-shallow)
-			opts="$opts $1"
-			;;
-		--no-recommend-shallow)
-			opts="$opts $1"
-			;;
-		--depth)
-			case "$2" in '') usage ;; esac
-			opts="$opts $1 $2"
-			shift
-			;;
-		--depth=*)
-			opts="$opts $1"
-			;;
-		-j|--jobs)
-			case "$2" in '') usage ;; esac
-			opts="$opts $1 $2"
-			shift
-			;;
-		--jobs=*)
-			opts="$opts $1"
-			;;
-		--single-branch)
-			opts="$opts $1"
-			;;
-		--no-single-branch)
-			opts="$opts $1"
-			;;
-		--filter)
-			case "$2" in '') usage ;; esac
-			opts="$opts $1 $2"
-			shift
-			;;
-		--filter=*)
-			opts="$opts $1"
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
-		$opts \
-		-- \
 		"$@"
 }
 
-- 
gitgitgadget

