Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BA21FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbcGSTFi (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:05:38 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34868 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcGSTFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:05:35 -0400
Received: by mail-io0-f195.google.com with SMTP id q83so2024537iod.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 12:04:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZZxAnAH7vuBmE9aYSgL4t0R02QFouWl8vAnvEoeGE48=;
        b=fpsHinbNN+fNegw5a+e3OR96kbhg7w3Ym45ypckDtJDei38rym5YWBHNaPFnxP3EkT
         gBnbztV45bcya0m6giiC0ppvK0u2XXdArqoPAmNthjGuuy2N2YV8d+nJoh+OblMVxMr2
         fJbRiT081olPcmXzb6z6+FIpGNwOBRmo90dqiNrpXowwfyxPc0fK8LjHQ5/yYWjZbjVr
         Eax2OwssVum/NApMGxcCSsqgSnj1gG+AAjSsuwD2jyeCmMP3fJNlyn+MUX3P83k5ROAR
         1pvjnMGU9UFBTu0TECO6yl4aqA9Jqea//TSnH+p1ev5M+pr+Y8Y+LrEEwHzIcsgJxMlX
         epGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZZxAnAH7vuBmE9aYSgL4t0R02QFouWl8vAnvEoeGE48=;
        b=Ign5fM8oxsLEkKgk2PbA6TsHyxfN/+zRonGfGA7WpWJdbBuVA+F4RP9Q2KaXMjVrXt
         OtOtCneUTkBsJvgmydiJHYIE+aPB5pQsjfsY4agbyYpPKMD2gH3utUTLpbTT1fBPoOcG
         V/+9EOhLINIOOIHbAlIgSilRz7j//MS9Rjqh8LAawBrxix3D9ksSwEajM2zQfhG92aAj
         a+atMpWbN6zAI6ETpO7iLS8ItFXbwOGx52yofDhz+ePe0ovwfDDrUPDk5qudbtyX40S7
         RMyDFYKsTj04tTVCVesf+Kj7XHF6NKO+ZX1ENvF9iXWRyL9pQNUDCcOEijJ1HSeONwi6
         h0ww==
X-Gm-Message-State: ALyK8tKrit1pDjdCyNShk/8rFchY21GpPHHHofadIqAHoPywjLEVW/5Q45gIUCC8PaS/wRYVkE0qgknyUU/WiQ==
X-Received: by 10.107.2.78 with SMTP id 75mr3945045ioc.128.1468955080732; Tue,
 19 Jul 2016 12:04:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 12:04:11 -0700 (PDT)
In-Reply-To: <20160719185452.GB28551@kwain>
References: <20160719144701.571-1-antoine.tenart@ack.tf> <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com> <20160719185452.GB28551@kwain>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 21:04:11 +0200
Message-ID: <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
To:	Antoine Tenart <antoine.tenart@ack.tf>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 8:54 PM, Antoine Tenart <antoine.tenart@ack.tf> wrote:
> On Tue, Jul 19, 2016 at 08:23:58PM +0200, Duy Nguyen wrote:
>> On Tue, Jul 19, 2016 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> 080739b (worktree.c: find_worktree() search by path suffix -
>> 2016-06-13) from 'next' should help identify worktrees in this case by
>> specifying 'project0/foo', 'project1/foo'... Granted it's not fun to
>> type all that when 'project0/foo' is something long, and bash
>> completion probably does not help much either.
>
> So with this I'll be able to create new worktrees, using paths having
> the same basename, but in different let's say "project directories"?

Well, internal name is still out of your control, but if you want to
do something to a worktree you can say "do project0/foo". With 'next'
those verbs can be lock and unlock. We probably can make 'worktree
list' take filter and show just one worktree (and just add "git
worktree show" for that).

>> Note that we may need a unique name elsewhere too, e.g.
>> refs/worktrees/xyz (even though we haven't settled on this yet). Then
>> xyz would be more exposed to the user and an easily recognizable name
>> would be a good thing.
>
> Having a recognisable name surely is a good thing, when performing some
> (rare) manual operations.

What I had in mind was "git log --decorate=more-than-full", foo/HEAD
and foo1/HEAD
do not look as good as project0/HEAD and project1/HEAD (*)

> Like moving a worktree (or is there a command for this?)

Don't touch it. I've been waiting patiently for that patch series to
be reviewed :)
-- 
Duy
