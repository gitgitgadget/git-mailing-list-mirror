Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0881FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935322AbeAKSUD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:20:03 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33450 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934462AbeAKSUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:20:02 -0500
Received: by mail-qt0-f194.google.com with SMTP id e2so2949033qti.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dW26jkQXxjBO51hxg/NlX8u3qFvaSQcuJsW5u6YriJk=;
        b=tXnD4t+BLY3I+Ft4onex8osaX1M+0pwoK/sf4D1zXRnJcpe9EdQG39v+ucpNSOt/A2
         f632f6ebsuS2ad7e4YVXAVjk+UYuaqLFob41+XepITCVvBquspD0X7ecoPxUzB90caG/
         en2gUoj55Nh3i/4iw4RbERVGwFmS8EJuZmHGhNnF1pZDwYoJ5TE50MoCpjPc+kJMKA6q
         UQvcs7RkgqE3q/kVtZH/IMBkEcBOak3FeXLae500yxZGso5oQzJBCkylRwd/kDkNwG8r
         koKes+WbtajMy6Nc9Wxfv2E9VuA4MwvWSomQhYfnffO9bXlvVKANAEFJMNyMvxpzZCEI
         tHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dW26jkQXxjBO51hxg/NlX8u3qFvaSQcuJsW5u6YriJk=;
        b=gyT/u06fvnR8nldL7G9x6YVoozwMeIoHp47aJYqEsnLA//h4Ke6s88xeaEIHA4mWM9
         YrDIbSnR64r/43muaUR7t9pog2IEHNTrOoEyNS46b/pw69u6iO+KYnkZcjYwKhNxpLGq
         mHcMYp3+hisfbCJ4tIX5xNzRt4S2u+5u/fs/hiACNsj4wnVUZSz9wMhBMEH0nd8ObphT
         9JT3l507CSQ5eosmMbKMc915lznSYPREFgo5ul3BFCxoiZiEVigHUEQOv0vHnNh6q2+9
         Kf/uVlVM4bclWnmhSzSDHUk2mUPGeuSof6mAugrttRzpAiJBc8/otj6/vq6+CfEVUWBB
         QoOg==
X-Gm-Message-State: AKwxytcrJs0EjcKNml4iAZ5AY5VMcn9NxNJo3OZgI2BzTjxmJDthpK2o
        QCglbDkBqLGebmiqAdCQep1vY/pdzRia0FGHtF6Ylw==
X-Google-Smtp-Source: ACJfBotouZc1xQCVSAffI5oNUknONiEuphllDgq3OBonnGu6NAIqrui9xwLi643WDfMYWXBO9ssXJdghw7KcsvjBiI8=
X-Received: by 10.237.38.3 with SMTP id z3mr2540893qtc.180.1515694801779; Thu,
 11 Jan 2018 10:20:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 11 Jan 2018 10:20:01 -0800 (PST)
In-Reply-To: <20180111175316.GD91567@google.com>
References: <20180110104835.22905-1-pclouds@gmail.com> <20180111094712.2551-1-pclouds@gmail.com>
 <20180111175316.GD91567@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Jan 2018 10:20:01 -0800
Message-ID: <CAGZ79kZDh6paRocJvWCtSEDZ=8+4+h0_QUStqBwkeLcvwqVCeg@mail.gmail.com>
Subject: Re: [PATCH v2] run-command.c: print env vars when GIT_TRACE is set
To:     Brandon Williams <bmwill@google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 9:53 AM, Brandon Williams <bmwill@google.com> wrote=
:
> On 01/11, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Occasionally submodule code could execute new commands with GIT_DIR set
>> to some submodule. GIT_TRACE prints just the command line which makes it
>> hard to tell that it's not really executed on this repository.
>>
>> Print modified env variables (compared to parent environment) in this
>> case. Actually only modified or new variables are printed. Variable
>> deletion is suppressed because they are often used to clean up
>> repo-specific variables that git passes around between processes. When
>> submodule code executes commands on another repo, it clears all these
>> variables, _many_ of these, that make the output really noisy.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  v2 fixes up commit message to clarify about "env delta" and why var
>>  deletion is not printed.
>>
>>  It also keeps child_process tracing in one place/function, this
>>  should make it easier to trace more e.g. cwd and stuff.
>>
>>  Though, Stefan, while i'm not opposed to trace every single setting
>>  in child_process, including variable deletion, cwd and even more, it
>>  may be not that often needed for a "casual" developer.
>>
>>  I suggest we have something like $GIT_TRACE_EXEC instead that could
>>  be super verbose when we need it and leave $GIT_TRACE with a
>>  reasonable subset.

Makes sense. Thanks for working on this!
Code&commit msg look good to me. I agree with Brandon on the
comments grammar to have a missing piece.

Thanks,
Stefan
