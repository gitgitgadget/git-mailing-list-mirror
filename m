Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F36C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 14:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E07E60524
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhJIOl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 10:41:26 -0400
Received: from mout.web.de ([212.227.17.12]:43341 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233581AbhJIOlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 10:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633790367;
        bh=qMHGqMxBmiYJ8RvuxpLFCBo5d7jrve+DbU1CcZAtNG4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YRZAKI1r4fCc3QYIINKISyqSYQDMW4M/kfmCj+uZPaqMEnXxdYaOz+shmDutPddUL
         K4sHPUdW0aE0I9kRXOMfQIvk9OpDvBVRI20W8HHCnQ0HpRQAPePxIdHWFhguYMogYs
         znfHOFbI9M0YdvngTCm07YAho5OnbtpcurIRg3RQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MXHbN-1mE69q0iRx-00WHEM; Sat, 09 Oct 2021 16:39:27 +0200
Subject: Re: p2000 failure due to empty reflog
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
 <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
 <8735pfjg47.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <23cfe67d-5a7c-6525-cb50-396cbd1121c6@web.de>
Date:   Sat, 9 Oct 2021 16:39:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8735pfjg47.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kb08OPwdVDj4fVi6nc6cjCfNr+wRxAbBw7cmeRyu1YiwIB8hOk1
 dtaG1rK2lKfmPtLW0UxElJHKg/vQnBzos/0laILFk8A6Uqmp1ToGuBRrxeuUp84Em/Yr3Wq
 LObUTf8BIkX7vtJ/3x68Nu9OYCfcE/w6LwOxU1LSYxFzfYqk/iZySso0F1P/JarR4e1pub2
 KMCnd+77Ev1tvHK312h2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MkBrbr5hkf4=:o86JOMc/K9gefO11OlYCJF
 6KcJ4iDEL9FhJ7QcSjmpUvX4Ir/vws/o8zn147BN4m7SZJ5X69TU0BrNd7Np8GbV7bPZT7AYY
 OWA0HPuw3vSRuR3ZuBCkxFeRf5yH0tpVMjotnt7wYGV9Tymd2jHFzCJYS3Uo3PLkcKyblldbk
 6GyzM+6KJdZqUeTToAGw7PhKnUge1QR8DwDATe/VKOGMsyfUlUpIviG1o0Kj1YkDpZjQCPd5s
 90p/vdDs3NbAY/H/FNQp62cuTe3oWWB51X1iNlflNKR6x1pa504PMrGmN36L3kVWGcXKg/A6S
 IqcE4yXphmZWOXXgqC6v5noaraqc8CZb5k4OAj3yI6dAGF/9sFn7ZRD2ZBVD+WGvxedX/Cx26
 GWMifZrqu1BDV3GSFPvFI6mj8avY0DdFZkJf2cnWVzmR0DzC4hrHRqk4DhKnZTiOrU5xljm0D
 WB7a8rumtNR5aU5NnpUEGvPA9COxt/EpDwbour+w//eKkQPEYtXaW/uuSEK8jDo7s4nNPNW7y
 Xrck34e+3CZSyX1Qvew2E30474m4b8QB960O8A2x+miCWD7yd7TPw+CEdDxJSY3GmsMXuk8oi
 hz5YPSr+spH269anqmCf1aO0JT2rLsoc+T9M0M3iGokEMrLeM7U4cqwYfiwRw+iKTuQp8KCYR
 6/boY0wu2ocP/Xy03FKtho4RGng5yciNMJhnw3PggKwocxF/2qZzHbG7jXbT4os9CNyPzH3Ay
 a78+9dJp0W8DbyTYE7nhV053xbpSz1WCDvl5iBRWV5u+QLv6rfqeLA54mNgF/w3Ebjuzk1ZEQ
 YAKsSTaeOw9toybAjbnkst/KFFrS4jrR4Nm3a9h5zLyIBVV7aTlznL5zz1Db7llkEI3p9ZOYQ
 mhoPe7cz1KDFVQhqqCX1vHvzy3sqT9weHHueOQaIA5u4IEBCdu6Dx/vw7vlR/vBy4jGkzpIew
 2o5KMpueu/zgaFLhZMCLncj/8tU98ams/0IgQFf56TxpOrwIfc8Mei0rxlP50d7Oax4OixkO/
 r1kzRJST/ci5xe0woX5o0zuBP6HO53KGOekql0EI/EeanG/vJv51YGPCf6+rxLHw1bu0deDSm
 djxCExp9wy/tNk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.21 um 23:38 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Oct 04 2021, Derrick Stolee wrote:
>
>> On 10/2/2021 1:37 PM, Ren=C3=A9 Scharfe wrote:
>>> p2000 fails for me and reports:
>>>
>>>    perf 18 - git checkout -f - (full-v3):
>>>    running:
>>>    			(
>>>    				cd full-v3 &&
>>>    				echo >>f2/f4/a &&
>>>    				git checkout -f -
>>>    			)
>>>
>>>    error: pathspec '-' did not match any file(s) known to git
>>>
>>> checkout fails because the reflog is empty, so the "-" can't be
>>> resolved.  The pathspec error message is confusing, though.
>>>
>>> The patch below adds a reflog entry and allows the script to
>>> succeed.
>>>
>>> Before the "test_perf_on_all git commit -a -m A", there are two
>>> reflog entries in each of the five clones, after it there are
>>> none.  How is that even possible?
>>
>> That is certainly confusing. Is there something about your global
>> (or local to your test repo) GC settings that cause an auto-GC to
>> prune the reflog aggressively?
>
> Perhaps something to do with certain parts of the code doing a
> time(NULL), and other parts faking up times to be 2005-something?
>
> I have some WIP patches that run concurrent "git gc --auto" with a
> detach across the whole test suite, and IIRC I had to search/replace all
> time(NULL) with my own time() that faked up (looks it up) an epoch of
> 1113465166 to avoid this exact issue.
>
> If you try doing that across our tests I think you'll find that the
> @{-1} syntax (reflog-powered) will start failing.
>
> But that's from vague memory, but perhaps it'll point you in the right
> direction...
Yes, that helped.  The reflog entries have fake dates in 2005, and "git
reflog expire --all" called by "git gc --auto" deletes entries older
than 90 days based on the actual current time.

Ren=C3=A9
