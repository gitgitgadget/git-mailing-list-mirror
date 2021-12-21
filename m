Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401AAC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbhLUSXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbhLUSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:23:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96879C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:23:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j21so51092541edt.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2q/O71KyLdXFbYEGAC2Ph9ITUvY9wJi0jP3bjtyNkg=;
        b=HjOQrpiFrIIBS79PEHeGrreMeXJbMiLsogiOQGXMpFolA6/57yQON01sUgSLznuU2j
         IFSCyewORBip7oriF2FZvda2/gzPj+LrG0k1mHxGmIgvPkwdIzCRfpbrzdm2I5Ibfudt
         NjomqlnvbNuHJh7zACX/dmJXqRAJbB83REHpuLNJb3BJ3G9r0qPsNQkyn3rsNn9FElYH
         lrbFX1heRK7Powr6VoWjR5j6i3GvrOMa44RGs5DC+sG1sJk8zkWLJNrV5jhUNzBIQ67H
         4AyZEedF0+uTh9BJ26ciiELHpTKSdmEhnIgSlz5cZ6G4+ml9Sy3PHiAZ5XecXlX6Yecc
         DnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2q/O71KyLdXFbYEGAC2Ph9ITUvY9wJi0jP3bjtyNkg=;
        b=TvKdcdPQtQqNiNb4jDfQCz3rhACdVXJINAo5W3/I2tvgCED1JULm3xyuQY2Yj9AgyJ
         82+b9WBBWGkC3DlpMh49MPI4owE/eq10V66RPuG8QqVoiT0IJNgojSusGpN+V3F9slrc
         m+o9ACfKNgy75kvlXjU9pim8SOOtuE8jHuu1N7jZ79QKJ8MRXMOMGCQJ0NTekI6rh+7B
         SL/wNTFC+ASyrezSGJQExAInDpGFGgG6sE75ZWbISbHMESaP7TltmokaMdNUSeKzJkWU
         PSKiFCTG4oGQVi4i5UH+CrHdQW3nfBnmBosePgmXekdKUavj4uRIPA/pCWCa1FfMH5Mc
         CjOA==
X-Gm-Message-State: AOAM531ttOS/Re9MbNl5nKSROuzEEZhIIjXUfho0lOafaASm67mH5aQr
        41++m5T33oujM4xm8hKFIkIW0Z9Ysc7lYtOOV1Y=
X-Google-Smtp-Source: ABdhPJzvlAbQJKCp3LRS+K9Tyzh2KkvyEbvf6woe41t37jjS4k3wvCHru+R1g3ZDYpGjhsx64PdAQAmKYcZRYf4MPCU=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr3728548ejc.493.1640111021103;
 Tue, 21 Dec 2021 10:23:41 -0800 (PST)
MIME-Version: 1.0
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
In-Reply-To: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 10:23:29 -0800
Message-ID: <CABPp-BGNdonxUafcQd9wqT4X6Eom92teuDVrHsKP8jJ214Z1+g@mail.gmail.com>
Subject: Re: taking a break from Git
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 1:40 PM Jeff King <peff@peff.net> wrote:
>
> Hey all,
>
> I'm going to be offline and completely absent from the mailing list for
> five months starting at the end of December. After that, things are up
> in the air, but I may not be as involved in the project as I have been.
>
> Sorry, there's no juicy gossip or drama to share. I still like everyone,
> and think it's a cool project. ;) After 15 years, it just feels like
> it's time for a break and to perhaps apply my brain to something else
> for a while.

Your contributions have been felt far and wide -- from patches, to
reviewing and mentorship, to setting up events, to just all around
friendliness.  I wish you luck and joy in whatever you decide to do
next.  (And selfishly, I hope you decide to come back to Git after
your five month sabbatical, but wish you the best with whatever you
choose to do.)

I'm slightly regretting right now waiting for ns/tmp-objdir to merge
to 'next' before resubmitting en/remerge-diff rebased on top of it;
it's probably too late now, but I resubmitted it anyway[1].  If you
have a chance for a follow-up review before you take off, I'd
appreciate it.  If not, you've already improved the series
significantly with your suggestions.  :-)


[1] https://lore.kernel.org/git/pull.1103.git.1640109948.gitgitgadget@gmail.com/
