Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9BA1F488
	for <e@80x24.org>; Thu,  9 May 2019 09:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEIJ4z (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 05:56:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39117 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfEIJ4y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 05:56:54 -0400
Received: by mail-it1-f195.google.com with SMTP id m186so2395815itd.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+BcXiFu4CGfnJ2Il2KXoBykK3yCYp61leYBQZjbafqo=;
        b=aGy5Bg/N36xQmULNq9dYtTfb994eHyIT4ZJ4aooYF5FZl7uwXHdfTgJXg2z7qk3P58
         0Mw1KDpl1WcNvpIOAIzK8aaSexrI6z4IVtJj66jruZEB8cBV3R8+Grgv1yTJjRS+LDJx
         rp3ck+EF+oyIh3dS5Cp2udSbBoCoAib8UHuuAIhlsIDl7APUjuKSIQQe345Z4OVdkgNv
         3DeJ4rW2Fo1lq3Pb6GmZfY/nElFIjzRC729xHCB8CHcpacqyZBctnGQJbbP5rU/nQPbR
         Z59tY2kl8Q6WAIp8uzqBZIsPQaCoKu1jtCJifE/wY6u8OQGtKrzDb26QSbn4UvP3yyid
         fyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+BcXiFu4CGfnJ2Il2KXoBykK3yCYp61leYBQZjbafqo=;
        b=lL3QObT5sWqk3I1MQ8MLQgRaa0Vs9IWU0muyKHih5cfnDFlt6TxfKdmZVOk228aKAE
         nDt2RxA97T/H6ZhHEGUE2CjQq5allNMRyK/tM1F5InzT24ieq0ZEhMWHEYKSDcU06VqC
         KxJMUXp54KUef6qI5zzAcTNvdowtSzIrt9CXI2iRGEwOXfMZwh0JvxmlGCvAYd1EBAOu
         Qwup76AXS1Fh/k2cuvvVv4ipZeMrR0OkrzXv+hvYwcn1/h247VrQqZ2LmcYh7aKPSZIP
         vnmU8vBOp6tiK9TEa04rwgV2exR+c2xKpoet6x8s1DHoSeHE9fc97OhFacf2owdRvUhA
         qIIQ==
X-Gm-Message-State: APjAAAWzwLdX+fIcIE5PGgwHugyz7jVD8g8CoaoJ1QEWREzuybweKHoF
        yk9u9St+OO4HlsJqsJ0YyTmRPVORblbDfvmefTs=
X-Google-Smtp-Source: APXvYqwp9hgMqEPckFSGIS9cvvUzoV+PB45sU+rDg0tEkZTJOeXpuOwxNIEzrX86aFwXoCFqh9Qy96Z1EdsFSicFUSw=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr1933824itl.10.1557395813947;
 Thu, 09 May 2019 02:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190508111249.15262-1-pclouds@gmail.com> <20190508111249.15262-2-pclouds@gmail.com>
 <0509589b-7a92-6c05-e404-65a9b2bf5666@gmail.com> <CACsJy8DEjBS-aiWqDe2AU56rJBVZ4Po6c-C7GxR4QDNiGSiZoQ@mail.gmail.com>
 <d018ea8c-6f7f-1587-d56b-af3225d6cf0b@gmail.com>
In-Reply-To: <d018ea8c-6f7f-1587-d56b-af3225d6cf0b@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 May 2019 16:56:27 +0700
Message-ID: <CACsJy8BR9XqEvQfnaBAjdgtp6J=FOhbUDpYCkMN4P4wOcw5Dmg@mail.gmail.com>
Subject: Re: [PATCH 01/19] revision.h: avoid bit fields in struct rev_info
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 10:52 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/8/2019 10:41 AM, Duy Nguyen wrote:
> > On Wed, May 8, 2019 at 9:07 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 5/8/2019 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >>> Bitfield addresses cannot be passed around in a pointer. This makes i=
t
> >>> hard to use parse-options to set/unset them. Turn this struct to
> >>> normal integers. This of course increases the size of this struct
> >>> multiple times, but since we only have a handful of rev_info variable=
s
> >>> around, memory consumption is not at all a concern.
> >>
> >> I think you are right that this memory trade-off shouldn't be a proble=
m.
> >>
> >> What worries me instead is that we are using an "internal" data struct=
ure
> >> for option parsing. Would it make more sense to create a struct for us=
e
> >> in the parse_opts method and a method that translates those options in=
to
> >> the bitfield in struct rev_info?
> >
> > But we are doing that now (option parsing) using the same data
> > structure. Why would changing from a custom parser to parse_options()
> > affect what fields it should or should not touch in rev_info? Genuine
> > question. Maybe you could elaborate more about "internal". I probably
> > missed something. Or maybe this is a good opportunity to separate
> > intermediate option parsing variables from the rest of rev_info?
>
> You're right. I was unclear.
>
> rev_info stores a lot of data. Some of the fields are important
> in-memory structures that are crucial to the workings of revision.c
> and are never used by builtin/rev-list.c. Combining this purpose
> with the option parsing seems smelly to me.
>
> Thinking more on it, I would prefer a more invasive change that may
> pay off in the long term. These options, along with the "starting list"
> values, could be extracted to a 'struct rev_options' that contains these
> integers and the commit list. Then your option parsing changes could be
> limited to a rev_options struct, which is later inserted into a rev_info
> struct during setup_revisions().
>
> Generally, the rev_info struct has too many members and could be split
> into smaller pieces according to purpose. I created the topo_walk_info
> struct as a way to not make the situation worse, but doesn't fix existing
> pain.
>
> My ramblings are mostly complaining about old code that grew organically
> across many many quality additions. It is definitely hard to understand
> the revision-walking code, and perhaps it would be easier to understand
> with a little more structure.

Thanks. This is much better.

> The biggest issue with my suggestion is that it requires changing the
> consumers of the options, as they would no longer live directly on the
> rev_info struct. That would be a big change, even if it could be done
> with string replacement.

I agree rev_info has grown "wild". It's quite ancient code. As you
noted, it's a big change. And since my series is already long (76
patches), I would rather focus on just one thing, rewriting the
parsing code with minimum changes to anything else, preferably retain
the exact same old behavior.

After that work is done (and no regression found), we could focus on
reorganizing rev_info, which could be quite "interesting". Some fields
may be overloaded with different purposes, which I just can't spend
time investigating now. There's also the problem with freeing
resources after rev-list is done, which I think we have ignored so
far.
--=20
Duy
