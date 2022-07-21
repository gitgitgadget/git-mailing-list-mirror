Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3779C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGUOlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGUOlO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:41:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFEE7C19E
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:41:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id l3so1431967qkl.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k7B2rWB6gQh78LVsmlQOPhTPEUdxIyDK946ctTfXb2E=;
        b=B/Q1inqy+acKblOzho6zOcLa9bx8o7qjXaWTfppwkf0Q3wMf6HowOZGOXXdEJeS9dw
         OAuJyRyw55S+YzdCeWb4LO928Hs/kBcFEiGmiY+a4x+AOtTBrfCY8R6hfchW/QizKw1h
         c2YagYbGE0A4Sw9S37IS6HGMpg8WSw4lBwzn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k7B2rWB6gQh78LVsmlQOPhTPEUdxIyDK946ctTfXb2E=;
        b=IMZEJJ10AqSxp0HCEnXXd/ZezyjLizu3pydIjonZiUexMOHVRY4MBl8HHF/kmufYb8
         53gxWBnl33cH7eFy0y/5gr5OPRrBvlbzxw0QEZ0sJutJHZcGlvVqAHZFRNdNYzT194mc
         I2u6my26PSK5ZVEl+HspMz1n31WiqECa3QbEocRVxwbn6mViPhj0I9Pkif8biBn3dpwy
         XYJHB44deUVRGdEQ33ERu5VveQiIRoWpdiuyQaQUD3tgKMR9ylwvpBSoQ+nO/KljxbWR
         uR0NfCmAlGfmpQ2IYJpfHM6+SOyziK+JNpzeee8TpBqSdg1M0CFiexLVr3mMfh1cJZqQ
         +xBA==
X-Gm-Message-State: AJIora/GEM+B79XDkt5+OFfoQwKa8QD0tK7lA75L71piy/Xt3JLJnq6D
        I8Nh9HA8gvrMsRjqv4rE18e+DQb44T2yHw==
X-Google-Smtp-Source: AGRyM1u58tnXuM47/xPFPXN/T1OzfMYfaw84W/iUaCRy0yTbbEMR7LXVg6NmTnLJcBBUKutwJyNKBg==
X-Received: by 2002:a37:555:0:b0:6b5:dace:f589 with SMTP id 82-20020a370555000000b006b5dacef589mr16997686qkf.444.1658414473054;
        Thu, 21 Jul 2022 07:41:13 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id y8-20020a05622a120800b0031ec38da567sm1518885qtx.0.2022.07.21.07.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 07:41:12 -0700 (PDT)
Date:   Thu, 21 Jul 2022 10:41:11 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: On-branch topic description support?
Message-ID: <20220721144111.w2fsowjgwjecjlek@meerkat.local>
References: <xmqqilnr1hff.fsf@gitster.g>
 <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 10:25:19PM -0700, Elijah Newren wrote:
> Seems mostly reasonable, but I'm curious about one thing:
> 
> The cover letter material often includes stuff that would not make
> sense for the merge message (e.g. "Rebased this version on master
> because of conflicts with ...", "Changes since v3", "I'm a little
> unsure of the logic in Patch 5", "Patch 3 might be controversial; take
> a look", etc.)  Would there be some kind of syntax for specifying the
> part of the cover letter meant to be used in the merge commit message,
> or would we just start out with it pre-populating the commit message
> and expect the integrator to cull out the irrelevant parts?

Maybe reuse the scissors line, but throw away stuff after the scissors? E.g.:

    Subject: [PATCH v2 0/3] Implement foo

    This implements foo that is needed to...
    ...
    ...
    ...

    Signed-off-by: De Veloper <dev@example.com>
    Link: https://example.com/foo

    -- >8 --

    Note: I'm not sure about....

    ---

    Changes in v2:
     - Rewrote using libfoo
     - ...

    ---
    Diffstat, range-diff, etc.

    ---
    base-commit: abcde
    change-id: abcde-foobarbaz

-K
