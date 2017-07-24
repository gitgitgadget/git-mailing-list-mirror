Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B2A203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdGXTib (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:38:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34879 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdGXTia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:38:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id c184so34308383wmd.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wda+X7mbZGFCtYyiruhGeAluKsZ2VXo0BP1ru3RKyAg=;
        b=CXVh6DjEYNUOn4T1UzYiMQO4/pLZ619swzRpLjRw2M4PK5WLepgurd/79m6w4ujNw6
         IKilH1fYV0MMY5Em7SRieNi6+yZAWlw4ljJ36htG4ol/B0UZmy0DtTqJ9KVzJgYGDO/M
         +D1XrOJ1ITCWYW36Ux2iXqXUnoVn4y9AzguYbZTkQBVwuwl29zwAX4xhowYMqT9txvTE
         h1BVmSodd5r9zzlGFbOrocusz+kAwQbhikTM/3eoSJBM1KADhIaRfoliX6Do9FuKKa4B
         LVFaqnPiSP94MYQ9xEYi8MvOoaeA6NRm+dW91iCXsPVnlsmhTgCw7Hky4gYHcCr4doi5
         SEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wda+X7mbZGFCtYyiruhGeAluKsZ2VXo0BP1ru3RKyAg=;
        b=XyPcaxWvtCC2oLWyEQQwK7NiNzZEBnAkgG1a35Ja4BmEyto0/1YwXQiKjD6ekQlP/8
         1Yemf0LavjA4UKHMfQJL+o7dPOtMTio95hwqjZ4JuxndZLG8ldgBUrwh9Q29538+PhTM
         2+Q6s4FP3NfIFGYnaHcyGLO/93Yy2mYUGtWY7tI5POf1UiNG+s/02yN6ow/UjYV7VoEG
         6/UcyYlRdQkdDYTXEAKaOKoFlk3pSXSlT18+0IsTsILxlgOULOTF8dQHLKL7S2soy4kE
         eLY3wGc4etBa8PhdaHjSuz8ZLpRYym9PB/MRFyv5Jmoe8WGSM6eIoH4oQmvRE2Yj+/Le
         xcRA==
X-Gm-Message-State: AIVw112TiO3PzmOvLdgacAh6eAV213+cT8wq0HF+Wo7nWhOB975iDlUy
        QkEboNYAxBi4IR0qvSeslAhLlGjxcA==
X-Received: by 10.80.148.36 with SMTP id p33mr14478174eda.174.1500925108836;
 Mon, 24 Jul 2017 12:38:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.179.82 with HTTP; Mon, 24 Jul 2017 12:38:28 -0700 (PDT)
In-Reply-To: <20170724091319.6818819d@twelve2.svl.corp.google.com>
References: <CAGHpTBLzN2g_ZXP4G6Eo5yZrvK_bB8KjBiSZ-Nc5JHNTRzv8qA@mail.gmail.com>
 <20170724091319.6818819d@twelve2.svl.corp.google.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Mon, 24 Jul 2017 22:38:28 +0300
Message-ID: <CAGHpTB+ADy+TgCtr37m6QniOQ0p96=2LMzesaGQkAwycnoawHw@mail.gmail.com>
Subject: Re: fetch-any-blob / ref-in-want proposal
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 7:13 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Sun, 23 Jul 2017 09:41:50 +0300
> Orgad Shaneh <orgads@gmail.com> wrote:
>
>> Hi,
>>
>> Jonathan Tan proposed a design and a patch series for requesting a
>> specific ref on fetch 4 months ago[1].
>>
>> Is there any progress with this?
>>
>> - Orgad
>>
>> [1] https://public-inbox.org/git/ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com/
>
> Do you mean requesting a specific blob (as referenced by your link)? If yes, it is still being discussed. One such discussion is here: [1]
>
> If you mean ref-in-want, I don't recall anything being done since then.
>
> [1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

Sorry, I thought it's the same thing. I mean ref-in-want[1]. This
issue in gerrit[2] was closed, claiming that ref-in-want will solve
it. I just want to know if this is likely to be merged soon enough (I
consider several months "soon enough"), or should I look for other
solutions.

- Orgad

[1] https://public-inbox.org/git/cover.1485381677.git.jonathantanmy@google.com/
[2] https://bugs.chromium.org/p/gerrit/issues/detail?id=175#c24
