Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FAB207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 05:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165286AbdDXF3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 01:29:20 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33866 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165283AbdDXF3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 01:29:19 -0400
Received: by mail-ua0-f171.google.com with SMTP id h2so106848362uaa.1
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 22:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=dCIuy45dCNy5nx8vdUmmbqD/mYHCOBM0AOszY/IYoQ4=;
        b=IRL8U5BiSUS/3ng3+oUCGSplX49+vfXfku1bsQLdYBiQyVNgKmo6+qwJjFoJeVBS6L
         xhU8L8gUdM1aIhjKuU3QCVFNAavyBB+B2HgxLI3PYd3Cw5CFBkBHAOKcEYa/aehgPeyq
         +BNFxinCCylM9zIMINV3adXpyEhImJu5EDlw2yvzihvoMqnRLxkikl0frg2Xqp2po24m
         ItvtNlj8fQtK5MyIaKERG4TwePL09uj/uOQ+/uMM3KLuVjD/Cr0YH9SMpRaRUkXqPIq9
         JRBvSq38P6AeKTmTf4wFJWrrkzj6Xk4DZUYgAKhvEwcEnHLI7TU8QJ0Gn8Ta7dCwTRzf
         0I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=dCIuy45dCNy5nx8vdUmmbqD/mYHCOBM0AOszY/IYoQ4=;
        b=GEarGKclfx9iOMUBzwfOGTTklACQLaMFNGti70VoESLZ7cFVmRh70YZFVIKgS/tTaG
         0e4ZbekWTgtjaSDfPbziPWxonBEO9a49mbZkZ+ifDAnTGFskYtLe8lqeGUeNrUqvHzA4
         aDEquxUFEXASw8/ViRVW8BAqSY9tlRfHYzFJuHoihtALoXagm3Z8W9/mk/z42Z2bdXUd
         zYnZpORa2+x8tSMG8odQkNAqYM3SEWoXo/GgNhzwI3BCY5G2eGtCLNWgz+oCRpUMKiTC
         iyknX3H1+ilbv+Lk4wY3eIm8FuISV9YvIKg4vbkS3PoZ0o70s/K5xGdyzdWcOH6GDJBh
         AtMA==
X-Gm-Message-State: AN3rC/5LPX7tMFir3P42hGT2dQfxM6YF8LjQ70O2pnXoFR+FjSqbFL5R
        Ggo7mwo9CFJgYvl1u5HPyup2k2X0ouYB
X-Received: by 10.176.77.211 with SMTP id b19mr12675972uah.63.1493011758157;
 Sun, 23 Apr 2017 22:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.105 with HTTP; Sun, 23 Apr 2017 22:28:37 -0700 (PDT)
In-Reply-To: <CAA0fXPvf5V3bALha-7fwTCt17OnXMDX-BjAz+jmXrsbK62BtCg@mail.gmail.com>
References: <CAA0fXPu7s1-UQ-RBxvmPq0kGSsdt1wp9VJp7wNMZ_uE02RvCbw@mail.gmail.com>
 <CAJZjrdVyKcPCmPT8S=Spju_Q7KRjkm7AbP4H--pVdiY9qR=AhQ@mail.gmail.com>
 <CAA0fXPsuSZsn3tfm=f0G7OP7bL0L=7GDy_WVqfAnhfBKonrHvg@mail.gmail.com>
 <CAJZjrdXqD-fSCjC75bPgeYKUDH-XvGkpjGgSeoYu9NNhZyiN3w@mail.gmail.com> <CAA0fXPvf5V3bALha-7fwTCt17OnXMDX-BjAz+jmXrsbK62BtCg@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 24 Apr 2017 00:28:37 -0500
Message-ID: <CAJZjrdXWbBz3MUVG4WuXvkGD1TZDWTaaEd7VXnyhDsXvU7WSEw@mail.gmail.com>
Subject: Re: I suggest a new feature: One copy from files
To:     Rm Beer <rmbeer2@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looping the listserv back in, didn't realize this had gone off thread.

I'm not sure what you mean by "update only the last change, and not
record the old changes".

update-index is, like most Git commands, per repo.

On Mon, Apr 24, 2017 at 12:08 AM, Rm Beer <rmbeer2@gmail.com> wrote:
> Yes, but i say about of have a update only the last change, and not
> record the old changes. Interesting command the 'update-index', this
> is a permanent config for each dir/files?
>
> 2017-04-24 1:59 GMT-03:00 Samuel Lijin <sxlijin@gmail.com>:
>> Ah - I see what you're asking for now, basically the ability to tell Git to
>> ignore changes to a file once you've already started tracking it, right?
>>
>> If I'm not mistaken, git update-index --skip-worktree will do this for you.
>> (I'm on my phone, so I don't have easy access to documentation right now.)
>>
>> Hope this helps.
>>
>> On Apr 23, 2017 11:51 PM, "Rm Beer" <rmbeer2@gmail.com> wrote:
>>>
>>> in a repository have two behaviors. (How understand i)
>>>
>>> 1) A file can check and updated in the repository, take any change
>>> from the file like a record logs.
>>> 2) If the file have in .gitignore . Git never see it.
>>>
>>> I suggest add a new behaviors:
>>>
>>> 3) A file can check and updated in the repository. But never add in
>>> the record logs, only have one copy in the repository. (Maybe add
>>> filters in .gitonecopy or something)
>>>
>>>
>>> 2017-04-24 1:02 GMT-03:00 Samuel Lijin <sxlijin@gmail.com>:
>>> > ...what?
>>> >
>>> > I'm sorry, I have absolutely no idea what you're asking. You're going
>>> > to have to be a lot more specific with your description of the desired
>>> > behavior because as is, I have no idea what purpose your .gitonecopy
>>> > or .gitonelog would serve. I also have no idea what this has to do
>>> > with the binary files ignored by .gitignore.
>>> >
>>> > It would probably make sense for you to describe a use case for this
>>> > as well, to help us understand why you want what you're asking for.
>>> >
>>> > On Sun, Apr 23, 2017 at 10:47 PM, Rm Beer <rmbeer2@gmail.com> wrote:
>>> >> I have a several directories with binary files datas that is discard
>>> >> by .gitignore.
>>> >>
>>> >> I recommend make a new .gitonecopy or .gitonelog or something that
>>> >> take the directories with only 1 copy of last updated and not take
>>> >> history of files in the repository.
>>> >> Maybe anyone found other best method for apply this idea.
