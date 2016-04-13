From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] t1500-rev-parse: rewrite each test to run in isolation
Date: Wed, 13 Apr 2016 08:21:15 -0400
Message-ID: <CANoM8SWAj-rkEAEG2Woha0OErW8JEPWt7iypnBV5ko6GKinO6A@mail.gmail.com>
References: <1460200767-32864-1-git-send-email-rappazzo@gmail.com>
 <1460200767-32864-2-git-send-email-rappazzo@gmail.com> <CAPig+cT8oD1jJdDrk+YPoquGfTh6m3m-ha0J+er42jOoxnVxzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:21:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqJnh-0007pA-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192AbcDMMVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 08:21:37 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34621 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758153AbcDMMVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:21:35 -0400
Received: by mail-io0-f193.google.com with SMTP id z133so6464372iod.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=30o38xJaPgJeSm/qwrovlbNtpptscA0VjVf0pVIXsaU=;
        b=MDU1W1gMIO2KzkFhC8mhndbhLOvIG88xJKmmx4JxOUnRFpY1GV6A+Vsi6mLZ1VzKDf
         oUzuY8N6+IErhV3d/uExc1u4zHKoBI71TFBOgZK6PMTNGlyoGgZdscWuqKS1UgulDd6b
         RsrGqGkn2EYdJlAGPaQUnxy/TfKrUmkvZY7dCfRK/wWoP/WlJTK+h8m+UebElwiS4nyO
         EJx4hpgTZW+rLsTxbkKaEA6IBOhN+9bC3yqMsK8gQdyzwGMJZmuQSDC+h7tmiJiAAxav
         c/mYEwXX0k0x40Ug54b7VZQsK5u59NeOlR+rhPHki/A7gHQRSAhFVddpsjkQXwBsjB38
         ka4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=30o38xJaPgJeSm/qwrovlbNtpptscA0VjVf0pVIXsaU=;
        b=HVaMDFqWZWRj1ePrZcgWwveUYLJUYZWTp+5g5M3gAM8GyEiFCWFmUs+cLzdLeGlsH8
         j0pAU3M2oTGj95lWRpyznLzLkb/ik6MGcLg0fj1sv91PCvcYyLudGNRCG628rRnxU2nd
         XUECdm7FB+c4ezU7RzzpdsMJV0PQu6kpHBkQuubTydjCC9Jj8jOFZZsOlMPtzFaGxcOU
         bKBcYHx03jYV5TAlpvNqTghLCDMHcBiDLv9L4BXiMK2wFVCs8XLPnl+0zR2qcS+UjWe2
         rh3ZhPa+WNVYHrwmpbrqWMArYgG8LyMGpucs4LiyUmY8IGT5sCWkbfwDOBmdbJMEgN08
         h3tQ==
X-Gm-Message-State: AOPr4FXYpz99JEtxDP5IJH8kWE3Km+l0Goz3d42yzs4N4mWKzgKQUAkR+K1ciFw7WgOvqPYt4arSpG6ZUsqcxQ==
X-Received: by 10.107.168.233 with SMTP id e102mr10871195ioj.55.1460550094711;
 Wed, 13 Apr 2016 05:21:34 -0700 (PDT)
Received: by 10.107.7.193 with HTTP; Wed, 13 Apr 2016 05:21:15 -0700 (PDT)
In-Reply-To: <CAPig+cT8oD1jJdDrk+YPoquGfTh6m3m-ha0J+er42jOoxnVxzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291392>

On Wed, Apr 13, 2016 at 12:54 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 9, 2016 at 7:19 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>> t1500-rev-parse has many tests which change directories and leak
>> environment variables.  This makes it difficult to add new tests without
>> minding the environment variables and current directory.
>>
>> Each test is now setup, executed, and cleaned up without leaving anything
>> behind.  Tests which have textual expectations have been converted to use
>> test_cmp (which will show a diff when the test is run with --verbose).
>
> It might be easier to review this if broken into several cleanup and
> modernization patches, however, some comments below...

I felt that the changes are repetitive enough that it did not
necessitate separate patches.  Perhaps after simplifying based on your
suggestions, it will be even smaller.

>
>> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
>> ---
>> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
>> @@ -3,88 +3,571 @@
>> +test_expect_success '.git/: is-bare-repository' '
>> +       (cd .git && test false = "$(git rev-parse --is-bare-repository)")
>> +'
>>
>> -# label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
>> +test_expect_success '.git/: is-inside-git-dir' '
>> +       (cd .git && test true = "$(git rev-parse --is-inside-git-dir)")
>
> Simpler:
>
>     test true = "$(git -C .git rev-parse --is-inside-git-dir)"
>
>> +'
>>
>> -ROOT=$(pwd)
>> +test_expect_success '.git/: is-inside-work-tree' '
>> +       (cd .git && test false = "$(git rev-parse --is-inside-work-tree)")
>
> Ditto.
>
>> +'
>>
>> -test_rev_parse toplevel false false true '' .git "$ROOT/.git"
>> +test_expect_success '.git/: prefix' '
>> +       (
>> +               cd .git &&
>> +               echo >expected &&
>> +               git rev-parse --show-prefix >actual &&
>> +               test_cmp expected actual
>> +       )
>
> Likewise, you could drop the entire subshell:
>
>     echo >expected &&
>     git -C .git rev-parse --show-prefix >actual &&
>     test_cmp expected actual
>
>> +'
>>
>> +test_expect_success '.git/: git-dir' '
>> +       (
>> +               cd .git &&
>> +               echo . >expected &&
>> +               git rev-parse --git-dir >actual &&
>> +               test_cmp expected actual
>> +       )
>
> Same here and for many subsequent tests (which I won't quote).
>
>> +'
>> +test_expect_success 'core.bare = true: is-bare-repository' '
>> +       git config core.bare true &&
>> +       test_when_finished "git config core.bare false" &&
>> +       test true = "$(git rev-parse --is-bare-repository)"
>
> Simpler:
>
>     test_config core.bare true
>
> and then you can drop 'test_when_finished' altogether. However, even simpler:
>
>     test true = "$(git -c core.bare=false rev-parse --is-bare-repository)"
>
> which allows you to drop 'test_config', as well.
>
> Ditto for subsequent tests (which I won't quote).
>
>> +'
>> +test_expect_success 'core.bare undefined: is-bare-repository' '
>> +       git config --unset core.bare &&
>
>     test_unconfig core.bare
>
>> +       test_when_finished "git config core.bare false" &&
>
> Why does this need to re-instate core.bare?
>
> Same comments for subsequent tests.
>
>> +       test false = "$(git rev-parse --is-bare-repository)"
>> +'
>> +test_expect_success 'GIT_DIR=../.git, core.bare = false: is-bare-repository' '
>> +       mkdir work &&
>> +       test_when_finished "rm -rf work && git config core.bare false" &&
>> +       (
>> +               cd work &&
>> +               export GIT_DIR=../.git &&
>> +               export GIT_CONFIG="$(pwd)"/../.git/config
>> +               git config core.bare false &&
>> +               test false = "$(git rev-parse --is-bare-repository)"
>> +       )
>> +'
>
> Same comments about -C to avoid the subshell and -c for configuration.
>
> Also, you can do one-shot environment variable setting for the command
> invocation, so the subshell goes away, and everything inside the
> subshell collapses to:
>
>     test false = "$(GIT_DIR=... GIT_CONFIG=...
>         git -C work -c core.bare=false rev-parse ...)"
>
> Additionally, I'm confused about why this test "reverts" the
> core.bare=false by setting core.bare=false in 'test_when_finished'.
>
> Ditto for subsequent tests.
>
>> +test_expect_success 'GIT_DIR=../repo.git, core.bare = false: is-bare-repository' '
>> +       mkdir work &&
>> +       cp -r .git repo.git &&
>> +       test_when_finished "rm -r repo.git && rm -rf work && git config core.bare false" &&
>
> If 'cp' fails, then 'test_when_finished' will never be invoked, which
> means that the cleanup will never happen; thus 'test_when_finished'
> needs to be called earlier. Ditto for subsequent tests.
>
>> +       (
>> +               cd work &&
>> +               export GIT_DIR=../repo.git &&
>> +               export GIT_CONFIG="$(pwd)"/../repo.git/config
>> +               git config core.bare false &&
>> +               test false = "$(git rev-parse --is-bare-repository)"
>> +       )
>> +'
>
> Closing comments:
>
> By using -C, -c, and one-shot environment variables, you can ditch the
> subshells, and most of these tests should collapse to one or two
> lines.

I follow, and I can make that adjustment.  Thanks for the review.

>
> There seems to be a lot of repetition here. To reduce the repetition,
> have you considered encoding the state which varies between tests into
> a table and making the tests table-driven. Or, by encoding the varying
> state in some nested for-loops? The nice thing about driving the tests
> from a table or for-loops is that it is easier to see at a glance if
> all cases are covered.

I was aiming for readability and the ability to test an individual
case.  The previous version was driven by a function, which did reduce
the repetition, but it made it not simple to run an individual test in
the case of a failure.  Would your table implementation be much
different from the function, in terms of readability?
