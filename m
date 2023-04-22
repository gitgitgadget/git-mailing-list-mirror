Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E35C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 02:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDVCE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 22:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVCE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 22:04:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D43211E
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 19:04:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a8ba5f1d6bso21949671fa.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 19:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682129094; x=1684721094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57kE9lAOwTE09neWCjTNGG+15Yqi7FMbooSqcG/FHdI=;
        b=nxlO73sYfWP644i2RRc4yAfJQRCsHpOQY1SnTe5E3ETBcQES4ooDs4BC5da7QxJB52
         N8/WL57ZL7ACMbHf85FYfHdJBoBLmcWh8GAqbz9oZZFl4MP9bZVMPGNyNu350pxRI7jE
         PmTbyof/NwZF54ahH4lpmAms5AWAaunfpSR8sXI6QPbsM/3cMXBJAq8sxOFBfiFlrCEh
         1rNmfz77x3SczF9vxAzv20LWlvwJP1JRuSPwnL0c1P/44tOZFtChfDvrhgYRz4R9nuJV
         lFTpputScZnRWRej5S4l+kIphq5nsIjIyXTyq8LMoULW5UEUP9+bIHfHuE1KdlTClFuM
         8ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682129094; x=1684721094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57kE9lAOwTE09neWCjTNGG+15Yqi7FMbooSqcG/FHdI=;
        b=LoJkTPCMoM6usblY5IdgVYPub5ccoAg3DEJ1kzOgfchYLZ7ImxN/+5M1U4D1m5i+sj
         hTE14VEFLeqkjw2RmYQoBxgftKq4vbj9TZyhVY6PvegTdpHa/Fysbr4V8lc5WkpgtJmZ
         IlcSXMbUnO7jojqhhpxQWojOPmKIuS2o+8JB2XBrAGjwzd86ooLTL44hmfiNrDIBdNcF
         aTvYN/cz3sFRq9LNfANHakXCdLNfgSuAkqs1Dv8Adc9XPmsRFeBGkFweawYVPFrHNYEb
         MQZrSgdeuhtmj6irY5J/siIp/RRRloYzZkwNhYPNDl5YGjWuk42i42zIxpgE5n+L7PXJ
         mtJQ==
X-Gm-Message-State: AAQBX9d23c+GKSaQxqDHQ1SzSkWuzSi0dQtJXuYxDe8LjJXGxiYcbpvD
        wIxv2GZQ0xZcQz5PSh1QKmhT0N7rweZNeyfYe2GVuWOc
X-Google-Smtp-Source: AKy350aU7GGEp0v493QEDtLb3aSKFnnmRda80PTT3691NwXN6v98TdMgviHOtXGXO7634qjEofurI1cjiKYvi39i9Bs=
X-Received: by 2002:a2e:964f:0:b0:2a8:dce8:2d13 with SMTP id
 z15-20020a2e964f000000b002a8dce82d13mr931448ljh.14.1682129094209; Fri, 21 Apr
 2023 19:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1518.git.1681974847078.gitgitgadget@gmail.com> <d5c93b5b-32b9-ec50-1661-06f73fa37f5f@github.com>
In-Reply-To: <d5c93b5b-32b9-ec50-1661-06f73fa37f5f@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Apr 2023 19:04:41 -0700
Message-ID: <CABPp-BGVEWM_N3eXjfEGjemeNzrLMmqDOuWKCvzOuHGeMueoJQ@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: fix calling merge_finalize() with no
 intermediate merge
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 6:10=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/20/2023 3:14 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> > While at it, ensure the FREE_AND_NULL() in the function does something
> > useful with the nulling aspect, namely sets result->priv to NULL rather
> > than a mere temporary.
>
> Good call. It also makes the code look better.
>
> >  void merge_finalize(struct merge_options *opt,
> >                   struct merge_result *result)
> >  {
> > -     struct merge_options_internal *opti =3D result->priv;
> > -
> >       if (opt->renormalize)
> >               git_attr_set_direction(GIT_ATTR_CHECKIN);
> >       assert(opt->priv =3D=3D NULL);
> >
> > -     clear_or_reinit_internal_opts(opti, 0);
> > -     FREE_AND_NULL(opti);
> > +     if (!result->priv)
> > +             return;
> > +     clear_or_reinit_internal_opts(result->priv, 0);
> > +     FREE_AND_NULL(result->priv);
>
> Perhaps this would be better as
>
>         if (result->priv) {
>                 clear_or_reinit_internal_opts(result->priv, 0);
>                 FREE_AND_NULL(result->priv);
>         }
>
> to avoid an accidental addition of code to the end of this
> method that doesn't depend on result->priv?

Ooh, yes, that'd be a good improvement; thanks.
