Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E421F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfJaUlu (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:41:50 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:55029 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJaUlt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 16:41:49 -0400
Received: by mail-wm1-f44.google.com with SMTP id c12so2821646wml.4
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=y0mYp4wOJsmohdAWYP2XP7FiumZU78TXl/B/Ue8fvPw=;
        b=MZOTDxYe7PsTJslGzHVkYt56r51Mzeky5k90XllRLubSfvmUYhsFcTiamyHrqMrPFc
         /zyMQHxpmIHrDpU6ld1qnso2eegFxzxX3GlcfQ+nT0iFEErLb2WxDeupeK0qt3D8v4uP
         a+gYwWZEh9+BtR4hmY2HnQDlzBilRnO0wY2oV9OW9dulgnrhDKneLFBLk2LkyytGYpe8
         Ls3odpTRApIlWxvQgaILRykayfi36RVNJX5u8j4qFC7toCXODtBjZHZ5NBoHHM3DRPsh
         jHD9rrMXeZ08fp1/CEUXT97+pFsALfKgVEjZszYfWocUcWC1j5iUklp2k/isCqLPGrg9
         5R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y0mYp4wOJsmohdAWYP2XP7FiumZU78TXl/B/Ue8fvPw=;
        b=TXB4pXPMMP9nIJPoMfzJJ48PuGKlUV5kJW1+BWOR3HhFXKZyStgttPLkfjoDSzzvbK
         EuvpsBWyxV4GVIjXL71yoUwEc+IQf/IRdES8d7bYISEmfGLic6a+ttnSFNT+Cd1rGD2S
         yRgJZwDkjSz2Hg8fbSMKerG2radh8IghfH7oTVASo/d8/07m2qAXXc6pgIHN0yhVDl/g
         7SucDHDx+VRwesffkrCVXVdqK+KXV95I402X87OJlR2Xf54d88ljDT8P7DVqyimdo1IO
         NGWUQarBtWpmDXq3jwoPPHyqBdtxWsP6m7PEEIKoed/vOPSxVPA6Dtz8pJn+J/uL/If3
         y4pg==
X-Gm-Message-State: APjAAAWskurE7BXtLnYEa8GKeKH1EckCnIh+rxe+f+ZvAmohIEBAMvEu
        M0zJSIJhaDPWAV6zT8JFok4WL/Uc
X-Google-Smtp-Source: APXvYqxXT2krgeIMEfuV6mDqguXHimMTuslLvq2d5cE1aCMdJ2biCuKoNnWN9efg+oMgKkBEc1gz/w==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr7384026wma.81.1572554507514;
        Thu, 31 Oct 2019 13:41:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm5733891wrv.17.2019.10.31.13.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 13:41:46 -0700 (PDT)
Message-Id: <pull.441.git.1572554506.gitgitgadget@gmail.com>
From:   "Ralf Thielow via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Oct 2019 20:41:45 +0000
Subject: [PATCH 0/1] fetch.c: fix typo in a warning message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noticed this while reviewing German translation.

Cc: Matthias Rüster matthias.ruester@gmail.com [matthias.ruester@gmail.com]

Ralf Thielow (1):
  fetch.c: fix typo in a warning message

 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: f21f8f5d35b09ecdd1a0112f114436fd2eda7df2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-441%2Fralfth%2Ffetch-fix-warning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-441/ralfth/fetch-fix-warning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/441
-- 
gitgitgadget
