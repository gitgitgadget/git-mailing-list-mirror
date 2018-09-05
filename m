Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2006A1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 13:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeIERd0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 13:33:26 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40367 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIERd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 13:33:26 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so13385777oig.7
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WDfof55dld2j6ZXyXBZUUq/XjEGG0HGcUWBV73ZQur0=;
        b=UTB7UYtBoCB4xhXQJiG8DjCm3hbJO3xz5OrO5I51QCfAQM7ry0rWfS3rGlgDPD+gM7
         8b/dQVg1vOJ5abjk35q/bQu0dIvty6z4nkoaDXXGGRzpe0AHWWCOly4CdkEOAls0FiSw
         J0wLNWH332kVs2PxCXaebYOH+zJiGu6577yIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WDfof55dld2j6ZXyXBZUUq/XjEGG0HGcUWBV73ZQur0=;
        b=YXp1NbSHo7/Cte5ig+UoIVc8ZAiiWrzzIOkQER2JIAZuDBReD7Dl4a5V2TDaF3Z3w0
         7p+dba8h0vmBGlYpoH4Ae7oxJoX+hr/ySI/6+P5WhhuYHAJY+riBSidr88dqt0DMTomn
         EKzGU3SQr59CMd12v99x9A4PbYS7Z82GhYVMhcIQCDsCK8MO1Lc0GgwokOuN5DrXhuKn
         Mpga+CRNGcg7IPHhon9Lb0dUdcem7vaOUqAVWhdETnZZH4KJkdN9EsG+N5J5CE9XuqCJ
         DYm4d2VFx3hUOFefU1gsP0iP6Zp+flutNWjJck9sgPR6jP4QvpLGRB31euewLphdC1vk
         3V2A==
X-Gm-Message-State: APzg51A7bggHw2QtfNLCe1kgk9zcLXJ7z0fOnTV5BRfdWGvrTKsJF+/z
        UsoQ1gDz0xA6R8W/+tOuSVlmUT4pX8At+jBf6BKhGdhR/fg=
X-Google-Smtp-Source: ANB0VdbyBXTMkf4/k42JmQGUq16qa8fn0SPR71T9Y7WEZAu9rsUUxSmmNOYIk712A7+RCi/8OTGsVALVHial59R2ubM=
X-Received: by 2002:aca:df55:: with SMTP id w82-v6mr30768650oig.355.1536152594640;
 Wed, 05 Sep 2018 06:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1ec:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 06:03:14 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
 <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1809041304450.71@tvgsbejvaqbjf.bet> <CAE5ih7_GgkEaVXONy8ZY9j43PX6GD-mkD9vJ1t93upAfTkM8tw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1809051430390.71@tvgsbejvaqbjf.bet>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 5 Sep 2018 14:03:14 +0100
Message-ID: <CAE5ih787aEOAGoC9Ze8qgq+veLQYNkpKgjAG7MpkP0=nyQ5MMA@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with
 --write-junit-xml upon failure
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2018 at 13:39, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Luke,
>
> On Wed, 5 Sep 2018, Luke Diamand wrote:
>
>> On 4 September 2018 at 12:09, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Tue, 4 Sep 2018, Eric Sunshine wrote:
>> >
>> >> On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
>> >> <gitgitgadget@gmail.com> wrote:
>> >> > So let's do something different in VSTS: let's run all the tests with
>> >> > `--quiet` first, and only if a failure is encountered, try to trace the
>> >> > commands as they are executed. [...]
>>
>> Is this re-running just an individual test on its own or all the tests
>> within a single file?
>
> Upon encountering a failed test, it is re-running the entire test script
> afresh.
>
>> The latter shouldn't need this at all.
>
> Please do not let me die dumb. In other words, I would love for you to
> explain what exactly you mean by that sentence.

Just re-run the script. You shouldn't need to kill p4d, as each script
starts up its own instance of p4d, and shuts it down when it exits.

$ cd t
$ ./t9800-git-p4-basic.sh
Ctrl^C
$ ./t9800-git-p4-basic.sh -v

There's a cleanup() function in lib-git-p4.sh which kills the p4d
server, and that's invoked via:

  trap cleanup EXIT

That's the only cleanup that each of the scripts require AFAIK.

>
>> And the former, I'm not sure will actually work - most of the tests
>> assume some particular p4 state. But perhaps I'm missing something?
>
> No, the former would not work at all. Not only for the p4 tests: Git's
> tests frequently commit the deadly sin of relying on output of one another
> (wreaking havoc e.g. when test cases are skipped due to missing
> prerequisites, and latter test cases relying on their output). It is not
> the only thing that is wrong with the test suite, of course.
>
>> I also think it does look kind of ugly. And if there's one thing I've
>> learned, it's that the ugly hack you write today with the words "we'll
>> tidy this up later" goes on to live with you forever!
>
> Okay.
>
> (And having read lib-git-p4.sh, I kind of see where you learned that.)
>
> But maybe you also have some splendid idea what to do instead? Because
> doing something about it, that we need. We can't just say "oh, the only
> solution we found is ugly, so let's not do it at all".
>
> I am even going so far as to say: unless you have a better idea, it is
> pretty detrimental to criticize the current approach. It is the opposite
> of constructive.
>
> So let's hear some ideas how to improve the situation, m'kay?
>
> Just as a reminder, this is the problem I want to solve: I want to run the
> tests in a light-weight manner, with minimal output, and only in case of
> an error do I want to crank up the verbosity. Instead of wasting most of the
> effort to log everything and then throwing it away in most of the common
> cases, I suggest to re-run the entire test.
>
> What do you suggest to solve this?
>

I don't know about any other tests, but the git-p4 tests don't take
any longer in verbose mode. So one simple solution is to just run it
in verbose mode - unless there are other tests which have more
overhead.

The trap/exit/cleanup method that the git-p4 tests already use would
seem to be ideally suited to cleaning up everything on exit.

There might be some specific tests where this doesn't quite work out,
if you let me know what they are I can have a look at fixing them for
you.

Thanks,
Luke
