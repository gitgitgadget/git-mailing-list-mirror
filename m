Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AFC1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 03:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeACDnj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 22:43:39 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33483 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeACDni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 22:43:38 -0500
Received: by mail-ua0-f179.google.com with SMTP id n6so267667uak.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 19:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gUc61cWoSup2LN/xbqZqyGJGuzUw+7GUGjHHEzCjWsk=;
        b=QL3sZIzn7bS4NJyS4eLJy3oKkbY5k+lLaT91qhwFmdYKNGe7ynuazCbrXqFBBqcYbG
         kWgANsOSNdXeRS1HIaF2GHj0CeHW8Em6NE9+Bs4Ry7BTFJBQQZNuldNUAFOlQk0rNRfP
         RkKX8A9yGep1McJ9iZc4jjyU3vt2QzGDXJ55AlLuSBXb06dekGTrLBcHdOinHDf+ioVX
         IAO1qqsX+9tG0vNA8o31QYfI0SRqx/X7zu3ZLC/OcR1VCTVbQZnMgKkYETKIHcspPLxp
         +7bGhuifZyB+AW8HjX2nFJDG1R8vlqwXU/3BH/uRK/aJNxIPjy1gf89+n0CA6Afjje1/
         O7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gUc61cWoSup2LN/xbqZqyGJGuzUw+7GUGjHHEzCjWsk=;
        b=EZzu3o8k1ajwVpGoiYNwhCCTc0gfhkISHjga5pBl0iEROgUYyOXz93aDzaJQoc1YTP
         4KE0E7gedjef9kgvpjjuSrBc0mle03BR6dA3kF/Do/xq+2dmzryaep4SHo+n4Gn2KAo8
         w7Wt2hb2GhNpjIAcDwsR+/G9YJrGJkra3nXBW+rxbwyyKF7WC96WUykWEIT70ec9B0nQ
         A8YkX9nf7fkPgDROWgzNroskyl5qEQus1jDuQJVQXM+KzhLf7XpUx2vYY6FDZg7DjtUz
         LimMyArwgylMFKxxQlQmgXM7kSxJB97pD0x6ObISLtd9Ftx1Y0wHhbDS0aCh0mWUXKS9
         w2gw==
X-Gm-Message-State: AKGB3mJ1FlXp5i1WH1aR/zc/HDPFaJPY4OAXjnKhAW2AGbAo15k19RP6
        Xh7h7L5yMqs2uZox59+q2W7g1/IFA18yxDD0vTQ=
X-Google-Smtp-Source: ACJfBosbVAK+n5tWkZ5FeTEB1L9Xv+O1CxwPdQhGxK0wRfqAXuDgibi9o1GHmDIK2ZBod6cwNTxzRo9cU3O9JR5HMss=
X-Received: by 10.159.51.75 with SMTP id a11mr149677uac.147.1514951017354;
 Tue, 02 Jan 2018 19:43:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Tue, 2 Jan 2018 19:43:36 -0800 (PST)
In-Reply-To: <20180103011804.13676-1-szeder.dev@gmail.com>
References: <20171228041352.27880-5-newren@gmail.com> <20180103011804.13676-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jan 2018 19:43:36 -0800
Message-ID: <CABPp-BFDCWpZ-axbNDGJgKRTLqS55rXBYamLe4kWzkHYz6sVAw@mail.gmail.com>
Subject: Re: [PATCH v5 04/34] directory rename detection: basic testcases
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 5:18 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
>> ---
>>  t/t6043-merge-rename-directories.sh | 430 +++++++++++++++++++++++++++++=
+++++++
>
> Many of the new tests added in this patch series perform a lot of checks
> running 'test', which has the drawback to fail quietly, leaving us no
> clue about which one of the several conditions failed and why.  We have
> several test helper functions that check the same but provide a useful
> error message if the condition were to fail.
> Here are a couple of suggestions in one of the tests, but they are
> applicable to many other tests in this patch series.

Cool, thanks for taking a look and for the suggestions.  It's good to
know of those other test functions; I'll incorporate them into the
testcase patches in the series.
