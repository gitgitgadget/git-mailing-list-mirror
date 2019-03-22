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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAB620248
	for <e@80x24.org>; Fri, 22 Mar 2019 11:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfCVLLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 07:11:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40218 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfCVLL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 07:11:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so1332212edw.7
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9LDcOlh/jeY32U61GR9t2lhxggniUMnY9R1htU/msMU=;
        b=UhsVwfWU7+vIE61RJqvQsr/k35o2Y9sD0uHuNerTQWHAclAXNdmaeAZ3/p/bnJgMdb
         nR5wmSnC5VvhOIaL1h9lvwaKWlZQEAjyly/eTuBdr/s9kXbKJMvzp1/suaR0/ntYcxQN
         8N0qb1ZonTq6mV4Ri4YfHHt1GsG3zxkYwzNNB8BFCS5+35Z5DlIsZBzVZrUtd8+QhvXO
         wjiMzpivWopNt9EyNp7mhBarpXq1gBwIENy0Qz0h9FKFvMo2rM8rQQHbbyIemf3nL5pq
         j/76DX2mzqPeahFCplbo/oPa4sx8Bx0rmiL21G+3zvjW4Dfi7EOlE/p2pa659q30WBxX
         IRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9LDcOlh/jeY32U61GR9t2lhxggniUMnY9R1htU/msMU=;
        b=InTSus1ZrVwRMyC6mScXak2Y/u0F5auD09xskgB+3BVjjPSIHN0vkGrJl7wASUXjOy
         BLpoew45rhNHLeHHZZl6dAzzDdWiO2LuluIz/WOuHpViSpVmiXIbt6VjVmvt/0My1uSy
         +Xyh9VX83/+767cEZ9EwNOLdoGQC2NeD03f+id6hr0lTGdoTQaIlbpiOseSaNmD3VcBr
         YMh7phW6woDtelnoHfo70/wYPcFLM2ALzrlRx77RnhF3fqGsr0DVeQUYlYmXqQSrrjKN
         e5Giyvwe8wFDm27vt8yVTu6a40q23bP12agWxfFyifTiXKdIWAjCyFyq5MDx2VoREDrj
         ZJXw==
X-Gm-Message-State: APjAAAXAer/UO7yAHEMOHBkkNFTF7Hfh+rApQ+DkrCk73RLTnfmTT4Ss
        6Z32lFX5Un73cbsvmUUCwfw=
X-Google-Smtp-Source: APXvYqxCgDmkAA32AuJ2E9WMZRI3uMlxF6YPLnyREXoVhmaZb3CSeUFaUR4QtOy0TLf7B31Ce/WISw==
X-Received: by 2002:a17:906:3005:: with SMTP id 5mr3974986ejz.103.1553253087873;
        Fri, 22 Mar 2019 04:11:27 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id i3sm1405816ejj.46.2019.03.22.04.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 04:11:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: don't show progress percentages while expanding reachable commits
References: <20190119202121.3590-11-avarab@gmail.com> <20190322102817.19708-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190322102817.19708-1-szeder.dev@gmail.com>
Date:   Fri, 22 Mar 2019 12:11:26 +0100
Message-ID: <87lg17cgf5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 22 2019, SZEDER G=C3=A1bor wrote:

> Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> progress, 2019-01-19) was a bit overeager when it added progress
> percentages to the "Expanding reachable commits in commit graph" phase
> as well, because most of the time the number of commits that phase has
> to iterate over is not known in advance and grows significantly, and,
> consequently, we end up with nonsensical numbers:
>
>   $ git commit-graph write --reachable
>   Expanding reachable commits in commit graph: 138606% (824706/595), done.
>   [...]
>
>   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
>   Expanding reachable commits in commit graph: 81264400% (812644/1), done.
>   [...]
>
> Therefore, don't show progress percentages in the "Expanding reachable
> commits in commit graph" phase.

There's indeed a bug here as your examples show, but there *are* cases
where it's correct, as the commit message for my patch on "master" shows
there's cases where we correctly.

So this "fixes" things by always removing the progress, why not instead
pass down the state to close_reachable() about what we're walking over,
so we can always show progress, or at least in some cases?

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 017225ccea..60c06ce58f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -672,13 +672,13 @@ static void close_reachable(struct packed_oid_list =
*oids, int report_progress)
>  	 * As this loop runs, oids->nr may grow, but not more
>  	 * than the number of missing commits in the reachable
>  	 * closure.
>  	 */
>  	if (report_progress)
>  		progress =3D start_delayed_progress(
> -			_("Expanding reachable commits in commit graph"), oids->nr);
> +			_("Expanding reachable commits in commit graph"), 0);
>  	for (i =3D 0; i < oids->nr; i++) {
>  		display_progress(progress, i + 1);
>  		commit =3D lookup_commit(the_repository, &oids->list[i]);
>
>  		if (commit && !parse_commit(commit))
>  			add_missing_parents(oids, commit);
