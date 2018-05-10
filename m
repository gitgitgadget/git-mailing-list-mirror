Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544FA1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeEJTF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:05:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36884 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbeEJTF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:05:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id e9-v6so1518609pfi.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/SIFpNR3da0c+CFv1X97xQ9q0nxqTD2IIhr4UYr/nOg=;
        b=lkNlOVBnKu64hzunbVZh3JK/KvjI23dRCvnvNPPENHzVxC+2f6knsV8evxoEoVyfq1
         ijfjMlZibTN7cqLDsrzW6ERqaFqCdNO3n4yiYmCnV5kAP0MK0Y5WM3vJ92/+nM7/faFy
         Ewi3artbf2uGjBLkdfUIxdtLcr5pEGzsuN33BlKLsh8B93uIGK+ENsaMzQGWF+fz/mWV
         UutN1IGEufvW3d0yVnHJWizBBgAc0X7d9o3BlcCPAQI0RSsYHDI8Lp9mFlWiUv2unzKD
         sj+Z47LqHVjPp7tiE8B246cv4w82fkO1OakmQsDj6kViY7rKkPEb2vqRJENVJILA5z58
         lFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/SIFpNR3da0c+CFv1X97xQ9q0nxqTD2IIhr4UYr/nOg=;
        b=RSQzQnrT3rw5TIDtnmlqx2cDQGTva6SM/6ovBEZxhczLzW1veGH0ExeruGp7tpg1eC
         JUzoZJt4IUDzzMaDtg4kIBn4a9iM+roWIHrb6Af3sSaKbRVrfeSiJp4TJ6XdyfWSzLdx
         eIk/Nv6s7SA+SypbO4X4SQYl1YmKUiR8olFAcmAB9v8utzgObNaTrNqeDi8WzVWwZYqe
         Jm1MmfiVBrKdlsjgPZv2q3cRe/8/+oXxiVUZo6hoNfHSx9UBw6F/AKjVSa66Npjqp14p
         28XBRQTLT53fZqlxUHQtoml9f59EX9YNpLfLEq2fsBAvQ7k0eJazL3ig1cN0Fa0ILmkL
         zX8A==
X-Gm-Message-State: ALKqPwfVVpx+4f4vR2T5j/gaGtwhKbLWkx2GofRrBrGI7en4F2RpEmGo
        FJ9x1RsJVO8E+MB8r6KKYtWNC7R1WbERMU9y1SQ=
X-Google-Smtp-Source: AB8JxZq96oIIVDbzZCJT8twnhvRTSKb5S0pYXk2udnmUspJLR7qwj+NuFZr+8/uNXVzI+bIfTQUhgfzc1Wkk9SQv49c=
X-Received: by 2002:a62:62c2:: with SMTP id w185-v6mr2479407pfb.78.1525979127612;
 Thu, 10 May 2018 12:05:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 12:05:27 -0700 (PDT)
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com> <20180510173345.40577-1-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 21:05:27 +0200
Message-ID: <CAN0heSo-1+BvE0SiZMKT1zHZ4o+-mK0W9S+xxDA4Pyw3iTvpDQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:

> Commits 01-07 focus on the 'git commit-graph verify' subcommand. These
> are ready for full, rigorous review.

I don't know about "full" and "rigorous", but I tried to offer my thoughts.

A lingering feeling I have is that users could possibly benefit from
seeing "the commit-graph has a bad foo" a bit more than just "the
commit-graph is bad". But adding "the bar is baz, should have been
frotz" might not bring that much. Maybe you could keep the translatable
string somewhat simple, then, if the more technical data could be useful
to Git developers, dump it in a non-translated format. (I guess it could
be hidden behind a debug switch, but let's take one step at a time..)
This is nothing I feel strongly about.

>  t/t5318-commit-graph.sh                  |  25 +++++

I wonder about tests. Some tests seem to use `dd` to corrupt files and
check that it gets caught. Doing this in a a hash-agnostic way could be
tricky, but maybe not impossible. I guess we could do something
probabilistic, like "set the first two bytes of the very last OID to
zero -- surely all OIDs can't start with 16 zero bits". Hmm, that might
still require knowing the size of the OIDs...

I hope to find time to do some more hands-on testing of this to see that
errors actually do get caught.

I saw you redirect stdout to a file "output", and anticipated later
commits to actually look into it. I never saw that though. (I did not
apply the patches, so I could have missed something.)

Martin
