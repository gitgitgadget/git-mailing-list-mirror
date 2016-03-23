From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: GSoC 2016 | Proposal | Incremental Rewrite of git bisect
Date: Thu, 24 Mar 2016 04:57:12 +0530
Message-ID: <CAFZEwPNXKo5YN9OPPCkO90bSPD3ittU+y8eDxh-JLxnihBznuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 24 00:27:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aisBK-0001qx-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 00:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbcCWX1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 19:27:15 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36110 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcCWX1N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 19:27:13 -0400
Received: by mail-yw0-f194.google.com with SMTP id p65so3532768ywb.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 16:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=gRlYXXO+wnXhCsiD4oJDOU57QNuLwU7djvggOU3kUe4=;
        b=I0DzRa6ZmO8fxTQOgLl68FFHg6btaSgpbJUrh90Kz4WKilgoNgy6ZHQGdARBuKBCqW
         lxaMQ/64lZ1YWrujzRt9UJlEW5HLwwGCUhgEnHsJ+mNwCAKluINawx/J77kMOCdkytQ2
         4l/i0t0ZENpKTeuXx1rF+swAXIawJDeKaxaqKvO2PMhdMPSpQol3ltT49rDn44GhsFdN
         AlXtRyMiJzAcMZAUyBN49GR/x9cF8EmHDfKtsVJLjd0GpXaxYj7Enc7mGKqJNuvgQEoo
         M372U/uHO2kUKF1JBDgEsBvIgo+tG4LewLvWIcZ/FOC8aFWdhcHkpiDEQ2MEl5z0Rptz
         8fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=gRlYXXO+wnXhCsiD4oJDOU57QNuLwU7djvggOU3kUe4=;
        b=XrmyTRs9RiFOQOyV17kjIAmkm0XeSCcQwhtmXw/QEojgarT/YC9e4N0vCYjxylKg4z
         KE3E8TylWiM+N8Aj6S6lkkk0oQFVZ1WWFs2thsCAJ0QgZ0R7Y1w8bdEQy6qpoaF/iE2j
         bYlgbnyTFhuU1jdR9+ZdiP4/dOPuGmXs9EXv6df5mmXjUYhhHMBfLWqYPgLt/GjU03rI
         ibkYfG+iek0+dsGc10Dl4ZRZfiSiroxARoTWx3gESxpewyG+Ju5iZoYwEB6dlnFuirqh
         +3774n7eGkQfGoTO4Z0DPKNKGABjwkvBTwIGUX0b8YVjw+EI0/DfnC4JC5FWB4whjLM9
         RaMw==
X-Gm-Message-State: AD7BkJIHaHHlcKIA23k8HposzrjAR4Kol+dVOE5g9FhIqmfcuCJqbTj96NcBuJ4RiVAigjCgur3EY+MflDfBHQ==
X-Received: by 10.37.100.196 with SMTP id y187mr2970486ybb.80.1458775632547;
 Wed, 23 Mar 2016 16:27:12 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 16:27:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289700>

Hey!

I have prepared a proposal for Google Summer of Code 2016. I know this
is a bit late, but please try to give your comments and suggestions.
My proposal could greatly improve from this. Some questions:

1. Should I include more ways in which it can help windows?
2. Should I include the function names I intend to convert?
3. Is my timeline (a bit different) going to affect me in any way?

Here is a Google doc for my proposal.
https://docs.google.com/document/d/1stnDPA5Hs3u0a8sqoWZicTFpCz1wHP9bkif=
cKY13Ocw/edit?usp=3Dsharing

=46or the people who prefer the text only version :

-----------------------------------------------------------------------=
------------

Incremental rewrite of Git bisect

About Me

Basic Information


Name           Pranit Bauva

University     IIT Kharagpur

Major            Mining Engineering

Email            pranit.bauva@gmail.com

IRC              pungi-man

Blog             http://bauva.in

Timezone     IST (UTC +5:30)

Background

I am a first year undergraduate in the department of Mining
Engineering at Indian Institute of Technology, Kharagpur. I am an open
source enthusiast. I am a part of Kharagpur Linux Users Group which is
basically a group of open-source enthusiasts. I am quite familiar with
C and I have been using shell for some time now and still find new
things about it everyday. I have used SVN when I was on Windows and
then I switched to Git when I moved to linux. Git seems like magic. I
always wanted to involve in the development process and Google Summer
of Code is an a awesome way to achieve it.


Abstract

Git bisect is a frequently used command which helps the developers in
finding the commit which introduced the bug. Some part of it is
written in shell script. I intend to convert it to low level C code
thus making them builtins. This will increase Git=E2=80=99s portability=
=2E
Efficiency of git bisect will definitely increase but it would not
really matter much as most of the time is consumed in compiling or
testing when in bisection mode but it will definitely reduce the
overhead IO which can make the heavy process of compiling relatively
lighter.


Problems Shell creates

System Dependencies

Using shell code introduces various dependencies even though they
allowing prototyping of the code quickly. Shell script often use some
POSIX utilities like cat, grep, ls, mkdir, etc which are not included
in non-POSIX systems by default. These scripts do not have access to
the git=E2=80=99s internal low level API. So even trivial tasks have to=
 be
performed by spawning new process every time. So when git is ported to
windows, it has to include all the utilities (namely a shell
interpreter, perl bindings and much more).

Scripts introduce extra overheads

Shell scripts do not have access to Git=E2=80=99s internal API which ha=
s
excellent use of cache thus reducing the unnecessary IO of user
configuration files, repository index and filesystem access. By using
a builtin we could exploit the cache system thus reducing the
overhead. As compiling / testing already involves quite a number of
resources, it would be good if we could do our best to make more
resources available for that.

Potential Problems

Rewriting may introduce bugs

Rewriting the shell script to C might introduce some bugs. This
problem will be properly taken care of in my method of approach
(described below). Still this approach will definitely not guarantee
that the functionality of the new will be exactly similar to the old
one, though it will greatly reduce its possibility. The reviews
provided by the seniors in the git community would help a lot in
reducing bugs since they know the common bugs and how to work around
them. The test suite of git is quite nice which has an awesome
coverage.

Rewritten can be hard to understand

Git does not like having many external dependencies, libraries or
executables other than what is provided by git itself and the
rewritten code should follow this. C does not provide with a lot of
other facilities like text processing which shell does whose C
implementation often spans to multiple lines. C is also notorious for
being a bit =E2=80=9Ccryptic=E2=80=9D. This problem can be compensated =
by having well
written documentation with well defined inputs, outputs and behavior.

A peek into git bisect

How does it help?

Git bisect helps the software developers to find the commit that
introduced a regression. Software developers are interested in knowing
this because a commit changes a small set of code (most time).  It is
much easier to understand and fix a problem when you know only need to
check a very small set of changes, than when you don=E2=80=99t know whe=
re to
look at it. It is not that the problem will be exactly in that commit
but it will be related to the behavior introduced in the commit.
Software bugs can be a nightmare when the code base is very large.
There would be a lot of sleepless night in figuring out the part which
causes the error. This is where git bisect helps. This is the one of
the most sought after tool in software development.

Git bisect algorithm (short description)

Git=E2=80=99s commits form a directed acyclic graph (DAG) which makes i=
t a bit
difficult to find the bisection commit. The algorithm it uses is :

Step 1: Keeps only the ancestors of =E2=80=9Cbad=E2=80=9D commit (inclu=
ding =E2=80=9Cbad=E2=80=9D one)
and the commits that are not the ancestors of =E2=80=9Cgood=E2=80=9D co=
mmit (excluding
=E2=80=9Cgood=E2=80=9D one). This helps in reducing a lot of =E2=80=9Ci=
nteresting=E2=80=9D commits.

Step 2: Starting from the good ends (or end), associate some kind of
=E2=80=9Cweight=E2=80=9D which depends on its distance from the good co=
mmit also
considering some other factors.

Step 3: Find the midpoint of the max weight which will be the bisection=
 commit.

Step 4: Repeat Step 1 but now with one more =E2=80=9Cgood=E2=80=9D comm=
it which will
cause rearranging of =E2=80=9Cweights=E2=80=9D thus finishing the algor=
ithm which uses
binary search.

=46urther details about the algorithm can be found in this article
written by Christian Couder.

Current status of git bisect

The bisect code is currently spread across multiple files namely
git-bisect.sh, bisect.c, bisect.h, and bisect--helper.c . The
algorithmic part is written in bisect.c . git-bisect.sh acts like a
glue connecting parts of bisect.c with git-rev-list (which helps in
listing the commits in various types and formats), git-rev-parse
(which helps in knowing the SHA-1 checksum for the ref passed),
git-symbolic-refs (to read, modify and delete symbolic refs),
git-show-branch (which helps by showing the branches and their
respective commits), git-update-ref (to safely update the SHA-1
checksum stored in a ref safely), git-for-each-ref (to get information
on each ref with given pattern, format, keys and much more) and
git-check-ref-format (to check whether the ref has a proper format and
doesn=E2=80=99t contain some =E2=80=9Cspecial=E2=80=9D characters which=
 aren=E2=80=99t allowed) though
this is soon going to be replaced by using a sub command
`--check-term-format` of bisect--helper whose patch is in its final
stages. git-bisect.sh is responsible for writing the respective data
concerning the status on bisect to the various files namely
BISECT_LOG, BISECT_NAMES, BISECT_START, BISECT_ANCESTORS_OK,
BISECT_LOG, refs/bisect and those which would be included in the
directory once bisection moves further.

How will I go about with this project?

Understand related areas

In the start, I will focus on understanding the things that
git-bisect.sh depends on. I will try to debug that part of code and
understand it through documentation. I will also learn to use some
more parts of API which I am currently unfamiliar with concerning this
project. I will also gain more familiarity with running gdb sessions
for big projects.

Discussion about the future look of bisect

When converting from shell to C, there needs to be quite some amount
of changes rather than just plainly translating the code. This is the
part where I will discuss with the git community as to what parts they
wish they could change it or which are better changed in C. Since C
and shell are quite different, approaches which seem good in shell are
not that good in C and vice versa. So having a thorough discussion can
really help.

Convert each function individually

Then I will convert each function from shell script to a C builtin in
bisect--helper.c individually. This raises a very valid questions as
to how to test whether the function performs the tasks as intended
since tests suites are written for git-bisect.sh and not
bisect--helper.c . To take care for this problem, I will first convert
each function to its C builtin and then provide utility in
bisect--helper.c so that git-bisect.sh can easily communicate with it.
In this way, I can make sure that git-bisect.sh uses a corresponding C
builtin rather than origin shell function to run the tests which will
help in recognising for any errors (if any) which the patch can have.
To help git-bisect.sh communicate, I will make the functions as sub
commands in bisect--helper.c so I can ensure that bisect--helper can
react in a way which is independant of other sub commands.

Unification of bisect.c and bisect--helper.c

This will unify the algorithmic and non-algorithmic parts of bisect
bringing them under one heading to make the code clean.

Thorough testing of bisect

This will be dedicated for thorough deep testing for any problems
which crept in after the shell to C conversion. I will also aim to
include some more tests to improve coverage of bisect. If time
persists, I will dig further in examining the failing tests and try
and fix the bugs.

Optimizing

I will mainly try to find ways in which I can make the code run better
or in a nicer way.

Documenting

Since C is notorious for being a bit =E2=80=9Ccryptic=E2=80=9D, the doc=
umentation can
really help the newcomers to ease into diving the codebase.

Goals

Incremental rewrite of `git-bisect.sh`

Get all the code written merged.

Some important points

My semester starts from 18th July so I will start working early just
to get reviews of the patches thoroughly and
code/test/optimize/document properly just to avoid end time hustle and
so that I can have some buffer time. Also, it would save me from the
extra burden once my academic session starts. If time permits then I
will work on Stephan Beyer=E2=80=99s patches which are related to bisec=
t
algorithm and seem quite interesting to me.

Timeline (Tentative)

1st April - 22nd April

Spend time going to the codebase and get familiar with using gdb with
it. I will mostly concentrate on reading up bisect related areas as
mentioned above.

2nd May - 8th May (1st week)

Start discussion about the design of bisect and note down the points
which some developers want to be changed. Also see the test suite as
to what is the expected behavior of a particular bisect related
command.

9th May - 26th June (2nd-8th week)

I count 23 functions (-1 probably) currently in git-bisect.sh . Each
function should take on an average 2 days including code/test/review
and some functions are quite small. Also by this time I will be quite
familiar with the codebase, review process and conventions so I won=E2=80=
=99t
make many mistakes and the reviews can go faster. Still I have kept
some buffer time for just in case some bug comes (which is quite a
reasonable possibility).


27th June - 3rd July (9th week)

Testing - I will mostly test the parts of code that I have written.
Also I will explore more on the use of git bisect and try to improve
its coverage.


4th July - 18th July (10th - 11th week)

Bug fixing - I will try and fix up some leftover bugs which were
either introduced because of the conversion or which were already
present.

18th July - 24th July (12th week)

Optimizing the C code I have written. Document the code enough so that
it is easier for a newcomer to dive in.

25th July - 23rd August (left over time)

I will keep this as a buffer period if anything goes wrong with this
timeline. Also I wish to work on Stephan Beyer=E2=80=99s patches concer=
ning
bisect which currently contain 1 leftover bug.


Micro-project attempted

I attempted a micro project which will add configurations for commonly
used command-line options (git commit -v). The link for the patch is
here. This is in its last stages and is soon expected to be complete.

Demo function conversion

As suggested by Johannes Schindelein <Johannes.Schindelein@gmx.de>, I
have tried converting one function from shell to C, the function being
check_term_format() to have a taste of how to go about with this
project. Here is a link to the patch. This patch is in its final
stage. This exercise was quite helpful!

Plans for Summer

I currently don=E2=80=99t have any plans for this summer. Though my new
semester starts from 18th July. So I will start early.

Possible Mentors

Christian Couder <christian.couder@gmail.com>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
