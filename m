Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCB9200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeECRLw (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:11:52 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:36980 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRLv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:11:51 -0400
Received: by mail-yb0-f180.google.com with SMTP id i13-v6so6750990ybl.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+7ATVaBNXtMKxCbImvV+3Zpp4jY8heqCvaRYKLIrwoc=;
        b=X1euBliiZIl47cEc2Irf+MISfpbMHzlAD4BXjrIro3M3P5YNxOD4KcSZmeerGsXhsW
         QDXwIECf5Uh1O1wzNHQvxHhaTFg+7PVDEAJdg0js3k1908mhFQCSIy67DMv2WFk3jTMi
         fKR9ELE2luNPQSOA0vBDNFdlzCwu4ELQORZoJi98AJnufwr3XCpbKjF8c4lMKFU+dxll
         wTBFCvIbjgthuG/WTpvkoo74hhgutyqHzWAzsTIW3l5220GgAEUcoHyp9gviUfPwL1OB
         FnM8Z4gNmEo6JYDePKy4WzxGJeYV9JtdPEAZXKYs5Yy6bHFvNNPILoDfJuAxJ/wFgPxm
         rDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+7ATVaBNXtMKxCbImvV+3Zpp4jY8heqCvaRYKLIrwoc=;
        b=hGBmoRML0WDH3r8akXXPqvlfilaoTv6VBoRi4Wul+/NguEX6V+kN8teUe4Or5Y+lWj
         1cpwtuU2N44Ty+X5eMM7z8I+9ki/C399HEo11ovU5a3CHKZxIdc6yaOOwtPQqzeHOGdi
         OesR0Rk0gpHaSgOqGmS/7Tv0stD7KRWdl93m3zhHidC9UIWDCSmP/ceHrTpohXooSyGN
         lhG7hyGSImXMS6ig6CFX8YTZpu0wLQocBq/BI7DeSwTU8nochJFYuXf+5OxzmptlU76/
         qtYGQ6D8IzsBL4b34C2ifrhviVErjRjClD5O8qwpo19JATc2pow5K/G02EYInmgyrjQW
         9QYw==
X-Gm-Message-State: ALQs6tCloIzpvnRuJFPOx5+rwU/VsT4pvVBrfmy4O3amWQPrGUbsFGzB
        SjRWbOBF+ygahLkWFLO4EJd1ZMxvL44DhFV+/b0nCg==
X-Google-Smtp-Source: AB8JxZpa2RHfBdj858kcazsJhXvA2oNxhpVuxTDj+YmHNMEBPAPOVsRvB00EwTJFF4KdM0L9N5Erebp0rfSCDxGcpbk=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr13004046yba.352.1525367510754;
 Thu, 03 May 2018 10:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 10:11:50 -0700 (PDT)
In-Reply-To: <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 10:11:50 -0700
Message-ID: <CAGZ79kY_kXpiXScjE+cNWRN1r71B3KkGNGZQjCHpKNe+tdMipw@mail.gmail.com>
Subject: Re: [PATCH 11/18] branch-diff: add tests
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 8:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> From: Thomas Rast <tr@thomasrast.ch>
>
> These are essentially lifted from https://github.com/trast/tbdiff, with
> light touch-ups to account for the new command name.
>
> Apart from renaming `tbdiff` to `branch-diff`, only one test case needed
> to be adjusted: 11 - 'changed message'.
>
> The underlying reason it had to be adjusted is that diff generation is
> sometimes ambiguous. In this case, a comment line and an empty line are
> added, but it is ambiguous whether they were added after the existing
> empty line, or whether an empty line and the comment line are added
> *before* the existing emtpy line. And apparently xdiff picks a different
> option here than Python's difflib.

I think that is the fallout of the diff heuristics. If you are keen on
a 1:1 port, you can disable the diff sliding heuristics and it should produce
the same diff with trailing new lines.
