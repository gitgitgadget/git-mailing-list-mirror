From: Stefan Beller <sbeller@google.com>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 11:02:46 -0700
Message-ID: <CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
	<CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
	<CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
	<CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jan Keromnes <janx@linux.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:02:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axeeq-0002Vg-7y
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933825AbcECSCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:02:48 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35373 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbcECSCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:02:47 -0400
Received: by mail-io0-f170.google.com with SMTP id d62so30564789iof.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=aKZxjjNnq5gGQgjBba/+lhpCxPsd5si9DhdV1MHWYys=;
        b=OUBXGGdd2lJACv/FtfQy6PbqUdzuDSMfgJlGyTl/NySWBmKsDtlSUIb1DKrjsxTo0c
         xoaGA5ZF6ZLtR2USQvNukAsZ0fBNccSyU0dGqvmltmjKy0/L7zqEPKe+D8Vja59As3LN
         msg+ueo+oN5Wh5f+qKbTZWsGF2seIhNuwZMMwwJKf/O6HdRyzRTNZnIVAOyzrH3jyjpd
         iRPclqCx35M5ibMJJuHYCRsH+8Ww+qSrxlfWbZRjGqanBaHA+MLBmUPtuzpeGsNiX6jB
         /KU+h+4L5UjEvHE5cvlweziIddceA7voHoamNxhOTzu9cE3Vj4XmtziGG+3Ac2OPQ5gA
         CW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=aKZxjjNnq5gGQgjBba/+lhpCxPsd5si9DhdV1MHWYys=;
        b=gS81XBqgOHIOqcLGTsimjfSHGoQ5asBsdXr9n51GNn+djryQW1gQX9lXpZtohCsgNB
         S15l7XhfC3Fswa1ZllXKwW696oD0DW9acKDaLjnLEb8uwI8t0S+x/sakqS2BVYJJm5IN
         stxOLoU8vHdm5za5SvDI2b4hxYTMDERGn7Z25CEqzxr6L+Og7wFPQTDhUm5avR0dpi2M
         udVikzblyzQQwMyy/KCai0BJouatbhpDJ0w94WAOkRXmXGNBG3gR3J1alBHMFv2Yrev7
         yqXKve6ZHZER4N2v0rr9ZXlrdhCui1UsIkxkYmPIWA5kJo9X3NPNCwB1eXqENXnwlQDd
         czvA==
X-Gm-Message-State: AOPr4FUTZvyQSaa2ToJq9kUHWUpz6EFu4YzhwhoWu/EEEXzfL/WjSJ8qfyeW47u2SLzsl74jh4cyx7aNcBihb+Yk
X-Received: by 10.107.53.204 with SMTP id k73mr4935150ioo.174.1462298566290;
 Tue, 03 May 2016 11:02:46 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 11:02:46 -0700 (PDT)
In-Reply-To: <CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293427>

On Tue, May 3, 2016 at 2:19 AM, Jan Keromnes <janx@linux.com> wrote:
> Thanks for your replies! I was able to reproduce to failure on Git 2.8.2.
>
> Steps:
>
> # Build Git 2.8.2 and run t/t7300-clean.sh in a Dockerfile based on
> ubuntu:14.04.
> RUN mkdir /tmp/git \
>  && cd /tmp/git \
>  && curl https://www.kernel.org/pub/software/scm/git/git-2.8.2.tar.xz | tar xJ \
>  && cd git-2.8.2 \
>  && make all && cd t && ./t7300-clean.sh -d -i -v -x

I am on a Ubuntu 14.04.1 LTS derivative (plain, not inside a docker) and running
that list of commands (getting that tarball from kernel.org and testing) doesn't
reproduce the failure for me.

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

++ rm -fr to_clean possible_sub1
++ mkdir to_clean possible_sub1
++ test_when_finished 'rm -rf possible_sub*'
++ test 0 = 0
++ test_cleanup='{ rm -rf possible_sub*
} && (exit "$eval_ret"); eval_ret=$?; :'
++ echo 'gitdir: foo'
++ chmod 0 possible_sub1/.git
++ git clean -f -d
Skipping repository baz/boo
Skipping repository foo/
Skipping repository possible_sub1/
Skipping repository repo/
Skipping repository sub2/
Removing to_clean/
++ test_path_is_file possible_sub1/.git
++ test -f possible_sub1/.git
++ test_path_is_file possible_sub1/hello.world
++ test -f possible_sub1/hello.world
++ test_path_is_missing to_clean
++ test -e to_clean
++ rm -rf possible_sub1
++ exit 0
++ eval_ret=0
++ :
ok 32 - should avoid cleaning possible submodules

>
> Judging from the line "Removing possible_sub1/", it looks like Git
> 2.8.2 removes a possible submodule while executing `git clean -f -d`,
> whereas the test expects it not to.

Yeah that is my conclusion as well. (The successful test doesn't remove it)
Reading the clean code at [1], specifically the loop starting at line 958,
there are two cases. Either the entry is a directory (submodules are
treated as special directories) or files.


So the line 975 is executed for that submodule as remove_dirs has the printing
in both cases.

Apparently the remove_dirs exits early for me in the condition

    if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
is_nonbare_repository_dir(path)) {

and your case doesn't. (I assume it falls through and later produces
the output in line 243.

So I wonder if is_nonbare_repository_dir() is the culprit here.
(We do a chmod 0 on the .git before the `git clean` in the test to confuse Git)

is_nonbare_repository_dir is only used in `git clean` as well as for the
files backend (which is rather new. I don't know the state of the usage there).

What I find suspicious about is_nonbare_repository_dir (found in setup.c:316),
is the assumption of only READ_GITFILE_ERR_OPEN_FAILED and
READ_GITFILE_ERR_READ_FAILED
leading to a repository.

I have cc'd Jeff and Erik, who have touched the code there, maybe they
have a thought on it.
In the mean time I would be interested if this change helps for you:

        diff --git a/setup.c b/setup.c
        index 3439ec6..4cfba8f 100644
        --- a/setup.c
        +++ b/setup.c
        @@ -323,8 +323,7 @@ int is_nonbare_repository_dir(struct strbuf *path)
                strbuf_addstr(path, ".git");
                if (read_gitfile_gently(path->buf, &gitfile_error) ||
is_git_directory(path->buf))
                        ret = 1;
        -       if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
        -           gitfile_error == READ_GITFILE_ERR_READ_FAILED)
        +       if (gitfile_error)
                        ret = 1;
                strbuf_setlen(path, orig_path_len);
                return ret;

Do you do anything fancy with your file system?

Thanks,
Stefan


[1] https://github.com/git/git/blob/v2.8.2/builtin/clean.c#L854


>
> Is it possible to make Git's output even more verbose, so that it
> tells why it decides to remove "possible_sub1"? Are you able to
> reproduce this test fail on your side?
>
> This prevents doing a full profile build.
>
> Best,
> Jan
>
> On Fri, Apr 29, 2016 at 7:06 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Apr 29, 2016 at 5:53 AM, Jan Keromnes <janx@linux.com> wrote:
>>> Hello,
>>>
>>> I tried running a full profile build of Git 2.8.1, but it looks like
>>> test #32 in `t7300-clean.sh` fails:
>>>
>>> Commands:
>>>
>>>> curl https://www.kernel.org/pub/software/scm/git/git-2.8.1.tar.xz | tar xJ
>>>> cd git-2.8.1
>>>> make prefix=/usr profile-install install-man -j18
>>>
>>> Logs of test-suite that fails:
>>>
>>> *** t7300-clean.sh ***
>>> ok 1 - setup
>>> ok 2 - git clean with skip-worktree .gitignore
>>> ok 3 - git clean
>>> ok 4 - git clean src/
>>> ok 5 - git clean src/ src/
>>> ok 6 - git clean with prefix
>>> ok 7 - git clean with relative prefix
>>> ok 8 - git clean with absolute path
>>> ok 9 - git clean with out of work tree relative path
>>> ok 10 - git clean with out of work tree absolute path
>>> ok 11 - git clean -d with prefix and path
>>> ok 12 - git clean symbolic link
>>> ok 13 - git clean with wildcard
>>> ok 14 - git clean -n
>>> ok 15 - git clean -d
>>> ok 16 - git clean -d src/ examples/
>>> ok 17 - git clean -x
>>> ok 18 - git clean -d -x
>>> ok 19 - git clean -d -x with ignored tracked directory
>>> ok 20 - git clean -X
>>> ok 21 - git clean -d -X
>>> ok 22 - git clean -d -X with ignored tracked directory
>>> ok 23 - clean.requireForce defaults to true
>>> ok 24 - clean.requireForce
>>> ok 25 - clean.requireForce and -n
>>> ok 26 - clean.requireForce and -f
>>> ok 27 - core.excludesfile
>>> ok 28 # skip removal failure (missing SANITY)
>>> ok 29 - nested git work tree
>>> ok 30 - should clean things that almost look like git but are not
>>> ok 31 - should not clean submodules
>>> not ok 32 - should avoid cleaning possible submodules
>>> #
>>> #               rm -fr to_clean possible_sub1 &&
>>> #               mkdir to_clean possible_sub1 &&
>>> #               test_when_finished "rm -rf possible_sub*" &&
>>> #               echo "gitdir: foo" >possible_sub1/.git &&
>>> #               >possible_sub1/hello.world &&
>>> #               chmod 0 possible_sub1/.git &&
>>> #               >to_clean/should_clean.this &&
>>> #               git clean -f -d &&
>>> #               test_path_is_file possible_sub1/.git &&
>>> #               test_path_is_file possible_sub1/hello.world &&
>>> #               test_path_is_missing to_clean
>>> #
>>>
>>> Best,
>>> Jan
>>
>> Thanks for reporting the bug!
>>
>> Have a look at t/README to run the tests with command line arguments.
>> (I usually run tests as ./tXXXfoo.sh -d -i -v -x with these arguments,
>> though I cannot remember what each of that does. One of it makes the
>> test suite stop on a failing test, such that you can cd into the testing
>> directory and check the state of the file. (Which are present, which are gone?)
>>
>> With these arguments it is also very verbose, and it would tell
>> you what is wrong (is the assertion wrong in the `test_path_is_file/missing`
>> or is it `git clean` segfaulting?)
>>
>> As Johannes said, it makes sense that you debug into that as
>> no one could reproduce it thus far on their system.
>>
>> Thanks,
>> Stefan
