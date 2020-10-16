Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75281C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5E22078A
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbgJPByo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 21:54:44 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38452 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389091AbgJPByo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 21:54:44 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so882223ejc.5
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 18:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIrdVYCKVsyTifehVxLpW+UyChOwCYM5OPrFr7P+tiM=;
        b=ZmfxU9UCSH9v+b+b/smGSA6Z+IhGTGfxZFhpfp074bnDsq+O1T3Xh6YNEjwkhmLnfu
         U4G72TYD+tyz7ZvkJXqBzK9dF/iCnCd4qx+VwtJQyXwFuHwAU9GuqDAwv9ka5aSa+x3+
         UDWxRsj1RkRgleKG/PSQ8gsjs/JhH4DWDXqKz2/+iXA6CSSXQdbkHsC1ZrLPT3kAY/9e
         DF/63fTk5DXewnIlca4SGGOXRWa0mEERDZkCZlD1DqE/ffkeSAUGkARiccqacTsSOxFN
         v6uwA7c4aoQAZztQo70I0LUU0XfTpCdlpsu7eB/Hljcy1X7dJg1jns02peL8tEd4BiSn
         eMEA==
X-Gm-Message-State: AOAM531UMFCQ/vjYi2WedfBzgQHg9hUMdgw5CdtO8c3ttd5aqKTv2un3
        JccT59RwRqzHBaI/SyoqBr2y4ogM8wJekObqi+fabdTvk7s=
X-Google-Smtp-Source: ABdhPJxvbRMptzGPuloxg58meEoOXkSEgoutO5nV1YDygrVUHbdJz7FflI6NQ9R/dQf09AC+hMTx9kvvaageYoaqSXk=
X-Received: by 2002:a17:906:7016:: with SMTP id n22mr1371344ejj.402.1602813282591;
 Thu, 15 Oct 2020 18:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201015215933.96425-1-bkuhn@sfconservancy.org> <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
In-Reply-To: <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 15 Oct 2020 18:54:30 -0700
Message-ID: <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Documentation/git-commit.txt    | 13 ++++++++-----
> > Documentation/merge-options.txt | 13 ++++++++-----
> > 2 files changed, 16 insertions(+), 10 deletions(-)
>
> Since the changes are exactly the same in the two files, maybe
> a preparatory patch that creates 'signoff.txt' and includes it
> in 'git-commit.txt' and 'merge-options.txt' would be a good idea ?

I actually think we are OK with two duplicated and leave that for
later clean-up. The more important would be to polish the text into
a good enough state quickly.

Another thing we should not forget is to update our SubmittingPatches
document. Since we are placing extra stress on that there is NO
inherent meaning in "sign off" and it is largely up to each project,
we should set a good example explaining what it means to THIS
project to sign your patches off, and SubmittingPatches is the
document to do so. Without such an update, I think the update
to these two files we see in this patch is incomplete.

Thanks.
