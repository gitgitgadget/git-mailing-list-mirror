Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029952023D
	for <e@80x24.org>; Fri, 19 May 2017 23:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbdESXUt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 19:20:49 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34457 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754139AbdESXUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 19:20:48 -0400
Received: by mail-lf0-f53.google.com with SMTP id 99so8042584lfu.1
        for <git@vger.kernel.org>; Fri, 19 May 2017 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NJCfbsrVYMAiAN9hTwcMXRbjg36uyLKaws4ZeoHYOHw=;
        b=sSio0SXtSMv38ZQkkkV8sqJDQ90mj3EnEd0VUR3959G58JOk0V/zQpJJmZqL1ImpaR
         ijf+FTL6u725njkj0kItVqg/jBDo9FBHYKphvrtt1e39no9M3Agd7WofSLBkkLtoJfAL
         IpuBjutRvJs6yE6iREnvvtomn6Hwh7446sVXKz29W7GfelGj44I5FrgyiieNdv8ZPW57
         KxYavzPRsx2fkdC63DZ/Rk0/z5slsCKvnAB60NjtSL3P3iAGVRcnKFyPemxfHw+k3g6M
         25oL1FM5eBf/MFBIehvKMFqTIy4MTqkzOdB7LNuBPvK3Cf4JrjPT2axdb+oHl/yGDm92
         9b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NJCfbsrVYMAiAN9hTwcMXRbjg36uyLKaws4ZeoHYOHw=;
        b=ffx8Iw+O0iqhsRR4LBohspSs5cumSe8j29N1lXsZrf3WvaNFGPvCbeBMzSfWKR+At8
         aAUKPYuN5uC1wVG9uUs3PqDKGjBtt6oUD+zI4ttGbfLRUE+gocX7bzTj7Gx9coulraYG
         JT0JJXTuKw30UNP78no/sMxRTeF4+BAiu9f3t7tmAsI3EZCCK2s7LNapiL0DjKr1de/s
         iS52wYr3w0+pP5E2seh43LaIQ/190s3L0kXcb5PFMxEvcLQPpqZMid6KUrZ8Srwfp6yY
         GPbknsImhfUc4pcP/5o6Z3WhdU2aJ85dTg5+oMKujnXZHXvlnh/vc+ev+HLut5VU1sRT
         aKQw==
X-Gm-Message-State: AODbwcDpojSiBhsrrcbM2613xp4sw0ryZ85BexSZmbHQsnxWk925EXb4
        utb+BzHTwb50fNtm33x0wNl/wJOOTw==
X-Received: by 10.25.20.101 with SMTP id k98mr2808156lfi.26.1495236046991;
 Fri, 19 May 2017 16:20:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.97.9 with HTTP; Fri, 19 May 2017 16:20:46 -0700 (PDT)
In-Reply-To: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
 <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
From:   Animi Vulpis <animi.vulpis@gmail.com>
Date:   Sat, 20 May 2017 01:20:46 +0200
X-Google-Sender-Auth: bpN5x9vG0P-7VthkSeJJ0TtBc1s
Message-ID: <CALKRkryGnj-8nRJZsjqLLLmiV5s_G9H0-peBTpa0u3C0RKrHOw@mail.gmail.com>
Subject: Re: [Bug] git branch -v has problems with carriage returns
To:     Atousa Duprat <atousa.p@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No problem, thanks for taking the time to help me.

I managed to create a minimal repository that shows the bug.
(I was able to deploy gitlab-ce-v8.15.8-ce.0 from docker locally and
create the repo, create the merge request and merge it)

I created a github repository so everybody interested can use it:
https://github.com/AnimiVulpis/git-bug
A few additional informations are in the README.md inside the repository.

FYI: I also tried a lot of things to create commit messages with \r\n
but without success. git does a good job preventing this.

Based on the history of the homebrew git formula
(https://github.com/Homebrew/homebrew-core/commits/master/Formula/git.rb)
and the fact that I `brew udpate` at least once a week I am pretty
sure that this bug does not exist in
git v2.12.2

Hope that helps
Have a nice weekend
David

2017-05-19 23:55 GMT+02:00 Atousa Duprat <atousa.p@gmail.com>:
> Sorry for the noise with previous response...
>
> I have tried to repro this issue but git goes out of its way to store
> the commit messages using unix end-of-line format.
> I think that git itself cannot create a repo exhibiting this problem.
>
> Most helpful would be if you could create a mini repo using gitlab.
> All it would need is one file, two branches, and a merge.
> With that in hand, it should be pretty easy to track down the problem
> and fix git.
>
> You mentioned that the previous version you were using was working
> fine, can you tell me which version that was?
> It'll help to narrow down the changes that could have affected the issue.
>
> Thanks,
>
> Atousa
>
> On Tue, May 16, 2017 at 4:22 PM, Animi Vulpis <animi.vulpis@gmail.com> wrote:
>> Hi,
>>
>> I upgraded to git v2.13.0 and since then git branch -v has problems
>> with carriage returns in subject lines.
>>
>> We are using gitlab (not the newest version). So this bug (It's about
>> carriage returns in auto-generated merge messages (\r\n)) is not yet
>> fixed in our version:
>> https://gitlab.com/gitlab-org/gitlab-ce/issues/31671
>> That's were the carriage returns are coming from.
>>
>> In my specific case the auto-generated merge message has three lines
>> with empty lines in between.
>> So every line ends with `\r\n\r\n`
>>
>> If I do `git branch -v` with such a subject line somehow the third and
>> second line get combined before the hash. Example:
>>
>> $ git branch -v
>> See merge request !XXXX temp space 84e18d22fd Merge branch
>> 'feature-XXX' into 'develop'
>> # <begins with third line> <ending of seconds line (if longer than
>> third)> <commit hash (correct)> <subject line (correct)>
>>
>> Before git v2.13.0 `git branch -v` worked completely normal.
>>
>> I was not able to create a minimal local example, because my manually
>> created \r\n in commit messages were transformed into \n\n
>>
>> Please let me know if I can provide any more information that would be helpful.
>>
>> Cheers
