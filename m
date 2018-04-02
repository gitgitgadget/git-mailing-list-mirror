Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB241F424
	for <e@80x24.org>; Mon,  2 Apr 2018 09:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbeDBJ3o (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 05:29:44 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36083 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754124AbeDBJ3n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 05:29:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id x82so25786802wmg.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=R2qGqIJmxRMwLN30WKnZqnCYlbQ0MvFoVbL+gXWgHzw=;
        b=czhWcIbEILSY4RtPzFHOvz2OzT0WU30maPOQ5dPhy9nxKZYOV99GaEE7A9ibyUtdUI
         fwK8NIWGhU4l9ZesbUZpqf7/dQFDfoJ3/O3dN5EsgGu92ur7VTe66vx6VIznKQX6mdVr
         XpzhQs733ZdT07AQo7cgV/gFBLY7DT37fpZSkQQsfQiKrYsnYvZiRK9yEtn2LE3ssEcU
         r8L/5fWY1G035dINYQjC48QgRqQaO1tQUYF4buPKFrJQ2CR3Ublqh3UYSLD8ssuhE1rq
         KRl9RGCoX9EFxRcvf29bvyDmP2Uv/TCHrT74WfICTxbxrxagAi+DdeWB5Yyj92KnSHVy
         2Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=R2qGqIJmxRMwLN30WKnZqnCYlbQ0MvFoVbL+gXWgHzw=;
        b=bGldA29GHbhS600FCEBiUBOAjijzts4fAogb4i5vcWwBmLLcVyOTVBgwq+h7qB8RQh
         7g1tBjP8mbE94fPbFxr2Y9Ww/LqQ1oVIj/vfynDAYmhXm997uSefy8XT4Gg5IbQ19XUY
         b2q/3GIQ4wXHlj67jBJw/8bOokj0mWQU+Smrq9etl70AJZCEc1m9jB6i/ZVeC8jitBhu
         X/mCGVUWIlgSHydh1AVkxcIWVCLfmR+v6GnUBrefb1agCqByyhP82Kex1EGc6n+taeNW
         7/6DSS7UO5enQnlx6kWrWBdN90UyJku/snW/XZJeiyyHZFCO/VpQxzeVaZ0Nl/KXb4QT
         ImuA==
X-Gm-Message-State: AElRT7EgyM36UIfm0z5RXJ2YwqSEAcutqOVtmskLczZ4zQwT8fwDD+Xf
        7790fqGDPct46dTmIz4ncmc=
X-Google-Smtp-Source: AIpwx48ZeEksfavxDhDRXau5Ec5XEzMggrchmX7zltehk91JENL3Ll0xthqsVJtEIadBulnbx3zy+w==
X-Received: by 10.80.184.34 with SMTP id j31mr12234418ede.103.1522661382809;
        Mon, 02 Apr 2018 02:29:42 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h56sm150510eda.20.2018.04.02.02.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 02:29:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git clone add option to track all remote branches
References: <20180402015035.mzgye6apwn3igch5@HP>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180402015035.mzgye6apwn3igch5@HP>
Date:   Mon, 02 Apr 2018 11:29:41 +0200
Message-ID: <874lkuvtve.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 02 2018, Yubin Ruan wrote:

> I am writing to ask that whether or not you think will be appropriate to add
> an option to "git clone" so that whenever a repo is cloned, branches are
> created automatically to track corresponding remote branches. (or is there any
> equivelant option?)
>
> You can obviously do this by a bash command like this
>
>     git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done

Aside from this specific suggestion, we should be careful when adding
more special snowflakes to git-clone that aren't available through
git-fetch or via after the fact config, such as git clone
--single-branch which has no fetch equivalent (i.e. in finding out what
the remote HEAD is).

Actually now that I mention that it occurs to me that what you want
could just be a special case of generalizing our existing
--single-branch feature. I.e. we would clone repos as:

    [remote "origin"]
    url = git@github.com:git/git.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    branch = $symref(HEAD):refs/remotes/origin/HEAD:TRACK

Or some other such syntax to create a refs/heads/master from the remote
HEAD symref if it doesn't exist (note the lack of a +), then for your
feature:

    branch = refs/heads/*:refs/remotes/origin/*:TRACK

But you could also do:

    branch = +refs/heads/origin/*:refs/remotes/origin/*:TRACK

Or whatever. I don't know what syntax would be sensible, but something
like this is a missing feature of our existing --single-branch feature,
and because of that you can only get its semantics by re-cloning.
