Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1841F404
	for <e@80x24.org>; Sun, 25 Mar 2018 00:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeCYAnc (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 20:43:32 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:40613 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeCYAnb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 20:43:31 -0400
Received: by mail-wr0-f177.google.com with SMTP id z8so15483595wrh.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bm3OR2C2DPOj5QkdgGuKqnwR9kcfPXcoXdeJ6lewOik=;
        b=kBROSDk5GA9B8Gdk/lWSHWE0iewnZ3myo2ujc9OsPTSgz3zrwRXwIoDO1cAy1SuZzm
         67dkigEGn/HSZCUd8DffYuz26VIBGAFUBpZgrdw7pwkqTVgaUMW8N35hjFJnmAXZ/Q9H
         N5XRgfKtkW0XgxSAbaNTNsf2yK1FmkjUw1nDgsZbncLnTB1OoyxIthXLD7wlcOmd9SRH
         j0u7awfaQZW5ivVpam+wLZzQp5GiL61cVlEAudmvV6yb2AvAEDtZoBpA+9HU66cSP3GG
         SYH2Pd7Y6J53S0qk7JMiOyId81ebLgq0zzfHTdj2W0TTJULsBeXpXbIWUa/I/Eg0mXAl
         5lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bm3OR2C2DPOj5QkdgGuKqnwR9kcfPXcoXdeJ6lewOik=;
        b=s4ZMYTBz6GWjBac/g98Vv2JZzhWFdSwrhdT4kjJXbpgxzj8PNeCClDB148XRnyRFWR
         +Mfso2d9+/h0AWGbirdqM049aJGHpi7uav90x6dlxB8b6nTWX9dPfR0dpjJZUVM+zHHc
         pZ6gQ8/lqdgMec/o7KMBScCQkG59DPuMSDYQH6ms06FBGSc7AcKOxLS57bbOxNHpNUyY
         Ys3ZIJiHuQEFQ9b7IMNHCsRrnRd8Y0biwTgrumf3zzkgbslNvepGJ65PMdiSZGrv2Wp0
         M4FkuaHmJmGIBtYCkFAD7HvUerNa6vyg4zuldf+obXovKSslThe4oeafugXBdhEH3YPX
         3u/A==
X-Gm-Message-State: AElRT7GoU/yiXrR+hyf//4pt/eRDGnSe1l3iCnJaQIi13Bmm7QccKi5E
        Q+b5yAR4DvGUgZCIhER1JHQ=
X-Google-Smtp-Source: AG47ELsgnTqt6q3eWnK+7qHhRKQZv40i2gcTXs0dd0eEcXTAhmtdHMA+5siuxTHLckzvl8yaVQEqTQ==
X-Received: by 10.223.209.194 with SMTP id m2mr14444960wri.214.1521938608246;
        Sat, 24 Mar 2018 17:43:28 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-141-195.w92-149.abo.wanadoo.fr. [92.149.156.195])
        by smtp.gmail.com with ESMTPSA id t74sm1698268wme.2.2018.03.24.17.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 17:43:27 -0700 (PDT)
Subject: Re: [RFC v3][GSoC] Project proposal: convert interactive rebase to C
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <2564070.6kGkNsz7Qa@andromeda>
 <ef8552ba-edb0-ea10-29fd-32152adbc992@gmail.com>
Message-ID: <cfadb1da-4d8b-ff70-5e5c-7c2fa0b8950a@gmail.com>
Date:   Sun, 25 Mar 2018 01:43:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ef8552ba-edb0-ea10-29fd-32152adbc992@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
this is the first draft of my proposal.

---
ABSTRACT

git is a modular source control management software, and all of its
subcommands are programs on their own. A lot of them are written in C,
but a couple of them are shell or Perl scripts. This is the case of
=git-rebase--interactive= (or interactive rebase), which is a shell
script. Rewriting it in C would improve its performance, its
portability, and maybe its robustness.


ABOUT `git-rebase` AND `git-rebase--interactive`

git-rebase allows to re-apply changes on top of another branch. For
instance, when a local branch and a remote branch have diverged,
git-rebase can re-unify them, applying each change made on the
local branch on top of the remote branch.

git-rebase--interactive is used to reorganize commits by reordering,
rewording, or squashing them. To achieve this purpose, =git= opens the
list of commits to be modified in a text editor (hence the
interactivity), as well as the actions to be performed for each of
them.


PROJECT GOALS

Back in 2016, Johannes Schindelin discussed[1] about retiring
git-rebase.sh (described here as a “hacky shell script”) in favor of
a builtin. He explained that, as it’s only a command-line parser for
git-rebase--am.sh, git-rebase--interactive.sh, and
git-rebase--merge.sh, these 3 scripts should be rewritten first.

The goal of this project is to rewrite git-rebase--interactive.sh in
C, for multiple reasons :

Performance improvements
Shell scripts are inherently slow. When Johannes Schindelin began to
rewrite some parts of git-rebase--interactive in C, its performance
increased from 3 to 5 times, depending on the platform[2].

That’s because each command is a program by itself. So, for each
command, the shell interpreter has to spawn a new process and to load
a new program (with fork() and exec() syscalls), which is an
expensive process.

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

Normally, I would be able to work 35 to 40 hours a week. When I have
courses or exams at university, I could work between 20 and 25 hours a
week.

Community bonding --- April 23, 2018 -- May 14, 2018
/I’ll still have courses at the university during this period./

During the community bonding, I would like to dive into git’s
codebase, and to understand what git-rebase--interactive does under
the hood. At the same time, I’d communicate with the community and my
mentor, seeking for clarifications, and asking questions about how
things should or should not be done.

Weeks 1 & 2 --- May 14, 2018 -- May 27, 2018
/From May 14 to 18, I have exams at the university, so I won’t be able
to work full time./

I would search for edge cases not covered by current tests and write
some if needed.

Week 3 --- May 28, 2018 -- June 3, 2018
At the same time, I would refactor --preserve-merges in its own
shell script, if it has not been deprecated or moved in the
meantime. Dscho explained that this would be the first step of the
conversion[1]. This operation is not really tricky by itself,
as --preserve-merges is about only 50 lines of code into
git_rebase__interactive(), plus some specific functions
(eg. pick_one()).

Weeks 4 to 7 --- June 4, 2018 -- July 1, 2018
Then, I would start to incrementally rewrite
git-rebase--interactive.sh functions in C, and move them
git-rebase--helper.c. Newly-rewritten C functions are then
associated to command-line parameters to be able to use them from
shell scripts.

Examples of such conversion can be found in commits
0cce4a2756[3] (rebase -i -x: add exec commands via the
rebase--helper) and b903674b35[4] (bisect--helper:
`is_expected_rev` & `check_expected_revs` shell function in C).

There is a lot of functions into git-rebase--interactive.sh to
rewrite. Most of them are small, and some of them are even wrappers
for a single command (eg. do_next()), so they shouldn’t be really
problematic.

A couple of them are quite long (eg. pick_one()), and will probably
be even longer once rewritten in C due to the low-level nature of the
language. They also tend to depend a lot on other smaller functions.

The plan here would be to start rewriting the smaller functions when
applicable (ie. they’re not a simple command wrapper) before
working on the biggest of them.

Of course, rewriting a function should not cause any breakage in the
test suite.

Week 8 --- July 2, 2018 -- July 8, 2018
Then, I plan to polish the new code, in order to improve its
performance or to make it more readable.

Benchmarking will be done using the existing script in t/perf.

Weeks 9 & 10 --- July 9, 2018 -- July 22, 2018
When all majors functions from git-rebase--interactive.sh have been
rewritten in C, I would retire the script in favor of a builtin.

Weeks 11 & 12 --- July 23, 2018 -- August 5, 2018
In the last two weeks, I would improve the code coverage where needed.

I also plan to use this time as a backup if I am late on my planning.


IF TIMES PERMITS

 * Add an option to include the patch in the message of commits to be
   reworded, as proposed by Ævar Arnfjörð Bjarmason[5].


COMMUNICATING ABOUT MY WORK

I will communicate every week about the state of my work on the
mailing list.


ABOUT ME

My name is Alban Gruin. I am an undergraduate at the Paul Sabatier
University in Toulouse, France, where I have been studying Computer
Sciences for a year and a half. My timezone is UTC+02:00.

I have been programming in C for the last 5 years. I learned using
freely available resources online, and by attending class ever since
last year.

I am also quite familiar with shell scripts, and I have been using
git for the last 3 years.

My e-mail address is alban <dot> gruin <at> gmail <dot> com, my IRC
nick is abngrn.

My micro-project was “userdiff: add built-in pattern for
golang”[6][7].
---

You can find the Google Doc version here[8].

Regards,
Alban Gruin

[1]
https://public-inbox.org/git/alpine.DEB.2.20.1609021432070.129229@virtualbox/
[2]
https://public-inbox.org/git/cover.1472457609.git.johannes.schindelin@gmx.de/
[3] https://git.kernel.org/pub/scm/git/git.git/commit/?id=0cce4a2756
[4] https://git.kernel.org/pub/scm/git/git.git/commit/?id=b903674b35
[5] https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com/
[6]
https://public-inbox.org/git/20180228172906.30582-1-alban.gruin@gmail.com/
[7] https://git.kernel.org/pub/scm/git/git.git/commit/?id=1dbf0c0a
[8]
https://docs.google.com/document/d/1Jx0w867tVAht7QI1_prieiXg_iQ_nTloOyaIIOnm85g/edit?usp=sharing
