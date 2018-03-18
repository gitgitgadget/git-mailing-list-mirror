Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460681F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 08:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeCRIiM (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 04:38:12 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34083 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeCRIiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 04:38:10 -0400
Received: by mail-oi0-f46.google.com with SMTP id u141so67733oif.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J6fj8rKHL+wkgi36y+wwABkGA0zXQNTF6VYNrjnV1ug=;
        b=b9VtsxGYVBobaN2E4BEt76dtPW7ACqJKENNGzhLCTGGP99IzkUPx87sRWDQomDPP2f
         0A2AbjJ3t17AOehyz7btY9h2VL0Iu1ZTdTsh9j1H1bmuJFpkd+vUz1ljkWSAYPS/2o+u
         qXmTwmxToQZ94p+qjNcIkjJ/HGzXUjkNNNWwZSyGgl66l48Y/vXs4VidXfYg7QJ1Lo+c
         KxylJ+FgWyfj7uVg0y61XJu/EQME83mHQb9ZBKkJUqqSu7nz9AZZju2Zn+NydoITu4A8
         /x/g6rXPfo1JUeP4q7u+q93kz0g2SV0Q0S8ipF6aVjzxeLblz5NNnTNwRMDnMwLfFRPh
         PRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J6fj8rKHL+wkgi36y+wwABkGA0zXQNTF6VYNrjnV1ug=;
        b=ovBaue3wcC/9VAcnJMHHRBYYgXxviQSgrqU7K+p2MYyEIs0d1BlZCZBN9qAzSVhGqW
         ReBYU1YN4WK+Si8dQKSLTRbfs9SXokrkgM3vnKYMNb3h2wTfcMsIX540yQ0NLUYL3yZt
         eHhmmH969n8ydZVZDPdebDymFB7VwGQi3/wnk0Z9OSo+ZykK0a+mheBCxhgMiyph+NFg
         /nBcobwj9lqFHwgakq7sDtXgYao0AgVTLXRjO0VX4/OXHklx7nssv6XrQrOP2kU7excG
         oHyZXywfqwxEpSt2HVZ9LhbnEgXPguVcU3AOk0eqHWASVpIaKtPS1pSETcXJgL9377z2
         5doA==
X-Gm-Message-State: AElRT7HYm3n4GA02LQ/qef3WXbOxLQQ+le4ZgRvwoZCLd91vYixuU4mG
        ltLeJGxya/QRZbja1X0kmPjzLJjnZqDvrnV7ZNI=
X-Google-Smtp-Source: AG47ELs3L5FXczRufYQ0kPZt8v/wye60ZcBjTyJRnRjzpuTWbJQGh1EEopPOnCx6g/bog3RVzKyItVWBOwzMJ4T4D3U=
X-Received: by 10.202.187.4 with SMTP id l4mr5025321oif.56.1521362290333; Sun,
 18 Mar 2018 01:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 01:37:39 -0700 (PDT)
In-Reply-To: <87fu4ycq7s.fsf@evledraar.gmail.com>
References: <20180228092722.GA25627@ash> <87fu4ycq7s.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 09:37:39 +0100
Message-ID: <CACsJy8B8YucY5cJEL9ku2yUhcD4Js2XAjsmHP1B0sGa3yixGhw@mail.gmail.com>
Subject: Re: Why does pack-objects use so much memory on incremental packing?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 11:05 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Feb 28 2018, Duy Nguyen jotted:
>
>> linux-2.6.git current has 6483999 objects. "git gc" on my poor laptop
>> consumes 1.7G out of 4G RAM, pushing lots of data to swap and making
>> all apps nearly unusuable (granted the problem is partly Linux I/O
>> scheduler too). So I wonder if we can reduce pack-objects memory
>> footprint a bit.
>>
>> This demonstration patch (probably breaks some tests) would reduce the
>> size of struct object_entry from from 136 down to 112 bytes on
>> x86-64. There are 6483999 of these objects, so the saving is 17% or
>> 148 MB.
>
> Splitting this off into its own thread. Aside from the improvements in
> your repack memory reduction (20180317141033.21545-1-pclouds@gmail.com)
> and gc config (20180316192745.19557-1-pclouds@gmail.com) series's I'm
> wondering why repack takes so much memory to incrementally repack new
> stuff when you leave out the base pack.
>
> Repacking git.git takes around 290MB of memory on my system, but I'd
> think that this would make it take a mere few megabytes, since all I'm
> asking it to do is pack up the few loose objects that got added and keep
> the base pack:
>
> ...
>

I left some clue in the new estimate_repack_memory() function in my gc
series that could help you find this out. I haven't really tested this
case but my guess is the two cache pools we have will likely be filled
up close to full anyway and hit delta_base_cache_limit and
max_delta_cache_size limits. When these are really full on default
configuration, they'll take roughly ~300mb.

The second is, I think we still go through all objects to mark which
one is included in the new pack, which one not (and probably which one
can be delta base candidates). Try calling alloc_report() function at
the end of repack to see exactly how much memory is locked in there.
This we could perhaps improve for incremental repack by avoiding
running rev-list.
--=20
Duy
