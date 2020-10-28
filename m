Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F3C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE4820796
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbgJ1X26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:28:58 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:60124 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgJ1X1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:27:40 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kXjC2-0000SS-4D; Wed, 28 Oct 2020 11:00:38 +0000
Subject: Re: Proposal: "unadd" command / alias.
To:     Filipp Bakanov <filipp@bakanov.su>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <xmqqblgnbea5.fsf@gitster.c.googlers.com> <20201027215638.GI5691@mit.edu>
 <CAAdniQ4vx4z9KnfvG7thzxf1xBa=P_nnbY1G=RTFUBb4Zxqeaw@mail.gmail.com>
 <20201027225403.GJ5691@mit.edu>
 <CAAdniQ7o2greovkG-RP-FLwW2OH3YuiORwB+QKgqy=_0aJ4XkQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <126f0324-2d5b-c2a9-b1ca-aa92909b6fde@iee.email>
Date:   Wed, 28 Oct 2020 11:00:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAAdniQ7o2greovkG-RP-FLwW2OH3YuiORwB+QKgqy=_0aJ4XkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/2020 23:14, Filipp Bakanov wrote:
> It's the matter of UX. If many users have to make an alias for the
> same unclear command, at least it's a point to think about making this
> particular command more convenient. As far as I remember, some aliases
> were already added to git by default.
> What's bad with adding a popular (among many users) aliases, if they
> improve UX and make life easier?

One option maybe to curate a few of the more popular aliases within a
contrib/aliases file/directory.

Not sure how best to add comments into the alias file so folks can
remember what they are really meant to do, or where they copied them from.

Philip

>
> On Wed, 28 Oct 2020 at 01:54, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> On Wed, Oct 28, 2020 at 01:02:11AM +0300, Filipp Bakanov wrote:
>>>>> Indeed, I have a similar alias in my ~/.gitconfig
>>> Why not just add it to git by default for everybody? revert-file is
>>> also ok, anything except `checkout HEAD --` will be good.
>> Because everyone may have their own favorite aliases?  Just because
>> *I* have the following aliases doesn't mean that everyone else would
>> find them useful.
>>
>> [alias]
>>         new = !gitk --all --not ORIG_HEAD
>>         dw = diff --stat --summary
>>         di = diff --stat --summary --cached
>>         dc = describe --contains
>>         revert-file = checkout HEAD --
>>         l  = log --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>>         lr = log --reverse --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>>         rl  = log -g --pretty=format:'%Cred%h%Creset %gd %gs %Cgreen(%gr)%Creset %s' --abbrev-commit
>>         rl1  = log -g --date=relative --pretty=format:'%Cred%h%Creset %gs %Cgreen%gd%Creset %s' --abbrev-commit
>>         lg  = log --graph --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>>         lgt = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>>         rlt = log -g --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
>>         lgt-nc = log --graph --pretty=format:'%h -%d %s (%cr)' --abbrev-commit
>>         st = status -s
>>         recent = for-each-ref --count=15 --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
>>         gerrit-clone = !bash ggh gerrit-clone
>>         start = !bash ggh start
>>         upload = !bash ggh upload
>>         prune-branches = !bash ggh prune-branches
>>         fixes = log -1 --pretty=fixes
>>
>> I have a huge number of bash aliases, and that doesn't mean everyone
>> else should have those bash aliases.  For that matter, I have the
>> following in ~/bin/git-rp-ext4 so that I can type "git rp-ext4
>> tags/ext4_for_linus".  But that doesn't mean this script is right for
>> everyone....
>>
>> Cheers,
>>
>>                                         - Ted
>>
>> #!/bin/sh
>>
>> START=origin
>> URL=git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>> END=""
>>
>> print_help ()
>> {
>>     PROG=$(basename "$0")
>>     echo "Usage: $PROG [-n] [--start <START COMMIT>] [--url <URL] [<END COMMIT>]"
>>     exit 1
>> }
>>
>> while [ "$1" != "" ]; do
>>     case $1 in
>>         --start) shift
>>                  START="$1"
>>                  ;;
>>         --url) shift
>>                URL="$1"
>>                ;;
>>         -n) NO_ACTION="echo" ;;
>>         -*) print_help ;;
>>         *)
>>             if test -n "$END"
>>             then
>>                 print_help
>>             else
>>                 END="$1"
>>             fi
>>             ;;
>>     esac
>>     shift
>> done
>>
>> $NO_ACTION git request-pull "$START" "$URL" "$END"
>>

