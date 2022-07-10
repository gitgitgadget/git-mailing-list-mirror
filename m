Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A470CC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 14:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGJOcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJOcG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 10:32:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AF212AEE
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 07:32:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g1so3552757edb.12
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vNRv6GNUV4N5aeHTVqJki2p15u3fZBe/VaK7rCKmgCc=;
        b=jpE/uFAfiqA49K6Kbur4Cp4vPg/kOsbKtd9wgVg+ba+W1sT0hK+cefqBftFIHlkElx
         eCyECdd82IFt3PvfHe/AXT2WwB6tVy4mc6kN8dMUEF1NQOGj07K+97TlT83ehw3hJLaL
         hSt/2WVOVxuIaJkJdR7kYIZ6LVgLdlyF7KovUKKkouTc0n8inzVeiMjbrFJgIeIvRMch
         viR9KDuD3lVkJvNUwabB2D9iLREMjzdBSgDwxIgPfcpHVIJIyyt4Aj/bsnXvV0Ip/mEk
         Ftcq7ogE4h1inVkK5N5xLiJlmYo2Dr2Kc9yi9WBP1KZ+/u7ewpHBVjwaXibZ01nFt35G
         GSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vNRv6GNUV4N5aeHTVqJki2p15u3fZBe/VaK7rCKmgCc=;
        b=q9d/jsguI06Kdpt5vadoxVmeFopwOTTv69Y/VcPCduHYqsywSL/WxNxgigryGCzCl+
         3qkTI2hOXdbdpDHIQ0H5ZQzXkkEmQKqVdDOTV0JFNa4AjCPdHqPTCwOfoWaYOofqB9OW
         KKHxgNhFupwTHDQVCG6uZ+qnKm75PfzTCUJhRABlBnhFOPJWR/Lme2GURIjNZmgNAGun
         P3BE+rfix+Ko62AA8p9e3N5h5LDS3E6d9ecTPHP69f3K450W/UzvfNfxurDXo3X9vDVQ
         Ij10NQYydo4poLMQZeUeZy+5yU4rY4go4fGZzxSxiAFjEqSyJawpVT/QlvqHB2F+eCrO
         EoNw==
X-Gm-Message-State: AJIora/E31LFdAJf/xRwgmoKmuoBBDXltfClXELQFQQZ0ImZCGpkLbtw
        37qHyF5wc6+22ZsMoX5U+fTsR5hg7h0=
X-Google-Smtp-Source: AGRyM1tgdNaAsuseXYe7OdmQLCOmsmRgolOZ42EPQUmjdFb48SvoemHnt9un4yDP36m5rQyEceb0pw==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id s26-20020a056402015a00b0043171b986f3mr18243693edu.249.1657463519476;
        Sun, 10 Jul 2022 07:31:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f1-20020aa7d841000000b0043a2b8ab377sm2835922eds.88.2022.07.10.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 07:31:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAXyX-0008v7-HW;
        Sun, 10 Jul 2022 16:31:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
Date:   Sun, 10 Jul 2022 16:31:18 +0200
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
Message-ID: <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 07 2022, Jonas Aschenbrenner wrote:

> Similar to the change of the default branch name from "master" to
> "main" to use a word which has less negative associations,
> I suggest to replace the word "blame" with something more neutral.
> Maybe "annotate". That word seems to already be used at some places
> for this Git feature.

What do you think about this old patch of mine to add a 'git praise'?:
https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/
