Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD2C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbiDKPT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiDKPTL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 11:19:11 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B893BA4E
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 08:16:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x20so4197934qvl.10
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z8cfX+cYiB5QKdL0ThlA0XiqTdniPVzlWTB83IZQ6/s=;
        b=hSsGrV/hnAT+mr4o7OOxJNJWymJwahva574UXwTF0o3A7JzQnTt5a+0Jom8ped5NRd
         M1kYB3FBosiRHM/xkageT87Tktn+9e4F+eV8iw6464+buwPIQOb83ts9IKSQaiDQ5ymw
         oBnP4G+/2Xk2/4M+KkLuaP5+sjAyXv6FaaL28u6Y2CKuWTBr6Kk66GxHwRLqhDkugah9
         5C7z1b9/zz56W0WIwbTtk3Aun3CJKuVYgDbBXd1Xti3HAYvrNQTT1Uyo77+cD2Xasqkz
         kJlsG5eF51B0A+bSonMtri+a0/OBewH2KyF8TPlisjGksSdwceRDL2jT1NbJzuCqy4D6
         ydZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z8cfX+cYiB5QKdL0ThlA0XiqTdniPVzlWTB83IZQ6/s=;
        b=xSKGfdQEuOPaNuhEFX4G7IA98vHVk+uWHaD5ybp0SIev6+0I7Xt0bor7RR99QmYU0B
         FAcILv6eanvMRYNA/35kVqQA9jBQpSxxjceJjWdf0EZjAlcjUNiw+wHYacY9TxPv46AD
         Ap4+7V9sZWzb4AwlomVl7Z2BtT1wboNAdBvOvKJEnLlRKMoIl59z8I3qelLagZMUHoY6
         t6kBq4JznQ/Jj++bX4bEcQfRCRXOLjQRsygNWgCNllwegk/Xos6W5LEFHVEeGP1fuxfy
         dJl/fBB6dpBbtKSlAhpOkXUsKeaK9sNQQKSDWqm3HlcQLXD6v7MYDI4F7urYiWTMkF7w
         gAog==
X-Gm-Message-State: AOAM531vcr2Vqz9/im4QVJJz7z3VluqiXPI9FvAOC4k2i3QMWT6Bw4x6
        De2eIqRf2y6Y7+A+xccOuowP/H6xRll1f5wW
X-Google-Smtp-Source: ABdhPJyI3Gtp5HuaKpi//MssObIIQ5Of+oTbCKiEiGKnEMtFOUR+0XgPUPKEhNr47o4rwEZ4ELU+RQ==
X-Received: by 2002:a05:6214:4104:b0:42c:1db0:da28 with SMTP id kc4-20020a056214410400b0042c1db0da28mr27616209qvb.67.1649690213632;
        Mon, 11 Apr 2022 08:16:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c10-20020ac87dca000000b002e1db1b7b10sm25327820qte.25.2022.04.11.08.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:16:52 -0700 (PDT)
Date:   Mon, 11 Apr 2022 11:16:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <ttaylorr@github.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
Message-ID: <YlRGY4j/YQ4zJiM9@nand.local>
References: <YkcmtqcFaO7v1jW5@nand.local>
 <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2204072346410.347@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 07, 2022 at 11:54:18PM +0200, Johannes Schindelin wrote:
> > To that end, we have a few options about what to do with the website in
> > the future:
> >
> >   - Convert the Rails application into a static site that could be
> >     hosted elsewhere for free. The non-static portions of the site would
> >     have to become static in one way or another, and we'd have to come
> >     up with an alternative search mechanism to replace the existing one.
>
> This is my preference (and I would love to contribute the time, but am
> quite short on that resource to help much).
>
> It looks to me as if the only blocker is the site-search, and there are
> ways to pre-generate an index e.g. in a Jekyll site (which we could host
> on GitHub Pages, incidentally, which would be a very nice setup indeed).

There are a few other smaller-ish things that we are using Rails for.
But most of them are limited to "fetch this list of things from Postgres
and format it in HTML" which could easily be automated and checked into
the static version of git-scm.com's repo.

> The other thing the Rails app does is to regularly poll for updated
> versions, e.g. Git for Windows and Git for Mac. This strikes me as
> something that would benefit from the transparency provided by having a
> GitHub workflow to perform said polling instead of the opaque Rails app on
> Heroku with no public log of when it ran and whether it was successful.

Yeah, agreed. Another "behind the scenes" task is running:

    heroku run -a git-scm rake preindex
    heroku run -a git-scm rake downloads
    heroku run -a git-scm rake search_index

, which I do after Junio pushes new tags. (FWIW, these jobs should run
on a timer, too, but I like to update the site with new links around the
time a release is tagged as opposed to having to wait for the automated
job to kick off).

I imagine that this would be replaced with some kind of GitHub workflow,
and the result (any new pages, updated search indexes, etc.) would be
committed into the repository transparently. That workflow could be
automated as well and get kicked off when new tags are pushed to git/git
(I think).

Thanks,
Taylor
