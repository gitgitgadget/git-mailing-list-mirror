Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53886C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 04:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiGUEIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 00:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiGUEHe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 00:07:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C2551437
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 21:07:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf4so1038934ejc.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+ZKrFFG8jKG1V2yjkLIvee9Amnf7sVBBEvN9viHGQSk=;
        b=Sy0uNzDq2Zx1uaFKhOHIsdvgLdniA0/ym56uXcnOEY8jYnO1VVxxqXNLUkQigwyoDG
         jVEN09FyJI76+qt2B8M9Fm9xS9NlfU7HnuGYhHI8F75MxpcN21p5I/4WOSVxA18BEjkU
         WL+7ZeiHlloWHJYSnFL1u9H1h3kIXlccsA34Y97K5lXbj9XSrHiJTvL6j9h4TmBnWVIJ
         pG0dvHBeKUkjoTD9Uqgpvb5IIEKKzKSsZr2K9OY58wBuylz16sFPHyehPFuA4h/bJ4M2
         RMD3yhhUv69X3oZsbbqdUD72U6lvpYEUHr5Su1kuTZERtQXW7CkH9VTbjrXDLFNBeNYd
         zorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+ZKrFFG8jKG1V2yjkLIvee9Amnf7sVBBEvN9viHGQSk=;
        b=pek9AiQakfT4qF8pp7/5cCw4M6oW2l3Jfbnvi1dhQE0s/BpbGj6GNMVdgbUN5s/Vzy
         NZGUBSRRb3urN+/zI7v11EXNGNH7vfXEPn4sOohV3LMcGPjVN9wqLb2XFwgBktb+3cSv
         8ety5qp62RHaLmkOOhgI7bOMZgnFEh7uRQ7Otwjx7bs+RaQApRqD6WZMW2VmsgN4OT+H
         8+7qYJ9qsYyGDitDdI27jjI9GtOIQBGPU4fGvVW3z3wAKM102PZ13XROypv/Z6QVTgac
         N0ZRxGnGO+5iiBL+fMlhJvEN2VSw1i6Lpsk8nwZnU1+FgsPVLul80IzXV9VUoA06Sfwe
         Vftg==
X-Gm-Message-State: AJIora8Y0Uufk6CVSR9yjf2SupE7EJhqhCleFy7EtnpbRapHbCFYEzTo
        kM5xUZgzxzbaS+sST4dYvrjXcRAEW8nFMFW+h6j8i+xFR9dOBA==
X-Google-Smtp-Source: AGRyM1u2srPtcN0V5LiIcmDMycyIG/bn7LnbUYVXF7sGIFOrzPVqSb2YpFmGGb7poxqNRaOFVqOCp+JfpVNODfMEdE8=
X-Received: by 2002:a17:907:7ba9:b0:72f:2994:74aa with SMTP id
 ne41-20020a1709077ba900b0072f299474aamr18831893ejc.85.1658376443563; Wed, 20
 Jul 2022 21:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
In-Reply-To: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Thu, 21 Jul 2022 09:37:12 +0530
Message-ID: <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2022 at 7:20 PM Abhradeep Chakraborty
<chakrabortyabhradeep79@gmail.com> wrote:
>
> Hello,
>
> I need the CRoaring[1] library to use roaring bitmaps. But it has
> Apache license v2 which is not compatible with GPLv2[2].

I have reached out to Daniel and he agreed to make CRoaring
dual-licensed under MIT and Apachev2[1].
Now, I can use CRoaring, right?

[1] https://groups.google.com/g/roaring-bitmaps/c/0d7KoA79k3A

Thanks :)
