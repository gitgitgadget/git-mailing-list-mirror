Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF078C4167E
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377573AbiDFFFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452487AbiDEXiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 19:38:16 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128B1C16FA
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 14:59:34 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z7so879420iom.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jol9/TDZDsp/mZ1p8zEkkLSh0TRmGorWoqu3Acka00U=;
        b=Y2SmvLoGOZVkcWnp0k1ffhq9LpaW5oP4b/b9aMDeqYJyx9zH2tW5aJV5+luvDGEixe
         hnCworRdV8sS/adaAtKE1pLLOoe1xE5AB2f4/JKmq9l487UtY2fGewkN6isLGdZMSwq6
         gLkjgE0SgEQBQxm7V7AWWGyisd5ZlC1MUisfuj8hhzr5TY3wEE1T2Xcctxb5JHCVQR+L
         IcYjEfr6teSxo6gOAgMsDU3JacAhVv6yA1pcM+PDMna0XsOSpXBw4tN5oqKgXkOqvb/h
         tUXdy+m/JlSjKRTRZJz/b8jtUyWmNDsOc7Jn0TyRAepLBc1iep/gKgPXNJ31wqb6F9pz
         5OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jol9/TDZDsp/mZ1p8zEkkLSh0TRmGorWoqu3Acka00U=;
        b=C0J8udiEBrhDJjwXenjD1HmYNXLH6UfzZ+YmL/gANWFA5nuDtNpaH0eKw+s4cNpNvu
         HRrxMmUjH1dDB+r9UduARVjMwijNk1+ufjPFY9T+Psuyp6K4TVN4x3t8qv0UMkGxSj4O
         TI/8kXstorClJZrysUeumXGnCaU3SN0u07hVQ4VWGowAC7B3dmFvWiM4M4zGvgGVgd5+
         prJbmwnmzP+7oB19GmaR75iJhVyzvSI5gNHBhTdi35II6TZedhWFYL41Fas3u2FmLkSi
         rXfPc5SewZfpnIX3F0vkgGiA6xqQV2pdM4kTX8JoHEeU6WJl9Bo3BShVBUPFrs1rWBVU
         +ZVQ==
X-Gm-Message-State: AOAM531l6x0I2zEY6LxcHKFoO0WdVx6+v69sus7g3p2hn14slHwF/pFI
        0tD4jsuF3vzbQZH01ra0NwbGyw==
X-Google-Smtp-Source: ABdhPJzY3vmgBB/yBRPFqgZOwqdyAFGfVqgmW+6jMEhBaWHpUL6l/Jas/ktLg4EjGH4VPy2fsO2KbA==
X-Received: by 2002:a6b:cd0c:0:b0:649:adb8:79eb with SMTP id d12-20020a6bcd0c000000b00649adb879ebmr2592672iog.138.1649195974264;
        Tue, 05 Apr 2022 14:59:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b11-20020a92c84b000000b002ca2fbb582asm5354775ilq.25.2022.04.05.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:59:33 -0700 (PDT)
Date:   Tue, 5 Apr 2022 17:59:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, shivam828787@gmail.com,
        kaartic.sivaraam@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <Yky7xb7nQRR8Vqtj@nand.local>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Plato,

On Wed, Apr 06, 2022 at 12:43:59AM +0300, Plato Kiorpelidis wrote:
> Hello,
>
> I'm interested in participating as contributor for the project
> "Reachability bitmap improvements".
> The area I'm interested in, the most, is the alternate compression scheme
> e.g. Roaring+Run, however I'm ecstatic about any bitmap performance improvement.
> Expected project size I'm targeting for is large (350 hours).
> I've already completed my micro-project and I will submit it in a few hours.
> I wanted to be sure I could submit v1 of it before committing to
> introducing myself.

Hooray! I'm delighted to hear that you're interested.

> I've gone through the mailing list and looked for other candidates that could
> also be interested in this project. Shubham Mishra is also interested.
> - Could we collaborate on this project considering how broad it is or only one
> can be selected?
> He/she already has experience in open source and has participated in
> GSoC before.

I think there are a couple of options here, since we have a handful of
bitmap-related projects that are all up for grabs. If Shubham is also
interested in working on implementing Roaring+Run compression, then I
would be happy for the two of you to work together.

Alternatively, if you each want to focus on different sub-projects, I
would be happy to work with multiple students on different areas within
the reachability bitmaps subsystem.

> I should note that the best case scenario for me is if we are both selected,
> probably on different bitmap performance areas under "Reachability bitmap
> improvements" project, however I don't know if it's possible. It probably
> depends on the mentors listed for this project and the work load involved.

Yeah. Even though I'd be happy to work with as many students as I have
time for, I'm not sure whether it's possible within GSoC's own rules,
much less whether or not it's been done before.

Christian (cc'd) may have more information. Christian: is it possible to
accept multiple students for the same GSoC project?

Thanks,
Taylor
