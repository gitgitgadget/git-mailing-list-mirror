Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879EA20986
	for <e@80x24.org>; Sun, 23 Oct 2016 01:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756178AbcJWBXe (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 21:23:34 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35665 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756170AbcJWBXd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 21:23:33 -0400
Received: by mail-it0-f46.google.com with SMTP id 198so56407314itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nDzUPb1Gsw6Vyarm4O0QcyqAtYAHvSiSUG9HwZWZwV4=;
        b=Rh5zTf8hx3g1eHi2+T+NBYfePbU84rWIFtqek/+x8FDOrOawxP4o98DsRg9SBfCBYP
         +X8ThAx7IZb5gWyIO2QUfYp4apoz9SDzrIyG7MCijxnlaLY2pl9wf8DUNSSxjp98lKAJ
         0M7EbT7VN8re/t0myseOxEnuB2tyDY7dBjDt6CZhgg0fQSqDQ1Ku0B487Eds88fS42Vv
         Uyr1rem4LL9n5G7mpSFSi2Pxbmn9adJ7d7CcaTXzSe4GeLKM0v7AedqzQJRc+ON7SMc6
         gecdexaQ1eZCalr0xZpJuOHZbvjPg0yEnLaSvOn/TJgWfnPUlPxdpxLIwEQCm3tLn/LE
         1yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nDzUPb1Gsw6Vyarm4O0QcyqAtYAHvSiSUG9HwZWZwV4=;
        b=Wmm3p6VnPluYwIOoK2dQfbIr0AcQB9qzk56bVNDuZbxWix1B8cd/MXXOJFLJ8IbEYo
         nK/OtKmfuzEO5KwBS8Z3hZ0REJQBzREUvTiLkn9zBkMbBwio+Jz/cc1S/bQYEvZGtIae
         Eb2t0zya8njdAaJZ/T2CmVGfx7TAHWDxjatlZ6KMW6rbxPhJUozwek7ZDJ9DUActRsz5
         OYngzfzYr2TAlrvG7P4CGjr/NgpdsFoZSlotKjtzaYsec4myOm9o7EFZJTxRd/UJvY2M
         9dPrY2QkiHlH8jq41ryL4le4w7FASzvRVW7rgfNXVA/ZEjK+wn/dipvHGA632IDH9ZHT
         jZiw==
X-Gm-Message-State: ABUngvdR3zYEoEk+UeKqxTBq1MT0ZPm9XAkkxLgAMC+whBdAkXRfb5s6aoj3bOGu6ny7IKJ0ZUsi9ityaN2o+w==
X-Received: by 10.36.216.4 with SMTP id b4mr5335811itg.74.1477185812436; Sat,
 22 Oct 2016 18:23:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Sat, 22 Oct 2016 18:23:01 -0700 (PDT)
In-Reply-To: <147712794056.12237.1478296296628149440@typhoon.fritz.box>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com> <147712794056.12237.1478296296628149440@typhoon.fritz.box>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Oct 2016 08:23:01 +0700
Message-ID: <CACsJy8Bz-DhE+CkJH+3zsrZJUQfGYDN072MKawJ6dx5begfnMw@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Lukas Fleischer <lfleischer@lfos.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2016 at 4:19 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> On Thu, 20 Oct 2016 at 19:27:58, Jacob Keller wrote:
>> [...]
>> I still think we're misunderstanding. I want git commit to complain
>> *only* under the following circumstance:
>>
>> I run "git add -p" and put a partial change into the index in <file>.
>> There are still other parts which were not added to the index yet.
>> Thus, the index version of the file and the actual file differ.
>>
>> Then, I (accidentally) run "git commit <file>"
>> [...]
>
> This reminded me of something that bothered me for a while. It's not
> 100% on-topic but still quite related so I thought I'd bring it up.
>
> When working on a feature, I usually try to make atomic changes from the
> beginning and use `git commit -a` to commit them one after another. This
> works fine most of the time. Sometimes I notice only after making some
> changes that it might be better to split the working tree changes into
> several commits.
>
> In that case, I git-add the relevant hunks and then, unfortunately, I
> often run `git commit -a` instead of `git commit` (muscle memory bites
> me), so I need to do all the splitting work again.
>
> It's not much of an issue but would it be worthwhile to add an optional
> feature (configurable) that warns you when using --all with staged
> changes (which are not new files)? Are there others having the same
> issue? Do you think this should be implemented as part of an alias
> instead?

I hit the same problem sometimes, but in my case sometimes I
accidentally do "git add" after "git add -p" and a configuration in
"git commit -a" won't help me. I'd prefer we could undo changes in
index instead. Something like reflog but for index.
-- 
Duy
