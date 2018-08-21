Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8291F954
	for <e@80x24.org>; Tue, 21 Aug 2018 14:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeHUSE2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 14:04:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51902 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 14:04:28 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so4469110itf.1
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zZN8BLv2uZT6RW4UixUtArIn8hN82vI/DDsv5mDR24k=;
        b=qC94uC0Wy7n+r0XzLKK4ioYQwkpRIbyOEDAnmIH0qwbyED2RsQTZab+i1ANjCVxk/U
         adYENbCzF5XXL7K+/esyjtsQypIuKpe9HaupAtzKDvbpQRDCoC+2oAV+37ejHJdtdYMV
         z3Jmh4qIUY4Guc4OTxn1R8l5muO5YlE3UzwXsRPmz6/uabBw0Xj53W1whIbr167fdrYK
         kz+EB04+I2iLc0qfeQOdEsVRe1IcNUtpAypzxcNbkEiTo4um+yjrpqPqmXVa8L86TeFR
         fjNThiA0xquxNunHKMc5FSeJ7lCRzanVJ8+KbtyWE4U/kLjkF1bZvrHMVt52tu/Zf+jz
         8elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zZN8BLv2uZT6RW4UixUtArIn8hN82vI/DDsv5mDR24k=;
        b=tph84VbVfqIhaEBlGNutH+ig+tV4NGcpivR2iLMf1wvqndN9U/ob8w4Dfbs9Bh2wh/
         31nL/KaFB0qXkiOanYw9yp4XJPY6DFe6OCWWX/KUxxJKNi6an7VUrhkviu2JUsprMqNO
         plnRKPGd4ndPgwqJQV+vqx+VVed7iMmvXG3vPImasw2eY9Pp71IOThv9yuZftUoJluhH
         44t5JLLJOo3cS7Evz2Bgxlc+ZX8Ind+gSJZlwnlZHMnjdMXkoI06pTbaAmk0UpJfpAwS
         9HQOpPDL58nry83uU3m5UIQdQOTZUlS1cdMp3e1ALDdxVMil144fvgMsulSURJBer9lR
         h+Nw==
X-Gm-Message-State: APzg51AruKCvp1y0zLL1miA0lbKKpf5s083poIhB4MmDnoFKpc7tMVsw
        1P3SLd/ez/g6jDlzU8W57q9jAzPu81+KFptDd1E=
X-Google-Smtp-Source: ANB0VdbusTkQ7hb8DrRmP0KXD3vuida4mJOaGgJVgkhnEneoWsgJvH7dIcpRy3B7nJ09jjPx5rTH/QSWs00VbvIIaZM=
X-Received: by 2002:a02:604b:: with SMTP id d11-v6mr3085895jaf.61.1534862640894;
 Tue, 21 Aug 2018 07:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180820193007.GB31020@aiede.svl.corp.google.com>
In-Reply-To: <20180820193007.GB31020@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Aug 2018 16:43:33 +0200
Message-ID: <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 9:30 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > So many times I have carefully cherry picked changes to the index with
> > `git add -p` then accidentally did `git commit -am ....` (usually by
> > retrieving a command from history and pressing Enter too quickly)
> > which destroyed beautiful index.
> >
> > One way to deal with this is some form of `git undo` that allows me to
> > retrieve the old index.
>
> Yes, I would love such an undo feature!
>
> How would you imagine that this information would get stored?  We can
> start with adding that and a low-level (plumbing) interface to it, to
> avoid being blocked on getting the user-facing (porcelain) "git undo"
> interface right.  (Or we can go straight for the porcelain.  It's fine
> for it to start minimal and gain switches later.)

Yeah I'd love to see "git undo" too, but unfortunately I don't have a
clear model how it should operate. Which is why I still hesitate to
implement one. :P

All I have is something close to how undo is done in an editor, where
we could save a list of actions and corresponding undo ones, but
editors are wysiwyg and we can't just let the user undo, see the
result elsewhere and redo if they're not happy.

> > Instead, let's handle just this problem for now. This new option
> > commit.preciousDirtyIndex, if set to false, will not allow `commit -a`
> > to continue if the final index is different from the existing one. I
> > don't think this can be achieved with hooks because the hooks don't
> > know about "-a" or different commit modes.
>
> I frequently use "git commit -a" this way intentionally, so I would be
> unlikely to turn this config on.  That leads me to suspect it's not a
> good candidate for configuration:
>
> - it's not configuration for the sake of a transition period, since some
>   people would keep it on forever
>
> - it's not configuration based on different project needs, either
>
> So configuration doesn't feel like a good fit.

I think it falls under personal preference (yes some people like me
will keep it on forever in fear of losing staged changes).

> That said, I lean toward your initial thought, that this is papering
> over a missing undo feature.  Can you say more about how you'd imagine
> undo working?

There is not much to say. But at least to be able to undo changes in
the index, I made two attempts in the past [1] [2] (and forgot about
them until I got bitten by the lack of undo again this time). I guess
I could push for one of those approaches again because it will help me
and also lay the foundation for any git-undo in the future.

Once we have can restore index, undoing "git reset --hard" is also
possible (by hashing everything and putting them in a temporary index
first).

[1] https://public-inbox.org/git/1375597720-13236-1-git-send-email-pclouds@=
gmail.com/
[2] https://public-inbox.org/git/1375966270-10968-1-git-send-email-pclouds@=
gmail.com/
--=20
Duy
