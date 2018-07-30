Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF471F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeG3Wxb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:53:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43520 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbeG3Wxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:53:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so14339785wrv.10
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CK4U97NAGcYYhuEWFAW84N8rp2/VnCQdi7VOyIUCGVY=;
        b=NQBdHcHuL99pjfNfZM+xUtVYfkWjfW5sa7NNMN4MLElKX3CN1kXCjH/j3+UsoGvokm
         +Co3IKj9Jf5fNtLmm/DNGK8NeoO4A5+I7Ocny30FejVADwnGfIX08FHw3XK5pbhvi/i3
         128UfWJHhBlcCVIX+d3omBGPoDWDJO1fy7XAeM6I37HBAGkU5x7hc6osCU1q+jaaNgJC
         XRWOSdlu7eEmLrL2eDm8X12xYoF63jr5Tfl0dHupHAFcE0+ABzWd8APJVMKjQxts3AcN
         eYhq/TTEwPA9cPkGUU+wgrdcLJhWIJ0H+SqzXIFbV5JPI6MnhbY/kbKiPcjRKUET8vcf
         MA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CK4U97NAGcYYhuEWFAW84N8rp2/VnCQdi7VOyIUCGVY=;
        b=UrKLXriCNZwCQiVYGMFxjbWQ9z2EnuuW4ERQg/LG7vTz+SvjGJKGnXcJ1wH9Ecg9fc
         P4SSDVQw4tKDF+vchwi3vdo/+Bnx2X4DyZdCzh1gfYTjE/VMwcyNtequI/TnNT8XFGwz
         hLQ2tbyYPSJu+S+gB2kfV8mTE7uWG2rrzRp6Fmb/pnurjvHyBEcz9HL7nKQDRDOmccjA
         cu5PcisMtTf8cFcx6/ba8L/mRALhUtBNNtElPjM2gF+rBL2D5ykHhAEkGVUUE/ymfi5Z
         75H6uc05HoizAQd1P+ujkOxWY02LlkZbB7Uiqs+yUcslgWoh10s799LkDmz3WWkpPCGM
         yYwQ==
X-Gm-Message-State: AOUpUlGgUMTgnCkYccIq6ki3Wd/VawcTly2DW7oluLxlvt4DiN5WaBUf
        b94gpXzhH+cMiPgykLSZNws=
X-Google-Smtp-Source: AAOMgpe8azDjPB/vUAiJYVtZDP5t4arYcgwj0xsDOZMv3lzAffK+PX2Z7RMrrN7G/Fo/Ex9R86C1WA==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr19841047wrg.249.1532985397722;
        Mon, 30 Jul 2018 14:16:37 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 185-v6sm895559wmy.38.2018.07.30.14.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 14:16:36 -0700 (PDT)
Date:   Mon, 30 Jul 2018 22:16:36 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/21] range-diff: first rudimentary implementation
Message-ID: <20180730211636.GK9955@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <4e3fb47a1dcef96780bd536032b81dd99387f2db.1532210683.git.gitgitgadget@gmail.com>
 <20180729183629.GC2734@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1807301759340.10478@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807301759340.10478@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Sun, 29 Jul 2018, Thomas Gummerer wrote:
> 
> > On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > > 
> > > [...]
> > > 
> > > +static void find_exact_matches(struct string_list *a, struct string_list *b)
> > > +{
> > > +	struct hashmap map;
> > > +	int i;
> > > +
> > > +	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
> > > +
> > > +	/* First, add the patches of a to a hash map */
> > > +	for (i = 0; i < a->nr; i++) {
> > > +		struct patch_util *util = a->items[i].util;
> > > +
> > > +		util->i = i;
> > > +		util->patch = a->items[i].string;
> > > +		util->diff = util->patch + util->diff_offset;
> > > +		hashmap_entry_init(util, strhash(util->diff));
> > > +		hashmap_add(&map, util);
> > > +	}
> > > +
> > > +	/* Now try to find exact matches in b */
> > > +	for (i = 0; i < b->nr; i++) {
> > > +		struct patch_util *util = b->items[i].util, *other;
> > > +
> > > +		util->i = i;
> > > +		util->patch = b->items[i].string;
> > > +		util->diff = util->patch + util->diff_offset;
> > > +		hashmap_entry_init(util, strhash(util->diff));
> > > +		other = hashmap_remove(&map, util, NULL);
> > > +		if (other) {
> > > +			if (other->matching >= 0)
> > > +				BUG("already assigned!");
> > > +
> > > +			other->matching = i;
> > > +			util->matching = other->i;
> > > +		}
> > > +	}
> > 
> > One possibly interesting corner case here is what happens when there
> > are two patches that have the exact same diff, for example in the
> > pathological case of commit A doing something, commit B reverting
> > commit A, and then commit C reverting commit B, so it ends up with the
> > same diff.
> > 
> > Having those same commits unchanged in both ranges (e.g. if a commit
> > earlier in the range has been changed, and range B has been rebased on
> > top of that), we'd get the following mapping from range A to range B
> > for the commits in question:
> > 
> > A -> C
> > B -> B
> > C -> A
> > 
> > Which is not quite what I would expect as the user (even though it is
> > a valid mapping, and it probably doesn't matter too much for the end
> > result of the range diff, as nothing has changed between the commits
> > anyway).  So I'm not sure it's worth fixing this, as it is a
> > pathological case, and nothing really breaks.
> 
> Indeed. As far as I am concerned, this falls squarely into the "let's
> cross that bridge when, or if, we reach it" category.

Makes sense, this can definitely be addressed later.

> > > +
> > > +	hashmap_free(&map, 0);
> > > +}
> > > +
> > > +static void diffsize_consume(void *data, char *line, unsigned long len)
> > > +{
> > > +	(*(int *)data)++;
> > > +}
> > > +
> > > +static int diffsize(const char *a, const char *b)
> > > +{
> > > +	xpparam_t pp = { 0 };
> > > +	xdemitconf_t cfg = { 0 };
> > > +	mmfile_t mf1, mf2;
> > > +	int count = 0;
> > > +
> > > +	mf1.ptr = (char *)a;
> > > +	mf1.size = strlen(a);
> > > +	mf2.ptr = (char *)b;
> > > +	mf2.size = strlen(b);
> > > +
> > > +	cfg.ctxlen = 3;
> > > +	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
> > > +		return count;
> > > +
> > > +	error(_("failed to generate diff"));
> > > +	return COST_MAX;
> > > +}
> > > +
> > > +static void get_correspondences(struct string_list *a, struct string_list *b,
> > > +				int creation_factor)
> > > +{
> > > +	int n = a->nr + b->nr;
> > > +	int *cost, c, *a2b, *b2a;
> > > +	int i, j;
> > > +
> > > +	ALLOC_ARRAY(cost, st_mult(n, n));
> > > +	ALLOC_ARRAY(a2b, n);
> > > +	ALLOC_ARRAY(b2a, n);
> > > +
> > > +	for (i = 0; i < a->nr; i++) {
> > > +		struct patch_util *a_util = a->items[i].util;
> > > +
> > > +		for (j = 0; j < b->nr; j++) {
> > > +			struct patch_util *b_util = b->items[j].util;
> > > +
> > > +			if (a_util->matching == j)
> > > +				c = 0;
> > > +			else if (a_util->matching < 0 && b_util->matching < 0)
> > > +				c = diffsize(a_util->diff, b_util->diff);
> > > +			else
> > > +				c = COST_MAX;
> > > +			cost[i + n * j] = c;
> > > +		}
> > > +
> > > +		c = a_util->matching < 0 ?
> > > +			a_util->diffsize * creation_factor / 100 : COST_MAX;
> > > +		for (j = b->nr; j < n; j++)
> > > +			cost[i + n * j] = c;
> > > +	}
> > > +
> > > +	for (j = 0; j < b->nr; j++) {
> > > +		struct patch_util *util = b->items[j].util;
> > > +
> > > +		c = util->matching < 0 ?
> > > +			util->diffsize * creation_factor / 100 : COST_MAX;
> > > +		for (i = a->nr; i < n; i++)
> > > +			cost[i + n * j] = c;
> > > +	}
> > > +
> > > +	for (i = a->nr; i < n; i++)
> > > +		for (j = b->nr; j < n; j++)
> > > +			cost[i + n * j] = 0;
> > > +
> > > +	compute_assignment(n, n, cost, a2b, b2a);
> > > +
> > > +	for (i = 0; i < a->nr; i++)
> > > +		if (a2b[i] >= 0 && a2b[i] < b->nr) {
> > > +			struct patch_util *a_util = a->items[i].util;
> > > +			struct patch_util *b_util = b->items[a2b[i]].util;
> > > +
> > > +			a_util->matching = a2b[i];
> > > +			b_util->matching = i;
> > 
> > So here we re-assign 'matching' in the struct regardless of whether it
> > was assigned before while searching for exact matches or not.
> 
> If `matching` were assigned here, it would indicate a bug in the code, I
> think. Before this loop, all of the `matching` fields should be `NULL`,
> and the `compute_assignment()` function is expected to populate `a2b` and
> `b2a` appropriately, i.e. no "double booking".

Hmm we are using the 'matching' fields in the loops above, e.g.:

	if (a_util->matching == j)
		c = 0;

They're also ints, so they can't be `NULL`, right?  So what I was
thinking is that we could do

	 if (a_util->matching < 0) {
		a_util->matching = a2b[i];
		b_util->matching = i;
	}

Anyway, I don't think it really matters, as there is no "double
booking", so we should essentially get the same results.

> > Shouldn't diffsize for matching patches also be 0?  So are we doing
> > the 'find_exact_matches()' bit only as an optimization, or am I
> > missing some other reason why that is beneficial?
> 
> An optimization.
> 
> Remember, the linear assignment algorithm runs in O(n^3). That's not a
> laughing matter by any stretch of imagination. The more stuff we can get
> out of the way, as quickly as possible, the less it hurts to have a cubic
> runtime complexity.

Makes sense, that's what I was expecting, just wanted to double check
that I didn't miss something.  Thanks for confirming!

> > > +		}
> > > +
> > > +	free(cost);
> > > +	free(a2b);
> > > +	free(b2a);
> > > +}
> > > +
> > > +static const char *short_oid(struct patch_util *util)
> > > +{
> > > +	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> > > +}
> > > +
> > > +static void output(struct string_list *a, struct string_list *b)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < b->nr; i++) {
> > > +		struct patch_util *util = b->items[i].util, *prev;
> > > +
> > > +		if (util->matching < 0)
> > > +			printf("-: -------- > %d: %s\n",
> > > +					i + 1, short_oid(util));
> > > +		else {
> > > +			prev = a->items[util->matching].util;
> > > +			printf("%d: %s ! %d: %s\n",
> > > +			       util->matching + 1, short_oid(prev),
> > > +			       i + 1, short_oid(util));
> > > +		}
> > > +	}
> > > +
> > > +	for (i = 0; i < a->nr; i++) {
> > > +		struct patch_util *util = a->items[i].util;
> > > +
> > > +		if (util->matching < 0)
> > > +			printf("%d: %s < -: --------\n",
> > > +			       i + 1, short_oid(util));
> > > +	}
> > > +}
> > > +
> > > +int show_range_diff(const char *range1, const char *range2,
> > > +		    int creation_factor)
> > > +{
> > > +	int res = 0;
> > > +
> > > +	struct string_list branch1 = STRING_LIST_INIT_DUP;
> > > +	struct string_list branch2 = STRING_LIST_INIT_DUP;
> > > +
> > > +	if (read_patches(range1, &branch1))
> > > +		res = error(_("could not parse log for '%s'"), range1);
> > > +	if (!res && read_patches(range2, &branch2))
> > > +		res = error(_("could not parse log for '%s'"), range2);
> > > +
> > > +	if (!res) {
> > > +		find_exact_matches(&branch1, &branch2);
> > 
> > Note to self: here we assign the matching member of struct patch_util
> > for each patch in both ranges to a patch number in the other range if
> > it is an exact match.
> > 
> > We also assign the patch and diff members, and number the patches
> > using the 'i' member of struct patch_util.  Let's see if that
> > numbering is still useful later.
> > 
> > > +		get_correspondences(&branch1, &branch2, creation_factor);
> > 
> > And here we use the linear assignment algorithm to match the rest of
> > the commits.
> > 
> > > +		output(&branch1, &branch2);
> > 
> > And finally we print the output.  We don't seem to use the util->i
> > that's assigned for range b (or range 2) anywhere at the moment, which
> > I was wondering about earlier, so I assume it's there mainly for
> > symmetry, but it doesn't really hurt other than me wondering what it
> > was for.
> 
> It's there because it would require extra care to do it only for one side.
> 
> > > +	}
> > > +
> > > +	string_list_clear(&branch1, 1);
> > > +	string_list_clear(&branch2, 1);
> > > +
> > > +	return res;
> > > +}
> > > diff --git a/range-diff.h b/range-diff.h
> > > new file mode 100644
> > > index 000000000..dd30449c4
> > > --- /dev/null
> > > +++ b/range-diff.h
> > > @@ -0,0 +1,7 @@
> > > +#ifndef BRANCH_DIFF_H
> > > +#define BRANCH_DIFF_H
> > 
> > s/BRANCH/RANGE/ above?
> 
> Good eyes.
> 
> Thank you for your review. It is nice to see that you can follow the code
> and come to the same conclusions as I. Can I always have you as reviewer?

Glad I could help.  Can I have more hours in a day? ;) I wish I had
more time for reviewing code, but sadly the time I have is limited.
Which is why I only got to review this now as well.  I did enjoy the
read!

> Ciao,
> Dscho
> 
> > > +int show_range_diff(const char *range1, const char *range2,
> > > +		    int creation_factor);
> > > +
> > > +#endif
> > > -- 
> > > gitgitgadget
> > > 
> > 
