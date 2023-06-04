Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7233C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 20:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjFDU4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 16:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjFDU4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 16:56:19 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD1DE
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685912155; x=1686516955; i=l.s.r@web.de;
 bh=odiNyKvFMplQK4EvyjwW7eSfI+Mpw7vVigNd18cYwu4=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=u+QEPlx4SpKSdHmZWdYkEYv8095MwJlbJCsuAkbJWSe/1fFPzN3s7ERVPfhQnl1+seBcPAY
 HL0grEZHAu5ACeWjUj/wwoB/XLiOsNUNvBa7A5MVwgbslhfXYvyy+M07+qh/oBX8FP4Xd+SKX
 u9hHKm41yTxJa8am0mHRTZbD8zO7s0gfex/TgH35bH9z+Fqvt6cLEF+bWqvSHM/aN6R9T7c8o
 I9XJ8AAViWrYmZOhNmnR9EVSg1cvG3vEjFTp3buNuhT5Tp1prsF0ztKeaIOKCJQVUb4QcgBK6
 AnrMSBGOVcPc98D1UhXjPkxjJ6fPvqu6DsehEFip2UeHuYJaFWjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.146.76]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1q2t1i2Iij-003iVj; Sun, 04
 Jun 2023 22:55:55 +0200
Message-ID: <28d808e4-77b4-d91e-8a86-c21287019b56@web.de>
Date:   Sun, 4 Jun 2023 22:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [BUG] Git 2.38.0-rc1 t1800 message text comparison
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
 <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
 <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
 <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
 <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
 <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
 <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
Content-Language: en-US
In-Reply-To: <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/y2xev1i/zjPYaX4rQDuE4SdiQL0PcNtWKRRk1EP9k75XgIjhBa
 bihB8ZOiXLFSGQLOH4wOWDh5vx1Z7oK7oQfp5CAcunTdQ0QCcooVvIMk8caXJkawODooAzB
 0KuRM3yxIKfVmRte/vNP+M5j1YJIEeoAHJP/dOvW1hD+64DdwuyKV+z0tGTOqF89WXIVOzJ
 TWPBRuUuPLGT8ubsh6BDA==
UI-OutboundReport: notjunk:1;M01:P0:D+8cz4+mlXA=;bbaMjVwAj8CVx3SO4Gn7SLw+Ule
 ZatiiByyWw3660+/7VgMA8GjSCAOyEkqXCkE34QKYDjjGvvZe+nNlnL61On6Ow5DNGaR0XOnt
 ytyGGav421lPqqGH81taZHNxfEdvtUUJO47Zt06hNNrpph63tLRyom7zaZmzCRq8WIu5ErngU
 559mTn+wjhwr1jU01PlrUL8/DkAdPauN8yLzIk5ApVvPMkBjZqBdSIrt39M4CQm8X7rSctQga
 8GCA1uVX/uNKnGQ01wzeSusIJpAJcgyFA7TsS36DbG/qQApzzznnw158ZQh6pPpDLWlVwNUFK
 nU2WNFdhTd2ODjN/Vo7jkFqhAZsxPqFh6oygdTQSoS8jaoil6HufH5lKQVDnBsmlxnfHfH5v4
 XkHO3ze1JbquxKLCnxkzXoMw6cf5K/sSLLcUmnTFQL1IN0JzlBpjVZnsTa1Xe0lP2VNUBAzYf
 Ur7xn+I7iomtFk3k36wMRMHz1Q5zu8OmPDTqIhGElULjoLDBohBvSC8yuiO2+s0zV8+hwlTpX
 K8fMGml9fLzkPG7ii4/ZEB4YXHAATLL80VpXeaPutrK8nHaNCgPZWDakhkN50rpLs4w+lt8B/
 YwiCEa6FzgMvnLbcMoKVhA0je+2V3qE54fYDl4y7HlrVBwitBhbntPkL9bm4AgKIjF4a09ff+
 V87PYj03DNZ+whG5VaLKsUFrXHjrCZTIstzhbcgaNzo0SEw1mNDNyTuS5LMWf7gFrP4T/wP3F
 I5NjKGf6hNo7+pyh4rkYV04m3xupL1aA27wPSVGcJptY+WYWmgZ57Wc6vzBZJST6Mb57JsoQN
 spyu1R3SN2AKB99oiRTKyHWWFOMgAGhSzxaVf10XEfCF0vL+jLQEm3Ff+47hZwIo5iaVlyzWR
 01TDrRJJ0zAGvvt7cMWitItsBYbzq/ejV6TCSUOislKgZo6xc7uewJgTENzyw6wPhRGMeeQ12
 O1NaEA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.06.23 um 14:13 schrieb Ren=C3=A9 Scharfe:
> Am 22.05.23 um 23:13 schrieb rsbecker@nexbridge.com:
>> The following is a potential fix:
>>
>> diff --git a/run-command.c b/run-command.c
>> index 60c9419866..b76e117d35 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -846,7 +846,7 @@ int start_command(struct child_process *cmd)
>>                         execve(argv.v[0], (char *const *) argv.v,
>>                                (char *const *) childenv);
>>
>> -               if (errno =3D=3D ENOENT) {
>> +               if (errno =3D=3D ENOENT || errno =3D=3D EACCES) {
>>                         if (cmd->silent_exec_failure)
>>                                 child_die(CHILD_ERR_SILENT);
>>                         child_die(CHILD_ERR_ENOENT);
>>
>> This does pass and should cover all POSIX interpretations.
>
> That would misreport execution failures due to missing permissions
> (think e.g. "chmod 0 file") as "No such file or directory".  So this
> should be only done if really needed, perhaps guarded by an access(2)
> check for verifying that EACCES is bogus, and only on affected
> platforms.

Actually the difference is a bit more subtle.  With that patch and
silent_exec_failure on, missing permissions wouldn't be reported
anymore, and with it off the eventual message command would change
from:

                error_errno("cannot exec '%s'", cmd->args.v[0]);

to:

                error_errno("cannot run %s", cmd->args.v[0]);

So the actual errno-based message would be the same, unless its
suppressed.

What's the significance of "run" and "exec" here?  Why do we have both
variants?  Is it to tell apart errors of the actual execve(2) call from
those in code leading up to it (e.g. when searching the executable in
$PATH)?  But at this point we are after the call, so why is ENOENT
from execve(2) a "run" thing, not an "exec" thing?

Ren=C3=A9
