Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C611FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 21:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbcLRVp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 16:45:26 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35242 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbcLRVpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 16:45:25 -0500
Received: by mail-io0-f173.google.com with SMTP id h30so139026417iod.2
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3PnrJZ1NgnpXCIe9gSaLRjhDXhdAupA6WtrY+2e4p5g=;
        b=Mw3zfLf03g8CaTh97jLvqZqxDnUDR6UIYJR0nrMQD8KOeqp8Mrt9mdCpwVKpbaVZAf
         hC0HVqTXT21UmFkcUXI6KYlUZS5kFUGX1JeqlP6+PUxvIm9UbGSU89RtdFvCA+x192BW
         CzzZp1kkku9G6S/RuX6u9gAOhavb8bMY9KFMOmIdyTAR+wzGWr75bY5AdgeTvaFXIsFr
         sIr+MrJP9RdFyfzM50bcKfHkhNIYzRGFWMQCoK2o+cLLPBaD0AMsiAC8Jh4Q79P5rKZh
         yFQPfRgULl1t/NoGWTctU9e9YWVU2zoxzJuujhq6CqElVwS843auvFrp3oLWLXoXBb+I
         IjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3PnrJZ1NgnpXCIe9gSaLRjhDXhdAupA6WtrY+2e4p5g=;
        b=p8BiySraGRmUWGAJ9yGX7QEwqq6bkfsknqM/9nuGTavyNUSAOJvPpC7V116llMk1Ez
         qOUyp4Be5WJzbo0SZ49NaZ2/Tn8bDu0Mxj4SB30HcxC5JxNtP7CYhDJ0Nx7NUBU5eaP3
         Xxk0SeO4kkEMBuqdGuVeIEOuAoCqlh0VkJLYEkxTM8aJ0p6i7zYU8YTs/Fakk75nDW6f
         N8y1N598zHWuOr6Tqj5zfJU47dRg5ceM+1e9xZclYPkzGiA5X0gSY2fVSpufx1FXy1yV
         eSIqeO/P324adYxLeAIwLjjlQJr7d3qCWzt9WM783Ebps44mVVArkizV4Vg8XE/6H16N
         OWVA==
X-Gm-Message-State: AIkVDXJQTGb+CYp8R7wmsSZwdcYRiQT6OjZw+/Z82tr6G9JoiHmx8GX2q92MPzTliiXqw4AqYmYbYdJvE+Pr7A==
X-Received: by 10.107.6.160 with SMTP id f32mr11600643ioi.201.1482097524834;
 Sun, 18 Dec 2016 13:45:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.87.169 with HTTP; Sun, 18 Dec 2016 13:44:44 -0800 (PST)
In-Reply-To: <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
References: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
 <CAGZ79kZ=QK5s0_94+4GNs3M5oo49GLm-KkT5K=yZktxX8C4UCw@mail.gmail.com>
From:   Josh Bleecher Snyder <josharian@gmail.com>
Date:   Sun, 18 Dec 2016 13:44:44 -0800
Message-ID: <CAFAcib9-rUSqyBRpauw3pTf9OPTKLYNf7bdh2gyykBNtJTZKGg@mail.gmail.com>
Subject: Re: Bug report: $program_name in error message
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> To reproduce, run 'git submodule' from within a bare repo. Result:
>>
>> $ git submodule
>> fatal: $program_name cannot be used without a working tree.
>>
>> Looks like the intent was for $program_name to be interpolated.
>
> Which version of git do you use?

$ git version
git version 2.11.0


>> As an aside, I sent a message a few days ago about a segfault when
>> working with a filesystem with direct_io on, but it appears not to
>> have made it to the archives on marc.info. Am I perhaps still
>> greylisted?
>
> Both emails show up in my mailbox (subscribed to the mailing list),
> so I think that just nobody answered your first email as the answer
> may be non trivial.

Thanks for the confirmation.

-josh
