Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40DECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiH3Jft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiH3Jeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:44 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD0E2C47
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:12 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11f0fa892aeso7095436fac.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yQZUwlot2KcMcOVFaJfRif/9lhEQBesbqls2nqR2MjU=;
        b=OMJkUceWDPo+Pu0759moYZfhVyp2O07Sr59EUbW8Kcf44G6puh9snA+5j9nhLLOV67
         jtvD4Ed6dGOVQZpFDdnactZSiVBadIPy2m3YjaUytjyPZpeisTbSZB8GJ0oqzI9YgMhs
         qmRv4kzi5+8TNjNJo2F6ExUp4AqBlOF3jSXGJ6SIsE+AudqcjI2mtnws+/ooAErkl0Xw
         xvdEsVZs/H+ihRL/kHxIZuRahtVvV0G891zmhGq1TpsHpONtppgHVTvn75vgHkycS/qU
         zDNYc2LDVWhojDB5KJ8xjQKRiuFZD8vCxIOF2yjgq/fTL6FxQID2nvvuSFeU42l2Qc+Y
         6uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yQZUwlot2KcMcOVFaJfRif/9lhEQBesbqls2nqR2MjU=;
        b=ZECHqQ0gzCh07vJ9oxse+Y7x+h7Fa7K/jH/gkYAbJYcgkgH1CZadUCqCMf8YgkkvcF
         SfgelGrkLp7KcMaE1LIqrqWrnQGqeNhsurPhhObyblW903bmmce+o7MDZddQ6AArkkN5
         deWM3zuebtIZ6rkbTM9Ya0EQwc4gzNxtYVGI7gXvjnylQWtSqhbXSHo2h7Vn1F5j4kUS
         zApyUh2NHWIFtFeFxQwFaMAT2GRa577sjyljifzIQxLYhTFHKDMPe87KLbaRMp1gkvmc
         lLrmJzDBaoDsHu6f8k6eKgsKpupBSmoKR2mrleAA6sVJk/b7RS+KrcG2KHs9Sup6t1KA
         30UA==
X-Gm-Message-State: ACgBeo0sEwYPACWmOtg6fH33xCF73cCt8XJDrU3kAiwV2T/FQB/K09qy
        47CekPV48RLEhNKqfk2AiNJfe2lwXqs=
X-Google-Smtp-Source: AA6agR5YlYHLMRl5/zbn2W6jih21GHLhLKnNrYTAo21HiBxzOG857iLSq1Zs2SWoylXTwj00jRbnRg==
X-Received: by 2002:a05:6808:1487:b0:344:ad43:fe30 with SMTP id e7-20020a056808148700b00344ad43fe30mr9227859oiw.258.1661851985772;
        Tue, 30 Aug 2022 02:33:05 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r18-20020a9d30d2000000b006370abdc976sm6982864otg.58.2022.08.30.02.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:33:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 50/51] zsh: remove version
Date:   Tue, 30 Aug 2022 04:31:37 -0500
Message-Id: <20220830093138.1581538-51-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doesn't seem to be useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 7d34522621..31bf88c1c5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -118,11 +118,6 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
-_git_zsh ()
-{
-	__gitcomp "v1.1"
-}
-
 __git_complete_command ()
 {
 	emulate -L zsh
-- 
2.37.2.351.g9bf691b78c.dirty

