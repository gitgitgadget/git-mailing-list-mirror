Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FEA1FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 09:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeCNJ5i (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 05:57:38 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40102 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeCNJ5h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 05:57:37 -0400
Received: by mail-wm0-f49.google.com with SMTP id t6so2794522wmt.5
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=outsOVuj/jE22mGKEJ8LBdvuAh1+p+dD/gwZgWtNGQI=;
        b=Xu+sNB7bWNNjWQtS+DUgGZoMmxFNCG7r6PBWD1KXEAC3fLI1GxSIVRxkzHpCSxJ5Cc
         HRrTg1WLuge10vPx7V91opbCgT/WBcYtzq9pqQucTOztLvPmkTzTHgnDrFkb6+eww/34
         kpsGI1TQvUxUpwogZe8tWfpmWBHKRTpTmXt5kv5trTZuvfjIfDfqIG4K/qy2wNk1kVei
         J+uAFYHFsaFGfg/p9rgPrk4MCe9wbUt/Y5HLU/G3x7jtjK40V7vbLLM3giUJrO7pkzFz
         nhM5wgI4Jhy6fgU3SLFJmtupHUyxswQelhy0YC47SpqlUkgTIVXzrS9PO6hewlhgQ844
         M95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=outsOVuj/jE22mGKEJ8LBdvuAh1+p+dD/gwZgWtNGQI=;
        b=T3xry/tbx7V3f6nma0QOZ1dKGMHrWfrisEMnzQoixA8Xm/V/OzCmB/oH0kH0M9Xsce
         S4urWslPeCXr/x+asSBX6ew/l2aFVXjwd4688pKmF7BR/WkteI05dH50UTTWAgoF/1jH
         W/fZocr8HarNtTKFu0Di0oBF+DJCnKykwaqevJPpaLgM0dPqYEA/ncl2Dj/uA1GtPLko
         JDtP//OnSuZeTbWR7pLvi0XYBFwG5qvQ41Pa9B6zgC0HY9Y8HPe870HT3r8NQ+Nma5yx
         f6fk0SO/kfUKvwJTHtAiP8Votyh6m2PPvB0O1XrO/Gjzyp1IX5xyPklblzmYdb9zMmiW
         TVZQ==
X-Gm-Message-State: AElRT7Ft9OTRtd4pjetAGUWDMHCCtYtNGxZ9cxJKGf7yVJ4HIFjgyWed
        7Yuarj4pgHaSeSreHPLG42E=
X-Google-Smtp-Source: AG47ELvKvd6cbekBNDgIkugssH9vAMJb7FCEG39Zz96tYz5WuPA8yM1lEehO9d5UwHRCxbMepeIH9w==
X-Received: by 10.80.159.133 with SMTP id c5mr1854019edf.221.1521021455564;
        Wed, 14 Mar 2018 02:57:35 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id v9sm1899603edi.16.2018.03.14.02.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 02:57:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GSoC] [PATCH] test: avoid pipes in git related commands for test suite
References: <20180313201945.8409-1-predatoramigo@gmail.com> <CAPig+cRPzyw525ODC4=-E7w=zbpbhVN2eqxSYDSLij5wfW8S_A@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAPig+cRPzyw525ODC4=-E7w=zbpbhVN2eqxSYDSLij5wfW8S_A@mail.gmail.com>
Date:   Wed, 14 Mar 2018 10:57:33 +0100
Message-ID: <87zi3bdlo2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 14 2018, Eric Sunshine jotted:

> Thanks for the patch. See comments below...
>
> On Tue, Mar 13, 2018 at 4:19 PM, Pratik Karki <predatoramigo@gmail.com> wrote:
>> This patch removes the necessity of pipes in git related commands for test suite.
>>
>> Exit code of the upstream in a pipe is ignored so, it's use should be avoided. The fix for this is to write the output of the git command to a file and test the exit codes of both the commands being linked by pipe.
>
> Please wrap commit messages to fit in about 72 columns; this one is
> far too wide.
>
> On the Git project, commit messages are written in imperative mood, as
> if telling the codebase to "do something". So, instead of writing
> "This patch removes...", you could word it "Remove..." or "Avoid...".
>
> It's misleading to say that the patch "removes the _necessity_ of
> pipes" since pipes were not used out of necessity; they were probably
> just a convenience and seemed reasonable at the time, but later
> experience has shown that they can be problematic for the reason you
> give in the second paragraph.
>
> Taking these observations into consideration, perhaps you could
> rewrite the commit message something like this:
>
>     Avoid using pipes downstream of Git commands since the exit codes
>     of commands upstream of pipes get swallowed, thus potentially
>     hiding failure of those commands. Instead, capture Git command
>     output to a file apply the downstream command(s) to that file.
>
> More comments below...

Makes sense.

>> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
>> ---
>> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
>> @@ -116,10 +116,10 @@ test_expect_success \
>>  test_expect_success \
>>      'checking the commit' \
>> -    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
>> -     grep "^R100..*path0/COPYING..*path2/COPYING" &&
>> -     git diff-tree -r -M --name-status  HEAD^ HEAD | \
>> -     grep "^R100..*path0/README..*path2/README"'
>> +    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
>> +     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
>> +     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
>> +     grep "^R100..*path0/README..*path2/README" actual'
>
> Although this "mechanical" transformation is technically correct, it
> is nevertheless wasteful. The exact same "git diff-tree ..." command
> is run twice, and both times output is captured to file 'actual',
> which makes the second invocation superfluous. Instead, a better
> transformation would be:
>
>     git diff-tree ... >actual &&
>     grep ... actual &&
>     grep ... actual
>
> The same observation applies to other transformations in this patch.

I think we have to be careful to not be overly picky with rejecting
mechanical transformations that fix bugs on the basis that while we're
at it the test could also be rewritten.

I.e. this bug was there before, maybe we should purely focus on just
replacing the harmful pipe pattern that hides errors in this series and
leave rewriting the actual test logic for a later patch.

>> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
>> @@ -204,8 +204,8 @@ test_expect_success "follow-parent is atomic" '
>>  test_expect_success "track multi-parent paths" '
>>         svn_cmd cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
>>         git svn multi-fetch &&
>> -       test $(git cat-file commit refs/remotes/glob | \
>> -              grep "^parent " | wc -l) -eq 2
>> +       test $(git cat-file commit refs/remotes/glob >actual &&
>> +              grep "^parent " actual | wc -l) -eq 2
>>         '
>
> This is not a great transformation. If "git cat-file" fails, then
> neither 'grep' nor 'wc' will run, and the result will be as if 'test'
> was called without an argument before "-eq". For example:
>
>     % test $(false >actual && grep "^parent " actual | wc -l) -eq 2
>     test: -eq: unary operator expected
>
> It would be better to run "git cat-file" outside of "test $(...)". For instance:
>
>     git cat-file ... >actual &&
>     test $(grep ... actual | wc -l) -eq 2
>
> Alternately, you could take advantage of the test_line_count() helper function:
>
>     git cat-file ... >actual &&
>     grep ... actual >actual2 &&
>     test_line_count = 2 actual2

In this case though as you rightly point out the rewrite is introducing
a regression, which should definitely be fixed.
