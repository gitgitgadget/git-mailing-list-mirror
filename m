Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6030CC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F020838
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgHNEvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:51:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35680 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNEvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 00:51:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id f1so7212985wro.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 21:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyD8DrtY/1mKazVwyVx1BIGtvqkwTmLjMygln2CNeKw=;
        b=H3WU1sz1pIMrHyOaIkZTPHFrQfmhBKKKj9COZzPTn2GVH/qOmoZbTDgzoIYPKgZ5kH
         dOAeNr9Jp0tXWQC2nYjUE/eEdLZM4wKSzbmdwm5gFu9eFf4zeld5wgS3AJeyenTIifyg
         NREjVJz/oRcyahG5YLgScDbWjbdpEF9cBOUzlGi8VFU+Dg38QmNht/y54kktvMSYt95O
         jqwh3GZPG/ooyZRP+Q02oKkcvNEWfhCa64Lh1tf5Le60kpQnfkkGxNkR2MzavknwPAYe
         qOGuUj9R/i+QXX22vUC56QMrVtkyPoxE4IWfRZrFjzYZ1CJ3j6s8ncUviduUt9hEm2FF
         rGUg==
X-Gm-Message-State: AOAM532MMpfdiFF5+zBKy8TThSEVf42L4I91ufH613iLSWKKu3bBw5zL
        q36RPa6yBxPl3FWIkgAD1Ks52VIw6CI4c5E7UnM=
X-Google-Smtp-Source: ABdhPJy4vLOT3wUH+63R+rIEbePAkchj0RtRZJMaqNK7xryHn/f2dV3vpHAJqYKfsMPlKWrecEdsboTeTq9RDAqkz8k=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr950060wrv.120.1597380679532;
 Thu, 13 Aug 2020 21:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com> <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com>
 <xmqqlfihzvhu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfihzvhu.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Aug 2020 00:51:08 -0400
Message-ID: <CAPig+cTTr8VdzeaPewktdncvnTWHjieEnEPV+vbD=GVbK7zQNQ@mail.gmail.com>
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 12:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> N_("Show blank SHA-1 for boundary commits (Default: off)")),
> >> N_("Blank object names of boundary commits (Default: off)")),
>
> You guessed my intention correctly.  By using the word "blank" as a
> verb (i.e. to fill the space, which should ordinarily contain
> something meaningful, with whitespace instead), I can shorten "Show
> blank" to compensate the lengthening of the message caused by
> replacing "SHA-1" with "object name".
>
> A better phrasing to replace it is of course welcome.

Perhaps?

    "suppress object names of boundary commits (default: off)"
