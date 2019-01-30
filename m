Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C7D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfA3KYP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 05:24:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44091 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfA3KYP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 05:24:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so20204814lji.11
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 02:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1igdGdZwDmI2dV/uiNq8sLiYaq+oy3+jDwf2KFdRZmI=;
        b=BKBcvwQKuWyqHoVunJtj+I5XbwW7bpwEblnM2u1U4GrUwhgPscfjogq/lNYjF2clzL
         E9SjyCUovvK5kkST+AFG4iG9gYxHIYoz3y3AxrmK+zbINow5IbZqfk5OdTrc6ISbDt7n
         Pf9sZeMTd9zs6b4c9ITNmGls53yKCsr1VWxyUHbtmv1pQv602+p7+dCFBD1asEVHj8lC
         4v2LS1o6rUX/SsVYLWsbrBRWqEvBOP47WZ8FIAX0fguBzf3xr7fnBoJnihlldZwxtNDG
         YbJQrC/GEiFSdUqS4HrcxqEirSgFMgXVgxbiNZ5a8vp0fbh1mCFjftc9z0e7FrOg2ih4
         4OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1igdGdZwDmI2dV/uiNq8sLiYaq+oy3+jDwf2KFdRZmI=;
        b=jWFA8R8QBWzseR0d30dlpqybDVWnLZVyvsFWOJzqT3WMIcCY9qHchgG6Msl8PhVA+S
         IJ0m9veOUQ4JBSonE1Wxy/Y37OJ0i/DGmUnAk+cgFxZvMztA1qW03ViRKv7YMFrCC8vZ
         9hQsyhnsWChCW7NPwNs/I/n8+6Ktj3wP7Vf1KOhnO2KAZuSnGq0j2sp8c47s1sNBSh1q
         U5Ec5CS1vJ6go0Kv74hufsQiN4YWauWhWNo6V4sY1Tv3EaN4BZZITsivA3Y3kuj2P0ub
         qxNfd/grp5h6LrOdAiuoiieZWHXqSZwVLkoTwiVyGmssGkXFSXbnWiyOC9BHjlLvqu5i
         9EwA==
X-Gm-Message-State: AHQUAuYNveDuY9I26XBWjcDWIqg5d4L1+88wGZ7m920/TGI5O4ENJ3yk
        OgbmTVVeH6uyCG1uulAzB1mMlXNasYhpoj8phXdzEe+k
X-Google-Smtp-Source: AHgI3Ia9mjZLkF4UYBNSHH0irvMbmdq828wmQCEq0Sb2FmuyJ6hTLD8v1zUi+mCl3KAXJPszg4t2KSuPYDBvpwQaQfM=
X-Received: by 2002:a2e:7f04:: with SMTP id a4-v6mr2827585ljd.156.1548843853016;
 Wed, 30 Jan 2019 02:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20190129051859.12830-1-koraktor@gmail.com> <20190129051859.12830-3-koraktor@gmail.com>
 <20190129131243.GC22211@sigill.intra.peff.net>
In-Reply-To: <20190129131243.GC22211@sigill.intra.peff.net>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Wed, 30 Jan 2019 11:23:36 +0100
Message-ID: <CA+xP2SZnmTHGd5rB8BtXMNnCoz0SEFdgT-vcgRttJxBdA04ciA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Add test for describe with a bare repository
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Di., 29. Jan. 2019 um 14:12 Uhr schrieb Jeff King <peff@peff.net>:
>
> On Tue, Jan 29, 2019 at 06:18:59AM +0100, Sebastian Staudt wrote:
>
> > This ensures that nothing breaks the basic functionality of describe for
> > bare repositories. Please note that --broken and --dirty need a working
> > tree.
>
> Makes sense.
>
> > +test_expect_success 'describe works from outside repo using --git-dir' "
> > +  git clone --bare '$TRASH_DIRECTORY' '$TRASH_DIRECTORY/bare' &&
> > +  git --git-dir '$TRASH_DIRECTORY/bare' describe
> > +"
>
> What the test is doing seems sane, but the same quoting comments from
> the earlier patch apply.
>

Ok, thanks.

> -Peff
