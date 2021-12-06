Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C580BC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 13:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbhLFNhw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 6 Dec 2021 08:37:52 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33777 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbhLFNhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 08:37:51 -0500
Received: by mail-pf1-f179.google.com with SMTP id x5so10216082pfr.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 05:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=84GKrSKUXchOQkO0hwIAt4y+T8+szq9dzNH7cvPiDHQ=;
        b=l7k/f3WItY+KFPduzWWi6vDGF57XXIahWg5Hy0gY8IaN09rfH+UiRgc+lKlYYyTiZj
         qJG5qmPLbLfUSODKe/DTtwyI6m++9BKCixGMXXjbddWsNMmzTLwA4iEGLV86QNMpybp2
         YYxeP/hS3eVDXWmjCii5ZBNGT4yIhEO1Rpm0R76EdZf5Kn3ktAZaP2tlhcCUcPGT9m7S
         /TULRnXsbuC1CVzDUPn1txCo+hJO7VV4t6i96qyg+aYM2QiC+2DyiFdmuKyL035Hlbmb
         vQweU54IhUbs/BbN2cm2JnmAUHkTNvu7wVYgXXfdJPaB0f3ZSX6p+ZNoj8UkAaGeEx3S
         caog==
X-Gm-Message-State: AOAM533TxYzWCavH7OxZAvaJGcnAkSdsQW0cKvXHHVPqdM4meSKVN/+0
        L5knO+3n6APnE14gaC292RxEa9csRtSif/tBt1chdhzciEH/RQ==
X-Google-Smtp-Source: ABdhPJwxNxB4+3nlHDEWBrSd1rLde+UHVjR0as4deE3gOsj8bfKV5YnwJFH+8uWZ3Lvtl+UxRcfNqNGB+m+Vii6YYFw=
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr36687932pfj.15.1638797662541; Mon, 06
 Dec 2021 05:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-3-sunshine@sunshineco.com> <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
 <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com> <xmqqa6hfmn3u.fsf@gitster.g>
In-Reply-To: <xmqqa6hfmn3u.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Dec 2021 08:34:11 -0500
Message-ID: <CAPig+cQ82UC3MRSswGtnCcB13wdhTNYzDex=tFSuFwFCjL3ErA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 5, 2021 at 4:12 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, Dec 3, 2021 at 4:15 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> Aside: I've been thinking of hacking something up to just change all
> >> these "[verse]" bits in the *.txt source to:
> >>
> >>     [verse]
> >>     $(git worktree -h)
> >>
> >> And then have the doc build process pick that up, run 'git $name -h', do
> >> some light search/replacement (e.g. "$cmd" to "'$cmd'") and build the
> >> docs like that.
> >
> > One caution that springs to mind is that there may be external tooling
> > which processes these documentation files directly, and such a change
> > might break them. (The one which popped to mind immediately was the
> > git-scm.{org,com} website, though I don't know what their tooling
> > looks like.)
>
> Also it would slow us down by making the .txt variant we see in the
> source tree harder to read (or in this case, impossible to see without
> building the documentation).

Taking this point into consideration, a middle-ground alternative to
Ævar's idea would be to add tooling which only compares (by some
definition of "compare") the output of `git blah -h` with the synopsis
in `git-blah.txt` and complains if there are significant differences
(by some definition "significant" and "difference"). It doesn't
automate-away the work of keeping the synopsis up-to-date, but at
least would flag inconsistencies.
