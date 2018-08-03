Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9908E1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 10:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeHCL5P (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 07:57:15 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:37705 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbeHCL5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 07:57:15 -0400
Received: from [192.168.2.201] ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id lWtufe7ORwhzSlWtufDxIo; Fri, 03 Aug 2018 11:01:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533290499;
        bh=2ZZmc26Pm6I1Ev6DAdGtnxbOcbhb7ML35NmwaEWylEc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RBy4COaXc4U0kNkSatBzYTPeJKfJuWq6nEPRp2V0Mr/XrWqkWHQATgM61npbFUiEC
         D1Ocf1bGfXzsUc2uahrzpEs+JIA3G3HsNom1Yo8zCZvGlODJXv99JB7T52nzRW8+6C
         /0XlmtHoWKTVwqLkVbXVls+bJ5dCb2T3AknCrn+4=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=8ldtwHJHadVjLwvstokA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=Chu9jQFIVPbQU4lL:21 a=1jNJDIJDFfiXzxoA:21 a=p27JlpC7oE3W6ayU:21
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v5 0/4] add -p: select individual hunk lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
 <874lgjv8h0.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
Date:   Fri, 3 Aug 2018 11:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <874lgjv8h0.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIys2c3qfC94cK3l7h7izYKRIbk5aTm04O5/7VRsbGJV5eUIdnnd0aBl1gJ3u7UYjSN03Hy6DctfaysXjfpO9811qovVemzXWp48qI0Psw9ngVwwyPz3
 dZoDY0i3Z/xW5DTE1s1dR3JRgWC6poBJ4l5wm4tDbNQArkoaJzlOPUuK013SZbYX6BogUjAwX9IGifunjrZ754v+LD/T4hvi5RZGQ64bDMFJQUSEdhkSSjtL
 9ARP/Ld22rWdAo8TGoq2J5qs/PZRi/Tyo7hs2EXG/diqEyRvYIedzHeQuwknehJxevYoSTUj3AOIWPMZ5D0Tpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

Thanks for looking at this.

On 28/07/18 13:40, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 26 2018, Phillip Wood wrote:
> 
>> Unfortuantely v4 had test failures due to a suprious brace from a last
>> minute edit to a comment that I forgot to test. This version fixes
>> that, my applogies for the patch churn.
>>
>> I've updated this series based on Ævar's feedback on v3 (to paraphrase
>> stop using '$_' so much and fix staging modified lines.). The first
>> patch is functionally equivalent to the previous version but with a
>> reworked implementation. Patch 2 is new, it implements correctly
>> staging modified lines with a couple of limitations - see the commit
>> message for more details, I'm keen to get some feedback on it. Patches
>> 3 and 4 are essentially rebased and tweaked versions of patches 2 and
>> 3 from the previous version.
>>
>> This series is based on pw/add-p-recount (f4d35a6b49 "add -p: fix
>> counting empty context lines in edited patches")
>>
>> The motivation for this series is summed up in the first commit
>> message:
>>
>> "When I end up editing hunks it is almost always because I want to
>> stage a subset of the lines in the hunk. Doing this by editing the
>> hunk is inconvenient and error prone (especially so if the patch is
>> going to be reversed before being applied). Instead offer an option
>> for add -p to stage individual lines. When the user presses 'l' the
>> hunk is redrawn with labels by the insertions and deletions and they
>> are prompted to enter a list of the lines they wish to stage. Ranges
>> of lines may be specified using 'a-b' where either 'a' or 'b' may be
>> omitted to mean all lines from 'a' to the end of the hunk or all lines
>> from 1 upto and including 'b'."
> 
> I tested this with an eye towards what I pointed out in
> https://public-inbox.org/git/878ta8vyqe.fsf@evledraar.gmail.com/
> 
> Using the same workflow (search for "So what I was expecting" in that
> E-Mail) this now does the right thing in that example:
> 
>     select lines? 4,10
>     [...]
>     $ git diff --staged -U1
>     diff --git a/README.md b/README.md
>     index ff990622a3..6d16f7e52b 100644
>     --- a/README.md
>     +++ b/README.md
>     @@ -20,3 +20,3 @@ See [Documentation/gittutorial.txt][] to get started, then see
>      Documentation/git-<commandname>.txt for documentation of each command.
>     -If git has been correctly installed, then the tutorial can also be
>     +If Git has been correctly installed, then the tutorial can also be
>      read with `man gittutorial` or `git help tutorial`, and the
>     u git ((49703a4754...) $) $
> 
> Some other comments on this:
> 
> 1) It needs to be more obvious how to exit this sub-mode, i.e. consider
> this confused user:
> 
>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,l,?]? l
>     select lines? ?
>     invalid hunk line '?'
>     select lines? q
>     invalid hunk line 'q'
>     select lines? exit
>     invalid hunk line 'exit'
>     select lines? quit
>     invalid hunk line 'quit'
>     select lines? :wq
>     invalid hunk line ':wq'
>     select lines? help
>     invalid hunk line 'help'
> 
> Just doing Ctrl+D or RET exits it. Instead "?" should print some help
> related to this sub-mode showing what the syntax is, and how to exit the
> sub-mode. I think it would make sense for "q" to by synonymous with
> "RET", i.e. you'd need "q<RET>q<RET>" to fully exit, but I don't know...

Thanks for point this out I meant to add some help and then forgot. As
for exiting adding "q" could be a good idea, at the moment it follows
the behavior of the other sub-prompts of 'add -i' which isn't that user
friendly.

> 
> 2) I think it's confusing UI that selecting some of the lines won't
> re-present the hunk to you again in line mode, but I see this is
> consistent with how e.g. "e" works, it won't re-present the hunk to you
> if there's still something to do, you need to exit and run "git add -p"
> again.
> 
> I think it makes sense to change that and you'd either "e" or "l" and
> then "n" to proceed, or continue, but that's per-se unrelated to this
> feature. Just something I ran into...

That's something I thought about but in the end I didn't do it, maybe I
should look at it again as it makes it easier to get around the
limitations of the selection grouping. On the other hand if I've just
selected the lines I want it is convenient to move directly to the next
hunk without having to somehow quit the current one.

There are some questions about how the remaining lines of the hunk
should be presented - should they be broken up if you end up with a big
block of context in the middle after the first edit for instance.
There's also a practical problem of coloring the hunk if the user has
set interactive.diffFilter as it appears reading and writing to a
process is tricky on Windows. Part of the commit message of 01143847db
("add--interactive: allow custom diff highlighting programs", 2016-2-27)
reads

      2. add--interactive will re-colorize a diff which has been
         hand-edited, but it won't have run through the filter.
         Fixing this is conceptually easy (just pipe the diff
         through the filter), but practically hard to do without
         using tempfiles (it would need to feed data to and read
         the result from the filter without deadlocking; this
         raises portability questions with respect to Windows).

> 
> 3) I don't see any way around this, but we need to carefully explain
> that selecting a list of things in one session is *not* the same thing
> as selecting them incrementally in multiple sessions. I.e. consider this
> diff:
> 
>     @@ -1,3 +1,3 @@
>     -a
>     -b
>     -c
>     +1
>     +2
>     +3
> 
> If I select 1,4 I get, as expected:
> 
>     @@ -1,3 +1,3 @@
>     -a
>     +1
>      b
>      c
> 
> And then in the next session:
> 
>       @@ -1,3 +1,3 @@
>        1
>     1 -b
>     2 -c
>     3 +2
>     4 +3
>     select lines? 1,3
> 
> Yields, as expected:
> 
>     @@ -1,3 +1,3 @@
>     -a
>     -b
>     +1
>     +2
>      c
> 
> But this is not the same as redoing the whole thing as:
> 
>     select lines? 1,4
>     select lines? 1
>     select lines? 3
> 
> Which instead yields:
> 
>     @@ -1,3 +1,3 @@
>     -a
>     -b
>     +1
>      c
>     +3
> 
> Now, rummaging through my wetware and that E-Mail from back in March I
> don't see how it could work differently, and you *also* want to be able
> to select one line at a time like that.
> 
> Just something that's not very intuative / hard to explain, and maybe
> there should be a different syntax (e.g. 1:4) for this "swap 1 for 4"
> operation, as opposed to selecting lines 1 and 4 as they appear in the
> diff.

I did wonder about forcing the user to explicitly pair lines but shied
away from it as I assumed that is what would be wanted most of the time
and it is awkward for the user to have to pair them up and it involved
more error checking on the input to make sure they don't say 1:4 2:3.

> 
> 4) With that abc 123 diff noted above, why am I in two sessions allowed
> to do:
> 
>     @@ -1,3 +1,3 @@
>     1 -a
>     2 -b
>     3 -c
>     4 +1
>     5 +2
>     6 +3
>     select lines? 1,4
>     select lines? 1,4
> 
> To end up with this staged:
> 
>     @@ -1,3 +1,3 @@
>     -a
>     -b
>     +1
>     +3
>      c
> 
> But not allowed to do the same thing in one operation via:
> 
>       @@ -1,3 +1,3 @@
>     1 -a
>     2 -b
>     3 -c
>     4 +1
>     5 +2
>     6 +3
>     select lines? 1,4,2,6
>     unable to pair up insertions and deletions
> 
> But I am allowed to do e.g.:
> 
>     select lines? 1,4,2,5
> 
> To end up with:
> 
>     @@ -1,3 +1,3 @@
>     -a
>     -b
>     +1
>     +2
>      c
> 
> I can do this in two steps.

Yes that needs explaining. To implement staging modified lines the code
needs to pair up each deleted line with its replacement. It does this by
grouping consecutive selected lines together, so it has a list of groups
of deleted lines and another list of inserted lines, it then pairs the
deletions and insertions by their index in the list. So in the last
example lines 1 and 2 are grouped together so there is a single group of
deletions and two groups of insertions. There is no way for it to tell
if lines 1 and 2 should be replaced by line 4 and line 5 should inserted
after 'c' or if 1 and 2 should be replaced by 4 and 5 with 'c' coming after.

It seems clear for your comment and Junio's that I need to improve the
documentation, I'm not sure if that will be enough though or do we need
to change the behavior? [I'm beginning to see why all the other programs
I tried while writing this (tig, gitg, gitk and mercurial's version of
add -i) don't make any attempt to stage modified lines correctly, though
I think git should have some way of doing it.]

Best Wishes

Phillip
