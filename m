Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33AAC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhLKCgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhLKCgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:36:08 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6AC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:32:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v1so35766251edx.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bSCJgoGhGuAzOFOAhsyYVB2PXCg9TwFZIOIK04aia5g=;
        b=DnYGTECZfMbMY7VG/j6e32ZKV4HGADw74s7rdpINCNzPUJPAgJsf/OXHYJ/JBWlx2n
         rLEso6s5TstwRlHy5dSBNSjniM/lKdfGobNWvN8vrUL3ZpGzH/wQMWO/MqiUvY88dmI9
         6AWNfyHRFKllWNhtCtEXe+eNQla84v6SMkFy2hX47Uf8Leg9lRD5h569li+hE3df8MlP
         z/ASpTnass8LQdJ+1nsk+aRBSgQs9BdyM9hsJSOufFoiLiL+9Xgt0l7GGdEPxLCtpYd/
         qaf5j1kzUZ33O/UO9mt+p3OTXSFS8LN9U+cr270hWhNi3iwqK3Xm2H+TIhLjGteUaNnM
         WgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bSCJgoGhGuAzOFOAhsyYVB2PXCg9TwFZIOIK04aia5g=;
        b=KJpRxfrY4CVJ15fAbQVNvBkp4/jf8Qqk9ELpoSz4YpD+61A5UUZZb19QWzZ/QR+vH/
         2DMudN0hisktJM8cs5idKESUCt3s/ZpXlmyNUp4a+MOt1xicK+LfcPEfaTa3QEMSwmZG
         B6eC/CQ190Npo9AyBBQo1LM0NjOK1ptRxlCEQztFNwHqjGcERT4X1eBVUNKbm2kNu+b6
         6/tJ27qxVhKCgD2S3ENhsOOLXrZ1IH2+D/A5/r9vr4QeSXZKQs66yPsdbE97wWq2JaXD
         PH5rXTZmJ1HWe+U/8kNTqaPJDDy8RXdgukKhB+qdvK4o27F/QqlZQzyySeF+NcrlTd0p
         pnrg==
X-Gm-Message-State: AOAM532kT1IBBnVD5ElWAonUUY9y8WeqPRGFbBZs3vuQub+dvp4TPsY/
        AHW78XgGk8ufEgREzKpO/27GnIjVTD0n1w==
X-Google-Smtp-Source: ABdhPJwj38BN/Elt3bPxY1pofNq+QBInJI/QQnHf5I1ed/BqIcWhaKvm1jhgh4JszOi99wWcbT91fA==
X-Received: by 2002:a05:6402:291:: with SMTP id l17mr44278936edv.242.1639189950509;
        Fri, 10 Dec 2021 18:32:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cq19sm2227754edb.33.2021.12.10.18.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:32:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvsBZ-000REs-DK;
        Sat, 11 Dec 2021 03:32:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jose Wielandt <jose.wielandt@timining.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git <git@vger.kernel.org>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
Date:   Sat, 11 Dec 2021 03:30:00 +0100
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
 <211210.86r1akbes8.gmgdl@evledraar.gmail.com>
 <20211210164249.bahhe5ogjjhz4lxo@fs>
 <CAJrA3nKbUK=_5d5KTCDehrfge4y1aB9YGsFwQYNzUDWGcfog4w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAJrA3nKbUK=_5d5KTCDehrfge4y1aB9YGsFwQYNzUDWGcfog4w@mail.gmail.com>
Message-ID: <211211.86a6h7c1mq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Jose Wielandt wrote:

> Yes, I git switch has the same behavior.
> I also agree that add hints could be a good idea.

I'll pick up this topic.

I have some patches I'm trickling in to improve the general UX of these
fatal/error/warning/hint etc. messages, one part of that is trying to
get this RFC series in incrementally (some patches are already on-list:
https://lore.kernel.org/git/RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com/

Adding color to the output would be relatively easy. I'll get to it, and
feel free to send me a reminder in some months (which is realistically
when you'd see it in a release) if you don't see it.

Thanks for the suggestion, & for caring about git's UX.
