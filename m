Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D94BC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhLGVRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhLGVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:17:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470AC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 13:14:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o20so1003433eds.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 13:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrdIZIBJPqewt+JZ854+iBry/OHdukheBVBHQfFTrsk=;
        b=MTQ4KJaN/X2/CyRjsnk33MzqCCXHJKwxo7knOCki9yiS/bCgXe9G87hE0I8otN3LRT
         TIYmzg1y3Uqe/mgAMv+XwHEvzSaDsdmCi1i7Zcrv0TPzL8Msw5qLYw6j13M5wN9ErMbz
         K/UOQJHKmFCgrF4grS3+lGH8kZvuNqVCkoVS4OXSlltAsUpa+42ugbR+jqvJzXUqt1vd
         3gPWWipPD9yjQYDYKg77LaEdxkA6Cfo4sKlgCBYl6jHOosICRwS3EBB0nEMTH3XTDQRy
         fQ66tb0F60luNcHcq8yMOigr7r0WdjjpArevADRTnIKyzEf1KmQd1Fb62LRYm8oQAKOh
         4iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrdIZIBJPqewt+JZ854+iBry/OHdukheBVBHQfFTrsk=;
        b=WbA9BzhFo+d54ZQNpI2+p2Gq6EHTNhhl1ihFSxREh2qLxxOWQsLRdc7GTLExEzJAds
         uCCImU3uBPn2ajm06l3NrVTwpwbzuhh9ncUOGxJMO37VC45IeK4v8UK5/Sw7r5TnsZAz
         uN5cRj/ASpOfFkQg0PkIDadglJb0Y/T47v7q+Na4NKkekGt5q3WhgPdnmQEhmD4+tb43
         uv1gg0jhFtz/YTAzq01l4+ITcaEq4CfK4d0WT4aX5beHheTORfZUUAA/AE7AQuYHskKp
         BSFhwlnNC+veliK6ZAE62AIm5c+J3plmz9MUdv0jP6vyJIhs6J7f2piwRxdUV/11RMpa
         WUrQ==
X-Gm-Message-State: AOAM531MRD+dxsaaWa5xkKSRynoFFxV96WmlBWPVquO/QFq0LLM35CL3
        GqcyO2k+Et3cE3IFMMaqKHPGtUjZ9maZ6jgb4w3I6Z2a
X-Google-Smtp-Source: ABdhPJwrzv5DOdJstIQr3v1Ckfen7qtO2cWmVubpeyHbO7rBlkkkUpQO8BMYJ+20jPcXdnMNWPXM3h2AJerRXNU6KWg=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr13235149edf.72.1638911647626;
 Tue, 07 Dec 2021 13:14:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
 <7c2a8b0e-a387-1166-ea02-e5792537aefa@gmail.com>
In-Reply-To: <7c2a8b0e-a387-1166-ea02-e5792537aefa@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 13:13:56 -0800
Message-ID: <CABPp-BH1nb0XBgNbLLrmbtoK6UfJHgeTwQvDPVn2RcaUKddNzA@mail.gmail.com>
Subject: Re: [PATCH 4/6] git-sparse-checkout.txt: update to document that set
 handles init
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 12:42 PM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
> On 12/4/21 12:00 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
...
> > ++
> > +Historically, `set` did not used to handle all the necessary config
> > +settings, which meant that both `init` and `set` had to be called.
> > +Invoking both meant the `init` step would first remove nearly all
> > +tracked files (and in cone mode, ignored files too), then the `set`
> > +step would add many of the tracked files (but not ignored files) back.
> > +In addition to the lost files, the performance and UI of this
> > +combination was poor.
> > ++
> Super nit: Perhaps update '`set` did not used to handle' to '`set` did not
> handle'.

Yeah, that sounds better.  I'll wait a bit longer for other comments,
then send a fix for this along with any other needed fixes (even if
just included Acks & Reviewed-bys I get).  Thanks!
