Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A438AC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 17:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBORRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBORRg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 12:17:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD83770C
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:17:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so2072634wmb.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ggyN+QIXsKZUDDey3uOrEoxYgN+zSTipnAPkT/rVMg=;
        b=MovBDqkowEUqnau2C61lloCSrcwhTiNVbZJnqTwbKasqDuv30p51hwflSHjL8PguV0
         6XqvChc70g4ZYb57ZFDjJf/AjyR7TSi1Dw3bMo8+S43DkLUWZEWdQ32pDa1kTblLe8MS
         FKzNwgiba56r9RSZLEk5UrmoA82vHS8x6IRXI1Ig+EJ77hkJbuBm9D7pNuvXgWEGesrC
         pTwA0EP/WJAVHRmDZO94dYPYiUW9sw/Sn4ePZVVmqWu/JSAprWr4nQrzsuJrWkcLD3vi
         9gOigRUZSIxIgvCASlOuFSJFGQbIux7pVT3q5H1xdacfTddhWvtu226FIe9QvILoYO3g
         MgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ggyN+QIXsKZUDDey3uOrEoxYgN+zSTipnAPkT/rVMg=;
        b=ELtT+lEgkDLzMG3uNyTP1sdw9ajGTmEhEFO7qq4S058cWmmyt1KLegowObWdOfGzPF
         gbB8uQoQXgXaoqTPaCGm6JcO8PzWxekoMkpfhjGXiMetxXjucEdz2QsCt9pktyL1zv3z
         Oa3CHR84Exg59o0vx0+epM1wga/pt0TIrjq5ZdSn87Kv8taWNrLVTzuZDnd7pX+ZmaD3
         gSxZEVnVXUFM4wVaRRW0eyeDVymdf5nq5A6+vHJmxdxjE4sZ8bvQbUjAkhTTHtzzGdXi
         7U0bi2ve10By/HaTy0NlAEdie1oTDVvG7PCWnQIoELZ4fjTu4eawLpRmLhLGiXRFqqu0
         NPGA==
X-Gm-Message-State: AO0yUKXh/+C40UiTqzG9SMed44VTSxaroL016WmmTVh50dTk/8z5YfrG
        I/ftciSAG7wqLpH954/AKdYrQweV0QOjidjc8BWBCPhogFZyHw==
X-Google-Smtp-Source: AK7set/4/zG+IzlJ44MKEWxHOhUTgcv/UuEbKF46IDaBq0j4zsZRf8A9tCciwShu5NIXNkb2yP4dy/vDBynG2wKBu7I=
X-Received: by 2002:a05:600c:1908:b0:3dc:5614:91a7 with SMTP id
 j8-20020a05600c190800b003dc561491a7mr12343wmq.104.1676481447130; Wed, 15 Feb
 2023 09:17:27 -0800 (PST)
MIME-Version: 1.0
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Wed, 15 Feb 2023 12:17:14 -0500
Message-ID: <CAMO4yUECbDFD3OxGU2u5QQzXYbej-N+=-=ODjskO12MXmFdYUA@mail.gmail.com>
Subject: Re:[PATCH 1/1] [gsoc][patch] trace.c, git.c: removed unnecessary
 parameter to trace_repo_setup
To:     git@vger.kernel.org, 20230215104246.8919-2-mcsm224@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello  Idriss,

I have some suggestions=EF=BC=9A

Seen like you didn't describe the existing problem and how you fix it
in the commit message. You can start with a description of the
existing problem in the present tense in your commit message. Also,
you should use the imperative mood to describe the change you make.

Maybe you can write something like the below in your commit message
after you use git commit -s.
---------------------------------------------------------------------------=
-------------
trace.c, git.c: removed unnecessary parameter to trace_repo_setup

your description of the existing problem.............

Fix them.

Signed-off-by: ...
---------------------------------------------------------------------------=
----------------





Regards,
Shuqi
