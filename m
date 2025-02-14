Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ECF18B460
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559641; cv=none; b=CbcRRxRk2aC9Vh3vdfPTDsV8rABkQjXbGqd7diSYam+wEe5Mrt6Q6gNtt1apEYPlzqrQdqtCC59b8dSZYvyLdGjhIwCzQ8Mu8iUe54wzqSCpeiNi0natOF2/f9a4GWavOKYczrpWfQ1mUUFk19qbZZ3iU7vfMLU9Z4dauX6X0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559641; c=relaxed/simple;
	bh=M0S/Zv+6nE+sqCEZg+r0CQ5zXvW2E0oLV3YkgqykYsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWSAnYQAKRHW2gqTNgxv90gYecDir8BFcc2LUsONbulTm0Jfdc9RByoo79iin/uxym33tp3054w2PXQVJkixUuWUt4d29bxn/Znj2XtXHN/8leE9Wi5A4y/9iVQ5OWW5mPwGzLHHz7s2SVwrAr8Wd9awDGW/INe4OHNwXs3PeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeFOGwc3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeFOGwc3"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so81161639f.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739559621; x=1740164421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up6vet4ygvfOGN0yUiC9gG73WdDB+fwASnMFWtUhdFs=;
        b=ZeFOGwc3stWiqYW/mi5we5kTEYiSNJBPm/WInM9ZA87olZXeUXtGexaSSu9CLCXbfU
         KbHsB3I2U1EXF1WAxrNcT88coRdH4MNllSpj6x5XtZHh3l9aGLdRdwzgum25WGpypzep
         bTJD6Y/xR2L83iyeKTLBoKK+uCA/YRSPZJNnUnOMhajECt/k/HgdqeTOEkgZ0Z9e18dP
         /CNrYHC+bXe8iuVCq5RBvBq6cqZi8Dfop7fPGwN1x84Y686ew77BZotyS47UtyZMBYEH
         CLs96JGKlkObBxYzDOStLBDt4FPhJk7/mOUFqy67pXFXKGBwZN9+KijzNY9vSrAKR2/Z
         C6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739559621; x=1740164421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up6vet4ygvfOGN0yUiC9gG73WdDB+fwASnMFWtUhdFs=;
        b=snqItZ3/iMFtNAawsQ3vHHOTWr2BFUnjHet2azJSV6VLHovAmkV7njfqLaq9tRJPEW
         99sXvVGaAbuLaiW3CNkYGDg31x/CPXgkGKQdLOwWe4VqRZMavIGpMkXGQDtWnWWgsPu3
         4FyTbdKqEpRpI0tat0sYxqQ0+khlNZ0YaDyo7a2ocsyamJp5h/3xCIwZq2/fn2fA++yT
         hYIdNMbpxk7vIJxJSergHeK5603ZlkcTIxD/+m8mrYU4Zuyxx/ps7u7rX3bE8Ttd26oS
         HA7eiKN81Vi9vdRIOIRuGfKS9wp9mtimGAUbXAJXWAUw4imEL8HX4mWEc4PyaC7UqoWT
         yF2w==
X-Gm-Message-State: AOJu0Yx3DZEiEBPw3PPkmP9WLnP91S2Syg/7NIBTZXFtPnONIiPq6eBt
	o/AIx4m0wV9pnCdhh/e0lMzMN5/D0xFJ+DPuj01ykAJ78DWC2DQqr5R6AcDSHsHSKIhe+218tRu
	J1kmI9h8KrvGZKWBJBYQ+6mQSGHkYUjLm
X-Gm-Gg: ASbGncuVsa/C2D9hTrMPl1rctF+6AfptsPPWtOV8+aziQWJJ2BdrwoimAlJzfiExJSJ
	sL5tEwL32ofL8EAgiG+0utfJu+votu7tbUibNZETdjDiuDdna/c+sJmOeEm7L5uXqleaPAZq2JV
	DPcwpGsd2KBscARXGhGQplC0wNBVb0Cg==
X-Google-Smtp-Source: AGHT+IHrpVYPsxHGDmsKKYS/NZkzYRtaM3jV83U6F+iM0L0ng6voU3O43UbN4tRRuZtU3+Kq8WDq5z9kLaiwjlrhYec=
X-Received: by 2002:a05:6e02:b2a:b0:3d1:9cee:3d24 with SMTP id
 e9e14a558f8ab-3d28090697dmr4035485ab.11.1739559620775; Fri, 14 Feb 2025
 11:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
 <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
 <CAPhwyn0hz16mZ-UoVAczC4qDLx2i0LwfFhhDjdTahe0=4TO57g@mail.gmail.com>
 <CABPp-BGq-x9Z98scXRtEnqz7BCmPn9ONHd6wDnnm9jL4YeDHxQ@mail.gmail.com> <CAPhwyn1oXRy5BFQBvuFsmhfVhkW8+D6Xz6OYB8LpP0O+jH1TFQ@mail.gmail.com>
In-Reply-To: <CAPhwyn1oXRy5BFQBvuFsmhfVhkW8+D6Xz6OYB8LpP0O+jH1TFQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Feb 2025 11:00:09 -0800
X-Gm-Features: AWEUYZkRNE6u2qARsbHLx43bnqNkXro9_eF6WBpN2JbGzFCIBOWUVx3KQCu0vUU
Message-ID: <CABPp-BGOeAJ-e0P7kALLMnA7wCzbJx6WEYwmCmsq9qK46DYdVw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:24=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com>=
 wrote:
>
> On Fri, 14 Feb 2025 at 11:35, Elijah Newren <newren@gmail.com> wrote:
> >
> > > > Did you run any tests?  I'm not sure you maintained correctness her=
e.
> > >
> > > I didn't run any tests -- I wanted to, but I wasn=E2=80=99t sure how =
to do it
> > > for this change. Since you suggested dropping this patch from the
> > > series, I=E2=80=99ll do that. But for similar changes in the future, =
how should I go
> > > about testing them?
> >
> > As per Documentation/CodingGuidelines: "After any code change, make
> > sure that the entire test suite passes."  You can do that by running:
> >     cd t && make
> > (You probably want to also run that before making any changes, just to
> > verify that they all pass for you.  Then, if any test fails after you
> > make changes, you know it's because of your changes rather than
> > because you missed something in building or setting up the tests.)
> >
> >
> > And although it doesn't matter since we're dropping this patch, the
> > issue I noticed was that if there were, say, three unmerged entries
> > with the same path, the original code would create one entry in the
> > string list and modify it 3 times (each with a different ce_stage(ce).
> > Your modification would create three different entries (each with only
> > information from one stage) and drop two of them, meaning we no longer
> > have a single string_list_item that contains information from all 3
> > unmerged entries for the same path.  I'm pretty sure running the
> > existing tests would catch that kind of bug, which is what raised the
> > question.
>
> That's the thing -- I did run make in the t/ directory, and it passed. I =
was
> just wondering if there's any other way to test this in isolation, in cas=
e
> I want to verify such changes more directly in the future.

Really?  Did you rebuild the code, after making your changes?  You may
have been running with a pre-changes version of the code.

I just applied your changes and ran the tests.  I see it fail as soon
as it gets to t1004.

$ cd t && make test
[... lots of output snipped ...]
*** t1004-read-tree-m-u-wf.sh ***
ok 1 - two-way setup
ok 2 - two-way not clobbering
ok 3 - two-way with incorrect --exclude-per-directory (1)
ok 4 - two-way with incorrect --exclude-per-directory (2)
ok 5 - two-way clobbering a ignored file
ok 6 - three-way not complaining on an untracked path in both
ok 7 - three-way not clobbering a working tree file
ok 8 - three-way not complaining on an untracked file
ok 9 - 3-way not overwriting local changes (setup)
ok 10 - 3-way not overwriting local changes (our side)
ok 11 - 3-way not overwriting local changes (their side)
ok 12 - funny symlink in work tree
ok 13 - funny symlink in work tree, un-unlink-able
ok 14 - D/F setup
ok 15 - D/F
ok 16 - D/F resolve
not ok 17 - D/F recursive
#
#
#        git reset --hard &&
#        git checkout side-b &&
#        git merge-recursive branch-point -- side-b side-a
#
#
# failed 1 among 17 test(s)
1..17
make[1]: *** [Makefile:77: t1004-read-tree-m-u-wf.sh] Error 1
make[1]: Leaving directory '/home/newren/floss/git/t'
make: *** [Makefile:63: test] Error 2


...and if go to the toplevel directory and run under prove so I can
see all the failures (and run the test suites in parallel), I see:

$ cd .. && make DEFAULT_TEST_TARGET=3Dprove GIT_PROVE_OPTS=3D'--timer
--state failed,slow,save --jobs 12' test
[... lots of output snipped ...]
Test Summary Report
-------------------
t3424-rebase-empty.sh                            (Wstat: 256 Tests: 20
Failed: 18)
  Failed tests:  3-20
  Non-zero exit status: 1
t3436-rebase-more-options.sh                     (Wstat: 256 Tests: 19
Failed: 17)
  Failed tests:  2-18
  Non-zero exit status: 1
t4151-am-abort.sh                                (Wstat: 256 Tests: 20
Failed: 12)
  Failed tests:  5-9, 12-16, 19-20
  Non-zero exit status: 1
t3407-rebase-abort.sh                            (Wstat: 256 Tests: 17
Failed: 8)
  Failed tests:  2-9
  Non-zero exit status: 1
t3428-rebase-signoff.sh                          (Wstat: 256 Tests: 7 Faile=
d: 5)
  Failed tests:  2, 4-7
  Non-zero exit status: 1
t6409-merge-subtree.sh                           (Wstat: 256 Tests: 12
Failed: 5)
  Failed tests:  2-6
  Non-zero exit status: 1
t7102-reset.sh                                   (Wstat: 256 Tests: 38
Failed: 7)
  Failed tests:  14-20
  Non-zero exit status: 1
t6432-merge-recursive-space-options.sh           (Wstat: 256 Tests: 11
Failed: 4)
  Failed tests:  2, 7-8, 11
  Non-zero exit status: 1
t6430-merge-recursive.sh                         (Wstat: 256 Tests: 37
Failed: 15)
  Failed tests:  10-11, 13-20, 22-24, 28-29
  Non-zero exit status: 1
t3406-rebase-message.sh                          (Wstat: 256 Tests: 32
Failed: 8)
  Failed tests:  22, 24-27, 29-31
  Non-zero exit status: 1
t4200-rerere.sh                                  (Wstat: 256 Tests: 36
Failed: 5)
  Failed tests:  24-28
  Non-zero exit status: 1
t7201-co.sh                                      (Wstat: 256 Tests: 46
Failed: 5)
  Failed tests:  5-9
  Non-zero exit status: 1
t3418-rebase-continue.sh                         (Wstat: 256 Tests: 29
Failed: 7)
  Failed tests:  4, 6, 10-12, 26-27
  Non-zero exit status: 1
t3403-rebase-skip.sh                             (Wstat: 256 Tests: 20
Failed: 3)
  Failed tests:  2, 4, 9
  Non-zero exit status: 1
t4253-am-keep-cr-dos.sh                          (Wstat: 256 Tests: 7 Faile=
d: 2)
  Failed tests:  6-7
  Non-zero exit status: 1
t9903-bash-prompt.sh                             (Wstat: 256 Tests: 67
Failed: 39)
  Failed tests:  16-31, 33-35, 37, 40-44, 46-52, 55-58, 60
                62, 67
  Non-zero exit status: 1
t3503-cherry-pick-root.sh                        (Wstat: 256 Tests: 6 Faile=
d: 2)
  Failed tests:  5-6
  Non-zero exit status: 1
t3401-rebase-and-am-rename.sh                    (Wstat: 256 Tests: 10
Failed: 2)
  Failed tests:  4, 10
  Non-zero exit status: 1
t2407-worktree-heads.sh                          (Wstat: 256 Tests: 12
Failed: 2)
  Failed tests:  4-5
  Non-zero exit status: 1
t5407-post-rewrite-hook.sh                       (Wstat: 256 Tests: 17
Failed: 3)
  Failed tests:  4-6
  Non-zero exit status: 1
t2500-untracked-overwriting.sh                   (Wstat: 256 Tests: 10
Failed: 2)
  Failed tests:  9-10
  Non-zero exit status: 1
t4153-am-resume-override-opts.sh                 (Wstat: 256 Tests: 6 Faile=
d: 1)
  Failed test:  3
  Non-zero exit status: 1
t1015-read-index-unmerged.sh                     (Wstat: 256 Tests: 6 Faile=
d: 1)
  Failed test:  6
  Non-zero exit status: 1
t3509-cherry-pick-merge-df.sh                    (Wstat: 256 Tests: 9 Faile=
d: 1)
  Failed test:  9
  Non-zero exit status: 1
t2023-checkout-m.sh                              (Wstat: 256 Tests: 5 Faile=
d: 1)
  Failed test:  5
  Non-zero exit status: 1
t7615-diff-algo-with-mergy-operations.sh         (Wstat: 256 Tests: 7 Faile=
d: 1)
  Failed test:  2
  Non-zero exit status: 1
t6427-diff3-conflict-markers.sh                  (Wstat: 256 Tests: 9 Faile=
d: 1)
  Failed test:  8
  Non-zero exit status: 1
t1004-read-tree-m-u-wf.sh                        (Wstat: 256 Tests: 17
Failed: 1)
  Failed test:  17
  Non-zero exit status: 1
t3420-rebase-autostash.sh                        (Wstat: 256 Tests: 52
Failed: 10)
  Failed tests:  11-17, 21-23
  Non-zero exit status: 1
t4150-am.sh                                      (Wstat: 256 Tests: 87
Failed: 33)
  Failed tests:  34-40, 42-46, 48, 50-54, 57-62, 64-65, 67-71
                75, 87
  Non-zero exit status: 1
t7512-status-help.sh                             (Wstat: 256 Tests: 46
Failed: 3)
  Failed tests:  5-6, 29
  Non-zero exit status: 1
t3400-rebase.sh                                  (Wstat: 256 Tests: 39
Failed: 1)
  Failed test:  30
  Non-zero exit status: 1
t3404-rebase-interactive.sh                      (Wstat: 256 Tests:
131 Failed: 1)
  Failed test:  80
  Non-zero exit status: 1
Files=3D1031, Tests=3D30662, 70 wallclock secs ( 8.33 usr  2.13 sys +
248.60 cusr 516.60 csys =3D 775.66 CPU)
Result: FAIL
make[1]: *** [Makefile:73: prove] Error 1
make[1]: Leaving directory '/home/newren/floss/git/t'
make: *** [Makefile:3237: test] Error 2

I suspect this is a case where it was testing a version of git that
you built before making the changes.
