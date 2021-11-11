Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B8C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155846124C
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhKKUUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhKKUUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 15:20:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379FC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 12:18:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v11so28785788edc.9
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeqQnAcgxDsVKGRVrSW74u96e0e7Bze1unAn+GgANuE=;
        b=MSHuecxlDuUQSSxYRk0O9022BwSnvKjIzh+2RTXqSrcIBrbenmE0vaDSfXO4+AHZ+1
         2M9SiGxYdeDlytgFp+ja3VWpGPV8o9+p2iqdyAb7GQTgxHRiYukclU2rFzfkRq5+5hYQ
         gR9sv8iDloW7vTCdtJRkcQCMVv8mGlM3ZrtUrHRtWgo60oDj9QItDdpluC6EFDtVH+qa
         Lg7Ggc9HkxfVOyycGOaScCrX3yU3I1GiyGljPf2JxZ8td6LI21jsccW6mMhvLSehGVoE
         ncZq/ScKUUtCRc9bb/kak9UFD9h4y3guY9uE955EWEgG0HhG+Z0IgLwl2RjTTe8lGK//
         tBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeqQnAcgxDsVKGRVrSW74u96e0e7Bze1unAn+GgANuE=;
        b=dY2ZcMRDlS6MaEBiEQloI4CiEgBwaIQQV3HhPV7f9jNQ6ma9sRBEUu1z4EAUbm5JuJ
         97JzCL5d18gxPzQRThYxeAl1UDbIhx/UFTRqqX/6TwF/5/EnvJNHKLRQnXZuDrSttKMz
         bvZ+6jaC3NGFTQTTcL7moMJvYkjt+cLlz6iuBK8Sh2t+3yZFOcTmZijFdgGvXUnBXlQV
         s6tsW8gGm+R4Oyi7mMi7PzB4TFPl6CgeQNdLWKScdqFFL73UbUIT/iP2K35EBIPFMXot
         i5SwAjXCiVI7SL0QLfDnfmNjbI1lS/IoaMlyYYRlQ7FwUizgV//gnva8AUIu3I8TT+Uk
         A3fw==
X-Gm-Message-State: AOAM532O/NIpT7MK+cWumCMDNE3UNlcKM9OnqW7Kx4oj4biT568WIw6d
        E5rxylJ1tZVvtWDWQQaJBScBfYuzVdyaMhdLJqX1xhpK
X-Google-Smtp-Source: ABdhPJxCxNsYJoRmrs3cQa2tLlOvIsvUC+V3keJxq2E6GY/3KlZT4axEs3BhEQ8vr7uptscoqE4WzWSly/mU13UaSp0=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr13233596edv.62.1636661878733;
 Thu, 11 Nov 2021 12:17:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1073.git.1636526490570.gitgitgadget@gmail.com>
 <xmqqo86qmvnr.fsf@gitster.g> <CABPp-BETy2=J1jNsS_pPpby7Z1P0Yfp92eekMLRicaA=YCL8tQ@mail.gmail.com>
 <xmqqbl2qlam4.fsf@gitster.g>
In-Reply-To: <xmqqbl2qlam4.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Nov 2021 12:17:47 -0800
Message-ID: <CABPp-BFEo3T48aXW9aas2FJufPp-jf0O73k3JsoTn1=+6cLcpw@mail.gmail.com>
Subject: Re: [PATCH] RelNotes: fix a couple of typos for the upcoming release
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 12:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> + * "git pull --ff-only" and "git pull --rebase --ff-only" should make
> >> +   it a no-op to attempt pulling from a remote that is behind us, but
> >> +   instead the command errored out by saying it was impossible to
> >> +   fast-forward, which may technically be true, but not a useful thing
> >> +   to diagnose as an error.  This has been corrected.
> >> +   (merge 361cb52383 jc/fix-pull-ff-only-when-already-up-to-date later to maint).
> >
> > Is this worth calling out in the release notes?  I thought the
> > discussion elsewhere on this list pointed out that this bug did not
> > exist in v2.33 or before after all, but rather that it was a
> > regression that was new to the v2.34 development cycle.
>
> The fix itself (i.e. "git pull --ff-only --rebase" when faced with
> new development on the other side) has already been described in an
> earlier entry (the third one in "Fixes since v2.33" section) and is
> in both 2.33.1 and 2.34.0-rc2.  The above entry is about what "git
> pull -ff-only -rebase" does when the other side lags behind us,
> which should be and used to be a no-op "already up-to-date" but the
> earlier fix broke it.  It should be in 2.34 final, and if we were to
> issue 2.33.2 later, it should go there, too.

Ah, I missed that it was in 2.33.1.  Thanks, and sorry for the noise.
