Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD92D2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992846AbcHEVny (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:43:54 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35307 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1951269AbcHEVnv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:43:51 -0400
Received: by mail-io0-f179.google.com with SMTP id m101so311286676ioi.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:43:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xXkzVdWnbPyYA11vPsndWgD8KrT28gFIjDamIbG7rw8=;
        b=KgZ/vD0mXntnE0hB/T23Nco8G1lKUCIExKkG1AJ5rM36ua09RO1n2Fs4AZ0dpFU/oE
         DDoMENgWsuR29/eLAufuWGDKZvLUJjShbrmAxTBdi37DJvQixefh8nOZbI43F6Ieyxlk
         mxHfPnMID4BK8r5mbTDeWcDOGu2TTHQYmOAaA7HAePZ3L+f5qbr3zAgc+cNCUz727OdX
         EXRaA32YRBuZCHNyTu192Gj8iToC5I1uz+hgVDpj6Vd75o9vqndyTO8vBwwgaHgf3F05
         3lEkG/uaQqtMK9myB7ZO+BvHr156g9EBsWLpHMUsuLbelglQASSRSd87QmpV2IJHGh9A
         gGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xXkzVdWnbPyYA11vPsndWgD8KrT28gFIjDamIbG7rw8=;
        b=licm5302dlusVKZT0tRIWZCyKhgEXJulME4pqTlH/AowQXJUkv35LJxDN/QgPYy8u7
         NdC0NRjHhxoTwE7riUXZKkW5upHBGE56xHYDOkvO0pHDPvCXoEvR/Hyi638LfUKO3ev3
         jRh4AGEnVqUI06unmzVjlBjzajM15WtI6CS4Z5kP5NC6OnuVTPCpnxCrJ4yURIOKSrP/
         aucOqWHWE/tpPzZvpm2mXlZ1XY31GopsB6dtN1rVN3Zg3r2edCG1WAeOqbrTk79+a7yx
         Vu6i3JCpaMMM5mAA8sMKHKjQKDbpBhcWHo2VRwCGygJ13RQPqqkvl9gUCRwLTgNo1Hwa
         V/Tw==
X-Gm-Message-State: AEkoout3bDkRdfoRwPP1fs26OZdz2N8CxvpuJgtive0WuijfARyzJChHewngRpftrENDfWB3fwXULH3p6seuLMwp
X-Received: by 10.107.178.129 with SMTP id b123mr82605825iof.83.1470433430071;
 Fri, 05 Aug 2016 14:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 5 Aug 2016 14:43:49 -0700 (PDT)
In-Reply-To: <20160805211434.54mtaw2cty4gaxsr@sigill.intra.peff.net>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com> <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
 <CAPc5daUr7OgFeefbwWLWFt3KW_9X-ijRmHa2oj0--zY4fqt82A@mail.gmail.com> <20160805211434.54mtaw2cty4gaxsr@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 5 Aug 2016 14:43:49 -0700
Message-ID: <CAGZ79kb2aO80csCfV=QbH8D1spdNLdkTCSPriZ8W9nSy6T5QAg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:14 PM, Jeff King <peff@peff.net> wrote:

>
> Unfortunately it is hard for me to test a one-off, as running it locally
> is a complete pain. Stefan set it up long ago to pull "pu" and email out
> the results from their central servers, so I just scan those emails for
> things that look like real issues.
>

I am glad this provides actual value. :)
(I tend to ignore the emails nowadays as I am focusing on other stuff.
I'll get back to down the number issues eventually, I promise ;)

Running one offs is "relatively" easy.
I did that for other projects once upon a time.
Here is my script to run the build:

    #!/bin/bash
    . .profile

    cd coverity/git
    git clean -dfx
    git fetch --all
    git checkout origin/pu
    git am ../git_strbuf_stop_out_of_bounds_coverity.patch

    descrip="scripted upload scanning github.com/gitster/git pu"
    name=$(git describe)

    cov-build --dir cov-int make
    tar czvf git-${name}.tgz cov-int

    curl --form project=git \
      --form token=<sekret> \
      --form email=<my mail address> \
      --form file=@git-${name}.tgz \
      --form version="${name}" \
      --form description="${descrip}" \
      https://scan.coverity.com/builds?project=git

    git clean -dfx


You can get a token if you look around, e.g. at
https://scan.coverity.com/projects/git/builds/new
and the email address is the one you signed up with
coverity (or the one from Github, if signed up via Github)

I am currently applying one patch on top of pu,
(id: 1434536209-31350-1-git-send-email-pclouds@gmail.com
I can resend if you don't have that.)

I am running this script as a cron job, but it can be run "as is"
as well, you'd just need to toss in the one-off test patch.

Thanks,
Stefan
