Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F1C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbhLVTFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhLVTFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:05:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999CC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 11:05:49 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o20so12300498eds.10
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 11:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HZhKKrSco7s/Gz2Ta+W872NlqhpBf/VCpKSeruKyL4k=;
        b=pUMgaX+QLFuYCTG6iGStemUqTc4pcy1UL1uQthem+zI2Yl1axf4ZqfJOHm4e8wIp6p
         APLc5kWEwyiMHkls902m8yFy6N6cmHybUHsYU1d5A9kZ1pujh2jttmlyPlve0jfXxuz/
         R3owGmr7L5aFuS8zDiQDNFgiYzNO0nbPoWVaPuAHbYgiXCTEMVKDd07HtOoAMhUuDPlK
         vUDWMaaxLg07uCjAZPuOzj75ittL1zU0dJ4s04jwtE0uO4Ap9Y/DGTrXOb4S0Q4U86fA
         n2HhZdoAlXTwv3g0noZfnf2mzd8eXYkgpZ5QHb35KTbY8FZZszQ7yJtZy1HAC0CsgLyy
         xWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HZhKKrSco7s/Gz2Ta+W872NlqhpBf/VCpKSeruKyL4k=;
        b=qlHnwzepB24ow3DzaQcooAhADWmI6DKpSaZpMqBsgv8nHxN4fPcWJlzdcZg/CkXy8v
         eHwrKEFqg9127PKsIQ6oubbf2rXDz1qn41VdkKoin9AqoPWGDGqmYYGBzWLhVRNEA/Nm
         HQFIbDqpMWfjaG6paHbDKx5H4mNcuLZbYzh7P0DmSRAK5xT0WXzQ3fpW+BmQPsLUW8F3
         cRKL2XfN3ihNMd7MhXRZrQ4so9kyL53p+KRFn9vRbXLegFLeHBP28Bc0/QLjrNKqPDcm
         +t6DBexDnOFsfg7hGDkFcaO+VfRLAEz/7MaLrR0mrnRk9FxXaS8N0aHpSr59I/weyYmj
         9ccw==
X-Gm-Message-State: AOAM532DWX+pZE5tYAA1TQHz5vCRZPFyZOrB/otopqdCMNvfCj+BUlHH
        mX+nVec19PAREnCb22btYQZMebtfBRleHDI9VzkesWcI4ls=
X-Google-Smtp-Source: ABdhPJxKoR4NLDKDqC2NRAKAE2ZaBRzdkYFULvwF5S3uG4mS2ZQiybiE36/aXe985UlBhBzCPIp9l405px5u6stll4U=
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr3513337ejc.100.1640199948031;
 Wed, 22 Dec 2021 11:05:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <4f21969e35724ffac6938beb9e089a970f90c41a.1640109949.git.gitgitgadget@gmail.com>
 <211221.86zgotprz3.gmgdl@evledraar.gmail.com> <CABPp-BHDJMecupic=ybVhzZbRC5=WmY616JQdbfaqw_1A5sMHA@mail.gmail.com>
 <211222.86mtktphxl.gmgdl@evledraar.gmail.com>
In-Reply-To: <211222.86mtktphxl.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Dec 2021 11:05:36 -0800
Message-ID: <CABPp-BFmMZUeJaOmyLHPR20XCKF=bj8ZYfZAw13vRLUNJy80-Q@mail.gmail.com>
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

On Tue, Dec 21, 2021 at 5:06 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Dec 21 2021, Elijah Newren wrote:
>
> > On Tue, Dec 21, 2021 at 1:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
> >>
> >> > From: Elijah Newren <newren@gmail.com>
> >> >
> >> > Signed-off-by: Elijah Newren <newren@gmail.com>
> >> > ---
> >> >  Documentation/diff-options.txt | 8 ++++++++
> >> >  1 file changed, 8 insertions(+)
> >> >
> >> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-opt=
ions.txt
> >> > index c89d530d3d1..b05f1c9f1c9 100644
> >> > --- a/Documentation/diff-options.txt
> >> > +++ b/Documentation/diff-options.txt
> >> > @@ -64,6 +64,14 @@ ifdef::git-log[]
> >> >       each of the parents. Separate log entry and diff is generated
> >> >       for each parent.
> >> >  +
> >> > +--diff-merges=3Dremerge:::
> >> > +--diff-merges=3Dr:::
> >> > +--remerge-diff:::
> >> > +     With this option, two-parent merge commits are remerged to
> >> > +     create a temporary tree object -- potentially containing files
> >> > +     with conflict markers and such.  A diff is then shown between
> >> > +     that temporary tree and the actual merge commit.
> >> > ++
> >> >  --diff-merges=3Dcombined:::
> >> >  --diff-merges=3Dc:::
> >> >  -c:::
> >>
> >> This & 5/9 would I think be better squashed into their respective "mai=
n"
> >> patches.
> >
> > I presume you mean the "main" patch for this one is 8/9.  I was trying
> > to find a way to break up that large patch, but this is pretty small
> > so...sure I'll squash it in.
> >
> > What are you referring to as the "main" patch for 5/9, though?  It
> > only seems related to 6/9 and 7/9 to me, but I very deliberately split
> > those patches off and don't want to confuse them with unrelated
> > changes.  I disagree with combining 5/9 with either of those.
>
> I just gave it a quick initial skim.
>
> I have sometimes found it a bit harder to review your patches due to
> over-splitting.
>
> E.g. (went back and looked) here tmp_objdir_discard_objects() is
> introduced in 1/9 but used in 8/9. "path_messages" is then introduced in
> 5/9 and used in 8/9, no?
>
> Anyway, just a bit of feedback. FWIW not just bikeshedding. I do find
> myself stopping at 1/9, paging to 2/9, searching for the function, not
> there, checking 3/9 etc.
>
> I realize this is a bit of a stones & glass houses comment, but I find
> it a bit easier to review things when a patch is larger v.s. having it
> split up in a way where preceding steps don't do anything yet except
> wait for use by a subsequent patch.
>
> 0.02 etc.

Oh, 8/9.  That one could make sense.

And thanks for the feedback.  Perhaps I could restructure this series
with a top-down design instead of bottom-up.  Doing that would mean
either adding functions with an instant-die() implementation in the
first step or just leaving a placeholder comment, and then filling
those things in for later steps.
