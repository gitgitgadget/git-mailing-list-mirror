Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07679C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59F76121E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJUNnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUNnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 09:43:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B3C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:41:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y11so436330qtn.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0n9ia/VYje618CU7TCjL14wywhB7AYwd+tkZ/s4TsJE=;
        b=XGv3thaQzyfjD3Zmc8x/iwxnVJS8qzytCJjnZAHGD+shQdQESN0w16OzZF9qGFGpJq
         vqQ3Q/x/w4PVNhBjCjvfI5AF0dTKSTNwGDFVVOlCQf6mjjiUOby1Mf5xmUi4l+KbrPrA
         1J1NQgPpGmadj8bDFy7lgroqft4dL1KhCSvF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0n9ia/VYje618CU7TCjL14wywhB7AYwd+tkZ/s4TsJE=;
        b=MOxOPbmfpD7d+ChEew956Ov38JAR05rl6nPXW0fmdIgJq6DN2mX07vIbb3tIlndqkL
         5Vat5Mm50Yjkn02eVF6HHsz/Zk+zpvFgATLfo/EF1xd4mhbLogt2ZTPhlaNmUwqjn1Vi
         ksRmxxnDc38Oaeo3sZyFc6uT1bl0AxT9BlSiLsWYhcwYMHRw/yxjQbe/lTh8ICBREO2g
         H328elBQlp+qjKQAiRHpSl2TnLIQWoAaTXenHXjAmYn2Q10cAa99DuHtPyUDBA0Cx+fG
         V9sGrsJ+Q7kpf4mlbQdgOpYeyIwgdwlV3KrjTYzoKRLI1Tbk53vrcWcbCsXEq36G9kUI
         28iQ==
X-Gm-Message-State: AOAM5307M8O/ZyQ6S5AmAU2OKibuYR9bYTsqdhyv1DhedN4phjB4JXOc
        LwgU/GL35UzbD1LgA31kDaqPSSP0EYlyiQ==
X-Google-Smtp-Source: ABdhPJyjf29SDfb7ZjPvOSktP4Lyrb4CoyruY37xp4yO1teD6m7lEugsNcUupKWp+wvDvby95ceV1A==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr6049557qtx.43.1634823667211;
        Thu, 21 Oct 2021 06:41:07 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id m6sm2447726qkh.69.2021.10.21.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:41:06 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:41:05 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [Summit topic] Improving reviewer quality of life (patchwork,
 subsystem lists?, etc)
Message-ID: <20211021134105.ziqmcknnpdsg6cvc@meerkat.local>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150460.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2110211150460.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 01:57:11PM +0200, Johannes Schindelin wrote:
>  2. Dscho said he’s not able to follow everything on the mailing list
> 
>     1. if you have just one patch you send, reply-all works okay
> 
>     2. mailing list works reasonably well if you’re someone like Junio, working
>        on it full time, has good mail filters, keeps up to date with everything
> 
>     3. If you’re in-between, does not work well

This is a problem that's not actually unique to mailing lists. If you have any
project that is popular enough, at some point it reaches critical mass where
developer/user feedback becomes too much for anyone to keep up. Github
projects aren't immune to this either, but they do have a benefit of providing
an easy interface for someone to apply categorization to issues/discussions.

One of the efforts currently under way at public-inbox is the "lei" tool that
should allow similar workflows for mailing-list based interactions. At some
point we will be able to provide both topical and search-based subscriptions
to subsets of the mailing list traffic that you're interested in. Search-based
subscriptions will allow you to monitor the list for discussions relevant to
your interest (e.g. patches touching functions/files/keywords that you are
working on). Topical subscriptions are a bit more complicated and would
require someone to actively categorize mailing list discussions by keywords
(e.g. bugs, suggestions, security), which would allow others to monitor just
those aspects of mailing list discussion. The latter requires someone's active
involvement and dedication from the project side, not unlike for categorizing
issues reported at github or any other issue tracker.

If you're curious, you can see my presentation to Linux Plumbers last month,
which is here:
youtube: https://www.youtube.com/watch?v=mF10hgVIx9o&t=1490s
slides: https://linuxplumbersconf.org/event/11/contributions/983/attachments/759/1421/Doing%20more%20with%20lore%20and%20b4.pdf

>  4. bmc: I want some way to track patches
> 
>     1. What have I reviewed before and what have I not reviewed since last
>        time?
> 
>     2. Emily: most of this exists in patchwork. Our intern Raxel Gutierrez did
>        work on that this summer. Alas, that doesn’t show up on
>        patchwork.kernel.org because it’s using patchwork 2.x and the features
>        are in 3.x

3.x is a bit new still, but chances are we'll be running it in a couple of
months. Unfortunately, our previous experiences with major patchwork upgrades
have been a bit thorny, so I'm trying to approach this carefully in order not
to impact other projects relying on it. (Not a dig at patchwork folks, just an
observation.)

>     7.  jrnieder: there’s a bugzilla instance at bugzilla.kernel.org, which
>         might satisfy CB’s criterion
> 
>     8.  bmc: I want to have whatever we use send out to the list. That would
>         avoid conversations going on without people in the mailing list centric
>         workflow being aware of it. If we are all using a GitHub/GitLab based
>         workflow then that’s not required

Bugzilla's mail integration is fairly good and list-friendly. We have several
projects that largely interact with their bugzilla via mailing lists
(two-way). Note, that someone still has to do things like closing and
recategorizing bugs through the website.

Note, that the initial bug report must come in through the bugzilla web
interface. There's a way to create bugs via incoming mail, but it works very
poorly.

>     13. Junio: Not really. The extra tracking conversations are not as
>         important to me. I think it’s a feature that if someone requests a
>         feature and nothing happens for a while that it no longer produces
>         overhead for people is a useful feature. That kind of old filtering
>         feature is sometimes valuable.

I find that if there's no mailing list integration, then bugzilla generally
rots after the initial person getting the bug reports moves on. Then bugs
reported via bugzilla just sit there without anyone paying attention. At least
when bug reports get sent to the list, the ensuing discussions get reflected
in both the list archives and in bugzilla.

>     16. I’m also happy to work with kernel.org admins to get this set up for us
>         if that’s what we want

Consider this part done. :)

-K
