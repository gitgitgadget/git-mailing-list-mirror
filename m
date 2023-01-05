Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A900C3DA7A
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 15:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjAEPoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjAEPoi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 10:44:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583645C90A
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 07:44:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2458863wmb.1
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByCksbdp9PUv1gQbSnEFFDIr6hBi3BDm7Ci2u4R6QhE=;
        b=NOj1PiacinyuqEkn/Hw/Q2J7Ylu/8dn8McuM+GQ6xzMK0qTfQ3kaTlkHCx4uMYQQz7
         lhyxKBxGDp0yAQ5rqhsx/MXAWFQnrWVBtIIYeFN5Z76GJb1g8xyP9JLWoDXu83VwjLkk
         BOG/lonJ+7LeCw2jo3i86cuELhwz/RyvgFNDrzEP5NsmuxReziaE+l27/tUGHn38KJQf
         HWZ4Jsea/S07IxAO+HeZdmqVFxW7fHJRmVmlsWlAOaPnqVJB45gz3MGHCbB07YiFk40t
         SJGqVWMDV40YQ0DVEjmTjdnJOKV5CuR1vDZeXX2mi9BlBnadoph9ljSHsqTDrJK+JeU4
         8BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByCksbdp9PUv1gQbSnEFFDIr6hBi3BDm7Ci2u4R6QhE=;
        b=7bHILsteFhi5e63xL5/St4u5bQdfCd7G22sDhFlZGvJQks84R5xiktVep3m3WAgJye
         YVQ9D+Cz/wcmd8olyyoI46tJ3K46ARcA8Zih3/4dluhOwJdU3fl1pPvX4ODNax1PUubT
         dnGMniGfWDUjseg4YtbJurPabG5suU3k7fAsv0pwwRh0YEYwCJ1UlljRYGp/IZys9jc0
         LSp9YCVS79NSzfdbMdwQUbOVhKbA30UKB596z/wC4HaVfcvZzWlgAXrbjR+hWnO0I3ti
         ajq/xagmW2o7Tt3cLyNt3j71lbw12BoONd13lBgTqHX0LySQ4z4zydn+aD1ptHAhGeKy
         tQhw==
X-Gm-Message-State: AFqh2kqpq/La3YtyHwWrH7vA3OZOI/S6Mbnn3L3+rZnZFgAW2w2qAY1V
        RMiTQv9c/o+/rqT9UQEDegjzCzbuk+U=
X-Google-Smtp-Source: AMrXdXu9sJURMiaSCy1D0/JG/fRoPdQC2qc/oy9mmZjNOHh93DiLq84GIrPxMIWkhmWROr3p5b8uRg==
X-Received: by 2002:a05:600c:378c:b0:3d2:1f10:3318 with SMTP id o12-20020a05600c378c00b003d21f103318mr40742437wmr.31.1672933475689;
        Thu, 05 Jan 2023 07:44:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b003d974076f13sm3354467wms.3.2023.01.05.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:44:35 -0800 (PST)
Message-Id: <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
References: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Jan 2023 15:44:32 +0000
Subject: [PATCH v14 0/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Rose <83477269+AtariDreams@users.noreply.github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After joining threads, the handle to the original thread should be closed as
it no longer needs to be open.

Signed-off-by: Seija Kijin doremylover123@gmail.com

Seija Kijin (2):
  win32: prepare pthread.c for change by formatting
  win32: close handles of threads that have been joined

 compat/win32/pthread.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)


base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v14
Pull-Request: https://github.com/git/git/pull/1406

Range-diff vs v13:

 1:  6f89b120641 = 1:  a20eafb9541 win32: prepare pthread.c for change by formatting
 2:  f126d6416d5 = 2:  aa0319bc08e win32: close handles of threads that have been joined

-- 
gitgitgadget
