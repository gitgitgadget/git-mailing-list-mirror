Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6761F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeGWRFQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:05:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51075 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388144AbeGWRFP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:05:15 -0400
Received: by mail-it0-f67.google.com with SMTP id w16-v6so2298772ita.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd5+KOFe3RNybLNctH29mVaBDADsl2esis1TDWpWzb4=;
        b=C8HAJNE2IE95xzQxvvqJMtcUruQ6O92AYHY4N5PmPd8fdHKCqZMZ0PntmfVyRRvCIZ
         UtdNKHY/G1pVZRat+DWni12DzF3dPVKdeGEt7NXDZe9WK/aqxDC7uWqfn7DFQw1cNPUF
         4F5HfMJiLti+4gD1WU6zoQSrz8MbPrXNdB1DYc9DFHoZE3nHezSUDjFJyNXm1ZQvToMX
         9ADEJDrLiD3yHNPe8v6K27/7slGFuEI40q2gcrUjcnRFDbe74q7NATSVkTS2xzG7GwOh
         ZxNgGK0YZt2niZ/dyVK5qHRveGNuaql7gu5O91pPyv6BFM8PPXuFa9/KxUdK6Tv59mYG
         louw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd5+KOFe3RNybLNctH29mVaBDADsl2esis1TDWpWzb4=;
        b=Crtosv7PNu9LG2DINcVqMjQtB2LHveXGvXLpNZcB81hyIYWEPciGssu8vhjEbNPyMn
         1piuFji86IoQhDlmDUNnkfEqe6JvmiaAMd/edZEa8RiH1OJXB9tbwSNeHTOxPkMcuoOf
         SstChGe6x27F0RDWxmNTBzBPoAfoxk/4W3QU2Wc+yPC84T5UId7Cgcw/BubAL0RoG8U7
         OwS2x4AfVgYzrohso3yCKZCO36fXihUaK5dbspKdi0aAUsxtDC58S1aEnzzRLgvcL85I
         qZ7RMNxsGjosP05nWXcN7MXFr23mMw/kZjDhjW5WeYyHXz9aFfNfH9xLjo3om4q9OhQC
         Lgmw==
X-Gm-Message-State: AOUpUlH3diHCBN+iREPUQImc33jdqxfGkAWzXDVtTRcOPoGoj8vDWOse
        Gvu9+3zyfxr3MnEBbPArf2rITCw2SMkRsNlJrOi4cA==
X-Google-Smtp-Source: AAOMgpfv0FjPKh2/WHqNAd1BfL/PCRzjCit9isZ04rVKlJaDkTbjbZ2JD5cOX1U/vMqwuG4i3K+rNIz6rqu3UQZ3//o=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr10332088itf.121.1532361801695;
 Mon, 23 Jul 2018 09:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <20180722095717.17912-3-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-3-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 18:02:55 +0200
Message-ID: <CACsJy8C8RK6HkfoEYJGZg=sgtJS0WksHD3=7Souw3jYebRo=Sg@mail.gmail.com>
Subject: Re: [PATCH 02/14] format-patch: add --interdiff option to embed diff
 in cover letter
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:

> diff --git a/interdiff.c b/interdiff.c
> new file mode 100644
> index 0000000000..d0fac10c7c
> --- /dev/null
> +++ b/interdiff.c
> @@ -0,0 +1,17 @@
> +#include "cache.h"
> +#include "commit.h"
> +#include "revision.h"
> +#include "interdiff.h"
> +
> +void show_interdiff(struct rev_info *rev)
> +{
> +       struct diff_options opts;
> +
> +       memcpy(&opts, &rev->diffopt, sizeof(opts));
> +       opts.output_format = DIFF_FORMAT_PATCH;
> +       diff_setup_done(&opts);
> +
> +       diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
> +       diffcore_std(&opts);
> +       diff_flush(&opts);
> +}

Is it worth adding a new file just for a single function? I haven't
read the rest of the series, but the cover letter's diffstat suggests
this is it. Is interdiff intended to become a lot more complicated in
the future? If not maybe just add this function in diff-lib.c
-- 
Duy
