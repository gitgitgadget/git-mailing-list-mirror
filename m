Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A371F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeIKVKO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:10:14 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36565 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKVKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:10:13 -0400
Received: by mail-it0-f45.google.com with SMTP id u13-v6so2236294iti.1
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=skgW9zFji0ZFAtaVmXepfDS4c33E88Lw98ltr8xu2Vc=;
        b=ak8WZQ+uEvj7fN6n0ZhVuwVmvDwPz15TREpeS3SpxLUoZn8RqfZC/cfEH+cUNK+bmY
         vJTi8jRkhcoIitUw4/FYgcfED3f1tc1hf09Uca5pw1kHxKYPLpLDLWiEGYnMRWUjoTZW
         L9NsiWDaJ+00u2mnQo7XjCAFJpaqVwCvAxEoYg6WO7wRjjTu9BsoGqtQD9tdtDB77fbN
         VwKdTBxVRw18QQMSHOhNA59VSGrQ0nRJa9Kq8ahr13TkgnlbnjyNRQQ/vWepyhxAtWuZ
         GjGNuJsIem0/FgLe58OgPvbVqlOEV0mAnczD3Y05PqgYYTwCGZ8faEH4to7OAlh56SWe
         buVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=skgW9zFji0ZFAtaVmXepfDS4c33E88Lw98ltr8xu2Vc=;
        b=alaPmNbZkc0M2FfNaN5BdpMvqh2ndTeYoGmktWjoqXoQT5uOWNHZ7Ugxz1bTHmpHLu
         W5p/1cbK0xBAWSS/usuzY5u67Gz1c0WjIBs40546MegJIDlDjwCtpT51VUJfw8lXdaaS
         xalJ54IBhqjj7mzg3dSDMKMbOLdIjA9RHdgKkC6XWfzEKxkny+YV33KnaGIPrRBSe1vq
         hkTIwyRqpG6VYn5IC/rzPn+989hIBBGSQVmpzy0z2jFwexc+JlzGPRMVJcLKeaZqe/7w
         nebCcbL8XDvJ1wU4Oa5zlCiiF27bJ6aR34ixiVIaOZbzh8khSBhECVGWaVJIg1oGTaOm
         L2pQ==
X-Gm-Message-State: APzg51BZwTeA7TBAUeaXZZgFJEz1gUUN8h3Pu3W8+6IoKc7HcUhnR4rB
        vcw8niV2+dNhiD2BbrJh4Jszv03qEd/+m4MF+Ko=
X-Google-Smtp-Source: ANB0VdYQdb/24FRZieSle2fiRRMpHyJkomM9Kr/B2KWbkLB0Ri5xebC6s8SJcYKHZZBksyAYxzGlzga7fEv2xE97vdY=
X-Received: by 2002:a02:270f:: with SMTP id g15-v6mr22545835jaa.94.1536682213728;
 Tue, 11 Sep 2018 09:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com> <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
 <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com>
 <CACsJy8AMaUmWO2zi9+Dpr9_ZHE7A0rSs63h646w4uokyKRAdUg@mail.gmail.com>
 <CACsJy8DdxmVd_jBG7Tp1e7k-BUc6R1=oWzPZ3z6xUZs2XU9rMA@mail.gmail.com>
 <CAJmnt9YxGoQO40GNQY=nTjGGaGB5X079koZ0QvCOZ4wd7ubkaA@mail.gmail.com>
 <CAJmnt9YgFNjzZfOW38WbyC-9AK4rtS3P6_dKN6hS1X+y932uiA@mail.gmail.com> <CAJmnt9aCfMGejO3B5ctZuCjJnE4K-dA1dwyz1uxoZwRBOJJqpg@mail.gmail.com>
In-Reply-To: <CAJmnt9aCfMGejO3B5ctZuCjJnE4K-dA1dwyz1uxoZwRBOJJqpg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Sep 2018 18:09:47 +0200
Message-ID: <CACsJy8DHTbpOmK=cthus3BZ4BtS0YbJS8=K72BCb7=fFx6TPBw@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     hultqvist@silentorbit.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 12:27 PM Hultqvist <hultqvist@silentorbit.com> wrot=
e:
>
> Sending again without HTML
>
> Den m=C3=A5n 10 sep. 2018 kl 12:28 skrev Hultqvist <hultqvist@silentorbit=
.com>:
> >
> > First I need to correct my previous observations.

Please don't top-post.

> > Today there appeared new set of config files in the root.
> > I looked into a few of them and found that their content doesn't match =
that of the repo at "G:/Min enhet".
> > Instead separate files had content from separate git repos within the G=
 drive.
> > These repos are not like the one we're discussed previously, they are c=
ompletely within G: using a classical .git directory.
> >
> > I guess git is creating the temporary files as close as possible to the=
 root, since "G:\" can't be written to, only "G:\Min enhet". and then copy =
them to the final destination which in this case is the same drive.

No. Those files should always be created inside the ".git" directory,
wherever it is. Failing to creating a file in there is usually a
serious error and the command will abort. Unless there is a bug
lurking around of course, but I can't nail it down with just code
audit.

Since the content of those files does not look like from "G:\Min
enhet" repo, do you know which repo they belong to (and where those
repo and worktree are)? I ask because if these are submodules of
"G:\Min enhet" for example, then we need to head another direction. Or
if they are completely unrelated to "G:\Min enhet", oh boy...
--=20
Duy
