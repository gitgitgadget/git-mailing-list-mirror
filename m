Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE341F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeKNKIb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:08:31 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35205 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeKNKI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:08:29 -0500
Received: by mail-ed1-f52.google.com with SMTP id x30so7377701edx.2
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=077Eb5QoHufgpg8IN6RAhkIlhBYANdxXbaaKXRfuokA=;
        b=qBcxnv3HGzWVN50TgQ1XaBGlscjP6AspTm5ujlod0RYWguWhtP9t13YFK4E3c7euXZ
         GgVNAjf1F+nofdJQvtWq6eNckK+xaL6CWpqvrS4ZeZJqJTBgXtTcBpcw5DYKsFTvIz1m
         ZrxZ2yKgGX+J1pMEq6DMTH42tPtOwC7xzP9viCZ8blvIJB7nSraRVv5KXhHEmnfVHmRJ
         /1PDCvOYiK/LBK3qgGLRT5+87toWl5xxqJ7Y9Bz2Ws+936COScAMqw+tBdph2YFDT1YL
         98WxzeXEQjsAlsqeOGcY6xNSzGYaUpfST8j9jmF+2gnW3/qJhb1UKa3Y+ZiZVRWAuqOO
         bIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=077Eb5QoHufgpg8IN6RAhkIlhBYANdxXbaaKXRfuokA=;
        b=SnON0e5gxxMreVm3zkRf9hIcKkJplYvxN4lg/hgy47XTllYEIsbB54zOVjesa3Jb95
         hHsOLqfhVcIuOh/cNKgznigN2G0u2F7EHLZx6w5IYAflQw30pQHZZG+cabGfm6reElcO
         21slEaYUHdhJmnGHd5G0LETjyEimaBkj+fFkaPOR/g6eG4yiC6GF82fN7fFH9e+DMiNU
         EKjbVEw2M2mmEEHedVUCkI0bVu5d/HmDvpSuysfQxJDfTYT9kyqZxsPuhIVLIJEO0UlW
         WnL03EYKatViNdb8dERMQ8fwF8mR+UHtaq8dQ2v3siNAleCkw+cryHEByGXSxUlt44PT
         VQ3Q==
X-Gm-Message-State: AGRZ1gKc5yTLOw2DgpW1xYz06uKNZSymqPONqUUamXDhRBLYqOarDlY1
        sschEBRtcM0/eTmC9lOxmbkaxYKzzzmv5tj7hlCogA==
X-Google-Smtp-Source: AJdET5cgrvoL9xZGN1uZCgtmvr89sTn5nyWmsNa2HwJGnC5xuKSQtodBCUGo7Fs/u73lS+7ot36AU825HsOlMmS2P9w=
X-Received: by 2002:a50:a307:: with SMTP id 7-v6mr68720edn.231.1542154064920;
 Tue, 13 Nov 2018 16:07:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.76.git.gitgitgadget@gmail.com> <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
 <00d9b0e4-dde5-c96d-76d7-42fb9ac393f8@talktalk.net> <nycvar.QRO.7.76.6.1811132019440.39@tvgsbejvaqbjf.bet>
 <1b8461d1-6cb7-6622-94d2-44c27623236d@talktalk.net> <87y39w1wc2.fsf@evledraar.gmail.com>
In-Reply-To: <87y39w1wc2.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Nov 2018 16:07:33 -0800
Message-ID: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
Subject: Re: rebase-in-C stability for 2.20
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But maybe I'm being overly paranoid. What do those more familiar with
> this think?

I am not too worried,
* as rebase is a main porcelain, that is even hard to use in a script.
  so any failures are not deep down in some automation,
  but when found exposed quickly (and hopefully reported).
* 5541bd5b8f was merged to next a month ago; internally we
   distribute the next branch to Googlers (on a weekly basis)
   and we have not had any bug reports regarding rebase.
   (Maybe our environment is too strict for the wide range
    of bugs reported)
* Johannes reported that the rebase is used in GfW
   https://public-inbox.org/git/nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet/
   https://github.com/git-for-windows/git/pull/1800
   and from my cursory reading it is part of
   2.19.windows, which has a large user base.

> (and would re-enable rebase.useBuiltin=true in
> master right after 2.20 is out the door).

That would be fine with me as well, but I'd rather
document rebase.useBuiltin instead of flip-flopping
the switch around the release.

Have there been any fixes that are only in
the C version (has the shell version already bitrotted)?

Stefan
