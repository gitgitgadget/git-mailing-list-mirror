Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABEC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 14:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiGFOTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGFOTb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 10:19:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC916586
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 07:19:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso10197044pjc.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akJcYTITo/H0sTbJpjJO5WDefoliIkAWNpZqDtu+v6w=;
        b=bIuUrd7WdU4bjs8NbZxGT2+iPaYH2uWhQmu6CjEgE09WqGQGg/H5kBtE0nHdAeJ4io
         rzTv3+8I3L47T0MLSI+jwwi9yf96qWv3nMAS/oeJZRpo9BRExeCsOgCoK6zo2u62aLBb
         rFPa7u0VXXYgfG/+nD8UBcQiCyc2mWNWZkQcyU9VTt0Nb0pHUy3j6L+j86Tw5RaWM7Pc
         +q77ubCpdDn0RxThvEF8FCbHCqrdjVlbSHio9O3XCKqHjuOTFfzyD1o21gbiYp1ZhVGp
         DTEo5K/7sFPmQ/Y9jnqVnIgnOY0yuh+qPSF6A/QFD1CE6b2Ytnhqh0Sk7pfcEjeLYRCu
         qHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akJcYTITo/H0sTbJpjJO5WDefoliIkAWNpZqDtu+v6w=;
        b=PTHVgQIiZHDn5NTPOnn5JC+n3v1Q1irVaFIexr7TRTYdfGZ1ICnwHBEnr26PstXpFP
         rbcG8bsndp1uU1mMiThIafcPAzK02KT0wwlo4R3MHJAbZ014i8ckxfmiv4K8dtGEzKWW
         QtInBhZV7VEhiwNlglSIfrsgOclUE6ZGpgfBTl9C0W35Ikx8cq8hBvnC6KHyh9ICC6se
         TEwWFKdnBev66uzrP9pybUS2smM9659M7jF5d6CCW1Edx/1x3A7dY5iKOzdbUZxqCQuy
         LtEuTNVnRAduk0GSm9YyETwQbg3IbYca1XZMWDPESrIi4qIepQQhEYagZFo7QczvoFQC
         SUlA==
X-Gm-Message-State: AJIora+IDvOlsfrXpt36E1MvxFFei0Pcs/cgg8ZuBLDarTWOhv6oWZmO
        RTQW0AVeo/sXNkoYuT3TtKg=
X-Google-Smtp-Source: AGRyM1scVqdDnaK4qCNg5XE1oCG2QTPXlO8O+VbXjzIwZLn7ZM+EogludS0AbMDf+g0MIKMXJJmDmQ==
X-Received: by 2002:a17:90b:2251:b0:1ed:29d2:e013 with SMTP id hk17-20020a17090b225100b001ed29d2e013mr49028638pjb.223.1657117169981;
        Wed, 06 Jul 2022 07:19:29 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00188900b0050dc762818csm25093486pfh.102.2022.07.06.07.19.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:19:29 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     sunshine@sunshineco.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
Date:   Wed,  6 Jul 2022 22:19:23 +0800
Message-Id: <20220706141923.58074-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.672.g74cc1aa55f.dirty
In-Reply-To: <CAPig+cR9XL3dRuRrH9kCrqUqu5HwAJstgkp9eTJVBZ0TBZ+Wjw@mail.gmail.com>
References: <CAPig+cR9XL3dRuRrH9kCrqUqu5HwAJstgkp9eTJVBZ0TBZ+Wjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Jun 2022 13:28:31 -0400, Eric Sunshine wrote:

> > On Tue, Jun 28 2022, Teng Long wrote:
> > >       if (bitmap_equals(result, tdata.base))
> > > -             fprintf(stderr, "OK!\n");
> > > +             fprintf(stderr, _("OK!\n"));
>
> As a minor additional bit of help, you can use fprintf_ln() from
> strbuf.h which will automatically output the trailing "\n":

Yes, agree.

> (Aside: Use of fprintf() here is a bit odd since there are no
> formatting directives in the argument, thus fputs() would have been a
> better choice, but that's a cleanup for another day and a different
> patch series, probably.)

*nod*, by the way, I think I will remove the translation on "OK!", currently I
think it doesnt mean much.

Thanks.
