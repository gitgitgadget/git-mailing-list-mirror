Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8760E1F424
	for <e@80x24.org>; Wed,  9 May 2018 18:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935291AbeEISV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 14:21:56 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:33882 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbeEISVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 14:21:55 -0400
Received: by mail-yb0-f170.google.com with SMTP id b14-v6so12669331ybk.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1JlSjK1+mbrBltybAzGXFnfVY1awiD9stvoCWEqCu/Y=;
        b=SYOtHTzGBP3pqRTPmpN5w1Wiph/FAITI1wgOLBrdRSJ74Ti+h5RjwzjqlDxYcZ0/V5
         3vmCGDTbF7GF9JMm0u53bxTtAViLHZR94UvgHB2/7xBOQr5CqJyO0scZS6T4nfAtd2tT
         vY68fUGyQAoAJ2DgVPdx+itXlJcirEWO7Y9SrLgfyzdZqwyRiEAY2feicKZtU0wvNA+m
         tsJ0W8hu4D4vV/0ag0tt4j2N1iWWmV6c4o2CAcm2S1uqdYnEmy7Bq1p9tvn300kjeWne
         bQVKOHxePrKlLKQufsrtqQFRkXStTsTMuzhT31vJDs7IG6QFPd1LX5pGa9JWs23KpYsL
         QWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1JlSjK1+mbrBltybAzGXFnfVY1awiD9stvoCWEqCu/Y=;
        b=FicHPgQT+/CAlSagKPnQmIlRl8preK0uSRApfLCiThHnBnmK9VWJqmncOYAQVVYRBp
         M3OVNRm9FR+EYvF6HfR/9q6+M6mg1rvJ85vsrb7EzCcMJCC5d0MVvCb3fBAGeDMofUyB
         qxclmHbS+rqYY8hRKdehqO/ObG/exXGAmiP2+OyKqqWndyqjYfGuZnhR6vdZyhs0EvP0
         JyBCjshKPVx3/HLrhnZHaXgHklRjzk74sITvz5Xm2ItqVVDGutQVsR728y8Yo0qZgm+w
         xJcG/tLXerdw1VoPkgaWY/cHz9RvhPutzkcdB+MX4b7x9P+HggQTczw3BnVngl67ngyK
         4kAw==
X-Gm-Message-State: ALKqPweEEd2K6WIYxBSHsk7tpPCbBRpGhQvSa975iKJ3Hqk8zHtdnxDh
        PBawRjYEOoxOc0fGnbQKKAOCNtVF+BFNETIZTdVJFQ==
X-Google-Smtp-Source: AB8JxZrQxO1S3ihSexrZ9tfbldWVXPIC3562PMk7Y8rr8y47QPkKPYkUqXLaIeMMA26o8fkr8axuopJ6fzXe7u9htvI=
X-Received: by 2002:a25:1907:: with SMTP id 7-v6mr3500856ybz.292.1525890114453;
 Wed, 09 May 2018 11:21:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 11:21:53 -0700 (PDT)
In-Reply-To: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
References: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 11:21:53 -0700
Message-ID: <CAGZ79kb05U91_Ku7DKuwQVCrtouYwGWTCPdJFQ=bgWo91inRGA@mail.gmail.com>
Subject: Re: Is rebase --force-rebase any different from rebase --no-ff?
To:     Ilya Kantor <iliakan@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Marc and Johannes who know more about rebase.

On Wed, May 9, 2018 at 9:01 AM, Ilya Kantor <iliakan@gmail.com> wrote:
> Right now in "git help rebase" for --no-ff:
> "Without --interactive, this is a synonym for --force-rebase."
>
> But *with* --interactive, is there any difference?

I found
https://code.googlesource.com/git/+/b499549401cb2b1f6c30d09681380fd519938eb0
from 2010-03-24

    Teach rebase the --no-ff option.

    For git-rebase.sh, --no-ff is a synonym for --force-rebase.

    For git-rebase--interactive.sh, --no-ff cherry-picks all the commits in
    the rebased branch, instead of fast-forwarding over any unchanged commits.

    --no-ff offers an alternative way to deal with reverted merges.  Instead of
    "reverting the revert" you can use "rebase --no-ff" to recreate the branch
    with entirely new commits (they're new because at the very least the
    committer time is different).  This obviates the need to revert the
    reversion, as you can re-merge the new topic branch directly.  Added an
    addendum to revert-a-faulty-merge.txt describing the situation and how to
    use --no-ff to handle it.

which sounds as if there is?

Stefan
