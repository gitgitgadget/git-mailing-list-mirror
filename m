Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60B91F404
	for <e@80x24.org>; Tue, 13 Mar 2018 17:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCMRpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 13:45:09 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:39369 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeCMRpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 13:45:08 -0400
Received: by mail-it0-f53.google.com with SMTP id l187-v6so1203511ith.4
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KCUK8TCWDilmIOFAPVXeV7zmvhzyw3kyoDU/kiI5Xy4=;
        b=VZU87AhgPVfbBsykIvQCBpNp1PUOlBNQN02MrhcNXwyQ4kLfRitXc5389uCHPxAkh+
         4ENDcA7bEBWwa7XH4EdtwF2Ih+KCRf1ZqmiY3t1wBURm56/z3jerasv0L/QoHHzNTDPX
         bmDnL1Nu9VdorhBa74OyPsRXwP6QXGi+lUBIpHxenBeb8r5DMdBV18eYl3SMvKKa1khT
         RVK+e1qvW5skrS2IYeG0c0zzFzerLj3hfvvWLLL14Y5/zqR3vGmjs/H6I2l4OWOssrbu
         zYwx/b8n4jHOGVx0WSLm80IUMo4R/TdgDcdsomQ1itx0Pn7dqs4QGAFrd4sF/ZvkpmoB
         mEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KCUK8TCWDilmIOFAPVXeV7zmvhzyw3kyoDU/kiI5Xy4=;
        b=cmgcmIFhg8Uq06/ZiP+6Ypt0x/lXymwTyir71Z896D4wMqeKyl1eyEbTSEHjfZ0z6B
         gS7I7znc7T5NCP/ishI8M1gHXNU4K4PKuvv9mglmA7fyjGoA7c7KmSXhEfaBxPT71R+X
         NhDdsmJj77x+4Zt9qGuxnUxJo+ooAiIePQU4lWAkPDBM424bWVyPAlg1iFgrjE/olskg
         XHETMS6ZRgnpb321H7hKRJaxppJekfLblq0QvZgHdAg6KbQCd67/Cwiasif79F19zdv7
         RSlfQvScqgVA0cTlie/dZuE7gwHNfcO8801yCvCVa/Zf2b5f9V0BVhGeFphfgyFq5Drk
         J5tw==
X-Gm-Message-State: AElRT7Ek5ym3h9eInVJiWBsOrPPnP3QKIooHI8bGX05JELGIg/vHbO1i
        lPtzAMFjwe3sLx2zCxfBJKnLZg2fak3CBaf/aUE=
X-Google-Smtp-Source: AG47ELu5zRt+RoWJQZAQbwRsCkwfByMv5oHl45CKRj91i6b6Y2VJBfXWbdVq4YaxuGXGUiNwGs4yCLNzmJeZMf9hY4U=
X-Received: by 10.36.47.147 with SMTP id j141mr1901404itj.140.1520963108001;
 Tue, 13 Mar 2018 10:45:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.63.6 with HTTP; Tue, 13 Mar 2018 10:45:07 -0700 (PDT)
In-Reply-To: <89AEA176-2D3F-4271-958E-1C6BCC944842@gmail.com>
References: <20180305200400.3769-1-sidm1999@gmail.com> <89AEA176-2D3F-4271-958E-1C6BCC944842@gmail.com>
From:   Siddhartha Mishra <sidm1999@gmail.com>
Date:   Tue, 13 Mar 2018 23:15:07 +0530
Message-ID: <CAMOtk6Df_7Jb9bX=8PfB9e4-5rRi8QSmXEK7=DmZui6LNBMSLQ@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] travis-ci: added clang static analysis
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 3:49 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> That looks interesting but I agree with Dscho that we should not limit
> this to master/maint.
>
> I assume you did run this on TravisCI already? Can you share a link?
> I assume you did find errors? Can we fix them or are there too many?
> If there are existing errors, how do we define a "successful" build?
>
> Thanks for working on this,
> Lars
>

Thanks for the reply,

I assume there will be false positives in the code which we can't fix
by making small modifications to the code as recommended in the FAQ
(https://clang-analyzer.llvm.org/faq.html). According to the FAQ,
there is no solid mechanism for suppressing a specific warning, so are
options are limited. Some of the things which might help reduce the
noise are:

1) To add specific tags in our source code to tell the analyzer to
ignore the code. This is probably a bad idea since it is intrusive and
forces changes to the actual source code which only affect one task.

2) Count the number of bugs in the previous pushed build and fail the
build if the number of bugs increases. It doesn't help remove the
noise from the error log but it does tell you if you've added more
bugs. However if you add a bug and remove one, it'll pass the job and
might mislead you into thinking that the code is correct.

3) Write a script to check the diff of the error log from that of the
previous pushed build(ignoring the line numbers). I haven't thought
about how exactly it would be implemented so I'm not commenting on it.

Is there a better solution that I'm missing or should I try coming up
with a script to come up the diff?

Thanks for the time,
Siddhartha

On Mon, Mar 12, 2018 at 3:49 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> That looks interesting but I agree with Dscho that we should not limit
> this to master/maint.
>
> I assume you did run this on TravisCI already? Can you share a link?
> I assume you did find errors? Can we fix them or are there too many?
> If there are existing errors, how do we define a "successful" build?
>
> Thanks for working on this,
> Lars
>
>> On 05 Mar 2018, at 21:04, SiddharthaMishra <sidm1999@gmail.com> wrote:
>>
>> Added a job to run clang static code analysis on the master and maint branch
>>
>> Signed-off-by: SiddharthaMishra <sidm1999@gmail.com>
>> ---
>> .travis.yml               | 17 ++++++++++++++++-
>> ci/run-static-analysis.sh |  9 ++++++++-
>> 2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 4684b3f4f..9b891d182 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -48,7 +48,7 @@ matrix:
>>       before_install:
>>       before_script:
>>       script: ci/run-linux32-docker.sh
>> -    - env: jobname=StaticAnalysis
>> +    - env: jobname=CocciStaticAnalysis
>>       os: linux
>>       compiler:
>>       addons:
>> @@ -59,6 +59,21 @@ matrix:
>>       before_script:
>>       script: ci/run-static-analysis.sh
>>       after_failure:
>> +    - if: branch IN (master, maint)
>> +      env: jobname=ClangStaticAnalysis
>> +      os: linux
>> +      compiler:
>> +      add_ons:
>> +        apt:
>> +          sources:
>> +          - ubuntu-toolchain-r-test
>> +          - llvm-toolchain-trusty
>> +          packages:
>> +          - clang
>> +      before_install:
>> +      before_script:
>> +      script: ci/run-static-analysis.sh
>> +      after_failure:
>>     - env: jobname=Documentation
>>       os: linux
>>       compiler:
>> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
>> index fe4ee4e06..6ae032f54 100755
>> --- a/ci/run-static-analysis.sh
>> +++ b/ci/run-static-analysis.sh
>> @@ -5,6 +5,13 @@
>>
>> . ${0%/*}/lib-travisci.sh
>>
>> -make coccicheck
>> +case "$jobname" in
>> +ClangStaticAnalysis)
>> +     scan-build -analyze-headers --status-bugs make
>> +     ;;
>> +CocciStaticAnalysis)
>> +     make coccicheck
>> +     ;;
>> +esac
>>
>> save_good_tree
>> --
>> 2.16.2.248.ge2408a6f7.dirty
>>
>
