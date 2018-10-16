Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55691F453
	for <e@80x24.org>; Tue, 16 Oct 2018 09:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJPR3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 13:29:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:41317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeJPR3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 13:29:03 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgt3g-1fzCeo38ka-00M0Gw; Tue, 16
 Oct 2018 11:39:22 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgt3g-1fzCeo38ka-00M0Gw; Tue, 16
 Oct 2018 11:39:22 +0200
Date:   Tue, 16 Oct 2018 11:39:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     gitgitgadget@gmail.com, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
In-Reply-To: <CAE5ih78gCgJgeXasdm6j+hO8Bk+_zk_-o5FqkMTr-q7fKDej9Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161111240.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com> <CAE5ih79cNkVVQOkaeJifSqkcp=HGmRb3a=jJC=g08iV8dYRyXg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810151657080.4546@tvgsbejvaqbjf.bet> <CAE5ih78gCgJgeXasdm6j+hO8Bk+_zk_-o5FqkMTr-q7fKDej9Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0NRmdiHc6O2FnjEBPy+e8rO6v6RKZrgVlRCHxekiqgB7hcfAAqO
 ZAJg+3cDqw2kZwO4mvTXrArGZQ1jjNFX2MRk9SlkyjJvg5jx1m6xul1LbnzIwojJ8KrgNfe
 WOJEjKly+SeqzFj3vSILsaHs4iPynOcynpHfIzVMdNmdJnEcZSY/FfK+OUc4AePvDPa91ad
 /W/Te03VG32l+lZJB3PDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M71sBYi6PfA=:Jpc5ALbGuUjfBX323fmG8g
 X8QqqzHssYSuQVIX6RWegikJLQH4jDtAs3q4b0Wr0BvB7W+k+YgiSRkznCVPTf/xuyKDZqX9x
 5cOKx7o/nHRar0GU5FEOTPnoNjEGyJyS7qvc00m2BM3WNxK5HSjwlRMCNKS8ygnxw9+98AKVF
 qv0sV2dtRHr6Kw46jDaRFW7w+Sm0bE7uh0qCKMt6X6TA9r15FtrDsKC3EfFTO/J0YV5ViKJUf
 1pl+UHD3ju1p8eSpEXVkiamqOceX3xoKP2sChwDJLK77dyNQ0gouK2nE7ETCuTwf5KMO6yCjU
 ZhbkkUJdiRfms7MOYIp6RY2uLL5zLzgj2RhynOBlz9kYF+2IwanUV85a2maPNVh4iWIyQlYhp
 fuc2W8oxA6tRGcKD48hmGViVgKgVA7evQk+wgO070btai3uYaudv/O6ulTYpE7mMLpHgJq+Sv
 XDpl8r5YiKYWCbjQgo5igC2gFM11C7KZmttf8fqB0lUMf46a5iEhEQD2+R7NFGYxycgpJSTZP
 FYnepfGC1FjfUYzoww3x4p8+coYhsyP0PzKS+RQEVY3JXvSW3mb9GTd4SNJYhtCNoSt5OUHAx
 ONDKJlCvH7tn/v5bMZ7h9so3OgsJQraqWLC3aRVw1BPFsXKlJnEFXUWHhu1mgvRd3RD1WRIGe
 gF3zag337MyC+ICIOCE0v0FpJk3RPkenYry2Snotf24nZGRMyqRGX9WgEoZMHT4tfEk9Np5xU
 4IsEd8xLMpOP5JNFTNUBbg04ncrC2XqrCNzDmXJY2PKj0Cn16X0n8gOPcpCJdCmYRT3Pugf5c
 s+NNFitKxxljPqvLJOP+j0Y3CDz1fCLsDn+ktRlCCHx5ZTvNJ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Mon, 15 Oct 2018, Luke Diamand wrote:

> On Mon, 15 Oct 2018 at 16:02, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Luke,
> >
> > On Mon, 15 Oct 2018, Luke Diamand wrote:
> >
> > > On Mon, 15 Oct 2018 at 11:12, Johannes Schindelin via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > >
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > This should be more reliable than the current method, and prepares the
> > > > test suite for a consistent way to clean up before re-running the tests
> > > > with different options.
> > > >
> > >
> > > I'm finding that it's leaving p4d processes lying around.
> >
> > That's a bummer!
> >
> > > e.g.
> > >
> > > $ ./t9820-git-p4-editor-handling.sh
> > > <passes>
> > > $ ./t9820-git-p4-editor-handling.sh
> > > <fails>
> >
> > Since I do not currently have a setup with p4d installed, can you run that
> > with `sh -x ...` and see whether this code path is hit?
> 
> All you need to do is to put p4 and p4d in your PATH.
> 
> https://www.perforce.com/downloads/helix-core-p4d
> https://www.perforce.com/downloads/helix-command-line-client-p4

I did download p4d.exe and p4.exe to $HOME/custom/p4/ (similar to the way
ci/install-dependencies.sh does it), from

	http://filehost.perforce.com/perforce/r18.1/bin.ntx64/p4d.exe
	http://filehost.perforce.com/perforce/r18.1/bin.ntx64/p4.exe

and then prefixed PATH with $HOME/custom/p4, just to run t9820. However,
it does not work here at all:

-- snip --
[...]
++ git p4 clone '--dest=/usr/src/git/azure-pipelines/t/trash directory.t9820-git-p4-editor-handling/git' //depot
Usage: git-p4 clone [options] //depot/path[@revRange]

[...]
-- snap --

I *think* the reason for that is that the MSYS path mangling kicks in when
`git.exe` is called with the `//depot` argument (the leading `//` can be
used in MSYS and MSYS2 to indicate that the non-MSYS .exe wants an
argument that starts with a single slash, but is not a path that needs to
be translated to a Windows path).

So I did the next best thing I could do: try things in the Windows
Subsystem for Linux (AKA Bash on Ubuntu on Windows).

> The server is free to use for a small number of users, you don't need
> to do anything to make it go.
> 
> 
> >
> >  test_done () {
> >         GIT_EXIT_OK=t
> >
> > +       test -n "$immediate" || test_atexit_handler

On a slight tangent: I made up my mind on the `test -n "$immediate"` part:
I will skip that. The daemon should be stopped also when `-i` was passed
to the test script (to stop at the first failing test case). There is
very, very little use in keeping the daemon alive in that case.

The commit message of "tests: introduce `test_atexit`" already made the
case for that, but somehow I had not made up my mind yet.

> > +
> 
> + test -n
> + test_atexit_handler
> ./t9820-git-p4-editor-handling.sh: 764:
> ./t9820-git-p4-editor-handling.sh: test_atexit_handler: not found
> 
> Is that expected?

No, that is not expected. For me, it looks quite a bit different, though:

-- snip --
[...]
+ test_done
+ GIT_EXIT_OK=t
+ test -n
+ test_atexit_handler
+ test : != { kill_p4d
                } && (exit "$eval_ret"); eval_ret=$?; :
+ setup_malloc_check
+ MALLOC_CHECK_=3 MALLOC_PERTURB_=165
+ export MALLOC_CHECK_ MALLOC_PERTURB_
+ test_eval_ { kill_p4d
                } && (exit "$eval_ret"); eval_ret=$?; :
+ test_eval_inner_ { kill_p4d
                } && (exit "$eval_ret"); eval_ret=$?; :
+ eval
                want_trace && set -x
                { kill_p4d
                } && (exit "$eval_ret"); eval_ret=$?; :
+ want_trace
+ test  = t
+ kill_p4d
+ cat /home/wsl/git/wip/t/trash directory.t9820-git-p4-editor-handling/p4d.pid
+ pid=20093
+ retry_until_fail kill 20093
+ time_in_seconds
+ cd /
+ /usr/bin/python -c import time; print(int(time.time()))
+ timeout=1539681637
+ kill 20093
+ time_in_seconds
+ cd /
+ /usr/bin/python -c import time; print(int(time.time()))
+ test 1539681577 -gt 1539681637
+ sleep 1
+ true
+ time_in_seconds
+ cd /
+ /usr/bin/python -c import time; print(int(time.time()))
+ test 1539681578 -gt 1539681871
+ sleep 1
+ kill 20093
+ retry_until_fail kill -9 20093
+ time_in_seconds
+ cd /
+ /usr/bin/python -c import time; print(int(time.time()))
+ timeout=1539681638
+ kill -9 20093
+ test_must_fail kill 20093
+ _test_ok=
+ kill 20093
+ exit_code=1
+ test 1 -eq 0
+ test_match_signal 13 1
+ test 1 = 141
+ test 1 = 269
+ return 1
+ test 1 -gt 129
+ test 1 -eq 127
+ test 1 -eq 126
+ return 0
[...]
-- snap --

As you can see, it works quite well over here.

Maybe I could trouble you to fetch the `vsts-ci` branch from
https://github.com/dscho/git and test things on that one, just in case
that anything important got "lost in the mail"?

> >         if test -n "$write_junit_xml" && test -n "$junit_xml_path"
> >         then
> >
> > > And also
> > >
> > > $ ./t9800-git-p4-basic.sh
> > > <starts running tests, but I get bored easily>
> > > Ctrl-C
> >
> > Oh, you're right.

So I tested this in WSL, and the relevant part of the output is this:

-- snip --
[...]
+ eval test_prereq_lazily_UTF8_NFD_TO_NFC=$2
+ test_prereq_lazily_UTF8_NFD_TO_NFC=
        # check whether FS converts nfd unicode to nfc
        au^CTraceback (most recent call last):
  File "/home/virtualbox/git/wip/git-p4", line 4143, in <module>
    main()
  File "/home/virtualbox/git/wip/git-p4", line 4137, in main
    if not cmd.run(args):
  File "/home/virtualbox/git/wip/git-p4", line 3925, in run
    if not P4Sync.run(self, depotPaths):
  File "/home/virtualbox/git/wip/git-p4", line 3824, in run
    system(["git", "symbolic-ref", head_ref, self.branch])
  File "/home/virtualbox/git/wip/git-p4", line 278, in system
    retcode = subprocess.call(cmd, shell=expand)
  File "/usr/lib/python2.7/subprocess.py", line 523, in call
    return Popen(*popenargs, **kwargs).wait()
  File "/usr/lib/python2.7/subprocess.py", line 1392, in wait
    pid, sts = _eintr_retry_call(os.waitpid, self.pid, 0)
  File "/usr/lib/python2.7/subprocess.py", line 476, in _eintr_retry_call
    return func(*args)
KeyboardInterrupt
+ exit 130
+ die
+ code=130
+ test_atexit_handler
+ test : != { kill_p4d
                } && (exit "$eval_ret"); eval_ret=$?; :
[...]
-- snap --

As you can see, the Ctrl+C managed to call `die` very well, without my
proposed change:

> > I think I need to do something in this line:
> >
> >         trap 'exit $?' INT
> >
> > in t/test-lib.sh, something like
> >
> >         trap 'exit_code=$?; test_atexit_handler; exit $exit_code' INT
> >
> > would you agree? (And: could you test?)
> 
> Not sure.

I *think* what happens is that the INT trap already calls `exit 130`
alright, and then the EXIT trap comes into effect, as planned.

Just to make sure that it was not Python that caused the exit code 130, I
tried it again, and luckily hit a spot where shell code was interpreted:

-- snip --
[...]
+ test_prereq_lazily_LONG_IS_64BIT=
        test 8 -le "$(build_option sizeof-long)"

+ test_lazy_^C+ exit 130
+ die
+ code=130
+ test_atexit_handler
+ test : != { kill_p4d
                } && (exit "$eval_ret"); eval_ret=$?; :
[...]
-- snap --

Same here. The Ctrl+C triggers an `exit 130`, this time I am certain that
it comes from the INT trap, and that `die` in turn is most definitely from
the EXIT trap, as intended.

My tests were performed with Dash, BTW, not with Bash:

-- snip --
$ dpkg -S $(which sh)
diversion by dash from: /bin/sh
diversion by dash to: /bin/sh.distrib
dash: /bin/sh
-- snap --

But I also repeated the tests with Bash, with almost the same result: the
only difference was that I did not manage to get the traces of
test_atexit_handler being called, but the p4d was no longer alive, so it
must have been killed as intended.

> Send me a patch and I can try it out.

I would *love* to figure out what is happening in your setup, and to fix
it. In my hands, the patches work, though...

Ciao,
Dscho

> 
> Thanks,
> Luke
> 
