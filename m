Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19DC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948636124B
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhFIJ32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:29:28 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:33544 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbhFIJ31 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 05:29:27 -0400
Received: by mail-yb1-f177.google.com with SMTP id f84so34605236ybg.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YC8Cb6866xwehTe++B8y+A2S2EnqQ1ktoskesT+3h9g=;
        b=TmeLQmmo4DjD6iUicEExxi9ZBhhBHzqFx64nNzefZrYx8FHW8vPfma/69hGBnG4jWv
         5/v77uylxhV1tjQt/bl5cyft1KMVeLWKciIAS0Uf6PbOSb3UPp66CrAL9vrlhicxKv3D
         5TF31iVkYLQipq0lXywLPEv3sMivG5atNHJaoRmfvPlyFJbdz9c8HHBS1Pk5FWl2M08I
         f5zdoKd3dEDXcMBQ3U6Wbp7jb0vx/gC8ibfpdTvrKel7EKFiCiomV+kvbyYWpyxTVD4C
         6ev+8eKp452hT+yVlwpPcImJce8XEf+95hixDBNI5bOzNxE/js2+8evRUPpVqxoeWnuQ
         HQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YC8Cb6866xwehTe++B8y+A2S2EnqQ1ktoskesT+3h9g=;
        b=s20aUHEW5yjb8GIRJ4mkw1Z6FwjJTjwmHwzqRUoUauoNFzjpT0FQ6MMCK/dTQdZHqb
         T2QGxVVNXUDUn5byL5P7pYr8MrseOWTDDmKr4mxKBUu73H9Dg3BXdSJi7WzcCTajrDot
         gBMMn0BY0O7UY9ZO+/qMvyAGYeXfNe6Zl4F7mfQ2mB1fNCia+0hV2JH7CU+TMKCGl4po
         vrHx63bfC1U1Hw/cUreglqm0vyVdxPnbQ98xNDmRbQAvJTH5mqg4x0ILq8TZ8Ok2gBsZ
         tgoNjASh5LGhQFIfDZTO2sasXsTzHTKnEv5iKcA3fYMSq83bFLPMU8rupykRH/2jmDz0
         lJhg==
X-Gm-Message-State: AOAM530FelMvd7+WnsgkleQ6a0EHEfuVRy0lnEoEj+9ARMGxqbsSqKLP
        Xpb3A9nZmu2XWD7xWi0NCjmxIb+G4NOjZgrD7Ew=
X-Google-Smtp-Source: ABdhPJyvbBuVcfX+cR3GwFTxhTkb0i/vc/1EqPY7Fv5n0YmH7/AZExFVYGw2Mz34md+Js5rDesPHdYg5s035FgzZAnM=
X-Received: by 2002:a5b:5c6:: with SMTP id w6mr37392787ybp.279.1623230779042;
 Wed, 09 Jun 2021 02:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqeeddq7h5.fsf@gitster.g> <87r1hc35f8.fsf@evledraar.gmail.com> <xmqqh7i8ndxn.fsf@gitster.g>
In-Reply-To: <xmqqh7i8ndxn.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 9 Jun 2021 17:26:07 +0800
Message-ID: <CANYiYbH5SUuR9HVtvvhNH7WX3bCWAD8v4RiROyNuFb8qC9mNRg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #03; Tue, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:18=E5=86=99=E9=81=93=EF=BC=9A
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Tue, Jun 08 2021, Junio C Hamano wrote:
> >
> >> [New Topics]
> >
> > Missing here is Jiang Xin's 2-patch series to fix a portability issue
> > with the "git bundle" tests:
> > https://lore.kernel.org/git/20210601144901.31375-1-worldhello.net@gmail=
.com/
>
> Yeah, I'd expect that many things that are not regression fixes and
> that were sent during the prerelease freeze to be missing.  Would
> you mind arranging it to be resent with copyediting (I remember that
> I saw the patches and found them needing some grammofixes)?
>
> Thanks.

Will do.
