Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A00C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 07:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiEPHnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 03:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiEPHnl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 03:43:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EEF24098
        for <git@vger.kernel.org>; Mon, 16 May 2022 00:43:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q130so17069357ljb.5
        for <git@vger.kernel.org>; Mon, 16 May 2022 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGj7SCRZCaBT+XhfjcfdMScqCquBFaEYJ1FF3j61fJU=;
        b=nETihCauW3FgDBYe/+5rkz13dVPzXA8usziIuU789lO2/bqqdpwbb8+NKQAgUYSWsZ
         beh0aImm/f5Ra8ck+awCG+JkZLCevsaEiNS2LMjrZMxmvjS91mfpQdE/FAUvUttWSKy4
         4CY+AbVVII4e5KUJh+GXy4rqjJ0nXlHVGzKEy1xvm0xU1cHiTFZb/teXsX7BJi2L27EP
         ljQIVdvTUIoFdpbjUEOWoShw7Zryjkwt/QHekoV+wawKEwbJM2ExmAAbw80Az/YirD03
         7x2/WhuzwMQPgA6KsXul7IRU/6iM2b/5uGM9qJY8egLdLORza8MRAXO4jUhRQgrdAUNm
         wp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGj7SCRZCaBT+XhfjcfdMScqCquBFaEYJ1FF3j61fJU=;
        b=k48c55MomZj8em8zzplnKrZgfUHy19pcfOaVgopGMupt0e+Zhbd3DGjrkaeneaglPU
         3RosDcj4LRFtiGVIIge/iI8ir0hOrXOnj+t+GYFfKrzmQmmCT/yiCYyxMpimTvYUg/+y
         h1kMox0u9ElsGW3Yow56P++eUInpvgZigN+54ssOMsIBb3W4CP3xMpyGv3NcPuZYFWfC
         Q2pYChWO+N8LtGDtxojGlSvG7S8ntUcXFOc6Z9efeZ1HQfKigxYE72KBGsZElom21BHt
         F0uRXTvty4wrGCPZqXe1X2jSlFGpPwYiijHdyvIdY9SxUYna//DRT5VHtGvVKm0cTJHR
         khuw==
X-Gm-Message-State: AOAM533rbgmpLTOMe0GqEIplLIGi9q5/IRzPL+Ok6So+H/cOAkdTLWCJ
        AppdhtSXVB0kfwL41spEp9SN+w/ti3aYGlSFI1oCpA==
X-Google-Smtp-Source: ABdhPJwWiE6OFC684RKXGbqRFnbmXJKxOi0mvVRUjZSKFZLcFtAZCkIEXBjRXej4/4Gdm/a3vre9HEFc4yelWs2ueIo=
X-Received: by 2002:a05:651c:b93:b0:250:b751:7d70 with SMTP id
 bg19-20020a05651c0b9300b00250b7517d70mr10555834ljb.232.1652687016414; Mon, 16
 May 2022 00:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <Ynndk0L6r9O7jLVU@google.com> <CAJoAoZ=t=BEfsfHBay1K7CY2MYEwcvPYKYxvgv_BvLL3SMcf_A@mail.gmail.com>
 <YoEnsb2UpDwdjDpd@google.com>
In-Reply-To: <YoEnsb2UpDwdjDpd@google.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Mon, 16 May 2022 09:43:25 +0200
Message-ID: <CAJoAoZnP47PT9EQYkNib9+_a-Qg=HxhjowgUx7qJ1V7=KY5iiA@mail.gmail.com>
Subject: Re: Let's have a user experience workshop
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Alice Merrick <amerrick@google.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2022 at 6:17 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> (bcc-ing workshop attendees again)
> Hi,
>
> Emily Shaffer wrote:
> > On Mon, May 9, 2022 at 8:35 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> 1. Continuing the conversation
> >>
> >> I and some others (e.g. David, cc-ed) ended the workshop wanting to
> >> discuss a little more --- when deciding (1) what to work on and (2)
> >> settling on a design for that work, what has worked well for us in the
> >> past?  What didn't work?  What research methods have we tried?  What
> >> would we like to try?  We mentioned wanting to continue that
> >> discussion on-list, so trying that now. :)
> [...]
> > For all 4 of the above - I wonder whether it really makes sense to try
> > and organize those things asynchronously. If I'm being honest, what
> > I'd much prefer would be a monthly-or-so working group meeting with
> > other folks interested in performing research, making recommendations,
> > learning how to improve Git's UX, etc. I'd absolutely make time to
> > attend such a thing, and I believe it would be the easiest way to
> > organize research and concert our efforts. Would other folks be
> > interested in showing up, too?
>
> Interesting!  I'd also enjoy a meet-up, but e.g. for "3. Testing ideas
> with users" I would find it worrisome if getting user input would
> require reviews on a given patch stalling out until the next monthly
> meeting.  (Reviews are already slower than they should be as it is!)
> I don't know that that's what you meant to suggest; I'm just aiming to
> understand what you mean about the "all 4" above.

Oh, thanks for clarifying. I agree waiting for some monthly user
feedback session wouldn't be ideal; rather, I'd like to see that kind
of meeting establish a process for getting user feedback sooner. Right
now I think it's a little intimidating to say "let's just start
getting user feedback" with no other instruction.

>
> > I'd envision it as something between a working group and a book club -
> > we could learn different aspects of UX design and research, and apply
> > them in various ways. It might be nice to have Alice along for at
> > least the first couple of sessions to answer questions and help us
> > learn in a bit more targeted direction than we got at the workshop.
>
> Sounds nice to me.  If others turn out to be also interested, then
> what would be the next step for making that happen?

Seems like we can go the typical route - vote for timezones and put it
on tinyurl.com/gitcal - but I'll wait to see more people than just you
and I talking about it before we do that ;)

>
> Thanks,
> Jonathan
>
> --
> You received this message because you are subscribed to the Google Groups "Git UX" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to git-ux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/git-ux/YoEnsb2UpDwdjDpd%40google.com.
