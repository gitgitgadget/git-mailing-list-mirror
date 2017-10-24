Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2AE91FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 16:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdJXQpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 12:45:16 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45763 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdJXQpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 12:45:15 -0400
Received: by mail-qk0-f196.google.com with SMTP id f199so27077389qke.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZFJ9DJ90hpLC2X/2Fur8Q7wqRYOJsl1is4tXAPraS8s=;
        b=nVOS6dJoHtIB1CEKO7AHYEKGVyFlmQQCUrAZQEYxqOpd8bJpkfypBLMqGhRypu4Q1O
         2XL1dy3Ybohv//6uypSrZjJRTdAF1a3XZIpXo0Rr2lUAUE6a1TdIvYwuLaoNlzhf6CsJ
         IQcyaAIEhFK5RCEzUXEF2Yj4Mh2axkLxEUpeuDhA87ecl7eRfXPn+eTB5wM75lxcSvjE
         iIe553Lv8ETveVPqUm63/Q+yd/DzYia65l279eW4aPgp8/sJMyICQHlUW8IhNZ4Bxf04
         Zgee9yRXtY0naMGZJ7H7AtoEt9S6rvblTPnBnB0m7X9FxxLXKJyXYd3KG02+zs0l+1fL
         7WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZFJ9DJ90hpLC2X/2Fur8Q7wqRYOJsl1is4tXAPraS8s=;
        b=RNbhz4jclR9r9tmHNvU2YSy9Ff05nh4zqk0apzKoctOpZd83EkUWBpMCttMwo8OAPP
         fihN9U5RfJJmylRZlyAvCInYJ8J3W0EW8m7ca5WPFAWNSdNdiTFp8MyvF8Uy8MfvtIwR
         o3/CqI/NExsbk0swG1t2M3luLupwHpEGB0xT62c9jVpS/hlAfeNd0NDBQ8DcNUnnuvl6
         YV3DcisfdHPl0uKn4/h9rcwmSb07KnUWnCbBO/cGW0JeQ8Pmqo6MT+e7beJUeSFOlKrP
         PrqOuZK9NAk0YLzxlBTf+AZ0Se7us/g4JIJK5LFtxqdmSdN9yXY37DAg+TNE5YPPHDKI
         JGEQ==
X-Gm-Message-State: AMCzsaVKczLfsJ2I+BqON1o36plFOEkJLJFSTqIY31Mgd1WC5MwSHfSD
        OuPbsVg+Egu2MPly9XTkHRtnxG2bk+Cm4Y+CaH5FMA==
X-Google-Smtp-Source: ABhQp+Qc17YNomAOegsh9YsIEmhQn9acAafQLOc0Od2A57TBPo39v9tje7RVSJ2EOMyC/J1jRyivi8fLfxaZZtn5veY=
X-Received: by 10.55.197.152 with SMTP id k24mr23980103qkl.178.1508863514416;
 Tue, 24 Oct 2017 09:45:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 24 Oct 2017 09:45:14 -0700 (PDT)
In-Reply-To: <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com> <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Oct 2017 12:45:14 -0400
X-Google-Sender-Auth: hsCCMvioeDjVZ7yWL7oLFxQk1do
Message-ID: <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Stefan Beller <sbeller@google.com>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 12:28 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Oct 24, 2017 at 8:27 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
>> Add check of 'GIT_MERGE_VERBOSITY' environment variable only once in
>> init_merge_options().
>> Consequential call of getenv() may return NULL pointer and strtol() crashes.
>> However the stored pointer to the obtained getenv() result may be invalidated
>> by some other getenv() call from another thread as getenv() is not thread-safe.
>
> But do we have other threads running at the time?

I feel uncomfortable about this change, not due to lack of thread
safety, but due to the distance between the getenv() invocation and
its point of use. See below for more detail.

>> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
>> ---
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> @@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
>>  void init_merge_options(struct merge_options *o)
>>  {
>> +       const char *merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
>
> Despite not being in a threaded environment, I wonder if we want to
> minimize the time between  calling getenv and the use of the result,
> i.e. declare merge_verbosity here, but assign it later, just before the
> condition?
>
> With or without this change:
> Reviewed-by: Stefan Beller <sbeller@google.com>

The distance between getenv() and the point where the value is
actually used is a big concern due to not knowing what is or might be
going on in called functions between the two points. According to [1],
the value returned by getenv() could be invalidated by another call to
getenv() (or setenv() or unsetenv() or putenv()), and we don't have
guarantee that we're safe from such invalidation considering that this
function calls out to others. For instance, after getenv() but before
the value is used, init_merge_options() calls merge_recursive_config()
which calls git_config() which calls git_xmerge_config(), and so on.

For this reason, I have difficulty endorsing this change as-is.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/getenv.html

>>         memset(o, 0, sizeof(struct merge_options));
>>         o->verbosity = 2;
>>         o->buffer_output = 1;
>> @@ -2171,9 +2172,8 @@ void init_merge_options(struct merge_options *o)
>>         o->renormalize = 0;
>>         o->detect_rename = 1;
>>         merge_recursive_config(o);
>> -       if (getenv("GIT_MERGE_VERBOSITY"))
>> -               o->verbosity =
>> -                       strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
>> +       if (merge_verbosity)
>> +               o->verbosity = strtol(merge_verbosity, NULL, 10);
>>         if (o->verbosity >= 5)
>>                 o->buffer_output = 0;
>>         strbuf_init(&o->obuf, 0);
>> --
>> 2.14.3
