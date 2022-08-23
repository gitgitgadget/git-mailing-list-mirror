Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C4C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiHWTvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiHWTvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:51:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9CB7CF
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:55:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso8224790wmr.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=VX6kP6TGAL7h3XyZhahFNxo4ROs5yYx3sQnRdZpZPto=;
        b=TPjHeId+EzraVTvDSzuxxwNGJi5CiBqkoThdkjvAMwmNKVEYrmPcIuoUOgha7QjWCP
         b3c5bXOfXiWu3FcupXGq9RKMVbymmuZcJ7apPy0fWB/Eq/HwpwCKmIl3xhwHjfiOpdGh
         +kLaMnDg/a5rwPSB9l27oGeEkhs7FjzP/LJWh8cHd32h/g4ccHg4oFjLOkX1r99Rg6Fv
         1mZze8fIIvd0qSV4GIocIoc7c54CcoFyI0BJF1EGAKSzu9SBD8ylCmsLZKzsMjYhAp8H
         SXmN+DIr1KbP9AuBL84nAwyWG7xWT/APNKOby4U+/vORbvGShB2Zeu+uOVaJur9vNLVS
         gVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=VX6kP6TGAL7h3XyZhahFNxo4ROs5yYx3sQnRdZpZPto=;
        b=TtmLgjmpR8MmUySYDqc4dKAOgMLxHOlGLrliuH+dMiQy4eMKis82npnconvOFmP41r
         hqD4+A0qzicpE5P0s3XV7Ev2rfzWLLQknQfB2qOZ2CCOazfW/92Oag3R4dmQQcUYXJ/k
         +WHxRgs6Vip8W/LH3F6RlepvRLEKO6dKsnb1yTMB6txPsCasTBzL/HJO9MWRRH/o2a3b
         yKYknOEh1fuGzXyNQUlVREjSOrgoWlp36pfSlNKUoc54UOel7xb4SaHxgzWl1LKYovM0
         DzwECaQa2voM9D6iUYlpyGTio0+21balwBmvmcIEyL2ksg+uTnsuxifbYoAylkSiEgnA
         +VRQ==
X-Gm-Message-State: ACgBeo0VD42nt3dgObw431m5Qog9uNiCDlJwhK4O0wsDHNHFPYfMOgjb
        uZyVmD9gNygn5aE7P+yrWuVHrSU4SMI=
X-Google-Smtp-Source: AA6agR7Jt8ne/LbH4el/ALfrPmB+pXxxqJkOySIUKFmt5jMi64V9n4TDQpK3sq6rpssSAUsY3AuqXw==
X-Received: by 2002:a05:600c:350:b0:3a5:3473:1c23 with SMTP id u16-20020a05600c035000b003a534731c23mr3129583wmd.9.1661280942326;
        Tue, 23 Aug 2022 11:55:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26-20020a1c541a000000b003a64f684704sm11799716wmb.40.2022.08.23.11.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:55:41 -0700 (PDT)
Message-Id: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
References: <pull.1326.v2.git.1661259820.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:55:39 +0000
Subject: [PATCH v3 0/2] fsmonitor: option to allow fsmonitor to run against network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc: Johannes Schindelin Johannes.Schindelin@gmx.de cc: Jeff Hostetler
git@jeffhostetler.com cc: Eric Sunshine sunshine@sunshineco.com cc: Torsten
Bögershausen tboegi@web.de

Eric DeCosta (1):
  fsmonitor: macOS: allow fsmonitor to run against network-mounted repos

edecosta (1):
  Check working directory and Unix domain socket file for compatability

 compat/fsmonitor/fsm-settings-darwin.c | 72 +++++++++++++++++++-------
 fsmonitor-ipc.c                        | 40 ++++++++++++--
 fsmonitor-ipc.h                        |  6 +++
 fsmonitor-settings.c                   | 67 +++++++++++++++++++++++-
 fsmonitor-settings.h                   |  4 ++
 5 files changed, 164 insertions(+), 25 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v2:

 1:  40ce21e85c9 < -:  ----------- fsmonitor: option to allow fsmonitor to run against network-mounted repos
 2:  46b4efd96cc = 1:  cd16d8bb3d6 fsmonitor: macOS: allow fsmonitor to run against network-mounted repos
 3:  9b128a98149 = 2:  f977d140afa Check working directory and Unix domain socket file for compatability
 4:  15c965801f8 < -:  ----------- Minor refactoring and simplification of Windows settings checks

-- 
gitgitgadget
