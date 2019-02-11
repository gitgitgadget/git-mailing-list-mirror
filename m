Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01D71F453
	for <e@80x24.org>; Mon, 11 Feb 2019 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfBKHqH (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 02:46:07 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44888 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHqH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 02:46:07 -0500
Received: by mail-ed1-f50.google.com with SMTP id y56so7963721edd.11
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 23:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VIxcdA7lsZjlo9F3nQMF/JzfGLiDgCNzfLEJxhwmods=;
        b=uBQL9/fhohwCrObULe/FohRsUjiuDWg2mQvUItofqFvJ4wkSgglD8yLTJRmyD5C2Qv
         Zf03j1Tj+F8tfs0L4Pv9s+pIs2a3mVwmBUai8EiwXmpw9br5wlIW3+4xnPV1CRui28L5
         U2d4wC1RPIBFPPN6JiYKdskUGM5/aFd0MeMY8K0XYcoh2HKGDTIHeBrsuiN5sArszqZ+
         r47qL3Ok0Ii5+pfmQB5AUziTO3yh7wRrrPV6a3A27I4SfUSrTGwlORp+hcg0E5/y7LZK
         k4JBduYtYI5BLUVGkrxp+31FWQqGavwTzcMLi2IEq3/kChwgV0L9CD7f+sxWFgQmdBdB
         k+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VIxcdA7lsZjlo9F3nQMF/JzfGLiDgCNzfLEJxhwmods=;
        b=GyV8CiQDofjEBNIRsZQYbPEBbXT0tGd9Cu2h5xH4cTperQPgBC1S/TcrBK4ivDWthn
         BajUSWs5/xaDmiP9gI+39sBLwGq8Uq8dwZhLZAxgHxUO20Ctz3GKQ+M+lXVBciAuIkPp
         inbX/ioQit4VCiz+30EExW5veRHm1gzFgUkU0ENEphxcyxPL1py46hFLEw7E2P1cwF49
         97d6YdEA5pHJ42/s/gieDbIBs87+WYOJSYZcxSz8VUDoR8NTN6uSJz4qH+YRFVyStOBr
         pggLCjk/7/wpuie93MUZKzQdSev3M9sN8I2QkG3ovx+EaCMArZceNJ+tkDexFBNLSlSq
         /svw==
X-Gm-Message-State: AHQUAuYUqCaGGvC6OqqdCXd7TwQneRsyFqbrJDmClm7FkzJ7WXuNjVfv
        sMigpb4LkyPStU66C0oFYXSs4SrKbpYPgXEMyTU=
X-Google-Smtp-Source: AHgI3IZJduEwQ5fAEOxJ6K3lR/qIWLUwN8m+qSj6sygxvMb2l+DACCHvWnJlaubAGiUvjvZeuV51c0fonpI5TKP3dYQ=
X-Received: by 2002:a17:906:55a:: with SMTP id k26mr17532804eja.172.1549871165188;
 Sun, 10 Feb 2019 23:46:05 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
In-Reply-To: <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Feb 2019 08:45:53 +0100
Message-ID: <CAP8UFD24Jgetmb9_ANm07Emwr90obVpiRPyX+HtmaHcL1fYq5g@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 6:48 AM =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=
=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>
> > It would be nice to have a few more project ideas.
>
> I am not sure I have additional ideas for 3-month project for the intern,=
 but
>
> > https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> > projects:
> >
> > - Unify ref-filter formats with other --pretty formats (which is new)
>
> I am ready to act as a mentor in this task, I know that part of
> project good enough.

Great! I thought that it would be a good project for you to mentor and
that's why I added it.

By the way if you would prefer not to mentor the other project I can
remove you from its possible mentor list.

> I have additional related task: We have a function called
> oid_object_info, it allows to download meta-info of the file. It was
> used in cat-file, and inspired by that example, I improved ref-filter,
> so now ref-filter works faster with it. Moreover, I have found that
> oid_object_info allows to get the contents of the file. It was useful
> in ref-filter, and actually it could be also useful in cat-file, but
> we still download the file differently in cat-file, and it looks
> awkward. I need to make just one last move to finish my patch: it will
> close the task about migrating cat-file formatting logic to
> ref-filter. But cat-file still will not use general way to download
> the file. So, the task is to get rid of additional file-reading logic.
> I guess this task is much smaller than original one, but at least the
> student will have chance to finish it in 3 months.
> My patch is here: https://github.com/git/git/pull/568
> But I hope you will also see it this week in the mailing list.
> Proposed task is in TODO in the end of ref-filter file.

Do you mean the following comment from
https://github.com/git/git/blob/c17ed82b8983ea7e172181d869966db546c6a528/re=
f-filter.c#L2393-L2399:

/*
* TODO: add support of %(*raw). Need to switch between oi and oi_deref for =
that.
* TODO: split logic and printing (as it is done in format_ref_array_item an=
d
* show_ref_array_item). After that we could use %(raw) in all
ref-filter commands.
* TODO: rewrite print_object_or_die so that it will reuse result of general
* oid_object_info_extended call.
*/

?

It doesn't look like that's it. Could you just copy the task into an
email? Or if you think it could be an idea for a GSoC project, could
you send a pull request to add it to:

https://github.com/git/git.github.io/blob/master/SoC-2019-Ideas.md

?

> By the way, we had a letter from Google, it is said that our tasks are
> sparsed. I am not sure I understand it correctly. Should I help the
> project somehow to solve our issues?

Yeah, we got en email from Stephanie Taylor saying that our idea list
is quite sparse this year with a link to:

https://google.github.io/gsocguides/mentor/defining-a-project-ideas-list

which contains:

"Even if you are a new organization and only want one or two students
showing that you have multiple ideas (a bare minimum of 4 solid ideas)
is vital."

They also want "more detailed description of [each] project (2-5
sentences)", so I think we should work on that too.

So yeah, any help to fix the idea list is very welcome!

Thanks,
Christian.
