Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11F11F404
	for <e@80x24.org>; Sun,  7 Jan 2018 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754768AbeAGWmb (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 17:42:31 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:42524 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeAGWmb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 17:42:31 -0500
Received: by mail-wm0-f52.google.com with SMTP id b141so11137627wme.1
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EH9Bznc0URTPFxPQoP84zuqi1+mL8lQI6wk5K+WWRz8=;
        b=ddF/F5laUmVwnf9iBqFAg7SgjPHTEYJe4WsJOREcegf7Cx6ZlLHtFdPs4A6sPjNTvM
         YXhj96Dy/sr+6zWFOO7ohxmLBizEWeqhMsvbfOalT8KLNho0orUTnOMfsoD7jNBFCJiE
         nbA48tkEc8uDyMvmPrEvhxdb0Vj2ZJTGf0KBAWqfbT/k+93oBdGObocULMVs9cUIdz3I
         1S1kBYpIYycVIFjgKG6RrNi/E66geu6hTLjP8OD70fc/9P8fcirr2jERpn0FI1krEt4i
         B8KCKtXVDJ3zRJxgvhs4Jh+NKpxnUU0Y281UABJde9rJXutVJVBC7jFO+zYMjWNs5U6Z
         jTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EH9Bznc0URTPFxPQoP84zuqi1+mL8lQI6wk5K+WWRz8=;
        b=GwUULKvpmy15iUiz2mFrovmLFt05Mu9gKGw9Ev5rIAoZny+uxG69q5SQltpT0hBbMn
         ocd3TGLsGooPGFsSFB7nIzs1SQ7oYbvTz4lywpur565YcgcrllZU1eB/SxGCNtmvDFWy
         TLygpVuPedd7HZGIVlsXf6HyRx2T93vNjMTUbF0pqAm3+ZpIk2gZhiYBX+E34eoXzThd
         n53+IANbeoYDw720MmEG5KXrj90UgnrHQK/SqsR9kkhBV01T5FGEEA9JIpATc+6T9Hlx
         QkxPkZbmN/6H3DrOKMHRPaPUb9PrYJFRuxDO4mnF3DJH6PKseR+NQbABcqrtl3d9osVZ
         sAxw==
X-Gm-Message-State: AKGB3mLxuOafy9skywYZFdosoElM6Uzo/Gm1eA+oz5IHNSMdCjJY7JsE
        rMRDnNftoOjRP71K8gz+DkFAGqq9
X-Google-Smtp-Source: ACJfBouGi4PRfjhtDVicw7MlGku1PpUGW8LH84dhlj12D9h1kPyMl40m+1zfqeTfXHgpZNMP6lspbA==
X-Received: by 10.80.144.49 with SMTP id b46mr14140320eda.116.1515364949531;
        Sun, 07 Jan 2018 14:42:29 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id i2sm6259044edb.31.2018.01.07.14.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 14:42:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
References: <20180107181459.222909-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180107181459.222909-1-dstolee@microsoft.com>
Date:   Sun, 07 Jan 2018 23:42:27 +0100
Message-ID: <87k1wtb8a4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 07 2018, Derrick Stolee jotted:

>     git log --oneline --raw --parents
>
> Num Packs | Before MIDX | After MIDX |  Rel % | 1 pack %
> ----------+-------------+------------+--------+----------
>         1 |     35.64 s |    35.28 s |  -1.0% |   -1.0%
>        24 |     90.81 s |    40.06 s | -55.9% |  +12.4%
>       127 |    257.97 s |    42.25 s | -83.6% |  +18.6%
>
> The last column is the relative difference between the MIDX-enabled repo
> and the single-pack repo. The goal of the MIDX feature is to present the
> ODB as if it was fully repacked, so there is still room for improvement.
>
> Changing the command to
>
>     git log --oneline --raw --parents --abbrev=40
>
> has no observable difference (sub 1% change in all cases). This is likely
> due to the repack I used putting commits and trees in a small number of
> packfiles so the MRU cache workes very well. On more naturally-created
> lists of packfiles, there can be up to 20% improvement on this command.
>
> We are using a version of this patch with an upcoming release of GVFS.
> This feature is particularly important in that space since GVFS performs
> a "prefetch" step that downloads a pack of commits and trees on a daily
> basis. These packfiles are placed in an alternate that is shared by all
> enlistments. Some users have 150+ packfiles and the MRU misses and
> abbreviation computations are significant. Now, GVFS manages the MIDX file
> after adding new prefetch packfiles using the following command:
>
>     git midx --write --update-head --delete-expired --pack-dir=<alt>

(Not a critique of this, just a (stupid) question)

What's the practical use-case for this feature? Since it doesn't help
with --abbrev=40 the speedup is all in the part that ensures we don't
show an ambiguous SHA-1.

The reason we do that at all is because it makes for a prettier UI.

Are there things that both want the pretty SHA-1 and also care about the
throughput? I'd have expected machine parsing to just use
--no-abbrev-commit.

If something cares about both throughput and e.g. is saving the
abbreviated SHA-1s isn't it better off picking some arbitrary size
(e.g. --abbrev=20), after all the default abbreviation is going to show
something as small as possible, which may soon become ambigous after the
next commit.
