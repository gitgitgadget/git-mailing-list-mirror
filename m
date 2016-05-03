From: Jan Keromnes <janx@linux.com>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 11:19:07 +0200
Message-ID: <CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
	<CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
	<CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 11:19:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axWU8-00067R-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 11:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbcECJTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 05:19:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34129 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbcECJTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 05:19:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so2645236wmn.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Iy6CJjjNm8FQCqjg2EXtnFGQkIaW1pJghRXojGaD6e8=;
        b=HWId+NEJf4+FyRSHg8Bx7ySuQcj6KOz+JCIiQfWAreoCiUZNWhZb8VxrKeaVELprtH
         18NcxMkndPB1iaj/LwLFgp3xyS38GZpwcGa7Uj+HZjc7EOVeFRsV2Pk3GGkVLkyb95Oo
         dNMM5G5TfXIhJpyur7bRoVZMFFTHyivrd5VeoMUbQDEJTDFOkNA0wxR0fXX2FzgBiEkR
         0+MeVgObzUmRHlkKONW7CgyAzsn9/qbbNRI5hmXryCcQ1mEbCx/Zef5pUobasEdvqH5S
         xhR3sgfzMhxsCxYs7n3/LG+sDw47iWKxa3SQi2sFvU9hGwezSxgilrJ7uzKVa/0LmTSD
         7wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Iy6CJjjNm8FQCqjg2EXtnFGQkIaW1pJghRXojGaD6e8=;
        b=EZmgSs6Z1GuUt/nbravI+ueZSduV5Yayx51lMVU29KTpi7kUY+4ZBkoVyPSNQPkv9k
         vNs2hxh3uDAYH46GFmikJxbQ9thpNnIFPVMgWlxQnNwh64LJPFx73Nqa+1bR0NiE7HR1
         SL06TNdOBiqAAnQirHUUUKUlcQGV8zRxrlw3WNJcyokLh/OlFjtqvkhPX9w3ajfLusas
         GgorTIskskIM1k9Z6d8NtC6ZA90svln9ykZ+o7soFoMqGOP0P1mQoXbomUsyNK/YNKD1
         mLOeox2uA4bTXILEUSnmWg7edJrZk30xcsW8+wek2axE+OlZzLL/Ga83T5DSpb6eIj3g
         iTWw==
X-Gm-Message-State: AOPr4FXykl+Yldhorqrx3aSO0eCjIIeWijxZInv4SvZlHjYO7nULpU8FbLFtHQ8SNx2pme1lDgsiCVim/3Sp9Q==
X-Received: by 10.194.96.10 with SMTP id do10mr1668814wjb.132.1462267147282;
 Tue, 03 May 2016 02:19:07 -0700 (PDT)
Received: by 10.28.175.74 with HTTP; Tue, 3 May 2016 02:19:07 -0700 (PDT)
In-Reply-To: <CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
X-Google-Sender-Auth: rZP5wgdwmi2iEiJ-OHRCkQiWFCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293348>

Thanks for your replies! I was able to reproduce to failure on Git 2.8.2.

Steps:

# Build Git 2.8.2 and run t/t7300-clean.sh in a Dockerfile based on
ubuntu:14.04.
RUN mkdir /tmp/git \
 && cd /tmp/git \
 && curl https://www.kernel.org/pub/software/scm/git/git-2.8.2.tar.xz | tar xJ \
 && cd git-2.8.2 \
 && make all && cd t && ./t7300-clean.sh -d -i -v -x

Logs:

expecting success:
        rm -fr to_clean possible_sub1 &&
        mkdir to_clean possible_sub1 &&
        test_when_finished "rm -rf possible_sub*" &&
        echo "gitdir: foo" >possible_sub1/.git &&
        >possible_sub1/hello.world &&
        chmod 0 possible_sub1/.git &&
        >to_clean/should_clean.this &&
        git clean -f -d &&
        test_path_is_file possible_sub1/.git &&
        test_path_is_file possible_sub1/hello.world &&
        test_path_is_missing to_clean

+ rm -fr to_clean possible_sub1
+ mkdir to_clean possible_sub1
+ test_when_finished rm -rf possible_sub*
+ test 0 = 0
+ test_cleanup={ rm -rf possible_sub*
                } && (exit "$eval_ret"); eval_ret=$?; :
+ echo gitdir: foo
+
+ chmod 0 possible_sub1/.git
+
+ git clean -f -d
Skipping repository baz/boo
Skipping repository foo/
Removing possible_sub1/
Skipping repository repo/
Skipping repository sub2/
Removing to_clean/
+ test_path_is_file possible_sub1/.git
+ test -f possible_sub1/.git
+ echo File possible_sub1/.git doesn't exist.
+ false
error: last command exited with $?=1
File possible_sub1/.git doesn't exist.
not ok 32 - should avoid cleaning possible submodules
#
#               rm -fr to_clean possible_sub1 &&
#               mkdir to_clean possible_sub1 &&
#               test_when_finished "rm -rf possible_sub*" &&
#               echo "gitdir: foo" >possible_sub1/.git &&
#               >possible_sub1/hello.world &&
#               chmod 0 possible_sub1/.git &&
#               >to_clean/should_clean.this &&
#               git clean -f -d &&
#               test_path_is_file possible_sub1/.git &&
#               test_path_is_file possible_sub1/hello.world &&
#               test_path_is_missing to_clean
#

Judging from the line "Removing possible_sub1/", it looks like Git
2.8.2 removes a possible submodule while executing `git clean -f -d`,
whereas the test expects it not to.

Is it possible to make Git's output even more verbose, so that it
tells why it decides to remove "possible_sub1"? Are you able to
reproduce this test fail on your side?

This prevents doing a full profile build.

Best,
Jan

On Fri, Apr 29, 2016 at 7:06 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 29, 2016 at 5:53 AM, Jan Keromnes <janx@linux.com> wrote:
>> Hello,
>>
>> I tried running a full profile build of Git 2.8.1, but it looks like
>> test #32 in `t7300-clean.sh` fails:
>>
>> Commands:
>>
>>> curl https://www.kernel.org/pub/software/scm/git/git-2.8.1.tar.xz | tar xJ
>>> cd git-2.8.1
>>> make prefix=/usr profile-install install-man -j18
>>
>> Logs of test-suite that fails:
>>
>> *** t7300-clean.sh ***
>> ok 1 - setup
>> ok 2 - git clean with skip-worktree .gitignore
>> ok 3 - git clean
>> ok 4 - git clean src/
>> ok 5 - git clean src/ src/
>> ok 6 - git clean with prefix
>> ok 7 - git clean with relative prefix
>> ok 8 - git clean with absolute path
>> ok 9 - git clean with out of work tree relative path
>> ok 10 - git clean with out of work tree absolute path
>> ok 11 - git clean -d with prefix and path
>> ok 12 - git clean symbolic link
>> ok 13 - git clean with wildcard
>> ok 14 - git clean -n
>> ok 15 - git clean -d
>> ok 16 - git clean -d src/ examples/
>> ok 17 - git clean -x
>> ok 18 - git clean -d -x
>> ok 19 - git clean -d -x with ignored tracked directory
>> ok 20 - git clean -X
>> ok 21 - git clean -d -X
>> ok 22 - git clean -d -X with ignored tracked directory
>> ok 23 - clean.requireForce defaults to true
>> ok 24 - clean.requireForce
>> ok 25 - clean.requireForce and -n
>> ok 26 - clean.requireForce and -f
>> ok 27 - core.excludesfile
>> ok 28 # skip removal failure (missing SANITY)
>> ok 29 - nested git work tree
>> ok 30 - should clean things that almost look like git but are not
>> ok 31 - should not clean submodules
>> not ok 32 - should avoid cleaning possible submodules
>> #
>> #               rm -fr to_clean possible_sub1 &&
>> #               mkdir to_clean possible_sub1 &&
>> #               test_when_finished "rm -rf possible_sub*" &&
>> #               echo "gitdir: foo" >possible_sub1/.git &&
>> #               >possible_sub1/hello.world &&
>> #               chmod 0 possible_sub1/.git &&
>> #               >to_clean/should_clean.this &&
>> #               git clean -f -d &&
>> #               test_path_is_file possible_sub1/.git &&
>> #               test_path_is_file possible_sub1/hello.world &&
>> #               test_path_is_missing to_clean
>> #
>>
>> Best,
>> Jan
>
> Thanks for reporting the bug!
>
> Have a look at t/README to run the tests with command line arguments.
> (I usually run tests as ./tXXXfoo.sh -d -i -v -x with these arguments,
> though I cannot remember what each of that does. One of it makes the
> test suite stop on a failing test, such that you can cd into the testing
> directory and check the state of the file. (Which are present, which are gone?)
>
> With these arguments it is also very verbose, and it would tell
> you what is wrong (is the assertion wrong in the `test_path_is_file/missing`
> or is it `git clean` segfaulting?)
>
> As Johannes said, it makes sense that you debug into that as
> no one could reproduce it thus far on their system.
>
> Thanks,
> Stefan
