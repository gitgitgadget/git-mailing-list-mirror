Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045317B4EC
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763814; cv=none; b=QYXxJtwPinyakKf4dXhP6Egzjpg8k3Sl04WIOd9/onIAdaTgUpXelxUc9eVAENeol2MYO3kpK9gSACss+PrPRUFFTDNWw0CBzzBBqsdnG+68NdIr1DNem8jP3tc7M78H0bLhNcIPKH3mjO9H9dHNNOQbuq79Qvhqqh6NePdGJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763814; c=relaxed/simple;
	bh=rhyabXoOSMyNDbWTxvZRpIaFE9HVg1rQORCWi12dNlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ2VTVGbo31j98Pi8GyC4RNtVn/dP2SW12q+DeyN1z9Pi7Ze5zCDzWETVdBM12cvU8TO1ecyJnkk9rd2cUpSnOTPqifLxFmdlGVAl6Li607+EOEf3dW2+IxK+Q1HkUjJyaiTLx/9pSGIR0LNDrnYz5/Bv73O8iMvba141Mkvtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeHUSFgD; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeHUSFgD"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b38896c534so1265053fac.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740763811; x=1741368611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0IwaOY5Z2ZakE/VTw2uSEoqqX36eUmqqfNpPNDpc8o=;
        b=UeHUSFgDDrule5GJmrBS87HT9ncPvxE3eYb+bLWNWA5yYs9Eis3wY3ic/sYcgxqjq7
         4j0BcmyqNm+MkoQO8cRw7ohiIwZq3VzoHQ06taU6GWPy/HP3IEiFwmXUQSNJ98+nV7rO
         NjMEr6FRS/gAW3UVDY3KS7JPOLToj2hxjr3mBdHjLL/93zjq9XGAXN4EjYcWQmZDTGLn
         WmXoxpMNZUPeP8EtnVlrDsppl6+pB6cD93Dsxfaoe73lFceqlvEiqkl1OpJgJ0nYQHJu
         LKsrzCV1y3jTap4HEsDcmFgwvqAuiF4Yf4kSbsBlUazsz6XlvVBj9a54D+1AtX9oGuQd
         SEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740763811; x=1741368611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0IwaOY5Z2ZakE/VTw2uSEoqqX36eUmqqfNpPNDpc8o=;
        b=GBgE+q7+1qQNKTMTXg8+vMKwSKkSQZWckW9R/+LbyGsJpxGUzvdPT2vzktySio0ID4
         J054HFTpZ+3iesrsmoAxL6strOcaOVGmvZPIGI8w4/guoHQce2nM3a/kWBt7x4I4tp98
         I0PugIqW7JPNSvOIL/1g37UL+cXWvNWjSSgG/uAXaF8IBld+ogFZ7U8VWWWdai8Krj9e
         kynBxSapGnEvbt43IFIXUQCinA3Ia3n/no0ucCEdeSIaifm02y87MfHoXk9ltgTvSaZr
         imUt2vxY/8bCOjkWfcTeLO3ZvSZsO/eWHxgOve+XDMzWdxPBQ+j9lmptSTDgGAUOzw6+
         GoNg==
X-Gm-Message-State: AOJu0YwjjiLOXGjXT1RoGI2l+ubh721EStKSVAvAsYLlStLV9iLbyutb
	vbCJSjaq4FfnnWtp7zIPuQqn7kgZKwR6HUuXk2Lqqy36XYp0OUHzK2JuDqkc
X-Gm-Gg: ASbGncti0LR2gDQHsqAobGRmNGbHRiE4ByzuJ4w0R0XSVj/yHlqM+u0n00nnBoXTr90
	0SKszLVQWwVCuALXft6kclFlAhEkTArmQIJOKg1IzCFTQ/z4OzmVVQ/niOWrVie30bd6QS/4Ng7
	o4TfTDta1+cM/12rGQrYhmODyX9pRlE7uMI0tcE30O4MFNLad+NZm1Xsi3ogs9R/IUD0Nh1SZay
	G+Mh/ByEsAFyGDzq3jXZqPKCtyxF4fcZpBvpANqTklzUSxa9LDvgmiuZFuLhg2YbE9gSKa9qg0J
	bezs527PA7Ad19u311I=
X-Google-Smtp-Source: AGHT+IEHTECXLZRDcOIcri04eqhd7jOdHdSHcPknD4NaviHJgwd6wNUDfZDggbYLJVE2mhsk1Ry1DA==
X-Received: by 2002:a05:6870:8090:b0:2a3:dca5:cae8 with SMTP id 586e51a60fabf-2c17866dc1amr2762329fac.34.1740763811415;
        Fri, 28 Feb 2025 09:30:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c15c19bbe9sm788293fac.21.2025.02.28.09.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:30:10 -0800 (PST)
Date: Fri, 28 Feb 2025 11:26:54 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood123@gmail.com, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/4] builtin: introduce diff-pairs command
Message-ID: <yb3d32awwgdv4yp2ma6udqn5w46stemptje2ykdkgwfeqxrwac@zn7ifcssc36u>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228002604.3859939-4-jltobler@gmail.com>
 <Z8Fz7CQimWgzrvz7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Fz7CQimWgzrvz7@pks.im>

On 25/02/28 09:29AM, Patrick Steinhardt wrote:
> On Thu, Feb 27, 2025 at 06:26:03PM -0600, Justin Tobler wrote:
> > diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> > new file mode 100644
> > index 0000000000..5a993b7c9d
> > --- /dev/null
> > +++ b/builtin/diff-pairs.c
> [snip]
> > +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> > +		   struct repository *repo)
> > +{
> > +	struct strbuf path_dst = STRBUF_INIT;
> > +	struct strbuf path = STRBUF_INIT;
> > +	struct strbuf meta = STRBUF_INIT;
> > +	struct option *parseopts;
> > +	struct rev_info revs;
> > +	int line_term = '\0';
> > +	int ret;
> > +
> > +	const char * const usagestr[] = {
> > +		N_("git diff-pairs -z [<diff-options>]"),
> > +		NULL
> > +	};
> 
> We tend to call these `builtin_*_usage`, so in your case it would be
> `builtin_diff_pairs_usage`.

Good to know, will adapt in a followup version.

> 
> > +	struct option options[] = {
> > +		OPT_END()
> > +	};
> > +
> > +	repo_init_revisions(repo, &revs, prefix);
> > +
> > +	/*
> > +	 * Diff options are usually parsed implicitly as part of
> > +	 * setup_revisions(). Explicitly handle parsing to ensure options are
> > +	 * printed in the usage message.
> > +	 */
> > +	parseopts = add_diff_options(options, &revs.diffopt);
> > +	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
> > +
> > +	repo_config(repo, git_diff_basic_config, NULL);
> > +	revs.disable_stdin = 1;
> > +	revs.abbrev = 0;
> > +	revs.diff = 1;
> > +
> > +	argc = parse_options(argc, argv, prefix, parseopts, usagestr,
> > +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
> > +			     PARSE_OPT_KEEP_DASHDASH |
> > +			     PARSE_OPT_KEEP_ARGV0);
> > 
> > +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> > +		usagef(_("unrecognized argument: %s"), argv[0]);
> 
> Okay, we now use `parse_options()` to parse stuff for us, and
> `setup_revisions()` only really does the setup for us as we know that
> all relevant diff options should've already been parsed for us. This
> looks much nicer to me.
> 
> I wonder though: we keep unknown options when calling `parse_options()`
> and then end up passing them to `setup_revisions()`. But are there even
> any options handled by `setup_revisions()` that would make sense in our
> context? And if not, shouldn't we rather make `parse_options()` die in
> case it sees unknown options?

Good catch, there should not be any actaully needed options left for
`setup_revisions()` to parse as they should all be handled by
`parse_options()`. I'll remove the `PARSE_OPT_KEEP_UNKNOWN_OPT` flag.

> If there are, we should probably document this because it isn't obvious
> to me.
> 
> > diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> > new file mode 100755
> > index 0000000000..8f17e55c7d
> > --- /dev/null
> > +++ b/t/t4070-diff-pairs.sh
> > @@ -0,0 +1,81 @@
> > +#!/bin/sh
> > +
> > +test_description='basic diff-pairs tests'
> > +. ./test-lib.sh
> > +
> > +# This creates a diff with added, modified, deleted, renamed, copied, and
> > +# typechange entries. This includes a submodule to test submodule diff support.
> > +test_expect_success 'setup' '
> > +	test_config_global protocol.file.allow always &&
> > +	test_create_repo sub &&
> 
> Use of `test_create_repo ()` is deprecated, as it is merely a wrapper
> around git-init(1).

Good to know! I'll swap to using git-init(1) instead.

Thanks
-Justin
