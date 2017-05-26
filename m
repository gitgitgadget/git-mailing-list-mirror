Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911441FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948426AbdEZQOW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:14:22 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36161 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948413AbdEZQOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:14:19 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so15623577pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zSRkiW1smiiytYMTS9J3HCCG6qlHgHwMPeK0F044R8A=;
        b=j7hnaA9ousAcxpWFVlzPAzv/IJEYcCk6WCMPnj0Q7COSb+9GYeg2JDTG31gXS4mmFV
         X5xDu/xvE8y5TpUg8aIIMizCkbowPcyP3MGQcGD4pwNfRS8hkI3KpuPtG7LP89v3Fi31
         e3hoc2mxpjs4E4r/kehrTISK1TwxNwESf96qfkA0LCvhPVI8/JeapAjPUIHrh1nWVkDL
         P9aWJSrigKtEKgkSjXRQv7lB+sMKAs9RVDnSkzeRewbEAk2mP0cdvpdoTOIetd3dvOV+
         RKzvGFYhOMn/vXbJQqTliVxPk/2o/gUSUpglcV4+jayzP91X4TkCmutYWvd9TiDGHiGx
         qnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zSRkiW1smiiytYMTS9J3HCCG6qlHgHwMPeK0F044R8A=;
        b=hlmfxIpnoaikNEcn9JD2FGuHY4dfoEoYUf5QLiUbIpTdu/xTfv52UWZ9Oj7qOOSmxk
         dKnHf3ryGnxSYIgdfFdn2DS/LXoFu80ih+XDcdZwjn1R4tbelOmwiKtMdM+/4udWxPnv
         HE4P88bxJ4Ue4bbGAHw72ty+IGK+nyRPFzLPFLvACQi8GKpCb4JFwgmr3pmDF0FHza1X
         XMzVg6/nYw1+zCHXi/TvCP7hgzKiioZgPHEfEo3+sIytC3RYInxgZ0sbWuUAvyR9pXie
         NQOZCGf6vcx8IE+a+nsrBbymGaUyoFcXkKXT4qEBdyhic4910FhBVhy/YU6W6BTQYw4Y
         kE8w==
X-Gm-Message-State: AODbwcD66nbfDIlsOrgxImwwsklF55N1sGEkcRLoutxOCvSD8KHj5dTB
        mdnTO0W3yKkL5FAxp3BLMyVUMciXa9NR
X-Received: by 10.99.116.7 with SMTP id p7mr3349811pgc.162.1495815258686; Fri,
 26 May 2017 09:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 26 May 2017 09:14:18 -0700 (PDT)
In-Reply-To: <20170526151713.10974-3-pc44800@gmail.com>
References: <20170521125814.26255-2-pc44800@gmail.com> <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-3-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 May 2017 09:14:18 -0700
Message-ID: <CAGZ79kasjuXBD8GmAF5n9Fy6WUbPsQt89th=k2tm_+KeV2ss2Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 8:17 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule foreach a builtin.

Cool. I reviewed the code and only have one minor nit.

> +static void runcommand_in_submodule(const struct cache_entry *list_item,
> +                                   void *cb_data)
> +{

> +       /* Only loads from .gitmodules, no overlay with .git/config */
> +       gitmodules_config();

Performance nit: We only need to load the gitmodules file once instead
of foreach submodule separately, so we could move this to module_foreach().

Thanks,
Stefan
