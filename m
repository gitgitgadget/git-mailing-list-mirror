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
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D281F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeJKEBf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:01:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39033 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJKEBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:01:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so6183547edq.6
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jVADrSkaLRJwgGCWL74wlody7TBmWlePxFRw29pChW4=;
        b=gesxwiKSdvFdXySZu/g0THk81X10PlKY8aNlLd6FrqKXlW6hhnLHwuOr7A7nfxm8yi
         WMjEcgEn2mX2XxZxp96sfIpEsAHYpjv8qtoY0F9UDPGrkjsVWUJBjANr33MarKd/91xG
         S+rl85LXFf6Oo2G6lZfmvnRcvsfi0RgnZNXCS2jSG9YjVxWOiLSXklegOm+KYEvdjLvd
         9y4M3FOV20uQ3A0o1gQe1gRiV4vTjj1uLmSEF3/Q/E9vYF6SMQ2MRIZ16GsTXIO9RaPm
         LlQPg6wB6FMr8+X86vSEzGsFZqSvtO5rI3bBw43suOwHT4KcWizY4somdPdeIaDiVWtO
         HVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jVADrSkaLRJwgGCWL74wlody7TBmWlePxFRw29pChW4=;
        b=jZw4wOhm8dGoGFBCu1hpBNUr8hOGgLWpEkjuLC9TRNHQl3nkt4hn/rlhCpzHUxmjuo
         ZUlO7HlYUdH9KycxX42IOawuxMZ4u1qPbAbcE7lNIcoJzrlqQJjAhTgSXArXYw97kw5Z
         vSmDrXrpBW3YqcEkTYehAyaIYB4erh31bwemfHO/JSDW90HfWmRTZBUcbiQRCXPdKGBA
         2dc69jCqJsRiEGzs8iyJSpELIGcq9nbBYCTaoWoRDFYdDJWDrDGTUtbT9IZP/6+hJA7g
         Upkn0Xqzmgbds6O6QTi57nCKhorLqkkadEojmnkA3YZkogeyyEQFPgdFasjunY+ZSSCo
         AO8w==
X-Gm-Message-State: ABuFfogE3FhT8ILq/2+GGA8MLThVl9zZxn2sSk8plF1N9asFTSBrPNsV
        aSqv4nRMDSC4zpXYEFFJc1g=
X-Google-Smtp-Source: ACcGV61BOFeIsVTIYAM4b3GH3fSzTpgyRQDDOFsOiNbfbNkDkIXuT3mbhrSCmek0aykILaccoAlKaQ==
X-Received: by 2002:a17:906:5f8b:: with SMTP id a11-v6mr29084791eju.10.1539203862640;
        Wed, 10 Oct 2018 13:37:42 -0700 (PDT)
Received: from szeder.dev (x4db070c3.dyn.telefonica.de. [77.176.112.195])
        by smtp.gmail.com with ESMTPSA id v3-v6sm4363605ejq.40.2018.10.10.13.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:37:41 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:37:38 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
Message-ID: <20181010203738.GE23446@szeder.dev>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
 <20180917153336.2280-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917153336.2280-2-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 03:33:35PM +0000, Ævar Arnfjörð Bjarmason wrote:
>     $ git -c gc.writeCommitGraph=true gc
>     [...]
>     Annotating commits in commit graph: 1565573, done.
>     Computing commit graph generation numbers: 100% (782484/782484), done.

While poking around 'commit-graph.c' in my Bloom filter experiment, I
saw similar numbers like above, and was confused by the much higher
than expected number of annotated commits.  It's about twice as much
as the number of commits in the repository, or the number shown on the
very next line.

> diff --git a/commit-graph.c b/commit-graph.c
> index 8a1bec7b8a..2c5d996194 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> -static void close_reachable(struct packed_oid_list *oids)
> +static void close_reachable(struct packed_oid_list *oids, int report_progress)
>  {
>  	int i;
>  	struct commit *commit;
> +	struct progress *progress = NULL;
> +	int j = 0;
>  
> +	if (report_progress)
> +		progress = start_delayed_progress(
> +			_("Annotating commits in commit graph"), 0);
>  	for (i = 0; i < oids->nr; i++) {
> +		display_progress(progress, ++j);
>  		commit = lookup_commit(the_repository, &oids->list[i]);
>  		if (commit)
>  			commit->object.flags |= UNINTERESTING;
> @@ -604,6 +616,7 @@ static void close_reachable(struct packed_oid_list *oids)
>  	 * closure.
>  	 */
>  	for (i = 0; i < oids->nr; i++) {
> +		display_progress(progress, ++j);
>  		commit = lookup_commit(the_repository, &oids->list[i]);
>  
>  		if (commit && !parse_commit(commit))
> @@ -611,19 +624,28 @@ static void close_reachable(struct packed_oid_list *oids)
>  	}

The above loops have already counted all the commits, and, more
importantly, did all the hard work that takes time and makes the
progress indicator useful.

>  	for (i = 0; i < oids->nr; i++) {
> +		display_progress(progress, ++j);

This display_progress() call, however, doesn't seem to be necessary.
First, it counts all commits for a second time, resulting in the ~2x
difference compared to the actual number of commits, and then causing
my confusion.  Second, all what this loop is doing is setting a flag
in commits that were already looked up and parsed in the above loops.
IOW this loop is very fast, and the progress indicator jumps from
~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
progress indicator at all.

>  		commit = lookup_commit(the_repository, &oids->list[i]);
>  
>  		if (commit)
>  			commit->object.flags &= ~UNINTERESTING;
>  	}
> +	stop_progress(&progress);
>  }
