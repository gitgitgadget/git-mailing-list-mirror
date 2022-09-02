Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A68ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiIBQNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiIBQNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:13:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309A10950F
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:09:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id se27so4790494ejb.8
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=oJO2Y7+qunhoUZPELmg7GT5LPuQC6HsgHehra7Pi3vw=;
        b=KmcJqdHevi6uWAh4Vpqm/Q8cAa4g2E7qJmJumQwyGj0GaQ4Q4NtqqT3DvxxH1rB8V5
         aB/KsjwBhN5zdTyNgtZO8qkQflwuk8rFvqBar3kDcMY9B9+NO8qWGUwSKh0A9U3bYSbq
         ar0YguVuxoiz9eo6xM0SN1Zvhh26VppBYq4n1amBIsNmXZFEli4VrbHXFJwxCV8fF8ld
         ubHmqN90VOoZddQkeViYMnCQ/vLeaTW0DeoWdksfLquftvfTvCCuZILJuj37xQfRkbGF
         l+D1ipdSsVeBniItJApwh0Feq1EQe/c0ZDvMW/31XPAxQN4j366STF9DoCgt73D66yM6
         YW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oJO2Y7+qunhoUZPELmg7GT5LPuQC6HsgHehra7Pi3vw=;
        b=x7URvKvUo35MvpD4dufd4u0CkSLeeih5KJcVAwndVTFXUYXEN+/hoWlnx+5B9oQ+mz
         mAmeQtjS/qy90qJ9j91pS0pfZfkMSOG2LeTt74LemlJXS4g/2Zromwul1XrcYeerT78h
         zfOY+mzosG/dk8vaPfZo0txcOKJ6LbaUOGdEmQ+tTAEf13tu18OCuDptahfrDnbErpw4
         JyfTqfKwPbBpst96lIBWm4KawDXvo6ARoFcAeY3A5GUKYdnsmLXQVetWXwRsfr9SY+A3
         2nw7lF3tA+fzFpketdGqRM5oh2LpYCJkGvkXcZKiEbc5mio6W38gdppcmgz5yB6lzMb4
         WGNA==
X-Gm-Message-State: ACgBeo0EOBur2teP3Srv+bXoGLIL1pwGS66u42ftiC+APSIlolI5SnTG
        Z+KSNRcAslEI0mueg3u/LRPDrh9LSDM=
X-Google-Smtp-Source: AA6agR7axNuH9ess+IqeP8rbUaMXw0QM1g3ej7XjtUgEY+jzv0gFzERn+zZT+ol3tK49xP4s0Tufvw==
X-Received: by 2002:a5d:6a01:0:b0:21a:338c:4862 with SMTP id m1-20020a5d6a01000000b0021a338c4862mr17269257wru.631.1662134217686;
        Fri, 02 Sep 2022 08:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003a5e7435190sm10647425wms.32.2022.09.02.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:57 -0700 (PDT)
Message-Id: <070f195f027e5601b88ca6a0d4c9991b472ad9ab.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:46 +0000
Subject: [PATCH v2 5/9] scalar: add to 'git help -a' command list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add 'scalar' as a 'mainporcelain' command in the Git command list. Update
the regex in 'cmd-list.perl' used to match the first line of command
documentation to find 'scalar(1)'.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/cmd-list.perl | 2 +-
 command-list.txt            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index af5da45d287..9515a499a31 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -10,7 +10,7 @@ sub format_one {
 	$state = 0;
 	open I, '<', "$name.txt" or die "No such file $name.txt";
 	while (<I>) {
-		if (/^git[a-z0-9-]*\(([0-9])\)$/) {
+		if (/^(git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
 			$mansection = $1;
 			next;
 		}
diff --git a/command-list.txt b/command-list.txt
index f96bdabd7d9..93f94e42ab7 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -235,3 +235,4 @@ gittutorial                             guide
 gittutorial-2                           guide
 gitweb                                  ancillaryinterrogators
 gitworkflows                            guide
+scalar                                  mainporcelain
-- 
gitgitgadget

