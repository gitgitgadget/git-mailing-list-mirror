Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E0B1F89D
	for <e@80x24.org>; Wed, 26 Jul 2017 00:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbdGZAg2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 20:36:28 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35452 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdGZAg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 20:36:26 -0400
Received: by mail-lf0-f45.google.com with SMTP id t128so32424024lff.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1XEfV+GfeQaW9yxJxdN3AJNc+gBCOOP3D5UjHhUAZNI=;
        b=WpY+79yIoVztN6YPTdPaBo3eGABoTuDwanlfC9e+Duyjv1Rs8JyQl07uV/dbu1/cOK
         sJ9dGcXoc9brlZ3cixuqb6OFDNQfzk//20zqbL9mqMvB+IGdOaYq8Tun1WzTTRUJXBjR
         97hdcsMbxd4poM4mtbfhl7YGuynq+TSfYin5ThAZSk2N5qTkRSHWAcxnAUTpAN4WliKW
         doVHqE5CPOYzsuQrhcD6FB5jcPBfDx8PP27YkWSZ8+rRAaPU1z41VOYKFXw1lkgfAu4p
         R4duQMEElns1kw9R+wmfl2H9ii7/7u9/NQTzIVOKc8+qPmo0vK8RHBdt7T9AID6f9xUk
         LS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1XEfV+GfeQaW9yxJxdN3AJNc+gBCOOP3D5UjHhUAZNI=;
        b=mD4TLaXLTmwTI8hOQAcoEdf9eefpFN+pKGY1i0HJkATyOpyZywE+Wmg8lTgPqHKzj4
         Kn5ks2hHcU/DfPJ07aP/epIxUJAOZ4vd0+ir0ICXi09LM3dr/v8Xby7XSaDVwz/Qy0Sp
         NtPRjqtD8oukFgrVMvMvZnYdyjQod3LDE413vMadQ9QBTsiZRIzIZ95h+5zc10Y93bIk
         3AeBMJq2jSdBvp65dKPo28/YrTgZk1msauXptMGeS1IeS8LuFrVn6iVZvNwdV85TGDjt
         JvYRhujZMtqLGZ9IhksV69RZUMRwznHfuMAvlTrW6HoY4XY8VFE9EkUsbpi7GNt0zKKv
         HhZw==
X-Gm-Message-State: AIVw112E0lxphjzkAc5MNrjrtxIHr/EUrQl1gtrK2l7ddp/8Dhn+MTQe
        Fjcq8YLSqpg8Syd1ZSPbze4Fqo+0+A==
X-Received: by 10.46.8.18 with SMTP id 18mr7563971lji.80.1501029384899; Tue,
 25 Jul 2017 17:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.56.13 with HTTP; Tue, 25 Jul 2017 17:36:04 -0700 (PDT)
In-Reply-To: <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru> <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru> <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 25 Jul 2017 17:36:04 -0700
Message-ID: <CA+P7+xock9gpYVtxj2n6L5Y9dO1VV01OEOT5i0MR7ay68yS+WQ@mail.gmail.com>
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

If your goal is to make it so users filling out bug reports have a
version, then using git descrsibe and making that be part of your
version (based off your tags, and commits) is how pretty much every
other project I've worked on does this.

I really don't think that's your goal here, given you're doing things
in make with timestamps and builds, so I guess I misunderstood your
answer?

Thanks,
Jake
