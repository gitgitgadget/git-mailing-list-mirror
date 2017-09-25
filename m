Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA915202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 18:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbdIYSvd (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 14:51:33 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:50078 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbdIYSvd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 14:51:33 -0400
Received: by mail-qk0-f180.google.com with SMTP id u67so7687772qkg.6
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U8UEo3sm735LRVkIqgvf325WfxW/nwngCuHfMo3a38g=;
        b=XTd0NGD+bxIYmjWCIg6P5z2/S71uk/cOb9TNL/+vq+1tys2WAPiDUm87ANgx/aSfeU
         d+SDdBr0hbn7VPzr6tlgc21iGshhK7qW5L59VtueWvAC93BXSnHqWxfL97Yyk5nn+oo+
         WS7DUvKUrdj1doGY/DvGaffB2lL7akJ1ulzEBpmmXpPwYzmG7A0iFc8kgl07LTGgPtnt
         xY2trHhuLBLIZHVwvZk31Ue5+ueraSGn2ilCPj+qE41w5S1LUHAazCrjnU8/IuDkmJAn
         XkUmFOlSbtttCRm/au8Q6lQ12USbheRTfj7smtkm8iWKp7nZlOlabUggWdxl4teVB8og
         hKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U8UEo3sm735LRVkIqgvf325WfxW/nwngCuHfMo3a38g=;
        b=g0/yqIlZxeetobHIUM5ls4CMwcAsAj/AmBvsuhAEymTEqirO7By0TLINfM1Ag+nXI2
         GosIdPBdRvxxCm97PI03QwZliUWtqgAXAsLm6n5MqfPt4QwWGL3ytZQfy3CYVvdfA9+t
         32fHcFtd3I9NoA9RNXdADziC2ExrFsSrjZaoAe6flzlZERn8Gm9s4ylB23Layu78oBkm
         9jot79mxSrsASosrmACqg+ItQh+VffOCJQWZh3tFlIC5HDDtcsEgU7uSXeKUno0m8ODr
         00XJdxWoDQH/uQ5834hBEjpfYK7bhKzW1p/MGknODwpUpuLDoksRRw+pCNWJJ86mxLgY
         4fng==
X-Gm-Message-State: AHPjjUj3a8v8TXUMdlbLG8gcsKmhVxq8v7yl+O4vH1bfoTg7Pqo8dAo0
        yE5m8PyVUHSdE7VSLYiHoUeW9S9Ie5iyJF2KLrmavg==
X-Google-Smtp-Source: AOwi7QB5NG0Rw2d/4GeePzS7lKj3JYas1NHdjTrzUtPtjl+NwbnauKX6khThavTN4i9pOrgZWZV86GH/dVIiW5vbJ98=
X-Received: by 10.55.33.216 with SMTP id f85mr12068102qki.176.1506365491957;
 Mon, 25 Sep 2017 11:51:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 11:51:31 -0700 (PDT)
In-Reply-To: <20170923033425.6ilykxl5pi7unlj6@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org> <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
 <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com>
 <20170922212525.kxldygbjrmjqu7ci@sigill.intra.peff.net> <CAGZ79kYJH-4qb5hiT1C_aCFXLcdiJs5h+Z7Goz4trp52C5s3Lw@mail.gmail.com>
 <20170923033425.6ilykxl5pi7unlj6@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 11:51:31 -0700
Message-ID: <CAGZ79kYOeJvQmw-h3GwFpv2w7AKtNWUxf96tUjPKPY1dMuzagA@mail.gmail.com>
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> There might be another option to cope with the situation:
>>
>>  4. Teach all commands to spinlock / busywait shortly for important
>>      locks instead of giving up. In that case git-status rewriting
>>      the index ought to be fine?
>
> We do have all the infrastructure in place to do a reasonable busywait
> with backoff. I think the patch is roughly just:
>
> diff --git a/read-cache.c b/read-cache.c
> index 65f4fe8375..fc1ba122a3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1563,7 +1563,8 @@ static int read_index_extension(struct index_state *istate,
>
>  int hold_locked_index(struct lock_file *lk, int lock_flags)
>  {
> -       return hold_lock_file_for_update(lk, get_index_file(), lock_flags);
> +       return hold_lock_file_for_update_timeout(lk, get_index_file(),
> +                                                lock_flags, 500);
>  }
>
>  int read_index(struct index_state *istate)
>
> though I think there are a few sites which manually call
> hold_lock_file_for_update() on the index that would need similar
> treatment.

uh, too bad. The patch above looks really promising, though. :)

>
> I suspect it would work OK in practice, unless your index is so big that
> 500ms isn't enough. The user may also see minor stalls when there's lock
> contention. I'm not sure how annoying that would be.

There is only one way to find out. Though we don't want to volunteer
all users into this experiment, I'd presume.

Regarding larger indexes, I wonder if we can adapt the 500ms
to the repo size. At first I thought the abbreviation length could be
a good proxy to determine the maximum waiting time, but now I am
not so sure any more.

Stefan
