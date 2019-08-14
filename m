Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5031F45C
	for <e@80x24.org>; Wed, 14 Aug 2019 08:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHNIcv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 04:32:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39560 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfHNIcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 04:32:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so20140376wra.6
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zy7kIjV1K+V6tzEdnM2gbbwKMO0mvi/OOmvsCYBz8k4=;
        b=gSCgs09tHL53xDgx68l9rPuyi3XLOCG4hz2LekYBD2UrfjwqWxnNDg3AizbearA+NG
         MjHOrWOI2TBbDtXyO11UmTwjFumyH78m7pO8fFdtpDaBFl20JTYcW2e+HWjhOcoyfQMx
         Omid7EeFt6rjO8QzZ9xSGtJ0/BV9VdOcXy+NDdj4dkYRaaFqNEzQTLSWmB9e4nSnfd7L
         VQcbw5qAjOOaTd8BG7mYNrBNMW2YbaE4TBwviEU/h58mpgqPupIlAw2izul+uV8IHtTr
         /+AmFQ5hKWbPKY2c2WQX049jtUxevsrR8WwbFD2+ATKGe1iJBJUeNMtTs1YMIv8kTTaA
         aysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zy7kIjV1K+V6tzEdnM2gbbwKMO0mvi/OOmvsCYBz8k4=;
        b=AnLMvZDKagDP/xniyoMqbJaicwVELCdbPfcO3o//i6LH+ytucozYPOFXGLEtmkJEuy
         TRgGJukrCNlS0/o+Gju19ojl2CIyRKum26eobAYTpHs+nI92UYHFLsDIGLk+KPeXWrW9
         1Kaa6iaeIdFpCWMVZPV0KmmQ0uINI0ETYodyYL0GuOCyGhBqE/U+yD2oiA1Be6RXCxGt
         g50vvSTRZuM1bxIo4+GJoUGPfKsrtQ9HrhSyzwZcQuiVQ4anj8mkL/u2oBivf2MO8F8M
         j9iXTS/b8S1bks79v2l4HU4hJYX8s5iVbk+ak90++mlZDhXpMEkkp719jXqdYt7n912R
         qZZA==
X-Gm-Message-State: APjAAAXj+RjzINJmZAVhcxLVjwgQJWTKu2pmFs+zf2SGjVJaFdQ0tLA2
        eFVoIG4023xrEPDFOHU7OmLpqfCaIPg=
X-Google-Smtp-Source: APXvYqyecqhV/AC+jB1ox9OEXnv07f8SUGJOLSXH2DhCAB9aPKXA6VOim9xMdKoMsIl//okCdcvAow==
X-Received: by 2002:adf:f008:: with SMTP id j8mr36207491wro.129.1565771569116;
        Wed, 14 Aug 2019 01:32:49 -0700 (PDT)
Received: from szeder.dev (x4db5324e.dyn.telefonica.de. [77.181.50.78])
        by smtp.gmail.com with ESMTPSA id l14sm16156459wrn.42.2019.08.14.01.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 01:32:48 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:32:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, gitster@pobox.com,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
Message-ID: <20190814083245.GP20404@szeder.dev>
References: <20190812213448.2649-1-palmer@sifive.com>
 <20190812213448.2649-6-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812213448.2649-6-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 02:34:48PM -0700, Palmer Dabbelt wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 67d001f3f78b..41498e9efb3b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -114,6 +114,20 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  	return git_default_config(k, v, cb);
>  }
>  
> +static int parse_jobs_arg(const struct option *opt, const char *arg, int unset)
> +{
> +	int jobs;
> +
> +	jobs = atoi(arg);
> +	if (jobs < 1)
> +		die(_("There must be a positive number of jobs"));
> +
> +	max_children_for_submodules = jobs;
> +	max_children_for_fetch = jobs;
> +
> +	return 0;
> +}
> +
>  static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);
> @@ -142,12 +156,13 @@ static struct option builtin_fetch_options[] = {
>  		    N_("fetch all tags and associated objects"), TAGS_SET),
>  	OPT_SET_INT('n', NULL, &tags,
>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
> -	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
> +	{ OPTION_CALLBACK, 'j', "jobs", NULL, N_("jobs"),
> +		    N_("number of parallel tasks to run while fetching"),
> +		    PARSE_OPT_OPTARG, &parse_jobs_arg },

These changes result segmentation faults in the tests '--quiet
propagates to parallel submodules' and 'fetching submodules respects
parallel settings' in 't5526-fetch-submodules.sh'.

If the number of jobs is specified as '-j 2' or '--jobs 7', i.e. as an
unstuck argument of the option, as opposed to '-j2' or '--jobs=7',
then 'arg' in the parse_jobs_arg() callback is NULL, which then causes
the segfault somewhere inside that atoi() call.


