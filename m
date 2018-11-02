Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1F31F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeKCCQ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:16:56 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45885 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeKCCQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:16:56 -0400
Received: by mail-ed1-f51.google.com with SMTP id t10-v6so2361282eds.12
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0kP7vT7PjUk40+ufk9FjP/EnQuHpBlsb3Ob0WhOivg=;
        b=hmZOdcqIJ0UOu7i5CGzZRUjEWQ9AZSBk0Hj04n2f7D3tQXTokh3qu0Z4Xht3y9/8qH
         hZP7i59XZ2nW4sm/2ho15IQxJdadG8HaDHZ2mXl4rNngeIfljd1pBjbkTpuwTpk3VGo/
         cmo5u9K8QZIiBhp1ZQ83eS+HDooFR6Zmzsfvq8g9KEUtQGayoLPNydFjCEuppnfrq/dV
         vUJox6azxm7iWZcOUi6qpdnajWuUZrcMuWB5EKVuLlS4cbyfht1zIM9ueLY303HB+QXG
         eb0O4uWOToECFcno2Pm10rPg09MsLOp0E6rNX/mFHSOBfXGEZtMaCGthpTyiR9q5CYGq
         Tfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0kP7vT7PjUk40+ufk9FjP/EnQuHpBlsb3Ob0WhOivg=;
        b=Kr0jh89o2wla+hd6jUvggEzI7Uw2mYvd1VLnt/CGRdYNjv5PGry47YqejutgoEEnnr
         KsN+X5qg7OCd+3ChQ9efnukjfuHmEZ/05ukQFIHiEJ7llqggT6L4tXezXJNJRhoILBM6
         0DxZwrl69M+kV6zeINFqdUrtwjNvnJV8jE6QZAzgx6MxWrcI1gQzbsivdJ+wm6gfcfhQ
         4rsJF4IaGDrYTof6FRNS/0uTxKOUHc7E8D6/mRL0xRTdGGAJNX4EwPujpFjdMLkqVsDF
         +vLyR9rrMQcIFwg2QQtFgMGqAQnroZApaYSiWMgUEVisv94nDVb+nKKOf9YV90JZy03T
         3MhA==
X-Gm-Message-State: AGRZ1gJfG5UyKcM6R4asHreNrtYQxtOXitVAPBSYRYKrQBftPeOFnNjl
        pU/uPliMiWPlRUqjjhbY0ei6sLhoDt+3cFIVV+5AXA==
X-Google-Smtp-Source: AJdET5d5UWfNI+em+NNOXrPQdLdoWXKEbZ/GYI4ImBCZXHnF8eLAh1aOr1nPY/a26f4wSb3GC7NOWpoBDo1+5NKsbJU=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr2463418eji.106.1541178544725;
 Fri, 02 Nov 2018 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AVfkWsAP_-CNd5RSbQ=tyCzdw-ix1k5zwmAKaj+z1qXw@mail.gmail.com>
In-Reply-To: <CACsJy8AVfkWsAP_-CNd5RSbQ=tyCzdw-ix1k5zwmAKaj+z1qXw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Nov 2018 10:08:51 -0700
Message-ID: <CAGZ79kbk0QdxTNWusieU=3DzTvxykmh-yTgNArTcM9USc5WWRw@mail.gmail.com>
Subject: Re: submodule support in git-bundle
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 9:10 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> I use git-bundle today and it occurs to me that if I want to use it to
> transfer part of a history that involves submodule changes, things
> aren't pretty. Has anybody given thought on how to do binary history
> transfer that contains changes from submodules?
>
> Since .bundle files are basically .pack files, i'm not sure if it's
> easy to bundle multiple pack files (one per repo)...

That is a really good discussion starter!

As bundles are modeled after the fetch protocol, I would
redirect the discussion there.

The new fetch protocol could support sending more than
one pack, which could be for both the superproject as
well as the relevant submodule updates (i.e. what is recorded
in the superproject) based on a new capability.

We at Google have given this idea some thought, but from a
different angle: As you may know currently Android uses the
repo tool, which we want to replace with Gits native submodules
eventually. The repo tool tests for each repository to clone if
there is a bundle file for that repository, such that instead of
cloning the repo, the bundle can be downloaded and then
a catch-up fetch can be performed. (This helps the Git servers
as well as the client, the bundle can be hosted on a CDN,
which is faster and cheaper than a git server for us).

So we've given some thought on extending the packfiles in the
fetch protocol to have some redirection to a CDN possible,
i.e. instead of sending bytes as is, you get more or less a "todo"
list, which might be
    (a) take the following bytes as is (current pack format)
    (b) download these other bytes from $THERE
        (possibly with a checksum)
once the stream of bytes is assembled, it will look like a regular
packfile with deltas etc.

This offloading-to-CDN (or "mostly resumable clone" in the
sense that the communication with the server is minimal, and
you get most of your data via resumable http range-requests)
sounds like complete offtopic, but is one of the requirements
for the repo to submodule migration, hence I came to speak of it.

Did you have other things in mind, on a higher level?
e.g. querying the bundle and creating submodule bundles
based off the superproject bundle? 'git bundle create' could
learn the --recurse-submodules option, which then produces
multiple bundle files without changing the file formats.

Stefan
