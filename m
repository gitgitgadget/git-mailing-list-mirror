Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ECAC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiDMVsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiDMVs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:48:28 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6342EFB
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:46:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r2so3418688iod.9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Sgf3qE4qWofn9NZsqPnnydn/BYSQWaYijKEooTsr38=;
        b=vXvrpqXVTBgWxrNzziBMpEI6gHEpsOPlGvZFnDtyRuH2604R40s8YXnS4jOzmVIXc2
         nDJF9/vto+yP+18hXYC9gpZXKBftj11Ehn5MteSX+wLFo9x0v1lQdw0ibJ05/lC2X+J5
         p/jF5vDfDWkvQ6h1ymWTfSE7V+kk8g3dtQjb2wNcD7uU6f2vYl6UP6tjkSk4mriyPctw
         puBGAVOiQzK0h7Cug4Qyyf6Ir2+MN2qKhdmKr3Sc7U4T5LVCigndfrPZmqmEgYoNdB6A
         WgLyIJ3WQ4+OMojHmVWZyVc3pW696Bwbst+V/CYKPFMc9TRYlwciwRWE7ynjp14yt65W
         5Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Sgf3qE4qWofn9NZsqPnnydn/BYSQWaYijKEooTsr38=;
        b=p90ME466iB3LSmUTHNMC5Pv0B5TK1+PHFH3GsHNYj4PhnyTQo47x/4KkGlGd1msunb
         0MhrPDlxNTZQlntqNvmfd3Wi3IjgKA5iSX4JcLNOJmLiJ5Zyq5o5w+Bgff656qclT+Ns
         SjwyqgDyZkCikWHK2cUgNe/rYK4hPqoxz6DcbleXk7E93kuznbJkCMJ+Qb3oNiyq/ecJ
         0A6VJX0D2TBUbuUnIZYjSimEqyUbtVs34sDhZazk79olDjJx4Tx+QSpXkLrtoRMZ9DxT
         4/hRHkpBh4VBWtOcxDn2/JOLZ4k7n77UW76DqQXLMR71Wp+WDJHg9uS4oubluwJiOAUO
         GJ/g==
X-Gm-Message-State: AOAM533ZgnDzN0ckHCzbrVz47wVV5FxHVJ3U84S1ZKoMfa+av7jlLeRp
        FXpjGHjsM3lEXc2mqEH15PTle3Gl0tegwLhD
X-Google-Smtp-Source: ABdhPJz2julcSEGVjX3IflSCDujFO+3MmWZ537PYmdhNMWcApxGBFkCcMef26ckLQoHOgo2sTN23PQ==
X-Received: by 2002:a05:6638:24d6:b0:323:cda4:170d with SMTP id y22-20020a05663824d600b00323cda4170dmr21494343jat.269.1649886364663;
        Wed, 13 Apr 2022 14:46:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e4-20020a056e020b2400b002ca9ffbb8fesm70139ilu.72.2022.04.13.14.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:46:04 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:46:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/RelNotes: fix a typo in 2.36's relnotes
Message-ID: <YldEmwQfLo2LbDGZ@nand.local>
References: <d23e51b8dc78651dbd751473c0f8b3dcd6bc3ac6.1649883760.git.me@ttaylorr.com>
 <xmqqczhk7klg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczhk7klg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 02:13:31PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > Noticed while reading the RelNotes for GitHub's release highlights blog
> > post.
>
> Thanks as always for highlighting more interesting bits from the
> flat-and-bland-list-of-changes which is what I prepare as the
> release notes.

It's a pleasure to do. Thanks for maintaining the release notes in the
meantime which make my job much easier to do.

> > - * A not-so-common mistake is to write a script to feed "git bisect
> > + * A not-so-uncommon mistake is to write a script to feed "git bisect
> >     run" without making it executable, in which case all tests will
>
> I actually meant that this is "not a common mistake that deserves our
> bandwidth but because a change was already made to help such a case,
> why not take it".

Ha! I wasn't sure if that's what you meant or not. I think your
suggestion below is an appropriate way to remove the ambiguity. Thanks.

> We can probably rewrite _without_ mentioning our expectation of how
> common it would be.
>
>     A user can forget to make a script file executable before giving
>     it to "git bisect run".  In such a case, all tests will exit ...

Looks good to me.

Thanks,
Taylor
