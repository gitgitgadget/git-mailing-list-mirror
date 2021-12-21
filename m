Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B828C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 22:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhLUWY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhLUWY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 17:24:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE3C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 14:24:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bm14so837824edb.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HJBzzUd/CMygibKVCmU2nKlQKgw4EWYUuwm+BJ/hvXY=;
        b=JKYqOqOrfgRzh4J9GSmPCd0THG2G3u+kZWNfISClUTOAKAh3qg2Rk9q2eDeDwcUyDX
         5uSixdWJlrwrxhD68E5gI2Cj7LS/ryZ9+VOYTowCecmeCkTKG7tkiOoMhBx18NZrG8HM
         qtK0bINyZ2+BCahn/sGzT0knh+Ie2GlUySCmbAGHsbQm6nnwhRecspZoFzoXwwO2Dx4e
         phK3irwoGf8YZRdnz9OAYK1FCcceXprerxXIdBAzcjOqo78DtmQ35M5Lm1EVDgfYZCHU
         hJ/SzQE/E1bGmpy2Lk+y46h9aiOOyQs6HsQAIPKUQ1ON7sGFz7Aq1wWFziadbY2+maEq
         Zlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HJBzzUd/CMygibKVCmU2nKlQKgw4EWYUuwm+BJ/hvXY=;
        b=VaRETjVtx7JyLAVRP0wF42stZAWUwZmcQGG9r4bwlaibPrwhx3qHtnhxYgUdIjJyC0
         T763+JJSYYYCQux5H+upTPJVLK7CobeaOgGWEbQf+C/xn72Y3mGbY5Npw/RNcJq06/a3
         sQqwgd5V6PQ/+qUa39JsnyUIuy8CfBrj9GfyIWxPR7U4Jhuk4jiTC34QtxRx+YHlhagn
         HTCSMqEwFXBIUWgJ2eHwwHaPBB4lFnfxwLLz8uNdE7QG5qRmH4bg2K6/HINmCLgcTRoW
         j8uLlSRnK8Pk1QxulTAjLrxcDIc6F9lXf4ms2/+jP2j+iqE8WHFidrSkqqkJ54oMDqAr
         ipsQ==
X-Gm-Message-State: AOAM530dlfAner36O9WLUMlC3EmrG6PEizfiAziolruO9sM8nlFFSlyu
        aC56CYqWxnaelhGmS44bK+pEfvOM1Lx2+sfNS8H73iu3Bds=
X-Google-Smtp-Source: ABdhPJyUPDwpLNHgYQdpJ1tfY0fPH65Zkft5WicIgs5WEnMypRvKDm4i7wPxIn4HXUdKAhbQQ36GvZy0Y76USqQ+bUM=
X-Received: by 2002:a05:6402:231a:: with SMTP id l26mr307731eda.175.1640125465862;
 Tue, 21 Dec 2021 14:24:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <4f21969e35724ffac6938beb9e089a970f90c41a.1640109949.git.gitgitgadget@gmail.com>
 <211221.86zgotprz3.gmgdl@evledraar.gmail.com>
In-Reply-To: <211221.86zgotprz3.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 14:24:14 -0800
Message-ID: <CABPp-BHDJMecupic=ybVhzZbRC5=WmY616JQdbfaqw_1A5sMHA@mail.gmail.com>
Subject: Re: [PATCH 9/9] doc/diff-options: explain the new --remerge-diff option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 1:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/diff-options.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> > index c89d530d3d1..b05f1c9f1c9 100644
> > --- a/Documentation/diff-options.txt
> > +++ b/Documentation/diff-options.txt
> > @@ -64,6 +64,14 @@ ifdef::git-log[]
> >       each of the parents. Separate log entry and diff is generated
> >       for each parent.
> >  +
> > +--diff-merges=3Dremerge:::
> > +--diff-merges=3Dr:::
> > +--remerge-diff:::
> > +     With this option, two-parent merge commits are remerged to
> > +     create a temporary tree object -- potentially containing files
> > +     with conflict markers and such.  A diff is then shown between
> > +     that temporary tree and the actual merge commit.
> > ++
> >  --diff-merges=3Dcombined:::
> >  --diff-merges=3Dc:::
> >  -c:::
>
> This & 5/9 would I think be better squashed into their respective "main"
> patches.

I presume you mean the "main" patch for this one is 8/9.  I was trying
to find a way to break up that large patch, but this is pretty small
so...sure I'll squash it in.

What are you referring to as the "main" patch for 5/9, though?  It
only seems related to 6/9 and 7/9 to me, but I very deliberately split
those patches off and don't want to confuse them with unrelated
changes.  I disagree with combining 5/9 with either of those.
