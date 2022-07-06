Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE165C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 14:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGFOGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGFOGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 10:06:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48D9BCB
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 07:06:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s27so14072484pga.13
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=118+0ftC2rLIqkBqMHO4HtwKO1b1hQaUWtoMDRsSPGE=;
        b=qraD3feogLGwX5fU0wAKKeTNmIKT1+o0yvfdAikhyUm2EaSAAyei9gj0I0ToXHqMOB
         uTEEpltFxD4txulule4KknmQn/BS3GDSKq8+TQ9CJrur6mQMQOuUji7zVOjdPGG+TvOT
         R/ffDA/KAKz90WYygV88rea05oLwEcHfQ/s8Vou68H8X37J+nX3PYf4Qm8Kvpy8qoDuH
         ethJixHAAdy2hmvBXaiXQwKViNuf8RuKg1J9/9tc6+5NPyzPK7l1werE3kVeY85OrMgS
         usqR4tMo122+nYjKElSlfkcQR6hyjeRcFzN8Idajto/HMaqTNX9TUQtEFoKHG8ihtvP5
         ZLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=118+0ftC2rLIqkBqMHO4HtwKO1b1hQaUWtoMDRsSPGE=;
        b=U9z29dRogurd5b6GtVExJ1dR3zz605K74AcMrliSQoas/9ngzEsq4FCswZmvVO6dNb
         +5BOIhaz1PSzGnyoCY4eBC729IF5Iq8i74a3rt0wRCPWtqR1fXEnKjZ2MFq0l0vW5FhD
         TECfguy08jU4yMKRvM3PuHhXmOlWrEP2c2K0DJOSZXahxCo9Jfr+R8oQ2+L+xbFKkWV1
         CeP/7H/xVDkDuL/yG4YR7XyDJ0aJSRsevzzz1wpv0sK4JwgfjGSoUPZkDn6rOjlKOISo
         FmaHu2SSHE7Q8AqHg/vjE3iZqG7OF+e0BLuzUHH3z3kkx6Q+E317eSDiUUQuos9QqwcE
         5taQ==
X-Gm-Message-State: AJIora9jCv63GodC/5JSk5BQeuFaiQJ7J5txHqJz0TvLit7htE6hS61K
        FPhcWDnFaYr8Irns85ojQtE=
X-Google-Smtp-Source: AGRyM1sP4zGpDnjeVvqV2Bi7o+7U0ct6cU4B07hUITvM2u8xS+6MTcgGbTjy5ytchHYyS6C1U9bR8Q==
X-Received: by 2002:a05:6a00:1412:b0:528:47a6:8569 with SMTP id l18-20020a056a00141200b0052847a68569mr24573206pfu.39.1657116370155;
        Wed, 06 Jul 2022 07:06:10 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902b58f00b001677d4a9654sm25595315pls.265.2022.07.06.07.06.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:06:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
Date:   Wed,  6 Jul 2022 22:06:03 +0800
Message-Id: <20220706140603.57564-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.672.g74cc1aa55f.dirty
In-Reply-To: <220628.86sfnpf96x.gmgdl@evledraar.gmail.com>
References: <220628.86sfnpf96x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Usually we don't go for cleanup-while-at-it, but in this case we're
> marking messages that don't conform to our CodingGudielines for
> translation, mostly because they're error messages that start with an
> upper-case letter.
>
> So I think we should fix those issues first, to avoid double-work for
> translators (well, a bit less, since they're the translation memory, but
> it's quite a bit of churn...).

Yes. I think it's need to make a cleanup commit first.

> Lose the \n here, in addition to lower-case & quote %s.
> ...
> Ditto don't include \n.
> ...
> Ditto don't translate BUG().
> ..

etc.Will fix.

Thanks.
