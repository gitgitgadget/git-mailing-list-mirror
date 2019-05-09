Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E1E1F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfEIVpz (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:45:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44137 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:45:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so3325083edm.11
        for <git@vger.kernel.org>; Thu, 09 May 2019 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KuRkZ3gdX6EwnqPF+XhY+Mn5tqlESRCB2OoauCYC/Ak=;
        b=mSUQxQYNq+y5cL/JvdRrU05XE2BPYg3xJ/byiISm3XvcAaUB7abbFykgI9YHLZf5t1
         yvZrTv46PBHE5UbOswr2XQ8jIQ6kH9MlRT2/9grKyH+Wj1p2ZrFb18P9RsQDjfDEfPLC
         /JeB4aZBNulCDzDJgCBhKxDl/vBghFjrowFNxc5A5/EC9IBe9qW0Fow+rmjxYpSu9hcz
         ERKRoktpnjPBOBtv+nyz8HjRTg9h78LCzhzLxDv1D9WL6grwy1UDBZnuLQhbkWJI6nct
         wE7v8FXYzpiBGfbncjXlN9+7ZK47/dCkjaBYRTaT/JB1B35xmI8AzF+s3Klnbl7z3Qyh
         FQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KuRkZ3gdX6EwnqPF+XhY+Mn5tqlESRCB2OoauCYC/Ak=;
        b=A0eiOsPKAbeq4PUOeQ0DmItsV54ojV9sNxoakUCKc4No7gKZJgJ2njF5daT6aeZKKp
         0CqkhM/Z8LVOJq/WAJ30hhlP2dSCSRsWVQJkUpYt/yNFtWC52HmNB6otFkl6R0XXXxzD
         7l2t4i3Ymvo7Gbtmf/BZAcPvUzCKFgtEMp9BD3vWUe7PJlkUsMC2q7iXAXOiSWaSeo0y
         aC3/mjZ+HKYZfxxtOfM54k6pjHUnu7at+mBEzWwiF4sYHTidQ1ED+++Qu9Bi1gAowSQD
         M+DEe4kNZ/Pn/yPkieemCh5tKejtv2pg9DA/kP0HqyMm1o1drxs9IJvBfq/Ja9uIenV2
         QP5w==
X-Gm-Message-State: APjAAAWwi2hkMiTEQavoywT2k89xTArVihTcKjrVrmhTkKp9sBHlF6h3
        Ye6Jy/Vn+g8O5KcV3jRtx1w=
X-Google-Smtp-Source: APXvYqzuWxGIHdkoihI9/im6hagCHEWHcpV08VDoM9LugyDUqhR68l7iiid7CBw9T/0FOWQsh7HvGQ==
X-Received: by 2002:a17:906:b20b:: with SMTP id p11mr5455048ejz.233.1557438352295;
        Thu, 09 May 2019 14:45:52 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o47sm886508edc.37.2019.05.09.14.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 14:45:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
References: <pull.184.git.gitgitgadget@gmail.com> <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com> <20190508172029.GP14763@szeder.dev> <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com> <87pnoshfkq.fsf@evledraar.gmail.com> <f27db281-abad-5043-6d71-cbb083b1c877@gmail.com> <875zqjy6ga.fsf@evledraar.gmail.com> <caefe73d-828f-5668-91bf-1f5a82931ad1@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <caefe73d-828f-5668-91bf-1f5a82931ad1@gmail.com>
Date:   Thu, 09 May 2019 23:45:50 +0200
Message-ID: <874l63xpwx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 09 2019, Derrick Stolee wrote:

> On 5/9/2019 11:48 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Thu, May 09 2019, Derrick Stolee wrote:
>> [snip]
>>>
>>> I still don't think this is a problem, with the idea below.
>>>
>>>>>  4. It would be helpful to add a new optional chunk that contains the
>>>>>     trailing hash for the lower level of the commit-graph stack. This=
 chunk
>>>>>     would only be for the commit-graph-N files, and would provide a s=
imple
>>>>>     way to check that the stack is valid on read, in case we are still
>>>>>     worried about other processes reading/writing in the wrong order.
>>>>>
>>>>> If we have this chunk -- you have convinced me that we need it -- the=
n we
>>>>> could ignore the "new" commit-graph-2 because its base graph hash doe=
s not
>>>>> match. We can continue without dying because we can always parse the =
"missing"
>>>>> commits from the packs.
>>>
>>> So, let's set that idea aside. You have other concerns.
>>>
>>>> Instead of looping through files N at a time we'd have a discovery step
>>>> where we'd need to open() all the files, see which ones say "my parent
>>>> hash hash X", and then create a list of those hashes in order to read a
>>>> bunch of commit-graph-<HASH> files.
>>>>
>>>> Is that a bit painful? Sure, but way less painful than dealing with the
>>>> caveats I'd mentioned in [1] and SZEDER details here.
>>>
>>> I don't see how this step is less painful than the one I am describing.
>>> You'll need to be a bit more specific to convince me.
>>>
>>> I'll try to be specific with a few ideas that have been thrown around,
>>> so we can compare and contrast (and point out where I am misunderstandi=
ng
>>> what you are trying to say).
>>>
>>> Option 0 (this series): commit-graph-N
>>> --------------------------------------
>>>
>>> On read, we look for the 'info/commit-graph' file and acquire a read ha=
ndle.
>>> We set that commit_graph struct as our tip commit-graph. Then, for each
>>> increasing N (until we fail) we acquire a read handle on
>>> 'info/commit-graphs/commit-graph-N' and check that its base hash matches
>>> our current tip commit-graph. If the file doesn't exist, or the base
>>> hash doesn't match, then we stop and continue with our current tip grap=
h.
>>
>> This "base hash" is something I may have missed. I *thought* we'd
>> happy-go-lucky load e.g. commit-graph-1, commit-graph-2 in that order,
>> and if (e.g. due to fsync/dir entry issues noted earlier) if we got the
>> "wrong" commit-graph-2 we'd be oblivious to that. Is that not the case?>
>> I was trying (and failing) to make the test suite vomit by hacking up
>> the code to load "commit-graph-1" first, then "commit-graph", so maybe I
>> ran into that safeguard, whatever it is. I've just seen how we carry the
>> "num_commits_in_base" forward, not some expected checksum...
>
> It's not implemented in the patch series code, but included as an idea
> in the cover letter, and the discussion above convinced me it should be
> required. The discussion here assumes that is part of the design.

Got it. Hashing like that would definitely mitigate the "wrong file"
failure scenario, although as discussed leaving some others...

>> >> On write, use a 'mv' to swap our .lock file with whatever level we are
>>> merging, THEN can unlink() the higher layers in decreasing order. (This
>>> "mv-then-unlink" order is different than what is implemented by this
>>> series, but is enabled by the chunk containing the base graph hash.)
>>
>> So one of the things that make me paranoid about this (as noted
>> upthread/earlier) is that at least on POSIX filesystems just because you
>> observe that you create and fsync "foo" and "bar" in that order doesn't
>> mean that a concurrent reader of that directory will get the updates in
>> that order. I.e. file update !=3D dir entry update.
>
> How far apart can these concurrency issues happen in the file system?
> One benefit to Option 0 is that there is only one file _write_ that matte=
rs.
> The other options require at least two writes.

You need to write() and then fsync()/close() to be guaranteed that the
data was written to the file.

As an aside I see that the current commit-graph uses CSUM_FSYNC (but
without CSUM_CLOSE, probably doesn't matter), I thought it
didn't. Maybe we should remove that unless core.fsyncObjectFiles=3Dtrue
(or have another "looser" fsync config).

So writing is cheap, but it's asking the OS to sync to disk that
generally hurts. As noted in the discussions when core.fsyncObjectFiles
was introduced some FSs are really stupid about it, so it's better to
avoid these caveats if you can.

As noted in the fsync(2) manpage on Linux (ditto POSIX) an fsync to a
*file* doesn't guarantee that the directory entry is updated. So we'd
also need to opendir() the containing directory and fsync that FD as we
juggle these renames/replaces.

But stepping away from strict POSIX for a second, many users of git use
the object store over something like NFS. It's very handy to be able to
mount such a volume with e.g. lookupcache=3Dpositive
(https://linux.die.net/man/5/nfs).

I.e. if you request a commit-graph-<HASH> you don't need a round-trip to
the server to server to see if it's still there.

So it's not that we can't do it, but rather that there's some usage
patterns that are much friendlier to performance & caching than
others. Just throwing things at the FS and having it flush stuff in its
own time is ideal, and e.g. commercial FS appliances have a lot of
performance knobs you can use if you have access patterns like what we
have in objects/pack/.

I.e. "any file here you can cache forever, they never change (they
disappear, but no hurry!), but new ones might show up".

That sort of thing becomes more true with other dumber FS-alike things,
e.g. if we go for some "grab a graph from the server" implementation
such a thing is way simpler as a list of hashes that can be cached
forever (http proxies et al) than N files sensitive to their update
sequence.

>> It can be made to work, and core.fsyncObjectFiles is a partial solution,
>> but better to avoid it entirely. Also the failure with
>> core.fsyncObjectFiles is much more graceful, since in that case we don't
>> have a "deadbeef[...]" loose object *yet* but will (presumably) see the
>> *right* thing Real Soon Now since it's content-addressable, whereas with
>> this design we might see the *wrong* thing. So this would be the first
>> area of git (that I know of) where we'd be sensitive to a combination of
>> syncing dir entries and file content in order.
>>
>>> Option 1 (needs format v2): commit-graph -> graph-{hash}.graph
>>> --------------------------------------------------------------
>>>
>>> On read, we load the 'info/commit-graph' file and inspect the byte sayi=
ng
>>> how many base files we have. We load their hashes from the base file ch=
unk
>>> and read 'info/graph-{hash}.graph' for each. If _any_ fail, then we need
>>> to ignore anything "above" the failure in the chain (and specifically t=
his
>>> includes the 'commit-graph' file), or consider reloading the commit-gra=
ph
>>> file altogether and hope it works this time. [Note: if an older version
>>> of Git doesn't understand the incremental file format, it will fail to
>>> properly understand the graph positions and either fail with an
>>> "invalid parent position" error, or worse give garbage results.]
>>
>> Right, except as noted before I'd add (at least per my understanding so
>> far) "s/needs format v2//". I.e. we could stick this data in new v1
>> backwards-compatible chunks, which also addresses the "older version..."
>> caveat.
>>
>> I.e. we'd always guarantee that the "commit-graph" file was
>> understandable/valid for older versions (even though eventually their
>> view on it would be "oh, this has no data" (but really it's all in a new
>> chunk they don't grok).
>
> I see. Something that I gather from your paragraph above but cannot find
> written explicitly anywhere is "write a commit-graph with zero commits,
> and it contains extra information that we can use to find the rest of the
> commits." In essence, the entire purpose of the file would be to contain
> the information of the 'commit-graphs/info' file from Option 2. It would
> mean we don't need to "copy then move" because the tip commit-graph file
> has no content to persist (except for the first incremental write).
>
> That would prevent breaking old clients, but they would also not have any
> commit-graph data to use. Option 0 and Option 2 can leave a valid v1
> commit-graph file with the majority of the commit data. This is only a
> performance issue for a narrow case, so maybe that's worth ignoring.

Indeed. As noted in the thread about the v1->v2 format if we just append
new chunks we have leeway like that, i.e. it's completely OK if we
choose to from the POV of old clients write no data to them so they're
not helped by the optimization, that's a more graceful way than them
dying on a format change.

And yes, we could stick the proposed commit-graphs/info "index" in a
chunk there. I've got a preference for a \n-delimited list similar to
objects/info/packs, but that's mostly for aesthetic reasons.

> (See =C3=86var's idea about symlinks at the bottom of this message for mo=
re.)
>
>>> On write, if we are creating a new layer to our chain, we need to _copy_
>>> the existing commit-graph file to a graph-{hash}.graph file before rena=
ming
>>> the .lock file. If we are merging layers, then we either (a) clean up t=
he
>>> dangling chains after moving our commit-graph file, or (b) have somethi=
ng
>>> like 'gc' clean up the files later. I think using 'gc' for this is not
>>> a good idea, since I would expect these files to be written and merged
>>> much more frequently (say, after a 'fetch') than a 'gc' is run. Cleaning
>>> up the dangling chains leads to our concurrency issues. Further, this
>>> 'copy the base' no longer keeps our large base file at rest.
>>
>> So aside from the specifics of implementation both this and the
>> commit-graph-N way of doing it involves juggling a sequence of chunks
>> that "point upwards", which IMO has worse caveats than "point
>> downwards". I.e. we'd need to rewrite "base" files to point "upwards" to
>> new stuff, and there's no (sane) way in option 0 to split commit-graphs
>> across repos, and no way at all in this scenario (if I understand it
>> correctly...).
>
> I don't understand the value of rewriting base files to point upwards.
> The whole point is to not change the base files.

Yeah I don't think it makes sense, but maybe I misread the
description...

>>> Option 2: grovel commit-graphs directory for graph-{hash}.graph
>>> ---------------------------------------------------------------
>>>
>>> On read, we load the 'info/commit-graph' file and assume it is never
>>> an incremental file. Then, scan the 'info/commit-graphs' directory
>>> for 'graph-{hash}.graph' files and open them _all_ up to construct
>>> a "graph forest" (each graph has a single parent, given by a chunk
>>> specifying its base graph hash). If we don't have an instance of a
>>> graph with a given hash, then ignore any graphs pointing to that hash.
>>> We now have a decision to make: which leaf of this forest should we
>>> use as our tip commit-graph? That could be given by the
>>> commit-graphs/info file. But what happens when we have timing issues
>>> around scanning the directory and the commit-graphs/info file? Do
>>> we fall back to modified time?
>>
>> I think in a worst-case scenario we shrug and just pick whatever chain
>> looks most recent/largest or whatever, but in practice I think it's a
>> non-issue.
>>
>> Critical for that "it's a non-issue" is the suggestion I had on 17/17 of
>> not doing the incremental write in "fetch", but instead just rely on "gc
>> --auto" *and* to address your "I would expect these files to be written
>> and merged much more frequently" we'd just (and I'm keen to hack this
>> up) teach "gc --auto" such an incremental mode.
>
> I look forward to this incremental mode, and its "partial maintenance".
>
>> This means that within a single repo all updates to the commit-graph
>> will go through the gc.lock, whereas with your current 17/17 we'd
>> potentially have a "commit-graph write" racing a concurrent "gc", with
>> both aiming to update the commit-graph.
>
> Except for writes that happen in `git commit-graph write`, of course.
>
> VFS for Git never runs 'gc' and instead maintains the commit-graph direct=
ly.
>
> Should the commit-graph builtin take a gc lock on write?

If we make the file management dumb enough it shouldn't matter, we'd
always have a lock for updating the "meta" file, but if we didn't we'd
just have some harmless duplicate work.

I think a lock in "gc" is enough, it's our default, so it should be
sensible. People doing custom GC generally do/want their own management
of that, no need for us to hold their hand beyond the point where
e.g. concurrent "pack-refs" might corrupt refs if the ref update itself
isn't locked.

>>> On write, if we are not merging, then we just create a new
>>> graph-{hash}.graph file. If we are merging, but still have a base graph,
>>> then create a new graph-{hash}.graph file. Finally, if we are merging
>>> all layers, then we rename our .lock file to 'info/commit-graph'.
>>> To clean up, we need to grovel the directory to look for graph-{hash}.g=
raph
>>> files whose base chains no longer match the new, "best" chain and unlin=
k()
>>> them. This clean-up step can happen at any time.
>>>
>>> --[end description of options]--
>>>
>>> Did I accurately describe the options we are considering?
>>>
>>> Option 1 was the design I was planning, and I think it matches how the
>>> split-index feature works. Please correct me if I am missing something.
>>> It _requires_ updating the file format version. But it also has a flaw
>>> that the other options do not have: the copy of the base file. One
>>> thing I want to enable is for whatever machinery is handling these
>>> file writes to run a 'verify' immediately after, and have that be fast
>>> most of the time. With a model that changes only the "tip" file, we
>>> can verify only the new files and have confidence that the base file
>>> did not change. I think options 0 and 2 both improve in this direction.
>>>
>>>> With commit-graph-<HASH> all these unlink() race conditions go away,
>>>> partial reads due to concurrent graph writing becomes a non-issue (we'd
>>>> just leave the old files, "gc" deals with them later..), no need to
>>>> carefully fsync() files/dirs etc as we need to carefully juggle N and
>>>> N+1 files.
>>>
>>> Calling this a non-issue is an exaggeration, especially if you are
>>> claiming we need to be robust to multi-hour gaps between reading files.
>>
>> We always have a race, but they're very different races.
>>
>> With "N" files (option #0) we'd have races of the type where within the
>> same few milliseconds of a commit-graph being merged/updated a
>> e.g. concurrent "tag --contains" would either be much slower (couldn't
>> get one of the incremental graphs it expected), or produce the wrong
>> answer (this may be wrong on my part, see my "base hash" comment above).
>
> With the "base hash" feature (planned, not implemented) we won't be wrong.

*nod*

> With the "max number of commits in the incremental files" feature, we
> would limit the performance issues from missing an update. BUT, this also
> implies we are rewriting the base commit-graph more often. With a limit
> of 64,000 commits, that's still only once every few weeks in the Windows
> OS repo.
>
>> Whereas if I run something with "ionice -c 3" I could possibly hang for
>> however many hours/days/weeks we wait until another "gc" comes along and
>> unlinks those old files, but if I'm running it like that I'm not
>> expecting it to be fast, so it's OK if the files went away, and it won't
>> ever get the wrong file (since the filenames are hash-addressible).
>
> How do we recover from this situation? Have no commit-graph at all? Or
> do we try again?

I think just no commit-graph at all is fine. If it lazily took you N
hours from reading the "commit-graphs/info" to getting around to looking
at now-disappeared files it sucks to be you.

>>>> It also becomes easy to "chain" graphs across repos e.g. via
>>>> alternates. Say in the scenario github/gitlab have where they have a
>>>> "main" repo and other objects on another delta island.
>>>>
>>>> In that case the repo would have a local "tip" file with the last link
>>>> in its chain, some of which would then refer back to <HASHes> in other
>>>> "parent" alternates.
>>>>
>>>> As long as such a setup has a "gc" process that's not overly eager abo=
ut
>>>> pruning old stuff and considers that constellation of repos as a whole
>>>> that should just work. You can freely optimize and rewrite graphs acro=
ss
>>>> repos, just be careful about unlinking old stuff.
>>>>
>>>> I don't see how it would work with commit-graph-N without a *lot* of
>>>> painful orchestration (where e.g. you *must* guarantee that the parent
>>>> repo ends in N, all child repos start at N+1).
>>>
>>> You're right that Option 0 does not work in this model where some graph
>>> information is stored in an alternate _and_ more information is stored
>>> outside the alternate. My perspective is biased, because I consider the
>>> alternate to be "almost everything" and the local object store to be
>>> small. But in a fork network, this is not always the case. I appreciate
>>> your feedback for this environment, and I've always hoped that someone
>>> with server experience would come and say "this feature is great, but
>>> we need X, Y, and Z to make best use of it in our environment. Here's
>>> a patch that moves us in that direction!" At least you are doing the
>>> next-best thing: stopping me from making mistakes that would block
>>> adoption.
>>
>> I'm happy to write some patches, just want to talk about it first (and
>> if I'm lucky convince you to write them for me :) ).
>>
>> One example is the git-for-windows commit-graph is 5.6MB, the git.git
>> one is 3.1MB. Should GitHub just stick that all in the one "parent"
>> graph, maybe. But nice to have the flexibility of stacking them.
>>
>> There's also more disconnected cases, e.g. I have some "staging" boxes
>> where where I have a cronjob running around re-pointing clones of a big
>> monorepo to a shared "alternates" store where I guarantee objects are
>> only ever added, never removed.
>>
>> It would be nice to have a way to provide a commit-graph there that's
>> "stable" that clients could point to, and they'd just generate the
>> difference.
>>
>> I.e. now I have a shared .git/objects which contains gigabytes, a
>> crapload of stuff in /home where .git/objects is 10-50MB, and each one
>> has a commit-graph that's around the same 50-100MB size (since it needs
>> to contain the metadata for the full set).
>>
>>> So let's consider how Option 2 would work in this "multi-tip" case.
>>> Each object directory would have some number of graph files, and one
>>> 'commit-graphs/info' file pointing to some hash. When we read, we
>>> try to pick the info file that is "closest" to us.
>>>
>>> This does create some complications that I don't think you gave enough
>>> attention to. These may be solvable, but they are non-trivial:
>>>
>>> * When we 'gc' the "core" repo, we need to enumerate all of the
>>>   "leaf" repos to check their tip commit-graph files and make a
>>>   decision if we should keep their bases around or delete those tips.
>>>   Perhaps I'm over-stating the difficulty here, since we need to do
>>>   something similar to find still-reachable objects, anyway. But if
>>>   we are doing that reachability calculation, then why are we not
>>>   just putting all of the commit-graph data in the core repo? Note
>>>   that we don't get the same value as delta islands because this data
>>>   isn't being shared across the protocol. The issue with storing all
>>>   graph data in the core repo is that the core repo doesn't actually
>>>   have all of the commits, which makes 'verify' on the graph a bit
>>>   annoying.
>>
>> Yeah I think similar to "alternates" it would be annoying to have a case
>> where a given repo has metadata on objects it doesn't have, and there's
>> cases (see the "staging" case I mentioned above) where that "parent"
>> repo won't have access to those things.
>>
>>> * If we choose a local tip instead of the "core" tip, then that chain
>>>   of commit-graphs can be far behind the core repo. In the world where
>>>   a fork moves only at the speed of a single developer, but the core
>>>   project moves quickly, then computing a merge base with the core's
>>>   master branch becomes slow as our local chain doesn't contain most
>>>   of the commits.
>>
>> That's a good point and a case where pointing "upwards" or just having
>> commit-graphs in the "base" repo is better, i.e. the "fork" has almost
>> no objects.
>
> Is your idea of "upwards" different than mine? I think of pointing to
> a base file as pointing "down", and the opposite would be "up". In the
> case of a fork network or multiple repos using an alternate, pointing
> upwards would not even be well-defined.

We've got the same idea, but as noted above maybe I misunderstood the
"option 1" description.

>> But solvable by triggering "gc" on these child projects so their
>> commit-graph keeps being re-pointed to a later version.
>>
>> And we'd have the reverse problem with a git-for-windows wouldn't we?
>> I.e. the fork is "far ahead".
>
> This is the quintessential example for why we can't have a single chain
> of commit-graphs long-term. It deviates from most fork networks enough
> that we can't say "just take the base repo's commit-graph" but typical
> fork networks can't say "just take my local commit-graph chain". The
> two-dimensional graph position would be valuable to help both shapes.

Indeed. I just thought about e.g. a [branch|tag] --contains for the
current repo, but for things like "how ahead of gitster/pu is my GFW
topic?" one graph for the network is needed.

If we can help it it would be useful to not unduly box the user in and
offer them flexibility to choose. I.e. some (e.g. my staging server
use-case) might want base+local repo and never need 2x local repos
v.s. each other, whereas github/gitlab might need one giant graph etc.

>>> * We can't take all of the "core" chain _and_ the local chain, because
>>>   the concept of "graph position" no longer makes sense. The only way
>>>   I see out of this is to make the graph position two-dimensional:
>>>   commit -> (index of tip chain, position in that chain). Perhaps this
>>>   is a valuable thing to do in the future? Or perhaps, we shouldn't
>>>   have incremental chains spanning object directories and instead
>>>   introduce "parents-by-ref" where we mark some parents as included
>>>   by object id instead of by graph position. This would allow the
>>>   core repo to gc without caring about the external repos. It also
>>>   wouldn't care about how the graph files are stored (Option 0 would
>>>   work, as graph chains would not cross object store boundaries) and
>>>   more closely resembles the independence of the pack-files in each
>>>   object store. The "parents-by-ref" would require updating the
>>>   file format version.
>>
>> The parent repo can "gc" without caring/inspecting "child" repos with
>> the "point downwards" of option #2, as long as it promises to retain its
>> old commit-graph files for some retention period of X, and the "child"
>> repos promise to "gc" (and re-point to new graphs if necessary) at rate
>> that's faster than that.
>>
>> This makes it easy to e.g. say "we retain old commit-graph files for 2
>> weeks", and "we re-gc everything in cron weekly".
>
> Here, I think, is the most crucial point of why Option 2 may be worth the
> added complexity over Option 0. Option 0 _requires_ that the files be
> replaced immediately on a new write, while Option 2 provides a way to
> leave old files around and be cleaned up later.
>
> But how should we actually perform this cleanup? I would imagine a
> 'git commit-graph gc' subcommand that cleans up old files. A 'git gc'
> run would perform the same logic, but we need a way to do this outside
> of 'gc'. It needs to use the modified time as an indicator, since we
> could run 'git commit-graph write' twice an hour before our two-week
> cleanup job and need to keep our hour-old stale file. Perhaps the
> 'git commit-graph gc' subcommand could take a '--window' parameter that
> can be 0, while 'git gc' uses a config setting.
>
> The decision can then be: "is this file not in our graph chain and
> older than <window> from now?"
>
> But also, I expect the stale commit-graph files will pile up quickly.
> We rebuild the commit-graph file roughly every hour. I would write
> our maintenance to call these subcommands in order with no delay:
>
>     "write" -> "verify --shallow" -> "gc --window=3D0"
>
> (Here, "verify --shallow" would only verify the tip of the
> commit-graph chain.)

I think a sane default would be to just unlink() the old ones as soon as
we're done writing the new ones & writing the commit-graphs/info file
saying "here's your current ones".

I.e. as noted in what I said about fsync above it's not that we need to
keep the old ones around, but avoiding the tight dance with N & N+1
updates, and being friendlier to stuff like lookupcache=3Dpositive.

Users with more advanced use-cases (e.g. cross-repo graphs) could then
always increase such an expiry.

>> It would work best if we can also pull this trick on the "base"
>> commit-graph file, which I believe we could do in a backwards-compatible
>> way by making "commit-graph" a symlink to whatever "commit-graph-<HASH>"
>> is the current "base".
>
> Could we do this, anyway? Use 'commit-graphs/info' to point to the tip
> and let the symlink 'commit-graph' point to the base. Then, old clients
> would load a full commit-graph and new clients would get the full chain.

How's the Windows support for symlinks? We don't symlink anything in
.git/objects/ ourselves now (but see[1]).

On *nix just manually symlinking it works fine (you need to go out of
your way not to support it, which we didn't).

So something like this would be desirable:

    $ tree -a .git/objects/info/
    .git/objects/info/
    =E2=94=9C=E2=94=80=E2=94=80 commit-graph -> commit-graphs/commit-graph-=
2492e0ef38643d4cb6369f76443e6a814d616258
    =E2=94=9C=E2=94=80=E2=94=80 commit-graphs
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit-graph-2492e0ef=
38643d4cb6369f76443e6a814d616258
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit-graph-988881ad=
c9fc3655077dc2d4d757d480b5ea0e11
    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 info
    =E2=94=94=E2=94=80=E2=94=80 packs
    $ cat .git/objects/info/commit-graphs/info
    2492e0ef38643d4cb6369f76443e6a814d616258
    988881adc9fc3655077dc2d4d757d480b5ea0e11

I.e. create new ones as needed, and when done say what sequence they
should be read in in the "info" file, and symlink "commit-graph" to
whatever the latest "base" is as a courtesy to old clients (or not, or
eventually don't bother).

1. https://public-inbox.org/git/20190502144829.4394-1-matheus.bernardino@us=
p.br/
