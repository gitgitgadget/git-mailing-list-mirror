Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50889C00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 04:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiHDEFh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 4 Aug 2022 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHDEFf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 00:05:35 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF563B4
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 21:05:34 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 199so4304986ybl.9
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 21:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=flNWFOg7i1W+KkafagwH/3e2rJ26ASIpnEnxg/JvdX4=;
        b=g/+giVlJ7sWbE0gxLgKG6lcbocvFEVtixd4gwcS7ppQ6Q+QLYNLz7DwpcsplvE2nUA
         3L0tEVjYvstDjaj8RQCaC2LSIiVCmtONhA8JT7CXAw6F68XhI8XYgwG/RtfQQbX6bqE9
         t3H1Aise9RIpwrGwdkRnym1RWqixviXN4nh3Tm79yyLz09EytOVaHSPmjb8xWdGXWb06
         6e5hvSsMYpIOS7ll4/q6ggM4fMNsmD+tn27zZC6TmuBVTk0ppFDlojWVma5e51yxSNMs
         qCiGfhDoYtaQ41I9PBiYtaR0s5dYyBvP9HcmNTPvKMyVqMYSGSmXcMzUbffAOUtswkOl
         6++Q==
X-Gm-Message-State: ACgBeo1swPcCqYpGylLKDE/owZpcRb3LyAQOtRzSySp5mSICO04+4u7S
        9E0Ur8J7T9uhMg5zDrlq8lNT3hT53IJa89KXq+M=
X-Google-Smtp-Source: AA6agR4T//TvLgJyEoS+XN9v4XDHmbNJSq9ojWbtGCGfdgo3SlSoYZmx76+Z5WAO/ILMnyGO88tKoH5kMLJN0ZP0A2I=
X-Received: by 2002:a5b:849:0:b0:66e:a027:3c with SMTP id v9-20020a5b0849000000b0066ea027003cmr13085ybq.208.1659585933682;
 Wed, 03 Aug 2022 21:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com> <b5eb110958baa80b72a345b3c850f1dfceabf076.1659122979.git.gitgitgadget@gmail.com>
 <220803.86y1w5g7r0.gmgdl@evledraar.gmail.com> <CAPig+cTUTXuBov4m0xvxehVFbbPjVPrAHAFfPWO5Yv4C9imyaQ@mail.gmail.com>
 <220803.86les5fpfg.gmgdl@evledraar.gmail.com>
In-Reply-To: <220803.86les5fpfg.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Aug 2022 00:05:22 -0400
Message-ID: <CAPig+cSjHf3d6xKT71biR8Cd0iKHqBpQ6Q9_bd_w9Hgg_uE=0g@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] t4207: test coloring of grafted decorations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 3, 2022 at 9:05 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Aug 03 2022, Eric Sunshine wrote:
> > On Wed, Aug 3, 2022 at 2:32 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> On Fri, Jul 29 2022, Derrick Stolee via GitGitGadget wrote:
> >> > +     sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
> >>
> >> {10,10} in a regex is just {10}, no?
> >
> > I'm more than a little surprised that this regex repeat-count notation
> > works on macOS `sed` which, in the BSD tradition, is rather feature
> > poor. Testing it, though, I find that it does work, even on my
> > relatively old version of macOS. However, I'd still worry about other
> > BSD `sed`s in the wild.
>
> It seems you missed it but we already have this code tested "in the
> wild", i.e. the "new" code here is really just copy/pasting test setup
> from above.
>
> So maybe we want to change (and you have some good suggestions here),
> but it's already shown itself to be portable enough. We've had this
> "sed" command since v1.7.2, or 567102819ac (Add test for correct
> coloring of git log --decoration, 2010-06-29).

No, I didn't miss it; I saw your mention that it was copied from
existing code in the script, but I assumed the existing code was
recent -- hence my surprise. Since it's been around so long, I agree,
it's hardly a cause for concern at this point (though, I still
reflexively write the more portable notation as used by `OID_REGEX`
and `_x05`, etc.).
