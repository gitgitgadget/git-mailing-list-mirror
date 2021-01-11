Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6941C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3392242A
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 12:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAKMem (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 07:34:42 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52663 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAKMem (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 07:34:42 -0500
X-Originating-IP: 103.82.80.125
Received: from localhost (unknown [103.82.80.125])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CB7731C000A;
        Mon, 11 Jan 2021 12:33:59 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Robert Pollak <robert.pollak@posteo.net>,
        Paul Mackerras <paulus@ozlabs.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH] gitk: Activate --find-copies-harder
References: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
        <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
        <b0c0a630-25a9-8ef8-2270-fa40404c2897@posteo.net>
        <23445a9c-46b2-0232-845b-c8d5fe36d506@redhat.com>
Date:   Mon, 11 Jan 2021 18:03:57 +0530
In-Reply-To: <23445a9c-46b2-0232-845b-c8d5fe36d506@redhat.com> (Laszlo Ersek's
        message of "Mon, 11 Jan 2021 10:21:25 +0100")
Message-ID: <87mtxfwt3e.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11 2021, Laszlo Ersek wrote:

> On 01/10/21 13:59, Robert Pollak wrote:
>> On 2021-01-06 16:58, Laszlo Ersek wrote:
>>> On 01/04/21 20:54, Robert Pollak wrote:
>> [...]
>>>> I see the following problems with my patch:
>>>>
>>>> 1) It is totally untested with all the other args that are collected in
>>>> diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.
>>>
>>> It would be really great if gitk supported both "-O<orderfile>" and
>>> --find-copies-harder!
>>
>> Can you please test these options with my patch and report back?
>>
>> -- Robert
>>
>
> The patch doesn't apply with git-am (I'm trying on top of 72c4083ddf91):
>
>> Applying: gitk: Activate --find-copies-harder
>> error: corrupt patch at line 100
>> Patch failed at 0001 gitk: Activate --find-copies-harder
>> hint: Use 'git am --show-current-patch' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>
> One problem could be the embedded diff in the notes section (I guess it
> could confuse git-am).
>
> Also, "gitk" has existed at "gitk-git/gitk" since commit 62ba5143ec2a
> ("Move gitk to its own subdirectory", 2007-11-18), so the pathname
> headers in the patch look wrong.

gitk is maintained as a separate repo by Paul Mackerras at
git://ozlabs.org/~paulus/gitk, and then is pulled into the main Git repo
from time to time using a subtree merge. That's how gitk changes end up
in gitk-git/. Patches for gitk should be based on the gitk repo to make
it easier for Paul to apply them. In short, the paths are fine.

> Thanks
> Laszlo
>

-- 
Regards,
Pratyush Yadav
