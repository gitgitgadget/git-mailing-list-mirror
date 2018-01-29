Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7939B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 18:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeA2SrP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 13:47:15 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35516 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2SrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 13:47:14 -0500
Received: by mail-wm0-f48.google.com with SMTP id r78so35742671wme.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:cc:content-transfer-encoding;
        bh=fhfeO2d+jB5P+zshKGOnYLcQOWDOMaJFjKTfn8glxyQ=;
        b=eZTcers7hwdfXc5QUI/HpGVU9q77Y5lPa/OcHWemxAvF2BqTKxNspRK8ttCTKfSh5P
         9iR1QKfAXd3pGAUBsjmBlHgJJ6L5e3fpwDQSPCmm6mk6D8Xh3ruxpw2naEBRO9mdXw7P
         4YEetz/VIeDTxSEYf1VlFrAv/UU0/+0TNOiw+ug7/pIe+xV5n2BuI2Z3atdaj5ucUhCb
         Tw1CGD5OqSp42VdKkCdYOOeYD8RlINmpEKyMYIL+i/oivFYYNcS6I6DE87i45qa9N/jx
         1EcWa5DwvQ0upv4Aes29etUO7mM4Rd0Ip55/s0/7/UzoiMQdxc9MGY99ZHTGIZRUKWHb
         2eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:cc:content-transfer-encoding;
        bh=fhfeO2d+jB5P+zshKGOnYLcQOWDOMaJFjKTfn8glxyQ=;
        b=W49fmv8jxTTL2YBJ0kByQfZA4ns69FGPVDL1RBjlG3qiswYRGcwCBPRPhcpafKcG+f
         KiDlXncj8EccNZUckYTYcgk4ZRogBEaDXj3N12gzboaCVK6Z9hsIqmNEKiu5IkIHrCv2
         pY8XAlvt0YRvoFNPiiyX/5rUqCUEjbfb4F6bz1ewpgK8RxKo6EKY8jhxgkJvt9cKS3hl
         4ugyuGOzpHc6INs6Nwz5CNpeVMbXAm0KUwZWk2ck3i7c6gciq8neEMk2xlOVqdlWZvgn
         TpUUBWyQmRv9k231WgfxXInxSnXDLvVbVzNdCoSSRSV0gsZfQdqcLJ//YRFyYRCT6+ST
         DEbw==
X-Gm-Message-State: AKwxytcLPU/YjhW5QIIFnwymugbOY2iE4axkdw1XTh9tKF1BIVCF3TzF
        1nfQriEVCyVnf0VOVOSAoiH1PYjmCV/FfO3AXPa6Hnlg
X-Google-Smtp-Source: AH8x224Nw6B+UGRuMfY1o34MNReik60uQauYdpHokbSNkqjrOCJzq/C5OA10QjNmMB6XFV6vMNnR2Fx1mDo7y5vIt1I=
X-Received: by 10.28.0.207 with SMTP id 198mr18641400wma.115.1517251633335;
 Mon, 29 Jan 2018 10:47:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.195.61 with HTTP; Mon, 29 Jan 2018 10:46:42 -0800 (PST)
In-Reply-To: <CABYAQkRPF1XB1LgMQXA1C9qD8buBedhKPWYRQ3v-WEzgF=sALw@mail.gmail.com>
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87bmhcsnhv.fsf@evledraar.booking.com> <20180129172452.GB4185@sigill.intra.peff.net>
 <CABYAQkRPF1XB1LgMQXA1C9qD8buBedhKPWYRQ3v-WEzgF=sALw@mail.gmail.com>
From:   Scott Gasch <scott@gasch.org>
Date:   Mon, 29 Jan 2018 10:46:42 -0800
X-Google-Sender-Auth: WytZy5BdFqtLSKsrK9_d8FZDqBE
Message-ID: <CABYAQkQektHS0haxoOezFVr8KnCuAu=3CnWP2pB78528EOYfFw@mail.gmail.com>
Subject: Re: Shawn Pearce has died
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I guess your email server doesn't like HTML messages... here's the plain te=
xt:

Chris, also on this email thread, is working on putting together some
kind of video of Shawn's colleagues at Google talking about working
with him.  Part of the thought is that his boys are going to want to
know what there dad was like at some point later in their lives and it
would be nice to capture the thoughts of the people who knew Shawn.

Chris: if people outside of Google wanted to include videos about what
it was like knowing and working with Shawn, how could we do it?  Is
there guidance (length?  format?)?  Deliver as an attachment over
email to you?

Thx,
Scott

On Mon, Jan 29, 2018 at 10:39 AM, Scott Gasch <scott@gasch.org> wrote:
> Chris, also on this email thread, is working on putting together some kin=
d
> of video of Shawn's colleagues at Google talking about working with him.
> Part of the thought is that his boys are going to want to know what there
> dad was like at some point later in their lives and it would be nice to
> capture the thoughts of the people who knew Shawn.
>
> Chris: if people outside of Google wanted to include videos about what it
> was like knowing and working with Shawn, how could we do it?  Is there
> guidance (length?  format?)?  Deliver as an attachment over email to you?
>
> Thx,
> Scott
>
>
>
>
> On Mon, Jan 29, 2018 at 9:24 AM, Jeff King <peff@peff.net> wrote:
>>
>> On Mon, Jan 29, 2018 at 04:17:32PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> > They don't want any flowers sent over to them, but I wonder if we
>> > couldn't make some sort of tribute to Shawn at the upcoming developer
>> > meeting in Barcelona (and find some way to have remote people contribu=
te
>> > to it).
>> >
>> > E.g. a short video/audio of different people in the dev community
>> > sharing some story about Shawn, or a written list of memories
>> > contributed by and signed by various people.
>> >
>> > I don't know what that would look like exactly, but I think it would b=
e
>> > a good thing for his family and especially for his children when they'=
re
>> > grown to remember him by, to know that their father contributed to the=
se
>> > software projects with people all over the world, and that all these
>> > people appreciated his work and him personally.
>>
>> I like this direction (though like you, I'm not sure exactly what it
>> should look like). I'm not sure what kind of video presence GitHub will
>> have at the contrib summit, but I'll see about getting some interview
>> footage there.
>>
>> Doing something written, though, may make it easier for remote people to
>> collaborate.
>>
>> -Peff
>
>
