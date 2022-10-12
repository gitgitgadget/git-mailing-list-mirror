Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E489C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJLVR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJLVRV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:17:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FE1191FA
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:17:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so159522pfh.6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2LkoblXxk8VAkPCyCz7pmz9KZE3w3VtvXMD8Vau9zw=;
        b=X3G4a9Sv7lPcPzW/Vo1qWmAB+YAfwvy31q93wbU74tE83R/2xjmKmjrYIqIhcljiGf
         0j5Ill1XF4uOX/JvC3TYFYc2M84RWMTE5C804E4S5opv2xkdoHTjl3FTBJRlMRQtbgON
         7m9oQwAtgCU5Agy5d2fTYoPJVMxvhf0pPZ3g8ed+TGOoRCir++/mgrgHUgZGuHxS1opU
         I2fM+VDlpycg253orixm2WF+hpSmMkmUO7PmDDPa2qsxxs1rsnvtOJCBm2KW5uZ+yHbF
         J2m2ddBhd/mdnk09Z4YfA8ldwq9eSq1fdTfIf/11qQXEyeiNPWeVj0SuAdm/z7nG8T3C
         xJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2LkoblXxk8VAkPCyCz7pmz9KZE3w3VtvXMD8Vau9zw=;
        b=zZJ86kXaRFlgfKnhsXooUlkFBIhNBplwwyIQZb0580MzO4nbbCvUy+qxAOQAuChITu
         hX3r25JDmdtcsg1mpoVxsNOp2x7nK+nDyaLSf0ffDvcx1N1H/A1wwxNW/6IS9wHoaNBq
         9U+REyCorYvnMdAVXBz7bXwrqZAlyu7XY9TNXFjSFO1qW9wgtAYRK7II41fqgEqrLElC
         lrnqhJHAnHGgc6vMl8Fr+0qcRhb26lbAR3pDnskehDQQgd6s1SZ0OdIUR1wt25lgKtVD
         Po7iNCjpmTKv3TW3FBivaMsUBgtpUuXzpTHeF9E9EAHuVw+iLyXI5LFcHavQDCkyud27
         Mn/w==
X-Gm-Message-State: ACrzQf1mpaPfvC5p8sF3ckI8v8GWrPLIZmXldYh05axGXlMDZvTJOKbt
        vSYvWJt2YvRiQS2hGNCYKwn9tbjQiUKV9gt6RS9TbeCdU2EvMA==
X-Google-Smtp-Source: AMsMyM5tRE4GqPzRYqYw8P4W2ZoucwDM3j+11JyD+bhgYunyGhEQJ+Nh8mKGLJAgbUZnGkg5f51KL7VHYrRbkhI/eRU=
X-Received: by 2002:a63:7:0:b0:45b:693e:7d86 with SMTP id 7-20020a630007000000b0045b693e7d86mr27776440pga.319.1665609435198;
 Wed, 12 Oct 2022 14:17:15 -0700 (PDT)
MIME-Version: 1.0
From:   Ignacio Taranto <ignacio.taranto@eclypsium.com>
Date:   Wed, 12 Oct 2022 18:17:04 -0300
Message-ID: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
Subject: About git reporting missing newline for symlinks
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, both git diff and git show display "\ No newline at end of file"
for symlinks.

I think this is related to how Git renders diffs, IMO it shouldn't
display a warning about
newlines for symlinks.

Am I making any sense here?
