Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B67C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D88E610CF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJUMdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJUMdS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 08:33:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF02C06161C
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 05:31:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so205499ote.8
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SwOiYxIsoBnBCkQNhH6d5BE6DzBn/2xj4Pd5HqTIUgM=;
        b=TtxxbvZGDctafVHXg52V6yymZFErQOwxAQbaPGCSxwflj94Ea+rfBZLfRdC9+5i2/5
         f55BHyMpZJMD5wQiSrdnYNvvqnu78JI2qWE5RMr4yvKprMMsSQsGRxlAOd7kYXMer1ru
         xiLYDZOpsmldMM9wu1Ye6yxxvrx2PZqJKgtah5foDUu7mg6q2e+LYZw2n0ddlXL0v5D7
         OLl8q5kHoBju16xOT8db5ortXiIBM8zJgvJ0X3JtH3ANOLs77E10qHE337kA0zzbYHkF
         1Hb8LyqqsoTxMRuinwCiV8zYqr271tJB1QqC9/WOqvGh3AFfyirXyIEzaSFWm76ntRhx
         P68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwOiYxIsoBnBCkQNhH6d5BE6DzBn/2xj4Pd5HqTIUgM=;
        b=HUhdRvZoQexBfl9GZj5pEq9UZ7MuLzg34NBmGlMODihPs9m+scFv9WaA5UXjtBUe9C
         VeL5MAj6bgWG5pJD+hBcu5vixXNfWI9/hC9bJM9SJL2H/f93x3H2SBPfk7rWVCWZuVUJ
         5pe89W9zO+cx2HTDAI1N4r4kQQTLkncEOduzmZSTpkuUX1eNXnczs2k9RHxyMRq6ZiXF
         r6oSi9p1RqsWCYzu/1auUOb30R/DOT1yijrE7BM1QC/KAT1LKGIc4wtUrXWB2frON2vt
         EGOJopEpOIdq5NW0v0Pt5Km1c4dS1hgfEJRhdUynYLQRZOovQ9icbunLrBtqWCLr2F//
         kWdQ==
X-Gm-Message-State: AOAM533XVQeNGorBgqplL9ihuaFBA/Zn9NbQBZxff1V52vlnJW4Ust2G
        k79YLqGlzEiQD3a3OfjK8ui1bOpGbB+AJmT25CY=
X-Google-Smtp-Source: ABdhPJzuz6Pk4XX0EucpX8+TYSNcmMrYr+M1oPyAr9PJpRAxYlao26sVUVbhByzp9GgUfQHP19Kx78A868jc4l2/1ZQ=
X-Received: by 2002:a05:6830:2696:: with SMTP id l22mr4445483otu.153.1634819462067;
 Thu, 21 Oct 2021 05:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Thu, 21 Oct 2021 14:30:50 +0200
Message-ID: <CAL3xRKck=cbdo=7gqv0q=MLjn+5J1ES6fbzHP1mEj90pLdUdAA@mail.gmail.com>
Subject: Re: [Summit topic] Crazy (and not so crazy) ideas
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 21, 2021 at 1:56 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> This session was led by Elijah Newren. Supporting cast: Johannes "Dscho"
> Schindelin, Jonathan Tan, Jonathan "jrnieder" Nieder, brian m. carlson,
> Jeff "Peff" King, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Emily Shaffer, =
CB Bailey,
> Taylor Blau, and Philip Oakley.
>
> Notes:
>

...

>
> * Biggest idea: there are a lot of people who version control things via
>   tarballs or .zip files per version. This prevents history from
>   compressing well. Some people check in those compressed files into Git
>   for purposes of history.
>

...

>
>    * Old suggestion of a =E2=80=9Cblob-tree=E2=80=9D type that allows sto=
ring a single
>      index entry that corresponds to multiple trees and blobs in the
>      background, possibly.
>
>    * One long-term dream (inspired by Avery Pennarun=E2=80=99s =E2=80=9Cb=
up=E2=80=9D tool) is to
>      store large binary files in a tree-structured way that can store
>      common regions as deltas, improve random access, parallelized
>      hashing. Involves a consistent way to split the file into stable
>      pieces, like --rsyncable uses (based on a rolling hash being zero).
>
>    * Peff: you can do that at the object model layer or at the storage
>      layer. The latter is less invasive.
>
>    * jrnieder: The benefits of blobtree are greater at the object model
>      layer --- e.g. not having to transmit chunks over the wire that you
>      already have. I think the main obstacle has been that the benefits
>      haven=E2=80=99t been enough to be worth the complexity. If that chan=
ges, we
>      can imagine bundling it with some other object format changes, e.g.
>      putting blob sizes in tree objects, and rolling it out as a new
>      object-format.
>

I think this was implemented as 'Blob Ref' in Yandex's vcs named Arc.
I was suggesting this to Gitlab folks earlier (1) as a possible solution to
large file storage.

Very glad to hear that it was brought up during the summit.

Cheers,
Son Luong.

(1): https://gitlab.com/gitlab-org/git/-/issues/93
