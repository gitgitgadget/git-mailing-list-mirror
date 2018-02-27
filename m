Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D683C1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 00:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeB0A3K (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 19:29:10 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:46634 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeB0A3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 19:29:09 -0500
Received: by mail-ot0-f169.google.com with SMTP id g97so2206063otg.13
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D6+I24iqK09GcfKPmaDBbFgVeX93uLh7sCc5yBMCx+k=;
        b=eDVdtshobxXgOWnLB56jbJWppjbUXK4QImbb5Z//o52vGcWDBiRH9x3gWqcBmMv30X
         x/QaoztdvOAoRmuVOHWhQIjRFU7WuTbHW1eCBmaXMBj+DgOiU8jMfZLxjagaWzYqZnkq
         3W69ybmWoyvxprofd6jiFPmAZUAAWTdo0QYzlINcD7MFtIDKdaiUXsFiPjQah3eurCVA
         5RqdoJQLYT+Z9OFCXNF33VH+uF8SCgEo2tnPvKHnDnrn0EQOZHGROldoOp+js/5aKOMg
         +9WlGrm2GgEiDdYCzw6o37Cg3uxjbZBUXnFx1ZcfDdSptPxHkclkwrdf7p4L554e2AGB
         IU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D6+I24iqK09GcfKPmaDBbFgVeX93uLh7sCc5yBMCx+k=;
        b=BltQgnw2ro62YHgESv2crJgtZEEv5iUbn82gHOXvUFxphRnLzHt1H+NWoqCBPp4kmi
         o+xgvsuDqpd85nMpkKLmlkXfNjge6pnuGr+oyTimLre4F2i8Zyg9D/KtE/UnMxGfz4WG
         kcm5szm31+Cf08iMKlgKlE6mb/HUrZoMoLei84NbtI5+L17ZCSoHTp3E2ddd3TN42qIJ
         YwSzTy6XHZVhEDe9n4qkQp9PAbXfQ/uUXiVa7nGS3SEU7iOZkfEF0OtBQgRbgWKQyNlY
         Vcwdn6oUo8Hz+6pbVmRblM8PFbD2rtt3TGQLeu6D6f5m9rE9MdWbk3eXrNUXcphwpHAV
         xbBA==
X-Gm-Message-State: APf1xPCvtz5QF6mdEsK6RIMyGXwKHyV70pkOopMclLg3Uw+DeTRHBGyk
        3IPRtYUVmU/MH+5XA7xmkji6w6OWqeGt7VT4lqA=
X-Google-Smtp-Source: AG47ELsy/RJOaadFlhVWl5vkob+iDBjdWTwq33voCiXZCnW7u72xlmc+iJ/o+jkqM1NLxRkXeY2lWvVuthd+DFGyKbY=
X-Received: by 10.157.67.42 with SMTP id s39mr9631194ote.14.1519691349111;
 Mon, 26 Feb 2018 16:29:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 16:28:38 -0800 (PST)
In-Reply-To: <CAGZ79kZHw3qr+-0QeE3j0nSjMkob8-QOCcbHRfoZGbapQsURaw@mail.gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
 <20180226103030.26900-2-pclouds@gmail.com> <CAGZ79kZHw3qr+-0QeE3j0nSjMkob8-QOCcbHRfoZGbapQsURaw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 07:28:38 +0700
Message-ID: <CACsJy8Bpo9yPEuiHe1+Rz4JEuT=8kkhyW3d-6_T2UbnoaorE5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] repository.c: move env-related setup code back to environment.c
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 3:30 AM, Stefan Beller <sbeller@google.com> wrote:
>> diff --git a/setup.c b/setup.c
>> index c5d55dcee4..6fac1bb58a 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1116,8 +1116,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>                         const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>>                         if (!gitdir)
>>                                 gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
>> -                       repo_set_gitdir(the_repository, gitdir);
>> -                       setup_git_env();
>> +                       setup_git_env(gitdir);
>>                 }
>
> What makes git_dir special, such that we have to pass it in here?
> Could the check for getenv(GIT_DIR_ENVIRONMENT) and fallback to
> DEFAULT_... be part of setup_git_env() ?
> Oh I guess that cannot be done easily as the submodule code
> spcifically doesn't want to discover the git dir itself.

No, submodule code already does not care about setup_git_env().

Back to your first question, this is related to the "NEEDSWORK"
comment in this code. We _should_ always set_git_dir() before leaving
setup_git_directory_gently() then everybody behaves the same way and
we don't need this special setup_git_env() here at all. BUT we need to
be careful about setting environment variable $GIT_DIR, done inside
set_git_dir(), because sub-processes will inherit it and if we're not
careful, we'll break .git discovery in those. There's another thing I
don't like about this is setup_work_tree() using set_git_dir() the
second time to adjust relative $GIT_DIR and friends when it moves
$CWD. I'll need to fix this, soon.

So in short, it's special because the current situation is messy and
(hopefully) temporary. But it should eventually be gone.
-- 
Duy
