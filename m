Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F551F461
	for <e@80x24.org>; Mon, 24 Jun 2019 15:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfFXPCu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 11:02:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44411 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfFXPCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 11:02:48 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so37223iob.11
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcFcAN2NVYyFNl9vCTq3yy1RWWN8bghdt4G3UBBsBaU=;
        b=sBv3UEpIzJPotW21tdwGLCqKy3ypuzvsSmqMrxYMs47r+TdEk8YZUrgBS+eEDZ3l7O
         cSmTC0ETm5fsIosjTc68Wf0qbojM391LZyu89HKCA9s5PuoIv8xZFc1BiFHp9hM5xo22
         Oc8lmdaI6afnxyPqnsvtkthOM5S8MsPwQxS1+Ys8mKCq4gbHwKzfxDsyEIoJD/+cYSlP
         NW4qaRh0VyNp6F6NceZO8tmQzgUz1FBRrhsLSLFKk/MShPH0A0BWKAbIAvfFzRJ5gxEP
         I36qW7qIbgKrbyttGIIvRzS/pQ39ut8IHyoxeH8fYpGHKYs8VLBXvTqoTJiLUmoKGuMV
         +doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcFcAN2NVYyFNl9vCTq3yy1RWWN8bghdt4G3UBBsBaU=;
        b=GVxHcDlzjAsofcLjann4httF91NmxpaWnDnpcEsy5DVENIMwzQ7EaA+bW4Qve+3Mfr
         6sUX/WXojs4qTvmWVtiNsCuXqqtiMpUrfXZqqy44ale/AtEd4j4O9JBpO1HhLWd15lzP
         NT4MyKRzzptVFwnYjJNQDkGSEf4/jnCw5re7bpUbnW72qnmM2rM7TZ1sm7JMQeSgPzTD
         JnqNCsmGi1vsS2AABGXLwO60SIgPdGd1aXYPMmE5KauS8XaKrzMRd+Pwhe6dSOXZj6B4
         256Tf3V4LmUFQhoJP72+T1KMpLq55eZ4YH2NFlyIHCGR5Ej1y1qsR//3fj+9Xo1D6yND
         WYEA==
X-Gm-Message-State: APjAAAU4jjdHj99BYAWxhFg1lVwJI2tV0aM4qLXpiQljp76ZiIn+UR4m
        j23rcJsBHCt1lVTxZXgfcVYnGgq4yzpyyTtkpdk=
X-Google-Smtp-Source: APXvYqxyHnSszxHWSPEbduE3vp4ECfc+EsG3adc+lW1fw0kHBQMF0PrNlBf392KAwvpnNN/8U+z0olkyFo6JHNeBlkQ=
X-Received: by 2002:a6b:b497:: with SMTP id d145mr61365764iof.17.1561388567915;
 Mon, 24 Jun 2019 08:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190622122417.28178-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906241251040.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906241251040.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Jun 2019 22:02:21 +0700
Message-ID: <CACsJy8DOAWw7TSi1jPqSNV-41h8R6nUAjVC+osTjaDpmxnPa-g@mail.gmail.com>
Subject: Re: [PATCH] rm: add --intent-to-add, to be used with --cached
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 5:52 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Sat, 22 Jun 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > An index entry serves two purposes: to keep the content to be committed=
,
> > and to mark that the same path on worktree is tracked. When
> >
> >     git rm --cached foo
> >
> > is called and there is "foo" in worktree, its status is changed from
> > tracked to untracked. Which I think is not intended, at least from the
> > user perspective because we almost always tell people "Git is about the
> > content" (*).
>
> I can buy that rationale. However, I do not think that "remove intent to
> add" (which is how I read `git rm --intent-to-add`) is a particularly goo=
d
> way to express this. I could see `--keep-intent-to-add` as a better
> alternative, though.

Oh good. I also dislike --intent-to-add for a different reasosn but I
didn't bring it up: This "rm --intent-to-cache" removes the content
and keeps ita, but there's also the potential use case to keep the
content and remove ita (e.g. you just want to undo intent-to-add
effect, but if you have already staged some content, leave it).

This case is about the worktree. But "git rm" is not designed for
that. It either handles both index and worktree, or just index. "Just
worktree" is delegated to system's "rm". But system "rm" can't do
anything about ita bit. And if we make "git rm --worktree" do that,
then "rm --worktree --intent-to-add" would be a much better name and
should not be taken by this patch. But "git rm --worktree" is not real
to even start a discussion about that...

End of rambling. I guess what I'm saying is, --keep-intent-to-add is a
good name (that I also didn't think of).
--=20
Duy
