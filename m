Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA347C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DA061391
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbhKRBlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbhKRBlI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 20:41:08 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55064C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:38:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id i9so4679161qki.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=90+pTZfqu7kEoLlQfSABCTx8ROdKWbFmK49S6DZDeD4=;
        b=auWO6ZZj4pQ077eeK0kStWemCvXCMeZ8LcTAFHtlTifuM4C+xAVUV5ipJy0HU0T9+Z
         gCQtmPEbaN4Ix/Je9jWkd/SE8CM6sGENTa1Khreu+hrYhZks/50mrTFze9Y1oH/m0iIS
         E6ZWBTag6Z7fpGk2Sh2VzioBaeZe21QnS8hdcq3oxqhZC3hHv0cU++RRu45GWijJGAUQ
         KjQqSqtDUPDx61Qm067BhyaOaERiCX4VA/UL1X+rQuNrJQP97Zi++Ht/jRTRmHvraDis
         ZcZMttbOEepkE300ZNzzuppkbzU+7Ilfe+HJ9SEFPfu5WMI1Os0di4zm+L/BF/lWeVm9
         wPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90+pTZfqu7kEoLlQfSABCTx8ROdKWbFmK49S6DZDeD4=;
        b=7yubAKuE+HsVWcgOWAnXBo0D97qi5duTkLGNkF3fN2K5wdUvGAIzEQepBFViXDbSF3
         w2Ht4rKowAd4qwX0XumeVP0j/vFMKFH/wc/bnVNPKFAlEk9rc6/k/SX1aVAYOUggZw7i
         +EwGlJ5ijRL8wPIqO9ohQlIthbWzL7s0I4JGYelsOLQX5vQnhuoiKJz7M6er9Nm9SYgj
         eZqrfjqWfTIbsxcE4c0Aa30tH5Ks/L18Am4DXmLr0QckMCmJxukJ4IMEvVqs3LE4HBLa
         hcx7jq6jbEoVQAfz4dfTUn3hn/Amm1xPnqHvhnN1kAc4aBgUMzhWSMEw1DydkNOenWhx
         F6lA==
X-Gm-Message-State: AOAM5317gDNLbPyH2A2Gzc6h2PwiKb3LsM/d2PMoUod/qyoCfosv3b3X
        BeDURSqIdvoDnY/ligiQEiz81j2He77ztnMQ5jc=
X-Google-Smtp-Source: ABdhPJzfkKlZmrEPq0SjXvgAgm+YM21STN/CuixBq4mIspjuzoHaVavXlKr7ADgUEEM3RSQnkoffOA33KYXWI5xUTjQ=
X-Received: by 2002:a05:620a:c4a:: with SMTP id u10mr17190514qki.69.1637199488561;
 Wed, 17 Nov 2021 17:38:08 -0800 (PST)
MIME-Version: 1.0
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email> <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
 <YZVB5hy4Xuim5K9B@nand.local>
In-Reply-To: <YZVB5hy4Xuim5K9B@nand.local>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 09:37:57 +0800
Message-ID: <CANYiYbFq-SAq2VLcFFX8P=Y8-JzjqW63mJqTuOCgO+q+Zzf=DQ@mail.gmail.com>
Subject: Re: Need help in understanding how to submit a patch
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Philip Oakley <philipoakley@iee.email>,
        Etienne Guillot <git@etguillot.fr>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 1:54 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Jiang,
>
> On Wed, Nov 17, 2021 at 11:21:49PM +0530, Pratyush Yadav wrote:
> > Hi Etienne,
> >
> > On 17/11/21 03:47PM, Philip Oakley wrote:
> > > On 16/11/2021 21:15, Etienne Guillot wrote:
> > > > Hi,
> > > >
> > > > I found a typo mistake in the french translation of git-gui.
> > > > I did read the instructions on this page
> > > > https://git-scm.com/docs/SubmittingPatches
> > > > but I still not sure where should I push the correction.
> > > >
> > > > Thanks for your help
> > > >
> > > > Etienne Guillot
> > > Hi Etienne
> > >
> > > The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at
> > > https://github.com/prati0100/git-gui
> > >
> > > Not sure what the latest is on contributing translations (not covered=
 in
> > > the GitHub Readme..).
> >
> > I usually ask people to post patches on this mailing list and I review
> > them here. But I make an exception for translation changes since they
> > never get any reviews anyway.
> >
> > So I am fine with either a Pull Request on GitHub or a patch on the
> > mailing list.
>
> Since Pratyush is the maintainer, does the po/TEAMS file in your tree
> need updating?

Git Gui is a standalone project with its own workflow. The file
"po/TEAMS" is only used for Git project, so I am a little confused how
to update this file?

> I'm not sure how up-to-date the file is in general, but the last commit
> was made semi-recently back in August, so I assume that the entry for
> the French translation is outdated.

French l10n team is led by Jean-No=C3=ABl Avila, and is very active.

    git log --no-merges -- po/fr.po

L10n for git-gui are maintained by different people though.  Because
"git-gui" is merged into git using subtree merge strategy,  I cannot
find commit logs of "git-gui/po/fr.po" using the same command, and
have to find the original git-gui commit, and find commit logs from
"po/fr.po" (which is quite different file from "po/fr.po" of Git).

    git log 8a383db4b2 -- po/fr.po

--
Jiang Xin
