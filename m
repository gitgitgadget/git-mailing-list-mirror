Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91811F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 14:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdKKOH5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 09:07:57 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:56703 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdKKOH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 09:07:56 -0500
Received: by mail-io0-f178.google.com with SMTP id m81so16345687ioi.13
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 06:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9r230v8hzIb7DwtSTcyVjNOPO6oWeAtW69HRUCxmXsM=;
        b=MgjzFWBNjjJ1p0sww0xXoAu5ZOODry7aRMVpdthKaAPKDS56QOpF0fp/U1C0A41Mp8
         m3rAFHan25wYm8txBc+E2tt7/U+e7xFKIypfZQ/wzaWEQ/FcM4dm56UGihmpPtBiiO1V
         F6+E6BmBonu4NQBx6Xu/Lk7rd7B4wnFCGk0i4yCdnZsspOPiPVYOyBtPi4EiWpTSenN4
         LYKctU5/Z9VLOYtnmXfXDaQu3rypuxD9EXQy3Lu7HO4ijO2sPe9iY+eiLn0EjtWTGMpo
         WACFKbcDOCQoqfUjiUvQEe7l6UEDGIB5TqR3nlYWcKuAB79iSbQ08q8FV3F94jfay/ts
         06GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9r230v8hzIb7DwtSTcyVjNOPO6oWeAtW69HRUCxmXsM=;
        b=H0NygdJRcK8Ce7T0BL6uQ0Z5NrcxYknOs6r5OujtLyzZqEbm71bFGxiXxXUhlbNBC8
         avOAkr4q3vVb9NjLGIv6ePLScjkDhvTnAzuW4FTYnJQUOVbu9NjF40B5hz3cuVpCrN6p
         rWSc/dlvsyHwwfrx2fttMwdfC5SAcElkoxNNnaVYKwrOfIPlN+BmDdLjU1QAacSoo21b
         pbv12B19jzn+0V47wpNu29sNM2mjAi6LrVjvyCWdUNqT6mH7oduNWt13ZA7qlWMtWVQ6
         YnKPyxVwiGVWf42lMTZoyPUx2xPhEnSSH2G5nCjBJpGMJEOdVbemCzZh38UqLbFa+mJF
         dgIg==
X-Gm-Message-State: AJaThX7fztOImrPvb0/3ur1bYvCahYp0jgDsfG5x6aYNu5u+AbfbKvJm
        MhE79LldUmTPtU/EWUvWeVAFGBJT48xkT+b4xAA=
X-Google-Smtp-Source: AGs4zMZXPbRL6mcLA0ElN5JiOUqGqlKz3Bjf6MvRVUkDH8O1yWrp8eJU/7UvjDMDap4OoAL3LA8u3CdDIAVReYq5hYU=
X-Received: by 10.107.47.17 with SMTP id j17mr3866287ioo.96.1510409275958;
 Sat, 11 Nov 2017 06:07:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 11 Nov 2017 06:07:55 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 11 Nov 2017 15:07:55 +0100
Message-ID: <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
Subject: Re: should "git bisect" support "git bisect next?"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 12:42 PM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
>
>   the man page for "git bisect" makes no mention of "git bisect next",
> but the script git-bisect.sh does:

Yeah the following patch was related:

https://public-inbox.org/git/1460294354-7031-2-git-send-email-s-beyer@gmx.net/

You might want to discuss with Stephan (cc'ed).

Thanks,
Christian.
