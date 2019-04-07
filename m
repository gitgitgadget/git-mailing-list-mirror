Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1312F20248
	for <e@80x24.org>; Sun,  7 Apr 2019 03:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDGDFU (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 23:05:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44433 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfDGDFU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 23:05:20 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so8194359iop.11
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zG8VjmmiU9D9ZGtjxzKll/UNm0FFuHMwLXc0U/rp4Mo=;
        b=fg4scNHYzthGeU3JbhvFDHTxCuGqvJJ8zbEiCqT9MjZUwAvXq3z7Hj6C6DYwDpZh4Y
         C8uzYdAs97tff7ppZY7+P5PF7n2D1m7pq00XRjEG8jG/j8/SFrOhQQt/hGM8ahbmDp0h
         xTZzhaolWz/s7OH30eXvrfrMz0YJ8kn33krig6BtDvadFlj2S62AsIGk3RR4RhkgFC/K
         JpOfOJ8JSgmKSR7o27aYiyzuGgDmm9jmEoP5WtYRI4FyKDSsEUd/SVsU98aFcZlGMXry
         fHJrl9TjaRb3svqJbRFmX+hnOE7l9QzN+XMt8nE1Ltu2OT1sGiK+BkGMLqCUSeun6Wk4
         3EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zG8VjmmiU9D9ZGtjxzKll/UNm0FFuHMwLXc0U/rp4Mo=;
        b=KFs5kRni3Y4PevbJ01axRnafSzo8CvaEDsvxyaZE+mlx6DsIXcdpFi2GwoxpaW87WA
         RpLy24s7t/aHTyx7HT+qCeEkxYkGL93wk+llUqk9+NCDfezDrkedWOvSrzpQoJSVNkzw
         tk4Jf3ij2OxgUgH4qBqo+GXrpflvETunkLiB1tLg+qKhBH+BQBLMNggiQ5QQoPS5LMAJ
         RYsxltFxJ/YlMsbySmxLnXsxTDhk/y/GueBlmFhlLeuvEZdZnybpsC6UwDjkvQrSRQNo
         xo1FL2d9COCuoiQZQS0dJEOG9HMncte/Goqw1LZz2DgaQ3mv3mnh+oVpF4bryh4XFYwb
         Vudw==
X-Gm-Message-State: APjAAAXW7cJcOltEfF38mw+RP3A6cIjxSjf8grSJ17fBb11z6MTd+nLG
        IRNhUkPxy6fiFpW6KcMeI4Q6/lz2hqXbr9rJNfg=
X-Google-Smtp-Source: APXvYqxzvT685ArGJh/kcov5ImzMiPuGLk5eXIxd10ri5CdTJRdIueSs7FTSHWilqlnr6iB4xisYdEwyKJ0LInImCCw=
X-Received: by 2002:a5d:840d:: with SMTP id i13mr6931083ion.186.1554606319979;
 Sat, 06 Apr 2019 20:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
 <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com>
 <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com>
 <CACsJy8DNb+Xu_bLAGw3WHECygxMLQHkaqGhJ89SY_yGF+c20bw@mail.gmail.com> <CAMknYEMVdH9f-sxyRkfL8OtFjC993ooAf_8z0SGA07+86NB66g@mail.gmail.com>
In-Reply-To: <CAMknYEMVdH9f-sxyRkfL8OtFjC993ooAf_8z0SGA07+86NB66g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 7 Apr 2019 10:04:54 +0700
Message-ID: <CACsJy8DURQdR3gAB4-KDz2mbdoZcXh8-+LdmCdzjMRsPv64pQw@mail.gmail.com>
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

On Sat, Apr 6, 2019 at 8:30 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> On Sat, Apr 6, 2019 at 5:49 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sat, Apr 6, 2019 at 7:14 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
> > > > In some cases, it will be simple. For example, if you have a look at
> > > > repo_read_index(), it already knows what repo it handles, so you can
> > > > just extend read_index_from() to take 'struct repository *' and pass
> > > > 'repo' to it.
> > > >
> > > > Be careful though, repository and istate does not have one-to-one
> > > > relationship (I'll leave it to you to find out why). So you cannot
> > > > replace
> > >
>
> at a lot of place where, read_index_from() is called, the repo struct
> is not available, so i am passing `the_repository` in those calls.
> this makes me wonder if this is really required, because most of the
> places just don't have repo.

We're still in a transition period where many places still assume the
default repo (so yes don't have "repo" or "r" argument). Once
everything is converted, the_repository should only appear in very few
places and will be passed down as "r" argument to all functions.
-- 
Duy
