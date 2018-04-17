Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754071F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeDQRl2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:41:28 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35119 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeDQRl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:41:27 -0400
Received: by mail-wr0-f175.google.com with SMTP id w3so21176167wrg.2
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6kCvxCiHpmjWNYSkvDYtAOAKH+4Lo1SlMhamgwToGU4=;
        b=hC3d6PA9XZ7+roOCLxh/zTNcvfGQKoTpQyZwIe9Arnnh9XLwof1cIGkaooFxX8lxjc
         zNRnGC9H7sSShpcuiIUh+7LRW1d+Dx2pm/cufYp4/fz++/L6Q5Wtg6zXxEoRydEmbtb4
         zWzBWS9vXB0GwGDoCQHX6ylgn/GOaY2mz1kpHZsN+MyANA5AXdeS+xCTArAtAxhg2r1Y
         nPDmE0U9GSm/mG03A4s4keTAylC2QIx/Yhm9fbjDpSUx2wMVboCFVnyfUJzqHDflne1T
         HOZnqAO2vDnRxRz2Vc7v8MQ4ilsd1OYxhk9KzvLT3CLhQsMwowUP35/dNjsuGj4hdbp9
         Tn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6kCvxCiHpmjWNYSkvDYtAOAKH+4Lo1SlMhamgwToGU4=;
        b=CSaONx6NBnU3OjgEpGN9EeH1K+PDlMmdYRc2r8YfrZO0E1fwTaRtLj+i5UFT/7Z+bo
         OSBuXTkbol+fqmcRz539dUv0aLXsUlkKZxOwgVn3Izk8OHYEfD/m+trJ2IVmOWQETEgI
         oKKjOUbhBNTtcoMZq4jAZIjgEMHwRDmWruh/9mUWQOur+lhSJx11+XxmbTdtUF5p/ko6
         RThOYuY52NqY/sYlyru83ebd1AN7mWQXJkLF6UW67q8w2gmfCEvCBp4cemxwiM+XlOXx
         qZaJpD9F1WPhPxAFVbJTmpDeXbWj+TF4POhKtLCaWzMf0kHBiK/wEcs1tHWbL1Sq32QM
         uSGQ==
X-Gm-Message-State: ALQs6tCCepB5V7NP/pOOSfIvLUEUb4/7mqPMsme8dYTTdJPghGUjlVvQ
        sPcLl81bDy7fQFC4ouVEeHiPE+rKW9XxtBAqP+Q=
X-Google-Smtp-Source: AIpwx4+6P6IVsAoz3t0XX36NlJCMlFnuv5zban+YG5p7IJzkXZTWKTzNcCHGXbKUz3ZNHnNM6x2jf5D6GYMSf2Drxl0=
X-Received: by 10.80.241.93 with SMTP id z29mr4315424edl.62.1523986885873;
 Tue, 17 Apr 2018 10:41:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Tue, 17 Apr 2018 10:41:05 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
 <87y3hn5drx.fsf@linux-m68k.org> <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
 <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
 <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 17 Apr 2018 10:41:05 -0700
Message-ID: <CA+P7+xrebnWe_6P0uGu2yEmXZ0+qjpykjrv39Nhd2hUPzO_96g@mail.gmail.com>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 8:34 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Tue, 17 Apr 2018, Junio C Hamano wrote:
>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>> > Things won't work so well if you set the push url and fetch url to
>> > different repositories. Git assumes that refs updated by "push"
>> > will also be reflected via "fetch".
>> >
>> > I don't know offhand what will break, but likely something will.
>> > For one, when you fetch again it will rewind your remotes after
>> > the push.
>>
>> Exactly.  I still haven't fully embraced it myself, but for a long
>> time, "git push" pretends as if it fetched from that remote and
>> updates the corresponding remote tracking branches (if you have
>> any), so you'll be inviting inconsistent behaviour if you set your
>> fetch and push URLs pointing at two logically separate places.
>
>   ... snip ...
>
>   oh, i totally buy all that now, i'm just suggesting that the man
> page might be tweaked to make that more obvious. in "man git-remote",
> under "set-url", remember that it reads:
>
> "Note that the push URL and the fetch URL, even though they can be set
> differently, must still refer to the same place."
>
>   i think it would be useful to be more specific about what "can be
> set differently" means, since a lot of readers might not immediately
> appreciate that it means just, say, the transport protocols. it never
> hurts to add that little bit of detail.
>
> rday
>
>

Maybe something like:

"Note that the push URL and the fetch URL, even though they can be set
differently, are expected to refer to the same repository. For
example, the fetch URL might use an unauthenticated transport, while
the push URL generally requires authentication" Then follow this bit
with the mention of multiple remotes.

(I think "repository" conveys the meaning better than "place".
Technically, the URLs can be completely different as long as they end
up contacting the same real server repository.)

Thanks,
Jake
