Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4151A20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 17:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbdK3Roo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 12:44:44 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33498 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdK3Ron (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 12:44:43 -0500
Received: by mail-wm0-f47.google.com with SMTP id g130so2491751wme.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nJMPgqANP1aTxswTtfdpOKzFOes1bQxu5WBNQHXQ/RQ=;
        b=iXERl8J8V8ajy5lG5G/7DgtMuU3SpD1UptEK5YAq9TzXokBDid2daXFTn4CDqjNKTC
         NMxe96mPn7oQdxtLYJ38kdtDc0L5hOgrQQ/rMwy1nZ2Kps0nxp+L32sq/XmhSDgBvLjn
         0aRFHvnQ8tkb7NS0eaxAXB3I6FxqKxYMFHnWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nJMPgqANP1aTxswTtfdpOKzFOes1bQxu5WBNQHXQ/RQ=;
        b=E2FmZV9ABkDS8DeA8Jghr6SS8beWNOgvn7eyWngn6f5Dwac1z6WLTgEypO5w9J9Y7q
         1fVDGUjohIj1fE4iaOqNeGTNyf2UvX9rZV8rmKCRgDFFya6SNFo2P0oxhb2urrlibVUG
         +POqiiPQihzbNT2zv624iTKzy180NEUwoOYFZ4gOB/D11O0zF6EoJq3uxxeEBkmRqOQx
         TAh/HogAxMo1o0FrYp2x1o4/IGID6MMj7PUHxZ6MGBJ8ivypI1QG9vRIcutfeYGcaZDj
         CW9wC4eEIq6MwIcCuO0rLRV/JBdRjPwwMP5UpCh++daYamWYQUkomPWiNTxJX1Px4I7y
         oNtA==
X-Gm-Message-State: AJaThX4Js89TEROpil91oScN0uzjo640/ZO60AbEZ6J2O6cITLbGPfE0
        f1OSZ5AZ20Et5qk4I857UOPOcxJxEJKGSwuWyq4+XDE=
X-Google-Smtp-Source: AGs4zMbGWbi3CEVcuURskEQ/aEV/bW8ViQ6EpSwJzSCdSmWZBhlD3clAwV3+AS9AQupdJIfezYvYqK6tTc3OtEVZ9w0=
X-Received: by 10.28.217.75 with SMTP id q72mr1204816wmg.9.1512063881623; Thu,
 30 Nov 2017 09:44:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.213.12 with HTTP; Thu, 30 Nov 2017 09:44:21 -0800 (PST)
In-Reply-To: <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
From:   Vitaly Arbuzov <vit@uber.com>
Date:   Thu, 30 Nov 2017 09:44:21 -0800
Message-ID: <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Found some details here: https://github.com/jeffhostetler/git/pull/3

Looking at commits I see that you've done a lot of work already,
including packing, filtering, fetching, cloning etc.
What are some areas that aren't complete yet? Do you need any help
with implementation?


On Thu, Nov 30, 2017 at 9:01 AM, Vitaly Arbuzov <vit@uber.com> wrote:
> Hey Jeff,
>
> It's great, I didn't expect that anyone is actively working on this.
> I'll check out your branch, meanwhile do you have any design docs that
> describe these changes or can you define high level goals that you
> want to achieve?
>
> On Thu, Nov 30, 2017 at 6:24 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>
>> On 11/29/2017 10:16 PM, Vitaly Arbuzov wrote:
>>>
>>> Hi guys,
>>>
>>> I'm looking for ways to improve fetch/pull/clone time for large git
>>> (mono)repositories with unrelated source trees (that span across
>>> multiple services).
>>> I've found sparse checkout approach appealing and helpful for most of
>>> client-side operations (e.g. status, reset, commit, etc.)
>>> The problem is that there is no feature like sparse fetch/pull in git,
>>> this means that ALL objects in unrelated trees are always fetched.
>>> It may take a lot of time for large repositories and results in some
>>> practical scalability limits for git.
>>> This forced some large companies like Facebook and Google to move to
>>> Mercurial as they were unable to improve client-side experience with
>>> git while Microsoft has developed GVFS, which seems to be a step back
>>> to CVCS world.
>>>
>>> I want to get a feedback (from more experienced git users than I am)
>>> on what it would take to implement sparse fetching/pulling.
>>> (Downloading only objects related to the sparse-checkout list)
>>> Are there any issues with missing hashes?
>>> Are there any fundamental problems why it can't be done?
>>> Can we get away with only client-side changes or would it require
>>> special features on the server side?
>>>
>>> If we had such a feature then all we would need on top is a separate
>>> tool that builds the right "sparse" scope for the workspace based on
>>> paths that developer wants to work on.
>>>
>>> In the world where more and more companies are moving towards large
>>> monorepos this improvement would provide a good way of scaling git to
>>> meet this demand.
>>>
>>> PS. Please don't advice to split things up, as there are some good
>>> reasons why many companies decide to keep their code in the monorepo,
>>> which you can easily find online. So let's keep that part out the
>>> scope.
>>>
>>> -Vitaly
>>>
>>
>>
>> This work is in-progress now.  A short summary can be found in [1]
>> of the current parts 1, 2, and 3.
>>
>>> * jh/object-filtering (2017-11-22) 6 commits
>>> * jh/fsck-promisors (2017-11-22) 10 commits
>>> * jh/partial-clone (2017-11-22) 14 commits
>>
>>
>> [1]
>> https://public-inbox.org/git/xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com/T/
>>
>> I have a branch that contains V5 all 3 parts:
>> https://github.com/jeffhostetler/git/tree/core/pc5_p3
>>
>> This is a WIP, so there are some rough edges....
>> I hope to have a V6 out before the weekend with some
>> bug fixes and cleanup.
>>
>> Please give it a try and see if it fits your needs.
>> Currently, there are filter methods to filter all blobs,
>> all large blobs, and one to match a sparse-checkout
>> specification.
>>
>> Let me know if you have any questions or problems.
>>
>> Thanks,
>> Jeff
