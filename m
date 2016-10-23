Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E657420986
	for <e@80x24.org>; Sun, 23 Oct 2016 01:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964856AbcJWBHi (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 21:07:38 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:33811 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936482AbcJWBHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 21:07:37 -0400
Received: by mail-yb0-f181.google.com with SMTP id f97so50387642ybi.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pTsH500YE+Y2TObfT67sVkF9zOWdHTSSJoFUEAYz+FM=;
        b=ooJ1fU9jLaUBUeZu30sRUFo7Qsk9eMZ4zDfoOoNF6NaiqiGtlOEQImIHPFrBAR0/w8
         N9/RcwyetRYoBB7MQQBEw5ew+qo+TYlmF8wuv2ARN9YDpepvlD3UojHtJJbHDKiUs7pH
         Si+iwzDw5/kjeEVDchf6NeHJI70/XNs8tVpDWHWSZEFqY7GUE+YvbidCoRH/wr679gLH
         X3Ah2sdDbvzCEfHbk46wNKXolFoKYBHhNQgueNY+kUM3o67F2sEeAioXiGyQdToe8fJv
         Wn18Xlz86k+0tMf45IhJwaERq0W6Ij8z8UbEJEXxkRt7xjCaKzepHg+l+x/KAzM9EyAe
         kV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pTsH500YE+Y2TObfT67sVkF9zOWdHTSSJoFUEAYz+FM=;
        b=JpBs7XLeLnc2AkziCn/zkNs8z4pkly2/Pb5TqaTxwjLyYArvdoEd3qouddfFlZ/EKO
         A8dr9aPzo6dYTXT3gbauovGvE5waX5LAIJmytUo/q0DpGrpgzkA7SMngrH67C8AD8WOr
         8BcXNgtksDU+yyKBeGzvxtqRKrVxQbf0CpPFmx9wOplHZyqNDqDZOfbS707iAceyeRoD
         qKeOLh8L4bOT6wpdmcGvX3qdPQT4x0zubshtgSCk70k4f2bx8ccTeBh4ZalZQv3dlkj0
         LSEHh/EiXCvXouKHiapGs5zx6+6y1BmZbCL4cblpJdpmEjWi0Mms+skaa1CLCA5ceIrb
         KXjw==
X-Gm-Message-State: ABUngvcQlCK8zpg6QPmaeoRWqM4ONVCbK9KNjR14GwmgzgOjUu1T3lYecXIa5ywgcwE9UyyU502ZAZ1+y7wEOw==
X-Received: by 10.37.119.85 with SMTP id s82mr9002609ybc.6.1477184856930; Sat,
 22 Oct 2016 18:07:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Sat, 22 Oct 2016 18:07:16 -0700 (PDT)
In-Reply-To: <147712794056.12237.1478296296628149440@typhoon.fritz.box>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com> <147712794056.12237.1478296296628149440@typhoon.fritz.box>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 22 Oct 2016 18:07:16 -0700
Message-ID: <CA+P7+xo4AvYMPdHP+JjmSaKRWucywd3t4ckby+0Az=cAo7JrsQ@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Lukas Fleischer <lfleischer@lfos.de>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2016 at 2:19 AM, Lukas Fleischer <lfleischer@lfos.de> wrote:
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
>
> Regards,
> Lukas

This is (essentially) what I am asking for above. It's the same
overall problem of "muscle memory bites me" and I want the tool to
change to help avoiding because I don't think I can win the fight
against muscle memory every time. Being configurable would ensure that
only those that want the behavior opt in.

Thanks,
Jake
