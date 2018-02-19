Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE321F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeBSXo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:44:57 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43876 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeBSXo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 18:44:56 -0500
Received: by mail-wr0-f193.google.com with SMTP id u49so6658696wrc.10
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 15:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTxo/n23a2Oacr/zUgxYm2WTFbr+fp/MI/EmrujuzrE=;
        b=oXjHc1cp1c1vE9D24aKHy9MxX8uznfP+/9Py2E2MeBA6pVKNoI94myUfrpX9j0P+th
         4KuW2OfqmY7SM0OCfV3I6Vx15eAFlWo/JUW5CH2saCaq1yIWzsBsSwQruJrs3zVOs9gv
         ybxlZ3Twa3hXjJ8YH7Z1lPmAnSTQWG/bhuj7yr4XNyRHOYrJrv4l/ovqJxcYaCUyTIe5
         dAUsMGH2wJvf9ywEOTB8VAcOsRZEuNYKhp5OsZL5daiReeZevYYM9D8rOQMwLrCy3vZa
         OVd0WOnp3RFoO2UCJ7I1yix5UEcFh6xiVy/KG95WFQdYnqRaMDTs8eaElywWqHdToCJO
         1RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTxo/n23a2Oacr/zUgxYm2WTFbr+fp/MI/EmrujuzrE=;
        b=IHS5PguaiK+n/hPDWG3zzj+nbZSCwQjpD+J/4IniPy5RdpkfuapyJM1xEz+ZNBvQSI
         vlB0c3/39RzHsAKeT6eJU9tEcsloSugT3OBtJ0zjNHEFbOwJLj1C9IlgjXjLmpkAv9c8
         m+lhUj1nJqDKdbtIYGxFTjijvfOW5yW98g9g08uwr53fTL1ukhFO0G24QumH0hE2reF8
         tpRndlpFkUY+8Kv1pRK4jHqKj8Nu1/FB9P19s9o2+uu27v0ifV4Y1XNUhtGVMObLJvex
         Oq8JxEHZN6+URvAEfEt4c6I12n3UfClJfnfVzPfiCypOINQLYKs2/dLkWCAb+olIMdu3
         7ryw==
X-Gm-Message-State: APf1xPCUteIFNK3b+r73m9gpQM2Z9MvsrE2y3GdJ93+lNR7kED5Sv5JM
        XMFm/lWOsFNGV9MXchgNLbQ=
X-Google-Smtp-Source: AH8x226LRvnELAwOs98ivUj4mw0ew3Pc6KUB7rnYQzsp80epWOf2Tq6TMD2CXw+ppBLbd+K4KcLwEA==
X-Received: by 10.223.190.141 with SMTP id i13mr2789936wrh.235.1519083894688;
        Mon, 19 Feb 2018 15:44:54 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id c56sm44639141wrc.82.2018.02.19.15.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Feb 2018 15:44:53 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <87y3jtqdyg.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
Date:   Tue, 20 Feb 2018 00:44:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87y3jtqdyg.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 16/02/2018 14:08, Sergey Organov wrote:
> 
> By accepting the challenges raised in recent discussion of advanced
> support for history rebasing and editing in Git, I hopefully figured out
> a clean and elegant method of rebasing merges that I think is "The Right
> Way (TM)" to perform this so far troublesome operation. ["(TM)" here has
> second meaning: a "Trivial Merge (TM)", see below.]
> 
> Let me begin by outlining the method in git terms, and special thanks
> here must go to "Johannes Sixt" <j6t@kdbg.org> for his original bright
> idea to use "cherry-pick -m1" to rebase merge commits.
> 
> End of preface -- here we go.
> 
> Given 2 original branches, b1 and b2, and a merge commit M that joins
> them, suppose we've already rebased b1 to b1', and b2 to b2'. Suppose
> also that B1' and B2' happen to be the tip commits on b1' and b2',
> respectively.
> 
> To produce merge commit M' that joins b1' and b2', the following
> operations will suffice:
> 
> 1. Checkout b2' and cherry-pick -m2 M, to produce U2' (and new b2').
> 2. Checkout b1' and cherry-pick -m1 M, to produce U1' (and new b1').
> 3. Merge --no-ff new b2' to current new b1', to produce UM'.
> 4. Get rid of U1' and U2' by re-writing parent references of UM' from
>    U1' and U2' to  B1' and B2', respectively, to produce M'.
> 5. Mission complete.
> 
> Let's now see why and how the method actually works.
> 
> Firs off, let me introduce you to my new friend, the Trivial Merge, or
> (TM) for short. By definition, (TM) is a merge that introduces
> absolutely no differences to the sides of the merge. (I also like to
> sometimes call him "Angel Merge", both as the most beautiful of all
> merges, and as direct antithesis to "evil merge".)
> 
> One very nice thing about (TM) is that to safely rebase it, it suffices
> to merge its (rebased) parents. It is safe in this case, as (TM) itself
> doesn't posses any content changes, and thus none could be missed by
> replacing it with another merge commit.
> 
> I bet most of us have never seen (TM) in practice though, so let's see
> how (TM) can help us handle general case of some random merge. What I'm
> going to do is to create a virtual (TM) and see how it goes from there.
> 
> Let's start with this history:
> 
>   M
>  / \
> B1  B2
> 
> And let's transform it to the following one, contextually equivalent to
> the original, by introducing 2 simple utility commits U1 and U2, and a
> new utility merge commit UM:
> 
>   UM
>  /  \
> U1   U2
> |    |
> B1   B2
> 
> Here content of any of the created UM, U1, and U2 is the same, and is
> exact copy of original content of M. I.e., provided [A] denotes
> "content of commit A", we have:
> 
> [UM] = [U1] = [U2] = [M]
> 
> Stress again how these changes to the history preserve the exact content
> of the original merge ([UM] = [M]), and how U1 an U2 represent content
> changes due to merge on either side[*], and how neither preceding nor
> subsequent commits content would be affected by the change of
> representation.
> 
> Now observe that as [U1] = [UM], and [U2] = [UM], the UM happens to be
> exactly our new friend -- the "Trivial Merge (TM)" his true self,
> introducing zero changes to content.
> 
> Next we rebase our new representation of the history and we get:
> 
>   UM'
>  /  \
> U1'  U2'
> |    |
> B1'  B2'
> 
> Here UM' is bare merge of U1' and U2', in exact accordance with the
> method of rebasing a (TM) we've already discussed above, and U1' and U2'
> are rebased versions of U1 and U2, obtained by usual rebasing methods
> for non-merge commits.
> 
> (Note, however, that at this point UM' is not necessarily a (TM)
> anymore, so in real implementation it may make sense to check if UM' is
> not a (TM) and stop for possible user amendment.)
> 
> Finally, to get to our required merge commit M', we get the content of
> UM' and record two actual parents of the merge:
> 
>   M'
>  / \
> B1' B2'
> 
> Where [M'] = [UM'].
> 
> That's it. Mission complete.
> 
> I expect the method to have the following nice features:
> 
> - it carefully preserves user changes by rebasing the merge commit
> itself, in a way that is semantically similar to rebasing simple
> (non-merge) commits, yet it allows changes made to branches during
> history editing to propagate over corresponding merge commit that joins
> the branches, even automatically when the changes don't conflict, as
> expected.
> 
> - it has provision for detection of even slightest chances of ending up
> with surprising merge (just check if UM' is still (TM)), so that
> implementation could stop for user inspection and amendment when
> appropriate, yet it is capable of handling trivial cases smoothly and
> automatically.
> 
> - it never falls back to simple invocation of merge operation on rebased
> original branches themselves, thus avoiding the problem of lack of
> knowledge of how the merge at hand has been performed in the first
> place. It doesn't prevent implementation from letting user to manually
> perform whatever merge she wishes when suspect result is automatically
> detected though.
> 
> - it extends trivially to octopus merges.
> 
> - it appears shiny to the point that it will likely be able to handle
> even darkest evil merges nicely, no special treatment required.
> 
> Footnote:
> 
> [*] We may as well consider the (UM,U1,U2) trio to be semantically split
> representation of git merge commit, where U1 and U2 represent content
> changes to the sides, and UM represents pure history joint. Or, the
> other way around, we may consider git merge commit to be optimized
> representation of this trio. I think this split representation could
> help to simplify reasoning about git merges in general.

I`m far from a Git expert, but merely a bit advanced user, so please 
take my opinion with a grain of salt.

That said, I`m really interested in this topic, which seems to (try 
to) address the only "bad feeling" I had with rebasing merges - being 
afraid of silently losing amendments by actually trying to "replay" 
the merge (where additional and possibly important context is 
missing), instead of really "rebasing" it (somehow).

Even though this behavior is known and documented, it still left some 
to be desired.

Might be I`m missing something, but so far I like how described 
approach just "feels right" (to me, for now), being really simple, 
yet robust :)

As my humble contribution to the cause and discussion itself, I`m 
providing possibly naive, yet simple demonstration script[1], and 
clearly showing where current `git rebase --preserve-merges` is 
lacking (in my opinion, even though being expected and documented), 
and how your proposal seems to improve the situation here.

Thanks for your thoughts, and hoping to see this going somewhere :)

Regards, Buga

[1] Demonstration script:
--- 8< ---
#!/bin/sh

# rm -rf ./.git
# rm -f ./test.txt

git init

touch ./test.txt
git add -- test.txt

for i in {1..20}
do
	echo A$i >>test.txt
	git commit -am "A$i"
done

git checkout -b b1
sed -i '6iB1' test.txt
git commit -am "B1"

git checkout -b b2 HEAD^
sed -i '16iB2' test.txt
git commit -am "B2"

git checkout -b merge b1
git merge --no-commit b2
sed -i '12iX' test.txt # amend merge commit
git commit -am "M"
git tag original-merge

git checkout master
for i in {1..5}
do
	j=`expr "$i" + 20`
	sed -i "${i}iA${j}" test.txt
	git commit -am "A$j"
done

# (1) current merge rebasing logic,
# not preserving merge commit manual amendment, as documented
git rebase --preserve-merges master merge
git tag preserve-merges

# (2) simple/naive demonstration of proposed merge rebasing logic
# using described "Trivial Merge" (TM, or "Angel Merge"),
# preserving merge commit manual amendment :)
git checkout b1
git rebase master
git cherry-pick -m1 original-merge

git checkout b2
git rebase master
git cherry-pick -m2 original-merge

git branch -f merge b1
git checkout merge
git merge b2 --no-commit
git commit -a --reuse-message original-merge
git tag angel-merge

git reset --hard b1^
git read-tree --reset angel-merge
git update-ref refs/heads/merge "$(git show -s --format=%B original-merge | git commit-tree "$(git write-tree)" -p "$(git rev-parse b1^)" -p "$(git rev-parse b2^)")"
git tag -f angel-merge
git branch -f b1 b1^
git branch -f b2 b2^

# show resulting graph
echo
git log --all --decorate --oneline --graph

# comparison between original merge and rebased merge (1),
# showing merge commit amendment "X" being silently lost during rebase
echo
echo 'diff original-merge..preserve-merges:'
git diff original-merge..preserve-merges

# comparison between original merge and rebased merge (2),
# showing merge commit amendment "X" being preserved during rebase
# (not shown in diff)
echo
echo 'diff original-merge..angel-merge:'
git diff original-merge..angel-merge

# direct comparison between two merge rebasing approaches,
# merge commit amendment difference showing up
echo
echo 'diff preserve-merges angel-merge:'
git diff preserve-merges angel-merge
