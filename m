Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE6D1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 11:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbfIELQf (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 07:16:35 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40468 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbfIELQe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 07:16:34 -0400
Received: by mail-wm1-f49.google.com with SMTP id t9so2478347wmi.5
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8YeJdduINqvok6OLbb18F4ardupZapKjDcsThc9K4Tk=;
        b=ma9YnxJMWBvJjMmtqOeHatDbgB4EMINFh8UhIG5gzayM+r0hL26/K1roVZ94/+O+LJ
         hWCAHVP6FzBW4eiYmQT+uI8ion3Gs+w5aJOQm8mhM8mesSicLlkES/j3qy5Y/yRSyNuh
         orEdshkN71HtGXhCB2ug3kYt8xDExuF1i3gt8ohkzwwDPRkm3CpHmQ3Cxp8M2gk9FYZX
         In/EyTt3ikKvAnBSFPd48nvb/VbyhuQWGoKFfdLwPFhGB+tG8ClsgxAUCD7Fnw5OfXGl
         aCErn+u2+/8V5ushw73IKMyqK9QjT3Wamf5tWPpqvWu4cdrE2Ts/47R9pvd89X2Fr4XZ
         JgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8YeJdduINqvok6OLbb18F4ardupZapKjDcsThc9K4Tk=;
        b=LlucT//S5jDQL/bQQLQL1W1GctfyED3DFOjt2jIlK1Zc9xYrXfJJXTLKhzjrdtzDhn
         kwvtMirB3GOryZJy5QeHbSpk8Y0mqcPOucVAZssC2gEGB9uSEvy/RHpAy40HphyixdLJ
         9NDjBmrqZW5ysLFmLgZn0xPHPsDJRJFZcDs3QkxjAsnupr7WDw+fmmORsQTT85BxM7xh
         VXZJAbMzerCf2VNRObFYZ27mNrQW8T2YhG8yuBrx+WUN1DaOfWoLcfb1gKfMh6XA/sBT
         nvg/8lW/5wsvO3Igjw72fwWKA7oytCAAFkTm88y0d6+ZKH54ONHZLGQoTw2FnK499qK8
         exdw==
X-Gm-Message-State: APjAAAUT8094K1rDohBFapOMKi15BSbEJdVm0kqq9ZY7W2o0EgHeADrF
        DWZ5PP9sQdke9NEQKB6xNOJTLyfE
X-Google-Smtp-Source: APXvYqypy+IAdLaiaO4AEA2LS1K6p+L+9CwGDjU84msJL1KAZ5xRO1Ib0j3/TOcMOS9MLswQ+9Oftg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr2613383wmd.104.1567682192747;
        Thu, 05 Sep 2019 04:16:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1709708wmj.3.2019.09.05.04.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 04:16:32 -0700 (PDT)
Date:   Thu, 05 Sep 2019 04:16:32 -0700 (PDT)
X-Google-Original-Date: Thu, 05 Sep 2019 11:16:30 GMT
Message-Id: <pull.332.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix stale .gitignore change, introduced via js/visual-studio
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in 
https://public-inbox.org/git/20190825120741.GM20404@szeder.dev/, we added a
line to ignore .manifest files, but that is a left-over from a long time
ago, before we added and used compat/win32/git.manifest.

This fixes that left-over.

Johannes Schindelin (1):
  .gitignore: stop ignoring `.manifest` files

 .gitignore | 1 -
 1 file changed, 1 deletion(-)


base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-332%2Fdscho%2Fstop-ignoring-manifest-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-332/dscho/stop-ignoring-manifest-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/332
-- 
gitgitgadget
