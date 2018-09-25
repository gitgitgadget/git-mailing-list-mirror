Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4BE1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeIYWO0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 18:14:26 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:35314 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbeIYWOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 18:14:25 -0400
Received: by mail-it1-f173.google.com with SMTP id 139-v6so15959335itf.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Y1JLyzu06TaFjTozC0weLP1am7bLiX73yFVXYcsyTY=;
        b=NetsMFNqDeYvZFbQF6xUZ2QhLe51KOCK3svNq7sh9V3r6hMdPY4aF46P4fKNBHAuJG
         NvLa0bMQXr3fQWgZeF31UJgyPYGsFtm/rs78NgCtYfPfULc0ePXWaf6HbgqVf/8Wb7ch
         uqPyXJV/U0cIlJD9FSfFPUrQBgHY4SR2Ib4+VkXLupUqf+d2zUVmkoLknLSrK+5N7PuH
         x6VFOAfZ9MoISxrVDaegYLJnm4DyOsUdq91J180d3NABj/ot4JX5mPra3w22ErHRfC7I
         8A232pna+xazItK1YRcdFhMLlI+faZmC4pee3VUD9AnjWnziR5PtMZs7OW7aIpwsGSJ8
         bT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Y1JLyzu06TaFjTozC0weLP1am7bLiX73yFVXYcsyTY=;
        b=HsgPQgux0p+8NFOx7xvmwVZ4OrhRIMLidqIiOAEyfqIOmm4XVxGOtLSLtZqJZ+tYyd
         huUpN4lgb67xQ+iuChSCDlJHNVbFZAkm8AInOpP8RK26Zeyg5CWvfmJCGwKcCuU+LKYk
         yqFGIAQSQrv8kwT+KCFIu+xclHqA89wiqAUFrKUU50+dw9YNqL1zkp06vIM1kJPoxg+S
         rfZp7BIQVrh33Q6bsod1on/JRvfsvPF/QcvAsIeBu9cDbyy1uHnNfKnuPXGhGmA8KmcP
         dA+n/6nm/iugWnVT2DdSMpO3iKQLVGptPJspWYImjUHW9jHakCkwnA+ciNga3CjAV1tI
         QMJg==
X-Gm-Message-State: ABuFfohqXAflgDNIHUqwN4OJBir04VAtZMBw/ZTsxzlpHliHefQFT0+7
        pTKOtDZMAv6qsscrAoV8xnsjc4vcsz45aoQ8zkg=
X-Google-Smtp-Source: ACcGV61lhzOhccpR0xsQQuzJnL2V2nPw/u0XjpKhYv0/1MFiHDqSzpHrBFgucKh3iQl3SQKRnTX8W66+XaSc3QCisuE=
X-Received: by 2002:a02:95c7:: with SMTP id b65-v6mr1668894jai.61.1537891575162;
 Tue, 25 Sep 2018 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <fd340f7b-61c0-2661-bdca-c239e51bc464@highlab.com>
 <xmqqefdir0tz.fsf@gitster-ct.c.googlers.com> <dbd2dcef-c892-3628-119e-f688e74f3599@highlab.com>
In-Reply-To: <dbd2dcef-c892-3628-119e-f688e74f3599@highlab.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 18:05:49 +0200
Message-ID: <CACsJy8C4+cj=K2NetC05rmwenY0cArQ7NehZZ+Df90fmzBVThA@mail.gmail.com>
Subject: Re: bug in 'git describe'?
To:     seb@highlab.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 5:41 PM Sebastian Kuzminsky <seb@highlab.com> wrote:
> That behavior seems to me to be different from what the (2.11) manpage says:

Good opportunity to improve the man page anyway even if Junio is
right. I agree that the section about "search strategy" is a bit
misleading because it does not mention anything about time stuff.

>
> > it suffixes the tag name with the number of additional commits on top
> > of the tagged object
>
>
> And:
>
> > If multiple tags were found during the walk then the tag which has
> > the fewest commits different from the input commit-ish will be
> > selected and output. Here fewest commits different is defined as the
> > number of commits which would be shown by git log tag..input will be
> > the smallest number of commits possible.
-- 
Duy
