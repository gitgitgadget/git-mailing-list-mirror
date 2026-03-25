Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B6256C70
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422164; cv=none; b=oRrC5tB5kPzlPYFypHHdRrEpJRKr2B7jIPD2InlpiyWlAkRlrjrvQSUIf1ivpyRNkwiUipv5oHfHcTgF9ffmJrBrursrHD8+wVUG3t6zeCnT8sGEoYv8Pp0gldoZJwyeWDvqUdqiegzQbfOQDVMCZezP/EUgXVicx4FaJzT0Z/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422164; c=relaxed/simple;
	bh=TkNUnM2/vlzkswQC7K1mc7s0++5SapHHnOcOc7xL2xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfKQ3M9R4ch9SFsqpoHnmy9Youu26FmKwgF1B0TIIaQ7Ci21ZrCiohZNP5Hay4pInmZRG02/ALDIIzfFvjNik9P1yAj1jY2lu23Bxhwkust00TlSOibXlO9ct+sW+Q4a3SCNq7XCRGy7eeOEQYk17rjQay7huy9tdbN2bPNCHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhnXT5Wm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhnXT5Wm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486b9675d36so50709445e9.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774422161; x=1775026961; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wPo5xMA2QfrE65XX7ntcQNkzwLvyA7HCqgboMsGdeAE=;
        b=WhnXT5Wmh0CIsSg+/Q7A1F7rIuNPhh+9/+k6F6ESPiFe83qFN4yCCdtCLaoZQJjiEk
         LTpI17SUTH1U3Hzq1VDvQJzNwm2YNvVpYKHZd8Bxp4ndD4IKuwu2n1VJ0Yj40LcRCV7U
         IFpoLKQm9qaOSrnOqwiw/vOaCMucU0KiyXoRt5e/hF649zFdjiCVhMaF7Nrvx+sF9UML
         5/l1+fjpRR0TmsGvTS0AHbDsSLziKDNgDOoEyJcUziKmlBB/yIa5NzM309hVHpN4z0uD
         baqI33Awgvgu3KJvopb0Mkf3fPWlhhrW+o2wMSVw5tC/oF/0Zwl9J752ocf9l+5/topZ
         QEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774422161; x=1775026961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPo5xMA2QfrE65XX7ntcQNkzwLvyA7HCqgboMsGdeAE=;
        b=bpSgaNQTFs9cGGqQk33K5yh976o5Fi/rcZVeXyP0DeGhGLw47LWD4cfvzq3YDigXH3
         6K0Qcfqk+6fbxZO+TJAnbwVqUrep5fVwnrzjS9KOTkvzDiQdWut+1a7YYeg6zQr/Qrth
         CC59qBYfp38tYEPscuRbZgdTKeMGjy+6wK0Tz5vSyv0eJ3xkLKbi6O4CloKSdYIrEVWo
         7Y1/Tq1Iei3r8zrQflcdCtz9NoVEjkU4IXKXtYrjYh8YU8RK1krRoUGgeKQbcxoTIpLc
         SZzqAZAhZRX5jun2r9CINUk/vRvhZI6uTSmyhKPhnBKZf/d27PsC9ugjnRzQ1kESZR3b
         mHmA==
X-Gm-Message-State: AOJu0YxekkvijDIQMWlX+YeeWF7kwX1nSlzJvuT39wjoH42lkUFb6wnE
	m/NXopgc79lyoHiqXk4ArOua5K/VMmLkz81/WWubTv+RxB1W4gE5ZKFg
X-Gm-Gg: ATEYQzxIVa1a+sxrmCePq+FgwVxNJGivLWB/w0ehqhT8JZLrtkbnYMf0Bp0fzX4ZxbH
	dJAe1ayLERFKYXW4V7rMyz5m4+1qaiI2qoTVyoxHAGdSY0vg6Ha6Yg+x+UUT3pDEm/hQuGg9JOq
	3I+wr3I3OWlQJLcumpSKCds9FNdUXPbv9HdhlLaW/6qI2cgRMyYZpdMZnXmiRsO4hiBajGE0sUs
	jrj4oIF9XFM6kA5fzO2DhMVjhETrRVlj9Pc9zsUBtMMTv2O05STYc8hlUu9be2orSolQ3fBmG0O
	XyQ1gJpb2QkB2kFSAGNlAx2i+3c6oTiYUk9lohnshCMEayENzWlbaFrmp7P1n1GhX5rTaiVeM+g
	ScGeDIs/uyssO6wnxOwO8BQIHHqtw5NaBxgqoyy4x6j9j9rhPSAHvNnKHpcBgoumhyIYtCpf0AE
	oDp/Ua+X3WSZhUtEH3rNOTEKGB9Mu7GIorU4QV65egMWrfRxCwIBKL5KBmYKvajP1Xf3zbZKiad
	5vstLgdiuM=
X-Received: by 2002:a05:600c:46c8:b0:485:3d3e:167b with SMTP id 5b1f17b1804b1-48715fc33bcmr32632385e9.5.1774422160945;
        Wed, 25 Mar 2026 00:02:40 -0700 (PDT)
Received: from localhost (20014C4D24C038005C4BF9510B05A899.dsl.pool.telekom.hu. [2001:4c4d:24c0:3800:5c4b:f951:b05:a899])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487165feea6sm27447125e9.2.2026.03.25.00.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:02:40 -0700 (PDT)
Date: Wed, 25 Mar 2026 08:02:38 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com,
	jltobler@gmail.com, ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com, chandrapratap3519@gmail.com,
	gitster@pobox.com, j6t@kdbg.org
Subject: Re: [GSoC PATCH v4 1/3] graph: add --graph-lane-limit option
Message-ID: <acOIjm2KHXvopSQ/@szeder.dev>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-2-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323215935.74486-2-pabloosabaterr@gmail.com>

On Mon, Mar 23, 2026 at 10:59:33PM +0100, Pablo Sabater wrote:
> Repositories that have many active branches at the same time produce
> wide graphs. A lane consists of two columns, the edge and the space
> padding, each branch takes a lane in the graph and there is no way
> to limit how many can be shown.
> 
> Add '--graph-lane-limit=<n>' revision option that caps the number
> of visible lanes to n. This option requires '--graph', without it
> a limit to the graph has no meaning, in this case error out.
> 
> Zero and negative values are valid inputs but silently ignored
> treating them as "no limit", the same as not using the option.
> This follows what '--max-parents' does with negative values.
> 
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  graph.c    | 9 +++++++++
>  revision.c | 6 ++++++
>  revision.h | 1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/graph.c b/graph.c
> index 26f6fbf000..e7c1151ac0 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -317,6 +317,15 @@ struct git_graph {
>  	struct strbuf prefix_buf;
>  };
>  
> +static int graph_needs_truncation(struct git_graph *graph, int lane)
> +{
> +	int max = graph->revs->graph_max_lanes;
> +	/*
> +	 * Ignore values <= 0, meaning no limit.
> +	 */
> +	return max > 0 && lane >= max;
> +}

This patch adds this static function, but it doesn't add any callers.
This breaks the build with DEVELOPER=1:

  $ make DEVELOPER=1 graph.o
      CC graph.o
  graph.c:320:12: error: ‘graph_needs_truncation’ defined but not used [-Werror=unused-function]
    320 | static int graph_needs_truncation(struct git_graph *graph, int lane)
        |            ^~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [Makefile:2923: graph.o] Error 1

>  static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
>  {
>  	struct git_graph *graph = data;
> diff --git a/revision.c b/revision.c
> index 31808e3df0..952edb031e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2605,6 +2605,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--no-graph")) {
>  		graph_clear(revs->graph);
>  		revs->graph = NULL;
> +	} else if (skip_prefix(arg, "--graph-lane-limit=", &optarg)) {
> +		revs->graph_max_lanes = parse_count(optarg);
>  	} else if (!strcmp(arg, "--encode-email-headers")) {
>  		revs->encode_email_headers = 1;
>  	} else if (!strcmp(arg, "--no-encode-email-headers")) {
> @@ -3172,6 +3174,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  
>  	if (revs->no_walk && revs->graph)
>  		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
> +
> +	if (revs->graph_max_lanes > 0 && !revs->graph)
> +		die(_("option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
> +
>  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>  		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
>  
> diff --git a/revision.h b/revision.h
> index 69242ecb18..874ccce625 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -304,6 +304,7 @@ struct rev_info {
>  
>  	/* Display history graph */
>  	struct git_graph *graph;
> +	int graph_max_lanes;
>  
>  	/* special limits */
>  	int skip_count;
> -- 
> 2.43.0
> 
