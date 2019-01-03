Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E952B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfACVif (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:38:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41051 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfACVie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 16:38:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so38425634qtf.8
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 13:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfNV2vT/A1ucrCka98fIh+2ej7YCQLkNimMzIsPSn+w=;
        b=CJhTprTmanSLPkwoDYGhPva+A0MMTRU9XL9jQe/DW+RYXIOUQwoknYXxsAco0vfVe5
         CEfnTe+g00UKPIfbPoLXHSL9/ytmZRY0T0h0GSEqduoMeIXY7ETpfpjLSR5jeHjaWlEN
         580Ak/Cjh21DCEebGXRMGZ5Y0JpUu/YC8YnFNvwC/0lWHcqgVhyt9sdJd35FVDIgszSH
         6mpvKGgaKaLz4EwdAgAjH9sodSJgLQbQeTJuFTDM7nLoVUuoCPTlJaXHlzp4dHBZ0CGj
         A1SUWl/IcmkBQ6Z+BnLUdT16+1huvHiIXSk+fr4bd3Ze+BXNRAw7e3uaddG6DNv0IuDP
         wbwQ==
X-Gm-Message-State: AJcUukcYPCCg7CEprE4CK9j4BGznbmFdEWpMtBiET9mHopvncsb+x3W1
        cWIu3/yk8eDk1y1IiAZBhkN8A1oNBhUkaHIPR3k=
X-Google-Smtp-Source: AFSGD/XUtG5WhQ5LmOhFCrXfj9+IxfnP0x5fNJfpLjOgA01fSirgkaCvZslW4Z0X95QIDSE3cmQW9VGslxFSoVtN5RM=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr46700585qtx.352.1546551512905;
 Thu, 03 Jan 2019 13:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20190103210351.13920-1-randall.s.becker@rogers.com> <20190103210351.13920-3-randall.s.becker@rogers.com>
In-Reply-To: <20190103210351.13920-3-randall.s.becker@rogers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jan 2019 16:38:23 -0500
Message-ID: <CAPig+cSkok+QttWZTMngCdUrxHiO0rg53M4q=1q1vsewn7Qy_Q@mail.gmail.com>
Subject: Re: [Patch v5 2/4] config.mak.uname: support for modern HPE NonStop config.
To:     randall.s.becker@rogers.com
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 4:04 PM <randall.s.becker@rogers.com> wrote:
> A number of configuration options are not automatically detected by
> configure mechanisms, including the location of Perl and Python.
>
> There was a problem at a specific set of operating system versions
> that caused getopt to have compile errors. Account for this by
> providing emulation defines for those versions.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
> diff --git a/config.mak.uname b/config.mak.uname
> @@ -470,7 +487,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>         NO_MKDTEMP = YesPlease
>         OLD_ICONV = UnfortunatelyYes
> -       NO_REGEX = YesPlease
> +       NO_REGEX=NeedsStartEnd
>         NO_PTHREADS = UnfortunatelyYes

Style nit (probably not worth a re-roll): you lost the whitespace
surrounding '='
