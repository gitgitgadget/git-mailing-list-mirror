Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E5620899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbdHWTyk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:54:40 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36771 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932539AbdHWTyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:54:39 -0400
Received: by mail-yw0-f178.google.com with SMTP id y64so6929981ywf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nd6YZ5ah6lkK3JdSj2/Kc03wy+0t70/ggkubxGbluAU=;
        b=nCtte8cz2smKPjuGvYNdRNFJ0sKF3XyQ0n2+zYFa7YcNve0z55yRp3+QErhPVEk2EX
         GcEh5MGWaDD4koPsTQxer6fmYQC1Kc54IuZf2aQzHatCH/TyVcCf2fEC17N1JEW7XwF6
         SXqX966CQOz0lk907AEE9Pxt1q4rfL0VeZE09iGIqxO4C5sZz07J7PGWNUQmYqSAzFOr
         yZCZohLoeXcdR5m/DVcVr+k0MprLByuMHxZPesMg2nSzOINFIPmxHbvuqmhjCFj4rv+6
         zqrvdwr+iu3ulSm5yFhzMa3VVXUSjF6e3gZRogpxh0pEumCtfMXsLy6LPEGo6ZXZ2kmv
         dhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nd6YZ5ah6lkK3JdSj2/Kc03wy+0t70/ggkubxGbluAU=;
        b=q32uykrYTNyGnMVFmSQrEjOhWW+LguTlKfSmh2eSPwg9jUFP7wvkYfOIbXrwtleyMG
         6seQ2an3bQ90Z5NgYU0bEDvDIeQknAwtMNQltUoMEfLh9S47t+Yx+b8IclfN6WXgX3Gg
         E3umHAcyo35TfTX5Z33YgWQL6/6GcizlNgJEGXAIbFiti3dhtS2/sVXdWMzwUibMeq4R
         oUDB5ZlI1Ks376jS4PA4OLnxpqU4n1XCyTaA2ipZ0yiKrWLQRLOkmq8Go3TimbiF1p0F
         03hCSqpUBU7RoY2Xoafd+spaYgh+Z4Oa1qXTa6NH1gHzZnl2HAZPtXaUdyAK2NS3a2jt
         CtMg==
X-Gm-Message-State: AHYfb5hLppyKUR9mWfm/spi3DOHscqPuhkyT21MK/cOqEgWetDeJXVh3
        ekbZ4JFKM+Up+dsz9R/IN7EeCdhjoLBO
X-Google-Smtp-Source: ADKCNb6ASW0oENakT82E7WSuW9xks9/nQ+dZ5jPO0lLCbyBh2ZZWE5YAp8b5X12KNMSZEDUz4xt2bWufFL22hnybhAQ=
X-Received: by 10.13.229.3 with SMTP id o3mr3032731ywe.137.1503518079213; Wed,
 23 Aug 2017 12:54:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 12:54:38 -0700 (PDT)
In-Reply-To: <20170823123704.16518-12-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-12-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 12:54:38 -0700
Message-ID: <CAGZ79kY8cW+6+60bgSAhS69nBWZbn1LA7gT3t4Ddii+MB2V_cA@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] revision.c: --all adds HEAD from all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +int other_head_refs(each_ref_fn fn, void *cb_data)
> +{
> +       struct worktree **worktrees, **p;
> +       int ret = 0;
> +
> +       worktrees = get_worktrees(0);
> +       for (p = worktrees; *p; p++) {
> +               struct worktree *wt = *p;
> +               struct ref_store *refs;
> +
> +               if (wt->is_current)
> +                       continue;

As said in an earlier patch (and now this pattern
coming up twice in this patch series alone), the lines
of this function up to here, could become
part of a worktree iterator function?

> +               refs = get_worktree_ref_store(wt);
> +               ret = refs_head_ref(refs, fn, cb_data);
> +               if (ret)
> +                       break;

with these 4 lines in the callback function.

> +/*
> + * Similar to head_ref() for all HEADs _except_ one from the current
> + * worktree, which is covered by head_ref().
> + */
> +int other_head_refs(each_ref_fn fn, void *cb_data);

This is already such an iterator function, just at another
abstraction level.
