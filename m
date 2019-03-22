Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4338F20248
	for <e@80x24.org>; Fri, 22 Mar 2019 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCVPtu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 11:49:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39715 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 11:49:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so2889199wrn.6
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7S5OmNjmTwPe9qeQs4fDb98yXIJ32W/gc2cfDl2pwqo=;
        b=O9zmHystrf1YtqjvN/drMLP7Cy/45MamTiwgy9m7C3d8JzTrtKWDjwwLKgh/lGoDix
         VRExp8uUuxcm1CoKHenZdkE+mKhyvRCAp9tUkrVteFUcKq/viU8jjhp4D7oElf5pMbt7
         i/w4unmq0Ka+7SjUDo0IORcvYSaWqYjwd7hZTloMTv4QLnx/KBNqfuvVj2CZyW5HcWDZ
         +4IPGAP2/nhi9ps5zjnxGxLIC1V0w2foys5HXPpJDEzSP9Bji+pt/BX8egTprPUYE6E/
         DeM8kbYqzf5o4iOPI/gYO/ztc0C+JHaVvPOAKK0CcDrvX+CcNc/PxAQsxXwARo2gV4g6
         IQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7S5OmNjmTwPe9qeQs4fDb98yXIJ32W/gc2cfDl2pwqo=;
        b=G4mssxiN9T0MWfmzyS8uey1D8cYw0yuMe0hnc/coxxjW5cnndIEbqHQH2BC6QulNNH
         J49E73YX2OVfL4z5Foa+wDfpPWKDsS/4HkDazYvNgzgUs+hIbetifPdzCRN4nZYJ45K/
         Py5u/+wyemqjQMMYu00nBxOZOfyzbSi6OOcq1qFT8uWm2vWCyR7sFzCkVdxQT88+6Qck
         R/K84Z/VIWEQoppbf06IoOfsR5m7JaSnlW14NnFLSq5ACSTA72xApDFeJ6zo76I6+tNb
         A+DHfnLiz0RN2uqF/yJXhyaZo3mrEAnoyzhgXHXsXAAOnOHpDlWvn7croVXgbNxvqw9/
         aIYA==
X-Gm-Message-State: APjAAAVz0n45YIKhNhmU1Xw5khzGFnQEzPBIn1GZYyswA1QCibu/mW9/
        2bp/Esdo+V/j7pC9NLVyjL8=
X-Google-Smtp-Source: APXvYqwlFqPqzH7fv563Ynuvm8VAlEYZdkr+gKVCcL4k6y6lNwcAsfTHAsAzlIKU4kaguyTjvPxCog==
X-Received: by 2002:adf:f285:: with SMTP id k5mr4191978wro.110.1553269786833;
        Fri, 22 Mar 2019 08:49:46 -0700 (PDT)
Received: from szeder.dev (x4db501f9.dyn.telefonica.de. [77.181.1.249])
        by smtp.gmail.com with ESMTPSA id f15sm145956wru.21.2019.03.22.08.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:49:46 -0700 (PDT)
Date:   Fri, 22 Mar 2019 16:49:43 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: don't show progress percentages while
 expanding reachable commits
Message-ID: <20190322154943.GF22459@szeder.dev>
References: <20190119202121.3590-11-avarab@gmail.com>
 <20190322102817.19708-1-szeder.dev@gmail.com>
 <87lg17cgf5.fsf@evledraar.gmail.com>
 <20190322111829.GC22459@szeder.dev>
 <87k1grc7al.fsf@evledraar.gmail.com>
 <20190322145550.GE22459@szeder.dev>
 <87ftrfc5b7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftrfc5b7.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 04:11:24PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 22 2019, SZEDER Gábor wrote:
> 
> > On Fri, Mar 22, 2019 at 03:28:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Fri, Mar 22 2019, SZEDER Gábor wrote:
> >>
> >> > On Fri, Mar 22, 2019 at 12:11:26PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >>
> >> >> On Fri, Mar 22 2019, SZEDER Gábor wrote:
> >> >>
> >> >> > Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> >> >> > progress, 2019-01-19) was a bit overeager when it added progress
> >> >> > percentages to the "Expanding reachable commits in commit graph" phase
> >> >> > as well, because most of the time the number of commits that phase has
> >> >> > to iterate over is not known in advance and grows significantly, and,
> >> >> > consequently, we end up with nonsensical numbers:
> >> >> >
> >> >> >   $ git commit-graph write --reachable
> >> >> >   Expanding reachable commits in commit graph: 138606% (824706/595), done.
> >> >> >   [...]
> >> >> >
> >> >> >   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
> >> >> >   Expanding reachable commits in commit graph: 81264400% (812644/1), done.
> >> >> >   [...]
> >> >> >
> >> >> > Therefore, don't show progress percentages in the "Expanding reachable
> >> >> > commits in commit graph" phase.
> >> >>
> >> >> There's indeed a bug here as your examples show, but there *are* cases
> >> >> where it's correct, as the commit message for my patch on "master" shows
> >> >> there's cases where we correctly.
> >> >>
> >> >> So this "fixes" things by always removing the progress, why not instead
> >> >> pass down the state to close_reachable() about what we're walking over,
> >> >> so we can always show progress, or at least in some cases?
> >> >
> >> > The cases where it does display correct percentages are exceptional,
> >> > and doesn't worth the effort to try to find out whether ther current
> >> > operation happens to be such a case.
> >>
> >> It's the "write" entry point without arguments that displays the correct
> >> progress. So not exceptional, but yeah, it's not what we use on "gc".
> >
> > Bit it displays the correct number only if all the reachable commits
> > are in packfiles, which is not necessarily the case (e.g. unpacked
> > small packs during 'git fetch').
> 
> No, argument-less "write" only considers packed commits.

No, it considers packed commits as starting points, and then expands
to all reachable commits, that's what that loop in question is about.

  $ git init
  Initialized empty Git repository in /tmp/test/.git/
  $ echo >file
  $ git add file
  $ git commit -q -m initial
  $ echo 1 >file
  $ git commit -q -m 1 file
  $ git rev-parse HEAD | git pack-objects
  .git/objects/pack/pack
  Enumerating objects: 1, done.
  Counting objects: 100% (1/1), done.
  ece3ff72952af2b28e048fa5c58db88c44312876
  Writing objects: 100% (1/1), done.
  Total 1 (delta 0), reused 0 (delta 0)
  $ git commit-graph write
  Computing commit graph generation numbers: 100% (2/2), done.


> >> In any case, the problem is that sometimes we've walked the full set of
> >> commits already, and some other times we haven't.
> >
> > ... and that we can't really be sure whether we've walked the full set
> > of commits until after this loop.
> 
> I'm fairly sure we can when we start with a full walk. See my
> explanation in <87imwbc6x8.fsf@evledraar.gmail.com>, but I may have
> missed something.
> 
> >> So in cases where we have we can show progress, and as a TODO (I think
> >> this came up in previous discussions), we could do better if we had a
> >> approximate_commit_count().
> >>
> >> In any case, the below fix seems correct to me, but I haven't poked it
> >> much. It *does* suffer from a theoretical race with the progress bar
> >> similar to d9b1b309cf ("commit-graph write: show progress for object
> >> search", 2019-01-19), but I work around it in the same way:
> >>
> >> diff --git a/commit-graph.c b/commit-graph.c
> >> index 47e9be0a3a..0fab3d8b2b 100644
> >> --- a/commit-graph.c
> >> +++ b/commit-graph.c
> >> @@ -693,7 +693,8 @@ static void add_missing_parents(struct packed_oid_list *oids, struct commit *com
> >>  	}
> >>  }
> >>
> >> -static void close_reachable(struct packed_oid_list *oids, int report_progress)
> >> +static void close_reachable(struct packed_oid_list *oids, int report_progress,
> >> +			    uint64_t oids_count_for_progress)
> >>  {
> >>  	int i;
> >>  	struct commit *commit;
> >> @@ -717,7 +718,8 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
> >>  	 */
> >>  	if (report_progress)
> >>  		progress = start_delayed_progress(
> >> -			_("Expanding reachable commits in commit graph"), oids->nr);
> >> +			_("Expanding reachable commits in commit graph"),
> >> +			oids_count_for_progress);
> >>  	for (i = 0; i < oids->nr; i++) {
> >>  		display_progress(progress, i + 1);
> >>  		commit = lookup_commit(the_repository, &oids->list[i]);
> >> @@ -725,6 +727,8 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
> >>  		if (commit && !parse_commit(commit))
> >>  			add_missing_parents(oids, commit);
> >>  	}
> >> +	if (oids->nr < oids_count_for_progress)
> >> +		display_progress(progress, oids_count_for_progress);
> >>  	stop_progress(&progress);
> >>
> >>  	if (report_progress)
> >> @@ -829,6 +833,7 @@ void write_commit_graph(const char *obj_dir,
> >>  	uint64_t progress_cnt = 0;
> >>  	struct strbuf progress_title = STRBUF_INIT;
> >>  	unsigned long approx_nr_objects;
> >> +	uint64_t oids_count_for_progress = 0;
> >>
> >>  	if (!commit_graph_compatible(the_repository))
> >>  		return;
> >> @@ -934,9 +939,10 @@ void write_commit_graph(const char *obj_dir,
> >>  		if (oids.progress_done < approx_nr_objects)
> >>  			display_progress(oids.progress, approx_nr_objects);
> >>  		stop_progress(&oids.progress);
> >> +		oids_count_for_progress = oids.nr;
> >>  	}
> >>
> >> -	close_reachable(&oids, report_progress);
> >> +	close_reachable(&oids, report_progress, oids_count_for_progress);
> >>
> >>  	if (report_progress)
> >>  		progress = start_delayed_progress(
> >>
