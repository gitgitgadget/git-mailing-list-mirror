Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5D2215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeD3QTK (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 12:19:10 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36093 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754674AbeD3QTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 12:19:10 -0400
Received: by mail-vk0-f48.google.com with SMTP id i185-v6so258108vkg.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wRFf1UicQfj+TqSYXeT3JdYqymPvm8wPrJJfnH+CoSc=;
        b=N2Kcl2Xuov0mN1ipE4A6SEJ6D31vr8+maESQWCeMK6+5hvJ8G2nCM2aTlAp21a80Cs
         wQ/UqNjPSvkh19aoP+nKDrpn7Z0iKex3KZf8TGjcTdpuqRrcdS6yjUxDl1B/oYLSR0Q5
         n6vSmM2s3ADR26vBKSiR8UNSPjZ4gXdYyGvWMPIH4ETqMu+7bU1HYVXo5xmwGc1EfeIz
         qFOH4sG7PqPqHdoXVssHgZj1DeRcrB47UMTZKpA4umV7xlWAxwFBNEMOfcNO5Kqe4Tkp
         0B4mpsh0LjlcF6PxO4VFLA1D/krXUPGqVPnlcZFWTzRlhi2AQ91JU2UmGI3G0JJi2HZ8
         x/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wRFf1UicQfj+TqSYXeT3JdYqymPvm8wPrJJfnH+CoSc=;
        b=nhqb+f4lMt8BjSUauyYDG17b3iBjdxeIFNrlXoV37Mq4gko/+uI/DpDJLcVe1cGBDH
         NiaD8Jcj8MFvasMtBuA6qZNYP0CuEUIm+ErOFAy4FoJqW1FkqTqMH0XWximmrGh59goj
         3nvHHrma2KDjmydhkreDVrrxUH+qXlEdSzZI/Fzo6iYxyCWkMZC9jfRc83Rwi0vh0/aN
         9u/zDrG/fYe5g67zgXiskRmhhicho1nEgII5evqSp4zmPt6o+NBcrvUhHoQeqEDQy+6E
         zYfzV+dNuIoPbX36AkkVTvQLcULIVcDbl7ws5MSo5T5Qr+h509VZyUK8U9XMx/NxYFjz
         KsjA==
X-Gm-Message-State: ALQs6tCScrmx80jvTMHcTW7UoUqPvTPJN5TQFBesNRsFIAzT+b26XzDB
        6+0o6Ym1dklNGAqxXnwMaKXcbATrEC3XQQAz0j4=
X-Google-Smtp-Source: AB8JxZoLyDMc6MSxhKER4q8IkWXptl92QYWk7JBL6o/j3JeQj7c20C6CpkoR4M8YQdRa3R+S7zxav7h+pMZos2EyR4M=
X-Received: by 2002:a1f:72cf:: with SMTP id n198-v6mr9376945vkc.149.1525105149210;
 Mon, 30 Apr 2018 09:19:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 30 Apr 2018 09:19:08 -0700 (PDT)
In-Reply-To: <CACsJy8DhDDzLCQNoAdc=F6jLUSJK=dDWhhqLBecGG5ru01gRCw@mail.gmail.com>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com> <20180424065045.13905-1-newren@gmail.com>
 <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804292251000.79@tvgsbejvaqbjf.bet> <CACsJy8Cqq5c1QC=2EjfajS3=+ofAF8eoFG2V4QeY+LzSykJOFw@mail.gmail.com>
 <CACsJy8DhDDzLCQNoAdc=F6jLUSJK=dDWhhqLBecGG5ru01gRCw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Apr 2018 09:19:08 -0700
Message-ID: <CABPp-BFsEPbTXq0cFE+gkXcXtP_1LOyQAUMMXBOdB16OJknDig@mail.gmail.com>
Subject: Re: [PATCH v3] unpack_trees: fix breakage when o->src_index != o->dst_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, Apr 30, 2018 at 7:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 30, 2018 at 4:42 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Apr 29, 2018 at 10:53 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>>> > @@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>> >                                                   WRITE_TREE_SILENT |
>>>> >                                                   WRITE_TREE_REPAIR);
>>>> >                 }
>>>> > -               move_index_extensions(&o->result, o->dst_index);
>>>> > +               move_index_extensions(&o->result, o->src_index);
>>>>
>>>> While this looks like the right thing to do on paper, I believe it's
>>>> actually broken for a specific case of untracked cache. In short,
>>>> please do not touch this line. I will send a patch to revert
>>>> edf3b90553 (unpack-trees: preserve index extensions - 2017-05-08),
>>>> which essentially deletes this line, with proper explanation and
>>>> perhaps a test if I could come up with one.
>>>>
>>>> When we update the index, we depend on the fact that all updates must
>>>> invalidate the right untracked cache correctly. In this unpack
>>>> operations, we start copying entries over from src to result. Since
>>>> 'result' (at least from the beginning) does not have an untracked
>>>> cache, it has nothing to invalidate when we copy entries over. By the
>>>> time we have done preparing 'result', what's recorded in src's (or
>>>> dst's for that matter) untracked cache may or may not apply to
>>>> 'result'  index anymore. This copying only leads to more problems when
>>>> untracked cache is used.
>>>
>>> Is there really no way to invalidate just individual entries?
>>
>> Grr.... the short answer is the current code (i.e. without Elijah's
>> changes) works but in a twisted way. So you get to keep untracked
>> cache in the end.
>
> GAAAHH.. it works _with_ Elijah's changes (since he made the change
> from dst to src) not without (and no performance regression).

So...is that an Acked-by for the patch, or does the "two wrong make a
right, I guess" comment suggest that we should still drop the
move_index_extensions change (essentially reverting to v1 of the PATCH
as found at 20180421193736.12722-1-newren@gmail.com), and you'll fix
things up further in a separate series?

> This file really messes my brain up.

I'm glad I'm not the only one.  :-)


Elijah
