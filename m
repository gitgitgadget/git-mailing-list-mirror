Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C360E1F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439616AbeKWXmA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 18:42:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40959 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439604AbeKWXmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 18:42:00 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so8723932ioh.7
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIrwoeZgQoeDQDwxMd0ylMBhvh0qTNOwJKYGAY1dOcI=;
        b=JxZl6bacW0nMNkQjP8icCJrPVD1Gf3Nv9WYKSqVcC4w7bG9P9/dx0W3swkb3IQ/C2j
         dgsfcKblEtnO2F/URQXjTD1G7C+ZDbaDCAg40wLAqa6lK3xMtkmdKOKrRwrqizdk8Dth
         AJxCnpru16j+8rqff9uGvVCGw3fYkfRFagHZOo2cV0PWqIEw7tJzoFsg7+ndtMQAfHg0
         DMbkB1OZJFIBTKXy+Blc6kWqcqMhSk8MJpv/WLT5DjuFeSLeIs1YVUxM1CwRP83oX8nw
         Sle1wG4iQ8/H+5fXXFPk6bDDsN9CXPf+i9xmJBcGeKy88AVvbbvgRYg00cMcYHgegnS3
         unjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIrwoeZgQoeDQDwxMd0ylMBhvh0qTNOwJKYGAY1dOcI=;
        b=jaKoaZvyfZvJ8mLb0lB3w62IRUQb/EFuXV3xpLk0tCTUB9oACqg/HTo42jOXxAtmCR
         erC7Vc0u/XMugY7/3uX5OiI2gBzxDSkLKKOprr5Ov/IoLHlfVUT/C7ZXxQKoWu/MLKWp
         d4K05UBtj9iB3zSlsEprRriWiO/+Nqtn4z+nJv90NrWcPF4EXiCPPJCzBdZcvycuiU7C
         C4BL7EA/tBTrqmsPGV0CT5aUu74RM8pL/6JyJdXb5UacEcDUErGAQ7mqJOsEATGEdlWr
         n4jOohOzI6hiWkpEcSKjp0Yy5kfL6JLjS1Y1GFBpIH2H4UWj29esiMjwNyrepW2+PjN2
         +Y1w==
X-Gm-Message-State: AA+aEWbk3HPYKp42NwcBDTPpW7JkiUB7B56NRYKFA3t94f1ahTHuveLl
        tRAPaMgKkc1IMBBiCcSDiuKS6AgnsOtRS/BAxP4lpnGT
X-Google-Smtp-Source: AFSGD/WEgwMFlOUiuULQf13+cYzrUZW+71HrIdDnd63FWL45jD9EIQm/6Hg10b6JUp4ys1X1ByTkxlG5R5CeHDSYVTs=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr2413647ioa.266.1542977874349;
 Fri, 23 Nov 2018 04:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net> <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com>
 <20181121224929.GD5348@jessie.local> <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com>
 <20181122063714.GE5348@jessie.local> <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com>
 <20181122161722.GC28192@sigill.intra.peff.net> <20181122234346.GF5348@jessie.local>
In-Reply-To: <20181122234346.GF5348@jessie.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 23 Nov 2018 04:57:43 -0800
Message-ID: <CAPUEspi67=Kt=mx21bjG2oCATnU+byO5nkvbMdQkN03yBGZMsA@mail.gmail.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
To:     max@max630.net
Cc:     peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 3:43 PM Max Kirillov <max@max630.net> wrote:
> also edited the test to include only push_plain case,
> and repeat it several times, to avoid running irrelevant
> cases, the failure never happened again.

as I explained previously[1] and as odd as it might seem the
push_plain case ONLY
fails if your run them together with the other tests that return
errors with compressed input

frankly I don't understand how one could affect the other as they
should be running in independent processes but it happens fairly
consistently in NetBSD (tested 7.1, 7.2, 8) with only one CPU (tested
i386 and amd64)

Carlo

[1] https://public-inbox.org/git/20181119213924.GA2318@sigill.intra.peff.net/T/#m041e9703432c39dcb04fe10e86fc53d5254474b4
