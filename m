Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722B61F462
	for <e@80x24.org>; Mon, 27 May 2019 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfE0T7Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 15:59:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43967 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0T7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 15:59:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so24802248edb.10
        for <git@vger.kernel.org>; Mon, 27 May 2019 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uaqy/QfX4G7X3IBqiSsKMHzM7bUykaJ9b0mtZkIcPEA=;
        b=J0OWuhB/NfOA+3fSRUq27X2cnjR81CE2gGwF/RgZK7paJVqlDKl7zmtquLjNOL2wA1
         HHQ2cv1yYGReN5XBQzcsuMjiz8ujcHtcMgp0ytevzerpBt6EnRTqwyq1nsbinOB/bISF
         zUGEkvmx25GzN7zJgRRagMya272B8drfgRmPyurbxMULsIXZ+sYQ3FSKI28Jk/E0+CX/
         78u3ILoLgE6/5oXcrwbKWcDs5pxRPB/KtpL1K9oqibsqHJlU1uvmcWt9TbGK4JTTNWXX
         NldrpyAPNSUK/TBVI9XGxd7BHPMcrpaKZ9I0uz0uDyHMrNjjxHAGzgqGUHYqTSa4xYJT
         58GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uaqy/QfX4G7X3IBqiSsKMHzM7bUykaJ9b0mtZkIcPEA=;
        b=jefja6ilm/o5mP51dmluAuYhzttQn6SqrQc+8sNpAwPcq4NQ70ENXAnqbMu7cE3vh1
         xCt6c2Db368qcLWxpbkd+M7jQmQKV/3SvOL4FDmeKqMR0FDUMHR9JG9B07YFsS6HMsvu
         xYeSSYmo46ClnizOrzHJZUvcbbj91po0Hrc29xUlOR11ea+S8u0jZAIWtXP24UiSpktq
         5E3cGWtpgFQ9mesa7D21Uor9yI9O0o1i8PW3Qb0tT54mM6ePqzHSnt7Eu/3zngt1jggR
         qqhiuCiuGPuiw+5rNQQ/NJs9Gb24M4GOF6O/ssOqRDv73Uz+O/oHmo1hgxDd6z4gl8Zz
         PUnQ==
X-Gm-Message-State: APjAAAXgI4YbOur7/Z5PEUldH9AVCAt0C2JHarUBslQZv6vnaeSqKw+B
        K+qw1KlcBZoKkKHMHMvzNbAdnQfY
X-Google-Smtp-Source: APXvYqxWYffOxlFPq8NKvxce5tFZ6gy3LTCWutsaagsUzHMfkO3+g3RTmKPJ7nabTlly5AZMgniNIw==
X-Received: by 2002:a17:906:24d8:: with SMTP id f24mr5617730ejb.1.1558987154064;
        Mon, 27 May 2019 12:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w53sm108866edc.6.2019.05.27.12.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:59:13 -0700 (PDT)
Date:   Mon, 27 May 2019 12:59:13 -0700 (PDT)
X-Google-Original-Date: Mon, 27 May 2019 19:59:11 GMT
Message-Id: <pull.226.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] bundle verify: improve the user experience when called without a .git/
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git bundle verify <bundle> command really needs access to a .git/ 
directory. But it did not make sure, instead erroring out with a BUG(),
making for a terrible user experience.

This patch fixes that.

Johannes Schindelin (1):
  bundle verify: error out if called without an object database

 bundle.c                | 3 +++
 t/t5607-clone-bundle.sh | 6 ++++++
 2 files changed, 9 insertions(+)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-226%2Fdscho%2Ffix-bundle-verify-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-226/dscho/fix-bundle-verify-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/226
-- 
gitgitgadget
