X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 04:17:31 -0400
Message-ID: <CAPig+cStkyOE4MwmFpq9V8h5M=6j=FWbDTkyMGXZsf8sBH=9pg@mail.gmail.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
	<CAPig+cTBxH7BAs2M+PBwTHfVJvH0ADL1OSEKdHQY59L-WiYosA@mail.gmail.com>
	<CAFZEwPPNMtopk9a3nVaCuujWoyeA5+39vEj3Mct1YckCXLh1-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
NNTP-Posting-Date: Sun, 27 Mar 2016 08:17:47 +0000 (UTC)
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QzboQYuLDbwXMH4zAA+EiK8gKtD55CSIwDZiESkcDHs=;
        b=BhEPsioLoK01PIEoASJCwnXsaim+rhwwhBbxGFftJoXemWDgohiuIPOv0R5xQ+Mcob
         5gL2fvOVK1dPuM3jyF+Irlx1rjd5HCGPc+fMLsxgfF9jPz1fZ033WLhe3502SF0EwubZ
         g6Dpp4eyEJEap9gVB/zzNJrUb85Su+Jt5hQlvLt1JOUUYwkGYkhN3hUoEP7StK9drbUF
         8DUoRUrNfJE9X10i8filAt50J6uZgF/kZ2ZpqyVH+GE3HqPyswelAWA2n+k7dQAu1sUD
         BeQl7nlRvwl7esq8OEn2I11lX5WNpJI2NcUAdNZx/z0FuZw5Gj358vf0d+icbkVVGsue
         xK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QzboQYuLDbwXMH4zAA+EiK8gKtD55CSIwDZiESkcDHs=;
        b=mPzfV/t/avIrdNMqALdCHlVj1GWnvnt09Rq6Mm+JMMK36ubLtuB6JzP1PtEqjlF4zA
         BKklOLJNiyEMe+P+jXjsNy+tdO+2PpDPAPI/93Y3qyAFhNJ+RtvcQ7cl/vyAlvHAIRGp
         yWGVaubX5Cb1gQFAAOS/DRPfTXTtclybJnW514weg1No+BTahuADnZLfrXs5y3M8vQx8
         Jtj2gM/1Sew+Ax+EWjeoakwc28b3MmfVOqX+7xN+ZeSHf0wJCIoWL0niCSQBRICIgRi8
         ox5J/duJ1KlfULhT7QFrxuOmLzHrzTbzQx1xHFGIM5Myh5LvyXqVqhyMgEizTqgm8Ps1
         d/mA==
X-Gm-Message-State: AD7BkJI/iCAO4oJm4KNEAPsiasvZRitR6cL+O3CH9Lw/LF5jsqMb0lj4LXNK9i/7L0dCzodn8ijQHBNXB7/YTA==
X-Received: by 10.176.2.143 with SMTP id 15mr11548763uah.113.1459066651787;
 Sun, 27 Mar 2016 01:17:31 -0700 (PDT)
In-Reply-To: <CAFZEwPPNMtopk9a3nVaCuujWoyeA5+39vEj3Mct1YckCXLh1-A@mail.gmail.com>
X-Google-Sender-Auth: dQ6RTtZCJhagXEorPi1q7mjhhbI
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1ak5tG-0005pY-F9 for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 10:17:42
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753365AbcC0IRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016
 04:17:35 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36005 "EHLO
 mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752245AbcC0IRc (ORCPT <rfc822;git@vger.kernel.org>); Sun, 27 Mar
 2016 04:17:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so11831010vkg.3 for
 <git@vger.kernel.org>; Sun, 27 Mar 2016 01:17:32 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 27 Mar 2016 01:17:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org

On Sun, Mar 27, 2016 at 3:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, Mar 27, 2016 at 9:04 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Mar 26, 2016 at 3:48 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> +test_expect_success 'commit.verbose true and --verbose omitted' '
>>> +       echo content >file2 &&
>>> +       echo content >>file &&
>>> +       git add file2 &&
>>> +       git -c commit.verbose=true commit -F message &&
>>> +       test_line_count = 1 out
>>> +'
>>
>> Why is this test so utterly different than it was in v9 (even though
>> the title is the same), and why is it so different from other tests
>> below?
>
> This is because the "editor" in v9 checked for "# Changes"... While
> this "editor" checks for 'diff --git'. And submodules don't give a
> proper diff to verify (I tried this out and noticed this behavior by
> tweaking some parts). In fact submodules don't give diff at all. But
> they do give "# Changes"... So its important to setup up a little
> before getting started. If this seems unnecessary, then should I move
> all the tests which were introduced here above the submodule test?

Let's ignore submodules when discussing this since they don't need to
factor into the issue. What you are actually saying (and what took me
a while to understand due to the "submodules" misdirection) is that
you need to do some additional setup to test the "-v -v" cases. In
particular, you need to introduce some change to the worktree which is
not in the index.

The typical way to satisfy this requirement (which doesn't require
relocating tests) is to add a "setup" test before the tests which
depend upon that additional setup, rather than adding that setup to
the first test which needs it. Just about the simplest setup test
which satisfies your needs is the following (inserted just before the
first of the new tests):

    test_expect_success 'setup -v -v' '
        echo dirty >file
    '

And, then you can restore the "commit.verbose true and --verbose
omitted" test to its simple form:

    test_expect_success 'commit.verbose true and --verbose omitted' '
        git -c commit.verbose=true commit --amend &&
        test_line_count = 1 out
    '


By the way, now that commit.verbose is no longer a mere boolean,
you're going to need some additional tests beyond the
commit.verbose={true,false} ones you've already added. In particular,
you should be testing commit.verbose with several numeric values to
verify that it works as expected. For instance:

    commit.verbose=-2
    commit.verbose=-1
    commit.verbose=0
    commit.verbose=1
    commit.verbose=2
    commit.verbose=3

The -2 case is interesting; I'm pretty sure the current implementation
of this patch will misbehave since the only negative value it's
