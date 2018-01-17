Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063AB1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754644AbeAQWZp (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:25:45 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:46350 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbeAQWZn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:25:43 -0500
Received: by mail-it0-f51.google.com with SMTP id c16so11122412itc.5;
        Wed, 17 Jan 2018 14:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ivewxAMMt9IbN82pUZes7rC9mpmwh9EM3EU1uGbRh4E=;
        b=Vqf1Ar32FlPbAAI5F/MJ2VB9UzZU8uffCfR3bppJ58HIR2QRnzefCVeoNFyUCNLdm7
         VawSjgcYuLu3MpIj6Y2QFwiQvns4WBh3jGkXkN9F/O2nWAboJH/ymmG8EqSlWTBa7kZA
         Sl2TSjSvMqbQDlCRgG0/75XZWYSkwvS4EsIjfK7YvEaDBKGr8BAllEvjZxgo+vzyRMbf
         Cul1j3pcyzq+lB4nsAsnXR+qP/5MAsg0+pcl/mte0SEj9V0/1YXV/tiTFPrgU8ZtFXXn
         ZLbUYkT5SC9Vk1Z2OOttBThwZRwy/KcahrWbqVvkBB+Ixe5f5umjRk2luGpAL6cc+ReF
         hZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ivewxAMMt9IbN82pUZes7rC9mpmwh9EM3EU1uGbRh4E=;
        b=AggjQr0lIoFWPeJ345/wRxGdRhWnHVDVSZBWEWjrF5bq1L8TC0ol/oEKI7YxcL0PeY
         NQg8A0A1rrvKKPunLZlmstNwAVe7Z3ORxczndKPyVfXpPJNEx+bX0dx/9lEFgule24P0
         C7DF7JzdpYxITRLgnAH1wfm42ampVTKH2CvRgN+bQ4lWoNDle3AnlLlT+QaCWCeh/1YW
         Ms6greyInKZnLJ7tGsTD+xvJAmznpyWwwGNsbTXIk0F3+ELUoXjZx5iJsSNKeCJKpFOM
         f9V6YYOrgeA5glu4njPVMZiVbHDzI9ygo3aI4M2LXWFOvEm11g/rKk/nG/udcNIBZhpo
         a/Ug==
X-Gm-Message-State: AKwxytes/82XnpoxMMGI+WG7TqXPms+ZdzoJFhVJOTqGGGrHPsYbKQ//
        oxu4pKT3ZIK1GKoVd8gLWjRWbtN/OZSPEVB5kgpL+A==
X-Google-Smtp-Source: ACJfBotE/z9Rbm+Oeg58kRDQC03DFsxRd5AaBYx523xhgOda+7nqgGi6f1aB7mxLAQWFcffLCoVbCzoIw4X3eT+Wers=
X-Received: by 10.36.47.5 with SMTP id j5mr17067424itj.123.1516227942364; Wed,
 17 Jan 2018 14:25:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.147 with HTTP; Wed, 17 Jan 2018 14:25:41 -0800 (PST)
In-Reply-To: <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jan 2018 14:25:41 -0800
X-Google-Sender-Auth: -JMTpSryQ46rzRXsJmqZa9x79Hs
Message-ID: <CA+55aFxSEd4azxVTEDNnUJaFY0Lp7VMQ2OGTYmVOFF7cr_HcqA@mail.gmail.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 2:07 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The original git design was very much to write each object file
> without any syncing, because they don't matter since a new object file
> - by definition - isn't really reachable. Then sync before writing the
> index file or a new ref.

.. actually, I think it originally sync'ed only before starting to
actually remove objects due to repacking.

The theory was that you can lose the last commit series or whatever,
and have to git-fsck, and have to re-do it, but you could never lose
long-term work. If your machine crashes, you still remember what you
did just before the crash.

That theory may have been more correct back in the days than it is
now. People who use git might be less willing to treat it like a
filesystem that you can fsck than I was back 10+ ago.

It's worth noting that the commit that Junio pointed to (from 2008)
didn't actually change any behavior. It just allowed people who cared
to change behavior. The original "let's not waste time on fsync every
object write, because we can just re-create the state anyway" behavior
goes back to 2005.

              Linus
