Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B241F462
	for <e@80x24.org>; Tue, 28 May 2019 13:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE1NgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 09:36:09 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35822 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfE1NgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 09:36:09 -0400
Received: by mail-lf1-f51.google.com with SMTP id a25so4743135lfg.2
        for <git@vger.kernel.org>; Tue, 28 May 2019 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=kK1eDmDsJbMbCcrnOZ7hj3TwOorjTPde0Y2yijr1Yao=;
        b=YZvTXBtoeB2MeTJa1uWAWV9d8OROoNiEHzZevjM8jj1zv3MbdbqQlnntVrooOrFdfX
         bxaepcuJMpPkOedWWBf+rh/q4+PwIxXZ82JExPp/7hdTm/428II8sM2fitds0a+wwxEC
         9tmglGgMaERXa98NxiRYOD6jJaCZhLdG/5ilTcP5RfWtMf6WX9kMZSeDE0WTdXPPLzen
         SwrmTYO6ixNk59C9oGaB7GIyML7dkCv9iehjYo+f8bCFd/VaSor/lyqKvXJcT7lltXZA
         EnrMrsbIfXBhCNYTpjvf29Pq0o2r5OkUgwCu6eZ/WU/ziyYPmFnWzITp/nJUYCczmFai
         NSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=kK1eDmDsJbMbCcrnOZ7hj3TwOorjTPde0Y2yijr1Yao=;
        b=NBhabe34qWQYGGJibdpfsjItZ0TvMKSHaJNriBgjBALczdwh1ju6f+S4gmTScvrQiL
         8rsoN850ntzZioB5UnpB1CJuPgcuid24gAaQqNlVxLJhTBAOes3+g54RjjtW94OAaDD5
         A+d/MmVbDnV4pI9khRJ5qEEat5e/p/fxf9EEdxeF/Mm3Z+e9/wEPm2g9i1jx+oufQwNL
         3GPeLwq3PwpQ4HhFhppw9YNDT/lAAZBYt2KAW3j2+OrM76IfkEE+2Beb03kLwFp3ff7o
         D7pacw06HK1LGNyjcKl1GuOr5t3B0P1xavVa6y5yldQ2LLJTMDLbwXNMpMSxIc04i55Z
         BGmw==
X-Gm-Message-State: APjAAAU2FlK0xZqIKuXeo6w0fnAKuVnAOvZUOHDkmmyusyufDtQbHUFn
        Met4DYQyyvSsl5Wveilqdc5qX0WOD51QV+zlaMxREQ==
X-Google-Smtp-Source: APXvYqzaFKGtPhpuw204LbmuDd3+TyW9zsd4cTiWcMdZTn1QnaD3P5p2vM4hE+6Sf8Q/Sp/QmjcorbZ0ElweJCLh6gM=
X-Received: by 2002:ac2:518d:: with SMTP id u13mr8976184lfi.40.1559050567220;
 Tue, 28 May 2019 06:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
 <87ftp3lqvw.fsf@igel.home>
In-Reply-To: <87ftp3lqvw.fsf@igel.home>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 28 May 2019 08:35:55 -0500
X-Google-Sender-Auth: x6365CQCPNfFXpxFBT8prRcCeL4
Message-ID: <CAHd499BQO8E99Y4=T9V6xXDuDyHdqMJ_sQM4DTraAxLzKf+Z-Q@mail.gmail.com>
Subject: Re: Need help merging unrelated histories
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 12:11 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Mai 24 2019, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
> > Can anyone provide some advice on how to properly restructure this
> > repository to create some ancestry, as if all along a `master` existed
> > and all release branches were based on this in a linear fashion?
>
> How about using git replace --graft, then git filter-branch to make it
> permanent?

I unfortunately have little-to-no experience with low level plumbing
commands. Could you provide an example of a series of commands to run?
It will help me to figure out how to do it on my own for my specific
use case. Thanks in advance.
