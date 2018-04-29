Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58511F428
	for <e@80x24.org>; Sun, 29 Apr 2018 21:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeD2Vo7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 17:44:59 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:41064 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbeD2Vo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 17:44:58 -0400
Received: by mail-yb0-f177.google.com with SMTP id l9-v6so2458471ybm.8
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0pzK7fRZSLSzK0QLflJN8pIumJEgN6N6mCJbOPlTpe4=;
        b=FiCoMypQklLclC0flA6R0GP+mXKUVa0r0dc+AE2PkwhehGSDDt6MXtQTS9u7fk64xp
         1MXrZ8FlCA5Li2xEHw1aEwzKuDbcfyayiN49p1DM8dL1zL/VxLGaUVoHWWp8MJHbaVGy
         ciiBSekGD2SDobLTesvH5otFoDDrtFiz3dyG3eeK5rauu+ZnmDgf4CNWBg10CjhtSGj4
         qKczPZWqJWpMIpGkLe5Sdbskibro74+WThZ2qc0vpY5bXxH+B4nF7l+unUtPZmlIZWYA
         gxqTYHmHMgy+W5wYw5dVJzIBulGS++HVnqIqO60Zj4eKmr0wjxn+aisna9NuQvhfM47o
         2HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0pzK7fRZSLSzK0QLflJN8pIumJEgN6N6mCJbOPlTpe4=;
        b=bIsCn2MBJh6PE8kFfsOgU30y2zUOK3akqI5eRhcSMgAepSudO4bO+N36gLE6Qh0It6
         X1MQ/71UVCnGfSMTkOroYx87BiTT+FhrtQ70vhhEdeb9PVovWee176EHxr9Fj3eFl+8n
         zcZGUOGpJY8M3LqHB68cApVTXZggTMjXIpl5f5RaxR9bh/xD+RuS1/p2VRCKUg2JpJ5N
         ObxUSGZmNj6C2jV6/UoAsxtIQU82DeQ8gCFftLUBbHUIMHbiiSV437DkCUsQ27yzdPPV
         Coj9Va5dvPiMA6KQM+zcNPGRvqoYmAe6Xiq0zpRmhZLXG3mCPQvZzWcoybpyeEzGjDHz
         fWqA==
X-Gm-Message-State: ALQs6tAtAOL0Xd2iVxoD83Bbk5If4IEUrC7I6tSoppJEF8KHGigbrDAH
        djdsZ7PmhoVLbEe0MPhd3/9hBEMrcErTBH6IIiL68A==
X-Google-Smtp-Source: AB8JxZrxe9q+wtsfJVZq5PdOUITnOttsDuKKIdMQVGnMGGT14BIhTB07wQcWnFVHwVwNcovr0saN+yEInb1aggLTJ4U=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr3049445yba.352.1525038297504;
 Sun, 29 Apr 2018 14:44:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Sun, 29 Apr 2018 14:44:56
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804291255010.79@tvgsbejvaqbjf.bet>
References: <cover.1524868165.git.johannes.schindelin@gmx.de>
 <42db734a98059fcfd67627aecc93cc8f0439fd37.1524868165.git.johannes.schindelin@gmx.de>
 <CAGZ79kZJJadXVhcMfxqq2kH=F-6nKVuhOc_s-vgj_9w5YcOxkg@mail.gmail.com> <nycvar.QRO.7.76.6.1804291255010.79@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 29 Apr 2018 14:44:56 -0700
Message-ID: <CAGZ79kbfOd9r9JGE4qP_=CVnYDbn2A2aY2i+UrttC_0x2xOFuQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] sequencer: learn about the special "fake root commit" handling
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Wink Saville <wink@saville.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

thanks for taking your time to explain things. It shows I am not
familiar with the rebase code, yet.

>
> Having said that, *this* time round, what we need to do is actually very
> similar to what builtin/am.c's read_author_script() does (even if we
> cannot use it as-is: it populates part of a `struct am_state`). I'll have
> to look into this more closely.

Heh, so my rambling was worth it. Thanks for looking into that.


>> This part could be prefixed with
>>     /* un-escape text: turn \\ into ' and remove single quotes. */
>
> If could be prefixed that way, but it would be incorrect. We never turn \\
> into '. What we do here (and I do not want to repeat in a comment what the
> code does): we dequote what we previously quoted using single quotes. So
> we use the fact that we know that the value is of the form 'abc', or if it
> contains single quotes: 'this has '\''single'\'' quotes'.

Is there a helper 'dequote' somewhere?

>> > +/* Does this command create a (non-merge) commit? */
>> > +static int is_pick_or_similar(enum todo_command command)
>> > +{
>> > +       return command <= TODO_SQUASH;
>> > +}
>>
>> This code looks scary.
[...]

> The code already does things like that, by testing `command <
> TODO_COMMENT`.

ok great. So that is a widely used pattern for enum todo_command,
such that rearranging their order would break a lot. (Hence people will
find out quickly when doing so).

> But I guess your concerns would go away if I made this a big honking
> switch() statement that lists *explicitly* what should be considered "pick
> or similar"?

I did not spell that out as producing lots of lines of code is not the
primary goal, but understandability is.

And it looked like it would just pick the first section, so I thought about
some different approaches, either by making the enum todo_command
a lot more complex than an enum (an array of structs?) or adding
a new parallel array, that contains additional information for each
value at the given index, e.g.

static int is_pick_or_similar(enum todo_command command)
{
    return todo_command_flags[value] & TODO_CMDS_IS_PICKING;
}

but all approaches I had were more complicated, such that the additional
verbosity would not be enough of a trade off.

I think this function was only scary as I was not familiar with the rebase
code as that employs similar patterns already.

>> > +                       if (is_fixup(command))
>> > +                               return error(_("cannot fixup root commit"));
>>
>> I would expect you also cannot squash into root commit?
>
> In sequencer.c, `is_fixup()` really means "is it a fixup or a squash?". So
> yes, you are correct that we also cannot squash into a root commit.
>
> However, a squash is the same as a fixup with the only difference being
> that the squash lets you edit the final commit message (and does not
> comment out the squash commit's message, in contrast to fixup).
>
> Is it really worth adding an ugly line break in the middle of the error()
> statement just to say "cannot fixup/squash into root commit"? I'd rather
> not.

Makes sense,

Thanks for your patience,
Stefan
