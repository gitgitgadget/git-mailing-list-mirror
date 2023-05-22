Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0710C77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjEVUje (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 16:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjEVUjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 16:39:33 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEF893
        for <git@vger.kernel.org>; Mon, 22 May 2023 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1684787961; i=l.s.r@web.de;
        bh=hpM0MI4s4pEt4zJHtgCEyizAB2AWBvSmHmdeAWlDGbk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TMXLZzLHUEaUs8tBn/hHV4O9ly26mLyQYpGhIXXbQQwPTMpJyX4yTMpW0Pr1Tnjz/
         vp6EC/5cB8Rt6dbEJ3MI9M5ByeCpV+OLHVgKBAwunOnW7sNHK5YGmDwFs+z3Y9ofDz
         0DphzRT4NdZZ1B0hkJinBcjMXpCahhG98F2RUfNX/cLl1jJeWcwlP78U+8UY/1rc+D
         Zo/rYyToVoIyw845Pnvno30obXRcf66GJxKDtJcShm63kPlyHMNbVmic2khzOFWr/N
         +cE8fdgq2B9qDNYis4gRypCC7h+Wkba9AQwqUzTqCkl/gD9llmUXNh3vd8oCW52jK5
         UAAT7lANn11+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.41]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1qJh4H0Ey4-00s8iZ; Mon, 22
 May 2023 22:39:21 +0200
Message-ID: <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
Date:   Mon, 22 May 2023 22:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [BUG] Git 2.38.0-rc1 t1800 message text comparison
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
 <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
 <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JrGME8xwPF+ryDCFPBXeFLJTo/p7u9v1gAKEHCPXivOknRlG1HU
 SU693Axm0pf5uTPYhbJso5OliO4qzwnslzoyDb0LE2iqPWVt8VsFiCYkviLNZvP1D9J2Xct
 XooKZwBNmLsP9yVB5Wh5LCMCKzKwN4f1tWxe7kx4UHN4qpAoetcLgu9L5uJO/BXJKfXAaxd
 8zscVYWmXuPIiPCYQWHEw==
UI-OutboundReport: notjunk:1;M01:P0:79V9V1qe47Q=;8WZymt8S6HjCLqgC+zDA6uFU/P1
 HTdG88BvWG1Cs6QoyiZDqUtxcjKJIR7TiP5FTOqaPTOS5N5M5Nk4VwAQ6W2XBFfbA7Ejb47F2
 SsvYLNdpvaDt/vIG2CT+yyp/lzxdMnxcfD1McEzPUCbY9ZYxxpQFNodvIF5DR0NSRK9riK043
 Q+cGQICluqQ2Zdx9F/BjI2AYHYoXOmxQZza0jfOBHVVAvhBuR5Fls737HYeSLiEXPr7pslVTQ
 QyFJJDHHOTf2yblnTc310DO1CRTZ2WUGeaKa35GWPGel8/MSn6ATatYxeL2ZN8E7gQoLqc89W
 X2cVzaBHEMHYnlL6bHQk0vjpUP0xVRpVXgRsZPbS7CJrgSMpnNhAuM0fWUYKKStifaYgKahwx
 jClvBppbkNVTNbsontU/xYqLLBh87obt9/kJ2F86nTLkTNmDH8xLuF/vCa7H5Cfz1hqjkkQMT
 ArZOfAeyLUzYt1uJt6wO66BeFdXiN+7JFJC8tCttfHGvWsL6fokgV99mWcli7NQbjFsjtTX6u
 eKZruvAeVF6mUyCRpuFid/7Rmfwg+3alQlKFXiJI1qSION6Ns/H34adCtQXAkXlFGcBOS+f4r
 VbA6W7yT3LADAfuE8Yo3gxpCV3fqQiBppO4O3GuWNDmiKQEzr0cnZrjMVA5yJFz0bqv0DlKJb
 fxEpdl9qJkgfENwbb/vSZUTmuNY/BLWHWVdjC9tVylf2817jLdwXfY+wnl/0J/c2p4wLR9hpg
 7rS1WEnLQHuir1RTdjkpWBTrJYkj0iTeuOkZi2OJdgdbmmL6CEBZni9408Cc67RlQeNRNP70e
 dMq2ZJCQhbcGZsUDhg4pWsOtyT2QI3WzA+fZzAMxcOYlwyif8NSbD7BeByfQu/f0DB6QpXBam
 GhTrB9F9vQQSs5Ozwdp9mBnsdl6JCQDaTBxIq4RKcBHE0zzIywDjXbLThE2V1WeiuPPdUAJkC
 KYewSg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.12.22 um 06:53 schrieb rsbecker@nexbridge.com:
> On September 23, 2022 4:43 PM, I wrote:
>> On September 22, 2022 3:03 PM, I wrote:
>>> On September 22, 2022 3:02 PM, I wrote:
>>>> Rc1 is looking good except for this test.
>>>>
>>>> We get a diff as follows:
>>>>
>>>> -fatal: cannot run bad-hooks/test-hook: ...
>>>> +fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>>>>
>>>> It looks like the pattern
>>>> sed -e s/test-hook: .*/test-hook: .../
>>>>
>>>> needs to be a bit extended. Adding
>>>>
>>>> sed -e s/exec/run/ | send -e s/["']//g
>>>>
>>>> might help clear off the other noise.
>>
>> A patch that might work is as follows:
>>
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh index 43fcb7c0bf..9a7236=
31a2
>> 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -173,7 +173,10 @@ test_expect_success 'git hook run a hook with a ba=
d
>> shebang' '
>>                -c core.hooksPath=3Dbad-hooks \
>>                hook run test-hook >out 2>err &&
>>        test_must_be_empty out &&
>> -       sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
>> +       quot=3D`echo "\047"` &&
>> +       sed -e "s/exec/run/" <err | \
>> +               sed -e "s/$quot//g" | \
>> +               sed -e "s/test-hook: .*/test-hook: .../" >actual &&
>>        test_cmp expect actual
>> '
>>
>> This does not require setting up a prerequisite for NonStop and the
> technique
>> might make the MING code easier but adding a change from spawn to run.
>
> This is still broken on NonStop. Is there any hope of a resolution?

So trying to execute an executable file consisting only of the line
"#!/bad/path/no/spaces" causes NonStop to report "Permission denied"?
That message text belongs to error code EACCES, not to EPERM ("Operation
not permitted"), right?

POSIX allows execve to return EACCES if the file to execute is not a
regular file and executing that file type is not supported or if
permissions are missing to one of its path components.

Either you have something called /bad that is not a regular file (e.g. a
directory) -- then it's just a matter of changing the test to use a
different supposedly non-existing filename, perhaps by creating and
deleting a temporary file for just that purpose.

Or NonStop correctly returns ENOEXEC on the first execve(2) call in
run-command.c and returns ENOACCES on the fallback with SHELL_PATH
(default value /usr/coreutils/bin/bash), because you are not allowed to
execute that shell.  Then SHELL_PATH needs to be corrected.

Or valid shells need to be placed in some kind of allow list to be
accepted in #!-lines, lest NonStop returns ENOACCES on them.  Or NonStop
is simply reporting a bogus error code for some reason.  In those cases
you probably need an execve) compat/ wrapper that corrects the error
code.

Or I'm missing something here, which is a relatively safe bet.  Anyway,
depending on the cause of the "Permission denied" message, loosening the
textual comparison in the test might not be enough.  There may not be a
point for end users to distinguish between "exec" vs. "run", but the
silent_exec_failure feature of run-command depends on the error code
being ENOENT.

Ren=C3=A9

