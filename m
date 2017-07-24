Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95D520899
	for <e@80x24.org>; Mon, 24 Jul 2017 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdGXECu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 00:02:50 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35673 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdGXECs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 00:02:48 -0400
Received: by mail-lf0-f52.google.com with SMTP id t128so9393333lff.2
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LGVFcQVA17SpAMeOmVaMVHfymnmIBXZnf4Jp04aGw9k=;
        b=khNn4Q36kKI2LdieQxyGMd0mMz5lJXZl3O7cr+FWaQ2lXAmNDpCZU9Ujt4Bru/K9Qu
         twV5FOaB0RpfZLsj6Y6TlfyTjcfKAS/SwWZt5FXfOLh5bvpsASCsaKdOeuDylPy3okM8
         tDKM/6gN+PItZVGRow8U4EAkrX9k46bwMt18PW4FrpoChnEexSAGPsKsM0t55JKeo9dy
         5bH00oXl82iRXJm4Iu3FO9S+9dyoi3FZUHX9MEMUF2QM2lnwHc4eFDBF7d5ZtN0fucEP
         Xeqls38ZPVQyxUC1NrV5pB0OD6F1s/BHlsmoWG97FxqzBNw8wG4GFDBSOtFPS1zaujxw
         wniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LGVFcQVA17SpAMeOmVaMVHfymnmIBXZnf4Jp04aGw9k=;
        b=QDrLXwqtKVnu3fuh2NLevNaEE7kJrhGg40XYvyY+UNW+m1OicKFIiymR1VHKYSqj1a
         ra+meKb6JJtE4MYWpjt346l8upewjtq2kGICHipOaYQrghj+ylK2HQH91MMPW2/Ymcia
         DsIMrqcG6ihB943KUP9Luw38p3c2fkStRuYWwWkiKOd68HBIiF2TGbFnxcFXnc5f1BzP
         0Nl4RrLgELDGkyl1JAk4MmZ9+tO9qQ1JBQt4Lh6vZQ1jOXn66YipejvVPwudyhwDNj+l
         DHUlbkEl0xgRjcQKcNTwZKwQi3r5HL5E6LtAL6fMO1R5jr35Y1ZVHBTxpcnZY0mukg7i
         j5Sg==
X-Gm-Message-State: AIVw110/noQCm+V778LXogIFi58F1qz35UQ0iqOktvXRofA/eS0NT5GD
        VS916X4nZ3iWUw/lM1xc+zw4k9PPsQ==
X-Received: by 10.25.209.2 with SMTP id i2mr4003983lfg.119.1500868967229; Sun,
 23 Jul 2017 21:02:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.56.13 with HTTP; Sun, 23 Jul 2017 21:02:26 -0700 (PDT)
In-Reply-To: <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru> <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru> <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 23 Jul 2017 21:02:26 -0700
Message-ID: <CA+P7+xrpKTuBTueyGGVz4doWMnbGQo+2qj2wbpPvXBaW-iDV2w@mail.gmail.com>
Subject: Re: git gc seems to break --symbolic-full-name
To:     Stas Sergeev <stsp@list.ru>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 23, 2017 at 12:23 PM, Stas Sergeev <stsp@list.ru> wrote:
> 23.07.2017 11:40, Jacob Keller =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On Fri, Jul 21, 2017 at 12:03 PM, Stas Sergeev <stsp@list.ru> wrote:
>>>
>>> I wanted some kind of file to use it as a
>>> build dependency for the files that needs
>>> to be re-built when the head changes.
>>> This works very well besides git gc.
>>> What other method can be used as simply
>>> as that? git show-ref does not seem to be
>>> giving this.
>>
>> There's no real way to do this, and even prior to 2007 when the file
>> always existed, there's no guarantee it's modification time is valid.
>>
>> I'd suggest you have a phony rule which you always run, that checks
>> the ref, and sees if it's different from "last time" and then updates
>> a different file if that's the case. Then the build can depend on the
>> generated file, and you'd be able to figure it out.
>
> OK, thanks, that looks quite simple too.
> I will have to create the file by hands that
> I expected git to already have, but it appears
> not.
>
>> What's the real goal for depending on when the ref changes?
>
> So that when users fill in the bug report, I can
> see at what revision have the bug happened. :)
> While seemingly "just a debugging sugar", the
> hard experience shows this to be exceptionally
> useful.
> I think even linux kernel does something like
> this, and solves that task the hard way. For
> example I can see a script at scripts/setlocalversion
> whose output seems to go to
> include/config/kernel.release and a lot of
> logic in the toplevel makefile about this.
> So not liking the fact that every project solves
> this differently, I was trying to get the solution
> directly from git. But I'll try otherwise.

generally, I'd suggest using "git describe" to output a version based
on tag, and as part of your build system set that in some sort of
--version output of some kind.

Thanks,
Jake
