Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	TRACKER_ID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09A01F404
	for <e@80x24.org>; Mon, 12 Feb 2018 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbeBLSim (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 13:38:42 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:38099 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeBLSil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 13:38:41 -0500
Received: by mail-yw0-f182.google.com with SMTP id m84so10571858ywd.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OAplRVbzkp2tjxZ1z13zhBieIxJBCUxCZdkPbvpafUI=;
        b=f1L/23M8PVZe6N/Cnj/lpINwZGjtvm/tKXmG65w93FlroJjvRat1yhgt3e5tceEpJ/
         n1BEYmotfsZhu0eC2OJfCeT24cEYysYNp7e75GKZNngxFofzvQEqSHAfxnTH3Uvkm+2Y
         o921+wq5eJmgAb/PBm+GE8KJJ1fRbUr8r0lsniRzuWKEtA+HDN6xOeqfE5UVytBSXYDS
         3tI3NPRnWnEJiSkK9iViodWoHTaBhxdmFc6hVuBQLIp6RaIAMyxyawWgcJS7tmDUgEnk
         vHsat50yxMQPradgdOEZY958UYAqBNPmiSuHlppJUjxYCiw23IzkG29Ei8iCU8Xk151L
         U9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OAplRVbzkp2tjxZ1z13zhBieIxJBCUxCZdkPbvpafUI=;
        b=Ec2cuh5zqlvJdBD6Ydj1spWDOLOSoOkvI2npGyv1Vtg3Jjz/jda5gtkmajJly6n0IP
         tSw+gwnW2WHstQhKwEADQiqVubm1bOMJ8VPBh/qtAn9lxSiviM0szZZ5Uck6MnnQ5Ott
         avrsrb1QXP7q7qFiCGoVia+kn+t1ML4Om3ATXl88zYTUFpYxTFfpwGBVvpYyMJv6/YGw
         Ev0JLr973oBC/AmiUAkDRTHYyuAwWeH4zOIdj52ak2hysc3gH26Jyvmxovln5QAsco6w
         hvIDqLcaZW6gNbkiEIBWzQeVu9jkBjX0mU0miOe/HPARSfR8P8D+TYLwWeoWq34AEGA5
         ZV6Q==
X-Gm-Message-State: APf1xPDFTyD/15W0XJopy9DQA72oZWBGkU+/nlnSyTC/Vq4LQ1pp+CPq
        UHUKLj9pvYN1XJ1ANBnyyFmCthosS+XhY/3iQr0dNA==
X-Google-Smtp-Source: AH8x226mkYVZ3JBOXQv5l2uAK7Y9zX/AYIoPDh1TLwIr4ZpVCtQF28giPPrEX770g2LiygobIgd/hn1MTBU/9VVNA5M=
X-Received: by 10.37.37.87 with SMTP id l84mr8350253ybl.386.1518460720656;
 Mon, 12 Feb 2018 10:38:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.203 with HTTP; Mon, 12 Feb 2018 10:38:40 -0800 (PST)
In-Reply-To: <20180212172306.GA4918@sigill.intra.peff.net>
References: <20180212172306.GA4918@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Feb 2018 10:38:40 -0800
Message-ID: <CAGZ79kayhsgxuPjQ9koBEnpbM3Feq=mHEizdVwZa0EzR-aSEKg@mail.gmail.com>
Subject: Re: [PATCH] describe: confirm that blobs actually exist
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 9:23 AM, Jeff King <peff@peff.net> wrote:
> Prior to 644eb60bd0 (builtin/describe.c: describe a blob,
> 2017-11-15), we noticed and complained about missing
> objects, since they were not valid commits:
>
>   $ git describe 0000000000000000000000000000000000000000
>   fatal: 0000000000000000000000000000000000000000 is not a valid 'commit' object
>
> After that commit, we feed any non-commit to lookup_blob(),
> and complain only if it returns NULL. But the lookup_*
> functions do not actually look at the on-disk object
> database at all. They return an entry from the in-memory
> object hash if present (and if it matches the requested
> type), and otherwise auto-create a "struct object" of the
> requested type.
>
> A missing object would hit that latter case: we create a
> bogus blob struct, walk all of history looking for it, and
> then exit successfully having produced no output.
>
> One reason nobody may have noticed this is that some related
> cases do still work OK:
>
>   1. If we ask for a tree by sha1, then the call to
>      lookup_commit_referecne_gently() would have parsed it,

lookup_commit_reference_gently

>      and we would have its true type in the in-memory object
>      hash.
>
>   2. If we ask for a name that doesn't exist but isn't a
>      40-hex sha1, then get_oid() would complain before we
>      even look at the objects at all.
>
> We can fix this by replacing the lookup_blob() call with a
> check of the true type via sha1_object_info(). This is not
> quite as efficient as we could possibly make this check. We
> know in most cases that the object was already parsed in the
> earlier commit lookup, so we could call lookup_object(),
> which does auto-create, and check the resulting struct's
> type (or NULL).  However it's not worth the fragility nor
> code complexity to save a single object lookup.
>
> The new tests cover this case, as well as that of a
> tree-by-sha1 (which does work as described above, but was
> not explicitly tested).
>
> Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>

This makes sense.
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!
Stefan
