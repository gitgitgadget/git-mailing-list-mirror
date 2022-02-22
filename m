Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C22C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiBVKe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiBVKeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:34:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B624C15B3E9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:33:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so32191319wra.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6Lwd9TmQkHgtuyVj0Z7okVM0xaLeMfR8AFo2dR4I7f4=;
        b=ZvGB3WmIX7jesLgqBUUXVCtoldn1M4Tbs5Ry5cMPJk1bJVI3WcTBlSM28ShdgPtju8
         rkuCOWoxGRZZ34gtwtson58Hu2MVo3wXsHmw3Vxoc214NQnqLQmjkSNY79/SU9ugxSSm
         tv69YMAJ4YLmKQMYtKKOHw6pPJGnof+fzv+fE6FFUeeikQumHWnVGyt1e/UF/gX0nbBa
         uhsfW0lFtAlxy6H9GZLrig3T6osLDVis+xIQdQDgn4LWxU5rGNLNNoA/LJ/bl52ldREl
         ZP7EW1dhdsRsShsvbdxGLDpeNEtOx7NZZUKwhYuqAUHKp1JpBhtfu81EGu3cruies5Yq
         4Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Lwd9TmQkHgtuyVj0Z7okVM0xaLeMfR8AFo2dR4I7f4=;
        b=H8aQJ++uAq4RPNtvr53p1DEupERnVZ/gFHTsWoJt6s2d0UCA75xQDLb4GIVsOJO38s
         7xGkcq9nNE/j8vOOo3IhsR7gFSwiIHar7JESlrabumY40fz/Sy9M/6So0u/I+k4thDwj
         FYLTlFwRwe3wpW+WaxOCAzIzG+7hW5rAfQD7h4uCVvEYtwGe2sfr5l8uwusjJf5uCxqI
         CQaktSGWfMMEiyaPo3m4EP1c/ZHVvl+IGM/IqF0jkUB76fa8mdzYLv0i6INjvGSRmTvz
         /ySN/CxRQ1gMi7gpyj//SFd4SL8zM+tgd65JTFZHIRTC+pGL/uf+ZLONoMZgsVtAkSQz
         T1FA==
X-Gm-Message-State: AOAM532ROC/XcCnYu5LiV1MNgZU5T28T//1qv6oi1vWiGaWQpiWbgbtu
        ZgV6F82SCZmf7xBGHE55LAnjwXzFoS8=
X-Google-Smtp-Source: ABdhPJwO0xemklJRLlk6uhN/QxuozlD1V3IWxM1gRiJ5Z41TNt3EtZG7G9CfNOmd00/MWvHTHjVmwA==
X-Received: by 2002:adf:cd0c:0:b0:1e3:3910:ac1e with SMTP id w12-20020adfcd0c000000b001e33910ac1emr18671908wrm.436.1645526018045;
        Tue, 22 Feb 2022 02:33:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c26c800b0037bec3c03c9sm3746815wmv.2.2022.02.22.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:33:37 -0800 (PST)
Message-Id: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 10:33:34 +0000
Subject: [PATCH 0/2] Update the die() preserve-merges messages to help some users
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small update to the die() preserve-merges messages is a response to the
reported edge case in the Git-for-Windows googlegroups thread
[https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM] where even git
rebase --continue would die.

It is most relevant for Windows because Visual Studio still offers the
option to run git pull --preserve, therefore Git for Windows already applied
these patches. The improvements are not specific to Windows, though, and
should therefore also get into core Git, albeit at a more leisurely pace.

This is a companion patch series to
https://github.com/git-for-windows/git/pull/3708

Philip Oakley (2):
  rebase: help user when dying with preserve-merges`
  rebase: `preserve` is also a pull option, tell dying users

 builtin/rebase.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1155%2Fdscho%2Fdie_preserve-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1155/dscho/die_preserve-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1155
-- 
gitgitgadget
