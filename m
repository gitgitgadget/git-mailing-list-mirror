Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2602027C
	for <e@80x24.org>; Tue, 30 May 2017 21:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdE3VdF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 17:33:05 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34493 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdE3VdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 17:33:04 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so83374483pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gj229ZVmDjAzj6z6uYYKq20qfilLQoBLX0fhEfEhcYA=;
        b=sAc/NZLn+XGzTA//3hUiMFToQfS4oRhfd25L+RMLs2K3CikHYeTuIseycPeQdzH/7+
         85nloCaOepx/vHH0I5I3JO7ItNv/Zeva3QZqzjZTZCwdnA7jNFvWhHXBOMJS43SNX7N2
         VeKl90IkR6reDN+77pVq5nEnA722Tg6xVOWGeXpwiqR6/ucXkBC5J18n5jDaRwVn4cse
         ZRI/8VBrX0i/V9ttmVzhYsnjDzyb9iCvFMGAHjv/5LQRHMzNdWOlNGF/0LTa7NqTNPbj
         KIY4J6aaBc99TxCHFnaGEklJXBck47kT47Efnam20imGHZIYAkiJs9TN1ieHzCiG47C8
         7jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gj229ZVmDjAzj6z6uYYKq20qfilLQoBLX0fhEfEhcYA=;
        b=JAmecNq4/N3Fs84q85UszmmtqIIewqbK1jEhWcHUG3cNcm1uZ7B/H7YTg6d8Q3TGzW
         46vLIggPgpI/UfvlMwOYT5WigRBJM+RXb7BTidcTeHCBq4L8Nhm72HRMQ1Pl9JzehJxx
         3SJyMoQh8W/UOTonsEEYmX9eMjm9Ipbe0koW000qfxC62wkxLCnJveUSGl7UqMSkk7Pb
         U6pbgqdLT+Sy7sdEgqpWLhvwKecFZUYhLxLt289NRkmK9W3FGvUCg5O7QY0eKvhvcrtg
         ZNqj5YcBF5/eN8DZHKyXJXiRygSlFMPTMPwkrQRqyYH6F47IzN4U9e2G2HGnxV2c4JxT
         SGOw==
X-Gm-Message-State: AODbwcBxFljYscsQpLXNNxyZIKFvkhog5mHJAmKunRtWmDq8zPXyq2hY
        HtvQJ+g4KENoRwrEu4IVj5Te9i/Y8iBR
X-Received: by 10.84.248.73 with SMTP id e9mr85927033pln.76.1496179983231;
 Tue, 30 May 2017 14:33:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 30 May 2017 14:33:02 -0700 (PDT)
In-Reply-To: <39D67E58AC02490FB6D6124BDF3EE2A9@PhilipOakley>
References: <CAGZ79kbD6QggYH9+M8FM0Khg7Cs0egJR6Jm+kMJkscaANV6UXA@mail.gmail.com>
 <20170527001820.25214-1-sbeller@google.com> <20170527001820.25214-2-sbeller@google.com>
 <39D67E58AC02490FB6D6124BDF3EE2A9@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 May 2017 14:33:02 -0700
Message-ID: <CAGZ79kbq3XiP8W_01FV133aMjZP9_GvpEg86N=XC2rTy24ZZGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] diff.c: color moved lines differently
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 12:05 AM, Philip Oakley <philipoakley@iee.org> wrote:
> a couple of mispellings in the doc parts:
>  s/on location/one location/
> [code not checked]

Thanks for proofreading the documentation!

>
> s/on location/one location/
>
>> + in another location will be colored with 'color.diff.newmoved'.
>> + Any line that is removed in on location and was added
>
> s/on location/one location/

For a moment I was worried that my 'e' key is stuck as it happens
to be the same misspelling here. However then I realized I copied
over part of the sentence and just replaced added/removed.

Stepping back a bit, maybe the second sentence can be partially
elided to be more concise. Maybe:

    Similarly 'color.diff.oldmoved' will be used for removed lines
    that are added somewhere else in the diff.

Thanks,
Stefan
