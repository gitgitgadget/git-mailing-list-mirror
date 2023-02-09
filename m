Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B57C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 10:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBIKED (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIKEC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 05:04:02 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6871227BB
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 02:04:01 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l3so1457519ljo.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n5hNWlCfRGmHMyEtfLe2q7Akmi1GflAG1XFnu37/f4E=;
        b=RPyp8pAAytDH/KWzZG8lOXOU7c1SMRaVMQkwiO4lr9jaACcWi+8D5L9G+efcfk1+2B
         VjPDF7l2p4pphSrN3MHvHTrxUSSfR7PWC33K0l4G//kLR5up1nJvEg53KfvsxB0vD/5I
         CEyGUUApSOHVozIF/h53e5irB/aBuiwZtpoZy0vtwQQGAFxXJ3vfk7QubCiZkyoB9Yby
         Qa86nWWH2PSoJxbesk2KuwSF13tjtktHjh0gMy0tXYycUihIWq424pngon6+RZzPFDf9
         JzFma52PxvASufSlUnuf69uimWITQdJzmbCiAEr6R7IF5w5QQ9h9sFW/iBkAFG4YTKzI
         nzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5hNWlCfRGmHMyEtfLe2q7Akmi1GflAG1XFnu37/f4E=;
        b=2xHBfHhmck/pOXL7UjOfYhYzHb8Ztp4Zit7RdUTbGdbJHDol5aAUylE1eqOWu7tuxy
         geYlwPEq4w0fq2965bnmQeBn9xfZWuq+aLNNB25VjM0JOb0aq2eTBGmpFXSJWIuvqy+g
         n/MRviEk4r4ZnoqkG+PLY5GBUfOC0l9ysynbjHrV7bS/qGvw2yLkF/QbhJ+uaIL0O8Rx
         1Zdyr/xysOpJiL1ZpqWYrx8qsqy5QLUfYja4uPy1PhjtvsCUedu10HZjy/X9/Lx360nb
         NhWqItyBFfl/VuymhAvtK3IslkinuVRwu4SqTxyI73K8tFBqXnrWL8rdlFYhSGHPYW4u
         CjTA==
X-Gm-Message-State: AO0yUKUwa5+tMUvtQ814TaxZArw+2aFYef/+joJXjWWq6NWZdeQK8KgY
        ISwYHiz9D58GatJzO72nOLW2t9JPYpBygG2RH4yzaEo9
X-Google-Smtp-Source: AK7set8Rsa/2J6YvoSfTxIHbwczyXVDHM76X/ikHVRZE7JebYl3tsWOsGzTMe+DWXfccOj/c/4kF1oG1EMMtv85FOL4=
X-Received: by 2002:a05:651c:49a:b0:290:637f:c6d6 with SMTP id
 s26-20020a05651c049a00b00290637fc6d6mr1776440ljc.132.1675937039444; Thu, 09
 Feb 2023 02:03:59 -0800 (PST)
MIME-Version: 1.0
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Thu, 9 Feb 2023 15:33:48 +0530
Message-ID: <CADE8Narm5asbx_bdgT=Q_e1CiHUQqFSo3F2cWrataqq3O9YuKQ@mail.gmail.com>
Subject: Doubt about skipped commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!
I am a new git contributor, and was reading through the source code.
I want to implement a small check that prevents an interactive rebase
from proceeding with a fixup in case the last commit did not apply
cleanly, in which case the fixup could amend the wrong commit.

I am doubtful about how to check for missing/skipped commits in
rebase-interactive.c .
Could anyone provide guidance?

Thanks a lot!
Vinayak
