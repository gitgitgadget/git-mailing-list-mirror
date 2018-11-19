Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B7D1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeKTJXV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 04:23:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731164AbeKTJXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 04:23:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so33768801wrr.0
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8P4VqtzQUPGggA5RRh9VcBk0va0xKzvZBaFRn5ACrsQ=;
        b=n30eMTDIepSB62WbJwLzhvxSzgXZgwmsLs/a+IWJ94znq3iuR2y4YLvBrEv9z/L7GY
         hFFoLAX2/qKqmyDIIx/WqaTZNAPJoGcrv34HKqdmu58Jo06m8NDh7fw6ft8dzLwr12ai
         cPdk1e8r/7HXwTCdI18eYnMCZCqlLpJzBqLTc6ePZHUo6GJytXBMYm5akahtOxiYRpck
         wiPUVZ+IY6yE5iLxsRqmWu1loGncc64BqszzCpZo2yFZllu3ag/aF+iKZ3yS3QZ2Nlwa
         kRrYzUec5zjoU8rHmHf0BZY26ZgJnKXK23LyAZvO0GcTEUHKniuxI1u+Zqy4N8ivqk1o
         wSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8P4VqtzQUPGggA5RRh9VcBk0va0xKzvZBaFRn5ACrsQ=;
        b=QRpCC0vaU0ZhdqB12OzwP95yXFZCmRCssnJMuRBZK2ycytNl8r7CuLjyFpNHIc+AYT
         DFSSWnFlTuRTN6v9hM9dK34g1+wxr/AuQzpOIlN4SK8v6e7taFIUEh0+thhc/7ejrPNi
         VaCMMS3+WtcOFae6giCdimNYIG5UZlGj0q8ikb8aNe6bg6Ut3ZhQTA70akadhqGkbPdQ
         LMvTRTF8bPLmXDMfdcvfkzmKBW7jbzJHmsXHsd9IjpASZM8mvGgO/j5oNJShQ52Y5NQF
         TFLRTs2lKq9/n8KGVo2E92tZDOTCIRj6ify7K3jCcAQEfnMAdYXRCwZyV7zgMVXW/KvO
         /djw==
X-Gm-Message-State: AGRZ1gKuRNVZVeWZSbyhNFg6mC2wwagCRqXQ0qcE/2Fb7fjiRTYraELE
        QHWI7htXCUFz3T9Amqf+AEw=
X-Google-Smtp-Source: AJdET5efeOy73cIEqLV0/VJgWJbu3zRN/ibpJKPhiS6lg3GPwC9kMblND8elhu9S69Gdw7OHYZPcuw==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14-v6mr20874179wrt.326.1542668244186;
        Mon, 19 Nov 2018 14:57:24 -0800 (PST)
Received: from szeder.dev (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id q9sm24433303wrp.0.2018.11.19.14.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:57:23 -0800 (PST)
Date:   Mon, 19 Nov 2018 23:57:20 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] commit-graph: split up close_reachable() progress output
Message-ID: <20181119225720.GV30222@szeder.dev>
References: <20181119160207.GU30222@szeder.dev>
 <20181119202300.18670-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119202300.18670-1-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 08:23:00PM +0000, Ævar Arnfjörð Bjarmason wrote:
> Amend the progress output added in 7b0f229222 ("commit-graph write:
> add progress output", 2018-09-17) so that the total numbers it reports
> aren't higher than the total number of commits anymore. See [1] for a
> bug report pointing that out.

Please make the commit message more self-contained, i.e. describe the
issue this patch fixes in more detail, so readers won't have to follow
links to understand the problem.

> When I added this I wasn't intending to provide an accurate count, but
> just have some progress output to show the user the command wasn't
> hanging[2]. But since we are showing numbers, let's make them
> accurate. The progress descriptions were suggested by Derrick Stolee
> in [3].
> 
> As noted in [2] we are unlikely to show anything except the "Expanding
> reachable..." message even on fairly large repositories such as
> linux.git. On a test repository I have with north of 7 million commits
> all of these are displayed. Two of them don't show up for long, but as
> noted in [5] future-proofing this for if the loops become more
> expensive in the future makes sense.

In my opinion this is rather one of those "we'll cross that bridge
when (or if ever) we get there" situations.

> 1. https://public-inbox.org/git/20181010203738.GE23446@szeder.dev/
> 2. https://public-inbox.org/git/87pnwhea8y.fsf@evledraar.gmail.com/
> 3. https://public-inbox.org/git/f7a0cbee-863c-61d3-4959-5cec8b43c705@gmail.com/
> 4. https://public-inbox.org/git/20181015160545.GG19800@szeder.dev/
> 5. https://public-inbox.org/git/87murle8da.fsf@evledraar.gmail.com/
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Mon, Nov 19 2018, SZEDER Gábor wrote:
> 
> > Ping?
> >
> > We are at -rc0, this progress output is a new feature since v2.19.0,
> > and the numbers shown are still way off.
> 
> I was under the impression after your
> https://public-inbox.org/git/20181015160545.GG19800@szeder.dev/ that
> you were going to do some more digging & report back, so I put it on
> my "waiting for feedback" list and then forgot about it.

No, after I managed to "get my numbers straight" I sent another bug
report in

  https://public-inbox.org/git/20181015165447.GH19800@szeder.dev/

but as a reply to your original patch.  Sorry about the confusion.

> But here's a patch that should address the issue you pointed out, but
> I don't know if it fixes whatever you were alluding to in the linked
> E-Mail above.

I'm afraid this patch doesn't address that issue, as it's limited to
close_reachable(), and that issue is related to the progress output in
add_packed_commits().

>  commit-graph.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 40c855f185..9c0d6914be 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -641,26 +641,29 @@ static void add_missing_parents(struct packed_oid_list *oids, struct commit *com
>  
>  static void close_reachable(struct packed_oid_list *oids, int report_progress)
>  {
> -	int i;
> +	int i, j;
>  	struct commit *commit;
>  	struct progress *progress = NULL;
> -	int j = 0;
>  
>  	if (report_progress)
>  		progress = start_delayed_progress(
> -			_("Annotating commits in commit graph"), 0);
> +			_("Loading known commits in commit graph"), j = 0);
>  	for (i = 0; i < oids->nr; i++) {
>  		display_progress(progress, ++j);
>  		commit = lookup_commit(the_repository, &oids->list[i]);
>  		if (commit)
>  			commit->object.flags |= UNINTERESTING;
>  	}
> +	stop_progress(&progress);
>  
>  	/*
>  	 * As this loop runs, oids->nr may grow, but not more
>  	 * than the number of missing commits in the reachable
>  	 * closure.
>  	 */
> +	if (report_progress)
> +		progress = start_delayed_progress(
> +			_("Expanding reachable commits in commit graph"), j = 0);
>  	for (i = 0; i < oids->nr; i++) {
>  		display_progress(progress, ++j);
>  		commit = lookup_commit(the_repository, &oids->list[i]);
> @@ -668,7 +671,11 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
>  		if (commit && !parse_commit(commit))
>  			add_missing_parents(oids, commit);
>  	}
> +	stop_progress(&progress);
>  
> +	if (report_progress)
> +		progress = start_delayed_progress(
> +			_("Clearing commit marks in commit graph"), j = 0);
>  	for (i = 0; i < oids->nr; i++) {
>  		display_progress(progress, ++j);
>  		commit = lookup_commit(the_repository, &oids->list[i]);
> -- 
> 2.19.1.1182.g4ecb1133ce
> 
