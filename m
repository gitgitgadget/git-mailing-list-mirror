Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FC11F406
	for <e@80x24.org>; Fri, 11 May 2018 02:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeEKC1Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 22:27:24 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33369 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeEKC1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 22:27:23 -0400
Received: by mail-wm0-f51.google.com with SMTP id x12-v6so1118363wmc.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 19:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hOLIQmWaeXXKh2ddn01g/AsKmjHYkaDUAsntHZ8tyUs=;
        b=ccp+psTQazK3+x7k8ofM32RpmwmmchcvBxdUUvdQJa21iI29TQ4byAGYmM72l+03L3
         sfRyDp28mBHkius5TTLOKvmCOu7cAoMKnAJxOvkSFTwJJJtKLixxtNjVGiUEQAS1ePsH
         cjVMIe60xk++1qsCGP33Wo1jagT9nHRnmDc1D0JH/+/+4nDK+V4omX3RC4wa0xSldfO7
         Awt4fZE8utydZLU/KdR+XeEjSsOH+xcIjAIgb68Evoq4OG8MqD03DPv8xc8BAalohqRV
         JUfWsQ6aOS5RKV8Fm01NbTkxCLNB6ozms9DKPfm0rhM7f5XlDzYu0mMONcC9XMzNfDd3
         r8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hOLIQmWaeXXKh2ddn01g/AsKmjHYkaDUAsntHZ8tyUs=;
        b=ckRP5PAm6bj+bEUOPnJ2pXYojf37h3k2TOCOmYbgoiihbNFbHGnZUbLGyfwWNjX8Zo
         kB85C8h9Bjzgrnw4hk/+xh+bROpMbU2TSEOhybXVKBTwQ8ed9NOzRnEGmilvzPq6npYo
         54JHPvJIMLs3pZyu1UKjOovBJmf3fDPVnV8UDVYqGAQbSG3TG772BNb+E2EexAfX9Jh6
         pEHhp9kou/7SBoWkBBnezMrEeKsA3SaIPjRKM+L3UKiRAwFx8s51rrZ7cIqQRKXi1SxY
         3BlVRI/3AuihFbkGqFYvAIDg+4ZPY8HtHvSqhelo9v3PL3yt2Iu3n607K//oD2J6jOTK
         GlWw==
X-Gm-Message-State: ALKqPweZNIIHzVjjybyPS3oKCYT9XZHnf+q3wPtuyUHVvscl+n6wzskO
        5tozkWbjV1euZ7vZkiYCLAo=
X-Google-Smtp-Source: AB8JxZru1fjtAp1M+5itRZhrZeRBIx6N/j8ktDZ2H+lAVQ7+PxM4MTpgtwVWvSCkmp5BhO4ryrrg4A==
X-Received: by 2002:a1c:8fd3:: with SMTP id r202-v6mr600307wmd.103.1526005642512;
        Thu, 10 May 2018 19:27:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 19-v6sm3346711wrz.7.2018.05.10.19.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 19:27:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Bryan Turner'" <bturner@atlassian.com>,
        "'Git Users'" <git@vger.kernel.org>
Subject: Re: [Best Practices Request] clean/smudge configuration
References: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com>
        <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>
        <001401d3e899$60cf3930$226dab90$@nexbridge.com>
Date:   Fri, 11 May 2018 11:27:21 +0900
In-Reply-To: <001401d3e899$60cf3930$226dab90$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 10 May 2018 15:59:12 -0400")
Message-ID: <xmqq7eobhqpi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> What if we create a ../.gitconfig like ../.gitattributes, that is loaded
> before .git/config?

You should not forget one of the two reasons why clean/smudge/diff
etc. drivers must be given with a step of redirection, split between
attributes and config.  "This path holds text from ancient macs" at
the logical level may be expressed in .gitattributes, and then "when
checking out text from ancient macs, process the blob data with this
program to turn it into a form suitable for working tree" is given
as a smudge filter program, that is (1) suitable for the platform
_you_ as the writer of the config file is using *AND* (2) something
you are confortable running on behalf of you.

We *deliberately* lack a mechanism to pay attention to in-tree
config that gets propagated to those who get them via "git clone",
exactly because otherwise your upstream may not just specify a
"smudge" program that your platform would be unable to run, but can
specify a "smudge" program that pretends to be a smudger, but is
actually a program that installs a keylogger and posts your login
password and bank details to this mailing list ;-)

So, no, I do not think in-tree configuration will fly.
