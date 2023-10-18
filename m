Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316113F4A6
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gTuF5R8e"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4A0B0
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:46:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777719639adso141549185a.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697651218; x=1698256018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZOnq1g6muGH7HkDkI1fAcoWF7+cif8pIoO2Ixm8ZiY=;
        b=gTuF5R8e3LEW0WMfkcH7oXX9vfD2D/cH3fJtkr2T8O7UokjFcIprxlVQOIVqeoTNGD
         GaoO86de4qJpd7cwYXeTTfTwFmBTiWkbffMuPhL0WaExYGkHx79kNhyEDhcexpbmsELn
         J1ib4PToCqE5EpUtdf2UJ+YH5OfMzLGQ92/FeQYU5Yw3pdyeGMOwIrfNo6CCjG8CamtS
         PtrzlcIro0ytQAk159sGGh6nyMFS3fnhtqvwaKbP3tTOV2noF+3u/YU86zfbjm1xT0pS
         Yccv9n0xTafs4lmtQh6hiwKnp07TjcoWsj/c6sM0Iih73xUe2WNE4kQSAF+gEHixeKkI
         rf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651218; x=1698256018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZOnq1g6muGH7HkDkI1fAcoWF7+cif8pIoO2Ixm8ZiY=;
        b=m0hnYcwmnNif+0ip2ngsnQP2EOkpdDEQUFpBMpSiZ8WW68k4Uu3KQmFGfuSvQ5l52H
         pzHe2bIa2AYSz9s66AFgtVm3LIZhbsBCuhdkuxdFi2kMUmuQNB2TxOrV7oOxCAzY8wcT
         2AwEvvzKyudRcM7Ge7y6KwPDFhnzJtrBqJATauZyY02ZenYXrx2r9qZdRbkiEuGk6ner
         yGfmMig9zzs1wWpDQMRrEiSTW+/NF9M/SzQwbltPEvDX5hVK88pLwdq20tlyyhna8uob
         E+KZIsXZF0nbY6x+KuytOJXwtfalzEa+XKPxPg8D6AiVoUYbAsagxjtJWueOsCPbHGWW
         t7bw==
X-Gm-Message-State: AOJu0YzjDXsSd2xFK4pOiv0a+s2TmZeooQ6cVNY2p6p1P7BF+80g2ucC
	3h46DWLB8nFWoW/7n3NTNn10BQ==
X-Google-Smtp-Source: AGHT+IGrGY9DtuZjnvkVOeA3dD8MOCQ62b3+XfySRRYuJE/ScA7ibCZj9/e4w5y+N99t4q8Ne37Y8w==
X-Received: by 2002:a05:620a:178f:b0:76c:99e3:ba76 with SMTP id ay15-20020a05620a178f00b0076c99e3ba76mr6834943qkb.26.1697651218593;
        Wed, 18 Oct 2023 10:46:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vr4-20020a05620a55a400b0076f19b9e96fsm120206qkn.107.2023.10.18.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:46:58 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:46:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 10/17] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZTAaEffz2MkkTjzD@nand.local>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <61d44519a5ffaf2c040198cf8d80d05a09de5de5.1696969994.git.me@ttaylorr.com>
 <ZS5JpJCw-MY256xo@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZS5JpJCw-MY256xo@tanuki>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:45:24AM +0200, Patrick Steinhardt wrote:
> > @@ -314,17 +314,26 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
> >  	return 0;
> >  }
> >
> > +struct graph_read_bloom_data_context {
> > +	struct commit_graph *g;
> > +	int *commit_graph_changed_paths_version;
> > +};
> > +
> >  static int graph_read_bloom_data(const unsigned char *chunk_start,
> >  				  size_t chunk_size, void *data)
> >  {
> > -	struct commit_graph *g = data;
> > +	struct graph_read_bloom_data_context *c = data;
> > +	struct commit_graph *g = c->g;
> >  	uint32_t hash_version;
> > -	g->chunk_bloom_data = chunk_start;
> >  	hash_version = get_be32(chunk_start);
> >
> > -	if (hash_version != 1)
> > +	if (*c->commit_graph_changed_paths_version == -1) {
> > +		*c->commit_graph_changed_paths_version = hash_version;
> > +	} else if (hash_version != *c->commit_graph_changed_paths_version) {
> >  		return 0;
> > +	}
>
> In case we have `c->commit_graph_changed_paths_version == -1` we lose
> the check that the hash version is something that we know and support,
> don't we? And while we do start to handle `-1` in the writing path, I
> think we don't in the reading path unless I missed something.

We don't have to deal with c->commit_graph_changed_paths_version being
-1 here, since we normalize it when reading the BDAT chunk. See
commit-graph.c::graph_read_bloom_data(), particularly:

    if (*c->commit_graph_changed_paths_version == -1)
        *c->commit_graph_changed_paths_version = hash_version;
    else if (hash_version != *c->commit_graph_changed_paths_version)
        return 0;

> > +test_expect_success 'when writing commit graph, do not reuse changed-path of another version' '
> > +	git init doublewrite &&
> > +	test_commit -C doublewrite c "$CENT" &&
> > +	git -C doublewrite config --add commitgraph.changedPathsVersion 1 &&
> > +	git -C doublewrite commit-graph write --reachable --changed-paths &&
> > +	git -C doublewrite config --add commitgraph.changedPathsVersion 2 &&
> > +	git -C doublewrite commit-graph write --reachable --changed-paths &&
> > +	(
> > +		cd doublewrite &&
> > +		echo "c01f" >expect &&
> > +		get_first_changed_path_filter >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
> > +
>
> With the supposedly missing check in mind, should we also add tests for
> currently unknown versions like 3 or -2?

Good idea, I'll update the test to reflect.

Thanks,
Taylor
