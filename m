Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE64FC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347457AbiEZNCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 09:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiEZNCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 09:02:34 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34647CFE15
        for <git@vger.kernel.org>; Thu, 26 May 2022 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653570149;
        bh=GxggW2RZGm8ngMAXrobTUgi3NXSMYvZrgdAPSvJTpt0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KZjm2EKHZpBDefZ4gvQrqPzwoi9tBR8MLnQx0bo9HBUNzcgoXsK2x8bRQrtYS259z
         g1p/jD4zxSAxVXoXMMQY+8haNCq7iXbxLHXL7uYi7hQDPLyvK8vGLQSSawETJxuieL
         YNBdhjpQtR7wrv6rOx7RjteFELyjOIGO4cMlbZrc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKFF-1oCXs034I9-00PkTF; Thu, 26
 May 2022 15:02:29 +0200
Message-ID: <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de>
Date:   Thu, 26 May 2022 15:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
 <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FvhOQPIdkqcAf69bETGTcGBbG1p2E8tAujrzKgr1eYij/ZQ/Sp2
 504xOH3hzdKgUVBy+B7LqSDo9D5GGcny7Eype1EtV9Y1TM3aa3fPEoXi4BvdoX5WA2N68/o
 mCbwefdk7cHRvhouy9nT9WPC+CXJYNZJBintg7vXZ/gIrKLLG5RUL7vLOon+aZyEszq3ZBx
 JC730tyjvplGRJroabTPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aXxHZDcERNE=:OHbUxTYllOh4VIpDp4hO8/
 /QxqMeu9FiAgzlGx0acsoJZi+dd6dK4MxeVWASS31Bvc+o8URE6DN2HjoHUiF5wnRrDI5xlgv
 kVErBSZc8H5wkLD7cFBEqlZAqo+m527j6UcgYUhs1SA6I+nlxqWhL9gHFmwPRkJN1kw1k4n3+
 TNGaHPMhHp6/sEO2xAn2NrK54i+uPLV3UabExvMq3W9hIf0BfZEOVXVa++7SMXEpkGRAJJIGV
 Y/nKj70hrk7nZvOUMS2YbBQfUc22GXhG7fC0TJ7zNkFyPou56QM9pFYhzCB1DoW6eKIvBthWy
 1SrMWggmddbO+76TVZ0j1q7XvjkPZv4hqpswwa1ZhPA2y/9YWLm0aJkxdhUaHRYS297gDFyNg
 oCwdbzoM6GBhonQs8+FpoxthFXbqRrTwrAUmnpz/2jLLDeisZWJqCO29MvsfvtaFh8uTvu7aF
 xOhH5nIGhdYBUNt+y6Nz4zsJXycXHdQCoeWpFeBh1OtYQdUW4yK0Zkrq0h3RXEjbG3V58Fqdx
 3Lv3aCvovuL6CFICfzY+E5nKWwK0vI1SYHfadgK4z+o6PPsDkyfT7aqQipcmeUOHazTxgu9UA
 qcJ010rERV0Yjsg83hCLHNFzbzt65GvbVnMidOCIqn7JBE6nRthb3zU3ou7It8iOq1fKj537j
 jOBQajCxIbO13PxpkpGFyn8w4vikzUbczt8OkMx4/ZF2YIRjUgMYQyxyvQNHsGZLM6Fmp44ik
 vX+bm96PFm9uu5GlGo0XiJ8YIjzt3kOjlb/sRifaPamrBdqfj/OGGhjzJTYf15sslNwoVZlh/
 dzODUktDmsQ2SLeXGMoZTzrR/vGjkrP9+qBij2Lh7y0SnivGgYTpQhZepyVeW0u6k/rCB2ABn
 KA4mFKnrS8MHPGrUgYPETf/tHQoRXjqNyQ2Dkzx/onUaDmffA/+zqgleGB4znj9si7N8io6Ur
 xnR10/DKZwEV2IPl63C8/j/bPKX0IwqCfcg5eKuFa6XEro85wmBrIp0R2k+K9cbp0fzwHYKm8
 JMz5APV4B2N0XLihnkGI1bnzyh122ecC5zFRI3hs2SD5TJq/FPcgd27UWngB95ZuaNSCt925o
 rQgTgIQs5Y0gd8iltdip8q1qbRHFIESXvTI
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.22 um 11:40 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
>> this option is now removed as stated in the subsequent release notes.
>>
>> Fix the option tip.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  builtin/rebase.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 7ab50cda2ad..6ce7e98a6f1 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1110,7 +1110,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>>  			parse_opt_interactive),
>>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>> +			      N_("(REMOVED) try to recreate merges instead of "
>>  				 "ignoring them"),
>>  			      1, PARSE_OPT_HIDDEN),
>>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>
> I have some local patches for this more generally, but for
> PARSE_OPT_HIDDEN options we never do anything with the "argh" field,
> i.e. it's only used for showing the "git <cmd> -h" output, and if it's
> hidden it won't be there.

Hidden options are shown if you use --help-all instead of -h.

OPT_SET_INT_F always sets the struct option member "argh" to NULL.  The
string changed above is the "help" member, not "argh".

> So there's no point in changing this string, nor to have translators
> focus on it, it'll never be used.
>
> This series shouldn't fix the general issue (which parse-options.c
> should really be BUG()-ing about, after fixing the existing
> occurances. But For this one we could just set this to have a string of
> "" or something, only the string you're changing in 3/3 will be seen by
> anyone.

What is the general issue?

Anyway, the new help text explaining what the option once did is a bit
confusing.  It would be better to focus on what it's doing now (nothing)
and/or why we still have it (for backward compatibility), I think.

Ren=C3=A9
