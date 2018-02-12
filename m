Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04281F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932471AbeBLV7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:59:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43763 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbeBLV73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:59:29 -0500
Received: by mail-io0-f194.google.com with SMTP id 72so19008368iom.10;
        Mon, 12 Feb 2018 13:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I/516FsDdAH7kL1/NwCUwVFmaWuBC3WwUl4Nsyi1m1w=;
        b=YcoRkSjr5XPcoq6Lfgnit/6Q7XaN4SBlh99vijfnWF09eTN8HHP3F5la9Cy/r5yHAt
         E0JKazfoO3WHOc/iHJCJaVRVxrdn7iRAew9LeAdFs+q7e9/cW0ot8rgO0NA88MM8q2lW
         p42N8jpCUqxH5IYKmOAum05i9ur9bPUUAGAnVaDXDx8yhfFoZ/8q+Qmj89e0Ke4J7bpz
         IHxt3ktjlZd5F/sV0CDvZIgfWezXTnAPGjEVbtXL20+M5Y4/oqTle+O5lBgQLlz8i2Zz
         qX2+V3ywwVVtTItEZzpemgSusuT1JGa1Zim5guib94NTMcd9v4UwCCmKNaUjXqcrpYwZ
         kV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I/516FsDdAH7kL1/NwCUwVFmaWuBC3WwUl4Nsyi1m1w=;
        b=Lt1lZdI6cpERSLHC2iJrfirV5BSny+2lHgXw40kUMHLaFlangbCiWJsNDWAf46NZNJ
         ne2Eq4HKK1UhAh9bXhCQ9KBqVTHH0vf6l8xbHSM8SxG6Keb1FqhM5fFQvpI8Z9YQiGvC
         +DoO1A1Vj64Rt/185v1GUOvSAjow7FN5uSd2vINj6qR+xdR00s9GSmJuQ8iKWAWUH01U
         OUdBVnhKGHDwleiOfQ0YjvOcoSeMhxogRf+A71CKf/dQtJ2aAkCEsZGbfjl3noGfPVP7
         EJuNaLroVok9JZY6yc3eHZWw2gi30vBoavYW2/2itMQnYDXIzXrDLVk8Fvz5ayfhMIH2
         faHA==
X-Gm-Message-State: APf1xPDrOCGywpEX4a6SUyihULEJW8Ov7vZpDJ+Z6dwbKhJkopStbSmy
        4IaZYhMT/2JmwX3qExi/+pYyKI2gpp0UNxqRP00=
X-Google-Smtp-Source: AH8x225y3uwgwkWIbJCbF5Y/hSZ/WuQ6kUNXLRfufMKtOyfaYIB+zhXPB9ef7WRSMl3uyF4VjidRErORXr5w13neh2E=
X-Received: by 10.107.81.20 with SMTP id f20mr15232405iob.174.1518472768438;
 Mon, 12 Feb 2018 13:59:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.135.221 with HTTP; Mon, 12 Feb 2018 13:59:27 -0800 (PST)
In-Reply-To: <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
References: <20180213080036.3bf3a908@canb.auug.org.au> <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
 <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com> <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Feb 2018 13:59:27 -0800
X-Google-Sender-Auth: o1Ew_raxS7sRcXPJ9oDXFf85NZY
Message-ID: <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> But I wonder why "update to upstream" is merging a signed tag in the
> first place.  Wouldn't downstream's "try to keep up with" pull be
> grabbing from branch tips, not tags?

I'm actually encouraging maintainers to *not* start their work on some
random "kernel of the day".

Particularly during the kernel merge window, the upstream master
branch can be pretty flaky. It's *not* a good point to start new
development on, so if you're a maintainer, you really don't want to
use that as the basis for your work for the next merge window.

So I encourage people to use a stable point for new development, and
particularly actual release kernels. The natural way to do that is
obviously just to create a new branch:

   git checkout -b topicbranch v4.15

and now you have a good new clean branch for your development.

But clearly we've got a few people who have gotten used to the whole
"git pull" convenience of both fetching and updating.

Some maintainers don't even use topic branches, because their main
work is just merging work by subdevelepoers (that goes for my own
tree: I use topic branches for merging patch queues and to
occasionally track my own experimental patches, but 99% of the time
I'm just on "master" and obviously pull other peoples branches).

And some maintainers end up using multiple repositories as branches
(the old _original_ git model). Again, you can just use "git fetch +
git reset", of course, but that's a bit unsafe. In contrast, doing
"git pull --ff-only" is a safe convenient operation that does both the
fetch and the update to whatever state.

But you do need that "--ff-only" to avoid the merge.

              Linus
