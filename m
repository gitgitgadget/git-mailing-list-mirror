Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF761F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 08:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJJPZL (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 11:25:11 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:32789 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJJPZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 11:25:11 -0400
Received: by mail-wr1-f48.google.com with SMTP id e4-v6so4595064wrs.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ldlhMc2sdedv/KcWZVnYcE6BdIoLhcBdf7uBU48MO6g=;
        b=D6bDWjab/yqljCc5nwqblt4eOfVg/prqgPGyewv1G/f9Nb3A49hBb4fRTAnzZMCYXz
         wwTGbXSIltTelJU8VpPRBy1ZhzwyJg7Bg7IeC/KIP0TkH+VGM1zeQd14YTxAM/wilP/R
         Ac7iOscx6CeVQLndevKlRMw1gee8vpMtl1IZx0kjb/KYIINkauZLBBzF+QPyX02Y7QUD
         I8GzPYdMEt7C/SWq8GypkBZ1nGhH8KPg+AGi84FOczOdyACWj71gIzcOLk3tOQzyxjcJ
         j9pRRcLjSdsGMIEgDJhXpwUKJuOEftkg05XHWawuSFtNd3xSH1XWcVKLln/WoTebIGA+
         LftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ldlhMc2sdedv/KcWZVnYcE6BdIoLhcBdf7uBU48MO6g=;
        b=iA8wbDMGCIVVRjyzC+n8sU1QtGjXtD48pkDAU3D053d5RHZuDUq9RNymk7zRWNxxt/
         O09D387zF50dmsZeaofEMuElMvRBLp4Yvx9qmGIJ6gymXcW+OI9gBp0yBUgsMUY/jfSS
         DsSpUxLTOl+2OgGhjNZ6m5FjekWDP0y3fhAhlfM+ISBUg5hTTnIpj4iZvdRHQcYHtamC
         t0duALJl4UP139ZyDi6ZXJsn8Gvn8pU+8h6BvFAMeUj26TxKawrkP2s9uTS2hxMAC6G2
         x3NIOHoLwDP/ViIcYCPsbYRxZ2hNW4ihIX+MUyIFL8QD6tjjJyPfNDTe+njIO9NBVyVQ
         M+dA==
X-Gm-Message-State: ABuFfoh2uqMxN09ob0wOh9AWSpX1htgevD8eiNp8mSqxEslhq2sTOYNU
        NtBJ9mMa0F/39D09sXsXZMZcdyJl
X-Google-Smtp-Source: ACcGV61lAdzu+8hXMoA8a0z+UmF8fJZnXMb/OEfPx2Qs9gg5okb+wVBFsq8b3mN974ps/YiN9TTbUQ==
X-Received: by 2002:adf:cd0c:: with SMTP id w12-v6mr23613103wrm.67.1539158650564;
        Wed, 10 Oct 2018 01:04:10 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id t3-v6sm1291671wru.47.2018.10.10.01.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 01:04:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com> <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
Date:   Wed, 10 Oct 2018 10:04:09 +0200
Message-ID: <87d0sifcsm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 09 2018, Martin Langhoff wrote:

> Hi folks,
>
> Long time no see! Importing a 3GB (~25K revs, tons of files) SVN repo
> I hit the gc error:
>
> warning: There are too many unreachable loose objects; run 'git prune'
> to remove them.
> gc --auto: command returned error: 255
>
> I don't seem to be the only one --
> https://stackoverflow.com/questions/35738680/avoiding-warning-there-are-too-many-unreachable-loose-objects-during-git-svn
>
> Looking at code history, it dropped the ability to pass options to git
> repack when it was converted it to using git gc.
>
> Experimentally I find that tweaking it to run git gc --auto
> --prune=5.minutes.ago works well, while --prune=now breaks it.
> Attempts to commit fail with missing objects.
>
> - Why does --prune=now break it? Perhaps "gc" runs in the background,
> and races with the commit being prepared?
>
> - Would it be safe, sane to apply --prune=some.value on _clone_?
>
> - During _fetch_, --prune=some.value seems risky. In a checkout being
> actively used for development or merging it'd risk pruning objects
> users expect to be there for recovery. Would there be a safe, sane
> way?
>
> - Is there a safer, saner value than 5 minutes?

What you've found is the least sucky way to work around this right now,
but see my
https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/ and
https://public-inbox.org/git/87d0vmck55.fsf@evledraar.gmail.com/ for
some prior (and recent) discussion of this problem on-list.

FWIW this has nothing to do with git-svn per-se, and also e.g. happens
to me when I do a 'git fetch --all' sometimes on git.git.
