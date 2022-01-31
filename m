Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB2C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381112AbiAaRuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377817AbiAaRuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:50:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC75C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so14211698wms.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XO4zLXw9Qsx8k7LywsNbE0KDnAh9lwX3HWQVjF+aptg=;
        b=bWHI9wnKYvg0bsdQeB0v95osIofRh14K7sdD2pbk0RqYuzwJGlHCjknRNZg9647O7H
         iNSNK/Elgxb+5vxaAiEFWsxW2nRQVRIwTjtmUAWvhtfPt/yYw9QF3K5SA1jMzeapbrWG
         O6+l3vRjK2u6zlk2Y7x0xvpuKzAe6y+GdPmMqrOItQn/cLM59P/+ri/MLHyAvQxfcbSm
         T1M7D5Cj/ZWwgwbeVu5yENzvYOD6y7N5iZZkOpP/he2NWMi043E7/tqZqTCIB7MEh2Aj
         wzJPxeU8wBjTF5Um7skTX8NTwoCn6ComQ8yZQkQ436UeGfCGUO1c8lYyXnGt81ptDKh/
         40hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XO4zLXw9Qsx8k7LywsNbE0KDnAh9lwX3HWQVjF+aptg=;
        b=7HxbNVSLpdnWC+EmYKc6a+2c6delvvFZBoqz3qzs2BCfrvBwUE10Q0feV3Vv5tCTrJ
         aPfFUFSfkUtjtEHEFXOMW/jN28mYR0TiJBvMpvynGsY6+Y1NBgVBJX7cep9GEtXBdWBi
         kADPPe/7lQi6CI4Wv2kZPBql6Akel2ptCZeoG+O685oKgipUlNZqwlHD/+CEqPaagyeD
         hz/oQDv9JQ1Lxgyr+CgUu8areJMldy6sLPG8Dt67cRHS4jM5TWX1bQJAncbhjGv42lhh
         uZ2o1w6gZkfLSTSF1Tya21KPNr3Glzu4SqRnPDlWYevecv363E0et2KC6ghKAJsWu1Mt
         p4cA==
X-Gm-Message-State: AOAM531usa2unBWFsuz8zh1pP19SkVlpCNjNEywMbtN7bBlVULDAGdpF
        uaHvwf9cpR63o3BVh9w+qdz068NoVek=
X-Google-Smtp-Source: ABdhPJzEIdPeq0khq3pVhyE3IoxEf+mZrD5xkHskixGYZ+ddRq9ibd1ZQjeRNT97nI5wyr8Vxc88Sg==
X-Received: by 2002:a05:600c:a4b:: with SMTP id c11mr28334168wmq.135.1643651421418;
        Mon, 31 Jan 2022 09:50:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm14035619wrd.111.2022.01.31.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:50:21 -0800 (PST)
Message-Id: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 17:50:17 +0000
Subject: [PATCH 0/3] reftable related test tweaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are 3 assorted fixes from my reftable-backend branch.

Han-Wen Nienhuys (3):
  t1405: explictly delete reflogs for reftable
  t1405: mark test that checks existence as REFFILES
  t5312: prepare for reftable

 t/t1405-main-ref-store.sh   |  8 +++++++-
 t/t5312-prune-corruption.sh | 10 +++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)


base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1209%2Fhanwen%2Ftest-tweaks-20220130-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1209/hanwen/test-tweaks-20220130-v1
Pull-Request: https://github.com/git/git/pull/1209
-- 
gitgitgadget
