Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6871F404
	for <e@80x24.org>; Wed, 31 Jan 2018 01:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeAaBG2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 20:06:28 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:38164 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeAaBG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 20:06:27 -0500
Received: by mail-oi0-f43.google.com with SMTP id j15so6147458oii.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 17:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fi+yoaQaAc9Oq8Y21lBENnsOn4UR2fzr30Hshq++0cc=;
        b=HY0KHaN/KH24k1Ex1ZD6H75R/lrcP7CBK2DVP0lX44LD+7ofbHiR7K0SY5p/k01HH/
         uYjK15M6CYhTScBn/0lKy38Eq1qjgiMDqVUwtXzjxzfdytWspyYideIzrlK2ATdIVbcm
         CaTu+SiLxKeoTahKGjtO1lNhVcT+6nGN6Ue0IHK7WIrBFc4z80frrC4RmH+grOVXBIbh
         OPP+OSEt3L1PBJUhJ3Cf7EZBEBLZXX+Esu3GKHy0Dr5M3536d/C8aQNvwSpmbUjpLurw
         occ7Y40eg0gKOhHuiM1ciOcDyr3z+U9IJWk3yUgzsD6+rEZK1pST7tG+KOZjxa5YM8Oc
         2/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fi+yoaQaAc9Oq8Y21lBENnsOn4UR2fzr30Hshq++0cc=;
        b=sb/vVt58eFBP2+syTKrM8twApv1h+NAr2tCI+maRLo2l4lh6/q4R7gj/IgBtV/mhYP
         4YsTggsxgxP2wiLnhGbXIYTBz4xV+gqVlLgW2iRN0HlO85CwqF+mHGSGlluXZgbldxC6
         JKzfXbiVTtspDHwCTwfpu9cPabnuVvH5kcB1OgEW9uYUOdg3vun/euPKBUfVPFhtWDrx
         2oFlt2MehsgGbl3gPS/DwTLc2D+7sLLkshCeyn0YMV/NqfuEJyibq+DlEdcphQ/Qb+Ko
         P8qg7KNatjDifU254lZUvtTUJIwsazQQz21z+kn1o035wKrdUYfZI7P0jcKDx3IIHyWu
         wJIw==
X-Gm-Message-State: AKwxytdH+cefRujc1mC6Pz6n52g+H3/9C5xKSAEPQ8kuGeB2yGtT2XgT
        mNFWvUrygn5hJJku1o84GqNP/LQwDTgUYh9agis=
X-Google-Smtp-Source: AH8x225ujefGiga4+7Yw0Xnj+Du7Xc0d48iibYXoWmceD43TZ8B4E6cvCsYmo2Fp9cKWsNUd8f1UIhUzpZSSN78v+6E=
X-Received: by 10.202.177.136 with SMTP id a130mr19382554oif.252.1517360786863;
 Tue, 30 Jan 2018 17:06:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 30 Jan 2018 17:05:56 -0800 (PST)
In-Reply-To: <CAGZ79kZNB=3fXOeJwhXGqyBi3mKmE-9nmM-ooXJOzy5OcYaoqQ@mail.gmail.com>
References: <20180129223728.30569-1-bmwill@google.com> <CACsJy8Cm8HsopKisiJkwtPyfv-O6Ei3waew6CsKLXzKv7=TriQ@mail.gmail.com>
 <xmqq7erzrn3f.fsf@gitster-ct.c.googlers.com> <CAGZ79kZ-hZzKtv05d5_7O2ndNZvGkU7qYnrn52zwpqSTqCiygQ@mail.gmail.com>
 <CACsJy8C98HD59DGgqyWtZzj2RVqFe9GN=810A6fs2mMYBh_53Q@mail.gmail.com> <CAGZ79kZNB=3fXOeJwhXGqyBi3mKmE-9nmM-ooXJOzy5OcYaoqQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 31 Jan 2018 08:05:56 +0700
Message-ID: <CACsJy8A=wLAY_Jmw-DRd_R0i-SW0qB-d9m13GohfTk16DY2ejg@mail.gmail.com>
Subject: Re: [PATCH 00/37] removal of some c++ keywords
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 7:57 AM, Stefan Beller <sbeller@google.com> wrote:
>> There's also C99 designator in builtin/clean.c (I thought we avoided
>> C99, I can start using this specific feature more now :D)
>
> That was a test balloon? See 512f41cfac
> (clean.c: use designated initializer, 2017-07-14)

Aww.. I thought it was in there since forever and it should be safe to
use now...

> One of the big advantages would be stricter type checking, such as
> signed/unsigned confusion, that we occasionally have.
> e.g. 61d36330b4 (prefer "!=" when checking read_in_full()
> result, 2017-09-27) or what is referenced from there 561598cfcf
> (read_pack_header: handle signed/unsigned comparison in read result,
> 2017-09-13).

We can do that even with C (at least with gcc and I guess clang as
well). The problem is it looks so bad right now that I have to turn it
off with -Wno-sign-compare

> The bugs resulting in these patches could have been caught more easily
> with C++ checking IMHO.
-- 
Duy
