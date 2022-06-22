Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9091CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiFVUvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiFVUvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 16:51:37 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9813EF27
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 13:51:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q4so14900791qvq.8
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qk2mtj/724Z7rzH+aYupU0IbBE02j7Xz4ln9ogK7dTA=;
        b=4j2krBb/eybnZiCWtAX0zfuKP4ki3aF4lcRgXmcWJ50PTx8na4MnU+eypFzhkxefDk
         RGFoLxIGt0kuEAowAdNkdTMSwKwMl0a/72H3UEcVcPjPtzO4+wR/u444Ca6/viydG2Ft
         Nxcy81a4GPFYa0o569bHDM8CYlK+VBV5ELObhIDwRuUDUW3jcSf5FX1XckDxxF1qzOpR
         SzhN9pPkP6cjE+/PKWNlfsLN2nLB+VWnl6T8+APQCOawqwxYyBrqJ5oPSCBKiwXCoQbS
         ZKbdJB52W6HNh777QahP471dXcx8SHvaC5ZSI0yjEjOYQEcZC/cxVfBMAoIensO2Cf4v
         gVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qk2mtj/724Z7rzH+aYupU0IbBE02j7Xz4ln9ogK7dTA=;
        b=nq7/YY3PCrb5o8h+YzJMpOLziwEHNV0cEJSE5i+lUgUtF5OYXmGl8shQrLxPqvM498
         v/x8SrLEOJ4ghHFdIFrWvh1EW60dTedNEVTno8xR8vVIN7bhlCnVdc+8/zhzwspbt/Qd
         F280q52KuxWVlfZ4pe/1lCQMgtKqXTIDZfJC2epCFJUJ/J0fxD6y5Et3QBvw/GVPSa1+
         62wQWh2V1heUMS8A3WVweb7t0ecKgXu/m8Rx/9bq+hwZOUyVdpyBpkiOcdsSZIzOSSM4
         Ijvnuirs08agIJ49RaaGPJsZtR2Kqr92WR5xZxvVM2bpoSAG6QtQ0tvQzNyJMyvbBNpj
         umyQ==
X-Gm-Message-State: AJIora9uffwz9vWeIEUC18MFoqj3EgHmeAG//A7/iE6D+IcNFQnEyMV7
        feeWCSV/hG4LAHGLFUSX9QPkhbGCZzLU+xvE
X-Google-Smtp-Source: AGRyM1vdU80tboM89RE/jZjIe0MC4knRV+74HwRNlDYUzTQ5deoL2YV/TwJoRrlNnYvTB5RV75Refg==
X-Received: by 2002:ac8:7f10:0:b0:304:e88d:b6c1 with SMTP id f16-20020ac87f10000000b00304e88db6c1mr4871330qtk.364.1655931095732;
        Wed, 22 Jun 2022 13:51:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z2-20020a379702000000b006a6d20386f6sm17270569qkd.42.2022.06.22.13.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 13:51:35 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:51:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] Abhradeep's GSoC blogs
Message-ID: <YrOA1hHc3BJiygqV@nand.local>
References: <20220620104441.10413-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220620104441.10413-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep!

On Mon, Jun 20, 2022 at 04:14:41PM +0530, Abhradeep Chakraborty wrote:
> Hello developers, this is the thread where you can know about
> my weekly GSoC blog links.
>
> My Project - Reachability bitmap improvements
>
> Blog update
> ------------
>
> Title - GSoC Week 1: Let's Get started
> Blog link - https://medium.com/@abhra303/gsoc-week-1-lets-get-started-fad78ec34dcf

I really enjoyed reading your blog post, and would encourage others who
are interested in your work on reachability bitmaps to check it out if
they haven't already.

I think you did a nice job explaining some background on what bitmaps
are, and what they're useful for. I also appreciated your initiative to
identify and improve gaps in the Documentation/technical tree ;-).

Now that that series is on the list, I can tell you that you did a great
job of turning a WIP patch into a well-structured series. From watching
and participating in the thread, I think that review is going well, and
you have some interesting areas to look a little further in while you
prepare a second revision of the series.

Note that the Git project is going to release v2.37 next week, and so
others on the list are likely more focused on ironing out any last bugs
before the release, so you may see some more attention towards the
middle or end of next week.

In the meantime: you are doing a great job, and I am looking forward to
seeing another revision of your series! Let me know if you have any
questions in the meantime.

Thanks,
Taylor
