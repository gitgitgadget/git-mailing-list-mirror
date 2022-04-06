Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C0C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 15:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiDFPNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiDFPMp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 11:12:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7EB582C7C
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 05:13:54 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e2442907a1so2286436fac.8
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4psF9SvHzH22ABXnegRexvtu57IgUbnKQ8pVNtKcdl4=;
        b=cdLhoZG6qU4bvzOSKZuQxqhSfzLaXtxtP8wfLU1H4BhiXRupVvKJhzu1mX0jocC6vg
         Fz2dL3lwMIurxn02+bvWg8Pu8xvEf8qAVbgZmvEWqULBVWi9e/7xRXeowywyFEN7kql8
         4lYhGoeFYouxbx21/RGkxf3aicmHh65+sAWZTx1qysJ2NTPhLHmqMvI/spB/Z/CvTMkl
         MvKivgvVaEqE7cr1Mum0AsBS/zYDHYqOq+lC11MFyE2+SGLOMemaDolokiQfA04LmFax
         zBLYlTqGvUgrKKaIfIVicE7P/XoAHwL9jx6KhCmRD4CRoei23Kakr5pMhQV0QdTxedUv
         Lx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4psF9SvHzH22ABXnegRexvtu57IgUbnKQ8pVNtKcdl4=;
        b=DwDnZN6FihAe2WDGBWe+5lC0VBxoIz7VzQ/sM45igpC1fnLByfSW6RxypMZX5mGP+D
         c0OdikETb2N4ocssiAu3bEwqoi4mBnzMkgqFhcdxETfnO6nD8Oi41MvcgCOCnwG8CWvv
         L5aXN456jy15oTYPePsz4A/ISEdFfTY/AQ/eIoWyA+vH4N9Ojap0ZpZzBnGkFlIy0NGS
         VhvWhnWu4D5jCiH7yDjlynM7t0r253MnIb2KbV6Q51Xxyo8rfC/IVz6sUo929nrfkWG9
         rQvDaGzUuiDQ2sqCBkLYJfdF4m4bZ+3uNyBWGqS5BmCch6C3cAr9YoGYKSrX1fmrpoFR
         hKkQ==
X-Gm-Message-State: AOAM531K2eKppSZuc75SXrOx8usElJ0WKciF41KXpVETXKjab3sZdrH2
        QyXZKrrHKtjvBImF3lYGNErVgHtnDj7UMT10BMIrEQdValjZKw==
X-Google-Smtp-Source: ABdhPJxVFv+ZT2AirHFA2C2r4ueBixVUQI5SYCAqwMPE7zmwJ1I/3cIg+QFcV47A2IVSVvUApjPPBzbPIRmE7ncSYHQ=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr3707443oab.280.1649246767085; Wed, 06
 Apr 2022 05:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220406080920.1220183-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220406080920.1220183-1-shaoxuan.yuan02@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 6 Apr 2022 20:05:55 +0800
Message-ID: <CAJyCBOTHT+oLQ5Z0rKhj7tfiA97_rpXAU3mVjokUV09DB9bkvg@mail.gmail.com>
Subject: Re: [GSoC v1 0/1] GSoC 2022 proposal rough draft
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure why, seems that the previous email does not show up on the
mailing list.

-- 
Thanks & Regards,
Shaoxuan
