Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024761F51C
	for <e@80x24.org>; Mon, 21 May 2018 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEUWW4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 18:22:56 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:40430 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753201AbeEUWWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 18:22:51 -0400
Received: by mail-ua0-f178.google.com with SMTP id g9-v6so10987235uak.7
        for <git@vger.kernel.org>; Mon, 21 May 2018 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Srfx0+t9u/rIysxILDKsOl4E347jsjZIH8ncNoF4ys=;
        b=LKgStrlw7sAAqlleLycMcsil3sJ7E+Z6qx6a0rbLheDaT2EYmsK4aFyIDwW5EP5k2u
         hQ/eqfvrIR+beYYkvoa+UwunwGvXR0bGEVW9hxpPr5rxcvc6hea0S2JxLhT3Y5AFHAiP
         IjEzUbxAilS6wZ22jFViQdab7/UUXpv3k9OsSZKmFIJFV4bBkeHqsTPT49FZSttx2k2z
         Hx68l646UAZyEF3BtDK0IHvdGYf3TqKMKdIlhc/YQ7E7paJ9nq+r76qEUR8SQqcOcch9
         ESbidIsWyN8tLSw85BtxwMqdvXXCRMZLNyf7saQbje08DyuPhntQfhCIr5pAjUjUb1RR
         cE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Srfx0+t9u/rIysxILDKsOl4E347jsjZIH8ncNoF4ys=;
        b=hGhYlo+78JgkJCp8XU7+oZV6kPRDNf47abnwoe409WH4r1EnZuEFHWIUVh/n5EEsRe
         7Da6HcsKJ3/egHn5flJV5zxiz+4DiI2Ur9ZftHDWrj3zp5AYkc7Vy95g+fxqGoU/+XOq
         wEjfl2buWyPmPcpSFil/T/SLhYBqZdmu5PVz0oGDBXX0c6NysJLWyA/9GbfOap9S5n7N
         XiWlAItyfAO2z1d3YucWqRotH2nOLv7b4xBW0sRKFKDeLPQZSUuf3Szc+X7yHV9+qEdr
         ei4BvTtTqCAiqfp6enG9tFGzJZyLKw6lhJhlv8wnrtrqSXmq2ui4RM5A9mYxEyXaM53u
         G4+w==
X-Gm-Message-State: ALKqPwenhqr2lMp2Faw0h8LzZEX5aOJQxTmjLa9S5OLafle4GH3WRWLk
        +mgzVZzBUS+A0a5QyKvE9QCcQuEneuXrO3nZ1P0=
X-Google-Smtp-Source: AB8JxZrNYE6szWL9M2L5jO9LW3fc6vxrfsXSQVW/V4QFvM0fDWfjXUpL1r7c4YewOkhzXWcfhLzsgLfk8Bohkqfnolw=
X-Received: by 2002:a9f:2d98:: with SMTP id v24-v6mr15915793uaj.5.1526941370404;
 Mon, 21 May 2018 15:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Mon, 21 May 2018 15:22:50 -0700 (PDT)
In-Reply-To: <CAE5ih7-1LwLxndEdjtGEmoViiZYbspkjymTzWxnnMgVWfNW2_w@mail.gmail.com>
References: <20180519100020.616-1-luke@diamand.org> <20180519100020.616-2-luke@diamand.org>
 <20180521213924.4491-1-szeder.dev@gmail.com> <CAE5ih7-1LwLxndEdjtGEmoViiZYbspkjymTzWxnnMgVWfNW2_w@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 22 May 2018 00:22:50 +0200
Message-ID: <CAM0VKj=OL28HiwiU8F=vg7+=Vt=Ng8W3=15Q-2fs=f0bEFTUtA@mail.gmail.com>
Subject: Re: [PATCHv4 1/1] git-p4: add unshelve command
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 12:09 AM, Luke Diamand <luke@diamand.org> wrote:
> On 21 May 2018 at 22:39, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
>>> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
>
> ...
> ...
>
>>> +'
>>
>> This test fails on my box and on Travis CI (in all four standard Linux
>> and OSX build jobs) with:
>>

>>     File "/home/szeder/src/git/git-p4", line 2467, in cmp_shelved
>>       return ret["status"] =3D=3D "identical"
>>   KeyError: 'status'
>>   error: last command exited with $?=3D1
>>   not ok 4 - create shelved changelist
>
> It works fine for me - but given where it's failing, my first
> suspicion would be p4 client version (or server) differences.
>
> I'm using 2015.1 for server and client. Could you check which version
> you are using?

Well, sending a bug report and not including the version used...
totally rookie move.  Sorry :)

I downloaded the same version used by the Travis CI Linux build jobs,
which is:

  Rev. P4/LINUX26X86_64/2016.2/1598668 (2017/12/08).
  Rev. P4D/LINUX26X86_64/2016.2/1648692 (2018/04/16).

The OSX build jobs used whatever current version they got via
homebrew:

  Rev. P4/DARWIN90X86_64/2017.2/1611521 (2018/01/21).
  Rev. P4D/DARWIN90X86_64/2017.2/1650199 (2018/04/18).
