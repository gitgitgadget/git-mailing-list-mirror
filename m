Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986D9C4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 21:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiLEVEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiLEVEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469B2AC64
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 13:03:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r188-20020a1c44c5000000b003d1e906ca23so71933wma.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DOdVNsD0r6Sk9fhN0ako0bhUI8ZTaaeCJad0qSTPRc0=;
        b=WLeU3675fNXJINu5BuzwUHdE5N4lvQ0Soev1Ws4LrdP6iTfTwyvPFt9PzySZpo/JvJ
         zeh4QeT51xYAar8S3YiWk3oqGMYNrEx5Mj+E9V23eV4bflWuYqNwEwmbSapkwO+09EtV
         30wAs4v4efQnanS/O3ln7nKlLZTHdx7QoDONm6nBwbwqfaxTXV4ZbJPOBkjuJz0cAK8U
         rCyuDsSR1ijx+yifd2x851/8RqwXPUQvf9+fx+aTbz+FgWLRHApSsNjH00UCwyqIm1p7
         hMwii0/O4czElf412zACDH9HnGjdDtkEdqnHx/vlcdCeLUCQ7D3oONiO4Mbw4PjdxdK7
         1lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOdVNsD0r6Sk9fhN0ako0bhUI8ZTaaeCJad0qSTPRc0=;
        b=zdXwLp4KJNVdBbVhLTzMRq05C4CugZLNbsMz5sAC9PiYNjJvrl7vCuAv3iS6VhdEHL
         h3GEaMXrDyyeZ9VBrMfd8Xx9PI3jDsp0ODt6yw1/Pav6MZopMXWJsQaeGNw3owp6Xuw0
         QmxAFG7rjiq+dAca7JEtPX8xvCqoaVfkVGZ0N455EAFbp3fx+7wVINa0ao63ybnlfGk5
         wJQWRG11mYvgQQp3EE4DzLAwSURRGAXq2w95MVGfl/QZ/5+VY84NB1Oj3RDlj28/0P+i
         pKqn1ZY+/O6uy8+vBJ9TSrODiXlOwrkQPrS3md6uOFY+i6Nur3N0+/cVkADf+PLL2ku+
         kPsA==
X-Gm-Message-State: ANoB5pn0gBeQPObZB9C+043AH5e/WJwOdo85a/Welr46rWXkMxlnr5A6
        fAyLWPuUERCEQCh/yoq5FXjUfV241aM=
X-Google-Smtp-Source: AA0mqf4EZiuJNM5m4Od7b9ONUQZzemU1zMZ3jytMvKYTrSO13+r1BQ6qJUOmnesS419qUGMl/Gf/ng==
X-Received: by 2002:a7b:c045:0:b0:3cf:6f5f:da0e with SMTP id u5-20020a7bc045000000b003cf6f5fda0emr46995427wmc.19.1670274215251;
        Mon, 05 Dec 2022 13:03:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q128-20020a1c4386000000b003c71358a42dsm30713191wma.18.2022.12.05.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:03:34 -0800 (PST)
Message-Id: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
From:   "Harshil Jani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 21:03:31 +0000
Subject: [PATCH 0/2] Remove MSys Support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Harshil Jani <harshiljani2002@gmail.com>
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1433%2FHarshil-Jani%2Fdrop-Msys-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1433/Harshil-Jani/drop-Msys-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1433
-- 
gitgitgadget
