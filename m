Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FF71F461
	for <e@80x24.org>; Sat,  7 Sep 2019 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391629AbfIGS4i (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 14:56:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42574 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIGS4i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 14:56:38 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so20175244iod.9
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QtFt2HsOxyVy4i6IN6epAuTkb6jWhv0tla72LSk7AMY=;
        b=hVY/NNZY813hCMEXX2BvKM8qXoV1JmJvMlfLX+3wOkGQTFlYU3/wB3ioaN77zk5UHm
         9P2mgT0IF+gS6vhfsiAzvNcPyHdeXxR1Q3vW3XopCT4xbmvoa4w/WasRTZ0EJaiiTxBL
         E63bp7QJx3Z+hZiEzz16N3o3YEt0GTb6k5l7derY+QCSwXXD83H8fVqPNa8RBZKaQ+Qz
         zCozNSLuQLvU2YI+FWO7xwzBhEHYxL2La8wNMLX5xR/OX1lGh2IDihld5gxvJszHcWz4
         bN7jaetM4SFyq4MVt42+2iAWoMaqg1H5vOb08J7oRz67K94WYhcevoJcVwvkOxOrOm/q
         6QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QtFt2HsOxyVy4i6IN6epAuTkb6jWhv0tla72LSk7AMY=;
        b=ItCr8GzfTBRxscCt4UxyHcjGSeeIyaEssYNeZKJKhXtnf3jZtVWNfJ5YIPICAovaU3
         zUb470MDzM5cJSloDOL18XxNSIV7LaG4G2goG47q9OkHaqwV4EtSND7ONdqmnwGH1LZU
         YixFYLoxRxhODpkSl0a7onewxh5WN/M0qB51R/lsqCdD0etd3R6O+MEzkK6087QDj0w7
         NCrTczrssSGKNZf/tnBYiqBG5wfjXaEZbpUiwv23v7yqeviA1+fNMiGqyI07H8FzXqiR
         o/3bW/GOcjXCnJc2Es0zhOSlqkD+4i7K653Maig8TfS7wTXN6/3kHWFR4X8hJ1yv9CdF
         99+A==
X-Gm-Message-State: APjAAAVB4PoQVL1h1NEKZkeRq8Jj0vUaG1t3Ozwn0fDTq7ay9EZX9XRz
        GPC1TGSTIyiCpi6BKH0RQxNh9g==
X-Google-Smtp-Source: APXvYqySkCcLsYPx0tZRDjCHwnxuApj2+7d1FkfxyMiekT+oZmP0BT6OIO2KwO9EIV+kJRmlCzOgVA==
X-Received: by 2002:a5d:9bda:: with SMTP id d26mr7413084ion.88.1567882597790;
        Sat, 07 Sep 2019 11:56:37 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id p20sm15925353iod.43.2019.09.07.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 11:56:37 -0700 (PDT)
Date:   Sat, 7 Sep 2019 14:56:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] commit-graph: turn off save_commit_buffer
Message-ID: <20190907185636.GB32028@syl.local>
References: <20190907045848.GA24515@sigill.intra.peff.net>
 <20190907050439.GB23904@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907050439.GB23904@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 01:04:40AM -0400, Jeff King wrote:
> The commit-graph tool may read a lot of commits, but it only cares about
> parsing their metadata (parents, trees, etc) and doesn't ever show the
> messages to the user. And so it should not need save_commit_buffer,
> which is meant for holding onto the object data of parsed commits so
> that we can show them later. In fact, it's quite harmful to do so.
> According to massif, the max heap of "git commit-graph write
> --reachable" in linux.git before/after this patch (removing the commit
> graph file in between) goes from ~1.1GB to ~270MB.
>
> Which isn't surprising, since the difference is about the sum of the
> uncompressed sizes of all commits in the repository, and this was
> equivalent to leaking them.
>
> This obviously helps if you're under memory pressure, but even without
> it, things go faster. My before/after times for that command (without
> massif) went from 12.521s to 11.874s, a speedup of ~5%.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We didn't actually notice this on linux.git, but rather on a repository
> with 130 million commits (don't ask). With this patch, I was able to
> generate the commit-graph file with a peak heap of ~25GB, which is ~200
> bytes per commit.
>
> I'll bet we could do better with some effort, but obviously this case
> was just pathological. For most cases this should be cheaper than a
> normal repack (which probably spends that much memory on each object,
> not just commits).
>
>  builtin/commit-graph.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 57863619b7..052696f1af 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -251,6 +251,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			     builtin_commit_graph_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>
> +	save_commit_buffer = 0;
> +

This looks exactly right to me. We had discussed a little bit off-list
about where you might place this line, but I think that the spot you
picked is perfect: as late as possible.

Thankfully, the option parsing code here doesn't load any commits
(though even if it did, I don't think that turning on/off
'save_commit_buffer' would really make much of a difference).

So, the patch here looks obviously correct, and I don't think it needs a
test or anything like that... besides: what is there to test? :).

>  	if (argc > 0) {
>  		if (!strcmp(argv[0], "read"))
>  			return graph_read(argc, argv);
> --
> 2.23.0.474.gb1abd76f7a

Thanks,
Taylor
