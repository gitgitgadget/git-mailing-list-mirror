Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5B01F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 08:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOIHU (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 03:07:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41612 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOIHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 03:07:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so8432964wrj.8
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 00:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ssvXUHcKrWu07gAN1qhpi+J18C87nSl4JU4NwSDIRs=;
        b=pTDYj6FX+HvCbaKlyZmkkyt56i7YML+OMjm4H1ABN1ylJzkwbUh3mmoDinile0JOBk
         8ybtipwLC1TQrUIc85XrUt35QyMfRGM+v4DZFgBP6h7bnn8RpU1/vr2Z3NsWx/q5D350
         PO1V7VHK8K+Emr7Q/l2EORn4A7cTQ1n9Kivxxm23AlS+KMwSQYjknGKPotD0w9gvoyl+
         suj/X81zU+PfmH7wb3M/YQGKWBlCzynWcQPZjOjYvkZfnacoFes3pzo2o07zTWLUM7xx
         rpEyLnTdjcpsBSWRsbvP2kiUT7a7T+kwl0jeGnPwzrsGrpaw8KpPmJaFiNRYmcy1I3N7
         e6yA==
X-Gm-Message-State: APjAAAVuM2fGXa84+YKbEPvdwhE16pS6v0Rk80iCciJJL1bmLb5hFbqw
        7ftbXCTgNWZxGyNx2CEImK0Ai1AWJjV4bdzLY28=
X-Google-Smtp-Source: APXvYqwBQOW/dUeI5PKW84C7TRGlZrj83ycuue2+V8F5Jgvpy43DjRqtGtYnZtJSKRPHYJDmY/13r5We/Jhb2wkIc0M=
X-Received: by 2002:adf:e70d:: with SMTP id c13mr13946563wrm.78.1573805238418;
 Fri, 15 Nov 2019 00:07:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573241590.git.liu.denton@gmail.com> <cover.1573764280.git.liu.denton@gmail.com>
 <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
In-Reply-To: <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Nov 2019 03:07:07 -0500
Message-ID: <CAPig+cR1Fbk0esmTRiTS8Zn-PAVPtEJ5HmaaDkT-EZA5f=KOfg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] pretty: implement 'reference' format
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 3:47 PM Denton Liu <liu.denton@gmail.com> wrote:
> [...]
> Since this format is so commonly used, standardize it as a pretty
> format.
> [...]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> @@ -63,6 +63,16 @@ This is designed to be as compact as possible.
> +This format is useful for referring to other commits when writing a new
> +commit message. It uses the following canned user format:
> +`%C(auto)%h (%s, %as)`. This means it will not respect options that
> +change the output format such as `--date` `--no-abbrev-commit`, and
> +`--walk-reflogs`.

Missing comma between `--date` and `--no-abbrev-commit`.
