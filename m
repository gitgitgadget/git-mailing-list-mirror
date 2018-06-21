Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041B51F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeFUVWc (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:22:32 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43138 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933162AbeFUVWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:22:31 -0400
Received: by mail-ua0-f194.google.com with SMTP id z16-v6so2964893uaz.10
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I6NZj11LakmXOnunn439mBNUMsTY9yK6DVOd+O84SMI=;
        b=m9ASeiC7e8gNp+pXzRAfFi1T/80LnCc2884sIkFXAjop1/A1zjUR816FLmVEx0cDRV
         74Q/PhvtAWCY2Kuot2a8ABZGNwV/e+L5lPQ9A5HRR1RaTrXVnLtehD/FuP7bQ2vPeKp8
         P1XVeXA7NtMi2pOay9LSLfKnr2pU/zDq2QmeYhxvDThCPMeEWMLKN/OxQqEYQyC7FyZh
         OS78x0KBQm++SNRcRap9S0JldTzMSGmJr+E1vg0UA9ZsiwjP5b3H8aTyWgsEtzZx0q/+
         I0fQB4uRq0qlP66oHXOfzMmh4hoR8WG/Ru0v3kJRwkOTZzljAQUsKRzx5BYoSABZkixp
         ekDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I6NZj11LakmXOnunn439mBNUMsTY9yK6DVOd+O84SMI=;
        b=kKHOmBHCHlf3J0/yGmQYX9Sjnwcn7KyHpSfJYcSb9q2zQXgBL15rqVsKjks76PM76X
         YsUYQ9jQTg5Yu44zLfPVP5+Jrib55l+Wa6y8bRisHfiCe/Ubf+qHuCq8SpsyBe2zBuKj
         RSrQgWxbYd/Gv+HdBC9F2sk2PRWjA7X6XqDnaia7nrSblwSM5bOJgbpMWZBFwZFZN8Vy
         mmLJCsJ7/VZUCcPglYaWAr9mayTY9kchbjHMoJxBDFyAclxuguTFWIC5ei56dexaE+6k
         EFO7g0ElQWIRBLhLKoWmCevI+cOV5+vxmDFs1tSSqBT/58TEn405kgkxNJKFOpSz26/f
         HNeg==
X-Gm-Message-State: APt69E2Zy1mivAe+TruFPQOx8jcGxT3RTiTEobr7jkaBSkTwv6ulwB8n
        k4uOpQN4Fr9VVPlApTlY+jqCKXzenwjLnZZHbZM=
X-Google-Smtp-Source: ADUXVKJjq2rC0LNOlTj3bjsD8Puja4gQUeQa1Uhmwjnm095NzWu/Mdy4/WcEpFMnwBQ+XP8C3TMvCA3UaA+QECmJgm4=
X-Received: by 2002:ab0:84b:: with SMTP id b11-v6mr17573448uaf.79.1529616150147;
 Thu, 21 Jun 2018 14:22:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 14:22:29
 -0700 (PDT)
In-Reply-To: <xmqqbmc3swaa.fsf@gitster-ct.c.googlers.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-7-newren@gmail.com> <xmqqbmc3swaa.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jun 2018 14:22:29 -0700
Message-ID: <CABPp-BH0c-wgjjj7Rzy-KRzKDMc8PLK5GqrGrnCUjzpux4VGLg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] git-rebase.txt: address confusion between --no-ff
 vs --force-rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 1:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> rebase was taught the --force-rebase option in commit b2f82e05de ("Teach
>> rebase to rebase even if upstream is up to date", 2009-02-13).  This flag
>> worked for the am and merge backends, but wasn't a valid option for the
>> interactive backend.
>> ...
>>  INCOMPATIBLE OPTIONS
>>  --------------------
>>
>> @@ -559,11 +549,6 @@ Other incompatible flag pairs:
>>  BEHAVIORAL INCONSISTENCIES
>>  --------------------------
>>
>> -  * --no-ff vs. --force-rebase
>> -
>> -    These options are actually identical, though their description
>> -    leads people to believe they might not be.
>
> Ah, I should have held off my review of 5/7 before reading this one.
> Perhaps we want to do this before the step 5/7 to reduce the churn?

Sure, I can switch the order around.
