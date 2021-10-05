Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC1C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 23:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A640C61056
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 23:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhJEXyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 19:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhJEXyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 19:54:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5CC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 16:52:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d8so2804450edx.9
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ipxp/ZinCOnI5qzcpbC3J3I+6lSvHESTLjWS1rV4lEU=;
        b=Q4onr0PQ1/J7aWtvJSD+z9mCJaVrw5m0TsrybFWYMqAtjQx3fi7WZOffsDrOkgtoWd
         voCKf9hdeHkrOeMKtghlQsKxTnX6HfifWlvKRE/TXWddZPnGlCBjaD99YpWIIbzWziPo
         FhLDG/y/W8++hmqZzasTJMsiJxOn/S7QPIMLbBijHPREviDrCgPHaAQZAfnwPZLM9+5i
         EZ69KfPUf57g5PlEkpEtJr0eLEw/rtKDbvW5jLcBtGHbioQp20AdgVeg5oRopKEROIWj
         ZYNPjbwoptuLhU18Hr/pvioFnN0wkd4KYYJ7WbSvKFCxmZy+jQAJTnN5ys64dJ/gDR5l
         K+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ipxp/ZinCOnI5qzcpbC3J3I+6lSvHESTLjWS1rV4lEU=;
        b=M1Hwgp1XC132WsCjoRbTl5Dbu26kk5PE+WZwHWDCdLHCCG+7mqaIyAfQjAgTGQWc2w
         HgVfyyrsCXUuDICxXJuqV0K4ptB+ELASOz7Xr0T6ref+oSCT+bWjsSlilLPCKpEYrEsw
         23TWbX/618hcupCkDvD78GCqM5SsVEUGPN6bH3xIUG8B3cJn67bE+hHx3dtRebOe/dq2
         Aa8t0S87lwesarOWJZiD60p0Fv2tb7W5Gmwlj+2cDLRDW4VBKZz6rpSF69TvJ9lLyG7T
         xFJ8KMSPlzW52urzKByNiGxhaM7V6zFSI/o8PCr63dIwWtjTnIYb0xKcEiQxb4dQivEb
         bSyw==
X-Gm-Message-State: AOAM531pHvMpuy6FCxIv6l0JDqo/kWgVAnmtfK4Qh6qIE7t/KGy3FpTS
        t1wNVVdzdPcUcK2FmpHr058RFNE5iUvBAaVYCkUQTV/xF9AbfA==
X-Google-Smtp-Source: ABdhPJx7K95BhXcV6PKN8Jvsqh3OQQdMiZrNrBz9AvRxlgKnCFpB+tdzt/yDwYHmZJm8prA8GpGlqBZ4B+GjLEo10DQ=
X-Received: by 2002:a17:906:d207:: with SMTP id w7mr26864338ejz.571.1633477932029;
 Tue, 05 Oct 2021 16:52:12 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Tue, 5 Oct 2021 16:52:00 -0700
Message-ID: <CA+KyZp75fjj9T0LjkpEjLMVf5KNguNZ1Ycxbb26ZnCGrK5zLAQ@mail.gmail.com>
Subject: add/init all git submodules that are referenced in .gitmodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am looking for this feature:

https://stackoverflow.com/a/69458406/1223975

it is really confusing as to why it doesn't exist

-- 
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills

Sender notified by
Mailtrack 10/05/21, 04:51:40 PM
Remove
