Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA539C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiFMRSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbiFMRRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 13:17:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115CD286C8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r187-20020a1c44c4000000b0039c76434147so4488294wma.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cRoF92z65QwYMs/zYcqHxC3Nk8hwBPfIqQrpcM/w94Q=;
        b=IgCwgyuqNPBMUOs+t6BFMVdiRpK3fi3oeT+gDCjQVH0omlmmGROqYW8ilPA1Cjo13X
         YBMfkA8NaS1h3ZVhMIQPx2ELo3GRzEOTZRzQH6yOcBbha/YHaGJSOzAY2YIP9+YTmShu
         Onhkfg9rE/XSu8F7v1GEqoGFyH5Tw13xKUsReGcWe+ixY7IpOgVOsCQY2Uk09RmSOCzk
         R7MYu/TX6BB+JahzZKFBshZgzhHNJDhvU6QtWkv5RjD57wfCBsVI2OxWX7sHN8A3srT7
         8V3JJPV86oqmMqYjqaO3FLPxqgosws8SvcRPJ2ZHeN4oeY22OG/aR0EkdWpS75GQymD0
         EjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cRoF92z65QwYMs/zYcqHxC3Nk8hwBPfIqQrpcM/w94Q=;
        b=73crSbQ8XnvneH4wltlkgxY+Ok7TdfxTZxxqUezYgKkz9fqgtHxWsKgyE7xIU/hdNe
         gmuxVrWGddC65qP+UDUHi1IN9EIqaIHiWAQ633WYZ/9EnCPmsRBYM5U85MZ19Kl3M+D8
         aysMp3ciJWp2V+TaTgqUj35L8mnB+r54gQl/A/g1+keB93ll9ZMAg+/Y5MsS3sNoPTbA
         S0NabFyYwAtJZVixXDq1QjUdaJaaAlOjTdtPoNT5qTXPhL2rV3Ns7/Rjdc9FuZ9j8Pxn
         Pe+s4al9GsqR1WVGe6oBVQJ/7oZJCIbi1GODXyD9EtMhaJ82oT8n3Xp+faT8dQq8pvg3
         MSYA==
X-Gm-Message-State: AOAM530GZdyd+XQhsN55BgPAG3xBhbjyhbv5USL2xodtX+3wugn+MzFq
        K496s5XTCwVSeLEpNfEid8PqV1/f/YNplQ==
X-Google-Smtp-Source: ABdhPJwAXkoz9lKPYj11In3bb5juRnU1aVYyuFuhUDxIThO+LpJbnVEu2k7S7s9+tm01IwUleKhwDg==
X-Received: by 2002:a05:600c:2189:b0:39c:4bfe:880e with SMTP id e9-20020a05600c218900b0039c4bfe880emr14332415wme.78.1655123384182;
        Mon, 13 Jun 2022 05:29:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0020c5253d8fcsm10122325wrs.72.2022.06.13.05.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:29:43 -0700 (PDT)
Message-Id: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 12:29:40 +0000
Subject: [PATCH 0/3] Fix a few documentation errors around the raw diff output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few doc fixes for some things that I noticed out while reading
the man pages for 'git diff-files' and 'git diff-index'. These are quite
old!

Philippe Blain (3):
  diff-format.txt: fix ancient copy-paste error
  diff-format.txt: correct misleading wording
  diff-index.txt: update raw output format in examples

 Documentation/diff-format.txt    | 6 +++---
 Documentation/git-diff-index.txt | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)


base-commit: 5699ec1b0aec51b9e9ba5a2785f65970c5a95d84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1259%2Fphil-blain%2Fdiff-files-doc-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1259/phil-blain/diff-files-doc-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1259
-- 
gitgitgadget
