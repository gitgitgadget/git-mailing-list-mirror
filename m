Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D69C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356541AbiASRvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiASRvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:51:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C76C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:51:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so15935427wmo.5
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ye9jRuSlKtRfyGhmgugg+xN/v6Pdkenl8j0M8NsMbUU=;
        b=KtrlQai0lpQKvBMqWhi1JAZk9Co6CSjKTE8ckh0zyRmX8zM13745MuDBXfu8lh2BRG
         gOvG4UX+J/2C28lZOnisYpz9c4UXaT7ySxPQxRXDjfm3/psN0QMHaa6e+qOzOihmTBfC
         JPh4g3GFha1jfiwm5x+1lPQh9AlJZLT5FH8eoct7HJV/1TZa6/N/S5sUbUjZhgDzl4Mj
         QZen586K8wn/vz5foPNQtg5x9qIyLbof01rw7nkOFwdOIxFdiTnzags28rP77n4ZN+fY
         h3aYunLXcXNPD3esZhddlgcTi1WZSew3MmMHp1HLTeIuogtVphazUNCYHrsdqvxBYBZh
         0VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ye9jRuSlKtRfyGhmgugg+xN/v6Pdkenl8j0M8NsMbUU=;
        b=Y6TBBkeHLrf+GVwvSeIkp22xrvG87FPmnAnCRZgTO+sVOTuSK7FIyCsm8uGbsbowqU
         2kCFif2Q171zwKTiGRuh+Gt9yADITa8j5+UfiMDNBouyL+WJfq+CP9gJ/s38duSlkSlh
         DepGAIIcP83V59NK9EQSto6s/gU3ntl37g+qpZQW4c6y5aoD1iIGNsucQXc0tCpfHPk1
         uwBU02ekUD8HAVwtv9ZGmX4RAOUfcasKh711fG0Lzg8ftOyu9n5/fXdfXZbgl8CXTkdu
         TbmSLXT8tKEonQXuHVJFhrenkjejO83G+ckg2+Rtszk9HY9wumrbP+ocZ90xlKtgsbXB
         yytw==
X-Gm-Message-State: AOAM530dLz4VyOhX31FmAys/g+8NBOlXl14YhBOAMBxSOTEr6SfqoIT1
        izrkzJT8TXebVS3Q1GrfLJxCq+XZ6Hp/e2bnxVEsIyUdojIr+w==
X-Google-Smtp-Source: ABdhPJwhRC5nrfPg2X5/wa6Vit83yBHj1dxhHvzw6cC7sW+9IOjmUALVdPKPVSYWDDCscODG9skgw1bS7e0kc8NJrAA=
X-Received: by 2002:a05:600c:3482:: with SMTP id a2mr4707112wmq.152.1642614705306;
 Wed, 19 Jan 2022 09:51:45 -0800 (PST)
MIME-Version: 1.0
From:   Frederic Tessier <ftessier@gmail.com>
Date:   Wed, 19 Jan 2022 12:51:34 -0500
Message-ID: <CAB7QKarvGGjNf-bvuKqwnAVT_wX_=J+Dh0-AEdKPdVMbkSzW3Q@mail.gmail.com>
Subject: Dangling copyright in git hook template
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git init

What did you expect to happen? (Expected behavior)
New repo initialized containing no copyright claims

What happened instead? (Actual behavior)
New repo initialized with a copyright claim in .git/hooks/pre-rebase.sample:
# Copyright (c) 2006, 2008 Junio C Hamano

What's different between what you expected and what actually happened?
There is a file in the fresh repo (copied from the template file
git-core/templates/hooks/pre-rebase.sample) which contains a copyright
statement, moreover without any licence to use the file.

Anything else you want to add:
This also happens upon running the 'git clone' command. This is an issue
because when users clone a project, they are left with a copyrighted dependency
(without any licence), even though the repository itself did not contain that
file. This occurs tacitly, and users would be unknowingly violating the
copyright if they happened to further convey the file.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.34.1

[Enabled Hooks]
