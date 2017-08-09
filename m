Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21211F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbdHIR3I (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:29:08 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33771 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdHIR3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:29:07 -0400
Received: by mail-lf0-f51.google.com with SMTP id d17so31077658lfe.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MnO4UicKcAvDEZWzmi4fm3/h3qahkOmUmIG5v6sL2X4=;
        b=BGOASx01KA7tEoQtkDOwxQAS5WeFUkFHD8k1murnfjOQezcxnGJF0xoQsf90aSaMjv
         ouWJu9WHpIXxA6IdWZSAC2qe+kUMrDnfxKdlTUMdxOVYKJH3CEt6OazfFmwtVy88/GAe
         fo7S3oJrsAq88LowR/zIIynKESTLQSPd3XRGuYjqLbYR6tifxdEhCnfo2AZKOcxKNUSG
         eAj2Mf5JRyeqpK4OJ9cSknEAjQRhSWGm/sCiYJJOLJkfmJape+mhuTbsQOoJR3HhBTuc
         xxFSS0WcIlrCH58BfiNAb9IapY9nJw5OrN31ECoucHZYzjKyHosKIn4JtFB6BlOOkvpR
         mwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MnO4UicKcAvDEZWzmi4fm3/h3qahkOmUmIG5v6sL2X4=;
        b=ntSol3FOgkK6sh28B5dxNuiEyIT+idEsAmP+ZgB/cSDYsswcPv400BN3h6J6ApT2Mu
         T65GLCoXxN+Xkr7ACZxkQbd8MDX7vq7xlSRtOjP3ZWi/Ca/ov0XbM7Qo/4XBgJ+rWZf4
         XRttQ2jKu4yElOKtKhxvRfbM3a5eiQrAmp2BfoKPd96LahVZZb4mLPcmQp3dNGv8Q2Mk
         MlX+5q9BTcfA24uHnz7w7HsP4/iX1tjp9eFzfBmotLObnWy0yGVHS4Fq37ng4bsuFsEI
         1dFC03L6qXq+xsv/vB7N7xdkbKKq9RkDc1N0m44hbnmP513z9gACIYH1DAponpA45cBX
         RW7Q==
X-Gm-Message-State: AHYfb5hcK9ieMb4Th5dckBvHRZvZ2QULK1sqF7NITepatQNNGYWfEc6i
        3GKUAid7AmWD/lUGzMtFdhIBAj4OGhxAuAiygQ==
X-Received: by 10.46.20.88 with SMTP id 24mr2772166lju.51.1502299745461; Wed,
 09 Aug 2017 10:29:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 10:29:04 -0700 (PDT)
In-Reply-To: <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 10:29:04 -0700
Message-ID: <CAGZ79kYUn_V81pRHsAuOoqNOpjfnng2NqLu7jPK93GM=LuvywQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:01 AM, Jeff King <peff@peff.net> wrote:
> As discussed in the previous commit, Git is not well-tested
> with old versions of curl (and in fact since v2.12.0 does
> not even compile with versions older than 7.19.4). Let's
> stop pretending we support curl that old and drop any
> now-obslete #ifdefs.
>
> Choosing 7.16.0 is a somewhat arbitrary cutoff, but:
>
>   1. it came out in October of 2006, over 10 years ago.
>      Besides being a nice round number, it's a common
>      end-of-life support period, even for conservative
>      distributions.
>
>   2. that version introduced the curl_multi interface, which
>      gives us a lot of bang for the buck in removing #ifdefs
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config.txt |  3 +--
>  http-push.c              | 23 --------------------
>  http-walker.c            | 12 -----------
>  http.c                   | 56 +-----------------------------------------------
>  http.h                   | 20 +----------------
>  remote-curl.c            |  4 ----
>  6 files changed, 3 insertions(+), 115 deletions(-)

`git grep USE_CURL_MULTI` also yields
Documentation/config.txt
t/t5540-http-push-webdav.sh

Would these also need adaption in this patch?
