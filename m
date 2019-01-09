Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AF61F803
	for <e@80x24.org>; Wed,  9 Jan 2019 22:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfAIWmW (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 17:42:22 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:33961 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfAIWmV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 17:42:21 -0500
Received: by mail-oi1-f179.google.com with SMTP id r62so7736856oie.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1/QU4Kmv4tFnZ+nnwNhIy6qtshbc66hN0O0M1UAusE=;
        b=rX1B/IOAq+KOTg4EYIMv85HCpNa/4qG22k5p/bdM0YJS/Enz2Ry6HGxNH6SW4DBgIP
         GteMS8QavFYRAnHOXBmKKqwQ0fDg1cGq6vnWXWuMGCutM0PpjP2Ni6to620X9XPAEqEP
         7LNzmFDCZ5iQTNLjwIR59eSturXH4H6sDW+WQT9Wr8qRb80AOaaFHPd81S9WSrsB/eh9
         odJIvLTJ8cE4d50zqXKO9VmdeWYVg7cPkdF/zCTFVY0+e+09615ydOVAgquNbRaIe0a/
         E4HXtW1tiUl6z+mBDyaLtzcmW2+V6799ELnjIGu6S5mkLTlrkajkjcZz7M9TLAClW2Ue
         f9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1/QU4Kmv4tFnZ+nnwNhIy6qtshbc66hN0O0M1UAusE=;
        b=haaf0EBuYYpRmwJWvLRGPiadi6d0hszn/PuAXoq9Rh3WuOwwSgy/h4gTSPljsqM1Hs
         vr8/RFvrJMC3LsBO+wnE9rlKaKBZ/Ar1P6RtRwv8n5RYpG1fhawUc0yRjAE54brKpTs5
         xDkP6PLxwJTu4ISuLbywZWVknqNx65lb4cWPGr7ecAeKIDjxF7uf63blt48bA5L53veF
         SzJvoT0SUIU8YYK789/yNNz7ShZBnEEWuK/5goPYhTcSGvTxi+W6WpX/Rw5EJVELNxml
         COj6wfyPZmddv2ZSc4bXjPNRG2lDeS/XEowkO41LXSaMhPI8W7i3uVR6CIn1W14pVmE9
         d1Yg==
X-Gm-Message-State: AJcUukfkl8j4txmDU9v36iRaWfMWND/v8A0z/BHkVUFz5EEYYHesu6aO
        H1kxQxYlPIEIPbia/r5Pvh/DDa85LJ21sKzoVy4=
X-Google-Smtp-Source: ALg8bN4zm5hJt5j2wcbzWynP49avfc2UEy0lZu9yI9Q6eBR9JzCmRpLnrr75qkH+npk4hRfaeShptHa4RiqjTQEH4FQ=
X-Received: by 2002:aca:b254:: with SMTP id b81mr4768531oif.257.1547073740881;
 Wed, 09 Jan 2019 14:42:20 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih7987J2WXdCJvs2e3hOn3zucpE6gsr4JJtxO+XE5=K2G_Q@mail.gmail.com>
 <20190108005634.1647-1-amazo@checkvideo.com>
In-Reply-To: <20190108005634.1647-1-amazo@checkvideo.com>
From:   Vitor Antunes <vitor.hda@gmail.com>
Date:   Wed, 9 Jan 2019 22:41:54 +0000
Message-ID: <CAOpHH-V8XJECpekPNvS3vymGBtzfrCTZAx=U5HALUTou+cAYfg@mail.gmail.com>
Subject: Re: git-p4: default behavior for handling moves?
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "luke@diamand.org" <luke@diamand.org>,
        "chenbin.sh@gmail.com" <chenbin.sh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

On Tue, 8 Jan 2019 at 00:56, Mazo, Andrey <amazo@checkvideo.com> wrote:
>
> > git-p4 can map a "git move" operation to a Perforce "move" operation.
> > But by default this is disabled. You then end up with a P4 commit
> > where the file is deleted, and a fresh file is created with the same
> > contents at the new location at revision #1.
> >
> > Rename detection gets enabled either with the "-M" option, or with
> > some config variables, git-p4.detectCopies and git-p4.detectRenames.
> >
> > I've been tripped up by this, and I actually know about it, and I know
> > other people have been as well.
> >
> > Should we switch the default over so that it's enabled by default? I
> > can't think of any reason why you wouldn't want it enabled.

The copy/rename detection in git is not so obvious, nor easy to understand.
Also, when you have many similar files it is possible that the source that git
detects is not the real source of the file.
Another thing is that copies are only detected if the source file was modified,
which means that detectCopies without detectCopiesHarder does not make
much sense..

Those were the reasons that I recall at the moment for not having enabled
these settings by default. But that said, I do not oppose in having them
enabled by default.

> I have it enabled in my ~/.gitconfig,
> so enabling it by default makes total sense to me.
>
> Regarding potential problems,
> I occasionally get a wrong "source" file detection.
> (e.g. there was `cp a b ; git add b`, but some other file "c" is selected as the source instead)
> Or there is a "copy/move" detected, when there was actually none.
> But I've only seen this with quite small files (like a trivial one line shell script) or binaries,
> and mostly because I have git-p4.detectCopiesHarder set as well as a pretty aggressive git-p4.detectCopies threshold.
> (normally 30%, but down to 10% at times to make sure a copy/move is really detected)
>
> But anyway, enabling both git-p4.detect{Copies,Renames}
> with default 50% similarity index makes sense to me.
>
> It's probably worth adding command-line options to override the new to-be defaults though.
>
>
> A more conservative approach like only enabling git-p4.detectRenames = 70% is an option too.

I'm using detectCopies=89% because copied/moved files, in general,
will have a very high similarity
level and I don't want to have new files with similar contents
(imagine test cases, for example) to be
automatically detected as copies.

> > I think the rename code was first introduced around 2011 by Vitor.

Time flies!
I was using a much more complex P4 setup at the time that relied a lot
on renames and copies, as
well as branches. I have a much more linear setup now.

Best regards,
Vitor
