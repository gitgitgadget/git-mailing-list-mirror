Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEF2C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 02:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiBOCaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:30:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiBOCaS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 21:30:18 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F59B0A4E
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:30:06 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so21515467ooq.10
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GRkaBBtZOT1velp56+qBUpOZH5UeGV756vg1dSc6pA=;
        b=DV72yVabfOZW//cmvafOOet4XI5nndrJEUNxUMJ1fReJiNd6WQkaYQgsxVeTqYgR0c
         gtL1HisCJ2R9DLpFg/NmUsYipfkIkH/cLlikN7mjiPkYtMwWPblOjYARC/wPnj85VPRq
         zlN/Ddh2ZHCkYZkMQzaK8vGihEi6Vr1qTJjhR9369kpM8B9Ef/Wv6j1+GamBUmCPcKB4
         rLGcrjN17YxI7lwlFEBqG50cP6Irf/jojia4h0IKg5FoB6K7r6GBiGAfK6O/y2b5ZO6c
         B1co9FWVvDO8OTGEbdpPCxhI0tjVsY8iO2g8AeuqrtU+yW2jGdDnl+TMNDNhNUrISxht
         HCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GRkaBBtZOT1velp56+qBUpOZH5UeGV756vg1dSc6pA=;
        b=ox4Q8dwDOhnkOcegroaXpnTRG+EZUozhjBd9jfgFbxhyt9nvGbag8OS/3YwEstWluS
         sJXWNVVuhW9lEhAbCA5O8ftqPYc7KcVE8Iy3Cq2jxwq0iRXncF9LHiOWz9L+WglCe4gM
         0MuM8TTCTfHJONsT8Uua3dD+NXC+2BQliyeJsBTcA4qlooBTHYaiDN+ePlJ3srKAvG16
         BO2jYFcFaLWoWO/F1GHo4i0vMAvPZmJ4COSukRDS4aqyXcd+V8mTzHlG387JFRK+gN3r
         8sVb4G+41eDjyCRormp9AQi8lsrr1jZ2U8QpJIUjU+v9N0CT+JfdVmBFRvaSt3o+azud
         XOQg==
X-Gm-Message-State: AOAM532HDfSlPma7kCEwJnXu2b8R48BlKLh+W0E9zWnqaQGmQpB2Vl9/
        b0+k7ZNClOnBUa1evjecHsZ9fzsBf1ZeDHBToQm3QTVCJNE=
X-Google-Smtp-Source: ABdhPJwz5Tw3JPP4zE6SU1rY7aK42bzHIMAx1q9BiLT4rycPR4vpLgDxtsXTHH50ZmTblneHzKyhHqw5d71h+ThZ6qI=
X-Received: by 2002:a05:6870:210a:b0:ce:c0c9:709 with SMTP id
 f10-20020a056870210a00b000cec0c90709mr620028oae.347.1644892205288; Mon, 14
 Feb 2022 18:30:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
 <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com> <e81f044d-8c3a-90df-ff9e-719b613807d6@gmail.com>
In-Reply-To: <e81f044d-8c3a-90df-ff9e-719b613807d6@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 15 Feb 2022 10:29:54 +0800
Message-ID: <CAJyCBOQbreyTY7NxvkU3e06KLh+HXe=tHtDcoN=iFmSJ9H4Tnw@mail.gmail.com>
Subject: Re: [GSoC] Interest in "More Sparse Index Integrations" project idea
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 2:45 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
>
> > But of course, this doesn't show the full history of the work in
> > each of these branches, so you can do a history walk from each
> > merge to get a picture of the full series:
> >
> > $ git log --oneline --graph 3c0e4178277 -6
> > *   3c0e4178277 Merge branch 'ds/fetch-pull-with-sparse-index'
> > |\
>
> Or even better (you do not have to guess the number of commits in
> each series):
>
> git log --oneline --graph 3c0e4178277^-
>
> (see [1]). Why that syntax seems to completely ignore '--graph',
> though is beyond me!
>
> Philippe.
>
> [1] https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltrevgt-ltngtemegemHEAD-HEAD-2em

Thanks ;-)

-- 
Thanks & Regards,
Shaoxuan
