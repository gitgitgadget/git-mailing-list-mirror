Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10E41F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfHPVT2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 17:19:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39078 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfHPVT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 17:19:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so2776552wra.6
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+13mf2sok0KDcW/LuUEilBv8gS4pXq/CIuWdKxur9c=;
        b=VxfQad0ScEKpwEtROmou01UWas8IZWS2Ghw7uGQ/AU78xneeafPqCExEN+yXrhmWqC
         7VTZkUSrQiDPIXSMXq6U/5EnaJQ9IX5PzUALpQj9obtGXA7f/YStPrD/gQoMl8NAoCCo
         KNBYNUoqHat30w3j7wkq8Bv9iHiI5m7aKwDOfcyR7KlgoZx073ntNWDlTriWWguq377p
         P+H4wEeJ9kMb59sm+Z/uYhuJhhKz4w0kjRJuw9dII3kJaASjC9gQa8sWIBMSabucUkaF
         zU0NbLD/9qhuhSrc9/U7cbvH8WPW7MJFabcIC+nVSYHxK997IlhX5Ue6Q6BIicFgyUkS
         3QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+13mf2sok0KDcW/LuUEilBv8gS4pXq/CIuWdKxur9c=;
        b=PObB785H9bD4hw86cvlt4R9NcCsPw2lTvk398tmafS9LH/0lActfjtH4lZJP6fajQp
         ttWLP5rfZbky/Wxu4tHwBkcx4fl0uylb9tTrEI+QDp2Bkhthc1Iq2gTGdLB5NusSI/qP
         vPLCjHQzwPDOCLlvg+qeNJUBXchSK5OpcHEoEnLu7aLourZpF56bArgOpslJriS2V1S0
         viv0WcXNbil4rHVQg7GFX7bUf1ZCiCa21xwDiThHI96eyIxGHyeTtlCLxySB0TnXJb2+
         A+h6w+ldICXAajPUV5LjmtRrpCZuUBSM1kPugZIf6EnMMnqDP0rWocoWP3HaV5AMVW5g
         ymMw==
X-Gm-Message-State: APjAAAVk7BUYR8Ny2xJsAdFddlFJlDYa25Q2ce9L4HreQMgHXbkw5sT4
        AOtJGd3M/yNf0K0waphu3RY=
X-Google-Smtp-Source: APXvYqz8XpcdEDE/SgVuUo+1jp3S0nUrLpUWFP4uGH1M2eXZRunNW8ukojkoNcBYnKWpM6WhX3aPJA==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr12361268wrs.200.1565990366379;
        Fri, 16 Aug 2019 14:19:26 -0700 (PDT)
Received: from szeder.dev (x4db61324.dyn.telefonica.de. [77.182.19.36])
        by smtp.gmail.com with ESMTPSA id r11sm5336926wrt.84.2019.08.16.14.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:19:25 -0700 (PDT)
Date:   Fri, 16 Aug 2019 23:19:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 21/24] merge-recursive: split internal fields into a
 separate struct
Message-ID: <20190816211922.GS20404@szeder.dev>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-22-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190815214053.16594-22-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 02:40:50PM -0700, Elijah Newren wrote:
> diff --git a/merge-recursive.c b/merge-recursive.c

>  static void merge_finalize(struct merge_options *opt)
>  {
>  	flush_output(opt);
> -	if (!opt->call_depth && opt->buffer_output < 2)
> +	if (!opt->priv->call_depth && opt->buffer_output < 2)
>  		strbuf_release(&opt->obuf);
>  	if (show(opt, 2))
>  		diff_warn_rename_limit("merge.renamelimit",
> -				       opt->needed_rename_limit, 0);
> +				       opt->priv->needed_rename_limit, 0);
> +	free(opt->priv);
> +	opt->priv = NULL;

Coccinelle suggests FREE_AND_NULL(opt->priv) here.

