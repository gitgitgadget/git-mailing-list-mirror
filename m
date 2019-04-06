Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4680220248
	for <e@80x24.org>; Sat,  6 Apr 2019 12:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDFMTV (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 08:19:21 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55574 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFMTU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 08:19:20 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so7225270itc.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIVO4wyWLBnE1Ag8WQm8Vjc+Nras5HNltvZ2s38Qtd4=;
        b=iPxH6S2zsh9ouueSb188WRO6qHlER6ripIcEBnIHdZd5WxNhXcM8ltRlvjR3jSg7B5
         yMdkDD/4AIko7xf7NZesHBW1DF8x05wWwJcnsJdVnZ2EP+fkVo1yrYT3IHwSg2Kg+ZO8
         dCr4Zmpsak1okN4YZsjaoMQDsd+YmikDe/CWDJTJPi7emNIV2gvWS3lj8sqKaPoJd3Mz
         sHfP1sNqx4hNcW3v9T7KurcXKy/L7Nd6otvgmYcpNvqTUqMlE/WtTg+PY7feLPjbzKDw
         Sx/nbSsr4M/sTRVHZMRzeEnio1bmlvv+fTjXesPW8tTY9a6B1Ro+VxxYfRIvgm4e6peW
         8o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIVO4wyWLBnE1Ag8WQm8Vjc+Nras5HNltvZ2s38Qtd4=;
        b=tKxApjDJ/DhBvXoVHL6SdRZ87talg8ykvhyW+y4Y6XHt015NrAo5/yJWVh0LKtxFOQ
         N7Ght4TKTG+VWyHMWlyFKfBugtkb7KxdfqDHHcb6XoA2h74eAXFwDiN7qA0Pj+ojwW7R
         Rmitls2AOW3rdOmm8NZTilbgfHNidM/Osu0pBcHdKBFsyKR0lSs9d0Cg056JkIQMrrS2
         xuupfvVCe3m2NVeGVF9N/Oydlkif1AKKmkMvUMJP24e2PoTnM5vZ1KyeiBjRIbSdBW0X
         3L7V2ZuG0lPPPnebw3vA3Joh92CCFeWVUxbAuVTJhi9VXNLauoSvSN50jt4L5AHggBoM
         wOYg==
X-Gm-Message-State: APjAAAXzA/7rrmus3z6ybRC0yGYABaoVSvEWmAWo2vZbjmWYyjMo7JIc
        F/w8lV4zyCfQQcwtig5IrWRQvp8IVsVDWaWKqW0=
X-Google-Smtp-Source: APXvYqwzz5ik51G16Vc4dhShR4wULzqsQkL4IeX0BZwuhu+B2d01a7RN6zCqeIOOfVtHbJtXMq5CY1wrEexG4AcZyKw=
X-Received: by 2002:a02:c50b:: with SMTP id s11mr14177970jam.84.1554553160041;
 Sat, 06 Apr 2019 05:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
 <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com> <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com>
In-Reply-To: <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 6 Apr 2019 19:18:53 +0700
Message-ID: <CACsJy8DNb+Xu_bLAGw3WHECygxMLQHkaqGhJ89SY_yGF+c20bw@mail.gmail.com>
Subject: Re: [RFC] TODO in read-cache.c
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 6, 2019 at 7:14 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
> > In some cases, it will be simple. For example, if you have a look at
> > repo_read_index(), it already knows what repo it handles, so you can
> > just extend read_index_from() to take 'struct repository *' and pass
> > 'repo' to it.
> >
> > Be careful though, repository and istate does not have one-to-one
> > relationship (I'll leave it to you to find out why). So you cannot
> > replace
>
> should i run all the tests after making the changes, or are there some
> specific ones.

'make test' (with -j<something> to speed up) should always be done for
any kind of changes. But I'm pretty sure you'll hit plenty compiler
errors that will make you pause and think.
-- 
Duy
