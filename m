Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460E3C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 03:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjBBDvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 22:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBDvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 22:51:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4377BE61
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 19:51:41 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so404336wmo.5
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 19:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOT3ko76SqGiCFPJ4mG3QZCPVTIq3QEw/v1P6Q1C80U=;
        b=gaVyzoFoScYWkdablQPJzRTPMtoppeehodFZ1E+ZnVQrV7NgvEWJMkQ8ITe8W/NhNA
         DSbowceJ130DJIskN4OlNJfAijr3ROuSOSdsQ65Ergma4zgQ9wWNHxLqqc8xQ8GINszx
         g5iv6RMgGy6N2uIxL5DXoBG1mqjB3JGmfayw+gr91FiZEuyCEFrOf/A72ZqO7RU2Prz7
         tFszkLDl+e1rrpfaGtDt595gey33jtvb+60DENlvsvQePJt7Ut+muj9a/noU/uq+wOpO
         Se7Or6KCsfOb8H2b2attvrg9W4eN9b5jivG+4S0gFgRP8SX6amOlTolv9veQI/a8RcJK
         pdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOT3ko76SqGiCFPJ4mG3QZCPVTIq3QEw/v1P6Q1C80U=;
        b=4Z2w3G+tT7EpXSgO0pZy7buK6OFA+GO698iaVhSZR2xbzuzOJZp95VOj/WBXOHiiRk
         +MSJii2BOan3slOxB+nDrDK/gKAwH6mUVC/Bu8ElE9XCq7y6zqEFjexpKPqXvNXE5zRU
         YF7f4F9ow3VYFMf7erZWQ3FypHvFa1MZdc1Mjpmxmil43FenhQT08SGYvBA3TNYt3SmS
         6aZWmu89hXnC+vn5ub9L+G5FK88HWuRJnI0VyQkCg7elQ1oAv/2JDWqvM0ruK+Q0FeV1
         CrpkeRxaCUm5cDt3IzAflU3Xx/8qLi6gH8YLk93E54IdWtLZ/dzCVDnMd0MTtnv/ASuE
         HSGQ==
X-Gm-Message-State: AO0yUKWp5EV/PLrwMlafjG/Zy7nMKo8hEH9mzfCimW4eONJKT9bkkIf1
        KNKuQlHXKO7oQVWOYwHMWQWp8bFc8Nc=
X-Google-Smtp-Source: AK7set8W6lQEoJF5/qKsGysmQBQ79MPQSzuosi4MxUui78fwBtkP+D4JjdgzAYp62c2cOTTmmACvyA==
X-Received: by 2002:a7b:cd17:0:b0:3db:14d0:65be with SMTP id f23-20020a7bcd17000000b003db14d065bemr4182316wmj.34.1675309899468;
        Wed, 01 Feb 2023 19:51:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003dc434b39c2sm3567031wmq.26.2023.02.01.19.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 19:51:38 -0800 (PST)
Message-Id: <pull.1433.v2.git.1675309898.gitgitgadget@gmail.com>
In-Reply-To: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
From:   "Harshil Jani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 03:51:36 +0000
Subject: [PATCH v2 0/2] Remove MSys Support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Harshil Jani <harshiljani2002@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am trying to learn more about the git code base and came across the issue
where the support of MSys environment was to be dropped. This patch is my
first contribution towards it.

The msysGit and the MSys v1.x has been dropped into this patch and the
USE_NED_ALLOCATOR variable was duplicated here in the implementation so its
deduplication was also made in this patch.

Signed-off-by: Harshil-Jani harshiljani2002@gmail.com

Harshil-Jani (2):
  mingw: remove duplicate `USE_NED_ALLOCATOR` directive
  mingw: remove msysGit/MSYS1 support

 config.mak.uname | 86 ++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 51 deletions(-)


base-commit: 35a62bb5798092d491e6c7e688db6cb1418c9098
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1433%2FHarshil-Jani%2Fdrop-Msys-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1433/Harshil-Jani/drop-Msys-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1433

Range-diff vs v1:

 1:  bc79dfcc4d4 = 1:  bc79dfcc4d4 mingw: remove duplicate `USE_NED_ALLOCATOR` directive
 2:  e6d3d280a4f ! 2:  0c0289343fb mingw: remove msysGit/MSYS1 support
     @@ Metadata
       ## Commit message ##
          mingw: remove msysGit/MSYS1 support
      
     -    The msysGit (i.e. Git for Windows 1.x' SDK) is no longer used and the
     -    last known user for MSys1 + MinGW has switched to MSys2. So there was no
     -    reason to keep the msysGit/MSys1 config section. This Patch intends to
     -    remove the support of both the builds and throw an error on
     -    execution.
     -
     -    The output of `uname -r` if returns us with '1.' then it relates with MSys1
     -    build environment and msysGit which we don't want to continue ahead and thus
     -    an error can be expected.
     -
     -    The MSYS2 is currently used into the MinGW so we can get that part
     -    running directly without any conditionals required.
     +    MSys has long fallen behind MSYS2 in features like Unicode or
     +    x86_64 support or even security bug fixes, and is therefore no
     +    longer used by anyone in the Git developer community. The Git for
     +    Windows project itself started switching from MSys to MSYS2 early
     +    in 2015, i.e. about eight years ago. Let's drop supporting MSys as
     +    a development platform.
      
          Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>
      

-- 
gitgitgadget
