Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D8C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC796102A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhHaNrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbhHaNrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:47:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D620EC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:46:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bt14so38897012ejb.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TGi1Dp/6LfAOvVypcRMyHAaZb1I0M08PFGiF2D+FSC8=;
        b=CS0IQIAHwP8Qm77vq6vk2d/Y5P7enAD4Yol+ynFC9P3qvFlqO2hS7yR9BMniC5eqVK
         FFEYRWQEAIH1G3hiSaLcbwKIjqzT+GaCTA+RIaMbUhcpMpTYYziOtN4yFM19WkKeSlTN
         Y75yHRGCgoBJ4IBp/M0fmckxWTO5LtPZOcGDjX34F/fPbA0GxNoB+sD0/ROMmq+ik0TJ
         pQ0mcwh6G8/P0rRiXKXOVbpe+akFzKVbS/leC1YmhMB1EiyPdG1ijj9g69POAweaBO1i
         GKlEjcmVBQyDFvVLw4jlDns/3LGIsJ61VCJQODmFppHn1sVSHbOKEIZaCM0um2ETBX/S
         j20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TGi1Dp/6LfAOvVypcRMyHAaZb1I0M08PFGiF2D+FSC8=;
        b=VzfozJEAsMIezAnMOMyNjL4Y3EM5L7skecnQ90nMhgVxXIXJyN8we3OvXp3SDYtkI8
         Zm5SSZNlOIg/0rzWxtUBskCqk1aU42HrsDsl5400d1d3nJirT1z6omSI1GdzFMjkUUXH
         iUFPARiTwt4K09D13SsVa2JmYVPADvL1sZXTy3mJW3yZmdcOl4uoBkFPO2HUERp6GAis
         frXEU94T7V5M5cUL2USmawPQQ3/sDG8gfAfHpPqx3L1iR2k/sNXX3XDeIVTvngPlDjyx
         3WuLLmq3wvCgkrmFIulnFYKpld+K2yTYRt3kLjQgsypobnZvyTb2Z2VMfrs+qmF/SQDm
         boSw==
X-Gm-Message-State: AOAM533UPFDX6xor+7op0HEMyWKSQS3mht98auOkCUsg8Nnf6MfOh5Ip
        saF/esnD+511FsEDRkBWj2fwqnrdCgD6U36Vcsu0s5lTTuEijE3s
X-Google-Smtp-Source: ABdhPJwQbhXD6q1VOzNZqShZukQ6D5bp8s8RPfUIRXc6xw8WvwirdwKNBIx6kb/JagixqwYRSRR0IQXFUR9CgNgw9rc=
X-Received: by 2002:a17:906:d0cd:: with SMTP id bq13mr31707697ejb.66.1630417614418;
 Tue, 31 Aug 2021 06:46:54 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Judas <snugar.i@gmail.com>
Date:   Tue, 31 Aug 2021 15:46:43 +0200
Message-ID: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
Subject: UX suggestion
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

first time posting here, I hope I'm doing it right.
I'd like to suggest a very minor UX improvement regarding the message:

error: The last gc run reported the following. Please correct the root cause
and remove /path/to/repo/.git/gc.log.

Currently, there is a dot after the file path, so it's impossible to
select just the path using double-click. If the dot was removed, or
separated from the path by a space, it would be slightly more
convenient :-)

Thank you

Jan Judas
