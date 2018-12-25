Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FC120A1E
	for <e@80x24.org>; Tue, 25 Dec 2018 02:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeLYCMd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 21:12:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46748 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLYCMd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 21:12:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so10805395oif.13
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 18:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnITCd6IHb9kDCqf+0u/P2S7bdetT9+m0Q214uVUcDI=;
        b=M3DOlBgCWaIzxZlT5iqjfCFTfZmEvG4tuddOo2r8VqyCEwAieOt9KDt+HoFQbUobRk
         45BvyYK9tWYH83hzKldr+0hWZquMuW82k0RZqO86C3bThWp0IXI3zSCOoeSycSJed3iO
         2VRnALi9XnxOHMPV8KMeiveTrId1xou4u8QO0uifFSXl5v6s3V6Ute6e2SRPOMNxpejq
         IQihQDxFIAQLH9SaKH1dGAh7xw/l69l1SKn2uR4gDO3HMKrZDn5cH6Ab7moyHtiPYLaY
         it3VbD7c/V34EbbWwtGyx/HM2bT3k09Y7trIKMSFpB46mmTwfA4glQiqkgQczbJhSJ5r
         tG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnITCd6IHb9kDCqf+0u/P2S7bdetT9+m0Q214uVUcDI=;
        b=t1hGUQ1IKCsBVP7Pc/Ehaw9uG0xknE8Tw8Ql2l4wIHjnocMqJkYpt4McEtK82J9fPW
         Nr4PaZ9wWvejT5sAQfhrF0XXcqjHawP56F1CDxYYPRtmaVU9J+m3JcGfrynCCjQwzgBy
         7goWVHZL7/5Q0OBhZBgW0DsmbxM/7YiVQyeb6iDYgRMilm0EYBH0W5BMt64Jk7BrPxMT
         8ppW5DzBW3Rn2h2vC3I1N2L7aIBXgvgJOG/2kzaG0nkbub2BHvazLNIzMgrwurOxATyE
         MqFMMNW8xk2WuRrzTL6fy5HjR1fLc/5av8MKaRuG2wsl1Ne+FX0lhVFIDHUe0/lcJX66
         e82w==
X-Gm-Message-State: AJcUukcATMr4xv/XbzmcP0p50eqbPcxR+M175607+RbEHFtrG7HoqSEd
        ltQbQdlT2x6UscQC4Xj6J6S3u52U7X+A2qkL7/0=
X-Google-Smtp-Source: AFSGD/WLWXSGs7SO8TfDoti5U+omSpWvaFRlk3F2XmwUCQCtQ+M1yEG6iXGC6i8BJXmjArMjYZUC7rckqfLgSSF4KWE=
X-Received: by 2002:aca:b954:: with SMTP id j81mr8948638oif.68.1545703952367;
 Mon, 24 Dec 2018 18:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20181219083305.2500-1-issac.trotts@gmail.com> <CANdyxMyz3u+ajH0X7BPJBPBT0iepWhunA_VA+HEGFrurYghSWQ@mail.gmail.com>
 <20181222222224.GA15914@sigill.intra.peff.net>
In-Reply-To: <20181222222224.GA15914@sigill.intra.peff.net>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Mon, 24 Dec 2018 18:12:20 -0800
Message-ID: <CANdyxMzg-RU82Enb5MpBrWSoteHQvw9SmsNiMbTWqBSfqM+ixQ@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got it, sounds good.

On Sat, Dec 22, 2018 at 2:22 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 20, 2018 at 09:24:10PM -0800, Issac Trotts wrote:
>
> > Hi all, friendly ping. Is there still interest in merging this patch?
>
> Yes, but I think people are largely absent for holidays at this point.
> If there hasn't been any movement on it, I'll try to review after Jan
> 5th (it also wouldn't hurt to re-post around then).
>
> -Peff
