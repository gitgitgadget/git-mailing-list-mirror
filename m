Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BEB1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 10:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJSSpj (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 14:45:39 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:32982 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeJSSpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 14:45:39 -0400
Received: by mail-wm1-f52.google.com with SMTP id y140-v6so3787925wmd.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bmVkySyAznuOZtOJpW0RagN/M1dtsuV46YCSwK9ouis=;
        b=vG512kwJl1tOuF0Ty/R85YWJi99sHc0U+WlIKlKiAweFTefD53npGMVNZt4CEtLRST
         IOYVw93zjW/csnEVlSbtwv6ev3LJWX77Si1XezJzINg6jH09denNB64yEINq2NhuGsE5
         yjeEjUfBASB4+Q1qCwbXsbR98KUssJrDD9uRoVT7/5+VgkoCC+oaJD7D58d3wDhVKciq
         U7RJdWDkBqte9Jdns3czI4ZilJGr91dWJ+1ha9wCVEd0W62sEy/WYPtni1YIcghk0E82
         HlDJ1miTv9LVjOmfR/dwbjKYpVz7aAVFvsdTy07zasZRb5rdVkbJPf4iYFMMxXhIsqxd
         w0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bmVkySyAznuOZtOJpW0RagN/M1dtsuV46YCSwK9ouis=;
        b=ZdJ375onEwqQX0CeTm64n5J4iO3LyRmXyhmvIp6O+2sMLowWMUlw99rmYbxSZA2Ccs
         Xzx8CY0CkPvfxk58e+LwiXuyn4FpCsURmjX4gGwCD5gJBnPhIAaisAnhzfNSyW/idPrK
         MmTx+BQCYZ3HK2biFUg4nCPcO/q8pGDZAExG1tperWApTDNbygCmp6hBEx0raxdHhj2Q
         P3wSOaXy41Od6JNA593wy+3bNVKWnAAgOiE8Puam2caPzHE0OyMDJBiMIti3JTEbVmj2
         nkdWCTa0Ed4UJ9p84U7gkk0BhOHYj9fNxCE3hmKAq58JhxF75PfLJjFxByR2dvHSyXla
         1fHQ==
X-Gm-Message-State: AGRZ1gJH6UwPtiVQRnYNvLYPJHlxPH4J5kj61BXpwq8celsaY8+pHTjo
        WY4zUcJvbH45HQg1COKcLLg=
X-Google-Smtp-Source: ACcGV63P5PycsHAbQ3dHVzW8kkjSlPqzLQu1i29Jtv6qddIPFFGVQ5GvH6RLa/pJNGkVcErzT4YRWQ==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr4140261wmf.114.1539945607621;
        Fri, 19 Oct 2018 03:40:07 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id l17-v6sm409770wrv.29.2018.10.19.03.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 03:40:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Mirror of git.git on gitlab.com
References: <pull.31.git.gitgitgadget@gmail.com>
        <8736t7dzan.fsf@evledraar.gmail.com>
        <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
        <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
        <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
        <CACBZZX59vT1CTiUPfPZDJUSRH=NSzmWiabux=KRdTUFa1R=5bw@mail.gmail.com>
        <xmqqo9bsvwn9.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqo9bsvwn9.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Oct 2018 12:40:05 +0200
Message-ID: <87k1mecj96.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 18 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> sites could do the same polling and mirroring.  I am just too lazy
>>> to open a new account at yet another hosting site to add that for
>>> loop, but I may choose to when I am absolutely bored and nothing
>>> else to do ;-).
>>
>> Do you mind if I squat gitlab.com/git/git in the meantime (i.e. create
>> an org etc.) and have it mirror github.com/git/git?, I'll hand the
>
> Obviously somebody who is not even interested in obtaining an
> account would appreciate, not just "would not mind", if a trusted
> member in the community did that for the community ;-)

I've set this up at https://gitlab.com/git-vcs

The /git namespace was taken (and I asked GitLab support if it was
stale, they said no). Also tried /git-scm and /gitscm, ditto. So I
settled on /git-vcs (version control system).

I mirrored all the repos that were on github.com/git (except for
cabal.git of course). This is being kept up-to-date with GitLab's own
mirroring feature, so it should always be max ~15m out of date v.s. the
GitHub version.

As an aside, I noticed that
https://github.com/git/sha1collisiondetection/ has never worked in
combination with git.git, i.e. it's cloned at a version that pre-dates
the initial introduction of the sha1collisiondetection submodule. Our
other mirrors don't seem to have it at all relative to
../sha1collisiondetection.git from their git.git.

Junio: What was the plan with that? It's never been used in combination
with git.git, so maybe we should just drop it?

If we'd like to keep it and if it was kept up-to-date some scripts of
yours we could use a relative URL in the .gitmodules, so e.g. if you
cloned from kernel.org you'd also get the submodule from there.

Also since we're fixing it, it would be good to delete the existing repo
and re-make it by clicking "fork" on
https://github.com/cr-marcstevens/sha1collisiondetection so GitHub shows
"forked from...", i.e. it's associated with the parent project in
GitHub's UI.
