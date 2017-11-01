Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A2F202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754873AbdKASMG (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 14:12:06 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:51683 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754866AbdKASMF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 14:12:05 -0400
Received: by mail-qk0-f194.google.com with SMTP id 17so3767166qkq.8
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3ks/7AaCkR+BI3tWGBkTKPDc30owvCK3np5YSOmkjvs=;
        b=oQD2bQB+aHX4prabKnCmBt9qaTk3Fen6MFDt9gpDUyxdm7OlRUrU6vOMkpEHX6IDDz
         RiC7VnSRzTqUHWig2uYgsfGaPfKKe9sRhoDO09Rzr5d4KFl+IGIv9Lcztj/jDYpyO5to
         uNDenz4A7uzmED5KMfxNRkWsfZxVhbElMTpLRxXnOS3FoGABwHRg4T/BQUO3hieJXWFc
         44a0CWos0F/solGD0+vYwGrk6OPS/znCYfBFGBIwDDRhzcrkDMVTD2qLQ2BFwE1K5u0j
         UbeAtgjWIMXn9ucTKeueBUsylYcAp/Eh0IQ8LnkEuKFhTVCYjLNV4CzY+cQcOGMoqwdj
         Rghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ks/7AaCkR+BI3tWGBkTKPDc30owvCK3np5YSOmkjvs=;
        b=NiwCsQxdrKTMO1moryLTk01sNQyECpc0jeheKyuhJgNC3oIEsLNvbKqxccH40LddOB
         9e3hmOR3ykspPxaQ7FE4LriSq9jDdbWaGWojxgartKGdiJVtvOZbpI8X6BeGbvnuY2XT
         hPifnzk2rLvTIRB+Sgb6n+XNbHK5u/hLfkERB9kYmwWCrRW7AfNhr1yZcH+YopW6nsZ5
         mSDwIycFoXxOnFVJYHIZsVIs2MB+E7iqR6yK/K+6vBDu8dbzz0cCGptEvJqfK3rULZKh
         TXNUMiXNu005rjowRK2XkgszhpfErm1MlFXt+6pMNqqKKES1gEQI+BTE5yCbGbXYjH8t
         dL/A==
X-Gm-Message-State: AJaThX7Ki72lfGidT9ckxtCDfrTAo9fjwaicDRSeeiJYiSxdbXtnAUNT
        GPR2grIFICmzGzo8VUafWsKb+plKHrG87zAp+3hGvg==
X-Google-Smtp-Source: ABhQp+RILtO4wjmb99krT/49zTTG7kiQEsFCi+YOlmdFcJyh3V56Zlvqj3GsqxyKvnimQEX4ZZu7Er4ulmHpYeX/3AE=
X-Received: by 10.55.18.165 with SMTP id 37mr1103993qks.352.1509559924953;
 Wed, 01 Nov 2017 11:12:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 11:12:04 -0700 (PDT)
In-Reply-To: <q7h97evaxntq.fsf@orange.lip.ens-lyon.fr>
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
 <20171030223444.5052-2-nathan.payre@etu.univ-lyon1.fr> <607ed87207454d1098484b0ffbc6916f@BPMBX2013-01.univ-lyon1.fr>
 <q7h97evaxntq.fsf@orange.lip.ens-lyon.fr>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 11:12:04 -0700
Message-ID: <CAGZ79kbCkj+=tUPL6W48cedSzETsydpHSMkZX=Xn7XnVijpjZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] quote-email populates the fields
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Payre Nathan <second.payre@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Tom Russello <tom.russello@grenoble-inp.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 4:04 AM, Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Payre Nathan <second.payre@gmail.com> writes:
>>
>>> From: Tom Russello <tom.russello@grenoble-inp.org>
>>>
>>> ---
>>
>> Missing something here???
>
> To clarify for Nathan, Thimothee and Danial: the cover-letter is an
> introduction send before the patch series. It can be needed to explain
> the overall approach followed by the series. But in general, it does not
> end up in the Git history, i.e. after the review is finished, the
> cover-letter is forgotten.
>
> OTOH, the commit messages for each patch is what ends up in the Git
> history. This is what people will find later when running e.g. "git
> blame", "git bisect" or so. Clearly the future user examining history
> expects more than "quote-email populates the fields" (which was a good
> reminder during development, but is actually a terrible subject line for
> a final version).
>
> A quick advice: if in doubt, prefer writing explanations in commit
> message rather than the cover letter. If still in doubt, write the
> explanations twice: once quickly in the cover letter and once more
> detailed in the commit message.

Oh, and I thought the sign offs.
