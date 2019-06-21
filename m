Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4991F461
	for <e@80x24.org>; Fri, 21 Jun 2019 10:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFUKsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 06:48:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38219 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUKsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 06:48:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so9464083edo.5
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 03:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/9nXA/Hh2EPiU3AwjdbRydOHqESC+RhwGGkWpTPkYI=;
        b=qhoPr5afj5Iw7BweHWOwkn05oGmAGd8b5zfYoF5GnYFtk9UJlfBTEjyrJjJL8DJa9g
         XbQIQ64eWq4jSAvR6AGJx1BAoe7o4grmw1QPbK6f3hVVrhu6TK6jsowL+h6JvC05/NNL
         6MYRtBuj7U6vYyp2UpBkthq4B6Vko9cWiREz3/ZJD2eNKI7QC2ARDzafLXqgjWk71o2S
         o9DQnXeSGllUSk9aAAfEiXCfoM+KSUR2a44d3sWD8pI9bpjXS6iFWAuAzv7hEfh3/qSp
         yQ0mQ3S0Q43CyWsA1zEw055RrBJX5We1jwOm5Ak6QuLslSOXq8lEDGGI68X/d2kjFUYc
         ZmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/9nXA/Hh2EPiU3AwjdbRydOHqESC+RhwGGkWpTPkYI=;
        b=ZFXy2G6k/6/8WfS+xci9EPrLrz3WLyy8ozgTkhsywFHy/UUzvKK8yW+cHNMvcPJ6m+
         qRl0E8v9fBCexyaghSFsV6/zkv3e3NzHFbyy3GwjSPqei1VmUIT5OMdcZI/sHyLzbwgB
         zXP9JEnppLZLKKqTYPaLkhX0ahR+UzsF+K4VTgRO92HGnsd6yM1lq4/vgN8L9Lltyb8b
         xVBnUB0yxd9MOs79cyn5WnhU9pMU4o1hmuCsOQ+KXBiwsyxWuMG6xj6IKxpkDxiCMhN4
         GhPSR+Ch9nCICMBccmpCUAtR1b3XDlmFETAisjj6Exvi6ZR/8fo54ryN0ohL1Dfz/dVq
         vwww==
X-Gm-Message-State: APjAAAVRo4gHHVeQv8m1GDCZkhlXEPUtQbCKQrOtE3lFlUbEdbCqyS9E
        XoQZ8IepwqnwJ6JoYDxNjRlasitE9pqDdADSW2c=
X-Google-Smtp-Source: APXvYqxOZai3nZgvdb/OjWn3tKmVDFfD9YXCNJDhByB4wS+hTav2Bziie6O+/aqsfrd+Ddh/Nk/x0ijttW+m2BkR4oQ=
X-Received: by 2002:a17:906:6147:: with SMTP id p7mr12335943ejl.187.1561114079589;
 Fri, 21 Jun 2019 03:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190620083026.14524-1-chriscool@tuxfamily.org> <xmqq36k4m12g.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36k4m12g.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Jun 2019 12:47:48 +0200
Message-ID: <CAP8UFD0HsD+q2Srd7iUkPhXMHzUN=g0he3EHGd0m3n_TDxuZ1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add OBJECT_INFO_NO_FETCH_IF_MISSING flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 10:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In a review[1] of my "many promisor remotes" patch series[2] and in
> > the following thread, it was suggested that a flag should be passed to
> > tell oid_object_info_extended() that it should not fetch objects from
> > promisor remotes if they are missing, instead of using the ugly
> > fetch_if_missing global.
> >
> > It looks like the OBJECT_INFO_FOR_PREFETCH flag already exists but
> > unfortunately conflates 2 separate things.
> >
> > This patch series introduces OBJECT_INFO_NO_FETCH_IF_MISSING to
> > disambiguate the different meanings and then uses it instead of
> > OBJECT_INFO_FOR_PREFETCH where it makes sense.
> >
> > 1: https://public-inbox.org/git/b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com/
> > 2: https://public-inbox.org/git/20190409161116.30256-1-chriscool@tuxfamily.org/
>
> What commit did you base these two patches on?

They were based on master at v2.22.0 when I worked on them, but I
didn't send them right away. And I didn't rebase them before I later
sent them.
