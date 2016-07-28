Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065791F858
	for <e@80x24.org>; Thu, 28 Jul 2016 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbcG1TYH (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 15:24:07 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36547 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241AbcG1TYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 15:24:05 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so175926127ith.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 12:24:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s0wwgekzN3M/i+NMIbsvNkZJg621E36gt9Mn4xGeHkg=;
        b=FC+/L3S+eztCSjwb4W0sUyGzFaH2llqntXPkSvfkradwozHMmF+X6ufNTjfT8c53oi
         xEMqfL3W5jAsEPHNi6b1H54QZbLvRqgxb16WaU7ILH2tk7DzTmyhXUWnEspRXM2NH88K
         iCmSEdFiSNjn19Nk1to/N/Kd7OwdfMmkpaJkRrptyGHtPU02pWtDRJ0xRc2YNm27K8JY
         hzmLrYCU/cOHYwoFzWSOWzTvAHRChoKwuhs1QxbqExWGeMt5hmEQPlZ795dsOtd0njEb
         X6842qsEdwjHJzU+h65hrEIWBY0ql2vGn1ClWzsCTEiEyenVrWUKl7LzYouFHqKHuRCt
         qVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s0wwgekzN3M/i+NMIbsvNkZJg621E36gt9Mn4xGeHkg=;
        b=WkdTHA2v3NqpORsd3ETA67n7YQ/xY5PAISvvrDQFV0w9gGsIdPpyXBo7/j6zLR3FOx
         FfDl7xL6s4E5nT8VE0XaeIqWh1t1QSiMC5YkmO6DXCTeh8ztnLQdobzGH3UKOS/JvyaK
         2Qen6CPuaTNYpVZjAdT9gJ3Pd+Ay+G275jL/42A3bFhKlMFdthYT5zfitEcZH2FXrT0p
         GM9Lg88RrXReqPOKWec5qRCQ2JWd6LQR/dkjsZqpuNfZ40CzWkKilnXpIZfzTzVYZRD1
         8mqtG/J6l1X5SBdPgaRw3h2+WE7ic4gGohMgnQ5ippamFaJGgWABNdoiPSNHwq89aOVw
         M7qA==
X-Gm-Message-State: AEkoouvpZPRa9TQdw7cg4jO25ZUeqloggHLCNSAuyJ4Gne2yeBp4gAryEg0FiDHfZwU626LhHBNc0JZEXEaS9kgx
X-Received: by 10.36.127.7 with SMTP id r7mr40499960itc.49.1469733843462; Thu,
 28 Jul 2016 12:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 28 Jul 2016 12:24:03 -0700 (PDT)
In-Reply-To: <CAGZ79ka5n1_5CM3DOGHcd3W=4KJb9d-sb=E1pyvzP=XWGVXE3g@mail.gmail.com>
References: <20160728172641.8376-1-sbeller@google.com> <20160728172641.8376-2-sbeller@google.com>
 <xmqqeg6dsj33.fsf@gitster.mtv.corp.google.com> <CAGZ79ka5n1_5CM3DOGHcd3W=4KJb9d-sb=E1pyvzP=XWGVXE3g@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 28 Jul 2016 12:24:03 -0700
Message-ID: <CAGZ79kZfXKC66uokqOXeWND=V+53YfAkfd1NUK7A4jM2UAea7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7406: correct depth test in shallow test
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 11:47 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jul 28, 2016 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> We used to ask for 3 changes and tested for having 1, so the test
>>> seems broken.
>>
>> I am not sure what to think of "seems broken".
>
> When asking for depth 3, I would expect a result of 1,2, or 3 commits.
>
> But when testing the depth argument with a history less than 3, and then
> implying: "I got 1, which is less than 3, so the depth works", seems
> to be a logical shortcut to me.
>
> I would have expected a history of >3, then ask for 3 and confirm we did not
> get 4 or 5 or 6, but 3 only.
>
>>
>> Asking for 3 and having 1 is broken in what way?  Should we be
>> expecting for 3 because we asked for that many?  Should we expect
>> less than three even though we asked for three because the upstream
>> side does not even have that many?  If the current test that asks
>> for 3 and gets only 1 is not failing, why should we expect that
>> asking for 2 would get 2?  In other words, why is it sane that
>> asking for fewer number of commits gives us more?
>
> I think there is a subtle thing going on, that I did not examine properly but
> it is hidden in the modernization from
>
>     test 1 = $(something)
>  to test_line_count = 2
>
> I'll investigate the actual reason.

So when I place a test_pause just before that check for the lines
we have the upstream submodule:
$ git log --oneline
6355002 upstream line4
820877d upstream line3
4301fd3 Commit 2
0c90624 upstream

which then allows fetching
6355002 upstream line4
820877d upstream line3
4301fd3 Commit 2

and "Commit 2" is recorded as the sha1, i.e.
when checking out "Commit 2" and running
(git log --oneline | wc -l) we get 1 as it cuts
off after that.

When adding a test (in the next patch) that adds
more commits to the submodule upstream, we
will fetch with depth 3 but will no longer see the sha1,
so we try a different approach. Current approach:
try fetching again with no depth, and then try again with sha1
given.

So one could say there is a bug as the fetching should
use the depth argument as well.

The depth of 2 I chose originally turns out to be a lucky
accident too, as the depth from "Commit 2" is 2,
so that we would observe the same depth no matter if
a --depth 2 was given and working or not.

I'll redo this test (as 2 tests, one is testing the situation as
we have now, i.e. the desired tip is reachable from within
the depth argument, the second test will test if it is not
reachable.)

>
>>
>> Also most of the lines in this subshell seem to be breaking
>> &&-chain.
>
> Thanks for pointing that out, will fix while at it.
>
>>
>>
>>
>>> Correct the test by using test_line_count that exists in the test suite.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  t/t7406-submodule-update.sh | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>>> index 88e9750..bd261ac 100755
>>> --- a/t/t7406-submodule-update.sh
>>> +++ b/t/t7406-submodule-update.sh
>>> @@ -846,9 +846,10 @@ test_expect_success 'submodule update clone shallow submodule' '
>>>       (cd super3 &&
>>>        sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>>>        mv -f .gitmodules.tmp .gitmodules &&
>>> -      git submodule update --init --depth=3
>>> +      git submodule update --init --depth=2
>>>        (cd submodule &&
>>> -       test 1 = $(git log --oneline | wc -l)
>>> +       git log --oneline >lines
>>> +       test_line_count = 2 lines
>>>        )
>>>  )
>>>  '
