Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5BC202A5
	for <e@80x24.org>; Thu, 28 Sep 2017 17:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdI1RRC (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 13:17:02 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:47199 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdI1RRB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 13:17:01 -0400
Received: by mail-pg0-f41.google.com with SMTP id d8so1289879pgt.4
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dhNCahQDSWICN/dnk/JVCjsdJtu4N8ozsZ8No4q0c8I=;
        b=A9P2JB7jcqz1tFdMZq8a70fpuN8G2bAIwrNWb3UWA2Li03jomNOeOGIdwI2uAzh0sO
         sWqzKhkp0Ewad0NjIRvuERHptWPmDESIo9q2vtQwhV4nl6iJL0zltbEwaFk/zYoy/YBC
         G8EOt7sF/rHCY2eMdAJTCNlAuvm3Sqi4pRi0EH16cP1JIIE2+QeiDdsWzGYF0Ptws65o
         fpSoYfmzsc6YzGpH4Ad63LBH/ihlhSzmVgj7vB5vcTZPo5KAMXISpkyXzw40uMh8SMfD
         chDte1O1/NNieecLwJ2t87YZcjuBizFwEiouPfFFsbmyIpszrnNuRN+SepDV5IiM8LiJ
         zGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhNCahQDSWICN/dnk/JVCjsdJtu4N8ozsZ8No4q0c8I=;
        b=qnVGHKu25d1+0lu6x8m+NmGD+VIbmx/y7bjRJ9onMMoGKPfH8xWoqeJcFZDgRYbIXz
         AaJd4u5csUJ0v+A2N5jdAbjJMr+C4f5AII0yrv3YC3ohfmCirNpIMQRIm655zCOWVKx3
         pIpf0R6BXfOtG+f8iHqtPEASB3vyfp1Mps+L6r0oGOKIuULDq8XLixklhlIXokPVIiwZ
         hxCEDP2WH7JvofX55HtdqJiltBhyr/wZUzQnZcMgIy4jYi4/MYlNbNPJdL6vMlXkUrss
         f54WUkAVf05GjfQVxlnxDJMQb6bWAmG376hD1QHiKas41eKg8ZhNFiL6okxlVeIinyZL
         rm1Q==
X-Gm-Message-State: AHPjjUhbmyGF3e7V5klmfBOsWJCx7NLzHv/De8Bh1jhvA7JMJGfluJc/
        rPntnnV8zuTbZVxSrb9uzhWsUA==
X-Google-Smtp-Source: AOwi7QBXRDScryQXdJKMGA2ikFbVA5FjSYJHlLXcNpwizB8vZie/1ZoclEh8SfOgt6KftSZFvlMeVQ==
X-Received: by 10.84.194.3 with SMTP id g3mr4630760pld.246.1506619020085;
        Thu, 28 Sep 2017 10:17:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:880:967f:fa0a:fc13])
        by smtp.gmail.com with ESMTPSA id r11sm3919848pfg.180.2017.09.28.10.16.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 10:16:58 -0700 (PDT)
Date:   Thu, 28 Sep 2017 10:16:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170928171657.GB153914@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
 <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
 <20170808182324.GB73298@google.com>
 <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
 <alpine.DEB.2.21.1.1709281249520.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709281249520.40514@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/28, Johannes Schindelin wrote:
> Hi all,
>
> On Thu, 10 Aug 2017, Johannes Schindelin wrote:
>
> > On Tue, 8 Aug 2017, Brandon Williams wrote:
> >
> > > On 08/08, Stefan Beller wrote:
> > > > On Tue, Aug 8, 2017 at 5:05 AM, Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > >
> > > > > On Mon, 7 Aug 2017, Brandon Williams wrote:
> > > > >
> > > > >> Add a '.clang-format' file which outlines the git project's
> > > > >> coding style.  This can be used with clang-format to auto-format
> > > > >> .c and .h files to conform with git's style.
> > > > >>
> > > > >> Signed-off-by: Brandon Williams <bmwill@google.com>
> > > > >> ---
> > > > >>
> > > > >> I'm sure this sort of thing comes up every so often on the list
> > > > >> but back at git-merge I mentioned how it would be nice to not
> > > > >> have to worry about style when reviewing patches as that is
> > > > >> something mechanical and best left to a machine (for the most
> > > > >> part).
> > > > >
> > > > > Amen.
> > > > >
> > > > > If I never have to see a review mentioning an unwrapped line, I am quite
> > > > > certain I will be quite content.
> > > >
> > > > As a thought experiment I'd like to propose to take it one step further:
> > > >
> > > >   If the code was formatted perfectly in one style such that a
> > > >   formatter for this style would not produce changes when rerun
> > > >   again on the code, then each individual could have a clean/smudge
> > > >   filter to work in their preferred style, and only the exchange and
> > > >   storage of code is in a mutual agreed style. If the mutually
> > > >   agreed style is close to what I prefer, I don't have to use
> > > >   clean/smudge filters.
> > > >
> > > > Additionally to this patch, we'd want to either put a note into
> > > > SubmittingPatches or Documentation/gitworkflows.txt to hint at
> > > > how to use this formatting to just affect the patch that is currently
> > > > worked on or rather a pre-commit hook?
> > >
> > > I'm sure both of these things will probably happen if we decide to make
> > > use of a code-formatter.  This RFC is really just trying to ask the
> > > question: "Is this something we want to entertain doing?"
> > > My response would be 'Yes' but there's many other opinions to consider
> > > first :)
> >
> > I am sure that something even better will be possible: a Continuous
> > "Integration" that fixes the coding style automatically by using
> > `filter-branch` (avoiding the merge conflicts that would arise if `rebase
> > -i` was used).
>
> FWIW I just set this up in my VSTS account, with the following build step
> (performed in one of the Hosted Linux agents, i.e. I do not even have to
> have a VM dedicated to the task):
>
> -- snip --
> die () {
>     echo "$*" >&2
>     exit 1
> }
>
> head=$(git rev-parse HEAD) ||
> die "Could not determine HEAD"
>
> test -n "$BUILD_SOURCEBRANCHNAME" ||
> die "Need a source branch name to work with"
>
> base=$(git merge-base origin/core/master HEAD) &&
> count=$(git rev-list --count $base..) &&
> test 0 -lt $count ||
> die "Could not determine commits to clean up (count: $count)"
>
> test -f .clang-format ||
> git show origin/core/pu/.clang-format >.clang-format ||
> die "Need a .clang-format"
>
> sudo add-apt-repository 'deb http://apt.llvm.org/xenial/
> llvm-toolchain-xenial main' &&
> sudo apt-get update &&
> sudo apt-get --allow-unauthenticated -y install clang-format-6.0 ||
> die "Could not install clang-format 6.0"
>
> git filter-branch -f --tree-filter \
>     'git diff HEAD^.. |
>      clang-format-diff-6.0 -p 1 -i &&
>
>      git update-index --refresh --ignore-submodules &&
>      git diff-files --quiet --ignore-submodules ||
>      git commit --amend -C HEAD' $base.. ||
> die "Could not rewrite branch"
>
> if test "$head" = "$(git rev-parse HEAD)"
> then
>     echo "No changes in $BUILD_SOURCEBRANCHNAME introduced by clang-format" >&2
> else
>     git push vsts +HEAD:refs/heads/clang-format/"$BUILD_SOURCEBRANCHNAME" ||
>     die "Could not push clang-format/$BUILD_SOURCEBRANCHNAME"
>     echo "Clean branch pushed as clang-format/$BUILD_SOURCEBRANCHNAME" >&2
>     exit 123
> fi
> -- snap --
>
> A couple of notes for the interested:
>
> - you can easily set this up for yourself, as Visual Studio Team Services
>   is free for small teams up to five people (including single developer
>   "teams"): https://www.visualstudio.com/team-services/, and of course you
>   can back it by your own git.git fork on GitHub, no need to host the code
>   in VSTS.
>
>   Disclaimer: I work closely with the developers behind Visual Studio Team
>   Services, and I am a genuine fan, yet I understand if anybody thinks of
>   this as advertising the service, so this will be the only time I mention
>   this.
>
> - the script assumes that there is a `core/master` tracking upstream Git's
>   master branch, then reformats the commits in the current branch that are
>   not also reachable from core/master.
>
> - The push credentials to push the result at the end are of course not
>   included in the script, they need to be provided separately.
>
> - the exit code 123 when the branch needed to be rewritten indicates to
>   any consumer that the build "failed". The reason is that I want to
>   integrate this into a system where I open a PR in my own account, which
>   triggers the build automatically contingent on the base branch being
>   core/master, and if the build fails, the PR gets "blocked", providing a
>   very easy way to see that there is still work to be done.
>
> - for the moment, I do not push back to the original branch, even if I
>   could. The reason is that already my first test produced a dubious
>   result, see below.
>
> I am reasonably happy with the way this build job works right now,
> especially given that I do not have to mess up any other setup I have just
> to get the bleeding edge version of Clang.
>
> Now for the dubious result.
>
> I took my most recent contribution, the lazyload one (which you can easily
> get yourself by fetching the lazyload-v2 tag from
> https://github.com/dscho/git), because it was pretty self-contained and
> small, only one patch. With the current .clang-format as per git.git's
> master (or for that matter, pu, as they are identical), the output `git
> show | clang-format-diff-6.0 -p 1` ends in this hunk:
>
> -- snip --
> @@ -43,8 +43,7 @@
>         if (!proc->initialized) {
>                 HANDLE hnd;
>                 proc->initialized = 1;
> -               hnd = LoadLibraryExA(proc->dll, NULL,
> -                                    LOAD_LIBRARY_SEARCH_SYSTEM32);
> +               hnd = LoadLibraryExA(proc->dll, NULL, LOAD_LIBRARY_SEARCH_SYSTEM32);
>                 if (hnd)
>                         proc->pfunction = GetProcAddress(hnd, proc->function);
>         }
> -- snap --
>
> (tabs intentionally converted to spaces, to show the extent of the damage
> clearly)
>
> In other words, despite the column limit of 80 (with a tab width of 8
> spaces), it takes a perfectly well formatted pair of lines and combines
> them into a single line that now has 84 columns. Absolutely not what we
> want.
>
> Even worse: if I replace the column limit of 80 by 79, like so:
>
> -- snip --
> diff --git a/.clang-format b/.clang-format
> index 3ede2628d2d..9f686c1ed5a 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -6,7 +6,7 @@ UseTab: Always
>  TabWidth: 8
>  IndentWidth: 8
>  ContinuationIndentWidth: 8
> -ColumnLimit: 80
> +ColumnLimit: 79
>
>  # C Language specifics
>  Language: Cpp
> -- snap --
>
> then that hunk vanishes and clang-format leaves the LoadLibraryEx() lines
> alone!
>
> Even stranger, if I revert to 80 columns, copy the offending line above
> the conditional block so that the indentation level is different (based on
> a hunch that this may have something to do with clang's understanding of
> tab widths) and extend the last parameter artificially, it still breaks at
> exactly 84 columns, i.e. if I make the line 84 columns long, it keeps it
> as one line, if I extend it to 85 columns, it breaks the line into two.
>
> In fact, the same holds true even with no indentation at all: if I turn
> this line into a static variable assignment outside of the function, it
> again breaks the line as soon as I extend it to 85 columns.
>
> Then I repeated the exercise with clang-format-6.0 instead of
> clang-format-diff-6.0, and the finding still holds. 85 columns, despite
> the explicit ColumnLimit: 80 in .clang-format.
>
> I then tried to format a file containing only the line "int i123, j123;"
> with various values for ColumnLimit, and could not get it to break at all.
>
> Any insights?

I think I know what is happening here, and this is something that we
will need to tweak based on more people beginning to use the formatting
tool.

In the .clang-format file there are a number of parameters at the end:

    # Penalties
    # This decides what order things should be done if a line is too long
    PenaltyBreakAssignment: 100
    PenaltyBreakBeforeFirstCallParameter: 100
    PenaltyBreakComment: 100
    PenaltyBreakFirstLessLess: 0
    PenaltyBreakString: 100
    PenaltyExcessCharacter: 5
    PenaltyReturnTypeOnItsOwnLine: 0

These penalties are used to determine which line breaking events should be
done based on some programmable weight (or penalty).  I thing that if we
bump up the penalty on excess characters to something higher than '5'
(which i think is quite low) then it may format more like you were
expecting.

--
Brandon Williams
