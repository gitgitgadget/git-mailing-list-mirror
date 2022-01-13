Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B64C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 05:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiAMFLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 00:11:03 -0500
Received: from mout.web.de ([212.227.15.14]:38329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbiAMFLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 00:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642050652;
        bh=/na6zqTEKLPOmYcDCozgEgfmED+2/EDuqSePt113hqQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Cn/uLmasZ89ucXgrp78Yb39u9ZCdXHzPP7fiLZZZKHTzaCgrffQXuVae8j8CMfjHu
         qeJ360JzESEVVG1Fq3MHwoi5z1L2zUlFlCvCrDodbKcxLJp1otpIPC3pE99AevV6hh
         Z7qlX8FwQ4A/duHDzIdRcFmaZzhocGJQrWj4MyzM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1mQHUg3Apq-00hwor; Thu, 13
 Jan 2022 06:10:52 +0100
Message-ID: <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
Date:   Thu, 13 Jan 2022 06:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: git bisect bad @
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
In-Reply-To: <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N/jgiUtikjxszGejTU7WZ+l9z5YRXBnhwlmsO+vptbywKlqOr3e
 FEt8Oj4vvvAPsHbeont7GVWt37y5Up1f3MqyNRrjPyGoqR0uw0V4TfjXEycrIxUvX/32KRs
 I/6IrJH20QAnqLGc7lbOr5ndCqNKxDsqIHFJ8E0wjf8qaqhfpVonbeHefCY53f/ccBWmdcm
 49Dv+LJLu28VPOBljVltg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AsgF8uWLX+Y=:CiUlY+oXX7GzK4cfXvcay8
 qaP9TK5/9+x3u0xO65gciGhyM+qRyvUUVTiHYPhwEU8bMfauJSppUJIeH5kBfnubvSv+9nRcp
 4M5EchTRjcXQehivXh4bf8cElhOVqJEHqmhcrdrL8foVCVBDgPmAeoxOQvOk26VaaVVSbh5//
 TiP6n4GZw3xxk5E0EoRHtugHnozHYnwP7oCTaHBeqndmRX1aPi7ZLEOc671uQUpVksPG3TCGK
 18OjbOVW3sp3OrTq7AmXOVomEN7LzVREaoBqXZDLTUsAEwCDf/0JqXhw7UfOh7lQfHrzXX3rT
 hCSy1NS1eDgxx8pAHYXNd+COFRidUryU2l9C8G710IlbRhRnWItBilgSkzQd2FSIFdMgHCnI3
 ejfq+i3Zws2SPjzcpS3+xTvupa+trR3FgMmGsB3dmibFpgix8QobDbgqIM/OZcHL/WdWvLit/
 vIW9oiik32VciEhxZq0x3slbswQTfxSaWCqThKNFw42wio5zzksEC3Pr1lvv4NSBxTe1MAT2R
 Wa4zPeDdQte7rg4gak3K3S+W+52Jz/Wdhd/bhUra8tHTfX3YfsGbpeAZZ10aDrXJpFirCOvTj
 gjfgAuRdux4KdVja5iG8V4C+Szu9obixJHR4bGE8jVv+JDCJjOkyaw7c6q5zf/U6Se9QtcBEd
 DWLWVs6x7QLSXSZ1tGHSsqxF7q3+d2D4QEhrc5wSxnAkVl2olPMxIxuTu10L/ZgFMB+7zF+G3
 9Wn0nfbERgcxd8RcgwzzbOZnVp0bNuLTy/521gCUqXIvFgUrn+jLqg8/92wrvwWTCkSBdAvrQ
 ivRjrcGUz2RdAsbRjTwP18w0JSi222PWGSUH7YlijT9opPIXiFezLptv7j5GBWYrnK8fEzePT
 S49U9Z0u0k2XSiJW4bO9GUhjvX3Agokad8n+Ab32CttXW2+ieZO2FkkJ0zYv9LxWzK6D9Mjd3
 q7ZIH5yVCJMqx4Wf3oIGT8sdOGKOM3rtq0fC7H5SyqS6yQ+kqf4A1WrnLJM5tHIolYuaBtiPY
 afTQ/5bBrqXvwm7a4GQmv+fjshd1fQjZG2amY2NgRpamxpE/hpEVqDQKjyG5wQqRd7CMdTtO1
 8hHRoxxOAqCOT8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.22 um 19:34 schrieb Ren=C3=A9 Scharfe:
>
> Am 12.01.22 um 18:50 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> It would be nice if we could determine if the command was not found by
>>> the shell and halt the bisection.  This is actually indicated by the
>>> shell using error code 127.  However, the script itself could also exi=
t
>>> with that code (e.g. if one of its commands was not found).  Currently
>>> this is interpreted as a bad revision and bisection continues, as
>>> documented in the man page of git bisect.
>>>
>>> If we'd make error code 127 (and 126) special by stopping the bisectio=
n
>>> (like we do for 128 and higher) then scripts that relied on that code
>>> indicating a bad revision would require a manual "git bisect bad" at
>>> each affected step.  Annoying, but not dangerous.  Such a script would
>>> have to be modified to convert codes 126 and 127 to e.g. 1.
>>>
>>> Seems like a reasonable trade-off to me.  Thoughts?
>>
>> Probably.  It is safer than the current "all revisions including the
>> bottom one and the top one are bad" which leads to the "merge-base
>> says your good and bad are nonsense" error for the "command not
>> found" case, but what if the one that reports an error with 127 (or
>> 126) is coming from something other than shell (i.e. the 'bisect
>> run' command was fed is not a script at all)?  Is it a no-no for a
>> random binary that is not an implementation of shell to exit with
>> these error status?
>
> The man page of exit(3) mentions the implementation-defined constants
> EXIT_SUCCESS and EXIT_FAILURE from C99.  It also says: "Cooperating
> processes may use other values".
>
> sysexits(3) on BSD mentions a few others, all below 100
> (https://man.openbsd.org/sysexits.3).  Its BUGS section says:
> "The choice of an appropriate exit value is often ambiguous.".
>
> So exit code values are only very vaguely standardized.  It's very
> possible that there are programs that use 126 or 127 to signal
> something other than "can't execute" or "cannot find command".  Under
> the new rules the bisect run script would have to translate them to
> some lower value.

Reserving 126 and 127 shouldn't cause too much trouble, but there's
also a way to avoid it: bisect run could checkout a known-good
revision first and abort if the script returns non-zero for any
reason, including its non-existence.

Ren=C3=A9
