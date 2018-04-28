Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19111F404
	for <e@80x24.org>; Sat, 28 Apr 2018 07:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeD1HWX (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 03:22:23 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40849 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeD1HWW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 03:22:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id j5so6432165wme.5
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yqDBfkhIl2rYhcv87Nqtn7vP/ftvOSb34XPtAxjwB1I=;
        b=N7v5s+Glasc0z09NvY6od9CY+5dY1vBkJgY4ccsCJ6hFyw1RI7Pj3eCYdo3aQD0/lc
         00ttfJ8AiakM0yxSaHQrqrWb+AqGphVmr+0NvsmtCbAR2HZLgxEjIVrBihUzxCYe2Zxi
         8YJUOO83FxlF6EpaacAgcf4sNmxrteDKRwlkbhDPMi6gpiyKGW2q+AeXsIVIXX7aZQ7k
         5x6ME8HZc3IAZ4elS6gswh9cNGRxTpX1F9G2tm7yn/B/v1JmsU/2ct4p9jjc2Iy+nU0V
         kCejk86E/ZNm/1AX8Kqqv3PBfrK+pby4O79zWTtw+arGz0k0F+l0/yfob+Q7LoZKSH+a
         OFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yqDBfkhIl2rYhcv87Nqtn7vP/ftvOSb34XPtAxjwB1I=;
        b=LfRpxWcV9LtHrxUmjvAz7KpNK6psHaVAfqeASk+x3vAOG+kkkTl3UxtykzeCdH3sXy
         pGxqiFqtaKLWSYh3ECnXDPUKCO/PIaN3qy5/tTBo9algQrHMXoVfHyahtizX03pe5i7F
         +eyIwiG3uXIyFpWqcYsapFZCo/EK33I5YdWVIpZU1MaxQ543FIPGolHLhWACwrnwDT4d
         VNcYhI1vvvYBzMEAfE9bFEbBLtYJ9vTlV7eJYJ0l0MKvt5+kjDxKPPFLTgDpI0XqAEFE
         2ahoRhDi64MY/ygCehwYvGpVijQdI3DRshrLs70oH+Q/oDv1RvSTkmGe3CbpAimCwGRA
         skQw==
X-Gm-Message-State: ALQs6tAjVnWi8aeVBPNBU7hIVjLopVOsOUheeWsuaz6Td5vrQRVD+PBx
        3r6iaXA5SvLsoj+dE0P4z5Gmvqn4uvP0a6cA/bc=
X-Google-Smtp-Source: AB8JxZr91c/3NuL1mIlSkLpYfhUmio/OWKgdBMlABomUCwRITW6nXPrUoIdXDIMPtvraZvqgOB6ZEdqdpNc78gUBvvE=
X-Received: by 2002:a50:8f21:: with SMTP id 30-v6mr6428733edy.265.1524900141246;
 Sat, 28 Apr 2018 00:22:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Sat, 28 Apr 2018 00:22:00 -0700 (PDT)
In-Reply-To: <CABPp-BGX-hQYdqfNQZ42313VVhKd7GzgUJqvgwOj=0TEO5UQpQ@mail.gmail.com>
References: <1524739599.20251.17.camel@klsmartin.com> <CABPp-BE5jRG8JdDfH1XG-Btz9jJxfwf_oyNni8Ci1j+J3icbVQ@mail.gmail.com>
 <1524825269.2227.5.camel@klsmartin.com> <CABPp-BGX-hQYdqfNQZ42313VVhKd7GzgUJqvgwOj=0TEO5UQpQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 28 Apr 2018 00:22:00 -0700
Message-ID: <CA+P7+xrK85JMJW4bMhJVBbbcdgs=6MQKvoZqTvKdB4yBNVc7Ag@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     Elijah Newren <newren@gmail.com>
Cc:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 5:24 PM, Elijah Newren <newren@gmail.com> wrote:
> I would expect that a different example involving non-linear history
> would behave the same, if both sides update the submodule in a fashion
> that is just fast-forwarding and one commit contains the other in its
> history.  I'm curious if you have a counter example.

My interpretation of the counter example was that the two submodule
updates were not linear (i.e. one did not contain the other after
updating).

I could be wrong, so more clarification from Lief would be helpful in
illuminating the problem.

Thanks,
Jake
