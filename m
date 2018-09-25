Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A171F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeIZAK0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:10:26 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35040 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIZAK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:10:26 -0400
Received: by mail-yb1-f193.google.com with SMTP id o63-v6so10170941yba.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ajKFb10o8qBs5zTrVZAAerw8rgQQquwCHjpdF6UplW8=;
        b=N6hV5+Ovxv2J//cx4hgJjzCXYocD5IaXo3EDQq74sQWzjpuNf7fcn0r511WXm0eLIG
         CJ+1Hz++awFKHfhrWOxgtJzSjQNOh44ZrWZb/iYriIVpVLAPNyvXmm2GGoPzI9UOeX9p
         IqYvJRwOISkYRVZEIhTgGYzKiHzbmwUvriGD1ZhgbR6i4eLnIvWSB0ME1LyQjPIWbKHA
         1ZEptct16mk9OylVgLuRp7nQeAGnnzW9jJfmvK12tcJKAz2syeIltzCiRg76df6I720o
         6fLtFoQZ6JdT9QSPFgcQWmrtwiPX/owwEx4Ai8RPp8+OkYGqmM+4dNpRGBCY/G+FhhOi
         l1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ajKFb10o8qBs5zTrVZAAerw8rgQQquwCHjpdF6UplW8=;
        b=I/yfysCJHtyuOLdRmeg5qeyYZz0Ts4xFcuyeeP5kZWwnrfVoAuYYKkteenrDjH6/JF
         nZ9FQNodr7S2ELZ3TGcgLsqa0QUmlKhaFdilndQWURSjvBZGJE+9OrdYOCpIxdqbPh1B
         k6iClSiDIDWmItv+yINT8mDsZg46PdT+Fcub5ehcBxF3MbMdgnQZuusTqQyE3TcnhgcO
         ViRygBJ7zsZrqlJ/UeZeNFF7iFs8ZwnGHxJyzyD2MJCd0vxIs4ZpJ1Sb4AGGWxeK0lTc
         hVutOLY4XAODsx4VrTbMb2gYAtmeXH11zhpyCJmi7fxO/6F6pgqVxRKYNy7x7+z7yrC8
         uKlQ==
X-Gm-Message-State: ABuFfojzT899a65jXhEPtQaE0sw9oHxIy1tRAv+WSZgnQbQDuwTgPxDP
        V0ckYPB4z9M9bPHlPh5f1ndRk52EoXY0akG2rdjFhw==
X-Google-Smtp-Source: ACcGV60v7j5XR4A10Yb2QdsEGxIesXhpAlubaTJCWJM0Qi7bg7OcjRThBvEJglWzkF2YQBXYH+1+35G5P9rcCBoXWvc=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr1241936ybh.416.1537898505429;
 Tue, 25 Sep 2018 11:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.41.git.gitgitgadget@gmail.com> <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
 <20180924213223.GG27036@localhost> <20180925070618.GB1596@xps> <4d276a77-0ac9-c1d1-b5de-3ded394efb0b@gmail.com>
In-Reply-To: <4d276a77-0ac9-c1d1-b5de-3ded394efb0b@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Sep 2018 11:01:34 -0700
Message-ID: <CAGZ79kZEN9pSBAdVajfRrrb_D3twD+C7hnzZti+TqO0-sVp9PA@mail.gmail.com>
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
To:     Derrick Stolee <stolee@gmail.com>,
        Matthias Sohn <matthias.sohn@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 7:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/25/2018 3:06 AM, Patrick Steinhardt wrote:
> > On Mon, Sep 24, 2018 at 11:32:23PM +0200, SZEDER G=C3=A1bor wrote:
> >> On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitGad=
get wrote:
> >>> From: Derrick Stolee <dstolee@microsoft.com>
> >>>
> >>> The index v4 format has been available since 2012 with 9d22778
> >>> "reach-cache.c: write prefix-compressed names in the index". Since
> >>> the format has been stable for so long, almost all versions of Git
> >>> in use today understand version 4, removing one barrier to upgrade
> >>> -- that someone may want to downgrade and needs a working repo.
> >> What about alternative implementations, like JGit, libgit2, etc.?
> > Speaking of libgit2, we are able to read and write index v4 since
> > commit c1b370e93
>
> This is a good point, Szeder.
>
> Patrick: I'm glad LibGit2 is up-to-date with index formats.
>
> Unfortunately, taking a look (for the first time) at the JGit code
> reveals that they don't appear to have v4 support. In
> org.eclipse.jgit/src/org/eclipse/jgit/dircache/DirCache.java, the
> DirCache.readFrom() method: lines 488-494, I see the following snippet:
>
>                  final int ver =3D NB.decodeInt32(hdr, 4);
>                  boolean extended =3D false;
>                  if (ver =3D=3D 3)
>                          extended =3D true;
>                  else if (ver !=3D 2)
>                          throw new
> CorruptObjectException(MessageFormat.format(
> JGitText.get().unknownDIRCVersion, Integer.valueOf(ver)));
>
> It looks like this will immediately throw with versions other than 2 or 3=
.
>
> I'm adding Jonathan Nieder to CC so he can check with JGit people about
> the impact of this change.

JGit is used both on the server (which doesn't use index/staging area)
as well as client side as e.g. an Eclipse integration, which would
very much like to use the index.

Adding Matthias Sohn as well, who is active in JGit and cares
more about the client side than Googlers who only make use
of the server side part of JGit.

Stefan
