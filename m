Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538D220248
	for <e@80x24.org>; Thu,  7 Mar 2019 09:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGJfm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:35:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44132 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJfm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:35:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so12827763edw.11
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RwsftGvTcxYF/ckAyodtuzWfsi4wwnr0IOwO7YY0K/0=;
        b=aRmgyQ/dbTbmMPKEgOEP2EPe/9afWy0YdNexUUTWb4ecVvWQ63+pTOV9cuQMKCSUC/
         d74Vx1BGTyQIEE6ojKC2IQ5kr7WZ+DocW3jdVHMtiym7PaPJAkycgzcvidKhIpHV8nTy
         tB5+5lFSon4ogFZ+oduSNAT6GFm/zekpmcDUcxyoPlAq7IDaq9nHfYMOHYX8mhFE02pv
         qNMctmJeDkPOA8tXYbxd5mOS1+eyUxpvL0IxSc6YuNU9PqRWvsfFvc5tgeun5mNjdRfm
         IrUrfRKxvjh9bkmFMQXJtY80C/rVa3k8R0Tmei9QGQpq/u97Lmo12J1UAe1j9XON802g
         opqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RwsftGvTcxYF/ckAyodtuzWfsi4wwnr0IOwO7YY0K/0=;
        b=lAjk9wZqCrCOS9JbhYThVzeNjptkKcZtCTCsCjJd27VswuX9cIKZI+BlB03NUrjtTC
         bAu3tALZm4z7pn5DctAD4tvoO4JNVajy2tfM5CQdph9KXarHAItZ7m3PBgzSii9c9wSS
         wyJnyVIkfORZrB1eBaXC/W4NHnE5gAti5/wkwMWB7TywpiwjAmnTOaDf1ExdIsVRReow
         l5hN+wr0GoetLtLaiZCSiAkMeo0i7m4cvJLx6TKSF+LzJ6obR3urjf05OwOsCYxErOE6
         ikMhup+MWvc4AztDpdlBIdI2KXpJwypmZf66ZpAadIQXWsNv8Shir0EtVgPeAcTVc/CX
         oTpw==
X-Gm-Message-State: APjAAAX15Frnnl7pjOH64DN0RHFyPVGMDjfDIsv4KPj/lRsoKf0Z0IyX
        bJslH5S4kfz+KRHWrdu1Peo/RZk0
X-Google-Smtp-Source: APXvYqzxB074qfgGUMQDSsnk66qjzXnBIpcYSSFPhOnWm0eFx4fpd9t3kkJ5YWD7Qvxu+VSWPKxPHQ==
X-Received: by 2002:a17:906:48c:: with SMTP id f12mr7146620eja.244.1551951340476;
        Thu, 07 Mar 2019 01:35:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j54sm1201196eda.38.2019.03.07.01.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:35:40 -0800 (PST)
Date:   Thu, 07 Mar 2019 01:35:40 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 09:35:38 GMT
Message-Id: <pull.131.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix git init with core.hidedotfiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes an regression that was not present in Git for Windows's original 
core.hideDotFiles patch, but in the shape of the core.hideDotFiles patch
that made it into git.git.

We fixed it in one big hurry in Git for Windows, and I simply forgot to
upstream this right away.

Johannes Schindelin (1):
  mingw: respect core.hidedotfiles = false in git-init again

 builtin/init-db.c |  6 ++++++
 t/t0001-init.sh   | 12 ++++++++++++
 2 files changed, 18 insertions(+)


base-commit: 39ffebd23b1ef6830bf86043ef0b5c069d9299a9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-131%2Fdscho%2Funhidden-git-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-131/dscho/unhidden-git-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/131
-- 
gitgitgadget
