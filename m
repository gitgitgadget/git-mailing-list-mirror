Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A73220986
	for <e@80x24.org>; Sun,  9 Oct 2016 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbcJILkT (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 07:40:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33791 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbcJILkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 07:40:19 -0400
Received: by mail-lf0-f66.google.com with SMTP id l131so5162789lfl.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tjVpinBSar3RxMJ2Cv/P/IdgusGeNb1xlPB8IoWEjOo=;
        b=uOpVokh5zLRFJT+vpQYGjD2EYvw6iJkXfNvyW4Z5J3ShNoOElj+tnQjN8mnih00SQY
         eniFxkfqzBn2v0CtJKTYkzAz7qP5vwdypN35qDIKEJpTIddkuBdeVr90KKs9zG40b41L
         utAysI5HfLgte0YT40eId5HZn1T4V2RO22LFn1Iv7pXoizsFTUHDWmmYewI3a8qSYTzi
         wVPZpHKb7b4O2JiBQPiiEK3qw/0YtN4dsLc0l6eJxBEIZ4ZowUuI5UTXOO4UoyWB93TP
         wX2MYhRJPGnXpUtSIqrMdXqDi71u1rnqxFJpTWddXMymr8aDAcqh624Xu4f2jUKkx4mW
         +cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tjVpinBSar3RxMJ2Cv/P/IdgusGeNb1xlPB8IoWEjOo=;
        b=PB57Jx5jxlSiKyBuUQpPtupW24+I+JnQPqowM3MKR/cp4CtiuXi7lgHU7MF0W7HM6V
         0EkGDCZvJDw5TraQZpr5O433v4LcBnk/70iAnv59PFsN1EIPlB27nhkhLumYe5F5G97W
         DUDuCTLdp/0HxY+KsPVCi73brfLP6kLIMeTqNvKJWXn8n8ynRbFKl9wstV8oykW9y0+W
         kIUyuNV+3SY08DVxXuhQu/rumUuC0YXGZbvUOxYP1MJs7ZNOS6AaobjZHxiGZnvv6V/Y
         453a62fRPvvnBC5xvvXyUpzG0uzBlRqlay0lS4xqYX3hwSExJ4Y19sY796yyKhv6B5fs
         ihLg==
X-Gm-Message-State: AA6/9Rl2MmH+VRrSqob2ixhqI0Mx4s4nRJ6fKaAS0JeokuUHJZbfFQSxtodefL5lB7/GzTxtiHKBbHZKXOpE5A==
X-Received: by 10.25.206.138 with SMTP id e132mr11308135lfg.39.1476013217208;
 Sun, 09 Oct 2016 04:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.165.11 with HTTP; Sun, 9 Oct 2016 04:39:36 -0700 (PDT)
In-Reply-To: <CACsJy8DGvyWz2_VBsEfmDWOPGUGAUhKYhCa1qLEMcOdn83ocSQ@mail.gmail.com>
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
 <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com>
 <CADKxhpd-gDczp05Ny6wP57RXafWWCimArfA9ki2phh+-gHez4A@mail.gmail.com> <CACsJy8DGvyWz2_VBsEfmDWOPGUGAUhKYhCa1qLEMcOdn83ocSQ@mail.gmail.com>
From:   =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>
Date:   Sun, 9 Oct 2016 13:39:36 +0200
X-Google-Sender-Auth: --LAyfjGexyZIz9XUGxRrNJTr28
Message-ID: <CADKxhpft56eu1_m70PGi3FPTeX7bS0L=WSe9yKZfLc94N7LsUA@mail.gmail.com>
Subject: Re: Feature request: use relative path in worktree config files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-10-09 13:37 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:
> On Sun, Oct 9, 2016 at 6:22 PM, St=C3=A9phane Klein
> <contact@stephane-klein.info> wrote:
>> 2016-10-09 13:11 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:
>>>> Why:
>>>>
>>>> 1. I configure worktree on my host
>>>> 2. next I use this git working copy in Docker with volume share
>>>> 3. next I've some git error in Docker because config files use absolut=
e path
>>>
>>> I think the common way of dealing with this in docker is put things in
>>> the same path where it actually is outside docker. If you have stuff
>>> at /path/to/foo, then you create the same /path/to/foo inside docker
>>> and bind the data to that path. Does that work?
>>
>> It's not always possible. I can't in my project.
>>
>> I think there are some pros and some cons for relative path and absolute=
 path.
>> Maybe append a "--relative" option with `git worktree add` ?
>>
>> I've converted all path to relative and all work with success.
>>
>> What do you think to append this --relative option.
>
> Patches are welcome.

Thanks :)
