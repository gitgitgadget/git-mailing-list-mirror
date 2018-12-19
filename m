Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC75E1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeLSVrG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 16:47:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46978 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 16:47:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so18687240ljh.13
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w0CPbCDI1ejQUNMduKxaWxipbdjLdL3YC4vUhuM4jNs=;
        b=ar2pgd5xMzqJmjXKVoxivDca2TwYOrIN3eEuyryZYFF4TZ7u5I6sEsnx742teUxIQO
         Do+C3v+AOPaXxTPS31NbIxJ0E4tSz2floNuet2Qgtm1qRpvoGRL5nJVbHVXkAcTnKoyK
         bj5/LI1t6LIZ7Tt2M/wu4ZTOpQa0OwwpOmsBlmOhZENdayNUNvm/wNSqGXLW6LVG05Rh
         3qSvkRW1mMTel/eJ1Hpq03ovmVkL1tje/J4HOSlCPDQBLUQReTOD7p7uBI/AWONqDiGI
         X+Ul/ov/8DRHqrVaCC31qpx3EIhFMWgfZO8fsFJywT5rO7+jRTRZNwmwrelIDrmFfCyD
         xIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w0CPbCDI1ejQUNMduKxaWxipbdjLdL3YC4vUhuM4jNs=;
        b=VCej9+UsLY56EczTjcTcwDTAHfrlni8rE+1QsLq+iuNNnk6+2e84zCXCaxORjCRrCq
         VZlCrzTQM87pfwwL750rk8BwDDQEgc2ac6TQ2LDdtpdUTqvOaDKQpXcrQy0itpltuw2t
         9uRaMNWHoJGKMeTOlrwhxCU7+3Rbz1Dg2ox4gv5ISXYUo/M8up9zZnSPMn8KYsBnzSnO
         pGSM709nlH7QPRkVH+R2L75zzcBOvEhpXVlXdgNcoDmOn+MfehwmUYF2dTkQj+C7Aq4N
         vx0uHM60pRMiCxfl6to/K6FfdA9h0rt4AkIN2EYA91AcddLPlwJW2MGNjQ6RaRlgVp36
         tdGw==
X-Gm-Message-State: AA+aEWarBSJS5MVFW0rbHf5EMd9D/+d8QUAYBMMMMvthjfd4D8TOzU15
        LDKzXhN9CBPs9BGGXPafK3mhhQTETjxS/kyN/l6BCQ==
X-Google-Smtp-Source: AFSGD/UfqxHvdSF6hZDev8/aWFNM/0YNKP7Y8GNmJVODfGJ3GJPEv4tqFaFuupRMUrQDikH0hqYpan2k4FpRpdd7TGo=
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr6360071ljg.50.1545256023570;
 Wed, 19 Dec 2018 13:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-3-martin.agren@gmail.com> <20181219153841.GB14802@sigill.intra.peff.net>
In-Reply-To: <20181219153841.GB14802@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Dec 2018 22:46:52 +0100
Message-ID: <CAN0heSpc_sap1cZktteRn3hyeuRx2w86Hd2kqxu4XFgHs75_Kw@mail.gmail.com>
Subject: Re: [PATCH 2/3] setup: do not use invalid `repository_format`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Dec 2018 at 16:38, Jeff King <peff@peff.net> wrote:
>
> On Tue, Dec 18, 2018 at 08:25:27AM +0100, Martin =C3=85gren wrote:
>
> > Check that `version` is non-negative before using `hash_algo`.

> Hmm. It looks like we never set repo_fmt.hash_algo to anything besides
> GIT_HASH_SHA1 anyway. I guess the existing field is really just there in
> preparation for us eventually respecting extensions.hashAlgorithm (or
> whatever it's called).

That was my understanding as well. Maybe I should have spelled it out.

I think of the diff of this patch as "let's check `foo->valid` before we
`use(foo->bar)`", which should only be able to regress in case foo isn't
valid. And ...

> Given what I said in my previous email about repos with a missing
> "version" field, I wondered if this patch would be breaking config like:
>
>   [core]
>   # no repositoryformatversion!
>   [extensions]
>   hashAlgorithm =3D sha256
>
> But I'd argue that:
>
>   1. That's pretty dumb config that we shouldn't need to support. Even
>      if we care about handling the missing version for historical repos,
>      they wouldn't be talking sha256.

... this matches my thinking.

>   2. Arguably we should not even look at extensions.* unless we see a
>      version >=3D 1. But we do process them as we parse the config file.
>      This is mostly an oversight, I think. We have to handle them as we
>      see them, because they may come out of order with respect to the
>      repositoryformatversion field. But we could put them into a
>      string_list, and then only process them after we've decided which
>      version we have.

I hadn't thought too much about this. I guess that for some simpler
extensions--versions dependencies it would be feasible to first parse
everything, then, depending on the version we've identified, forget
about any "irrelevant" extensions. Again, nothing I've thought much
about, and seems to be safely out of scope for this patch.


> So I think your patch is doing the right thing, and won't hurt any real
> cases. But (of course) there are more opportunities to clean things up.
