Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAA6C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 22:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiCPWZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiCPWZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 18:25:53 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2D17A88
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 15:24:38 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so4387375oot.11
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M3rCqEDRJtKdkkMabjp/TsNXQG0O66uUln0nE+4PYMs=;
        b=jLYJDVUAkGFxmRSV/aLiy7kgAJiH/A1duVHcZApQpOf6jhLIGrsNKIilz9SnO1YbiP
         2GEe9q97ab+bjrIn07kaAYIwI6wXHhlUoD5l4uiTPtG/gsnDh7cP/OdBgAhp+IfVGh6z
         rqKGt2EmvhNQWft0dLm65NFTJOt/axLTeNDGVxW5C2fI9Q8Aq0FkTkh7I/DY82j6E8kY
         l88m2wzNSkmmf6JDxADClE08e43Mec4xs9NPs6XBPJQQASezv68aiWiKc/XUMOwgTBu0
         640NdJmPn+CZkzQCz5WqgW8N/rERmqn+L1HdAevJTwibJjQoV89kkAzI9zGPFTIK9Fzk
         TRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M3rCqEDRJtKdkkMabjp/TsNXQG0O66uUln0nE+4PYMs=;
        b=nK6vRFvp0cM4WvDKg8qCKbfBJydJrd3Ier5Yt1FF19jtwbhHhy7wE5MkvYvpgRMBc7
         +0YmMRMfoxXvr0dl74hAROXXLucQMS0PiR6vxWqf4fIsrH/3L/cV+8m0s74iu3a9bFAE
         pXcgxjKRPskOfNaaWKaMSorPpo1ReFc+a79I1NwfHg8DHfXZQcJalVlQbJvMkqBg01Qi
         FJ5LS2cDHzVVUED8CNKsJbj2S4mH7dvhjEhUYfJFkzdrTVIm9jwRMCL7GSSLd5H+U2M/
         fNPVT4ERf+YSlexOsjoLQhXD829CFLOVJSuK1ba74tzJbwFHBplFSjPYJ96MxSpXxEoa
         I/ng==
X-Gm-Message-State: AOAM533y3pnaRUzDsyr1LIR4ZCTlrPxNEYG/HSMMGkyG7rgUNcCESgCv
        sAoU3X82QUp9K+Os185kI/1i9HSf/1pm3IJwPr8=
X-Google-Smtp-Source: ABdhPJzYarWZ04cAlcSakzwFWy+i7dbeE8bCBRGbiKtjewI4TaV9seEsD8kHvWrtmHBSxrR1XXP/rgHAJ24w9QrVC98=
X-Received: by 2002:a05:6870:f71d:b0:dd:a49b:60bd with SMTP id
 ej29-20020a056870f71d00b000dda49b60bdmr696421oab.217.1647469477610; Wed, 16
 Mar 2022 15:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220316140106.14678-1-gitter.spiros@gmail.com>
 <20220316140106.14678-3-gitter.spiros@gmail.com> <220316.86czimdkb0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220316.86czimdkb0.gmgdl@evledraar.gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Wed, 16 Mar 2022 23:24:26 +0100
Message-ID: <CA+EOSBmmK0hEfgiYiSgzGmBVuib1rOZsgd8yNPLxonJ0Lj3M_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-curl-compat.h: addition of all symbols defined by curl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mer 16 mar 2022 alle ore 15:49 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason
<avarab@gmail.com> ha scritto:
>
>
> On Wed, Mar 16 2022, Elia Pinto wrote:
>
> Per the comment on v1 I really think we should not do this...
>
> > This file was produced from a modified version of symbols.pl
> > (https://github.com/curl/curl/blob/master/docs/libcurl/symbols.pl) and
> > by manually adding the previous comments describing the dates of releas=
e
> > of some curl versions not currently reported in the symbols-in-versions=
.
> >
> > To do this the symbols are listed in the order defined in the file
> > symbols-in-versions rather than as they were previously inserted based
> > on release dates.
> >
> > Most of these symbols are not used by git today. However, inserting
> > them all starting from an automatic tool makes it largely unnecessary
> > to update this file and therefore reduces the possibility
> > of introducing possible errors in the future.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>
> But more generally, re your reply on v1:
>
>     In the end I did not understand if you think it is worthwhile that i
>     do a reroll of  the patch[...]
>
> Better than a re-roll is replying to outstanding concerns about your
> patches. I.e. this, which still applies here
> https://lore.kernel.org/git/220315.86pmmndmre.gmgdl@evledraar.gmail.com/

Yes, sorry, I was going to do this, but it was a tough day at work and
I could only try to redo the patch. However, I largely agree with your comm=
ents.
The biggest work is what you have done previously in trying to
simplify and rationalize
dependencies on curl versions.
My patch only extends your work by adopting the curl maintainer best
practices for doing the same thing,
although I had to adapt them to the schema you introduced.
But I don't see it as a problem. So my patch does not introduce any ad
hoc version of these dependencies
but the choice made upstream, which I think may be worth in terms of
extensibility and future maintenance.
Initially  I wanted to release the tool I made to produce
git-curl-compat.h indeed but symbol-in-versions has no information on
the release dates of the various curl versions and even if a symbol is
an enum or not: so so i left your comments where they were

That the biggest job is what you (or whoever gets to work on it) have
done working on the git source is no doubt for me. My contribution,
much smaller, just wanted to enhance what you had done.

If my patch is completely useless or not I leave it to the git
community, including you, of course.
Anyway at least the Junio fix I put in the other patch I think is a
good thing anyway.

Thanks and sorry again for the delay in replying.

Elia
