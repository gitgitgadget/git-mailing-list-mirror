Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A40B1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeCFKpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:45:30 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:11165 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:45:29 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id tA63em13XlYtptA63exFwN; Tue, 06 Mar 2018 10:45:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520333128;
        bh=KQ+j7a57FXCRdd8ABCn0M6P4GOQF/aa0DdhVjxjZ6DU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LOiNhaedPvytpb290IY4em8IbNg6Q3L5BmEgUAPqiJ1AZSwGgHAe1Gg84U2JTWeHB
         8umTMlWJfF9vJ4btjUnTV9mz4oFcmd/R5p0wRMVc17GzpgBlL/uijNxLELV1CfG40O
         FSyZ/Q9FrcbYnpBJ42rdzS3xrufJO6zKb47JxgAA=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=fzd_GW6KvRVoikn6DosA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
Date:   Tue, 6 Mar 2018 10:45:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO76zgkahQNdWSV5o8kcYrPHn2E8Us4kM6kFk4axvzbGFWfDwdzcumMW5D4Mwst2iALyrqMVdwh2A8oIKZIsjEW7vP40Kawv5B9jlRr2wIAZMOT6Qt7+
 97MCl75onyQ7W9bQEvEgcmqXtHJwTS1eu4Z8gwDzJ8jmu8wZ7vnwfUA6TWnsPalmm5u2FwIdl6a1eMAb89XjtNtOorZ9LUpdEvPa7MCT/EaQCSMDZCpKp4Cx
 96jq7zv1QGvK0oh1IM+fYfVT0VH87K/uiymOzcW3iZ1c75epPcuo9VsGi7T81CjGvYuhK+5ZSJsY4y/ypyD6Fk/GYnVrCMbghmLrI7ei8nmI5mhKaXLBAcDH
 TPFmMEKlKMpPlNMN/C27xGbErWXNxBT5wbfUsg50eMdE11E8ZuRl9qo+twzFNGfw4rZFaWGT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/18 00:29, Igor Djordjevic wrote:
> Hi Phillip,
> 
> On 02/03/2018 12:31, Phillip Wood wrote:
>>
>>> Thinking about it overnight, I now suspect that original proposal had a
>>> mistake in the final merge step. I think that what you did is a way to
>>> fix it, and I want to try to figure what exactly was wrong in the
>>> original proposal and to find simpler way of doing it right.
>>>
>>> The likely solution is to use original UM as a merge-base for final
>>> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
>>> though, as that's exactly UM from which both U1' and U2' have diverged
>>> due to rebasing and other history editing.
>>
>> Hi Sergey, I've been following this discussion from the sidelines,
>> though I haven't had time to study all the posts in this thread in
>> detail. I wonder if it would be helpful to think of rebasing a merge as
>> merging the changes in the parents due to the rebase back into the
>> original merge. So for a merge M with parents A B C that are rebased to
>> A' B' C' the rebased merge M' would be constructed by (ignoring shell
>> quoting issues)
>>
>> git checkout --detach M
>> git merge-recursive A -- M A'
>> tree=$(git write-tree)
>> git merge-recursive B -- $tree B'
>> tree=$(git write-tree)
>> git merge-recursive C -- $tree C'
>> tree=$(git write-tree)
>> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')
>>
>> This should pull in all the changes from the parents while preserving
>> any evil conflict resolution in the original merge. It superficially
>> reminds me of incremental merging [1] but it's so long since I looked at
>> that I'm not sure if there are any significant similarities.
>>
>> [1] https://github.com/mhagger/git-imerge
> 
> Interesting, from quick test[3], this seems to produce the same 
> result as that other test I previously provided[2], where temporary 
> commits U1' and U2' are finally merged with original M as a base :)
> 
> Just that this looks like even more straight-forward approach...?
> 
> The only thing I wonder of here is how would we check if the 
> "rebased" merge M' was "clean", or should we stop for user amendment? 
> With that other approach Sergey described, we have U1'==U2' to test with.

I think (though I haven't rigorously proved to myself) that in the
absence of conflicts this scheme has well defined semantics (the merges
can be commuted), so the result should be predicable from the users
point of view so maybe it could just offer an option to stop.

> 
> By the way, is there documentation for `git merge-recursive` 
> anywhere, besides the code itself...? :$

Not that I'm aware of unfortunately. It's pretty simple though

git merge-recursive [<options>] <merge-bases> -- <our-head> <their-head>

The options are listed on the 'git merge' man page but you specify them
as '--option' rather than '-Xoption'. I'm not sure what the exact
requirements are for the index, having it match <our-head> should always
be safe.

> 
> Thanks, Buga
> 
> [2] https://public-inbox.org/git/f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com/
> [3] Quick test script:
> -- >8 --
> #!/bin/sh
> 
> # rm -rf ./.git
> # rm -f ./test.txt
> 
> git init
> 
> touch ./test.txt
> git add -- test.txt
> 
> # prepare repository
> for i in {1..8}
> do
> 	echo X$i >>test.txt
> 	git commit -am "X$i"
> done
> 
> # prepare branch A
> git checkout -b A
> sed -i '2iA1' test.txt
> git commit -am "A1"
> sed -i '4iA2' test.txt
> git commit -am "A2"
> sed -i '6iA3' test.txt
> git commit -am "A3"
> 
> # prepare branch B
> git checkout -b B master
> sed -i '5iB1' test.txt
> git commit -am "B1"
> sed -i '7iB2' test.txt
> git commit -am "B2"
> sed -i '9iB3' test.txt
> git commit -am "B3"
> 
> git checkout -b topic A
> git merge -s ours --no-commit B # merge A and B with `-s ours`
> sed -i '8iM' test.txt           # amend merge commit ("evil merge")
> git commit -am "M"
> git tag M #original-merge
> 
> # master moves on...
> git checkout master
> git cherry-pick B^     # cherry-pick B2 into master
> sed -i "1iX9" test.txt # add X9
> git commit -am "X9"
> 
> # (0) ---X8--B2'--X9 (master)
> #        |\
> #        | A1---A2---A3 (A)
> #        |             \
> #        |              M (topic)
> #        |             /
> #        \-B1---B2---B3 (B)
> 
> # simple/naive demonstration of proposed merge rebasing logic
> # using iterative merge-recursive, preserving merge commit manual
> # amendments, testing `-s ours` merge with cherry-picking from
> # obsoleted part, but still respecting interactively rebased
> # added/modified/dropped/cherry-picked commits :)
> 
> git checkout -b A-prime A
> git reset --hard HEAD^             # drop A3 from A
> sed -i '/A1/c\A12' test.txt        # amend A1 to A12
> git commit -a --amend --no-edit
> git rebase master                  # rebase A onto master
> git cherry-pick B                  # cherry-pick B3 into A
> 
> git checkout -b B-prime B
> git rebase master                  # rebase B onto master
> sed -i '12iB4' test.txt            # add B4
> git commit -am "B4"
> 
> git checkout --detach M
> git merge-recursive A -- M A-prime
> tree="$(git write-tree)"
> git merge-recursive B -- $tree B-prime
> tree="$(git write-tree)"
> git tag M-prime "$(git log --pretty=%B -1 M | git commit-tree $tree -p A-prime -p B-prime)"
> 
> git update-ref refs/heads/topic "$(git rev-parse M-prime)"
> git checkout topic
> 
> # (1) ---X8--B2'--X9 (master)
> #                 |\
> #                 | A12--A2'---B3' (A)
> #                 |             \
> #                 |              M' (topic)
> #                 |             /
> #                 \-B1'--B3'---B4  (B)
> 
> # show resulting graph
> # echo
> # git log --all --decorate --oneline --graph
> 
> # in comparison to original merge commit M, rebased merge commit 
> # M' is expected to:
> #
> # - Add X9, from updated "master"
> # - Have A1 changed to A12, due to A12 commit amendment
> # - Keep A2, rebased as A2'
> # - Remove A3, due to dropped A3 commit
> # - Keep amendment from original (evil) merge commit M
> # - Miss B1' like M does B, due to original `-s ours` merge strategy
> # - Add B2, cherry-picked as B2' into "master"
> # - Add B3, cherry-picked as B3' into "A"
> # - Add B4, added to "B"
> #
> # echo
> # echo 'diff M M-prime:'
> # git diff M M-prime
> 

