Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF131F45F
	for <e@80x24.org>; Thu,  9 May 2019 15:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEIPsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 11:48:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46193 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfEIPsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 11:48:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so2434981edb.13
        for <git@vger.kernel.org>; Thu, 09 May 2019 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FDVlZYPD/digtRZKZeQ61QuJkdiYnVsBWqNjF9bhUiU=;
        b=QfAysN0CkI75mEBVjESxoytK6sazY14l2i2j7WMsP/ussWBkM9sXYZvJBhQ6On8LWt
         GbW8V4Ho81NJy9e+4LYgHxF0guOuJppp5OAwvLc4A8wr9vbjU8krgALVw8MJYx9m4Gi+
         IRPZQ7u6Wps+D0XX+a2qZR+XQW5L/N/x+ySqim1xUGBy4cSBhRMP3YaEIVIWccqpQdP3
         VzdkwJeaqttzec9H8abYYOyhU4B2mQ83qjbWzZII6RCBLQ7p4ZnIfDBiC+ruOh816uXu
         4DMzF4Ly92TiO4OciiHZXSJ0JCohvdVCrPWUrMKbFYjHKrVd6HPynk0hI+sQxk1QfE0s
         YgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FDVlZYPD/digtRZKZeQ61QuJkdiYnVsBWqNjF9bhUiU=;
        b=Y17b0LzYm2uLfFp3r7TGz2H+I1/ug7qgA2tCbsRN3MXnYIR5W5v9VRD+TrFSl1F6V/
         NxuhPLKULKaPAxyH0JlpNaulRIzwmBEYWiIt7KHYt7ehAmDZJHI415z2eSbVLUEaJscB
         wM8h/4WK4NDKVaDjBb3Xgb44SC1f6wwlCYsaKNGD9EXsM7ajaEGrRIgtZDAcAnhkd40x
         OT0F3JTLgnbDZAD+CCfVTnLk/1I3NGugiTThT0kDP5g1yLO71PG0et0b5eOlC9TaBc7m
         141OmaTV19CbbRUbm5g4Rx3Cj1T7WD5fHGCXC0TT+PgErGWu1WcUHvciEcMI+2KKQSDs
         SlTw==
X-Gm-Message-State: APjAAAVk/tmkUuF0xe36wVq31JTAikJtbNrDvvIh2U1+iZRqBrNXWVkE
        kwKDTnxYfzcUJm8FG+h9czk=
X-Google-Smtp-Source: APXvYqwu5rcXccnSO9x1Dc2QyEDM2je75pp5W4na/bezWCfqggh5PiuWGqT/fz1TXLKxyuSgxSGrhA==
X-Received: by 2002:a50:99ca:: with SMTP id n10mr4895483edb.279.1557416918696;
        Thu, 09 May 2019 08:48:38 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id h17sm376782ejc.34.2019.05.09.08.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 08:48:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
References: <pull.184.git.gitgitgadget@gmail.com> <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com> <20190508172029.GP14763@szeder.dev> <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com> <87pnoshfkq.fsf@evledraar.gmail.com> <f27db281-abad-5043-6d71-cbb083b1c877@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <f27db281-abad-5043-6d71-cbb083b1c877@gmail.com>
Date:   Thu, 09 May 2019 17:48:37 +0200
Message-ID: <875zqjy6ga.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 09 2019, Derrick Stolee wrote:

Not a very detailed reply since I've gotta run soon, but figured I'd
send something (also given our timezone difference).

> On 5/8/2019 4:11 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Wed, May 08 2019, Derrick Stolee wrote:
>>
>>> I'll ignore the improbability of this turn of events (two writes happen=
ing
>>> during the span of trying to read two files) and focus on the fact that
>>> we can prevent issues here using the 4th TODO item in my cover letter:
>>
>> FWIW the sort of scenario SZEDER is describing is something I deal with
>> in production a lot. It doesn't require an unfair scheduler, just that
>> you have differently nice(1)'d processes accessing the same repo.
>>
>> So if you have batch "cron" processes their IO scheduling follows their
>> nice(1) scheduling. It's not atypical to e.g. have some background
>> thingy sit for seconds or even minutes on an I/O syscall while the
>> kernel decides everyone else has right of way, since you nice'd that not
>> caring if it finishes in 10 seconds or 10 hours.
>
> Thanks. I learned something today.
>
> I still don't think this is a problem, with the idea below.
>
>>>  4. It would be helpful to add a new optional chunk that contains the
>>>     trailing hash for the lower level of the commit-graph stack. This c=
hunk
>>>     would only be for the commit-graph-N files, and would provide a sim=
ple
>>>     way to check that the stack is valid on read, in case we are still
>>>     worried about other processes reading/writing in the wrong order.
>>>
>>> If we have this chunk -- you have convinced me that we need it -- then =
we
>>> could ignore the "new" commit-graph-2 because its base graph hash does =
not
>>> match. We can continue without dying because we can always parse the "m=
issing"
>>> commits from the packs.
>
> So, let's set that idea aside. You have other concerns.
>
>> Instead of looping through files N at a time we'd have a discovery step
>> where we'd need to open() all the files, see which ones say "my parent
>> hash hash X", and then create a list of those hashes in order to read a
>> bunch of commit-graph-<HASH> files.
>>
>> Is that a bit painful? Sure, but way less painful than dealing with the
>> caveats I'd mentioned in [1] and SZEDER details here.
>
> I don't see how this step is less painful than the one I am describing.
> You'll need to be a bit more specific to convince me.
>
> I'll try to be specific with a few ideas that have been thrown around,
> so we can compare and contrast (and point out where I am misunderstanding
> what you are trying to say).
>
> Option 0 (this series): commit-graph-N
> --------------------------------------
>
> On read, we look for the 'info/commit-graph' file and acquire a read hand=
le.
> We set that commit_graph struct as our tip commit-graph. Then, for each
> increasing N (until we fail) we acquire a read handle on
> 'info/commit-graphs/commit-graph-N' and check that its base hash matches
> our current tip commit-graph. If the file doesn't exist, or the base
> hash doesn't match, then we stop and continue with our current tip graph.

This "base hash" is something I may have missed. I *thought* we'd
happy-go-lucky load e.g. commit-graph-1, commit-graph-2 in that order,
and if (e.g. due to fsync/dir entry issues noted earlier) if we got the
"wrong" commit-graph-2 we'd be oblivious to that. Is that not the case?

I was trying (and failing) to make the test suite vomit by hacking up
the code to load "commit-graph-1" first, then "commit-graph", so maybe I
ran into that safeguard, whatever it is. I've just seen how we carry the
"num_commits_in_base" forward, not some expected checksum...

> On write, use a 'mv' to swap our .lock file with whatever level we are
> merging, THEN can unlink() the higher layers in decreasing order. (This
> "mv-then-unlink" order is different than what is implemented by this
> series, but is enabled by the chunk containing the base graph hash.)

So one of the things that make me paranoid about this (as noted
upthread/earlier) is that at least on POSIX filesystems just because you
observe that you create and fsync "foo" and "bar" in that order doesn't
mean that a concurrent reader of that directory will get the updates in
that order. I.e. file update !=3D dir entry update.

It can be made to work, and core.fsyncObjectFiles is a partial solution,
but better to avoid it entirely. Also the failure with
core.fsyncObjectFiles is much more graceful, since in that case we don't
have a "deadbeef[...]" loose object *yet* but will (presumably) see the
*right* thing Real Soon Now since it's content-addressable, whereas with
this design we might see the *wrong* thing. So this would be the first
area of git (that I know of) where we'd be sensitive to a combination of
syncing dir entries and file content in order.

> Option 1 (needs format v2): commit-graph -> graph-{hash}.graph
> --------------------------------------------------------------
>
> On read, we load the 'info/commit-graph' file and inspect the byte saying
> how many base files we have. We load their hashes from the base file chunk
> and read 'info/graph-{hash}.graph' for each. If _any_ fail, then we need
> to ignore anything "above" the failure in the chain (and specifically this
> includes the 'commit-graph' file), or consider reloading the commit-graph
> file altogether and hope it works this time. [Note: if an older version
> of Git doesn't understand the incremental file format, it will fail to
> properly understand the graph positions and either fail with an
> "invalid parent position" error, or worse give garbage results.]

Right, except as noted before I'd add (at least per my understanding so
far) "s/needs format v2//". I.e. we could stick this data in new v1
backwards-compatible chunks, which also addresses the "older version..."
caveat.

I.e. we'd always guarantee that the "commit-graph" file was
understandable/valid for older versions (even though eventually their
view on it would be "oh, this has no data" (but really it's all in a new
chunk they don't grok).

> On write, if we are creating a new layer to our chain, we need to _copy_
> the existing commit-graph file to a graph-{hash}.graph file before renami=
ng
> the .lock file. If we are merging layers, then we either (a) clean up the
> dangling chains after moving our commit-graph file, or (b) have something
> like 'gc' clean up the files later. I think using 'gc' for this is not
> a good idea, since I would expect these files to be written and merged
> much more frequently (say, after a 'fetch') than a 'gc' is run. Cleaning
> up the dangling chains leads to our concurrency issues. Further, this
> 'copy the base' no longer keeps our large base file at rest.

So aside from the specifics of implementation both this and the
commit-graph-N way of doing it involves juggling a sequence of chunks
that "point upwards", which IMO has worse caveats than "point
downwards". I.e. we'd need to rewrite "base" files to point "upwards" to
new stuff, and there's no (sane) way in option 0 to split commit-graphs
across repos, and no way at all in this scenario (if I understand it
correctly...).

> Option 2: grovel commit-graphs directory for graph-{hash}.graph
> ---------------------------------------------------------------
>
> On read, we load the 'info/commit-graph' file and assume it is never
> an incremental file. Then, scan the 'info/commit-graphs' directory
> for 'graph-{hash}.graph' files and open them _all_ up to construct
> a "graph forest" (each graph has a single parent, given by a chunk
> specifying its base graph hash). If we don't have an instance of a
> graph with a given hash, then ignore any graphs pointing to that hash.
> We now have a decision to make: which leaf of this forest should we
> use as our tip commit-graph? That could be given by the
> commit-graphs/info file. But what happens when we have timing issues
> around scanning the directory and the commit-graphs/info file? Do
> we fall back to modified time?

I think in a worst-case scenario we shrug and just pick whatever chain
looks most recent/largest or whatever, but in practice I think it's a
non-issue.

Critical for that "it's a non-issue" is the suggestion I had on 17/17 of
not doing the incremental write in "fetch", but instead just rely on "gc
--auto" *and* to address your "I would expect these files to be written
and merged much more frequently" we'd just (and I'm keen to hack this
up) teach "gc --auto" such an incremental mode.

This means that within a single repo all updates to the commit-graph
will go through the gc.lock, whereas with your current 17/17 we'd
potentially have a "commit-graph write" racing a concurrent "gc", with
both aiming to update the commit-graph.

> On write, if we are not merging, then we just create a new
> graph-{hash}.graph file. If we are merging, but still have a base graph,
> then create a new graph-{hash}.graph file. Finally, if we are merging
> all layers, then we rename our .lock file to 'info/commit-graph'.
> To clean up, we need to grovel the directory to look for graph-{hash}.gra=
ph
> files whose base chains no longer match the new, "best" chain and unlink()
> them. This clean-up step can happen at any time.
>
> --[end description of options]--
>
> Did I accurately describe the options we are considering?
>
> Option 1 was the design I was planning, and I think it matches how the
> split-index feature works. Please correct me if I am missing something.
> It _requires_ updating the file format version. But it also has a flaw
> that the other options do not have: the copy of the base file. One
> thing I want to enable is for whatever machinery is handling these
> file writes to run a 'verify' immediately after, and have that be fast
> most of the time. With a model that changes only the "tip" file, we
> can verify only the new files and have confidence that the base file
> did not change. I think options 0 and 2 both improve in this direction.
>
>> With commit-graph-<HASH> all these unlink() race conditions go away,
>> partial reads due to concurrent graph writing becomes a non-issue (we'd
>> just leave the old files, "gc" deals with them later..), no need to
>> carefully fsync() files/dirs etc as we need to carefully juggle N and
>> N+1 files.
>
> Calling this a non-issue is an exaggeration, especially if you are
> claiming we need to be robust to multi-hour gaps between reading files.

We always have a race, but they're very different races.

With "N" files (option #0) we'd have races of the type where within the
same few milliseconds of a commit-graph being merged/updated a
e.g. concurrent "tag --contains" would either be much slower (couldn't
get one of the incremental graphs it expected), or produce the wrong
answer (this may be wrong on my part, see my "base hash" comment above).

Whereas if I run something with "ionice -c 3" I could possibly hang for
however many hours/days/weeks we wait until another "gc" comes along and
unlinks those old files, but if I'm running it like that I'm not
expecting it to be fast, so it's OK if the files went away, and it won't
ever get the wrong file (since the filenames are hash-addressible).

>> It also becomes easy to "chain" graphs across repos e.g. via
>> alternates. Say in the scenario github/gitlab have where they have a
>> "main" repo and other objects on another delta island.
>>
>> In that case the repo would have a local "tip" file with the last link
>> in its chain, some of which would then refer back to <HASHes> in other
>> "parent" alternates.
>>
>> As long as such a setup has a "gc" process that's not overly eager about
>> pruning old stuff and considers that constellation of repos as a whole
>> that should just work. You can freely optimize and rewrite graphs across
>> repos, just be careful about unlinking old stuff.
>>
>> I don't see how it would work with commit-graph-N without a *lot* of
>> painful orchestration (where e.g. you *must* guarantee that the parent
>> repo ends in N, all child repos start at N+1).
>
> You're right that Option 0 does not work in this model where some graph
> information is stored in an alternate _and_ more information is stored
> outside the alternate. My perspective is biased, because I consider the
> alternate to be "almost everything" and the local object store to be
> small. But in a fork network, this is not always the case. I appreciate
> your feedback for this environment, and I've always hoped that someone
> with server experience would come and say "this feature is great, but
> we need X, Y, and Z to make best use of it in our environment. Here's
> a patch that moves us in that direction!" At least you are doing the
> next-best thing: stopping me from making mistakes that would block
> adoption.

I'm happy to write some patches, just want to talk about it first (and
if I'm lucky convince you to write them for me :) ).

One example is the git-for-windows commit-graph is 5.6MB, the git.git
one is 3.1MB. Should GitHub just stick that all in the one "parent"
graph, maybe. But nice to have the flexibility of stacking them.

There's also more disconnected cases, e.g. I have some "staging" boxes
where where I have a cronjob running around re-pointing clones of a big
monorepo to a shared "alternates" store where I guarantee objects are
only ever added, never removed.

It would be nice to have a way to provide a commit-graph there that's
"stable" that clients could point to, and they'd just generate the
difference.

I.e. now I have a shared .git/objects which contains gigabytes, a
crapload of stuff in /home where .git/objects is 10-50MB, and each one
has a commit-graph that's around the same 50-100MB size (since it needs
to contain the metadata for the full set).

> So let's consider how Option 2 would work in this "multi-tip" case.
> Each object directory would have some number of graph files, and one
> 'commit-graphs/info' file pointing to some hash. When we read, we
> try to pick the info file that is "closest" to us.
>
> This does create some complications that I don't think you gave enough
> attention to. These may be solvable, but they are non-trivial:
>
> * When we 'gc' the "core" repo, we need to enumerate all of the
>   "leaf" repos to check their tip commit-graph files and make a
>   decision if we should keep their bases around or delete those tips.
>   Perhaps I'm over-stating the difficulty here, since we need to do
>   something similar to find still-reachable objects, anyway. But if
>   we are doing that reachability calculation, then why are we not
>   just putting all of the commit-graph data in the core repo? Note
>   that we don't get the same value as delta islands because this data
>   isn't being shared across the protocol. The issue with storing all
>   graph data in the core repo is that the core repo doesn't actually
>   have all of the commits, which makes 'verify' on the graph a bit
>   annoying.

Yeah I think similar to "alternates" it would be annoying to have a case
where a given repo has metadata on objects it doesn't have, and there's
cases (see the "staging" case I mentioned above) where that "parent"
repo won't have access to those things.

> * If we choose a local tip instead of the "core" tip, then that chain
>   of commit-graphs can be far behind the core repo. In the world where
>   a fork moves only at the speed of a single developer, but the core
>   project moves quickly, then computing a merge base with the core's
>   master branch becomes slow as our local chain doesn't contain most
>   of the commits.

That's a good point and a case where pointing "upwards" or just having
commit-graphs in the "base" repo is better, i.e. the "fork" has almost
no objects.

But solvable by triggering "gc" on these child projects so their
commit-graph keeps being re-pointed to a later version.

And we'd have the reverse problem with a git-for-windows wouldn't we?
I.e. the fork is "far ahead".

> * We can't take all of the "core" chain _and_ the local chain, because
>   the concept of "graph position" no longer makes sense. The only way
>   I see out of this is to make the graph position two-dimensional:
>   commit -> (index of tip chain, position in that chain). Perhaps this
>   is a valuable thing to do in the future? Or perhaps, we shouldn't
>   have incremental chains spanning object directories and instead
>   introduce "parents-by-ref" where we mark some parents as included
>   by object id instead of by graph position. This would allow the
>   core repo to gc without caring about the external repos. It also
>   wouldn't care about how the graph files are stored (Option 0 would
>   work, as graph chains would not cross object store boundaries) and
>   more closely resembles the independence of the pack-files in each
>   object store. The "parents-by-ref" would require updating the
>   file format version.

The parent repo can "gc" without caring/inspecting "child" repos with
the "point downwards" of option #2, as long as it promises to retain its
old commit-graph files for some retention period of X, and the "child"
repos promise to "gc" (and re-point to new graphs if necessary) at rate
that's faster than that.

This makes it easy to e.g. say "we retain old commit-graph files for 2
weeks", and "we re-gc everything in cron weekly".

It would work best if we can also pull this trick on the "base"
commit-graph file, which I believe we could do in a backwards-compatible
way by making "commit-graph" a symlink to whatever "commit-graph-<HASH>"
is the current "base".

> --[end discussion of incremental files]--
>
> I'll move forward applying your existing feedback on patches 1-11 and
> submit as a full series to replace ds/commit-graph-format-v2. We can
> work on reviewing that code while we continue to think critically on
> the topic of incremental files.
>
> Thanks,
> -Stolee
