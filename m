Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89A01F462
	for <e@80x24.org>; Sun, 16 Jun 2019 01:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFPBct (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 21:32:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36637 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfFPBct (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 21:32:49 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so14002527ioh.3
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i920+rjxGyKgY3CtmHRbbtIhidbtHySY31dPfCTRHQk=;
        b=tXP44rKjalGjDqOrxH7HOdHOmh/V4tuLu5On01P3eYex/y8lYlQTJVVM1lwbgTrvCR
         ADuaxIJMNowA25JCw1eK6QsRwucGXO1CnTsFbNxODxpbmswTsQ5ChXb8nvha0L5oT7q4
         6W3lMhW0CAsjkD54JGG9X6H+Q3zZTGJ6jFdOCp9mBcLuB30ycpR4ZvSxiRwrvwJM/V6L
         6y137Qy+sXET1nq6Ur7nyh3hQMcm53I2VkIjcdDjpT5zIcsE7147RJSF97Q642MaMxpg
         qJiI065jv9t0ZMZCTA3GMpQjFWnrQgioFBMqVjPulLrU+RAxpV0494r8dOhLE6oCEy15
         SZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i920+rjxGyKgY3CtmHRbbtIhidbtHySY31dPfCTRHQk=;
        b=GjvKazJZNDe0da1W00lSJrGQP5MeH3fP/ulayJjvmeISIFPVf0Ej/GXSmAOkFQB1ch
         WESikHBtlGz7FCNArBDpUwqYBfnaNymiPmX+XV0j4vGqJMsQPgne96ik34DT6/JxXEtu
         lExl3/Qw471F5b+O1ZcNv9+ZooLKXKHypRWa6prCdZK0/856nb9O52PSkIVCKcE2phtZ
         eZOsqxQs/VboKvp2S9yzltcm0TTf++0XDp+lGXO2ZoucfxhJ0+jLoYxirvOLcs8AdyXE
         Hxxwa8tTlBqHjKx+3vaQgVlLv4sPMrnkHu7twKEOFtE8DRWmUcgnyzbyPOFO7IH2guJx
         uILw==
X-Gm-Message-State: APjAAAU3AgZafgC95GOZ1WZN3bIx5vCIvl0aG5Wa3zHZ7frl9k8ZaJXr
        7uoDWhpUfqxL+TX42afxLwzFo7cgwb4m4gmyoMM=
X-Google-Smtp-Source: APXvYqyuxPDduTtfvUpiKhAkSrLnz+417blAyFKqymi4DlzLdDFB6UPVMuiK1DgmdjNxbq4RNUZRzSImGfGtKPoFVqo=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr9584941ior.277.1560648768272;
 Sat, 15 Jun 2019 18:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com> <20190607100252.GA24208@szeder.dev>
 <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com>
 <CACsJy8CGtZMn0aa7QRj7Dz-jZS2K2fviUJ_Lii48FRY4E84i5Q@mail.gmail.com>
 <CAMP44s2ewOJNYSqQ+8EiBJ8ik7rWMj9yaxWwzYk9nUO+A1gwcg@mail.gmail.com>
 <CACsJy8DThHXksARSM32fQ_8fdYqpQYnR5SQmC0i1oVZVc58fPw@mail.gmail.com> <CAMP44s1RP8ERVX7EPt3oJyd8FP+4OjrGnWnaavnHuORoc+BGxw@mail.gmail.com>
In-Reply-To: <CAMP44s1RP8ERVX7EPt3oJyd8FP+4OjrGnWnaavnHuORoc+BGxw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Jun 2019 08:32:22 +0700
Message-ID: <CACsJy8AkKEf=EvFTcw2QvsQOfaHawWLas-K0FRq-BBLeHuLFbQ@mail.gmail.com>
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 1:07 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Thu, Jun 13, 2019 at 9:53 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 7:30 AM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
>
> > > One way or the other, shouldn't my tests be merged? The issue is still
> > > there, and it's nice to have tests for that.
> >
> > Is there any good reason to complete options when they are not going
> > to work anyway (e.g. like checkout which needs $GIT_DIR)? Besides "it
> > used to work before --git-completion-helper" which I don't consider a
> > good reason given the maintenance tradeoff of --git-completion-helper.
>
> No, there is no good reason that I can think of, except checking the
> arguments, which is precisely how I found out the issue; not something
> I usually do. But a newcomer might not know what commands don't work
> outside a git directory.
>
> But more importantly; is there a good enough reason not to?

For me, yes. No extra work for me.

> I seem to
> recall to be annoyed by the fact that 'git command -h' failed on some
> command with a fatal error. Similarly, I don't see any good reason why
> 'git help clone' should ever fail.

You could give the '-h' hack a try. It probably works for some, but I
don't think it also works for things like 'git worktree add
--git-completion-helper'.
-- 
Duy
