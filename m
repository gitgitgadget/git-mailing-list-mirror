Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC2C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiECKat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiECKaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D4644C
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:26:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so1055527wmb.4
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MbE5fPZ6+QDkXvZT+FpmiJMxsnCjrY3txpRuLfM65hI=;
        b=gkUiKrjmqJwP8Dqo7DrImwerFcU1YjRfcGgyyGyRPXYSo7v1euw3/zc3eEpn5pyVsf
         thSyw+GuxJhc9HdrWCO++fWA24yXBvg6qq+18wYrMHrFcTQg1yLQ/STuM9Mrh523g5G7
         vy32Tb4xtxLYOqJNeUQgFc7BarXaB/cAxQxHbCjeDaF68Gi4CyFI5dgbA18vX4QOXpK9
         wOiUxCVzSmqmDodYEN6ys1VHQBjordWopP0YiHKuMeM6Tbl4yhtcD+8+z8ZIvHbDmBBy
         hnNAkVNK6LTOcagjq0MWSIlo5fF2CNpyqRIHL5n4HANfU67Pc5/1eL3iD5C+q4Cgdw8Y
         LDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MbE5fPZ6+QDkXvZT+FpmiJMxsnCjrY3txpRuLfM65hI=;
        b=jVHRlFFVkLfJIslCRHcdVdhNezepOAGJPxnxkMaCF2x7thrbvM+g3yzvLOmArBtoVF
         tIyWMkwHX/SZvy6IgX/inpl6EtBlmTCQwe3yLQnWyHkSCuw5KIfcpllnRx4yvRRKiPBz
         KpFw17PdRa3mcvykDknwekdpyh+pNT5G6yQtT+4yQhkxv+o3FDWwmdmUYMaGYU+khnsc
         1RXUe2wVHAcREaUOAW5EdpQFWsnKEZ5ua42tvAtEUXz6bcyAMjIGu5ZgmmBJSiDO1YZ/
         RNMR1/4fLNPNfygb6HBoKHy9oZa5PlybBQhJDg8xhvCIZoqgnB5MAbpfT8ww9XuN/Lfn
         Nj2Q==
X-Gm-Message-State: AOAM5314NutSGat4i3vwWM3e9ACep1NieB6J9PxYzJV5kAXQpJWjbEwn
        u/j1ik0Nv6fXaD+8iH2roooKZyrU2tc=
X-Google-Smtp-Source: ABdhPJyecJwocBvGJLr2YgAPJ3g3uB6PSga0o3tRIDpisGnEb8caorh+KxTxbN2Mb/SN1pFShQ3XeQ==
X-Received: by 2002:a05:600c:1c27:b0:393:ee3d:eb0a with SMTP id j39-20020a05600c1c2700b00393ee3deb0amr2749498wms.69.1651573616421;
        Tue, 03 May 2022 03:26:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b003942a244f43sm1406390wmq.28.2022.05.03.03.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:55 -0700 (PDT)
Message-Id: <1c5a700838201d7002351c8664b9a2c16a00688d.1651573607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:45 +0000
Subject: [PATCH v2 4/6] trace2 docs: fix a JSON formatted example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The example was not in valid JSON format due to a duplicate key "sid".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index e8a5d7c78d0..bf0f0750733 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -128,7 +128,7 @@ yields
 
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"version","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
 {"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
 {"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
 {"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
-- 
gitgitgadget

