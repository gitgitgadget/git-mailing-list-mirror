Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0530FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39F9207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PwRzqfQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfLIQjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:39:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:58063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfLIQjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575909554;
        bh=NJU8H0Um1wgggfTxdA3tUuxMLOVMDQUumCqNKJ0DtnY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PwRzqfQX342ay8yPidKZqhDvMv+ZDPRmcbOz/GZ+91HyT/NXhnoTpDqjJ6Bsy4bwC
         5nIYoDbnPMoLTmXqYpK5nyZXvZGB0XurYWInICKs+sB3qTALzWUEHhMwERbT0qtWJC
         6ycomp+mrbIZor6e/+2nA16e6Waw7wSdRU7DsJ6Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.32] ([87.180.191.241]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1hd9K02p8w-011QRa; Mon, 09
 Dec 2019 17:39:14 +0100
Subject: Re: Git as data archive
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
References: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
 <60945f9c-d79c-7806-0c5e-3e2affcea001@iee.email>
 <1c81112d-5a1b-a791-b43f-d6a67d5b2e04@virtuell-zuhause.de>
 <76f7d2f5-45fe-a43f-2121-954e1a497b4f@gmx.de>
 <d4e34fa6-e92c-5178-c61e-e4b87dab7e09@virtuell-zuhause.de>
From:   Andreas Kalz <andreas-kalz@gmx.de>
Message-ID: <fc38fbbe-e481-6a36-162e-34465f0a5bb0@gmx.de>
Date:   Mon, 9 Dec 2019 17:39:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d4e34fa6-e92c-5178-c61e-e4b87dab7e09@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M1ww03ePLRqUmocirdsttfhBsLwPLJqW45KGNDqFrm7UcMXCcD+
 VakLC+95Is6vIXu5ScpEMGk1LOSqp4zJ4VITnV6JAvIlpJlGORFIrqgOuDhK69z8ERfU4JY
 hWqYhiKG2LqCwquSsMUyXCEw5Ov8m5srJVbLry5Rl6YNt+0EO25IOuHBa12ZJZugnIXcDhz
 zG+Hwn3rLKh/yogQl9q/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p1MTetFhioU=:f+wQzmqtsqzoBvR2fkGZfy
 N2nlDeAwkHPKVUOqWr01RNbbwefGb0M4fTBVvW4xdibExd0it+FfL7ljjKFf6RMaScJOHI2Df
 /mGA0Krk1UqquC9ft7h5migc7AyhEjXs1J6pWzz2Ro0Ilaz1SNyGfGBW9G9M0mNBf0QIsQJNk
 VNcF4mbwGiiK0beSNe2yIjbjLHDxcU0NKCLuPf7c72gFKPmzJ/31aeP+hQ4USAPA8xTQ8Zxpe
 xmTLJzbVC09uwrmmqUMmtQGOj4oZBpAmoN/kKSw3KgtfK26lnuUNiTCPwohyOcQeaa4RUy0Fh
 w7/bDxgUUM89CBqvydhCfv3NY9pyvgSCMNZIM/W7WAoPxsCo0ei0Q6kM3UudorO7wKx68FIz8
 0jjbMhMLUszJc1EVoHHWCDSY+J2CyJEeUyQ+zGLkbZq24sX49fdephAEMqTzI5DbfNKkxt2+U
 FHt4tWu0TaXPdIHmeVpgq/xrXTpo/bOCGaTlRSktXin5Vj2bsI9WXKVEQQASFtxi+9g7bCPNR
 dCD+9C37add6jC7p0pfI90n+HMO1eppyJnayoSAkZx4kDynD7MQcYfFOfN04zDVE3+FnL0A4q
 hZ0QQdcx5jV8WhX/wasL9oNDHZ4ygZF3wOI4JSKq6zUwPd2fdyx5zTM0Z1YAu7fKOHmcHpIfC
 8R15ZSxacRuVBXbLQuh4I5c4QlBoER5Rj+9vRueHfpHfzDncDxzcVLYUGyVA1pn85ZKj/ap9y
 CprxYgrAbTIoW7ODvLLYTbbo8gPBpJ+7PiLQubJmr9ct5P+i28Y/O8TkDQH2HDIFCAnuGQ3FA
 lScvLk/oUWr1g/+I/Y+npJ61mGrQbWvDJN0cRl3CP/cKNUlmNWFa2xvmSNdEFDYmHaiCVawIQ
 FXeZIVQp3j9iQYe974+Bx4DnqIvtndcYPVheGEdo0dvZsQmUy9mcJlWdg3h0mP6E7s1y6tW7i
 kyCFYDwVnzbw7HkrhtIlGMOCHWWVNh35WtOmxDoz12Wdw41Oz3P5GZX77+bRphPuEzLpqZdGz
 lfHccquvlpntAjvBzDGHbOamy11XlpyXkzVN7KGBFVBEFv+j+ohFt3xrcsgsjDfmReV9in5Yj
 62QQZrr7rO5k0KXxNzoaSn+963G6z+JPyLsootzaGCEMr01c3N8RAjehJaQPk/bbYRO54VPRW
 Yh6hTYlRxNXQzDJiQPrHrIO3ULulfQSYkQ4feKn8mUSkE2pdsmBqn5sTTLFkkygPH8QITBJ3h
 uZtAINcPByuL4TyceBf79z+g5II4U+MpEOHusHf5bdtSOfhAQeKc8gxujdWw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,
I committed it only on a local repository (git add . / git commit
-m"..."). But I never tested to restore the big files from the archive
:( and then I stepped over the bug description.

Now I tried it out and something bad happened:
E:\bilder_git>git checkout -- Hochzeitsmesse.mp4
error: bad object header
fatal: packed object 5c1403a85829c1c9e03bf04ac814d65bb72b617f (stored in
.git/objects/pack/pack-00246783dc8e6b7365220e75563b5cecfa358e11.pack) is
corrupt

During add / commit there was no problem, but now this is not a good
thing...

My C-Skills are not bad - I worked about 10 years in embedded SW
development. But, currently my time is limited as I have a 3 week old
baby child :)

All the best,
Andreas



Am 09.12.2019 um 02:18 schrieb Thomas Braun:
> On 08.12.2019 19:44, Andreas Kalz wrote:
>
> Hi Andreas,
>
>> @Thomas: are you Thomas Braun who studied at FH Regensburg?
> nope, sorry.
>
>> Well, currently the .git repository is 715GB and the maximum file size
>> is 9.5GB, but I did not get error messages due to that even if the
>> performance is quite low. The biggest pack* file is 24GB. There are som=
e
>> files which are modified, but most are not modified.
> Okay that is kind-of-large. How did you add the 9.5GB file? AFAIK this
> could not have be done on windows.
>
> Do you push that to a remote repository as well?
>
>> My question came up as I did not find a documentation about limits of
>> git, only a lot of entries about github and forum users who are
>> discussing about old bugs of git. I read about git-lfs and also that it
>> is not working very stable, due to that I did not use it yet.
> Although I'm not using git-lfs myself, from what I know it works well.
> But it does have the same limitation as stock git for windows as Philip
> pointed out already.
>
>> How can the delta compression settings and/or the big filethreshold
>> limits be modified?
> These are plain git config settings. Have a look at [1]. The attributes
> are explained in [2-3]. Basically you can set in .gitattributes
>
> *.bin -delta, -diff
>
> which would tell git that files with suffix bin should not be delta
> compressed and are always binary.
>
> You could also play around with turning compression completely off via
> core.compression or pack.compression.
>
> Hope that helps,
> Thomas
>
> PS: If you have resources to help fixing that long-standing bug in git
> for windows, there is a PR open [4] which has a WIP version. But beware
> you need good C skills and better-than-average git skills, or a
> Santa-Claus-style bag with monetary resources.
>
> [1]:
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-corebig=
FileThreshold
> [2]: https://git-scm.com/docs/gitattributes#_code_delta_code
> [3]: https://git-scm.com/docs/gitattributes#_marking_files_as_binary
> [4]: https://github.com/git-for-windows/git/pull/2179
>
>> Am 07.12.2019 um 19:04 schrieb Thomas Braun:
>>> On 07.12.2019 17:54, Philip Oakley wrote:
>>>> Hi Andreas,
>>>>
>>>> On 06/12/2019 18:54, Andreas Kalz wrote:
>>>>> Hello,
>>>>> I am using git as archive and versioning also for photos. Apart from
>>>>> performance issues, I wanted to ask if there are hard limits and
>>>>> configurable limits (how to configure?) for maximum single file size
>>>>> and
>>>>> maximum .git archive size (Windows 64 Bit system)?
>>>>> Thanks in advance for your answer.
>>>>> All the best,
>>>>> Andreas
>>>> On Git the file size is currently limited to size of `long`, rather t=
han
>>>> `size_t`. Hence on Git-for Windows the size limit is 32bit ~4GiB
>>>>
>>>> Any change will be a big change as it ripples through many places in =
the
>>>> code base and, for some, will feel 'wrong'. I did some work [1-4] on =
top
>>>> of those of many others that was almost there, but...
>>> Adding to what Philip said. On Windows the size of exported archives
>>> (git archive) is currently also limited to 4GB. The reason being also
>>> the long vs size_t issue (which is not present on linux though).
>>>
>>> So if you can switch to Linux or even MacOSX these issues are gone.
>>>
>>> The number of files in .git, only the number packfiles would be of
>>> interest here I guess, do not have the long vs size_t issue. So
>>> packfiles can be larger than 4GB on 64bit Windows (with 64bit git of
>>> course).
>>>
>>> But depending on how large the biggest files are, it might be worth
>>> tweaking some of the settings, so that the created packfiles are
>>> readable on all platforms. I once created a repo on linux which could
>>> not be checked on windows, and that is a bit annoying.
>>>
>>> So the questions are how large is each file? And what repository size =
do
>>> you expect? Are we talking about 20MB files and 10GB repository? Or a
>>> factor 100 more? And are you just adding files or are you modifying th=
e
>>> added files? Depending on the file sizes it might then also be
>>> beneficial to tweak the delta compression settings and/or the big file
>>> threshold limits.
>>>
>>> Thomas
>>>
>>>> The alternative is git-lfs, which I don't personally use (see [4]).
>>>>
>>>> Philip
>>>>
>>>> [1] https://github.com/git-for-windows/git/pull/2179
>>>> [2] https://github.com/gitgitgadget/git/pull/115
>>>> [3] https://github.com/git-for-windows/git/issues/1063
>>>> [4] https://github.com/git-lfs/git-lfs/issues/2434
>>>>
>>>>
>>

