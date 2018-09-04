Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701551F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIEChK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:37:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42330 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeIEChK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:37:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so5481522wrr.9
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E5gw5GrtE2YpxIoQ6gOXMhjxXLtkeD53w8v5Z3wLBfw=;
        b=AePk7+1HmxVwNBDkCV49yjs2XD2WLyS4wOpXPNsy9v3ZpVc9F5ww9p7BaLDsWkUNeC
         C7sFJysaZXCvVDqP5xW0BgegvpXn4DSADObqMWVXCVAqdvH/6BkJifzSvuMA06ZjuxLQ
         E8UgzYANFsZz/67OFPnSNhYYG1YvRFlTLhy8W+odmxd8hdgQoYE5vysSOtRTwzdcLSQY
         rMf/H4zxET/KltDQ5zziPjGDB19ctQV1VD9DbdN8xlMhoCxMVWrjt7qR0I8xr1XS97sf
         TGVB9FkxBzC5YOKItAuIZQBNgZzIEq/7ElmuA2MHHvBb3h8NVtPkzCYeXv0MGxtYUg73
         Uc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E5gw5GrtE2YpxIoQ6gOXMhjxXLtkeD53w8v5Z3wLBfw=;
        b=Snb+Xbyddox+Yhu3MWdqQv+10Kz+pZlMyaEbybfOKSk42NjX+NEGpx3eRhu3P6hDwH
         0TMedZhmiPahak+H9ZFMCXAGeyVw3YLhNataLg2+38hR7fOjfIUO4lNoBgdh/rdTcZ1K
         rDvADtSOAQg/bRR5kweuL9P6NHnCbPTNly3ptVkcWk7S6Jx/VSEIZVbsTAw1MZPRhqCJ
         p4Rhf92YvcECrIqTthr9Xdh8xybk6MW4z6IBtSndilF5yHApIA8RgpsvSVNGk+CVNwvM
         gpOR7soKvgfx9PqMfBkLrxrwx7AmRfkpL1zabu31NHGvLUXlLH/eNjMsPamCqM4P9AlB
         fk6g==
X-Gm-Message-State: APzg51CHYxHVGWmDDAx5zU1+Be/KXeHVOnA5g/WD83sg4MuoOAYydWp7
        eRKltOEQkxioRvrajxX/G78=
X-Google-Smtp-Source: ANB0VdbY7vnIOEBFM+/13nAK06hKTDINrN6iuesKw8iE5IWm2UiE7bRdNxDA+wdGAT1UtW8L54yUGQ==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr4949774wrc.119.1536099002589;
        Tue, 04 Sep 2018 15:10:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f18-v6sm16627wrw.32.2018.09.04.15.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 15:10:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] commit-graph verify: add progress output
References: <20180904202729.13900-1-avarab@gmail.com>
        <20180904202729.13900-3-avarab@gmail.com>
Date:   Tue, 04 Sep 2018 15:10:01 -0700
In-Reply-To: <20180904202729.13900-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 4 Sep 2018 20:27:29 +0000")
Message-ID: <xmqqefe87w3q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> For the reasons explained in the "commit-graph write: add progress
> output" commit leading up to this one, emit progress on "commit-graph
> verify". Since e0fd51e1d7 ("fsck: verify commit-graph", 2018-06-27)
> "git fsck" has called this command if core.commitGraph=true, but
> there's been no progress output to indicate that anything was
> different. Now there is (on my tiny dotfiles.git repository):
>
>     $ git -c core.commitGraph=true -C ~/ fsck
>     Checking object directories: 100% (256/256), done.
>     Checking objects: 100% (2821/2821), done.
>     dangling blob 5b8bbdb9b788ed90459f505b0934619c17cc605b
>     Verifying commits in commit graph: 100% (867/867), done.
>
> And on a larger repository, such as the 2015-04-03-1M-git.git test
> repository:
>
>     $ time git -c core.commitGraph=true -C ~/g/2015-04-03-1M-git/ commit-graph verify
>     Verifying commits in commit graph: 100% (1000447/1000447), done.
>     real    0m7.813s
>     [...]
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  commit-graph.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Yup.  The verification side knows the total number of things, so it
is much easier to give the percentage progress with a very simple
addition like this, which is very nice.



>
> diff --git a/commit-graph.c b/commit-graph.c
> index 74889dc90a..1a02fe019a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -914,6 +914,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
>  	int generation_zero = 0;
>  	struct hashfile *f;
>  	int devnull;
> +	struct progress *progress = NULL;
>  
>  	if (!g) {
>  		graph_report("no commit-graph file loaded");
> @@ -981,11 +982,14 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
>  	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>  		return verify_commit_graph_error;
>  
> +	progress = start_progress("Verifying commits in commit graph",
> +				  g->num_commits);
>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
>  		struct commit_list *graph_parents, *odb_parents;
>  		uint32_t max_generation = 0;
>  
> +		display_progress(progress, i);
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>  
>  		graph_commit = lookup_commit(r, &cur_oid);
> @@ -1062,6 +1066,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
>  				     graph_commit->date,
>  				     odb_commit->date);
>  	}
> +	display_progress(progress, i);
> +	stop_progress(&progress);
>  
>  	return verify_commit_graph_error;
>  }
