Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5076201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757255AbdKOSiG (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 13:38:06 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:56606 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbdKOSh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 13:37:58 -0500
Received: by mail-qt0-f178.google.com with SMTP id r39so20321473qtr.13
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 10:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RLRzfQ5WY8QvnvS+pbZIDa9AUO9lKICG+3fah/bZp9A=;
        b=NmkBiDqj77wyLyiP+6cgHZZ8dBj90brMjoqASq6+bjvrNTkimdTm+mXKpsZPkBuUrm
         99HYuI0kES/+5q1dQdH4JEpqJYeZxuSoLqHM3nvwcscbQoyWRqMQkXCyGU7hyqotJlOu
         v6crRrs7jSmBEdpbVxKYxf5PcUJr6zDYMDAnMBn0j3GCwNx22fpL+a4+ht9y8hmRuley
         NJLSaglcmJeSyEIPv1q6KoPtLH1Cw8eoUbiKfahSb3nehlWGl/sUV2+1P9v6HsSCSQQT
         uG3ecM1H9TsXZGkbHs20wMXnF8GsZ/EtWmuvN4uG44BmZKLYr4wnfpZftIk2pp5kcpQc
         NUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RLRzfQ5WY8QvnvS+pbZIDa9AUO9lKICG+3fah/bZp9A=;
        b=V52q60TCbRvycWFkSGwdzHnxWiMJPzZ8fbVwVjfKmGzSiVbki2pNnVudF0FnAeTvhY
         5wtHMwXN9ACJRSq+DmAcosX7C8pCFvGNloeGCxXJVU+ZyOcdzrP0ZkwqjLqwGe7RmYkC
         KpgLZAtWu0jUOxQfGvMDYU3XLdpj3LhBLHfk//kKferbgALTOfJFReusGNbIYxcmYBTb
         n4bzm6iyLegAeZDaUB2zJfGkVv9hUBJTJehlMk13ipBvsM21w0aA0I2gIGMcuxN/JRof
         Vd58WhOKMjtzzRpBwOZxH3yJeI3FMvJ9lldci/oWVt7COWgoSJxErjWqOJmRSQIUu0wr
         /6kQ==
X-Gm-Message-State: AJaThX6Cr4GLxH7uuyBuPsZD6IIqE9y3OrUbpQCvwZoBbhxOjRhzc3z6
        bKArq+7S9QEi89eQynJupbwckrY8l8LquSfwYrqvHQ==
X-Google-Smtp-Source: AGs4zMYPVq2NuMqhV5e/qWVvDethc6edpgMC8d5jQX9esPzKAwXhkNdSMfnk5YHp6YIIuk19W/ahxl2NNIaY5v7+oXw=
X-Received: by 10.55.125.196 with SMTP id y187mr27791044qkc.180.1510771076760;
 Wed, 15 Nov 2017 10:37:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 10:37:56 -0800 (PST)
In-Reply-To: <7CF0CF44-3772-48D9-A2EF-E501645A6211@gmail.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
 <CAGZ79kaqyRTaj6=-7Jmb1K6_aSH5-BaEhm7PPyRgJLsHuDF-tw@mail.gmail.com> <7CF0CF44-3772-48D9-A2EF-E501645A6211@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 10:37:56 -0800
Message-ID: <CAGZ79kb4DdV3P0z9qQkHMt9oj40sddfRWdT3k-fMj2-CJkwXiA@mail.gmail.com>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 10:07 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>> Can this be put in a wrapper that opens the text editor?
>> The wrapper would print these lines and then open the text editor;
>> depending on the operating system, there might even be a command to
>> focus on that editor window.
>
> Yeah, that would be a workaround. However, in order to take these steps (write the
> wrapper, enable the focus command) the users needs to understand the problem.
> That's quite a leap especially for new Git users. They just get the feeling "Git
> is broken because it hangs".
>
> Can you imagine any downside for an "Opening editor for user input..." message?

"Wasting precious screen real estate for power users" (tm)
So maybe if one can turn it off, this would be ok? Or even for known inline
editors?

>> Regarding Git, maybe improve the documentation for how to set the editor
>> variable?
>
> The sad truth is that 98% of the users do not read the documentation
> (made up number but close to my observed reality).

Yeah that is an excellent point, but you forgot the people who
look at stackoverflow which of course links back to the docs in
the first excellent reply.

In a way this suggestion of bettering the docs was a cheap way out, sorry.
