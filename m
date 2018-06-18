Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D70F1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936327AbeFRTzb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:55:31 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:43687 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936120AbeFRTza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:55:30 -0400
Received: by mail-yb0-f171.google.com with SMTP id w3-v6so6421509ybq.10
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyEThWKsxr8v/OFsjNJhJAuswqfdIPev+jOikiIU7Ls=;
        b=japZp87txfCAP4+PQbmngKgrTgdzbvokbCxYdvIFfPuKvBE45FWSiaH8p50JFEPOlP
         GwvseRtN47GjM51B9IPfSKOagbOUuLD996T2qAgsVnFKzp0Jo0nLjiUYglObi2/qhzeX
         5ya5xFGy9D0dGnONjJXZuoC2ylrwRUPLwVv4FRHG3ytZcFwOcwUHJq0Ot2be3u5WHMsu
         6wkxTDSHknbnKGitv0uNwVFAo9lHgf9zmce70V4BtyS1sznGyK1Xfmlakrr8Pdk9g/m6
         jCmt+5uHga3KQa5U3jBAaZbQDjZ7d8LP5XeHU/a+gYc780f7zePzzXUAoikWe+52ymCa
         16pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyEThWKsxr8v/OFsjNJhJAuswqfdIPev+jOikiIU7Ls=;
        b=tUNJ041usOyGMKc66Qrt4O44PlneNHWHpl8wZMYp97+3rsZeOePsE1TaM8AL5eweAT
         DGeXQHNgJct7LEOXRnGdHl4TuMKNgbxGEw9gOb/dfrvjfNp1SFvPzpKeUayWNQ8zXAKR
         2udN2mtRPybRULMYA+Lzjs0GKnhUAqwCeQ6Zg+dqhFC/s6Ohw82EV3jRCo1LO44RcSGb
         3iQs0cRWhmILmxCcrcpyvTbQ1/a9Xop2Ok3WOnHT4tgNq3UCkRH5dLlUe+/E9ojBOOEk
         D+ZaJIp1o8X960HBqi9Ta4r6Lrn9oOXp4VDZAHHq5CoqpRZ0W+pggjsjbsl/sS72PTyn
         V5fg==
X-Gm-Message-State: APt69E0+44S7LwUfhAyCEM5CkCaqPoNEpW7cz4cIeG+Io9aiKRpetOE2
        0o+6mq8NP7b6dW5EDfSVNjp+13P77mysR3jg+hEXLStgnsw=
X-Google-Smtp-Source: ADUXVKLJ5Cb9JhQLENzXRDgsu587W8tyY/mrzY2Vn/9/6JiHXSm1ersotYQPbavQ5pxy2QlDbHYYzNX2y7pmFWNJAxY=
X-Received: by 2002:a25:cc14:: with SMTP id l20-v6mr3445300ybf.334.1529351729339;
 Mon, 18 Jun 2018 12:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-4-dstolee@microsoft.com>
 <CAGZ79kaH7XzbtPZqVwGgP774GJNxF7ZsHqLzWEmb2NLSxG3Njg@mail.gmail.com> <160f10c8-3016-8466-22dd-14cbd1a2c2f6@gmail.com>
In-Reply-To: <160f10c8-3016-8466-22dd-14cbd1a2c2f6@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 12:55:18 -0700
Message-ID: <CAGZ79kbb699FHoD1X5gXjtBv0r7zpd5PRuh1R2FQ8ABySV8znQ@mail.gmail.com>
Subject: Re: [PATCH 03/23] midx: add midx builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > But as this is plumbing and users should not need to worry about it
> > this is optional, I would think.
>
> The design document is also in 'Documentation/technical' instead of just
> 'Documentation/'. Do we have a pattern of linking to the technical
> documents?

Apparently we do (and I was not aware of it):

    $ git -C Documentation/ grep link:technical
    git-credential.txt:23:link:technical/api-credentials.html[the Git
credential API] for more
    git.txt:839:link:technical/api-index.html[Git API documentation].
    gitcredentials.txt:184:link:technical/api-credentials.html[credentials
API] for details.
    technical/http-protocol.txt:517:link:technical/pack-protocol.html
    technical/http-protocol.txt:518:link:technical/protocol-capabilities.html
    user-manual.txt:3220:found in link:technical/pack-format.html[pack format].
