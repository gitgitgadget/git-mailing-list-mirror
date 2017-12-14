Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8A61F404
	for <e@80x24.org>; Thu, 14 Dec 2017 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbdLNXvJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 18:51:09 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:38959 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbdLNXvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 18:51:08 -0500
Received: by mail-ua0-f181.google.com with SMTP id i20so5107686uak.6
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9f0+4/8q/WKBivaVk4psKDxNi66qBhN9dhs7p+JibLk=;
        b=beRhYG3FYQRCtrkoeB8vDST3/blmaaFrCBMMXlq/k37q5bT8fZ+MlVsnV5cKI4FiAO
         Soe6j3JJKbw0fHOmi3aXNisvQL9Xk4WoVnEDE09+ymOrWRqqspWrW06HfIEpCbi1RoOZ
         zwGpw3alnXXzBEaK+Jo92QYEiBFPDf+8G1EjtSIIsAbgE9usDffqbIz+hSFsx1C/6N/q
         AYxIVLHLcmAd6NyMcNFANBcFvQhLm/P5qKfjS4+S4mB9uQ8AcVvD26QA1TPFBznckTZa
         9bJJeen0ZybX+vk1jbp6XfRxK1yzy3ULH8GwUGQvy9wM5mLpjVLeZJ0PzY4zwdE8guv8
         El/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9f0+4/8q/WKBivaVk4psKDxNi66qBhN9dhs7p+JibLk=;
        b=nL7eO/tPX8exXydojMfe3qAn6h1bkYmglOLSUCOMBjdNuJ3yPJ3lKTOi4paE91Tkeb
         seo7/t3/YYsmPsPzOIp4zH6tN/dd7Ya4R82Xz4u2G8nuwBsRSCUlflNHGnvium3pc+th
         wlXtwOjgVS0Y08Mqm8a2Jd5hmxo56mqPDZw2AWPfLvtXLM/MtUJz/+g5excWmHliY/7P
         xHN1LXAG8u9rVdAg9vLCilw5x5gKvaPPhGre0/6/yQY7wm5asIqwBD6uysJUKrCiHMqw
         OB//525uNLxrJ3r3be0WlvjMIUIS+wZ9bWbaWQ6b5NJEp0KBS054gK9IpebL1hbCZmm0
         WPdA==
X-Gm-Message-State: AKGB3mJBBVM0T1qt17vpPoeJkGG+8r3CpA8yZRIHhnqI82pSdTNdvI0E
        CL2ioOihWGmMSjbZsuIFX2uwDGRjGCHgcO3gCug=
X-Google-Smtp-Source: ACJfBou/7vo1xT2EFo4uui1KijTfSmwHiyRtjlNdxoAN7xDy9+AV3VRLEqy5/5P3gKW6vfXh2Y3BlzZ3+HRjfIQjsm4=
X-Received: by 10.176.29.147 with SMTP id l19mr12706315uak.37.1513295467450;
 Thu, 14 Dec 2017 15:51:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Thu, 14 Dec 2017 15:51:07 -0800 (PST)
In-Reply-To: <77E6AE23-44FF-42E0-94FF-C4B35D913D5B@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com> <20171211233446.10596-1-szeder.dev@gmail.com>
 <20171211233446.10596-2-szeder.dev@gmail.com> <9AAC2BCC-AA06-46F9-8E6E-1D99CD959FDD@gmail.com>
 <CAM0VKjkVw8QeDErDg9aXcQ1sAgY34eBEeA0QJGamvEEBOG8y9w@mail.gmail.com> <77E6AE23-44FF-42E0-94FF-C4B35D913D5B@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 15 Dec 2017 00:51:07 +0100
Message-ID: <CAM0VKjkv0XqHf8s94Wj2DHsD49gTP0M6HU2AY=36Jj-5SYhS9A@mail.gmail.com>
Subject: Re: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra
 tracing output
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 12:10 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 12 Dec 2017, at 19:43, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>>
>> On Tue, Dec 12, 2017 at 7:00 PM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>
>>>> On 12 Dec 2017, at 00:34, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>>>>
>>>> While the build logic was embedded in our '.travis.yml', Travis CI
>>>> used to produce a nice trace log including all commands executed in
>>>> those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
>>>> code into dedicated scripts, 2017-09-10), however, we only see the
>>>> name of the dedicated scripts, but not what those scripts are actually
>>>> doing, resulting in a less useful trace log.  A patch later in this
>>>> series will move setting environment variables from '.travis.yml' to
>>>> the 'ci/*' scripts, so not even those will be included in the trace
>>>> log.
>>>>
>>>> Use 'set -x' in 'ci/lib-travisci.sh', which is sourced in most other
>>>> 'ci/*' scripts, so we get trace log about the commands executed in all
>>>> of those scripts.
>>>
>>> I kind of did that intentionally to avoid clutter in the logs.
>>> However, I also agree with your reasoning. Therefore, the change
>>> looks good to me!
>>
>> Great, 'cause I'm starting to have second thoughts about this change :)
>>
>> It sure helped a lot while I worked on this patch series and a couple of
>> other Travis CI related patches (will submit them later)...  OTOH it
>> definitely creates clutter in the trace log.  The worst offender might
>> be 'ci/print-test-failures.sh', which iterates over all
>> 't/test-results/*.exit' files to find which tests failed and to show
>> their output, and 'set -x' makes every iteration visible.  And we have
>> about 800 tests, which means 800 iterations.  Yuck.
>>
>> Perhaps we should use other means to show what's going on instead, e.g.
>> use more 'echo's and '--verbose' options, or just avoid using '--quiet'.
>> And if some brave souls really want to tweak '.travis.yml' or the 'ci/*'
>> scripts, then they can set 'set -x' for themselves during development...
>> as the patch below shows it's easy enough, just a single character :)
>
> Hm... in that case. Would it be an option to "set -x" only in the header
> of "install-dependencies.sh"?
>
> In "lib-travisci.sh" we could keep your "set -x" and execute
> "set +x" at the end of the file. Wouldn't that give us the
> interesting traces without much clutter (e.g. what is $PATH etc)?

Hmm, that's an idea worth considering.

Scripts like 'run-build.sh', 'run-tests.sh' and 'run-static-analysis.sh'
do basically nothing more than run make with different targets, so on
one hand 'set -x' doesn't cause any clutter in the trace log, on the
other hand there is no benefit from it either.
'run-linux32-docker.sh' runs docker (the command) twice, so it's
basically in the same boat.

I think both 'lib-travisci.sh' and 'install-dependencies.sh' benefit
from 'set -x'.
So does 'test-documentation.sh': it executes about 15 commands, among
them a bunch of 'test -s <file>' which fail quietly.  With 'set -x' we
would see the last executed command and know that that's the one that
failed.

As mentioned above, 'print-test-failures.sh' definitely suffers from
'set -x'.

There is a lot going on in 'run-windows-build.sh', so the output of 'set
-x' might be useful or might be considered too much clutter, I don't
know.  I put Dscho on Cc, I think it's mainly his call.

So it seems that there are more scripts that would benefit from tracing
executed command using 'set -x' than scripts that would suffer because
of it, and it doesn't matter for the rest.  This means we could issue a
'set -x' in 'lib-travisci.sh' and disable it only in
'print-test-failures.sh'.

There is one thing that triggers my OCD: whenever we echo something, it
ends up being duplicated in the trace log, e.g.:

  + echo foo bar baz
  foo bar baz

We could workaround it by writing 'echo "<msg>" >/dev/null', but it
feels hackish and I'm not sure it's worth it.


G=C3=A1bor

>>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>>> ---
>>>> ci/lib-travisci.sh | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
>>>> index ac05f1f46..a0c8ae03f 100755
>>>> --- a/ci/lib-travisci.sh
>>>> +++ b/ci/lib-travisci.sh
>>>> @@ -23,7 +23,7 @@ skip_branch_tip_with_tag () {
>>>>
>>>> # Set 'exit on error' for all CI scripts to let the caller know that
>>>> # something went wrong
>>>> -set -e
>>>> +set -ex
>>>>
>>>> skip_branch_tip_with_tag
>>>>
>>>> --
>>>> 2.15.1.421.gc469ca1de
>>>>
>>>
>
