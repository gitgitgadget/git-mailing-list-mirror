Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F020C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 04:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiHUEih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 00:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHUEif (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 00:38:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E2DFB9
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:38:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso6025196wma.2
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=s/h/JpRkG1ihnP0RX+ZzwtNr4J9Y/039VHJVKEyfUYQ=;
        b=YK8u7J/vEU+OJeYKhCaDEYSAQsXzFm5RKAEg7Fw2ydVX1hkDpGFVZqtQy9u9oLN2//
         qbrIYTgKa2GTkIJlih809haLq6Nn1nEI3ijIDkfZiG/kANnfegUJgC17IeWxYDkl6fPf
         obg690ITStsP+Yb7X75FaqSxm60uK3JtYT0i0Q3wfhCr3VvFba/2ghCr5VccL4B4QfVX
         a80OoM84ivp0hf2K45Y0wn9wH0s5VYMa1HEHIIvrPuqtCg/S/BSb6O+UOKIwCuqs55AP
         BK1RIJrpAVaEm8eMdbr2RAOcBt5jWIjF4AMLs0tZvUOxW3DLjn781RtCW3kICB89jrAY
         u/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=s/h/JpRkG1ihnP0RX+ZzwtNr4J9Y/039VHJVKEyfUYQ=;
        b=qKRFgGxq22kRT+vU1T7PFu7nkpKPR/4QVBlpocX3UIFxN9DXu0YHniEuCiG1xkzF7Q
         KT+40qh7b54Q2MNCha7vlMjQrUXPouXz8zAbhRLuyL4uGFpTeVoooxaMvyYk1sLd9Xsi
         usK2iQY/XGIpNuH5KT7U12m2nfd+NHsf4LMoytbum7TqIOAYkl5wEH1z4uz1mG9Rt45l
         YSuDnBQMCRAzGdcYKmhsvMAMHY8ngiGhZCJxvCTG4BnBwSVzQOa0pPN1Yd174WsyD1KV
         lCO8nVmAVBr31+enoJ94voQBYnABLMMZi/FEYYcrIQXuErnidVdIPntitErJsbvoXKau
         Q8sA==
X-Gm-Message-State: ACgBeo1VStflX/tWjgs9NH7fEzLDh0S0lG+NuwTLLGPTwaYA1VPwKxf2
        +xVvKTu0hJuWLqqXphFMOufdsplpmkE=
X-Google-Smtp-Source: AA6agR70AKF+aMJ1c9XrkgmOO6SABCgzefPIYU54pNiybD7ifdXmx1pcbgWADblVBW7l5ZIoSg25Gg==
X-Received: by 2002:a7b:cd0f:0:b0:3a5:ec59:daf0 with SMTP id f15-20020a7bcd0f000000b003a5ec59daf0mr11634704wmj.13.1661056710983;
        Sat, 20 Aug 2022 21:38:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a056000108600b002250c35826dsm8037502wrw.104.2022.08.20.21.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 21:38:30 -0700 (PDT)
Message-Id: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Aug 2022 04:38:27 +0000
Subject: [PATCH 0/2] Miscellaneous merge fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on other things, I noticed a few miscellaneous issues in
builtin/merge.c. Here's a few small fixes to address them.

Elijah Newren (2):
  merge: only apply autostash when appropriate
  merge: avoid searching for strategies with fewer than 0 conflicts

 builtin/merge.c  | 19 ++++++++++++++-----
 t/t7600-merge.sh |  9 +++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)


base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1331%2Fnewren%2Fmisc-merge-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1331/newren/misc-merge-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1331
-- 
gitgitgadget
