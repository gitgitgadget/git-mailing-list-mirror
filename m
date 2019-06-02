Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB931F462
	for <e@80x24.org>; Sun,  2 Jun 2019 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfFBJT0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 05:19:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32863 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfFBJT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 05:19:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so9300067wrx.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q+FSgd90rNEB3uQ4jXahfCCLwRt8Ljw1E6prb2+geyk=;
        b=ngHS5BmMgKMWre1FY9gZMFkquDU7It1gc3vTj5/Ujify4791DSTFRK5uU95xhZfIIn
         ahvauqxL9+envdkG++edhYGUgd8+D8sH8e9Bu4EI9/gQEjmZ5hH03THjp9EQg0oKw0Ze
         XbHIG9UbE65WbxsIo7oYoM4IcKDrkgq7ABfAxoCYOxdTnHsTI/IIDG+R1UWBKBwKP8Hi
         CUe9j+9UQtxIzMDlNphkGy5k1wsZ/mL5vonl8NZMz7wi5j3kE0yv2wPkem24BPaT/fl6
         R5rrr30p6SrllslyHqjcmBcfw1xfeakPnpv4eq74tUirV06Rj0rXBKbLzQsTadibGGnA
         xovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q+FSgd90rNEB3uQ4jXahfCCLwRt8Ljw1E6prb2+geyk=;
        b=b3g4hb3/4lxlzLSOoFWJs0tZZX0mkdALzYNh+MTcnFLBKX8+iHqGkaGzEGN1d9Gm5D
         PdynXsNtRRavuIUNzj2acdgNlL3IUaQfPSGr96Q9Tnbfh8ALRdrAxZduS6fTnYW5HoDA
         7IQ6BqFaOCmpu0ZRuq5q9DBI7k6oqiAIqy5nzZZyAFZMHG9QBMXTJjNTvpenQ9dg3nbM
         bdQBN7iG11NbH+A6PC6s9kW2hI8qFpRsRQGGGHFRbomw3ujEpFKwLKmEaW707OReBOpG
         B5HnXCMpTqkhSk6lDNbc0zAUvyp5Z/opEoltTA+GzME0mFNE3PeByS/KULyNaVCkHdgh
         +mJw==
X-Gm-Message-State: APjAAAW37F76vSLIGVJfpTFsrB9LCGV3Wq0cOObZ5sexlZdgLVqiXAtS
        ZpcJrJ9Lsa05t30A6H9LacebWei4T5M=
X-Google-Smtp-Source: APXvYqzBjCLnFJGCFqi6cBWtfcluGHw0qBHttr0kvMgYm3GyKXh66k9Zfx+MaG5w/XW1lKtkQhTmQA==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr12043487wrr.262.1559467163998;
        Sun, 02 Jun 2019 02:19:23 -0700 (PDT)
Received: from szeder.dev (x4db46cf5.dyn.telefonica.de. [77.180.108.245])
        by smtp.gmail.com with ESMTPSA id h90sm34747985wrh.15.2019.06.02.02.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 02:19:23 -0700 (PDT)
Date:   Sun, 2 Jun 2019 11:19:19 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Occasional git p4 test failures because of stray fast-import
 processes
Message-ID: <20190602091919.GN951@szeder.dev>
References: <20190227094926.GE19739@szeder.dev>
 <CAE5ih78MV1qGTHBmCaN5k+VGv8Cy-RnFwOU0yuJBPEyn37C_4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5ih78MV1qGTHBmCaN5k+VGv8Cy-RnFwOU0yuJBPEyn37C_4w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 03:03:30PM +0000, Luke Diamand wrote:
> On Wed, 27 Feb 2019 at 09:49, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > I saw rare failures in test 6 'git p4 sync uninitialized repo' in
> > 't9800-git-p4-basic.sh' on Travis CI, because the 'cleanup_git'
> > function failed to do its job.  The (redacted) trace looks like this:
> 
> Thanks for the *very* detailed analysis!
> 
> I think you are right - git-p4 should wait() for all of its children,
> and that ought to fix this.
> 
> I think I may have even added the bit of code you mention (about a
> decade ago now).
> 
> I'll have a look and see what can be done.

So...  any progress on this issue? ;)

I've seen a few failures of 't9825-git-p4-handle-utf16-without-bom'
lately that look like this:

  checking known breakage: 
          git p4 clone --dest="$git" //depot
  
  +git p4 clone --dest=/home/travis/t/trash dir.t9825/git //depot
  Initialized empty Git repository in /home/travis/t/trash dir.t9825/git/.git/
  Perforce db files in '.' will be created if missing...
  Perforce db files in '.' will be created if missing...
  Perforce db files in '.' will be created if missing...
  Perforce db files in '.' will be created if missing...
  Perforce db files in '.' will be created if missing...
  Command failed: ['p4', '-r', '3', 'print', '-q', '-o', '-', '//depot/file1@1']
  Error: Translation of file content failed near line 1 file -
  
  Perforce db files in '.' will be created if missing...
  Importing from //depot into /home/travis/t/trash dir.t9825/git
  Doing initial import of //depot/ from revision #head into refs/remotes/p4/master
  error: last command exited with $?=1
  
  not ok 4 - clone depot with invalid UTF-16 file in non-verbose mode #
  TODO known breakage
  +stop_p4d_and_watchdog
  +kill -9 24722 24724
  +exit 1
  +eval_ret=1
  +:
  # still have 1 known breakage(s)
  # passed all remaining 3 test(s)
  1..4
  rm: cannot remove '/home/travis/t/trash dir.t9825/git/.git/objects':
  Directory not empty
  rm: cannot remove '/home/travis/t/trash dir.t9825/git/.git/refs':
  Directory not empty
  error: Tests passed but test cleanup failed; aborting


I think (without digging too deep, I admit) that this is caused by the
same root issue quoted below, with some slight differences:

  - It's not 'git p4 sync', but 'git p4 clone' that starts the
    background 'git fast-import' process in t9825's last test case,
    but on error it leaves the child process behind all the same.

  - The actual error doesn't come from a check in the 'cleanup_git'
    helper function, and not even from within the test case, but from
    the 'rm -fr "$TRASH_DIRECTORY"' in 'test_done', which racily
    removes directories while the background 'git fast-import'
    (re-)creates them.

I suspect the chances for this race occurring increased considerably
with commit 07353d9042 (git p4 test: clean up the p4d cleanup
functions, 2019-03-13): since then there is basically only a single
'kill -9 $pids...' between the last test and 'test_done's cleanup 'rm
-fr', but before that there has always been at least one 'sleep 1' in
'kill_p4d'.



> >
> >   + cleanup_git
> >   + retry_until_success rm -r /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
> >   + time_in_seconds
> >   + cd /
> >   + /usr/bin/python -c import time; print(int(time.time()))
> >   + timeout=1551233042
> >   + rm -r /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
> >   + test_must_fail test -d /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
> >   test_must_fail: command succeeded: test -d /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
> >   + eval_ret=1
> >   + :
> >   not ok 6 - git p4 sync uninitialized repo
> >
> > Trying to reproduce this failure with stock Git can be tricky: I've
> > seen
> >
> >   ./t9800-git-p4-basic.sh --stress -r 1,2,6,22
> >
> > fail within the first 10 tries, but it also run overnight without a
> > single failure...  However, the following two-liner patch can reliably
> > trigger this failure:
> >
> > diff --git a/fast-import.c b/fast-import.c
> > index b7ba755c2b..54715018b3 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -3296,6 +3296,7 @@ int cmd_main(int argc, const char **argv)
> >                 rc_free[i].next = &rc_free[i + 1];
> >         rc_free[cmd_save - 1].next = NULL;
> >
> > +       sleep(1);
> >         start_packfile();
> >         set_die_routine(die_nicely);
> >         set_checkpoint_signal();
> > diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> > index b3be3ba011..2d2ef50bfa 100644
> > --- a/t/lib-git-p4.sh
> > +++ b/t/lib-git-p4.sh
> > @@ -190,6 +190,7 @@ kill_p4d () {
> >
> >  cleanup_git () {
> >         retry_until_success rm -r "$git"
> > +       sleep 2
> >         test_must_fail test -d "$git" &&
> >         retry_until_success mkdir "$git"
> >  }
> >
> >
> > What's going on is this: 'git p4' invokes 'git fast-import' via
> > Python's subprocess.Popen(), and then there are two chain of events
> > racing with each other:
> >
> >   - In the foreground:
> >
> >     - 'git p4' notices that there are no p4 branches and die()s as
> >       expected, but leaves its child fast-import behind
> >     - 'test_i18ngrep' quickly verifies that 'git p4' died with the
> >       expected error message
> >     - the cleanup function removes the "$TRASH_DIRECTORY/git"
> >       directory, and
> >     - checks that the directory is indeed gone.
> >
> >   - Meanwhile in the background:
> >
> >     - 'git fast-import' starts up, kicks off the dashed external
> >       'git-fast-import' process,
> >     - which opens a tmp packfile in "$TRASH_DIRECTORY/git" for writing
> >       (the start_packfile() call in the patch context above), creating
> >       any leading directories if necessary,
> >     - notices that its stdin is closed (because 'git p4' died) and it
> >       has nothing left to do, so
> >     - it cleans up and exits.  Note that this cleanup only removes the
> >       tmp packfile, but leaves any newly created leading directories
> >       behind.
> >
> > While unlikely, it does apparently happen from time to time that the
> > test's cleanup function first removes "$TRASH_DIRECTORY/git", but then
> > 'git fast-import' re-creates it for its packfile before the cleanup
> > function checks the result of the removal.  The two well-placed
> > sleep()s in the patch above force such a problematic scheduling.
> >
> > There are 4 test cases running 'test_must_fail git p4 sync': the above
> > patch triggers a failure in 3 of them, and with a bit of extra modding
> > I could trigger a failure in the fourth one as well.
> >
> > We could work this around by waiting for 'git p4' and all its child
> > processes in the affected tests themselves, using the same shell
> > trickery as in ef09036cf3 (t6500: wait for detached auto gc at the end
> > of the test script, 2017-04-13), but this feels like, well, a
> > workaround.
> >
> > I think the proper solution would be to ensure that 'git p4' kills and
> > waits for all its child processes when die()ing.  Alternatively (or in
> > addition?), it could perform all the necessary sanity-checking (and
> > potential die()ing) before starting the 'git fast-import' process in
> > the first place.
> >
> > I've glanced through all subprocess.Popen() callsites in 'git p4' and
> > found most of them OK, in the sense that they wait for whatever child
> > process they create.  Alas, there was one exception: p4CmdList() can
> > invoke an optional callback function before wait()ing on its 'p4'
> > child, and the streamP4FilesCb() callback function can die() without
> > waiting for the 'p4' process (but it does wait() for 'git
> > fast-import'!).
> >
> > On a related note: this check for the just-removed directory was added
> > in 23aee4199a (git-p4: retry kill/cleanup operations in tests with
> > timeout, 2015-11-19), which mentions flaky cleanup operations.
> > Perhaps this is the same flakiness?!
> >
> > Anyway, as I mentioned elsewhere before, I have no idea why/how 'git
> > p4' works, so I'll leave it up to you how it's best to deal with this
> > issue...
> >
> >
> > Gábor
> >
