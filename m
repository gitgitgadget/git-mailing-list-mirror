Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F229405
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247199; cv=none; b=bDwojKlvI5RTbyHN4mrsVyw7q0tswPxFMNQvSPaTcC0eioWx6xWnXUv5bmeHzfqhBf+NBZXNQnkMWg6yVj+aUymlBrNff67VNG7d5eQa6uZ7OkcjJ3eiRrH586yvZ9zl9KRJI3JgssC6tk0AbgzRmTz+9hPCpPXbX6mzzTP9jK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247199; c=relaxed/simple;
	bh=CwZlcj0TbyLlJOROfg6RG0rLLWg5IeC+Rk/sKa8OBeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNNZuYw+tnS4DuC8lcsL7mxuv3oPgOq6rOXfR4vFQUDIsdWXRjP3y91nDTfP8zQt4aD5arSfvOiCDxn25Cs+KFENrkQbC+hRh7nQJ63vybw46tRW5Qjd+Pc1Ac4dC6AHLG1mR+yN8nchhis2AGvH+Er2C0xcVhXNbJwbxJEQP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CLqKsoxh; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CLqKsoxh"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430d098121cso6225635ab.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761247197; x=1761851997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRyu0MhOHHpXxOvaRjq6/tKLB3RtZqWqYpMiMExHZxs=;
        b=CLqKsoxhbmLeT+3BHpfDcfkk/VTqwsQ9YLxWJzUU/rijdM3SPPUAzRYEqS29kLBSlA
         O2jwv4t0c3GN9f28ew4AuUUgHJ+eR3c2rsNErYvqJbezmxIgib3ae2UAd8s8w+6m4jHM
         7awYQrVfOOHBm4E1ZVwkF6KO3wG09yprL2KBM7ll/4sS4GlzQgtL8gRHkpVyidr3FoEz
         tvm8qEd+hu5MbcST+Za5/z6oPrFoNhdSyNT0cvuIPI5YaKPQhDVm3fIH8cMPWY4MZmm4
         Pj14YUCbaEWPfI558s7n4Z/zRJgXtl/hbxHviC8bLnsDLPFoJCm65zm2HYKUF/RPN6pK
         Eplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247197; x=1761851997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRyu0MhOHHpXxOvaRjq6/tKLB3RtZqWqYpMiMExHZxs=;
        b=tdY7OA85eVaH7DpszEkht4YejLdGYO7U7CMS3mJHyAkB7RFAh6i+toeqkGXy/mUhLS
         wvB1rx1Uupb8ZFsxeQ/Yvp7xbhszLkuTpRzCQEX5xbHO1fumTnuceZX6joHeEre/gX8Z
         VbPDwb1kt+gfGnAPOEx8g64f1AREp9uDTuuqxvuTvVpwnz00lBzS1p0pldGSD1X0yErs
         4RAfSFUhgcOp1HH+A3KULFI774VE8u1YiLh3sLX1Cmvwb0811Ib+c+f+IBQUTFTLRubA
         jCstcC6mQ25jOVo0I5KvDLQ8OpdU3stHK5QH6UAGRczKsQGfV0NTXozkFSysSXOkGtWd
         Vrxg==
X-Gm-Message-State: AOJu0Yyjbdj/GN6y6SpMEaQEjdUudXtIHQz9kHa3e9ccMiCD941NJbEo
	aoCSUZMDQ1SrFZ7f8V6ZqFH5UgKu6sEGmfKGvnH/1osOdt66UuRY7dpSySA+/RtPScs=
X-Gm-Gg: ASbGnctNrd49maA6gOgYd62rVXQK+nda6/PY20cPKpLsDGzGrK72ZSGHcKUTAIx42HE
	/OO+jUE4hGtdL18Xt3QgZxiPPPi6ArwnXE8qwqPSClUz0M4lKKOqIz0mvkp1MW5O4Dla/zvyf3c
	Lm0lohZO8C0cYc0qKC9tNsjC8pEF7KWwjpPRhyWtKLP8it8xIMtfQL6Lu8tyyl8XdeLy+78K47Y
	FzPrwhRO395nbrfqc6yzwuZHoB8hJ21a2KUlrLT/5IGgD5b/DTxIUHM60afVcuxacp3+u13Y+MD
	Lm4f+uz/x9K17wp9zOI+66yvHWWR9vAYYq6E4xTSHF5kxDF3DZck0cSxefaKfXaadeQHXiA78Yl
	b+35c31qlYiajypYCSqq+1ACm1d4IcIB7rx/IA2xZHjxrXU8ob0uF4vmXnbpxBPmLy9yxIJfL7W
	yH1JsQqROaFa3Zk16EO40YqRoMWNMx8vdwJ0Ao9AkerRWx+ckpdIPh3IlZhfuvrhG7EMJbGaYqo
	4q5vtFKpVKnYyoIt+IgffkZgRvg
X-Google-Smtp-Source: AGHT+IFWtfn/rwb0uRX2ytbkbDVWqTIF3YPyxAkDs07DOZVyrx7OYhbfF/0z5jdi8HWYO/hxoXex8w==
X-Received: by 2002:a05:6e02:156c:b0:430:ad98:981f with SMTP id e9e14a558f8ab-430c524b96bmr336413695ab.4.1761247196608;
        Thu, 23 Oct 2025 12:19:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5abb4e4c156sm1217811173.2.2025.10.23.12.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:19:56 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:19:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPp/0/kU1LMBjt7g@nand.local>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
 <aPLC9FIDR8Y3ayn+@nand.local>
 <aPeD75W4FjtTZDYr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPeD75W4FjtTZDYr@pks.im>

On Tue, Oct 21, 2025 at 03:00:31PM +0200, Patrick Steinhardt wrote:
> > OK. To make sure I understand: this limit is the minimum number of loose
> > objects would cause the geometric-repack task to run, unless there are
> > pack(s) which would be combined as a result of running a geometric
> > repack, in which case we run it regardless.
> >
> > Is that right?
>
> Yeah, exactly. I was initially thinking to only frame this in the
> context of "how many packs would be merged"? But the problem with that
> is that we wouldn't ever generate _new_ packs if the repository only
> ever grows loose objects, and consequently we also wouldn't ever merge
> any of them.

Makes total sense, I like the direction that you picked here.

> > > @@ -1566,6 +1568,101 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
> > >  	return 0;
> > >  }
> > >
> > > +static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
> > > +					     struct gc_config *cfg)
> > > +{
> > > +	struct pack_geometry geometry = {
> > > +		.split_factor = 2,
> >
> > I wonder if this should be configurable somewhere. It might not be a bad
> > idea to introduce a 'repack.geometricSplitFactor' configuration
> > variable, defaulting to two, and use that here. It would also be nice to
> > be able to run 'git repack --geometric -d' and have it fallback to that
> > split factor, since using "2" is so common that it's frustrating when I
> > forget to type it out explicitly ;-).
>
> I was also pondering over this. I think the way to do so would be to
> introduce "maintenance.geometric-repack.splitFactor", as that follows
> all the other maintenance configuration we have there, as well.
>
> I decided to not do it yet as I wanted to keep the scope of this patch
> series contained. But honestly, it's an easy-enough change to make, so
> let me introduce another patch to do this.

I'm glad to have ~~nerd-sniped~~ convinced you that this was an
interesting addition ;-). Thanks for working on it.

> > > +static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
> > > +{
> > > +	struct pack_geometry geometry = {
> > > +		.split_factor = 2,
> > > +	};
> > > +	struct pack_objects_args po_args = {
> > > +		.local = 1,
> > > +	};
> > > +	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
> > > +	struct string_list kept_packs = STRING_LIST_INIT_DUP;
> > > +	int auto_value = 100;
> > > +	int ret;
> > > +
> > > +	repo_config_get_int(the_repository, "maintenance.geometric-repack.auto",
> > > +			    &auto_value);
> > > +	if (!auto_value)
> > > +		return 0;
> > > +	if (auto_value < 0)
> > > +		return 1;
> > > +
> > > +	existing_packs.repo = the_repository;
> > > +	existing_packs_collect(&existing_packs, &kept_packs);
> > > +	pack_geometry_init(&geometry, &existing_packs, &po_args);
> > > +	pack_geometry_split(&geometry);
> > > +
> > > +	/*
> > > +	 * When we'd merge at least two packs with one another we always
> > > +	 * perform the repack.
> > > +	 */
> > > +	if (geometry.split) {
> > > +		ret = 1;
> > > +		goto out;
> > > +	}
> >
> > Hmm. I wish that we could somehow pass this information to the function
> > above so that we don't have to re-discover the fact that there are packs
> > to combine. I'm not familiar enough with the maintenance code to know
> > how difficult that would be to do, but it looks like at least the
> > gc_config pointer is shared between the auto condition and the task
> > itself.
> >
> > That's kind of gross to tack on there, but I could see a compelling
> > argument for passing around an extra void pointer between the two that
> > would allow us to propagate this kind of data between the auto condition
> > and the task itself. It's not super expensive to do so I don't think not
> > doing it is a show-stopper at least from a performance perspective, but
> > it does seem like a good opportunity to DRY things up a bit.
>
> The problem is that the auto-condition is not evaluated when running
> without the "--auto" flag. We of course can conditionally compute the
> split in case we figure that the auto-condition didn't run, but it does
> get somewhat dirty.
>
> So I'd propose to defer such a change into the future in case we notice
> that this indeed is a problem. Is that fine with you?

Ah, makes sense, I definitely felt like I was missing something here.
I agree that punting on this feels like the right thing to do.

> > > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > > index ddd273d8dc2..83a373fe94b 100755
> > > --- a/t/t7900-maintenance.sh
> > > +++ b/t/t7900-maintenance.sh
> > > @@ -465,6 +465,143 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
> > >  	)
> > >  '
> > >
> > > +run_and_verify_geometric_pack () {
> > > +	EXPECTED_PACKS="$1" &&
> > > +
> > > +	# Verify that we perform a geometric repack.
> > > +	rm -f "trace2.txt" &&
> > > +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> > > +		git maintenance run --task=geometric-repack 2>/dev/null &&
> > > +	test_subcommand git repack -d -l --geometric=2 --quiet --write-midx <trace2.txt &&
> >
> > Makes sense. I do think the test_subcommand thing is a little fragile
> > here, but verifying that the resulting pack structure forms a geometric
> > progression feels like overkill for this test, so I think what you wrote
> > here makes sense.
>
> Oh, yeah, it's fragile and somewhat gross indeed. Couldn't really find a
> nicer way to do it though :/

Yeah, I don't think that there's a much better alternative. At some
level, we really just care that we ran a geometric repack, and that's
exactly what test_command is verifying. I think the fragility comes from
cases like:

 - You started (or stopped) passing an ancillary argument to the command
   in such a way that caused test_subcommand to no longer match, but the
   change in how we call the command internally is not meaningful to the
   test.

 - You stopped passing an argument (e.g., "--geometric=2") in a way that
   *looks* like it would have altered the behavior of the command, but
   actually doesn't, e.g., because you made the geometric factor of "2"
   the default, or otherwise specified via the config.

I think this is all just idle musing about test_subcommand in general,
and not useful to this immediate patch series.

> > > +
> > > +	# Verify that the number of packfiles matches our expectation.
> > > +	ls -l .git/objects/pack/*.pack >packfiles &&
> > > +	test_line_count = "$EXPECTED_PACKS" packfiles &&
> > > +
> > > +	# And verify that there are no loose objects anymore.
> > > +	cat >expect <<-\EOF &&
> > > +	info
> > > +	pack
> > > +	EOF
> > > +	ls .git/objects >actual &&
> >
> > I wonder if there is an easier way to check for loose objects here that
> > doesn't require you to know that the "info" and "pack" directories
> > exist. Perhaps something like:
> >
> > test_stdout_line_count = 0 find .git/objects/?? -type f
> >
> > , or even
> >
> >     find .git/objects/?? -type f >loose.objs &&
> >     test_must_be_empty loose.objs
>
> This doesn't work though in case there is not even a single sharding
> directory:
>
>     find: '.git/objects/??': No such file or directory
>
> I didn't really have any other idea for now to do this.

Mmm, good point. What about using 'git count-objects -v' directly?

    test_loose_object_nr() {
      local nr="$1" &&
      git count-objects -v >count &&
      grep '^count $nr$" count
    }

Thanks,
Taylor
