Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCB72027C
	for <e@80x24.org>; Wed, 31 May 2017 04:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdEaEdK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 00:33:10 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35903 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdEaEdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 00:33:09 -0400
Received: by mail-qk0-f169.google.com with SMTP id u75so3303104qka.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ATbRs+ShFavmNTJQZVHOFAs/EKwPjtFA9CXhvUxyIUo=;
        b=DrFk1nZ4+Kn21tAGMbH6/0M3dkVB6L7/bGdz4r0v88BtvkcIEuDCJAmWEQtlq+UGNO
         LJ8fqEoj8z/z8OMeBLaT9mmk//raV30USY9hdQb83Hx9WlX0fPYOWIs0xTnjfCnO7lJK
         nf+l4v1x4pKrBPS0u17lqM6QSh7iipPhTVygYRoM9838Rz+IQL0xQcpqSRNb45qob8xE
         iKjTINeWU8wJUcZuU0lQowiV4x8bs7NJWvcgbvVCfuZ+DFEXrszOQLQEQG9z8Qoi/hzB
         dSxU4z9kt1X452mzN4eyvpXiEOFcYbDxRpZfz8eN8zuzuMnXcerJEFQf+SGW+K8MexgE
         O54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ATbRs+ShFavmNTJQZVHOFAs/EKwPjtFA9CXhvUxyIUo=;
        b=REPiiK8Wx6npo8AKsWcjKpzoM6g+cqaQbH50lrGsrMJ5IUIedMkRgGwmT0h/vcj9ud
         fulBkztS8iRHZf/E/xFBYZ3N0Orebc+vm351PQRWJdiesBbY0NZETBr0Lvtf45nfY0cX
         3bIMKux9X4436FCEmRRJzLYUA58HaAPuzR/o88cR0wWTuKVkL/HNey9nUDF/gChb8rYL
         AhEujZBuqWHWAHL6ad4TXu+33unThUmt+fPo/XsiDHh/VfDrIZAAkd9oPwj4ciQOpbii
         +Pwgj3dG6DjrDAb1hHQmloUVE4P6a7BumHZ2MHqWoVvcw6L9DQLTzIgaycHlatdmCu54
         egIQ==
X-Gm-Message-State: AODbwcAPojHCNEkGFtfc6eg5lQycgnR2+Kfa9cKY0hsWwm9YeElQw3sj
        bjh+UdpLZplBoRRBXcSldCfJb86asg==
X-Received: by 10.55.86.66 with SMTP id k63mr25472788qkb.46.1496205188500;
 Tue, 30 May 2017 21:33:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Tue, 30 May 2017 21:33:07 -0700 (PDT)
In-Reply-To: <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com>
References: <20170525183612.3128-1-benpeart@microsoft.com> <20170525183612.3128-5-benpeart@microsoft.com>
 <CAP8UFD0OEUogQYL5Eo1kBy_1B=dBcdEJyc4B_qAUOU=2XnrxxA@mail.gmail.com> <bfab707a-7f3a-ca7d-1f67-66dcb6ab2ea6@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 May 2017 06:33:07 +0200
Message-ID: <CAP8UFD3jkAOOpFqJg2LurBfXRzeOLNO6+Wso3OPt_40TUVZy9g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] fsmonitor: add test cases for fsmonitor extension
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 11:21 PM, Ben Peart <peartben@gmail.com> wrote:
>
> On 5/30/2017 9:18 AM, Christian Couder wrote:
>>
>> On Thu, May 25, 2017 at 8:36 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>>> +       printf "untracked\0"
>>> +       printf "dir1/untracked\0"
>>> +       printf "dir2/untracked\0"
>>> +       printf "modified\0"
>>> +       printf "dir1/modified\0"
>>> +       printf "dir2/modified\0"
>>> +       printf "new\0""
>>> +       printf "dir1/new\0"
>>> +       printf "dir2/new\0"
>>
>> Maybe something like the following to save a few lines and remove some
>> redundancies:
>>
>>         printf "%s\0" untracked dir1/untracked dir2/untracked \
>>                               modified dir1/modified dir2/modified \
>>                               new dir1/new dir2/new
>>
>> or perhaps:
>>
>>         for f in untracked modified new
>>         do
>>                printf "%s\0" "$f" "dir1/$f" "dir2/$f"
>>         done
>
> That is a clever solution that certainly is fewer lines of code. However, I
> have to read the loop and think through the logic to figure out what it is
> doing vs the existing implementation where what it is doing is apparent from
> just glancing at the code.  I was also trying to maintain consistency with
> the other status test code in t7508-status.sh

Ok fair enough.

>>> +       EOF
>>> +       : >tracked &&
>>> +       : >modified &&
>>> +       mkdir dir1 &&
>>> +       : >dir1/tracked &&
>>> +       : >dir1/modified &&
>>> +       mkdir dir2 &&
>>> +       : >dir2/tracked &&
>>> +       : >dir2/modified &&
>>> +       git add . &&
>>> +       test_tick &&
>>> +       git commit -m initial &&
>>> +       dirty_repo
>>> +'
>>> +
>>> +cat >.gitignore <<\EOF
>>> +.gitignore
>>> +expect*
>>> +output*
>>> +marker*
>>> +EOF
>>
>> This could be part of the previous setup test.
>
> I had followed the pattern in t7508-status.sh with this but I can move it in
> if that is the preferred model.

Yeah, I think it is preferred these days to have all the setup code
inside tests.

>>> +       git config core.fsmonitor true  &&
>>> +       git config core.untrackedcache true &&
>>> +       git -c core.fsmonitor=false -c core.untrackedcache=true status
>>> >expect &&
>>
>> I don't understand why there is " -c core.untrackedcache=true" in the
>> above command as you already set core.untrackedcache to true on the
>> previous line.
>
> Defensive programming. :) The global setting was to ensure it was set when
> the test sub-functions clean and dirty were called and the command line
> settings were used to make it explicit what was being tested.  I can remove
> them if it is causing confusion.

I think it is a bit confusing indeed.

>>> +test_expect_success 'refresh_index() invalidates fsmonitor cache' '
>>> +       git config core.fsmonitor true &&
>>> +       git config core.untrackedcache true &&
>>> +       clean_repo &&
>>> +       git status &&
>>> +       test_path_is_missing marker &&
>>> +       dirty_repo &&
>>> +       write_script .git/hooks/query-fsmonitor<<-\EOF &&
>>> +       :>marker
>>> +       EOF
>>> +       git add . &&
>>> +       git commit -m "to reset" &&
>>> +       git status &&
>>> +       test_path_is_file marker &&

Ok so "marker" is there now.

>>> +       git reset HEAD~1 &&
>>> +       git status >output &&
>>> +       test_path_is_file marker &&
>>
>> You already checked that "marker" exists 3 lines above, and as far as
>> I can see nothing could remove this file since the previous test, as
>> the hook can only create it.
>> So I wonder if something is missing or if this test is redundant.
>
> Testing it each time ensures it is being created when it is supposed to be
> (ie when the test believes it is using the query-fsmonitor hook) and that it
> isn't when it isn't supposed to be (ie when the hook should not be called).

I would agree with that if the "marker" file was removed after the
previous "test_path_is_file marker", but I don't see any "clean_repo"
or "rm marker" call that removes it.
