Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C267DC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiF3VTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiF3VTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9A345787
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so451743wra.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=W1ePcHzxfgzuz+gX0A5j68PuxD+g5ZNhol7Gw34IJ2s=;
        b=WIGscM7n95sfSudLGloQnZz/bEsqHPEm+Bq4Sy85O87GUAYAOV8j9n7f4tvNfiuhh2
         g9UOrfuMmL5dDakPVL3GLuuk7iyPcNLdk5ir0ofktcKHU6SeqwgmjYyJhHpJ82nU4kOt
         INmVk6JDbGWbA1oS2u/RWls0mtbfJ1sdyBCrW10hQ+8U82nDf7CGOspmWL+ziZMhYCec
         pOF+qyDSIcFAKQboJrdZzogM/Me56nXm/0r996thDDcatxf2OIdnxLyfjBYl5fKpnliQ
         sXF/D4Wl8pnS/Mu0cwy2/1DE8ZWnroy0dYlKWCgtLTKfPkwIMvri+o+6WRLtzsOSwB+F
         m9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=W1ePcHzxfgzuz+gX0A5j68PuxD+g5ZNhol7Gw34IJ2s=;
        b=HjtCKFwqPZ3pLmS79otYst0tiw5+20R18r2PV4d75QVxaYIe+fgDE2SUeLMGof5QxO
         IsIqNi1I1A9eNo91nzPrrGamAcUp/lmGHyONqD8xthDxjoc2j/8tQHVxHUUA9flE/zFy
         rumyDQ1G+kdpBvTNZMVSFeyfjIQ/UCq5sLpyVLOHJyMbqbV0i7kHUqfOT2KvgJZMrn9P
         EsOEEWFZ3R7xiqvmhYDblzxBr0co+H6qewfFJuBj15vISs1J+yKFPr7UKSZV5R0kRFqr
         dA9oBFvksu6/54MXmJEImR7c8ysXQTYM64fRAevE2bk8cq/Xm73hlna6GjIxxLkF0X+O
         U8kA==
X-Gm-Message-State: AJIora8Q6y7YcqNJ4gGD+CQT5GeStnRu2wLLwaM7+xS5f01AxoY0W8kF
        QNabE7gFk1fGXE0KBbvenLhJii1j5cM=
X-Google-Smtp-Source: AGRyM1sjth4rZMnO43gemmhREWasRIGQ1OsfOVSi58hEYfol1Nxp0z8LGNZSgxl5dru9shyLbC4VKg==
X-Received: by 2002:adf:f751:0:b0:21a:3ab8:1991 with SMTP id z17-20020adff751000000b0021a3ab81991mr10616926wrp.711.1656623983897;
        Thu, 30 Jun 2022 14:19:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c3b08000000b00397402ae674sm4095439wma.11.2022.06.30.14.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:43 -0700 (PDT)
Message-Id: <757d0927976cf9d59a050f8f9ce1fe54d4dff653.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:23 +0000
Subject: [PATCH v2 03/18] git-submodule.sh: make the "$cached" variable a
 boolean
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

Remove the assignment of "$1" to the "$cached" variable. As seen in
the initial implementation in 70c7ac22de6 (Add git-submodule command,
2007-05-26) we only need to keep track of if we've seen the --cached
option, not save the "--cached" string for later use.

In 28f9af5d25e (git-submodule summary: code framework, 2008-03-11)
"$1" was assigned to it, but since there was no reason to do so let's
stop doing it. This trivial change will make it easier to reason about
an eventual change that'll remove the cmd_summary() function in favor
of dispatching to "git submodule--helper summary" directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 53847bbf6e2..b99a00d9f84 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -446,7 +446,7 @@ cmd_summary() {
 	do
 		case "$1" in
 		--cached)
-			cached="$1"
+			cached=1
 			;;
 		--files)
 			files="$1"
@@ -583,7 +583,7 @@ do
 		branch="$2"; shift
 		;;
 	--cached)
-		cached="$1"
+		cached=1
 		;;
 	--)
 		break
-- 
gitgitgadget

