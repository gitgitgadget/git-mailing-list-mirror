Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931361F404
	for <e@80x24.org>; Thu, 22 Mar 2018 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeCVWDm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 18:03:42 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35330 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeCVWDl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 18:03:41 -0400
Received: by mail-wm0-f41.google.com with SMTP id r82so304330wme.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XZOsGzK9uMlNYzw7wInpFDkNUpERSIWgZn0JmLFvvJ4=;
        b=I/iQVHpO1MXwaUXvvsai4y8UBMw56S5YTmgczJ75CnNz9m8ZsX/7bJz8bvtCFjaKff
         LSyGDBbp9QYISBzSZfjTBDQIZs7ta8TlzO5xoo5pXPKCQCxnOzTFk2ak2Pqyiro7UyzT
         ueJFBe3i0UD3eqmblfkNWblhoh6fqHBDQ+SiG31dF3c+jlHgRx4bE7JY5O6VklSAZNtj
         f6/Ge6Te/oxPLXxbtimOIB4wWIrxW1tZcLbhTqGmcQkWJ1mr6hKBpxG2xWKYrE5B68IY
         CXOvxU8NggGr6V5qAiJfoyJ6ekAOhmqi0HDgkeGg9NPSVVqYEuVv2NTXQBo2M8oz0Vyf
         jaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XZOsGzK9uMlNYzw7wInpFDkNUpERSIWgZn0JmLFvvJ4=;
        b=ZoaB69uat0G6B0dbBJQHBVD491z/3pre98WVjqMzxZSiBlVTRQ7Fk+OFA2m7QNRtGH
         l1e/H9VcuQJPyS18fn3o4iV2lROyRoW2WFwry+YeaVl9ElU22OXHJ7/RNMfudVEPUxaP
         22wM3JNwnxK9dCQcbF5+kL01ITa9b57TMpR0MJ3U1W1HZX8ZdvjsRFmA6SiTVXWOYVVn
         Pg7Q/cgCwF+3XPyLmtm3ek++3BWWNzFjnf7u0KnF6W2y4S2WdFwoz/rgxY2qFHIqjDU9
         tXLkyEmkNcT8E8LR2EW8bJOMpuKjnrmloCpV2YSuzikuRoSqVU+bqgT26HfkvtSepvs1
         CY7w==
X-Gm-Message-State: AElRT7HUY4tjM/2NA21igANL3b0Ezp+nDfJ4NRG9t0TSHWN8s0EBWXb5
        9KcnOn9stSKSeH2LXOYcQAs=
X-Google-Smtp-Source: AG47ELuwRmWiqTwISC39LN4ezUgBYrAiCPnXRwc40Jp5GyJ8aBaEyVTNmIFw0HlJ/nk/pGluGixnLg==
X-Received: by 10.28.131.140 with SMTP id f134mr7106315wmd.117.1521756219927;
        Thu, 22 Mar 2018 15:03:39 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-17-82.w86-222.abo.wanadoo.fr. [86.222.16.82])
        by smtp.gmail.com with ESMTPSA id e74sm7579093wmg.27.2018.03.22.15.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 15:03:39 -0700 (PDT)
Subject: Re: [RFC][GSoC] Project proposal: convert interactive rebase to C
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <2564070.6kGkNsz7Qa@andromeda>
Message-ID: <ef8552ba-edb0-ea10-29fd-32152adbc992@gmail.com>
Date:   Thu, 22 Mar 2018 23:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2564070.6kGkNsz7Qa@andromeda>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is my second draft of my proposal. As last time, any feedback is
welcome :)

I did not write my phone number and address here for obvious reasons,
but they will be in the “about me” section of the final proposal.

Apart from that, do you think there is something to add?

---
ABSTRACT

git is a modular source control management software, and all of its
subcommands are programs on their own. A lot of them are written in C,
but a couple of them are shell or Perl scripts. This is the case of
git-rebase--interactive (or interactive rebase), which is a shell
script. Rewriting it in C would improve its performance, its
portability, and maybe its robustness.


ABOUT `git-rebase` and `git-rebase--interactive`

git-rebase allows to re-apply changes on top of another branch. For
instance, when a local branch and a remote branch have diverged,
git-rebase can re-unify them, applying each change made on the
local branch on top of the remote branch.

git-rebase--interactive is used to reorganize commits by reordering,
rewording, or squashing them. To achieve this purpose, git opens the
list of commits to be modified in a text editor (hence the
interactivity), as well as the actions to be performed for each of
them.


PROJECT GOALS

The goal of this project is to rewrite git-rebase--interactive in C
as it has been discussed on the git mailing list[1], for multiple
reasons :


Performance improvements
Shell scripts are inherently slow. That’s because each command is a
program by itself. So, for each command, the shell interpreter has to
spawn a new process and to load a new program (with fork() and
exec() syscalls), which is an expensive process.

Those commands can be other git commands. Sometimes, they are
wrappers to call internal C functions (eg. git-rebase--helper),
something shell scripts can’t do natively. These wrappers basically
parse the parameters, then start the appropriate function, which is
obviously slower than just calling a function from C.

Other commands can be POSIX utilities (eg. sed, cut, etc.). They
have their own problems (speed aside), namely portability.

Portability improvements
Shell scripts often relies on many of those POSIX utilities, which are
not necessarily natively available on all platforms (most notably,
Windows), or may have more or less features depending on the
implementation.

Although C is not perfect portability-wise, it’s still better than
shell scripts. For instance, the resulting binaries will not
necessarily depend on third-party programs or libraries.


RISKS

Of course, rewriting a piece of software takes time, and can lead to
regressions (ie. new bugs). To mitigate that risk, I should understand
well the functions I want to rewrite, run tests on a regular basis and
write new if needed, and of course discuss about my code with the
community during reviews.


APPROXIMATIVE TIMELINE

Community bonding -- April 23, 2018 - May 14, 2018
During the community bonding, I would like to dive into git’s
codebase, and to understand what git-rebase--interactive does under
the hood. At the same time, I’d communicate with the community and my
mentor, seeking for clarifications, and asking questions about how
things should or should not be done.

Weeks 1 & 2 -- May 14, 2018 - May 27, 2018
/From May 14 to 18, I have exams at the university, so I won’t be able
to work full time./

I would search for edge cases not covered by current tests and write
some if needed.

Week 3 -- May 28, 2018 - June 3, 2018
At the same time, I would refactor --preserve-merges in its own
shell script (as described in Dscho’s email[1]), if it has
not been deprecated or moved in the meantime. This operation is not
really tricky by itself, as --preserve-merges is about only 50 lines
of code into git_rebase__interactive().

Weeks 4 to 7 -- May 4, 2018 - July 1, 2018
Then, I would start to incrementally rewrite
git-rebase--interactive.sh functions in C, and move them
git-rebase--helper.c (as in commits 0cce4a2756[2] (rebase -i
-x: add exec commands via the rebase--helper) and b903674b35[3]
(bisect--helper: `is_expected_rev` & `check_expected_revs` shell
function in C)).

There is a lot of functions into git-rebase--interactive.sh to
rewrite. Most of them are small, and some of them are even wrappers
for a single command (eg. is_merge_commit()), so they shouldn’t be
really problematic.

A couple of them are quite long (eg. pick_one()), and will probably
be even longer once rewritten in C due to the low-level nature of the
language. They also tend to depend a lot on other smaller functions.

The plan here would be to start rewriting the smaller functions when
applicable (ie. they’re not a simple command wrapper) before
working on the biggest of them.

Week 8 -- July 2, 2018 - July 8, 2018
When all majors functions from git-rebase--interactive.sh have been
rewritten in C, I would retire the script in favor of a builtin.

Weeks 9 & 10 -- July 9, 2018 - July 22, 2018
I plan to spend theses two weeks to improve the code coverage where
needed.

Weeks 11 & 12 -- July 23, 2018 - August 5, 2018
In the last two weeks, I would polish the code where needed, in order
to improve its performance or to make it more readable.

I also plan to use this time as a backup if I am late on my planning.


IF TIME PERMITS

 * I see there is a known breakage in test t3404. Maybe I could
   investigate and try to fix it.
 * Add an option to include the patch in the message of commits to be
   reworded, as proposed by Ævar Arnfjörð Bjarmason[4].


ABOUT ME

My name is Alban Gruin. I am an undergraduate at the Paul Sabatier
University in Toulouse, France, where I have been studying Computer
Sciences for a year and a half. My timezone currently is UTC+01:00,
but will be UTC+02:00 starting from March 25th, because of the
daylight saving time in Europe.

I have been programming in C for the last 5 years. I learned using
freely available resources online, and by attending class ever since
last year.

I am also quite familiar with shell scripts, and I have been using
git for the last 3 years.

My e-mail address is alban <dot> gruin <at> gmail <dot> com, my IRC
nick is abngrn.

My micro-project was "userdiff: add built-in pattern for
golang"[5][6].

---

You can find the Google Doc version here[7].


Regards,
Alban Gruin

[1]
https://public-inbox.org/git/alpine.DEB.2.20.1609021432070.129229@virtualbox/
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=0cce4a2756
[3] https://git.kernel.org/pub/scm/git/git.git/commit/?id=b903674b35
[4] https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com/
[5]
https://public-inbox.org/git/20180228172906.30582-1-alban.gruin@gmail.com/
[6] https://git.kernel.org/pub/scm/git/git.git/commit/?id=1dbf0c0a
[7]
https://docs.google.com/document/d/1Jx0w867tVAht7QI1_prieiXg_iQ_nTloOyaIIOnm85g/edit?usp=sharing
