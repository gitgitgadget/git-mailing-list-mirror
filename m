Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B672022A
	for <e@80x24.org>; Wed, 26 Oct 2016 13:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966337AbcJZNXv (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 09:23:51 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37298 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965925AbcJZNXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 09:23:48 -0400
Received: by mail-it0-f53.google.com with SMTP id u205so32077112itc.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=if59+DXeVwJ4+A2jLe0WAbeinocWqq1u7mnh2HE8kGQ=;
        b=uAJGuNbPgJoRxgp3NgzkK7rZ0urcXiGDCwj7e5m4djwYmeNw0894fFxlc9h413jxZ1
         mku1S/isHoZqZUxpK4/8Wp5oIBIT5Yicstge2XmmPEp0OJCvLD5CJQSysybmVpPXflP1
         ROy3F/xYx0br3Z9JBz5v4mYrhvcA8Y+r4kKKpkdn9n1L9ZTZLvJpFpNQkLbY+Bid710a
         Ss9H2V69xM1+xo0zyz8WXeB9Y2frnLTejDNElosf/xBodMxFwFSlRfYlWodJYu1gUDzv
         ER/DLiM8RCjHGlrfuhOqXMMBPbDO8BjEsTfRaZnDGdnDrqJ2i2/7Q6tcgU0NhX7JYXe0
         QNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=if59+DXeVwJ4+A2jLe0WAbeinocWqq1u7mnh2HE8kGQ=;
        b=GOKnv1lnngc+pK41oRXnxuSx+tlOwfHEYByDdW0N7KOLJ+u+BhPW/xmx4dJ35IcZEK
         Rzmz4kc/jlnWp0oAsvlxLNDwMVV5YqY9P8I5Fuiptimws1qJ+1ijhUBqK6Glb/3xbpS2
         DrqMweFvm3QvDvfNaQ9nWwkExzSxmzADkUEDzj9Q5aq2iMXTLJPwg4p8B5rfZSc7pBU+
         qYukfSGAcClFxsG6LHhxxJ6+gkV/JQ43GRwhE7jHCxKYtJQe5btdmXVsC7tjqb7/YPVs
         +bJTf28+kYPnoJutXrJtyZs/swM9/s7wJhc4hOZS5Ei0Ohb6npk2qHS8b+5bkjavsgFe
         840A==
X-Gm-Message-State: ABUngveiMhP5AUQ487r9+6gMZexTDrKTTDHlsFFTeix2PrStTQi6ay/WFGCtpdbyivhaKtpwUQom0smK5GmGAA==
X-Received: by 10.36.26.78 with SMTP id 75mr6303163iti.74.1477488227688; Wed,
 26 Oct 2016 06:23:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 06:23:16 -0700 (PDT)
In-Reply-To: <20161011150118.7eb474yg5c3oe5mn@sigill.intra.peff.net>
References: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org> <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox> <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
 <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
 <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net> <alpine.DEB.2.20.1610111142490.35196@virtualbox>
 <20161011150118.7eb474yg5c3oe5mn@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 20:23:16 +0700
Message-ID: <CACsJy8DUqrsaqmrCHzzuS3Q7DXRAPkisOJbSmYPX8-AhmNUz6w@mail.gmail.com>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 10:01 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 11, 2016 at 11:44:50AM +0200, Johannes Schindelin wrote:
>
>> > Yeah, that's reasonable, too. So:
>> >
>> >   [alias]
>> >     d2u = "!dos2unix"
>> >
>> > acts exactly as if:
>> >
>> >   [alias "d2u"]
>> >     command = dos2unix
>> >     type = shell
>> >
>> > was specified at that point, which is easy to understand.
>>
>> It is easy to understand, and even easier to get wrong or out of sync. I
>> really liked the ease of *one* `git config` call to add new aliases. Not
>> sure that I like the need for more such calls just to add *one* alias (one
>> config call for "shell", one for "don't cd up", etc).
>
> Could we simply support alias.d2u indefinitely, and you could use
> whichever format you felt like (the shorter, more limited one if you
> wanted, or the more verbose but flexible one)?

Before this thread goes completely dead... Since there's a lot more
work involved with the new alias.<name>.<property> approach (short
term would be git completion support, longer term would be the ability
to manipulate a config group more conveniently), I'm going with the
"(properties)!command" approach. But even then a new series is not
going to pop up, like, in the next two months.

I don't object the alias.<name>.<property> approach though. It's
definitely a cleaner one in my opinion. It just needs people who can
spend time to follow up until the end. But if someone decides to do
that now, I'll drop the "(properties)!command" and try to support
him/her.
-- 
Duy
