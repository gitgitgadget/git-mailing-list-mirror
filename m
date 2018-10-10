Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FB51F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeJKFbx (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:31:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40052 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeJKFbx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:31:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so6375398edd.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nWQ0rvXDVIrcQoXMzCSGka/jiyh0gYAeOvC/ut+Oo2s=;
        b=qXad/zgxC8kZVN4gv5j53JgJrT4dSa21mV9OgK4HcK5hxGkAIgrn8t0aHdqnzS2Ag+
         cpbJ/c0T3hK5nS+wZyUmKo6/Yankhl4EJwtl897z3IIt0W342Q+K7n/QTv+cO4G1pAs+
         uuItWgPAze8MovZqUh+6ii+1tJ2G8Lg5kv/GBkkqPx+vFo8ElY8bzPLQ/ce7xg8FtXAm
         tEcn/zYR1Yy32AxALPT3N5hxVusn9x0SRkBjQyf/Wyo05yU375cCWYMcPERZFNkscQ+k
         0Bfifdex7dWLWQP68jt0P7THgHQz+5WOXexkNHWkiiDO1tJ+goxjFIDrh7ixqZZV7e2i
         KeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nWQ0rvXDVIrcQoXMzCSGka/jiyh0gYAeOvC/ut+Oo2s=;
        b=sy+uoUquyGyaRnLLa3v6SoKFyWa6oI5kFjubRk92Ql28viSWdh+ItthwmT9bGXshmY
         w40ye2RtTjiVluZbu7CKd6CGWGprB6F2LtovR51wE1pgiLJbGQ+B/Rc10wTJ0AXTjpY1
         Fkk6RSzsZpQvCZuDCe8VIuTDhf64bvLYJeMN2h/7dX3nZHAMjgWOtMPEfgC31CAbnk6R
         J1SJrXwCZ1vXzLO0zV/gx+a5CM23nGpJQeAipVQVKN6nivjQ8Tr8FPm5udcNd4UQ03pf
         9YexCKNdN7vQqSQJEjQ+XmQInXKMZMzVMO2kK3w1m330fkc0m3q1ZAcZFwW3QcBAUIwT
         mzCw==
X-Gm-Message-State: ABuFfoj2R+7gXA8h8EPlUaqrWVvSoFJP5PmcgO177yXns68RlN9FmDFh
        l9gvz+oyOsa3xgehdw6EVns=
X-Google-Smtp-Source: ACcGV61Nx8ClWJS1M+4Sr+rqzEkHEXo+9wKu5KtcyL4YnBSebJSPceu5AzeRBfwza8ja9sBK+uX36A==
X-Received: by 2002:a50:8f23:: with SMTP id 32-v6mr492048edy.158.1539209262984;
        Wed, 10 Oct 2018 15:07:42 -0700 (PDT)
Received: from szeder.dev (x4db070c3.dyn.telefonica.de. [77.176.112.195])
        by smtp.gmail.com with ESMTPSA id p19-v6sm1126290ejw.69.2018.10.10.15.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:07:41 -0700 (PDT)
Date:   Thu, 11 Oct 2018 00:07:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181010220739.GF23446@szeder.dev>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
 <20181003145308.GP23446@localhost>
 <87murvgir6.fsf@evledraar.gmail.com>
 <20181003165926.GR23446@localhost>
 <xmqqpnwo3ow9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpnwo3ow9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 11:09:58PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >>     git-gc - Cleanup unnecessary files and optimize the local repository
> >> 
> >> Creating these indexes like the commit-graph falls under "optimize the
> >> local repository",
> >
> > But it doesn't fall under "cleanup unnecessary files", which the
> > commit-graph file is, since, strictly speaking, it's purely
> > optimization.
> 
> I won't be actively engaged in this discussion soon, but I must say
> that "git gc" doing "garbage collection" is merely an implementation
> detail of optimizing the repository for further use.  And from that
> point of view, what needs to be updated is the synopsis of the
> git-gc doc.  It states "X and Y" above, but it actually is "Y by
> doing X and other things".

Well, then perhaps the name of the command should be updated, too, to
better reflect what it actually does...

> I understand your "by definition there is no garbage immediately
> after clone" position, and also I would understand if you find it
> (perhaps philosophically) disturbing that "git clone" may give users
> a suboptimal repository that immediately needs optimizing [*1*].
> 
> But that bridge was crossed long time ago ever since pack transfer
> was invented.  The data source sends only the pack data stream, and
> the receiving end is responsible for spending cycles to build .idx
> file.  Theoretically, .pack should be all that is needed---you
> should be able to locate any necessary object by parsing the .pack
> file every time you open it, and .idx is mere optimization.  You can
> think of the .midx and graph files the same way.

I don't think this is a valid comparison, because, practically, Git
just didn't work after I deleted all pack index files.  So while they
can be easily (re)generated, they are essential to make pack files
usable.  The commit-graph and .midx files, however, can be safely
deleted, and everything keeps working as before.

OTOH, this is an excellent comparison, and I do think of the .midx and
graph files the same way as the pack index files.  During a clone, the
pack index file isn't generated by running a separate 'git gc
(--auto)', but by clone (or fetch-pack?) running 'git index-pack'.
The way I see it that should be the case for these other files as well.

And it is much simpler, shorter, and cleaner to either run 'git
commit-graph ...' or even to call write_commit_graph_reachable()
directly from cmd_clone(), than to bolt on another option and config
variable on 'git gc' [1] to coax it into some kind of an "after clone"
mode, that it shouldn't be doing in the first place.  At least for
now, so when we'll eventually get as far ...

> I would not be surprised by a future in which the initial index-pack
> that is responsible for receiving the incoming pack stream and
> storing that in .pack file(s) while creating corresponding .idx
> file(s) becomes also responsible for building .midx and graph files
> in the same pass, or at least smaller number of passes.  Once we
> gain experience and confidence with these new auxiliary files, that
> ought to happen naturally.  And at that point, we won't be having
> this discussion---we'd all happily run index-pack to receive the
> pack data, because that is pretty much the fundamental requirement
> to make use of the data.

... that what you wrote here becomes a reality (and I fully agree that
this is what we should ultimately aim for), then we won't have that
option and config variable still lying around and requiring
maintenance because of backwards compatibility.

1 - https://public-inbox.org/git/87in2hgzin.fsf@evledraar.gmail.com/

> [Footnote]
> 
> *1* Even without considering these recent invention of auxiliary
>     files, cloning from a sloppily packed server whose primary focus
>     is to avoid spending cycles by not computing better deltas will
>     give the cloner a suboptimal repository.  If we truly want to
>     have an optimized repository ready to be used after cloning, we
>     should run an equivalent of "repack -a -d -f" immediately after
>     "git clone".

I noticed a few times that I got surprisingly large packs from GitHub,
e.g. there is over 70% size difference between --single-branch cloning
v2.19.0 from GitHub and from my local clone or from kernel.org (~95MB
vs. ~55MB vs ~52MB).  After running 'git repack -a -d -f' they all end
up at ~65MB, which is a nice size reduction for the clone from GitHub,
but the others just gained 10-13 more MBs.

