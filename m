Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D12720281
	for <e@80x24.org>; Wed, 13 Sep 2017 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbdIMBjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 21:39:39 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:46175 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdIMBji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 21:39:38 -0400
Received: by mail-wm0-f45.google.com with SMTP id i189so6578048wmf.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 18:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kv3OrCl+c808TlhIfhqmE1YKz3OYjA8ELK1RdpRjmys=;
        b=qiZuz0W9bdhohZbmLw7xh1gghTwBLvnySx03OT09Jkbumz9vV3PRL3905310lPCF8E
         DOpE8fbtIgBoKj/rJaDm6OkJdbuE+P0ZdCIFrB1pNj93Fi6+AHdasJDjaNmrTuzdPI4j
         koG2Dyf8VAjew8TwtORCNz309RGyXs+Esbo88G2tIse1CvBeRotLgy/j+GCwGFfA9jDI
         p2FvsE3nbLX52YRglNP0nkLQLg8OgN5zxTgLmuc4BaU4djbuZ0iVZoYo5t0lb4TFMJoJ
         Rkduc6hSp1iXZ+WhCQTRg3wIXgQpYk/0J/FUTFtb9Xx7vaLFMbLDBxh4ogkq3fnDRJwz
         6j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kv3OrCl+c808TlhIfhqmE1YKz3OYjA8ELK1RdpRjmys=;
        b=CVGkcvDTv11JPBwxFEUj5wgLaWnLjiLVlsQfemoxd5bCCp44IZCaQD34GV4e2CurPV
         TawEEpS5ZfSQhlx9foxI0bsIQemPKcxGwovUYzBx8tCEJzgq/DsSKcaUZQc5tkEFtdeF
         BT6wCnTdRKD1OlKkVGQ5NUZk3Twkxuem6t9IcXmBC6O1lEDWswpyJOxKVL96TDqAaSCj
         M2SOBpxvvqE/PkXn05LJWGbrMEHQVDk65kH1kw4qLKBiiWoJO9XD5zn2IdriSD6ZW1un
         Fvoa/gXdLG90MYHDMif7JY7wBNQWua4cYgPFarwYjRpAb1YpyWbjaB0kbVc4Q6qDY3c1
         cqPg==
X-Gm-Message-State: AHPjjUg/F/pGlmoXZuCwLio/C9iaLE7qxb9dGxH8nvB+0KuhHdXxFrcw
        tKstKwGQej37xbdyAZWZ16+4SYaWE6N2MkvzQ/M=
X-Google-Smtp-Source: ADKCNb4W3zt7Kiewi0Eqrq7kX2MVjGoBd3nouEUEVgTJZ3WLqFnywRLEHZR33HbWyRuZlmgiD9H9l8LDyUuOqeAbr+M=
X-Received: by 10.80.169.43 with SMTP id l40mr14463024edc.187.1505266776925;
 Tue, 12 Sep 2017 18:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.185 with HTTP; Tue, 12 Sep 2017 18:39:16 -0700 (PDT)
In-Reply-To: <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com> <20170908180050.25188-2-kewillf@microsoft.com>
 <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com> <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
 <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com> <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
 <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com> <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Sep 2017 18:39:16 -0700
Message-ID: <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 4:30 PM, Kevin Willford <kewillf@microsoft.com> wrote:
>
> Sorry.  It was not in the sparse-checkout file.
> $ git config core.sparsecheckout true
> $ echo /i > .git/info/sparse-checkout
> $ git checkout -f
> was ran in the modified file case as well and "i" was the only file in the
> working directory before reset.
>


I'm assuming then that you mean that some file "m" is modified by the
commit, and do not mean to say that it has local modifications in the
working tree? That is not what I had inferred from earlier, so I was
very much confused.

In this example, the only file actually checked out is "i", as
everything else will have the skip-worktree bit set..?

So doing git reset HEAD~1 will reset the branch back one commit, and
now because of this reset is clearing the skip worktree flag, and
since you never had a copy of it checked out it is notified as
deleted, because it's no longer marked as skip-worktree?


I think the real fix is to stop having reset clear skip-worktree, no?

By definition if you do a sparse checkout, you're telling git "I only
care about the files in this sparse checkout, and do not concern me
with anything else"... So the proposed fix is "since git cleared the
skip-worktree flag, we should actually also copy the file out again."
but I think the real problem is that we're clearing skip worktree to
begin with?
