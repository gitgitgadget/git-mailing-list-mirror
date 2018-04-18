Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCB31F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDRWPK (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:15:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44153 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRWPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:15:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id o15-v6so8764303wro.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sntkFv9Hd0kOXSCYUp/r7LbrU19xPGUPhNxwqFIyk1Q=;
        b=BkEVSZXJ74jxMBfGF0M3iZyCHwfFzWAc7XW9NaV97qC14OiZOW8Q8Wuz12jyYND1Ai
         coXTIixaTIPjYo4Yv8rR64jQAhoLxOrWfhpHTE53O+Y8lu62tjEEvozeoy/sLpXuTOnP
         gUinsaNjjsX6u4NURo8FQPOZ0kywjT+efEqmjQPLeXX7LAWxM4Ge+w5zKMkqUULo5LRJ
         NSuduiDUc2lpEyRhGCXsoYIgPxRSF7JmYnDiZ1A+PdiDH1dl5cBtne7nVOwjZikptd+6
         2O1twCcSql/j8dSCkvjgr/WblfXN/vaCH0fPgBD1KA2QvRv5+Rj/T7JYJX1CrBPWLEV0
         kkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=sntkFv9Hd0kOXSCYUp/r7LbrU19xPGUPhNxwqFIyk1Q=;
        b=Ar/KU2FFaniQHZ3gB8uVRMx9incakQWhz9jJJzTOxCSlKh0JVij5CIf2xV+DuDuiMg
         udauPCWiJ7C1QR2dVTgzniHfRru0l70idP9an3caiNXSnLn+pKdKNjpU9frbsLEk2iIN
         fn7yqSLK0N1m41WCXnga1De+CLUUWPNzbUxN1qbOtx+TEei2j868aX+WSHjTRMOXT6eO
         /MkKC/6KprMWOUrA5inldWeiyKb3j/AOoS07XfbfrIVRgCEgcJTphnfa+v5fUNU1XktH
         sT/Wz1VBBjGxhFemjWZCfLW+IC+88pgwtq2ZCuBJxJ3ekXv7P5MIPouW2vVBFoCTFru8
         hB5w==
X-Gm-Message-State: ALQs6tApSk5uB+Cf3CAPjYzIBpq9fGgkNOMB8GzLrDxOGfymrVuS5lj7
        iZReyKruuZobZNQkaVMSTz8=
X-Google-Smtp-Source: AIpwx4+2JYRpGvNP96L4B6Xt+5YP8EzVi9iO0tQgK957fNEOKvEBraUEdPWjaRPS6aNuFYkOIAybbg==
X-Received: by 10.28.197.205 with SMTP id v196mr2922904wmf.37.1524089708170;
        Wed, 18 Apr 2018 15:15:08 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id e10-v6sm3876267wri.23.2018.04.18.15.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 15:15:07 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff\@peff.net" <peff@peff.net>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 6/9] commit: use generation numbers for in_merge_bases()
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-7-dstolee@microsoft.com>
Date:   Thu, 19 Apr 2018 00:15:06 +0200
In-Reply-To: <20180417170001.138464-7-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:30 +0000")
Message-ID: <86k1t4go0l.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The containment algorithm for 'git branch --contains' is different
> from that for 'git tag --contains' in that it uses is_descendant_of()
> instead of contains_tag_algo(). The expensive portion of the branch
> algorithm is computing merge bases.
>
> When a commit-graph file exists with generation numbers computed,
> we can avoid this merge-base calculation when the target commit has
> a larger generation number than the target commits.

You have "target" twice in above paragraph; one of those should probably
be something else.

>
> Performance tests were run on a copy of the Linux repository where
> HEAD is contained in v4.13 but no earlier tag. Also, all tags were
> copied to branches and 'git branch --contains' was tested:
>
> Before: 60.0s
> After:   0.4s
> Rel %: -99.3%

Nice...

>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

...especially for so small changes.

>
> diff --git a/commit.c b/commit.c
> index a44899c733..bceb79c419 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1053,12 +1053,19 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>  {
>  	struct commit_list *bases;
>  	int ret = 0, i;
> +	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
>  
>  	if (parse_commit(commit))
>  		return ret;
> -	for (i = 0; i < nr_reference; i++)
> +	for (i = 0; i < nr_reference; i++) {
>  		if (parse_commit(reference[i]))
>  			return ret;
> +		if (min_generation > reference[i]->generation)
> +			min_generation = reference[i]->generation;
> +	}
> +
> +	if (commit->generation > min_generation)
> +		return 0;

Why not use "return ret;" instead of "return 0;", like the rest of the
code [cryptically] does, that is:

  +	if (commit->generation > min_generation)
  +		return ret;

>  
>  	bases = paint_down_to_common(commit, nr_reference, reference);
>  	if (commit->object.flags & PARENT2)

Otherwise, it looks good to me.
