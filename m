Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801EA1F404
	for <e@80x24.org>; Thu, 18 Jan 2018 10:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755232AbeARKTz (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 05:19:55 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:44932 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754932AbeARKTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 05:19:53 -0500
Received: by mail-ot0-f176.google.com with SMTP id t20so10260805ote.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vcR9znPjsxxqHu0ryGpxtoutJFMtL+OcPnRnd19nbKE=;
        b=DF4R2T4Yu7+8slXVap5HgSk3wW9KrFeN6fHed6vGV/X3bBRACQtZZEiv/dVG8mH6RF
         Y861kTgL31NRng3dT1bsnqu/NikgXh/z8mL09Xoa/XI0StjL9hNtL/wHBYBZhBV2ZcT9
         sP4WFOPntRIdj8RbxvKARk1yebtEp99lmgDPl5xUajq+I7MTwFlyQupsMpvRPeRV+USX
         T4RQRx3v0NR8b/8At3VXyIqQkrIv2kPueqayIwaEudZcA8KF42oT80eWGcdbZ7IarFQT
         U6lwkIZW9ddI+jnwjXrdqRzHMeF0kjMk2r5zeEpNJfLmzIejXZILIcO5MPOmx8dDqLJj
         Kysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vcR9znPjsxxqHu0ryGpxtoutJFMtL+OcPnRnd19nbKE=;
        b=lRiY5HGAOHtTv3tZaHTcEAkvqBVVLRrU1jLl3oAxUXlvog9H5OshyHsuIYKMoQ8WlG
         IqJyl4o9x2rWAMY9k7tFXApiXjeKmuf8fdmP/V0I6ZvXZ8z7hs3hdtUcalNkf4uCWcIz
         1asWDE3U3dseHbvdUZeHmhdWmzReaHzYEts48snKoUHIOrt+vP1uCZ4Vbz0Z2OQkxJJ2
         vlgZp3QrWeC3nXJwjJUaclJpL3QCEs/QK2cu14uM3Zxg5057vfD4Lc33MBrUd0zGepzg
         yw9vLt3fQskH0HRY8cuDPfvDQjFD94sYeEe+wE0HZxkX2JS3m7m/6u+6QVbCHPJf57ZC
         sopQ==
X-Gm-Message-State: AKwxytfTqacTR9WsqruxMFd3Lch8fhlSLd/9o/CpPNVHfCuEHoIugbtO
        POtN4QP6OHgnlKFR9IeF8SSTBYaYOOZ9XoVSSEQ=
X-Google-Smtp-Source: ACJfBosnB2xhwR6OXkIgG9hyOpa/+1kudD9yCSmU2Fap2c9UjaFfv0MkXJAV8RwKVV1f50fJG4fij0xhcru6tX3L9Is=
X-Received: by 10.157.14.65 with SMTP id n1mr3076920otd.337.1516270792675;
 Thu, 18 Jan 2018 02:19:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 02:19:22 -0800 (PST)
In-Reply-To: <20180117181618.GA112319@aiede.svl.corp.google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com> <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com> <20180116214239.GA3622@google.com>
 <CACsJy8A9AheuBK-mKy9d9m5yfSFFZ9N8=wg8FZD_C6mHHTdqXg@mail.gmail.com> <20180117181618.GA112319@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Jan 2018 17:19:22 +0700
Message-ID: <CACsJy8D+SjWsTtwBSPbw5cVVSuVFYP6GVRSWaP7AWSgLC3e=TQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 1:16 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Duy Nguyen wrote:
>> On Wed, Jan 17, 2018 at 4:42 AM, Brandon Williams <bmwill@google.com> wrote:
>
>>>                                  IIUC Split index is an index extension
>>> that can be enabled to limit the size of the index file that is written
>>> when making changes to the index.  It breaks the index into two pieces,
>>> index (which contains only changes) and sharedindex.XXXXX (which
>>> contains unchanged information) where 'XXXXX' is a value found in the
>>> index file.  If we don't do anything fancy then these two files live
>>> next to one another in a repository's git directory at $GIT_DIR/index
>>> and $GIT_DIR/sharedindex.XXXXX.  This seems to work all well and fine
>>> except that this isn't always the case and the read_index_from function
>>> takes this into account by enabling a caller to specify a path to where
>>> the index file is located.  We can do this by specifying the index file
>>> we want to use by setting GIT_INDEX_FILE.
> [...]
>>> In this case if i were to specify a location of an
>>> index file in my home directory '~/index' and be using the split index
>>> feature then the corresponding sharedindex file would live in my
>>> repository's git directory '~/project/.git/sharedindex.XXXXX'.  So the
>>> sharedindex file is always located relative to the project's git
>>> directory and not the index file itself, which is kind of confusing.
>>> Maybe a better design would be to have the sharedindex file located
>>> relative to the index file.
>>
>> That adds more problems. Now when you move the index file around you
>> have to move the shared index file too (think about atomic rename
>> which we use in plenty of places, we can't achieve that by moving two
>> files). A new dependency to $GIT_DIR is not that confusing to me, the
>> index file is useless anyway if you don't have access to
>> $GIT_DIR/objects. There was always the option to _not_ split the index
>> when $GIT_INDEX_FILE is specified, I think I did consider that but I
>> dropped it because we'd lose the performance gain by splitting.
>
> Can you elaborate a little more on this?
>
> At first glance, it seems simpler to say "paths in index extensions
> named in the index file are relative to the location of the index
> file" and to make moving the index file also require moving the shared
> index file, exactly as you say.  So at least from a "principle of
> least surprise" perspective I would be tempted to go that way.
>
> It's true that we rely on atomic rename in plenty of places, but only
> within a directory.  (Filesystem boundaries, NFS, etc mean that atomic
> renames across directories are a lost cause.)
>
> Fortunately index files (including temp index files used by scripts)
> tend to only be in $GIT_DIR, for exactly that reason.  So I am
> wondering if switching to index-file-relative semantics would be an
> invasive move and what the pros and cons of such a move are.

I think it gets messier. Now you have to move two files. If the first
move succeeds but the second one fails, recovery may involve un-move
the first file, but its old content is already gone. We probably can
get around that. But since the shared index is assumed big and heavy,
I just went with "store it in the place it's going to be and never
move it anywhere ever (until nobody uses it then it's deleted)"
-- 
Duy
