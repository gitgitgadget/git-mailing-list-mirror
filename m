Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78365C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 00:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiK0AcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0AcB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 19:32:01 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B817A9D
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:32:00 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f9so6857293pgf.7
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhZect4bg1npqN9RMbVwdWcoK1g/jVJm7EV9yk0BvnI=;
        b=lEbFWeRlnm9mmIjVJ8e3ufUkWLW0DU3KfaENTtXAegP53ulJFiL3pf7Rgn+ub+UjHK
         Ym7igU3wuSRPx482OmPtSj84z8EEeRRII4xDH0OJhsq94+etqIk7q5p0WGb9S8Si+kG8
         3fIE8pVCupw9n34rWe5OnJ5MZ7fMm9TCgb82ug3liQ+362RG8u14gDuq3/esCeqdWL8H
         F+vHZztDyfBX1eh6IobxIt3p2iLG8vJwecHCfL0W6ndZmSl03Gum54AKK5JyXU9SG1L8
         mdqk1cO0DPIxuLU5HpySa42JXTiq2n5AXjXATkLiijL/VaJAQ4QhjajQd3jY4p35Xy+v
         J6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhZect4bg1npqN9RMbVwdWcoK1g/jVJm7EV9yk0BvnI=;
        b=3du6AttOiy2ltZ0sZmKuOtG+LM7RGcnpmYjSbP1HQX0cb175zvCPazJWNJAtPSUvj2
         /V4cqPTD/EvpZjAfcWySwqfRAHt4XQCtGQNJ1bwoqsbqyd+OcZ1LOAvSac/8sgnM1mOV
         RAT7kKEsNIWrLCQu/S0jxOpVeXtIyswsRiOw9j0PrZF8L68CYzAkuMyy/pxWNxID4VVR
         MLdxY1AbpYVeXhcC3WDsKyOhNfhMzrahEc0YRYmUyiXife5Cxq6PmWwMQuuXY0y47Wtx
         DquUnt1QzLQgqvnf/yUufD0wrIarOHAa7BZE+JshNQEXMHauCUPjxSsfGWfEKUccypHp
         TX+w==
X-Gm-Message-State: ANoB5pkARI7nXSsY9ttyhaiADLaEvA/Dgh7MROJQCRaon+Z9rqeXY5oB
        PDd0Cpjq6QQfflvxQg+gkjn1Kr3BuNWChJ+2qh1klU4L
X-Google-Smtp-Source: AA0mqf48hXpJSL4cwIGoAR2ITyEGqsdodbocmSy1maFoHOqCSu2ZPP0NLT+VyrxTCrcyKFTYrL3TVyn8MBj82DRYyXM=
X-Received: by 2002:a63:1708:0:b0:477:ba9c:d8f4 with SMTP id
 x8-20020a631708000000b00477ba9cd8f4mr16474597pgl.283.1669509119883; Sat, 26
 Nov 2022 16:31:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com> <446777d300d73498bd7da709fad75731a13d0d59.1669347422.git.gitgitgadget@gmail.com>
 <221125.86y1rzmmfc.gmgdl@evledraar.gmail.com>
In-Reply-To: <221125.86y1rzmmfc.gmgdl@evledraar.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Sun, 27 Nov 2022 09:31:48 +0900
Message-ID: <CAF5D8-uaR-BMoCzGuDsYDbBxaKFS0vzAvWY0mq12vBGtecwajQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] git-jump: add an optional argument '--stdout'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2022 at 6:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Nov 25 2022, Yoichi Nakayama via GitGitGadget wrote:
>
> > From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
>
> > +use_stdout=3D
> > +while test $# -gt 0; do
> > +     case "$1" in
> > +     --stdout)
> > +             use_stdout=3Dt
> > +             shift
>
> Put this "shift"....
>
> > +             ;;
> > +     --*)
> > +             usage >&2
> > +             exit 1
> > +             ;;
> > +     *)
> > +             break
> > +             ;;
> > +     esac
>
> ... here instead, as I showed in a comment on 3/3 you'd need to to that,
> or copy/paste it for every option once you have >1 option. See
> e.g. "test_commit" in "t/test-lib-functions.sh" for a function with that
> pattern.

Thanks. I'll apply this.

--=20
Yoichi NAKAYAMA
