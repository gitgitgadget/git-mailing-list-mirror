Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FDEC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiCaRVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiCaRVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 13:21:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90551168C8
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 10:19:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso66430pjb.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2He+YQ/Ih06iniJDw1iPGeKxKtItXe9bervss52cW1c=;
        b=OtNYP+JddwiNKKQElJhJnoiAeJj74TCyuvixRnLplN15n8FkLhH8It0BfwoBJNJHvh
         jQ1DLk+SZBLajsAdd7Mgezi5CUF/xM73vSQTKbMjh1N54Vt54bs4nWFzILgEx0U/e5bm
         Hsu957rgqXQraZM9V+XGiUTcegFKYzN5eXBtcKv/6qWa6VnvC7jPGbMVI1k5Fd0ewrc3
         kPXjoL51PGlS/SiLR8XbRIWqThLP3cJKOShorqsz7XLludov32aGpG/8XI6jQU5XvBr2
         8eg6txCJrqT4zsdm/gf3Efi1lpszCpPNF9KfksF/jc5JWXHmSFwNJ5cKMYLGU1Q5YwtH
         zaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2He+YQ/Ih06iniJDw1iPGeKxKtItXe9bervss52cW1c=;
        b=kIK9Kyq5c+qrnFUOiMM47fjrJnqOQzp0PZY12xd0h+LlrQEjyMfxn3aIvb/9btHBsV
         x4FdxYyuAsoIyvLW85IOhTpAaiIrOpm+M9MxvPlEBjHbupIzP94FBOiU3BKtGsbIO5/e
         omgcQ3syzJmE3Cti7f9ct7bMOaq8LN2BLH1SObnck1rUrwxkeFEugLmjFAOiLFOvbH1j
         U4RRYezfE5Uu9B+7M47AcmCv0q955Xzujn6dW8tUfKEk/JnB5Jc+bPhTzpPsERvoGvuo
         Z0nVDDqV4BFMr4srwAzaylVTYhOtLh0EE5XRgRo92mxwic9oyluu1m/ctgs11ABKb36Z
         J+og==
X-Gm-Message-State: AOAM530hDW8oa95H4Nla+KwfHsa8RfqZOzRkuHgh5v8zfKsY/S5pM+0C
        nQ3osa+FZsA13u1uAMGW+HRlV/lr43052sCvqo6+64W0kC4=
X-Google-Smtp-Source: ABdhPJw9VwOUJsF4y8UZSJhFun9Ez7NNZdjJkMjCqG2exEMZMRYX4bC1jZkezoem2XcbK4v7bIpOSbpddGA3kf1wH8g=
X-Received: by 2002:a17:90b:4a92:b0:1c7:5aa4:2a74 with SMTP id
 lp18-20020a17090b4a9200b001c75aa42a74mr7252835pjb.239.1648747187950; Thu, 31
 Mar 2022 10:19:47 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 31 Mar 2022 19:19:36 +0200
Message-ID: <CAP8UFD3epdwdB7ri02mCt2m-AF9-mq-RaSZoPLwDOqX+nOcM0Q@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 85
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 85th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2022/03/31/edition-85/

Thanks a lot to Victoria Dye and Bruno Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/568
