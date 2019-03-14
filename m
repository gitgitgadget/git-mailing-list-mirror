Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D9D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCNM5Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:57:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41216 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfCNM5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:57:25 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so4958361iom.8
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfSbdGPC5oVEq3UjEYCWMXtgHD/ZhxN5C2pHedzn7Fw=;
        b=BuRgyPALsHKQod5vOB/yAWpVkfbsLDVnIueve+UwYNnjv7WhU6LbIyVdwSiCpd8lvO
         318m3D3brq7KUsjUFjOypu7qEO6hdgLTXWrWdOANlMXHZo5yy5szrKsUQNc/dNKrWuZX
         SdgIzOnUMcyUVtkGumGydY9DOd7qlee1dq3VAaNdnU1IDxUx26o08Y5zOEkAiLu/PboJ
         UDcJTBx/N9ie4aCC+fIM+Qb/VxGWrpJqSeEFrAXIc/EkTutwGTTHs74ee95jjKzlbXXA
         YN5yo3KgWSj09JGiaWqxVtKthHOPR3E3VVnQcdiq3jjrVSk29XGKgi6mUbgzN/Z27O75
         BlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfSbdGPC5oVEq3UjEYCWMXtgHD/ZhxN5C2pHedzn7Fw=;
        b=TL5rdmO2kcUVdwq3ofCtUYWtO5TnJVjgnKqaKQXtUf1hwgyK19i3y2jHZEfYaNg5b9
         6ir7QGy74hXb1iDl9L5nkuH1PZa0S9G8RsmtXU3aw4LjKhgpxZV/0AE90MRV+wLaMlSQ
         aqceL0APAkFx2dCUFaTz9s1qXbRNa4PqJn7TpG/p3KSnbdHAWw0HOtsDGmvwvLmclXYD
         cL63tT6VVuSi/EEHGBBfzes/fDvfec7r9J9hk1K4bGeIEEnuVtkSsTpMpV+183Pd3rX5
         j8EtT7gAZnWCRm7BkwKLIqgZ143g3RHroJeoBn8Ro7g+G0U4aJZREHC9AKjvkkGPqPLM
         j+ww==
X-Gm-Message-State: APjAAAU0YMirKz2uZ2Iu3IpWdqo/ZSfQ9ed21XLrnzyOJFbPSkWSIHIm
        1zBtJrUQJLIyZSoOSZ7U2tUlIKMIPB+vZ9dwqus=
X-Google-Smtp-Source: APXvYqx220u1sHRIl5cnT8lBeIV848VIlBaDHKvJAaoosMAMgJIrza6yTOi2wcAFPgNfY8vYKxwT16YgzGOLMQeP0BA=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr11413255iom.118.1552568244289;
 Thu, 14 Mar 2019 05:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com> <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
 <20190314091753.GA9852@ash> <5cd15ff0-8913-9b92-6ddb-94eff6f22077@gmail.com>
In-Reply-To: <5cd15ff0-8913-9b92-6ddb-94eff6f22077@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 19:56:58 +0700
Message-ID: <CACsJy8C54dndO_VoMZhvY=N3_prpLESp3w5NceUgRLPvnBVGLQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 6:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 14/03/2019 09:17, Duy Nguyen wrote:
> > On Tue, Mar 12, 2019 at 01:28:35PM -0400, Eric Sunshine wrote:
> >>>> Again, not much of a datapoint, but I do use --orphan periodically.
> >>>> The idea of "fixing" the behavior so that --orphan starts with a clean
> >>>> slate is certainly appealing (since it matches how I've used orphan
> >>>> branches in each case).
> >>>
> >>> The only three people who have commented on --orphan in this thread
> >>> all apparently feel the same way: the current behavior is wrong.
> >>> Maybe we can switch it to start with an empty index after all?
> >>
> >> Starting empty may match intuition better. (More importantly, perhaps,
> >> it's harder to come up with a use-case for --orphan which doesn't
> >> involve starting with a clean slate.)
> >
> > OK so the new --orphan description would be like this, right?
> >
> > --8<--
> > --orphan <new-branch>::
> >       Create a new 'orphan' branch, named `<new-branch>`. If
> >       `<start-point>` is specified, the working tree is adjusted to
> >       match it. The index remains empty (i.e. no file is tracked).
> > -->8--
>
> What happens if no <start-point> is given? Do you end up with an empty
> working tree or the current one? I'd lean towards an empty working tree
> (with a check that there are no uncommitted changes, users can use
> `restore` if they want some of the files back) but that is inconsistent
> with the implicit <start-point> of -c.

I was thinking default <start-point> is HEAD. But yeah empty tree
makes more sense since you can always say "switch --orphan <branch>
HEAD" but can't really say "give me an empty tree".
-- 
Duy
