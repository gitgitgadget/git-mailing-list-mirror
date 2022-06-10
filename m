Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B46CC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiFJA0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiFJA03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20A53C75
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso315062wmr.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LpATBawER/4wzFU2+F3+njS535x4YYuxmNlzmMRfvzM=;
        b=F/b0TZYD2e8E3QJjZav85ngJsfU/koFcfQ6JXnd5rjBIGgpH5OgmvC5fET6o10+vh+
         9BGWjC5BC/8VpBpvHBILeS2IZ/1J9wyajzJQJCcxyzWJOayOn6q25iXPewN5pRb4XDi6
         /N044lQ4u583hAHJXe2WR9eTOMa2rFoB3eYNxYtx0MGyHoZ/fBQfc1JCEuGIErPVTTt1
         TdtB7CfMB3EUlUagqj9xQU9tvOPDqoEEhSjEMKJDVY0BGcYTLpfMZ6SahyMKHsCGanLu
         HKnLalkcELH1ZBAPMdHY5jIW2LSDSRsQeCDUUObRa0YKn4fr3IuHvWZr5krIYrIvdvIG
         K9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LpATBawER/4wzFU2+F3+njS535x4YYuxmNlzmMRfvzM=;
        b=r4YXyc/LTc5oxIxIrVj6WU+fUDPVjnuk4G0dWURHgr6ozU6HO7U7lTGESewPDAI4ye
         yb3zIZi1rSyG+6CEziSvQ84nkNnTAxvMuXipPdB6dzPqMpeZXRV8JJrPhvfkAVyCtE/M
         LQKfz5cJ70M08JqIhTTN//aaIFe2/obwrlnzgaGz/wtSejOT31Ncf30rql75AvgbctIj
         x/q3S5tsAUmAemihySzwS8WhEn/2YAq4awZbuNDK5lHuhyxXtHu3OoyAESvz8fGhNSDD
         E+EalmLa7aa8iwg0PVZoDXgRJdz0DyRF/D5HvVUuzJ0KY2jZv/u0THmmZfS1M8/3JVEQ
         TDvA==
X-Gm-Message-State: AOAM533AwxBsu5u2rXsbzVNIA8C13B08RRH8+Wn5ZoQraqdrF2TswL8c
        NdruNMWx3GcOIubbI6IosorlbO+iY4Q9YlYE
X-Google-Smtp-Source: ABdhPJyOuBK5x22lImYf4ffKDDxcwpB/vuNuXyDdxKAD04U+LcspJqkXBRBSE1aN5Tlq1blzzrMNuQ==
X-Received: by 2002:a7b:cd16:0:b0:39c:4fff:88cc with SMTP id f22-20020a7bcd16000000b0039c4fff88ccmr5716043wmj.122.1654820786744;
        Thu, 09 Jun 2022 17:26:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bc5c8000000b003974860e15esm789485wmk.40.2022.06.09.17.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:25 -0700 (PDT)
Message-Id: <cad906fda44133963cae92dabbbf9290e8356df1.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:16 +0000
Subject: [PATCH 3/8] submodule update: pass options with stuck forms
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

git-submodule.sh::cmd_update() converts 'unstuck' forms of options into
their 'stuck' forms before passing them to "git submodule--helper
update". Remove this special handling of 'unstuck' options and append
the options to `opts`.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 git-submodule.sh | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8c46eac22e8..7418fd5bf51 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -32,7 +32,6 @@ export GIT_PROTOCOL_FROM_USER
 command=
 branch=
 force=
-reference=
 cached=
 recursive=
 init=
@@ -44,8 +43,6 @@ custom_name=
 depth=
 progress=
 dissociate=
-jobs=
-filter=
 
 isnumber()
 {
@@ -277,11 +274,11 @@ cmd_update()
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
-			reference="--reference=$2"
+			opts="$opts $1 $2"
 			shift
 			;;
 		--reference=*)
-			reference="$1"
+			opts="$opts $1"
 			;;
 		--dissociate)
 			opts="$opts $1"
@@ -303,19 +300,19 @@ cmd_update()
 			;;
 		--depth)
 			case "$2" in '') usage ;; esac
-			depth="--depth=$2"
+			opts="$opts $1 $2"
 			shift
 			;;
 		--depth=*)
-			depth=$1
+			opts="$opts $1"
 			;;
 		-j|--jobs)
 			case "$2" in '') usage ;; esac
-			jobs="--jobs=$2"
+			opts="$opts $1 $2"
 			shift
 			;;
 		--jobs=*)
-			jobs=$1
+			opts="$opts $1"
 			;;
 		--single-branch)
 			opts="$opts $1"
@@ -325,11 +322,11 @@ cmd_update()
 			;;
 		--filter)
 			case "$2" in '') usage ;; esac
-			filter="--filter=$2"
+			opts="$opts $1 $2"
 			shift
 			;;
 		--filter=*)
-			filter="$1"
+			opts="$opts $1"
 			;;
 		--)
 			shift
@@ -351,11 +348,7 @@ cmd_update()
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-		${reference:+"$reference"} \
-		${depth:+"$depth"} \
 		${require_init:+--require-init} \
-		$jobs \
-		$filter \
 		$opts \
 		-- \
 		"$@"
-- 
gitgitgadget

