Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D74F1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeJKG0O (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 02:26:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43671 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKG0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 02:26:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so6461607eds.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ppvzmw2yA5OoTa5lyAIJFKQzTEWWcEPdFAUdNkuMy94=;
        b=aSiNoCTSiJ1xUOrGAD1a5sX0fesyZdMPPocSh0toeLw1fEx+/c2ESh2kSQ9ecO41Vv
         gTLiqjX/HBn+BL5cJxIw9ZuxkACXGyfn5shgE/k0k9AVtv3WDTtT9HVxKiTFxhhmmggz
         pfJ6V7TPi6MxB24+l1PF/cQbNR0yUPYC5PS1LConQLIk2yTrIUBf/6IoMeCnEGSzN1VI
         xYf4bL9Ga3/lLYsLCFbLpQEW4qAOBgE3B+94ucf0XmvQfm/m3sJvqwEnTb05BEd4MT8q
         yJ2sFJQRAsOuTFzKoyZVAEVwG0rcye0v+oje+oFfQxCgLUgA5lxCE+lIrkyKTB1Q0g48
         Mp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ppvzmw2yA5OoTa5lyAIJFKQzTEWWcEPdFAUdNkuMy94=;
        b=bjY3banh8Xmko615Vks063VkK2izFnMJAOGyPyhd1YFVTbY7y8EvyWkHCUi6w6eCKX
         vMJahwYuWUEob1afCDf7AcAqWncDVXb1kFxJ6BBKx0ojLfvsJiNE61iWT+/+aJzi9Pu3
         1NObEFj3cU4y/nIkXvMUx/nyHCDc5u25ya841q3zQmh/z+0vxfb5CaVe+iAYCuJzyk1Q
         6C7etTCk3SGFuz5FyzwNWPSU2nIIZrLHW8hDDLStwwsgOFEss6SQG0dskqdUsgv6l3ub
         ovjiNZm9TC+RwwF1/abtY2eGzv9P3ymVE+EL/f3bbYbQrSaEno9M8NWV13sID8X2bh+Y
         VqeA==
X-Gm-Message-State: ABuFfoiAVPs5ohDVzSnEQZaIn8e/Y++KO1yWJF8DvNNU4IAdynFJXd6m
        YZ7Kq3cUb8fRhqPys2BOMVgeSTMXkUw=
X-Google-Smtp-Source: ACcGV61n20v0C0iicReJo6BIaBNcnnXb7okJdNNiT9vHqrNMHBOwczyPJutLzUIpbnXi8IBYtU6V0Q==
X-Received: by 2002:a50:b494:: with SMTP id w20-v6mr43116066edd.197.1539212514546;
        Wed, 10 Oct 2018 16:01:54 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id a21-v6sm7686917edr.57.2018.10.10.16.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 16:01:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <20181003133650.GN23446@localhost>
        <87r2h7gmd7.fsf@evledraar.gmail.com>
        <20181003141732.GO23446@localhost>
        <87o9cbglez.fsf@evledraar.gmail.com>
        <20181003145308.GP23446@localhost>
        <87murvgir6.fsf@evledraar.gmail.com>
        <20181003165926.GR23446@localhost>
        <xmqqpnwo3ow9.fsf@gitster-ct.c.googlers.com>
        <20181010220739.GF23446@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010220739.GF23446@szeder.dev>
Date:   Thu, 11 Oct 2018 01:01:51 +0200
Message-ID: <87lg75e78g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, SZEDER Gábor wrote:

> On Thu, Oct 04, 2018 at 11:09:58PM -0700, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>
>> >>     git-gc - Cleanup unnecessary files and optimize the local repository
>> >>
>> >> Creating these indexes like the commit-graph falls under "optimize the
>> >> local repository",
>> >
>> > But it doesn't fall under "cleanup unnecessary files", which the
>> > commit-graph file is, since, strictly speaking, it's purely
>> > optimization.
>>
>> I won't be actively engaged in this discussion soon, but I must say
>> that "git gc" doing "garbage collection" is merely an implementation
>> detail of optimizing the repository for further use.  And from that
>> point of view, what needs to be updated is the synopsis of the
>> git-gc doc.  It states "X and Y" above, but it actually is "Y by
>> doing X and other things".
>
> Well, then perhaps the name of the command should be updated, too, to
> better reflect what it actually does...

I don't disagree, but between "git gc" being a longstanding thing called
not just by us , but third parties expecting it to a be a general swiss
army knife for "make repo better" (so for a new tool they'd need to
update their code), and general name bikeshedding I think it's best if
we just proceed for the sake of argument with the assumption that none
of us find the name confusing in this context.

At least that's the discussion I'm interested in. I.e. whether it makes
conceptual / structural sense for this stuff to live in the same place /
function in the code. We can always argue about the name of the function
as a separate topic.

>> I understand your "by definition there is no garbage immediately
>> after clone" position, and also I would understand if you find it
>> (perhaps philosophically) disturbing that "git clone" may give users
>> a suboptimal repository that immediately needs optimizing [*1*].
>>
>> But that bridge was crossed long time ago ever since pack transfer
>> was invented.  The data source sends only the pack data stream, and
>> the receiving end is responsible for spending cycles to build .idx
>> file.  Theoretically, .pack should be all that is needed---you
>> should be able to locate any necessary object by parsing the .pack
>> file every time you open it, and .idx is mere optimization.  You can
>> think of the .midx and graph files the same way.
>
> I don't think this is a valid comparison, because, practically, Git
> just didn't work after I deleted all pack index files.  So while they
> can be easily (re)generated, they are essential to make pack files
> usable.  The commit-graph and .midx files, however, can be safely
> deleted, and everything keeps working as before.

For "things that would run in 20ms now run in 30 seconds" (actual
numbers on a repo I have) values of "keeps working".

So I think this line gets blurred somewhat. In practice if you're
expecting the graph to be there to run the sort of commands that most
benefit from it it's essential that it be generated, not some nice
optional extra.

> OTOH, this is an excellent comparison, and I do think of the .midx and
> graph files the same way as the pack index files.  During a clone, the
> pack index file isn't generated by running a separate 'git gc
> (--auto)', but by clone (or fetch-pack?) running 'git index-pack'.
> The way I see it that should be the case for these other files as well.
>
> And it is much simpler, shorter, and cleaner to either run 'git
> commit-graph ...' or even to call write_commit_graph_reachable()
> directly from cmd_clone(), than to bolt on another option and config
> variable on 'git gc' [1] to coax it into some kind of an "after clone"
> mode, that it shouldn't be doing in the first place.  At least for
> now, so when we'll eventually get as far ...
>
>> I would not be surprised by a future in which the initial index-pack
>> that is responsible for receiving the incoming pack stream and
>> storing that in .pack file(s) while creating corresponding .idx
>> file(s) becomes also responsible for building .midx and graph files
>> in the same pass, or at least smaller number of passes.  Once we
>> gain experience and confidence with these new auxiliary files, that
>> ought to happen naturally.  And at that point, we won't be having
>> this discussion---we'd all happily run index-pack to receive the
>> pack data, because that is pretty much the fundamental requirement
>> to make use of the data.
>
> ... that what you wrote here becomes a reality (and I fully agree that
> this is what we should ultimately aim for), then we won't have that
> option and config variable still lying around and requiring
> maintenance because of backwards compatibility.

We'll still have the use-case of wanting to turn on
gc.writeCommitGraph=true or equivalent and wanting previously-cloned
repositories to "catch up" and get a commit graph ASAP (but not do a
full repack).

This is why my patch tries to unify those two codepaths, i.e. so I can
turn this on and know that on the next "git fetch" we'll have the graph
(without needing to also run a full repack if it's not needed).

> 1 - https://public-inbox.org/git/87in2hgzin.fsf@evledraar.gmail.com/
>
>> [Footnote]
>>
>> *1* Even without considering these recent invention of auxiliary
>>     files, cloning from a sloppily packed server whose primary focus
>>     is to avoid spending cycles by not computing better deltas will
>>     give the cloner a suboptimal repository.  If we truly want to
>>     have an optimized repository ready to be used after cloning, we
>>     should run an equivalent of "repack -a -d -f" immediately after
>>     "git clone".
>
> I noticed a few times that I got surprisingly large packs from GitHub,
> e.g. there is over 70% size difference between --single-branch cloning
> v2.19.0 from GitHub and from my local clone or from kernel.org (~95MB
> vs. ~55MB vs ~52MB).  After running 'git repack -a -d -f' they all end
> up at ~65MB, which is a nice size reduction for the clone from GitHub,
> but the others just gained 10-13 more MBs.

To me this sounds like even more reason for why we shouldn't be
splitting up the entry point for the "does the repo look shitty? Fix
it!" function (currently called git-gc).

We might get such crappy packs from a clone, or from a fetch, or maybe
in the future when e.g. "git add" or "git commit" generate a pack
instead of a bunch of loose objects we'd want to immediately kick off
something in the background to optimize / consolidate them.

So instead of having clone/commit/add/whatever call some custom
function(s) to just do the things they *think* they want, we just call
"gc --auto", because that entry point needs to eventually know how to
"recover" from any of those states without any prior knowledge or hints
about what just happened.

This is why I'm calling "gc --auto" from clone in this WIP series, with
the only special sauce being "if you have stuff to do, don't background
yourself", because not having a commit graph at all after a clone is
just one special case of many where we have no commit graph and want to
have one made ASAP (e.g. someone rm'd it, or the "I want a commit graph"
config variable just got turned on).

So since we need all those smarts in some function anyway, let's just
have one entry point to that logic. Discarding what it doesn't need to
do (e.g. too_many_loose_objects() just after a clone) is a trivial cost,
so if we don't care about that we have less complexity to worry about by
not having a proliferation of entry points into what are now subsets of
the GC code.
