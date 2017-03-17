Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440A520951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdCQTSS (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:18:18 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34841 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdCQTSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:18:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id b129so47693440pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoKuJYuyN7HNo087VSE/bFq8osH7IB2mcGfnt1VwzM0=;
        b=vqwCZSoA7nCdFA0JUm9C+t4uyFUQWczCyMQvJkdWnhg4WUHxCWdr9XAnf1JfsklOCI
         kvI3udtd2Q8+lNfYp7ySYHz2FI+dkeHgAP8Td1CoXix9CazKMk+CAoIzXOqA1YG/ZLLk
         5ffm0MDJbXtAYiantCF7RUApy/pny7G13v7W2TJq8EQDBj7UHia/qmY8FJoSHHUuO64A
         jTcXIwZOxtKujqafYjbESetcr4De+QjDSZ+tnG0vWGk0D8cGpF/YqAUpDQO1FmT9rPUS
         8W4II9fz2O3IDs4L/Zzso8iyRjIHVaLRxcR+jG4HYvXr/363sIUAk1EP7vwyxu2/bT2V
         Lspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoKuJYuyN7HNo087VSE/bFq8osH7IB2mcGfnt1VwzM0=;
        b=kHdp8pJYmnJjeyud/9gcYTHubicS0+W+9aw/sdPqBYNI0XlHwM3zf06eFU00tA6yMw
         0YeVl/fVuHTFP47nfARI5QMEWlCXya5Wu18ax/2y+dcVRBMrnLmcFqHy6jShFpuUH+Y4
         1kvrL95WGESY/xlXWrpbjEevgRthwhRxrehG29qXRl9tEFvT/1u/3+rrsl/flc+uawqf
         A0d2y/PNZuKe9TUW8uVTmprV9vVaBSIR8+hSPpmfa4EJdMg7hrwnpgg7aiF8kIKI19EB
         +aC5Mldvl5kVPc/1+wr5nYvbRGJeM9izCqZIc7UR/q4hfwfadWZXCox9Ywkldrw7EAOk
         njCw==
X-Gm-Message-State: AFeK/H2wQt410G7KVA9HsBweD8SoTKF1UPIf9I7UXJrcdD8/1GCA3MMiiS6UBfpj7k4+dfIK
X-Received: by 10.84.213.130 with SMTP id g2mr6564961pli.53.1489778241300;
        Fri, 17 Mar 2017 12:17:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id n189sm18279933pfn.108.2017.03.17.12.17.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 12:17:20 -0700 (PDT)
Date:   Fri, 17 Mar 2017 12:17:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git
 commands
Message-ID: <20170317191719.GD110341@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com>
 <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
 <20170317190856.GC110341@google.com>
 <CAGZ79kaTNVZBZg5jiVzAKdu96pENcRJmvZ1WR37TP2MXLR-nUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaTNVZBZg5jiVzAKdu96pENcRJmvZ1WR37TP2MXLR-nUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Stefan Beller wrote:
> On Fri, Mar 17, 2017 at 12:08 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 03/17, Stefan Beller wrote:
> >> >         prefix = setup_git_directory_gently_1(nongit_ok);
> >> > +       env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
> >> > +
> >> > +       if (env_prefix)
> >> > +               prefix = env_prefix;
> >> > +
> >> >         if (prefix)
> >> >                 setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
> >>
> >> so we load that GIT_TOPLEVEL_PREFIX_ENVIRONMENT prefix
> >> first, such that we essentially copy it into GIT_PREFIX_ENVIRONMENT,
> >> such that e.g. aliased commands will know about the superprefix, too.
> >
> > I don't follow, this doesn't have anything to do with super-prefix.
> >
> 
> s/superprefix/prefix as passed in via GIT_TOPLEVEL_PREFIX_ENVIRONMENT/
> 
> sorry for the confusion.

Alternatively we could not copy it into GIT_PREFIX_ENVIRONMENT.

-- 
Brandon Williams
