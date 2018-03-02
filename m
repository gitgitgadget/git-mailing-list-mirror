Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230271F404
	for <e@80x24.org>; Fri,  2 Mar 2018 01:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163921AbeCBBQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 20:16:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40121 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163405AbeCBBQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 20:16:10 -0500
Received: by mail-wr0-f193.google.com with SMTP id o76so8480989wrb.7
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 17:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bACQRgOQNLzEd23CuvQ7AoFi9vy/MhCvRadlZjgM30w=;
        b=n7E2Z/6s+SmFul6Z6N6qV6I1nVRHXvCxEj906WJa7kr33SsaF36JDZ92CGoCOKrhmo
         B8GAza4lsTBr0V8wOV6kdLM1a9XXH9RFbp6Ar7ReELxJVGam4oVyreub88tJIrLyHqnA
         J7QE8Z2kAvXECEDCAQ70a3OZ6/8NzDlx0I/gZx6mcczHX52N0G/fG6i8vCbU8kcKhzby
         JpRMXM7ejk13QxWv20KkWr/9PtzQjowsWEJzIJkhWHqU84s0ng/KeFui939bF1JCcOTz
         +1l4ksoTl6XSe+lTpmbILn1lNIqEvhJXtMa0XD08UnST5CxPO3uTEPrpFw8ohVwDpcmb
         LARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bACQRgOQNLzEd23CuvQ7AoFi9vy/MhCvRadlZjgM30w=;
        b=ZL8ZBO3m98pUpzsnLVkyLIEKVcwztbUj/VtVa3NrSCCYpUu1Zvb2cds5jFGjxgDq0a
         TVz9fcIRTnn+QITeCYJMdY37ENxe98gwhbr9z1nwJLvUHXT6Q+2F0kKJwV/2sUZ+n/oy
         e5c7lapw/BvF+/NtFRaaa3wplIAGwRyh7zmLXB2Ya3t5LurqlXgFmqi8Zc4e3LdKpQWy
         fFfXAYP3s6ZM2tJayq1cluCmmRY3+eshDvMRmLJtrLnqx01iR/+/UhN1UHp+lbTswDLy
         t2Kqq9zQ6YQHh08Gz0R3OGYEIvbmXHyx0ZovEYII+4QHH72/eulN6MdP694OiIq3964X
         8TBw==
X-Gm-Message-State: APf1xPDeJyblJVoqyOygAuOzCZxYrZ0l51IC2PAD3RKmT/KCAJQjF3Re
        CnAhTyZdU/y72Yw8GfwR6nY=
X-Google-Smtp-Source: AG47ELtoDhx04Y3BiI/Em47jXA2j7+/S56yUKAW3yckWTuxSN0SwvV145ebJ9KBoPaU1ZlF/upCxeA==
X-Received: by 10.223.184.134 with SMTP id i6mr3652290wrf.179.1519953369219;
        Thu, 01 Mar 2018 17:16:09 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id r126sm70076wmd.29.2018.03.01.17.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 17:16:08 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
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
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
Date:   Fri, 2 Mar 2018 02:16:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87a7vss6ax.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 01/03/2018 06:39, Sergey Organov wrote:
> 
> > > (3) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> > >
> > 
> > Meh, I hope I`m rushing it now, but for example, if we had decided to 
> > drop commit A2 during an interactive rebase (so losing A2' from 
> > diagram above), wouldn`t U2' still introduce those changes back, once 
> > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
> > 
> > [...]
> 
> Yeah, I now see it myself. I'm sorry for being lazy and not inspecting
> this more carefully in the first place.

No problem, that`s why we`re discussing it, and I`m glad we`re 
aligned now, so we can move forward :)

> > So while your original proposal currently seems like it could be 
> > working nicely for non-interactive rebase (and might be some simpler 
> > interactive ones), now hitting/acknowledging its first real use 
> > limit, my additional quick attempt[1] just tries to aid pretty 
> > interesting case of complicated interactive rebase, too, where we 
> > might be able to do better as well, still using you original proposal 
> > as a base idea :)
> 
> Yes, thank you for pushing me back to reality! :-) The work and thoughts
> you are putting into solving the puzzle are greatly appreciated!

You`re welcome, and I am enjoying it :)

> Thinking about it overnight, I now suspect that original proposal had a
> mistake in the final merge step. I think that what you did is a way to
> fix it, and I want to try to figure what exactly was wrong in the
> original proposal and to find simpler way of doing it right.
> 
> The likely solution is to use original UM as a merge-base for final
> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
> though, as that's exactly UM from which both U1' and U2' have diverged
> due to rebasing and other history editing.

Yes, this might be it...! ;)

To prove myself it works, I`ve assembled a pretty crazy `-s ours`  
merge interactive rebase scenario, and it seems this passes the test, 
ticking all the check boxes (I could think of) :P

Let`s see our starting situation:

 (0) ---X8--B2'--X9 (master)
        |\
        | A1---A2---A3 (A)
        |             \
        |              M (topic)
        |             /
        \-B1---B2---B3 (B)


Here, merge commit M is done with `-s ours` (obsoleting branch "B"), 
plus amended to make it an "evil merge", where a commit B2 from 
obsoleted branch "B" is cherry picked to "master".

Now, we want to rebase "topic" (M) onto updated "master" (X9), but to 
make things more interesting, we`ll do it interactively, with some 
amendments, drops, additions and even more cherry-picks!

This is what the final result looks like:

 (1) ---X8--B2'--X9 (master)
                 |\
                 | A12--A2'---B3' (A)
                 |             \
                 |              M' (topic)
                 |             /
                 \-B1'--B3'---B4  (B)


During interactive rebase, on branch "A", we amended A1 into A12, 
dropped A3 and cherry-picked B3. On branch "B", B4 is added, B2' being 
omitted automatically as already present in "master".

So... In comparison to original merge commit M, rebased merge commit 
M' is expected to:

 - Add X9, from updated "master"
 - Have A1 changed to A12, due to A12 commit amendment
 - Keep A2, rebased as A2'
 - Remove A3, due to dropped A3 commit
 - Keep amendment from original (evil) merge commit M
 - Miss B1' like M does B, due to original `-s ours` merge strategy
 - Add B2, cherry-picked as B2' into "master"
 - Add B3, cherry-picked as B3' into "A"
 - Add B4, added to "B"
 - Most important, provide safety mechanism to "fail loud", being 
   aware of non-trivial things going on, allowing to stop for user 
   inspection/decision


There, I hope I didn`t miss any expectation. And, it _seems_ to work 
exactly as expected :D

Not to leave this to imagination only, and hopefully helping others 
to get to speed and possibly discuss this, pointing to still possible 
flaws, I`m adding a demo script[1], showing how this exact example 
works.

Note that script _is_ coined to avoid rebase conflicts, as they`re not 
currently important for the point to be made here.

In real life, except for usual possibility for conflicts during 
commit rebasing, we might experience _three_ possible conflict 
situations once "rebased" merge itself is to be created - two when 
rebasing each of temporary merge helper commits, and one on the 
"rebased" merge itself. This is something where we might think about 
user experience, not introducing (too much) confusion...

Regards, Buga

[1] Demonstration script:
-- >8 --
#!/bin/sh

# rm -rf ./.git
# rm -f ./test.txt

git init

touch ./test.txt
git add -- test.txt

# prepare repository
for i in {1..8}
do
	echo X$i >>test.txt
	git commit -am "X$i"
done

# prepare branch A
git checkout -b A
sed -i '2iA1' test.txt
git commit -am "A1"
sed -i '4iA2' test.txt
git commit -am "A2"
sed -i '6iA3' test.txt
git commit -am "A3"

# prepare branch B
git checkout -b B master
sed -i '5iB1' test.txt
git commit -am "B1"
sed -i '7iB2' test.txt
git commit -am "B2"
sed -i '9iB3' test.txt
git commit -am "B3"

git checkout -b topic A
git merge -s ours --no-commit B # merge A and B with `-s ours`
sed -i '8iM' test.txt           # amend merge commit ("evil merge")
git commit -am "M"
git tag original-merge

# master moves on...
git checkout master
git cherry-pick B^     # cherry-pick B2 into master
sed -i "1iX9" test.txt # add X9
git commit -am "X9"

# (0) ---X8--B2'--X9 (master)
#        |\
#        | A1---A2---A3 (A)
#        |             \
#        |              M (topic)
#        |             /
#        \-B1---B2---B3 (B)

# simple/naive demonstration of proposed merge rebasing logic
# using described new approach, preserving merge commit manual
# amendments, testing `-s ours` merge with cherry-picking from
# obsoleted part, but still respecting interactively rebased
# added/modified/dropped/cherry-picked commits :)

git checkout A
git cherry-pick -m1 original-merge # prepare temporary helper commit U1
git tag U1
git reset --hard HEAD^^            # drop U1 and A3 from A
sed -i '/A1/c\A12' test.txt        # amend A1 to A12
git commit -a --amend --no-edit
git rebase master                  # rebase A onto master
git cherry-pick B                  # cherry-pick B3 into A
git cherry-pick U1                 # "rebase" temporary helper commit U1
git tag U1-prime

git checkout B
git cherry-pick -m2 original-merge # prepare temporary helper commit U2
git tag U2
git reset --hard HEAD^             # drop U2 from B
git rebase master                  # rebase B onto master
sed -i '12iB4' test.txt            # add B4
git commit -am "B4"
git cherry-pick U2                 # "rebase" temporary helper commit U2
git tag U2-prime

git branch -f topic A
git checkout topic
# merge rebased temporary commits U1' and U2',
# using original merge commit as a merge base,
# producing "rebased" merge commit M'
git read-tree -m --aggressive original-merge A B
git merge-index -o git-merge-one-file -a

# recognize complex stuff going on during rebasing merge commit,
# allowing user to inspect result, edit, and continue or abort
git diff --quiet U1-prime U2-prime
if test $? -ne 0
then
	# PLACEHOLDER
	# chance to inspect result, like:
	git diff original-merge
	# edit if needed, continue or abort
fi

# drop rebased temporary commits U1' and U2'
git branch -f A A^
git branch -f B B^

# record branches A and B as parents of "rebased" merge commit M',
# updating topic branch
git update-ref refs/heads/topic "$(git show -s --format=%B original-merge | git commit-tree "$(git write-tree)" -p "$(git rev-parse A)" -p "$(git rev-parse B)")"
git tag angel-merge

# (1) ---X8--B2'--X9 (master)
#                 |\
#                 | A12--A2'---B3' (A)
#                 |             \
#                 |              M' (topic)
#                 |             /
#                 \-B1'--B3'---B4  (B)

# show resulting graph
# echo
# git log --all --decorate --oneline --graph

# in comparison to original merge commit M, rebased merge commit 
# M' is expected to:
#
# - Add X9, from updated "master"
# - Have A1 changed to A12, due to A12 commit amendment
# - Keep A2, rebased as A2'
# - Remove A3, due to dropped A3 commit
# - Keep amendment from original (evil) merge commit M
# - Miss B1' like M does B, due to original `-s ours` merge strategy
# - Add B2, cherry-picked as B2' into "master"
# - Add B3, cherry-picked as B3' into "A"
# - Add B4, added to "B"
#
# echo
# echo 'diff original-merge angel-merge:'
# git diff original-merge angel-merge
