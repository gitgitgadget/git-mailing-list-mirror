Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D231F597
	for <e@80x24.org>; Sun,  5 Aug 2018 19:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHEVXG (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 17:23:06 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:40081 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeHEVXG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 17:23:06 -0400
Received: by mail-lf1-f51.google.com with SMTP id y200-v6so7502982lfd.7
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hQvcNiCJH+eJ2t+2YVU/2gyzg6NOaNXM8dQnK2ZincQ=;
        b=IMDD5LwUJeTRd1eH8OqYQHotmXieqsoTUGn+GWlk6GNqrVsQHU1AMcB09Bhd8LgF2L
         u1U2k67ATunj4dSQcTR/jbyeX5Z06Ynk9SyIvB0COY7rId5L+3MlJe7KFVo09nCGzVwl
         QUmcrrEaN9Mf1bJClckN5C/oNOEaOKUOzn9Lef+kBckVIB3wWeeEvB3IR8EAHIaI24N5
         YdSk5+T4s3VkOefUxnT75DgYugYWLjx0HezyHGq5MHbbRjIOv7tUqOzFO2DleUWbkzzj
         BS+yMuycv8owWp8DYEXRfgfEouQY1vJpIP5RqPCs4KWRhJmpnXaAj+z5FSFUPK8lO9R8
         yPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hQvcNiCJH+eJ2t+2YVU/2gyzg6NOaNXM8dQnK2ZincQ=;
        b=dNb07sfmwaAa30uFNL7wpuVfO8BnJITg5OjoUjkWecn5B3qur1fHgDH2Ti0p+rDsKO
         BxhB0Nsexx7eyIzOyozagELZJg1QG4xMYvGBTA6jc7Rl7Bm3Jp5la4Pg+4Z8+qRSXYdH
         S6Kpxg/FleLSVmK3cmCSvocu49jtbenir1CghXoDf60/4av4uZfr4COxD+6VhgPPSplV
         9e8MV2kvuhV7IQZbEBRMk5Foo6/7SWiGv8U6wbBXCvCl8OESkalFgz6E96+X5mGiMTaE
         AVrCdo+dVqtrQhBJXXaSPbYA1S5Ar2NWKdMSYrdcVCSVs20enkRi88tyF2H/vNHRyxKg
         imtA==
X-Gm-Message-State: AOUpUlHZMyUuD8KTN5FIJo6elP7dyrS6W6aq0dMUH1jNvCRo/T0blwxX
        hJ+G5+g2eEpxsqSHvrnVR5HdBlx30LuMeLcd4xU=
X-Google-Smtp-Source: AAOMgpcq0qOIE0jTaUfNxjXmagsZIwYVZC3HEy6CmvsGdp5ii8/UkI0Pi9JgvGj1tanD52klcftc6TT/5JXeP1JeGPk=
X-Received: by 2002:a19:3b11:: with SMTP id i17-v6mr9236152lfa.146.1533496649489;
 Sun, 05 Aug 2018 12:17:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 12:17:28 -0700 (PDT)
In-Reply-To: <20180805081116.GG44140@aiede.svl.corp.google.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com> <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com> <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
 <20180805081116.GG44140@aiede.svl.corp.google.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Sun, 5 Aug 2018 12:17:28 -0700
Message-ID: <CA+KyZp6KXFfEKNho7njg=0tDxAk-mSMP9r9hZFFH+gZcJ8KptQ@mail.gmail.com>
Subject: Re: concurrent access to multiple local git repos is error prone
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am on Ubuntu, I will run the checks that you mentioned. I assume
it's operator error for now though. Like I said, it was just `git
status` that was sometimes failing to send any stdout, presumably when
access to a certain git repo was concurrent, but possibly due to
concurrent access across multiple repos.

Also, as an aside, this seems to be a bug, but probably a known bug:

$ git diff-index  HEAD; echo $?

:100755 100755 60e5d683c1eb3e61381b1a8ec2db822b94b9faec
0000000000000000000000000000000000000000 M      cli/npp_check_merge.sh
:100644 100644 35a453544de41e2227ab0afab31a396d299139e9
0000000000000000000000000000000000000000 M      src/find-projects.ts
:100644 100644 c1ee7bc18e6604cbf0d16653e9366109d6ac2ec9
0000000000000000000000000000000000000000 M      src/tables.ts
:100644 100644 29d9674fbb48f223f3434179d666b2aa991ad05a
0000000000000000000000000000000000000000 M
src/vcs-helpers/git-helpers.ts
0

$ git diff-index --quiet HEAD; echo $?
1

different exit codes depending on whether --quiet was used. In this
case, the exit code should be consistent.
The bug is with the `git diff-index` command, as you can see.

-alex

On Sun, Aug 5, 2018 at 1:11 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Alexander Mills wrote:
>
>> Yeah in this case what appeared to be happening is that if `git status` =
was
>> called concurrently, frequently I wouldnt get any stdout..
>
> Thanks for reporting.  A few questions:
>
> What platform are you on?  What version of Git are you running?  What
> is the output of "git version --build-options"?
>
> What is the exit status from these "git status" invocations that
> didn't write output?  What options are you passing to "git status"?
> Are there any other interesting symptoms?
>
> Is this part of a larger tool or script?  Are there other operations
> going on (e.g. something sending signals to these git processes)?
>
> Does the repository pass "git fsck"?  Any other symptoms or hints that
> could help in tracking this down?
>
> Can you paste a transcript of the commands or script you ran and what
> output it produced?  Is this something I should be able to reproduce?
>
> Thanks and hope that helps,
> Jonathan



--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
